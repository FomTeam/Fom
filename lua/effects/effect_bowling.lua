/***
	Bubbles effect

	Coded and managed by Trojan
***/

if SERVER then AddCSLuaFile() end

function EFFECT:Init(data)

	self.Start = data:GetOrigin()
	self.size = 1
	self.Emitter = ParticleEmitter(self.Start)
	
	local p = self.Emitter:Add("effects/bubble", self.Start)

	p:SetDieTime(math.Rand(0.4, 1.8))
	p:SetStartAlpha(255)
	p:SetEndAlpha(255)
	p:SetStartSize(math.random(2, 4) * self.size)
	p:SetEndSize(math.random(2, 4) * self.size)
	p:SetCollide(true)
	p:SetGravity(Vector(0, 0, math.Rand(4, 50)))
	p:SetColor(255, 255, 255)
	
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
	return false
end