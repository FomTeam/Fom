/***
	Explosion of full flask

	Coded and managed by Trojan
***/

if SERVER then AddCSLuaFile() end

function EFFECT:Init(data)
	local col = data:GetStart()
	self.Start = data:GetOrigin()
	self.size = data:GetMagnitude()
	self.Emitter = ParticleEmitter(self.Start)
	
	for i = 1, 80 do
		local p = self.Emitter:Add("effects/bubble", self.Start + Vector(0, 0, 20))

		p:SetDieTime(math.Rand(0.4, 1.8))
		p:SetStartAlpha(255)
		p:SetEndAlpha(255)
		p:SetStartSize(math.random(2, 4) * self.size)
		p:SetEndSize(math.random(2, 4) * self.size)
		p:SetCollide(true)
		p:SetGravity(Vector(0, 0, math.Rand(-50, -4)))
		p:SetVelocity(VectorRand() * 220 * self.size)
		p:SetColor(col.x, col.y, col.z)
		
		local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), self.Start)

		p:SetDieTime(math.Rand(1.1, 1.2))
		p:SetStartAlpha(60)
		p:SetEndAlpha(0)
		p:SetStartSize(0)//math.random(120, 150) * self.size)
		p:SetEndSize(math.random(120, 150) * self.size)
		p:SetRoll(math.Rand(-15, 15))
		p:SetRollDelta(math.Rand(-15, 15))
		p:SetGravity(Vector(0, 0, math.Rand(-50, -4)))
		p:SetVelocity(VectorRand() * 220 * self.size)
		p:SetAirResistance(100)
		p:SetColor(col.x, col.y, col.z)
	end
	
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
	return false
end