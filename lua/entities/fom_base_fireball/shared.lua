/***
	Base for fireball

	Coded and managed by Trojan
***/

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.Spawnable = false

if CLIENT then
	_addMagicEntity("Fireball", "fom_base_fireball", "fom_entity_stuff")
end

function ENT:Initialize()
	if CLIENT then return end

	self:SetModel("models/hunter/misc/sphere025x025.mdl")
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:DrawShadow(false)
	self:GetPhysicsObject():EnableGravity(false)
end

function ENT:Draw()
	if SERVER then return end

	render.SetMaterial(Material("particle/particle_glow_04_additive"))
	render.DrawSprite(self:GetPos(), math.random(10, 50), math.random(10, 50), Color(255, 255, 255))
end
