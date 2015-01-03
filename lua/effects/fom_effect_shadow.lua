/***
	Shadow

	Coded and managed by Trojan
***/

if SERVER then AddCSLuaFile() end

local beam = Material("cable/physbeam")
local beam2 = Material("cable/redlaser")

function EFFECT:Init(data)
	self.Start = data:GetStart()
	self.End = data:GetOrigin()
	
	self:SetRenderBoundsWS(self.Start, self.End)
	
	self.Die = CurTime() + 0.2
end

function EFFECT:Think()
	if CurTime() > self.Die then return false end
	return true
end

function EFFECT:Render()
	render.SetMaterial(beam)
	render.DrawBeam(self.Start, self.End, math.Rand(1, 45), math.Rand(1, 25), 0, Color(255, 0, 255, 255))
	
	render.SetMaterial(beam2)
	render.DrawBeam(self.Start, self.End, math.Rand(1, 60), math.Rand(1, 25), 0, Color(255, 0, 255, 255))
end
