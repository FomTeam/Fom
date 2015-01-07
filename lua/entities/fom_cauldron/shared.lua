/***
	Main attribute of alchemy

	Coded and managed by Trojan
***/

--[[

	Realism improvements and bugfixes by [G - P.R.O]EgrOnWire

]]--

/*** Main variables ***/
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.Spawnable = false
/*** Main variables END ***/

if CLIENT then _addMagicEntity("Cauldron", "fom_cauldron") end

//Liquid
ENT.liquid_amount = 0
ENT.liquid_state = ""
ENT.liquid_color = Color(0, 0, 0)
ENT.liquid_curcolor = Color(0, 0, 0)

//Heat
ENT.heat_max = 800
ENT.heat_combustion_point = 310
ENT.heat_brewing_point = 100
ENT.heat_hurt_point = 65
ENT.heat_amount = 0
ENT.heat_process = false

//Ingredients
ENT.brew_ingredients = {}

//Misc
ENT.bubble_process = false
ENT.points = ""


if CLIENT then
	surface.CreateFont("fom_font1", {
		font = "Arial", 
		size = 4000, 
		weight = 0, 
		blursize = 0, 
		scanlines = 0, 
		antialias = true, 
		underline = false, 
		italic = false, 
		strikeout = false, 
		symbol = false, 
		rotary = false, 
		shadow = false, 
		additive = false, 
		outline = false, 
	})
	
	usermessage.Hook("fom_client_notify", function(data)
		local b = data:ReadBool()
		local n = data:ReadFloat()
		local name = data:ReadString()
		local ent = data:ReadEntity()
		
		ent.client_time_toready = n
		ent.client_notify = b
		ent.client_potion_name = name
	end)

	usermessage.Hook("fom_changed_ingredients", function(data)
		local str = data:ReadString()
		local ent = data:ReadEntity()
		
		ent.brew_ingredients_client = str
	end)
end

function ENT:GetIngredientsStr()
	if CLIENT then return end

	local str = ""
	
	for k, v in pairs(self.brew_ingredients) do
		if IsValid(v) and fom_GetIngredient(v) then
			str = str .. fom_GetIngredient(v) .. " "
		end
	end
	
	return str
end

function ENT:SendIngredientsToClient()
	umsg.Start("fom_changed_ingredients")
		umsg.String(self:GetIngredientsStr())
		umsg.Entity(self)
	umsg.End()
	
	return true
end

function ENT:RemoveIngredient(v)
	if CLIENT then return end
	if not table.HasValue(self.brew_ingredients, v) then return end
	
	table.RemoveByValue(self.brew_ingredients, v)
	self:SendIngredientsToClient()
	
	if fom_potions_manager.GetPotionByRecipe(string.Left(self:GetIngredientsStr(), string.len(self:GetIngredientsStr()) - 1)) then
		self:StartMakingPotion(fom_potions_manager.GetPotionByRecipe(string.Left(self:GetIngredientsStr(), string.len(self:GetIngredientsStr()) - 1)))
	else
		self:StopMakingPotion()
	end
	
	return v
end

function ENT:SetUpIngredient(v)
	if CLIENT then return end
	table.insert(self.brew_ingredients, v)
	self:SendIngredientsToClient()
	
	if fom_potions_manager.GetPotionByRecipe(string.Left(self:GetIngredientsStr(), string.len(self:GetIngredientsStr()) - 1)) then
		self:StartMakingPotion(fom_potions_manager.GetPotionByRecipe(string.Left(self:GetIngredientsStr(), string.len(self:GetIngredientsStr()) - 1)))
	else
		self:StopMakingPotion()
	end
	
	return v
end

function ENT:ClientNotify(b, t, s)
	umsg.Start("fom_client_notify")
		umsg.Bool(b)
		umsg.Float(t)
		umsg.String(s)
		umsg.Entity(self)
	umsg.End()
	
	return true
end

function ENT:StartMakingPotion(potion)
	if CLIENT then return end
	
	if self.liquid_state == "water" then
		//if you want to change making time via some shit use POTION_MAKING_TIME
		local const_int = self.POTION_MAKING_TIME
		if not const_int then const_int = 0 end
		const_int = potion.time - const_int
		if const_int <= 0 then const_int = 1 end
			
		self:ClientNotify(true, const_int, potion.name)
			
		timer.Create("fom_make_potion" .. self:EntIndex(), const_int, 1, function()
			if self and IsValid(self) then 
				self.liquid_state = potion
				self.liquid_color = Color(potion.color.r, potion.color.g, potion.color.b, 10)
				for k, v in pairs(self.brew_ingredients) do if IsValid(v) then v:Remove() end end
					
				self:ClientNotify(false, 0, "")
			end
		end)
			
		timer.Create("fom_make_potion_eff" .. self:EntIndex(), 1, const_int, function()
			if self and IsValid(self) then 
				local ef = EffectData()
				ef:SetOrigin(self:GetPos() + Vector(0, 0, 42))
				ef:SetMagnitude(0.2)
				ef:SetStart(Vector(255, 255, 255))
				util.Effect("fom_effect_boom", ef)
			end
		end)
	end
	
	return potion
end

function ENT:StopMakingPotion()
	if CLIENT then return end
	
	self:ClientNotify(false, 0, "")
	timer.Destroy("fom_make_potion" .. self:EntIndex())
	timer.Destroy("fom_make_potion_eff" .. self:EntIndex())
	
	return true
end

--[[Added REALISTIC heat processing. NO INSTAHEAT TO 800 degrees!]]--
--[[Heating: 1 deg in 0.5 sec. Cooling: 1 deg in 10 sec. Also can cool in water (faster than in air)]]--
function ENT:ProcessHeat()
	if not self.heat_process then
		self.heat_process = true
		//Getting fire source
		timer.Create( "fom_process_heat", 0.4, 1, function()
			if IsValid(self) then
				for k, v in pairs(ents.FindInSphere(self:GetPos(), 20)) do
					if (v:IsOnFire() or v:GetClass() == "fom_bonfire") and self.heat_amount < self.heat_max then
						self.heat_amount = math.Approach(self.heat_amount, self.heat_max, 1)
					elseif self:WaterLevel() >= 3 then --[[Cauldron in the water]]--
						self.heat_amount = math.Approach(self.heat_amount, fom_runes_manager.outdoor_temp, 25)
					elseif self.heat_amount > fom_runes_manager.outdoor_temp then
						self.heat_amount = math.Approach(self.heat_amount, fom_runes_manager.outdoor_temp, 0.1) --[[Air cooling, no water]]--
					end
				end
				self.heat_process = false
			end
		end)
	end
	
	return true
end

//Making bubbles
function ENT:MakeBubbles()
	if not self.bubble_process then
		self.bubble_process = true
		
		timer.Create("fom_make_bubbles", 0.5, 1, function()
			if self and IsValid(self) then
				local e = math.random(1,3)
				for k = 0, e do
					local vec = VectorRand()
					vec.z = 0
				
					local ef = EffectData()
					ef:SetOrigin(self:LocalToWorld(Vector(0, 0, 42)) + vec * math.random(10, 15))
					util.Effect("effect_bowling", ef)
				end
				
				self.bubble_process = false
			end
		end)
	end
	
	return true
end

function ENT:Initialize()
	if CLIENT then
		self.points = ""
		return 
	end

	self:SetModel("models/fom/cauldron/cauldron.mdl")
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	
	self.liquid_amount = 0
	self.liquid_state = nil
	self.heat_max = 800
	self.heat_combustion_point = 310
	self.heat_brewing_point = 80
	self.heat_hurt_point = 65
	self.heat_amount = fom_runes_manager.outdoor_temp --[[Outdoor temperature from magicmanager]]--
	self.heat_process = false
	self.brew_ingredients = {}
	
	self.liquid = ents.Create("prop_physics")
	self.liquid:SetModel("models/hunter/tubes/circle2x2.mdl")
	self.liquid:Spawn()
	self.liquid:SetPos(self:LocalToWorld(Vector(0, 0, 42)))
	self.liquid:SetMaterial("models/debug/debugwhite")
	self.liquid:SetColor(Color(0, 190, 255, 10)) // 0 190 255 10 blue color	
	self.liquid:SetRenderMode(RENDERMODE_TRANSALPHA)
	self.liquid:DrawShadow(false)
	self.liquid:SetParent(self)
	self.liquid:SetSolid(SOLID_NONE)
	self.liquid_curcolor = self.liquid:GetColor()
	
	self.bubble_process = false
end

function ENT:OnRemove()
	if SERVER and self.liquid and IsValid(self.liquid) then self.liquid:Remove() end
end

function ENT:Draw()
	if SERVER then return end
	
	self:DrawModel()
	
	if not self.change_time and self.client_time_toready then
		self.change_time = true
	
		timer.Create("fom_ch_time" .. self:EntIndex(), 1, 1, function()
			if IsValid(self) then
				self.client_time_toready = math.Approach(self.client_time_toready, 0, 1)
				
				self.change_time = false
			end
		end)
	end
	
	
	if not self.make_points then
		self.make_points = true
	
		timer.Create("fom_make_points" .. self:EntIndex(), 0.4, 1, function()
			if IsValid(self) then
				if self.points != "...." then self.points = self.points .. "." else self.points = "." end
				
				self.make_points = false
			end
		end)
	end

	
	local angle = (self:GetPos() - LocalPlayer():GetPos()):Angle().y - 90
	local name = self.client_potion_name
	if not name then name = "" end
	cam.Start3D2D(self:LocalToWorld(Vector(0, 0, 65)), Angle(0, angle, 90), 0.06)
		if self.brew_ingredients_client and self.brew_ingredients_client != "" then draw.DrawText("Ingredients: " .. self.brew_ingredients_client, "fom_font1", 0, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER) end
		if self.client_time_toready and self.points and self.client_notify then
			draw.DrawText("Making " .. string.lower(name) .. " " .. self.client_time_toready .. self.points, "fom_font1", 0, -280, Color(255, 255, 255), TEXT_ALIGN_CENTER)
		end
		if self:GetNWFloat("fom_heat_amount") then
			draw.DrawText("t " .. math.Round(self:GetNWFloat("fom_heat_amount")) .. "°C", "fom_font1", 0, -140, Color(255, 255, 255), TEXT_ALIGN_CENTER)
		end
	cam.End3D2D()
	
	return true
end

function ENT:Think()
	if CLIENT then return end
	
	//Hurt player
	if self.heat_amount >= 65 then
		for k, v in pairs(ents.FindInSphere(self:GetPos(), 40)) do
			if IsValid(v) and v:IsPlayer() then
				local ply = v
			
				if not ply.fom_hurt_wait then
					ply.fom_hurt_wait = true
				
					timer.Create("fom_hurt_ply" .. ply:EntIndex(), 0.5, 1, function()
						if IsValid(ply) then
							ply:TakeDamage(5)
						
							ply.fom_hurt_wait = false
						end
					end)
				end
			end
		end
	end
	
	if not self.send_heat_to_client then
		self.send_heat_to_client = true
		
		timer.Create("fom_send_heat" .. self:EntIndex(), 1, 1, function()
			self:SetNWFloat("fom_heat_amount", self.heat_amount)
			
			self.send_heat_to_client = false
		end)
	end
	
	//Checking angles
	--[[Fixed to small angle check. Added more realistic potion pouring formula.]]--
	--[[Clamping, because 100/90 = 1,(1), so instead using 1.1 we use 1.2]]--
	--[[ADD PARTICLES FOR WATER POURING OUT]]--
	local cauldangle = math.abs(self:GetAngles().r)
	if cauldangle > 55 and ((self.liquid_state != "water" and self:WaterLevel() >= 3) or self.liquid_amount > 0) then self.liquid_amount = math.Clamp(self.liquid_amount - ((cauldangle * 1.2) - self.liquid_amount),0,100) end
	
	//Changing color
	for k, v in pairs(self.liquid_color) do
		self.liquid_curcolor[k] = math.Approach(self.liquid_curcolor[k], v, 1)
	end
	self.liquid:SetColor(self.liquid_curcolor)
	
	//Checking ingredients in cauldron
	for k, v in pairs(self.brew_ingredients) do
		if IsValid(v) then 
			if v:GetPos():Distance(self:GetPos() + Vector(0, 0, 25)) > 30 then self:RemoveIngredient(v) end
		else
			self:RemoveIngredient(v)
		end
	end
	
	//Getting flask
	for k, v in pairs(ents.FindInSphere(self:GetPos() + Vector(0, 0, 25), 25)) do
		if IsValid(v) and IsValid(v:GetPhysicsObject()) and v:GetClass() == "fom_flask" and self.liquid_state then
			if not v.Used and self.liquid_state then v.Desc = self.liquid_state v.Used = true self.liquid_amount = self.liquid_amount - 5 end
		end
	end
	
	--[[UPD: yes we need 20 not 0 :C]]--
	if self.liquid_amount <= 20 then self.liquid_state = nil end
	if self.liquid_amount > 40 and self.heat_amount >= self.heat_brewing_point then
	
		--[[Fixed null prop check]]--
		//Getting ingredients
		for k, v in pairs(ents.FindInSphere(self:GetPos() + Vector(0, 0, 22), 25)) do
			if IsValid(v) and IsValid(v:GetPhysicsObject()) then
				if fom_GetIngredient(v) and not table.HasValue(self.brew_ingredients, v) then
					self:SetUpIngredient(v)
					
					if fom_potions_manager.GetPotionByRecipe(string.Left(self:GetIngredientsStr(), string.len(self:GetIngredientsStr()) - 1)) then
						self:StartMakingPotion(fom_potions_manager.GetPotionByRecipe(string.Left(self:GetIngredientsStr(), string.len(self:GetIngredientsStr()) - 1)))
					elseif self.liquid_color != Color(0, 190, 255, 10) and self.liquid_state == "water" then
						self.liquid_color = Color(0, 190, 255, 10)
					end
				end
			end
		end
		
		self:MakeBubbles()
	else
		for k, v in pairs(self.brew_ingredients) do self:RemoveIngredient(v) end
	end
	
	self:ProcessHeat()
	
	//Checking liquid
	if self.liquid and IsValid(self.liquid) then
		if self.liquid:GetModelScale() != self.liquid_amount * 0.0065 then
			self.liquid:SetModelScale(self.liquid_amount * 0.0065 * 0.65, 0)
		end
		
		self.liquid:SetPos(Vector(0, 0, self.liquid_amount * 0.42))
	end
	
	//Getting water
	if self:WaterLevel() >= 3 then
		self.liquid_state = "water"
		self.liquid_amount = 100
		self.liquid_color = Color(0, 190, 255, 10)
	end
	
	self:NextThink(CurTime())
	return true
end

function ENT:SpawnFunction(ply, tr, name)
	if CLIENT then return end

	if not tr.Hit then return end
	if not IsValid(ply) then return end

	local pos = tr.HitPos + tr.HitNormal * 32
	
	local ent = ents.Create("fom_cauldron")
	ent:SetPos(pos)
	ent:Spawn()
	ent:Activate()
	
	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then phys:Wake() else return NULL end
	
	return ent
end

