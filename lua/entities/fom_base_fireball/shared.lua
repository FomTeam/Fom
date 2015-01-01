--[[
	Base fireball entity
	Use with mhands SWEP
	
	Coded and managed by [G - P.R.O]EgrOnWire
	
#######################################################################################################################
	Note for people who decompiled this addon to look only for developer functions:
	
		As developer of this part of addon, i have some rights (maybe?), to add some stuff
		that normal players don't have, can't have and not count as cheating (as kekc's instakill sphere in his wand).
		This part of addon contain list of developers steamid's i use for making our fireballs more unique.
		Our fireballs only have unique looks and nothing else.
		
	Note to Robotboy:
		It is better to optimize the game than watch the other's addons.
		Everyone don't have powerfull pc's to handle your shit code. Difference is not 8 FPS. It's 800 fps.
		Quit looking at other developers code, searching for a author only stuff. Fix and optimise damn game.
#######################################################################################################################
]]--

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName= "Magical fireball"
ENT.Author= "[G - P.R.O]EgrOnWire"
ENT.Contact= "egoronwire@gmail.com & via steam"
ENT.Purpose= "Kill, heal, bark and many more :D"
ENT.Instructions= "Explodes on touch. Have different customizable effects."
ENT.Category = "Features Of Magic"

ENT.Spawnable = true
ENT.AdminSpawnable = false

function ENT:Initialize()
	if CLIENT then return end

	self:SetModel("models/hunter/misc/sphere025x025.mdl")
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:DrawShadow(false)
end

function ENT:Draw()
	if SERVER then return end
	--[[Leave color like this, ill code it later]]--
	--[[TODO: height and width are derived from damage/abilities of fireball, color properties is dervied from properties only]]--
	
	--[[Dis one is explosive variant]]--
	render.SetMaterial(Material("particle/particle_glow_04_additive"))
	render.DrawSprite(self:GetPos(), 50, 50, Color(255, 255, 255))
	render.SetMaterial(Material("particles/fire_glow"))
	render.DrawSprite(self:GetPos(), 100, 100, Color(255, 255, 0))
end

function ENT:SpawnFunction(ply, tr, name)
	if CLIENT then return end

	if not tr.Hit then return end
	if not ply then return end
	if not ply:IsValid() then return end

	local pos = tr.HitPos + tr.HitNormal * 32
	
	local ent = ents.Create("fom_base_fireball")
	ent:SetPos(pos)
	ent:SetAngles(Angle(0, 0, 180))
	ent:Spawn()
	ent:Activate()
	ent.Alch_Properties = {} --[[Abilities of our fireball]]--
	
	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then phys:EnableGravity(false) phys:Wake() else return NULL end
	
	return ent
end
 
--[[
function ENT:Think()
 return --Maytbe some additional calculations, but later
end
]]--

function ENT:Explosive(pos)
--[[mrminds code, rework it later when swep is ready]]--
	local EFDATA = EffectData()
	EFDATA:SetOrigin(pos)
	util.Effect("Explosion", EFDATA)
	
	local owner = self:GetOwner()
	if not owner then owner = self end
	if not owner:IsValid() then owner = self end
	
	util.BlastDamage(self, owner, self:GetPos(), 180, 20)
	
	self:Remove()
end

function ENT:PhysicsCollide(data, phys)
	if CLIENT then return end

	self:Explosive(data.HitPos)
end
