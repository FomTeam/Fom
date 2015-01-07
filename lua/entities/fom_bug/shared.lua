AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.Spawnable = false
ENT.Npcs = {}

function ENT:MakeNPCS()
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 500)) do
		if not table.HasValue(self.Npcs, v) and (v:IsNPC() or (v:IsPlayer() and v != self.Owner)) then table.insert(self.Npcs, v) end
	end
end

function ENT:FindEnemy()
	if CLIENT then return end
	
	self.enemy = table.Random(self.Npcs)
end 

function ENT:Initialize()
	if CLIENT then return end
	
	self.Npcs = {}
	
	timer.Create("fom_bug_die" .. self:EntIndex(), math.Rand(3, 7), 1, function()
		SafeRemoveEntity(self)
	end)

	self:SetModel("models/hunter/misc/sphere025x025.mdl")
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:DrawShadow(false)
	self:GetPhysicsObject():EnableGravity(false)
	
	util.SpriteTrail(self, 0, Color(255, 255, 0), false, 5, 0, 0.7, 3, "cable/physbeam.vmt")
end

function ENT:Think()
	if CLIENT then return end
	if GetConVar("ai_disabled"):GetBool() then return end
	
	self:MakeNPCS()
	
	if not IsValid(self.enemy) then
		self:FindEnemy()
		self:GetPhysicsObject():ApplyForceCenter(VectorRand() *  100)
	else
		self:GetPhysicsObject():ApplyForceCenter((self.enemy:GetPos() - self:GetPos()):GetNormal() * 800 + VectorRand() * 2)
	end
	
	self:NextThink(CurTime())
	return true
end

function ENT:Draw()
	if SERVER then return end

	render.SetMaterial(Material("particle/particle_glow_04_additive"))
	render.DrawSprite(self:GetPos(), math.Rand(5, 10), math.Rand(5, 10), Color(255, 255, 255))
end

function ENT:PhysicsCollide(data, phys)
	if CLIENT then return end
	if IsValid(self.enemy) then self.enemy:TakeDamage(4) self.enemy = nil end
end
