/***
	Base for fireball

	Coded and managed by Trojan
***/

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.Spawnable = false
ENT.DATA = nil

if CLIENT then
	_addMagicEntity("Fireball", "fom_base_fireball", "fom_entity_stuff")
end

function ENT:Initialize()
	if CLIENT then return end
	
	timer.Create("fom_delete_firaball" .. self:EntIndex(), 5, 1 , function()
		if self.DATA then
			for k, v in pairs(ents.FindInSphere(self:GetPos(), 150)) do
				self.DATA.func(v)
				self:Remove()
			end
		end
	end)

	self:SetModel("models/hunter/misc/sphere025x025.mdl")
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:DrawShadow(false)
	self:GetPhysicsObject():EnableGravity(false)
	self:GetPhysicsObject():SetMass(10)
	
	self.DATA = fom_runes_manager.GetRuneByName("Blast")
end

function ENT:Draw()
	if SERVER then return end

	render.SetMaterial(Material("particle/particle_glow_04_additive"))
	render.DrawSprite(self:GetPos(), math.random(10, 50), math.random(10, 50), Color(255, 255, 255))
end

function ENT:PhysicsCollide(data)
	if self.DATA then
		for k, v in pairs(ents.FindInSphere(data.HitPos, 150)) do
			self.DATA.func(v)
			self:Remove()
		end
	end
end