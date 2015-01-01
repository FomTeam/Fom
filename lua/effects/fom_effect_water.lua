/***
	Explosion of full flask

	Coded and managed by Trojan
***/

if SERVER then AddCSLuaFile() end

function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	self.Emitter = ParticleEmitter(self.Start)
	
	local p = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), self.Start)

	//for i = 1, 900 do
	p:SetDieTime(math.Rand(0.1, 1))
	p:SetStartAlpha(0)
	p:SetEndAlpha(60)
	p:SetStartSize(math.Rand(1, 2))
	p:SetEndSize(math.Rand(4, 6))
	p:SetRoll(math.Rand(-1, 1))
	p:SetRollDelta(math.Rand(-1, 1))
	p:SetGravity(Vector(0, 0, -150))
	p:SetColor(220, 255, 255) //end
	
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
	return false
end