/***
	Crystal ball
	
	Coded and managed by Trojan
***/

/*** Main variables ***/
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.Spawnable = false
/*** Main variables END ***/

ENT.Wait = 0

if CLIENT then _addMagicEntity("Crystal ball", "fom_sphere", "fom_entity_stuff") end

function ENT:Initialize()
	if CLIENT then 
		self.model = ClientsideModel("models/Gibs/HGIBS.mdl")
		self.model:SetPos(self:LocalToWorld(Vector(0, 0, 15)))
		self.model:SetModelScale(3.5, 0)
		self.model:SetParent(self)
		self.model:SetMaterial("models/debug/debugwhite")
		self.model:SetRenderMode(RENDERMODE_TRANSALPHA)
		self.model:SetColor(Color(0, 255, 255, 100))
		
		return 
	end

	self:SetModel("models/Mechanics/gears/gear16x6.mdl")
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetColor(Color(255, 0, 255))
	
	self.Wait = 0
end

function ENT:OnRemove()
	if CLIENT then SafeRemoveEntity(self.model) end
end

function ENT:Draw()
	if SERVER then return end
	
	self:DrawModel()
end

function ENT:Think()
	if CLIENT then
		local dlight = DynamicLight(self:EntIndex())
		if dlight then
			dlight.pos = self:GetPos()
			dlight.r = 255
			dlight.g = 0
			dlight.b = 255
			dlight.brightness = 0.5
			dlight.Decay = 1000
			dlight.Size = 256
			dlight.Style = 6
			dlight.DieTime = CurTime() + 0.1
		end
	end

	local ef = EffectData()
	ef:SetOrigin(self:GetPos() + Vector(0, 0, 10) + (VectorRand() * 25))
	util.Effect("fom_effect_twinkle", ef)
	
	self:NextThink(CurTime() + 0.5)
	return true
end

function ENT:SpawnFunction(ply, tr, name)
	if CLIENT then return end

	if not tr.Hit then return end
	if not IsValid(ply) then return end

	local pos = tr.HitPos + tr.HitNormal * 16
	
	local ent = ents.Create("fom_sphere")
	ent:SetPos(pos)
	ent:Spawn()
	ent:Activate()
	
	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then phys:Wake() else return NULL end
	
	return ent
end

if SERVER then
	util.AddNetworkString("fom_freezeply")
	
	net.Receive("fom_freezeply", function()
		local ply = net.ReadEntity()
		
		ply.fom_crystal_ball = false
		hook.Remove("Move", "fom_freezeply" .. ply:EntIndex())
	end)
end

function ENT:Use(activator, caller)
	if CLIENT then return end
	if not caller:IsPlayer() then return end
	if CurTime() < self.Wait then return end
	if caller.fom_crystal_ball then return end
	
	hook.Add("Move", "fom_freezeply" .. caller:EntIndex(), function(ply, mv)
		if ply != caller then return end
		mv:SetVelocity(Vector(0, 0, 0))
		
		return true
	end)
	
	umsg.Start("fom_open_cb_menu", caller)
		umsg.Entity(caller)
		umsg.Entity(self)
	umsg.End()
	
	caller.fom_crystal_ball = true
	self.Wait = CurTime() + 1.5
end

if CLIENT then
	local function StopIt(ply)
		hook.Remove("CalcView", "fom_calcview" .. ply:EntIndex())
		hook.Remove("ShouldDrawLocalPlayer", "fom_shdrawlp" .. ply:EntIndex())
		hook.Remove("RenderScreenspaceEffects", "fom_magic_cb" .. ply:EntIndex())
		hook.Remove("HUDShouldDraw", "fom_disablehud" .. ply:EntIndex())
		
		net.Start("fom_freezeply")
			net.WriteEntity(ply)
		net.SendToServer()
	end

	usermessage.Hook("fom_open_cb_menu", function(data)
		// Self is player who opened this menu
		local self = data:ReadEntity()
		local ball = data:ReadEntity()
		if self.win and IsValid(self.win) and self.win:IsActive() then return end
	
		self.win = vgui.Create("DFrame")
		self.win:SetSize(270, 400)
		self.win:ShowCloseButton(false)
		self.win:SetTitle("Crystal ball")
		self.win:Center()
		self.win:MakePopup()
		
		//Found players
		local rec = vgui.Create("DListView", self.win)
		rec:SetPos(15, 35)
		rec:SetSize(240, 345)
		rec:AddColumn("Players")
		
		for k, v in pairs(player.GetAll()) do
			rec:AddLine(v:Nick())
		end
		
		rec.OnClickLine = function(p, line, i)
			self.win:Close()
		
			local cur_ply = self
			for k, v in pairs(player.GetAll()) do
				if v:Nick() == line:GetValue(1) then cur_ply = v break end
			end
			
			self:ChatPrint("[E] - exit")
			
			hook.Add("ShouldDrawLocalPlayer", "fom_shdrawlp" .. self:EntIndex(), function() return true end)
			hook.Add("RenderScreenspaceEffects", "fom_magic_cb" .. self:EntIndex(), function()
				local tab = {}
				tab["$pp_colour_addr"] = 0.1
				tab["$pp_colour_addg"] = 0
				tab["$pp_colour_addb"] = 0.1
				tab["$pp_colour_brightness"] = -0.1
				tab["$pp_colour_contrast"] = 1
				tab["$pp_colour_colour"] = 1
				tab["$pp_colour_mulr"] = 0
				tab["$pp_colour_mulg"] = 0
				tab["$pp_colour_mulb"] = 2 
			 
				DrawColorModify(tab)
			
				DrawMaterialOverlay("effects/water_warp01.vmt", 0.1)
			end)
			hook.Add("HUDShouldDraw", "fom_disablehud" .. self:EntIndex(), function(name) if name == "CHudChat" then return true end return false end)
			hook.Add("CalcView", "fom_calcview" .. self:EntIndex(), function(ply, pos, angles, fov)
				if not IsValid(cur_ply) or not IsValid(ball) or not ply:Alive() or ply:KeyPressed(IN_USE) then StopIt(ply) end
			
				local view = {}

				view.origin = cur_ply:GetPos() + Vector(0, 0, 50) - angles:Forward() * 100
				view.angles = angles
				view.fov = fov
				
				return view
			end)
		end
	end)
end






