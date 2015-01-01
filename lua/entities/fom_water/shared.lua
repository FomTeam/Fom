/***
	Water
	
	Coded and managed by Trojan
***/

/*** Main variables ***/
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.Spawnable = false
/*** Main variables END ***/

if CLIENT then _addMagicEntity("Water", "fom_water") end

function ENT:Initialize()
	if CLIENT then return end

	self:SetModel("models/props_junk/garbage_plasticbottle003a.mdl")
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	
	self.water_amount = 100
end

function ENT:Draw()
	if SERVER then return end
	
	self:DrawModel()
end

function ENT:Think()
	if CLIENT then return end
	
	if self:WaterLevel() >= 3 then self.water_amount = 100 end

	if self.water_amount > 0 then
		if math.abs(self:GetAngles().r) > 110 and self:WaterLevel() <= 0 then
			local ef = EffectData()
			ef:SetOrigin(self:LocalToWorld(Vector(0, 0, 9)))
			util.Effect("fom_effect_water", ef)
				
			if not self.Sound then
				self.Sound = CreateSound(self, "fom/water.mp3")
				self.Sound:Play()
				self.Sound:ChangePitch(150, 0)
			end
			
			local tr = util.TraceLine{
				start = self:LocalToWorld(Vector(0, 0, 9)),
				endpos = self:LocalToWorld(Vector(0, 0, 9)) - Vector(0, 0, 200),
				filter = self
			}
				
			local ent = tr.Entity
				
			if IsValid(ent) and ent:GetClass() == "fom_cauldron" and ent.liquid_amount < 100 then
				ent.liquid_state = "water"
				ent.liquid_amount = ent.liquid_amount + 0.4
				ent.liquid_color = Color(0, 190, 255, 10)
			end
				
			self.water_amount = self.water_amount - 0.34
		else
			if self.Sound then self.Sound:Stop() self.Sound = nil end
		end
	else
		if not self.Play_End_Sound then
			self:EmitSound("ambient/water/drip4.wav")
		
			self.Play_End_Sound = true
		end
		if self.Sound then self.Sound:Stop() self.Sound = nil end
	end
	
	/*
		self.liquid_state = "water"
		self.liquid_amount = 100
		self.liquid_color = Color(0, 190, 255, 10) */
	
	self:NextThink(CurTime())
	return true
end

function ENT:SpawnFunction(ply, tr, name)
	if CLIENT then return end

	if not tr.Hit then return end
	if not IsValid(ply) then return end

	local pos = tr.HitPos + tr.HitNormal * 16
	
	local ent = ents.Create("fom_water")
	ent:SetPos(pos)
	ent:Spawn()
	ent:Activate()
	
	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then phys:Wake() else return NULL end
	
	return ent
end

