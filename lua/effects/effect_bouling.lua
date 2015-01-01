if SERVER then AddCSLuaFile() end

function EFFECT:Init(data)

	self.Start = data:GetOrigin()
	self.size = 1
	self.Emitter = ParticleEmitter(self.Start)
			
	local vec = VectorRand()
			
	vec.z = 0
			
	local p = self.Emitter:Add("effects/bubble", self.Start + vec * 20)

	p:SetDieTime(math.Rand(5, 15))
	p:SetStartAlpha(255)
	p:SetEndAlpha(255)
	p:SetStartSize(math.random(4,8) * self.size)
	p:SetEndSize(math.random(4,8) * self.size)
	p:SetCollide(true)
	p:SetGravity(Vector(0,0,math.Rand(4,10)))
	p:SetColor(255,255,255)
	
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
	return false
end