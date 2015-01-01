/***
	This is notebook
	User can save his found potions with this stuff (recipes of potions is unknown)

	Coded and managed by Trojan
***/

AddCSLuaFile()

SWEP.Slot				= 0
SWEP.SlotPos			= 1
SWEP.Base				= "weapon_base"
SWEP.Spawnable			= false
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/c_grenade.mdl"
SWEP.WorldModel = "models/weapons/w_grenade.mdl"
SWEP.DrawAmmo = true
SWEP.Weight				= 1
SWEP.AutoSwitchTo		= false
SWEP.PrintName = "Notebook"
SWEP.AutoSwitchFrom		= false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.ShowWorldModel = false
SWEP.UseHands = true

SWEP.BobScale = 1

SWEP.ViewModelBoneMods = {
	["ValveBiped.Grenade_body"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

if CLIENT then
	file.CreateDir("fom_notebook_recipes")

	SWEP.VElements = {
		["m"] = { type = "Model", model = "models/props_lab/bindergreenlabel.mdl", bone = "ValveBiped.Grenade_body", rel = "", pos = Vector(0, 1.299, 0.518), angle = Angle(0, 99.35, 180), size = Vector(0.497, 0.497, 0.497), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.WElements = {
		["m"] = { type = "Model", model = "models/props_lab/bindergreenlabel.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 2.596, -3.636), angle = Angle(0, 68.96, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	_addMagicEntity("Notebook", "fom_notebook", "fom_weapon", "weapon")
end

function SWEP:Initialize()
	self:SetHoldType("duel")

	if CLIENT then
		self.Window = nil
		
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

		self:CreateModels(self.VElements)
		self:CreateModels(self.WElements)

		if IsValid(self.Owner) then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)

				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255,255,255,255))
				else
					vm:SetColor(Color(255,255,255,1))
					vm:SetMaterial("Debug/hsv")			
				end
			end
		end
	end
end

function SWEP:Holster()
	if CLIENT and IsValid(self.Owner) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
	
	return true
end

function SWEP:OnRemove()
	self:Holster()
end

function SWEP:PrimaryAttack()
	if CLIENT then return end

	umsg.Start("fom_book_open", self.Owner)
		umsg.Entity(self)
	umsg.End()
end

function SWEP:SecondaryAttack()
end

function OpenMenu(self)
	if not self then return end
	
	//Don't let open panel twice more times
	self.Current_Selected_Potion = ""
	
	self.win = vgui.Create("DFrame")
	self.win:SetSize(800, 500)
	self.win:SetTitle("")
	self.win:Center()
	self.win:MakePopup()
	self.win.Paint = function()
		local w = self.win:GetWide()
		local t = self.win:GetTall()
		
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(Material("fom/old_book"))
		surface.DrawTexturedRect(-20, -20, w + 20, t + 20)
	end
	
	local panel = vgui.Create("DPanel", self.win)
	panel:SetPos(25, 40)
	panel:SetSize(370, 400)
	panel.Paint = function() end
	
	local name = vgui.Create("DLabel", panel)
	name:SetPos(35, 25)
	name:SetFont("Trebuchet18")
	name:SetColor(Color(0, 0, 0))
	name:SetText("")
	
	local desc = vgui.Create("DLabel", panel)
	desc:SetPos(35, 50)
	desc:SetFont("Trebuchet18")
	desc:SetColor(Color(0, 0, 0))
	desc:SetText("")
	
	//Found recipes
	local rec = vgui.Create("DListView", self.win)
	rec:SetPos(415, 40)
	rec:SetSize(320, 425)
	rec:AddColumn("Recipes")
	rec.Paint = function() end
	
	local tab = file.Find("fom_notebook_recipes/*.txt", "DATA")
	for k, v in pairs(tab) do
		rec:AddLine(string.Explode(".txt", v)[1])
	end
	
	rec.OnClickLine = function(p, line, i)
		if line and self.Current_Selected_Potion != line:GetValue(1) then
			name:SetText("Name: " .. line:GetValue(1))
			if file.Exists("fom_notebook_recipes/" .. line:GetValue(1) .. ".txt", "DATA") then desc:SetText("Recipe: " .. file.Read("fom_notebook_recipes/" .. line:GetValue(1) .. ".txt")) end
			name:SizeToContents()
			desc:SizeToContents()
			
			local remove = vgui.Create("DButton", panel)
			remove:SetPos(15, 260)
			remove:SetSize(315, 25)
			remove:SetText("Remove this recipe")
			remove:SetFont("Trebuchet18")
			remove.DoClick = function()
				file.Delete("fom_notebook_recipes/" .. line:GetValue(1) .. ".txt")
				
				self.win:Close()
				OpenMenu(self)
			end
			remove.Paint = function() end
			
			local c_desc = vgui.Create("DButton", panel)
			c_desc:SetPos(15, 300)
			c_desc:SetSize(315, 20)
			c_desc:SetText("Change recipe")
			c_desc:SetFont("Trebuchet18")
			c_desc.DoClick = function()
				local make = vgui.Create("DFrame")
				make:SetSize(300, 110)
				make:Center()
				make:SetTitle("")
				make:MakePopup()
				
				local dl = vgui.Create("DLabel", make)
				dl:SetText("Recipe")
				dl:SetPos(12, 35)
				dl:SizeToContents()
				
				local text = vgui.Create("DTextEntry", make)
				text:SetPos(75, 35)
				text:SetSize(210, 25)
				local cur_text = string.sub(desc:GetValue(1), 9)
				if not cur_text then cur_text = "" end
				text:SetText(cur_text)
				
				local btn = vgui.Create("DButton", make)
				btn:SetPos(12, 70)
				btn:SetText("Save recipe")
				btn:SetSize(275, 25)
				btn.DoClick = function()
					local name = line:GetValue(1)
					
					file.Write("fom_notebook_recipes/" .. name .. ".txt", text:GetValue())
					
					make:Close()
					self.win:Close()
					OpenMenu(self)
				end
			end
			c_desc.Paint = function() end
			
			local c_name = vgui.Create("DButton", panel)
			c_name:SetPos(15, 280)
			c_name:SetSize(315, 20)
			c_name:SetText("Change name")
			c_name:SetFont("Trebuchet18")
			c_name.DoClick = function()
				local make = vgui.Create("DFrame")
				make:SetSize(300, 110)
				make:Center()
				make:SetTitle("")
				make:MakePopup()
				
				local dl = vgui.Create("DLabel", make)
				dl:SetText("Name")
				dl:SetPos(12, 35)
				dl:SizeToContents()
				
				local text = vgui.Create("DTextEntry", make)
				text:SetPos(75, 35)
				text:SetSize(210, 25)
				local cur_text = string.sub(name:GetValue(1), 7)
				if not cur_text then cur_text = "" end
				text:SetText(cur_text)
				
				local btn = vgui.Create("DButton", make)
				btn:SetPos(12, 70)
				btn:SetText("Save recipe")
				btn:SetSize(275, 25)
				btn.DoClick = function()
					if file.Exists("fom_notebook_recipes/" .. line:GetValue(1) .. ".txt", "DATA") then 
						local data = file.Read("fom_notebook_recipes/" .. line:GetValue(1) .. ".txt", "DATA")
					
						file.Delete("fom_notebook_recipes/" .. line:GetValue(1) .. ".txt")
						file.Write("fom_notebook_recipes/" .. text:GetValue() .. ".txt", data)
					end
					
					make:Close()
					self.win:Close()
					OpenMenu(self)
				end
			end
			c_name.Paint = function() end
			
			self.Current_Selected_Potion = line:GetValue(1)
		end
	end
	
	local mak = vgui.Create("DButton", self.win)
	mak:SetPos(15, 425)
	mak:SetSize(370, 40)
	mak:SetText("Save recipe")
	mak.DoClick = function()
		local make = vgui.Create("DFrame")
		make:SetSize(300, 140)
		make:Center()
		make:SetTitle("")
		make:MakePopup()
		
		local dl = vgui.Create("DLabel", make)
		dl:SetText("Description")
		dl:SetPos(12, 35)
		dl:SizeToContents()
		
		local dl = vgui.Create("DLabel", make)
		dl:SetText("Recipe")
		dl:SetPos(12, 80)
		dl:SizeToContents()
		
		local text = vgui.Create("DTextEntry", make)
		text:SetPos(75, 35)
		text:SetSize(210, 25)
		
		local recc = vgui.Create("DTextEntry", make)
		recc:SetPos(75, 80)
		recc:SetSize(210, 25)
		
		local btn = vgui.Create("DButton", make)
		btn:SetPos(12, 110)
		btn:SetText("Save recipe")
		btn:SetSize(275, 25)
		btn.DoClick = function()
			file.Write("fom_notebook_recipes/" .. text:GetValue() .. ".txt", recc:GetValue())
			make:Close()
			
			self.win:Close()
			OpenMenu(self)
		end
	end
	mak:SetFont("Trebuchet18")
	mak.Paint = function() end
	
	return self.win
end

usermessage.Hook("fom_book_open", function(data)
	OpenMenu(data:ReadEntity())
end)


if CLIENT then

	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		
		local vm = self.Owner:GetViewModel()
		if !IsValid(vm) then return end
		
		if (!self.VElements) then return end
		
		self:UpdateBonePositions(vm)

		if (!self.vRenderOrder) then
			
			// we build a render order because sprites need to be drawn after models
			self.vRenderOrder = {}

			for k, v in pairs( self.VElements ) do
				if (v.type == "Model") then
					table.insert(self.vRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.vRenderOrder, k)
				end
			end
			
		end

		for k, name in ipairs( self.vRenderOrder ) do
		
			local v = self.VElements[name]
			if (!v) then self.vRenderOrder = nil break end
			if (v.hide) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (!v.bone) then continue end
			
			local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
			
			if (!pos) then continue end
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	SWEP.wRenderOrder = nil
	function SWEP:DrawWorldModel()
		
		if (self.ShowWorldModel == nil or self.ShowWorldModel) then
			self:DrawModel()
		end
		
		if (!self.WElements) then return end
		
		if (!self.wRenderOrder) then

			self.wRenderOrder = {}

			for k, v in pairs( self.WElements ) do
				if (v.type == "Model") then
					table.insert(self.wRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.wRenderOrder, k)
				end
			end

		end
		
		if (IsValid(self.Owner)) then
			bone_ent = self.Owner
		else
			// when the weapon is dropped
			bone_ent = self
		end
		
		for k, name in pairs( self.wRenderOrder ) do
		
			local v = self.WElements[name]
			if (!v) then self.wRenderOrder = nil break end
			if (v.hide) then continue end
			
			local pos, ang
			
			if (v.bone) then
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
			else
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
			end
			
			if (!pos) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
		
		local bone, pos, ang
		if (tab.rel and tab.rel != "") then
			
			local v = basetab[tab.rel]
			
			if (!v) then return end
			
			// Technically, if there exists an element with the same name as a bone
			// you can get in an infinite loop. Let's just hope nobody's that stupid.
			pos, ang = self:GetBoneOrientation( basetab, v, ent )
			
			if (!pos) then return end
			
			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
		else
		
			bone = ent:LookupBone(bone_override or tab.bone)

			if (!bone) then return end
			
			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBoneMatrix(bone)
			if (m) then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end
			
			if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
				ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
				ang.r = -ang.r // Fixes mirrored models
			end
		
		end
		
		return pos, ang
	end

	function SWEP:CreateModels( tab )

		if (!tab) then return end

		// Create the clientside models here because Garry says we can't do it in the render hook
		for k, v in pairs( tab ) do
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
				
				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
				
			elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
				and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
				
				local name = v.sprite.."-"
				local params = { ["$basetexture"] = v.sprite }
				// make sure we create a unique name based on the selected options
				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for i, j in pairs( tocheck ) do
					if (v[j]) then
						params["$"..j] = 1
						name = name.."1"
					else
						name = name.."0"
					end
				end

				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
				
			end
		end
		
	end
	
	local allbones
	local hasGarryFixedBoneScalingYet = false

	function SWEP:UpdateBonePositions(vm)
		
		if self.ViewModelBoneMods then
			
			if (!vm:GetBoneCount()) then return end
			
			// !! WORKAROUND !! //
			// We need to check all model names :/
			local loopthrough = self.ViewModelBoneMods
			if (!hasGarryFixedBoneScalingYet) then
				allbones = {}
				for i=0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)
					if (self.ViewModelBoneMods[bonename]) then 
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = { 
							scale = Vector(1,1,1),
							pos = Vector(0,0,0),
							angle = Angle(0,0,0)
						}
					end
				end
				
				loopthrough = allbones
			end
			// !! ----------- !! //
			
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end
				
				// !! WORKAROUND !! //
				local s = Vector(v.scale.x,v.scale.y,v.scale.z)
				local p = Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms = Vector(1,1,1)
				if (!hasGarryFixedBoneScalingYet) then
					local cur = vm:GetBoneParent(bone)
					while(cur >= 0) do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end
				
				s = s * ms
				// !! ----------- !! //
				
				if vm:GetManipulateBoneScale(bone) != s then
					vm:ManipulateBoneScale( bone, s )
				end
				if vm:GetManipulateBoneAngles(bone) != v.angle then
					vm:ManipulateBoneAngles( bone, v.angle )
				end
				if vm:GetManipulateBonePosition(bone) != p then
					vm:ManipulateBonePosition( bone, p )
				end
			end
		else
			self:ResetBonePositions(vm)
		end
		   
	end
	 
	function SWEP:ResetBonePositions(vm)
		
		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end
		
	end

	/**************************
		Global utility code
	**************************/

	// Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
	// Does not copy entities of course, only copies their reference.
	// WARNING: do not use on tables that contain themselves somewhere down the line or you'll get an infinite loop
	function table.FullCopy( tab )

		if (!tab) then return nil end
		
		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v) // recursion ho!
			elseif (type(v) == "Vector") then
				res[k] = Vector(v.x, v.y, v.z)
			elseif (type(v) == "Angle") then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end
		
		return res
		
	end
	
end












