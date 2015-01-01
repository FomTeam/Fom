/***
	Flask

	Coded and managed by Trojan
***/

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.Spawnable = false
ENT.Desc = {}

if CLIENT then _addMagicEntity("Empty flask", "fom_flask", "fom_flasks") end

function ENT:Initialize()
	if CLIENT then return end

	self:SetModel("models/fom/flask/flask.mdl")
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
end

function ENT:Draw()
	if SERVER then return end
	
	self:DrawModel()
end

function ENT:Boom(pos)
	if self.Desc and type(self.Desc) == "table" and self.Desc.CollisionFunc then
		self.Desc.CollisionFunc(self, pos)
			
		local ef = EffectData()
		ef:SetOrigin(self:GetPos())
		ef:SetMagnitude(0.3)
		ef:SetStart(Vector(self.Desc.color.r, self.Desc.color.g, self.Desc.color.b))
		util.Effect("fom_effect_boom", ef)
	end
		
	self:EmitSound("physics/glass/glass_bottle_break" .. math.random(1, 2) .. ".wav")
	
	self:Remove()
end

function ENT:Think()
	if SERVER and self.Desc and type(self.Desc) == "table" and self.Desc.color then self:SetColor(self.Desc.color) end
end

function ENT:OnTakeDamage() self:Boom(self:GetPos()) end

function ENT:Use(activator, caller)
	if self.Desc and type(self.Desc) == "table" and self.Used then
		if not self.Desc.UseFunc then
			if self.Desc.CollisionFunc then self.Desc.CollisionFunc(self, self:GetPos()) end
		else
			self.Desc.UseFunc(caller)
		end
		
		self:EmitSound("fom/drinking.wav")
		
		self.Used = false
		self.Desc = {}
		self:SetColor(Color(255, 255, 255))
	end
end

function ENT:PhysicsCollide(data, phys)	
	if data.Speed > 200 then
		self:Boom(data.HitPos)
	end
end

function ENT:SpawnFunction(ply, tr, name)
	if CLIENT then return end

	if not tr.Hit then return end
	if not IsValid(ply) then return end

	local pos = tr.HitPos + tr.HitNormal * 16
	
	local ent = ents.Create("fom_flask")
	ent:SetPos(pos)
	ent:Spawn()
	ent:Activate()
	
	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then phys:Wake() else return NULL end
	
	return ent
end

