/***
	Warlock

	Coded and managed by Trojan
***/

if SERVER then AddCSLuaFile() end

function EFFECT:Init(data)
	local col = data:GetStart()
	self.Start = data:GetOrigin()
	self.Owner = data:GetEntity()
	self.Emitter = ParticleEmitter(self.Start)
	
	for i = 1, 40 do
		local p = self.Emitter:Add("particle/warp2_warp", self.Start)
		local s = math.random(10, 50)
		
		p:SetDieTime(math.Rand(1.5, 2))
		p:SetStartAlpha(math.random(10, 80))
		p:SetEndAlpha(0)
		p:SetStartSize(32)//math.random(120, 150) * self.size)
		p:SetEndSize(0)
		p:SetRoll(math.Rand(-15, 15))
		p:SetRollDelta(math.Rand(-15, 15))
		p:SetGravity(Vector(0, 0, math.Rand(-50, -4)))
		p:SetVelocity((VectorRand() * 20) + self.Owner:GetAimVector() * math.random(100, 300))
		p:SetAirResistance(0)
		p:SetColor(col.x, col.y, col.z)
		
		local p = self.Emitter:Add("sprites/animglow02", self.Start)
		
		p:SetDieTime(math.Rand(0.1, 1))
		p:SetStartAlpha(255)
		p:SetEndAlpha(0)
		p:SetStartSize(s)//math.random(120, 150) * self.size)
		p:SetEndSize(0)
		p:SetRoll(math.Rand(-15, 15))
		p:SetRollDelta(math.Rand(-15, 15))
		p:SetGravity(Vector(0, 0, math.Rand(-50, -4)))
		p:SetVelocity((VectorRand() * 50) + self.Owner:GetAimVector() * math.random(100, 320))
		p:SetAirResistance(0)
		p:SetColor(col.x, col.y, col.z)
		
		local p = self.Emitter:Add("sprites/light_ignorez", self.Start)
		
		p:SetDieTime(math.Rand(0.1, 1))
		p:SetStartAlpha(255)
		p:SetEndAlpha(0)
		p:SetStartSize(s)//math.random(120, 150) * self.size)
		p:SetEndSize(0)
		p:SetRoll(math.Rand(-15, 15))
		p:SetRollDelta(math.Rand(-15, 15))
		p:SetGravity(Vector(0, 0, math.Rand(-50, -4)))
		p:SetVelocity((VectorRand() * 50) + self.Owner:GetAimVector() * math.random(100, 320))
		p:SetAirResistance(0)
		p:SetColor(255, col.y, col.z)
	end
	
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
	return false
end