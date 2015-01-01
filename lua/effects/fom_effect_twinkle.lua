/***
	Bubbles effect

	Coded and managed by Trojan
***/

if SERVER then AddCSLuaFile() end

function EFFECT:Init(data)

	self.Start = data:GetOrigin()
	self.size = 1
	self.Emitter = ParticleEmitter(self.Start)
	
	local p = self.Emitter:Add("fom/twinkle", self.Start)

	p:SetDieTime(math.Rand(0.4, 1.2))
	p:SetStartAlpha(50)
	p:SetEndAlpha(50)
	p:SetStartSize(math.random(0.5, 2.5))
	p:SetEndSize(0)
	p:SetRoll(math.Rand(-0.1, 0.1))
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