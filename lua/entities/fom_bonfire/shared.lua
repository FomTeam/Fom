/***
	Quick way to heat cauldron

	Coded and managed by Trojan
***/

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.Spawnable = false

if CLIENT then _addMagicEntity("Bonfire", "fom_bonfire") end

function ENT:Initialize()
	if CLIENT then return end

	self:SetModel("models/fom/bonfire/bonfire.mdl")
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	ParticleEffectAttach("bonfire_light", PATTACH_POINT_FOLLOW, self, 0)
end

function ENT:Draw()
	if SERVER then return end
	
	self:DrawModel()
end
function ENT:Think()
	if CLIENT then
		local dlight = DynamicLight(self:EntIndex())
		if dlight then
			dlight.pos = self:GetPos()
			dlight.r = 255
			dlight.g = 51
			dlight.b = 0
			dlight.brightness = 0.5
			dlight.Decay = 1000
			dlight.Size = 156
			dlight.Style = 6
			dlight.DieTime = CurTime() + 0.1
		end
	end
end
function ENT:SpawnFunction(ply, tr, name)
	if CLIENT then return end

	if not tr.Hit then return end
	if not IsValid(ply) then return end

	local pos = tr.HitPos + tr.HitNormal * 32
	
	local ent = ents.Create("fom_bonfire")
	ent:SetPos(pos)
	ent:Spawn()
	ent:Activate()
	
	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then phys:Wake() else return NULL end
	
	return ent
end

