/***
	Furnace
	
	Coded and managed by Trojan
***/

/*** Main variables ***/
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.Spawnable = false
/*** Main variables END ***/

//if CLIENT then _addMagicEntity("Furnace", "fom_furnace") end

function ENT:Initialize()
	if CLIENT then return end

	self:SetModel("models/fom/furnace/furnace.mdl")
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
end

function ENT:Draw()
	if SERVER then return end
	
	self:DrawModel()
end

function ENT:Think()
	if CLIENT then return end
	
	
	
	self:NextThink(CurTime())
	return true
end

function ENT:SpawnFunction(ply, tr, name)
	if CLIENT then return end

	if not tr.Hit then return end
	if not IsValid(ply) then return end

	local pos = tr.HitPos + tr.HitNormal * 128
	
	local ent = ents.Create("fom_furnace")
	ent:SetPos(pos)
	ent:Spawn()
	ent:Activate()
	
	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then phys:Wake() else return NULL end
	
	return ent
end

