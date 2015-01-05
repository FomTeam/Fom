AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Spawnable = false

ENT.Wait = 0

local function tonumberb(bool)
	local n = 0
	if bool then n = 1 end
	
	return n
end

function ENT:Draw()
	if SERVER then return end
	
	self:DrawModel()
	
	if self:GetNWBool("broom_diactivated") then
		local ef = EffectData()
		ef:SetOrigin(self:GetPos() - self:GetForward() * 50)
		ef:SetAngles(self:GetAngles())
		util.Effect("effect_sm_fom", ef)
	end
end

function ENT:OnTakeDamage(dmg)
	if SERVER then self:TakePhysicsDamage(dmg) end
end

function ENT:Initialize()
	if CLIENT then return end

	self:SetModel("models/rogue_cheney/broomstick.mdl")
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	
	local phys = self:GetPhysicsObject()
	
	if phys:IsValid() then
		phys:SetMass(200)
	end
	
	self:StartMotionController()
end

function ENT:CreateGhost()
	self.Broom = ents.Create("prop_physics")
	self.Broom:SetModel("models/rogue_cheney/broomstick.mdl")
	self.Broom:SetPos(self:LocalToWorld(Vector(-25, 0, 0)))
	self.Broom:SetParent(self)
	local ang = self:GetAngles()
	ang:RotateAroundAxis(ang:Right(), 180)
	self.Broom:SetAngles(ang)
	self.Broom:Spawn()
	self.Broom:SetModelScale(1.1, 0)
	self.Broom:SetSolid(SOLID_NONE)
	self:SetNoDraw(true)
end

function ENT:Use(activator, caller)
	if CLIENT then return end

	if not activator:IsValid() or not activator:IsPlayer() then return end
	if self:GetNWBool("broom_diactivated") then return end
	if activator:GetNWEntity("broom_active"):IsValid() then return end

	if CurTime() < self.Wait then return end
	
	self:SetDriver(activator)
	self.Wait = CurTime() + 1
end

function ENT:OnRemove()
	self:SetDriver(NULL)
	self:StopMotionController()
	
	if self.Broom and self.Broom:IsValid() then self.Broom:Remove() self.Broom = nil end
end

function ENT:SpawnFunction(ply, tr, name)
	if not tr.Hit then return end

	local pos = tr.HitPos + tr.HitNormal * 32
	
	local ent = ents.Create(name)
	ent:SetPos(pos)
	ent:SetAngles(Angle(0, 0, 180))
	ent:Spawn()
	ent:Activate()

	ent:CreateGhost()
	
	if IsValid(ent:GetPhysicsObject()) then ent:GetPhysicsObject():Wake() else return NULL end
	
	return ent
end

function ENT:Diactivate(time)
	if CLIENT then return end

	self:StopMotionController()
	self:SetNWBool("broom_diactivated", true)
	
	timer.Create("fom_broom_start" .. self:EntIndex(), time, 1, function()
		if self:IsValid() then self:StartMotionController() self:SetNWBool("broom_diactivated", false) end
	end)
end

function ENT:GetDriver() return self:GetOwner() end

function ENT:SetDriver(ply)
	if CLIENT then return end

	local driver = self:GetDriver()
	
	if driver:IsValid() then
		if not ply:IsValid() then
			driver:SetNWEntity("broom_active", NULL)
			driver:DrawWorldModel(true)
			driver:DrawViewModel(true)
			driver:SetNoDraw(false)
			driver:SetMoveType(MOVETYPE_WALK)
			
			if self.UsedWeapon then
				if driver:HasWeapon("weapon_crowbar") then driver:StripWeapon("weapon_crowbar") end
				self.UsedWeapon = false
			end
			
			if self.PlyOldWep and driver:HasWeapon(self.PlyOldWep) then 
				driver:SelectWeapon(self.PlyOldWep) 
				self.PlyOldWep = nil 
			end
			
			driver:SetPos(driver:GetPos() + Vector(0, 0, 60)) // fixing stuck in walls
			if self:GetPhysicsObject():IsValid() then self:GetPhysicsObject():SetVelocity(self:GetForward() * 500) end
			
			// Removing ghost and hitentity
			if self.Ghost and self.Ghost:IsValid() then self.Ghost:Remove() end
			
			self.K = 0
			
			driver:SetVelocity(Vector(0, 0, 0))
		else
			return
		end
	end

	/*******************
		Setup some shit 
		Ugly animation
		Saving data
	*******************/
	if ply:IsValid() then 
		local weapon = ply:GetActiveWeapon()
		if weapon:IsValid() then self.PlyOldWep = weapon:GetClass() end
		
		if not ply:HasWeapon("weapon_crowbar") then
			ply:Give("weapon_crowbar")
			self.UsedWeapon = true
		end
		
		ply:SetVelocity(Vector(0, 0, 0))
		ply:SelectWeapon("weapon_crowbar")
	
		ply:SetNWEntity("broom_active", self) 
		ply:DrawWorldModel(false)
		ply:DrawViewModel(false)
		ply:SetNoDraw(true)
		ply:SetMoveType(MOVETYPE_NOCLIP)
		
		if self.Ghost and self.Ghost:IsValid() then self.Ghost:Remove() end

		local ang = self:GetAngles()
		ang:RotateAroundAxis(ang:Forward(), 180)
		ply:SetEyeAngles(Angle(ang.p, ang.y, 0))
		ang:RotateAroundAxis(ang:Right(), -60)
		
		self.Ghost = ents.Create("fom_broom_ghost")
		self.Ghost:SetPos(self:LocalToWorld(Vector(-20, 0, -5)))
		self.Ghost:SetAngles(ang)
		self.Ghost:SetParent(self)
		self.Ghost:SetModel(ply:GetModel())
		self.Ghost:Spawn()
		self.Ghost:SetNWEntity("broom_driver", ply)
		self.Ghost:SetSolid(SOLID_NONE)
	
		/**********************************
			Ugly animation goes here
			Do not kill me for this shit 
		**********************************/
		self.Ghost:ManipulateBoneAngles(Entity(1):LookupBone("ValveBiped.Bip01_Head1"), Angle(0, 30, 0))	
		self.Ghost:ManipulateBoneAngles(Entity(1):LookupBone("ValveBiped.Bip01_R_Calf"), Angle(0, 30, 0))
		self.Ghost:ManipulateBoneAngles(Entity(1):LookupBone("ValveBiped.Bip01_R_Thigh"), Angle(10, 30, 0))
		self.Ghost:ManipulateBoneAngles(Entity(1):LookupBone("ValveBiped.Bip01_L_Calf"), Angle(0, 30, 0))
		self.Ghost:ManipulateBoneAngles(Entity(1):LookupBone("ValveBiped.Bip01_L_Thigh"), Angle(-10, 30, 0))
		self.Ghost:ManipulateBoneAngles(Entity(1):LookupBone("ValveBiped.Bip01_R_Hand"), Angle(-30, -30, 40))
		self.Ghost:ManipulateBoneAngles(Entity(1):LookupBone("ValveBiped.Bip01_R_Forearm"), Angle(0, 50, 0))
		self.Ghost:ManipulateBoneAngles(Entity(1):LookupBone("ValveBiped.Bip01_R_Clavicle"), Angle(50, 20, 100))
		self.Ghost:ManipulateBoneAngles(Entity(1):LookupBone("ValveBiped.Bip01_L_Hand"), Angle(30, -30, -40))
		self.Ghost:ManipulateBoneAngles(Entity(1):LookupBone("ValveBiped.Bip01_L_Forearm"), Angle(0,  50,0))
		self.Ghost:ManipulateBoneAngles(Entity(1):LookupBone("ValveBiped.Bip01_L_Clavicle"), Angle(-50, 0, -100))
		self.Ghost:SetSequence(ply:LookupSequence("sit"))
		
		self:SetNWEntity("broom_ghost", self.Ghost)
	end

	self:SetNWEntity("broom_driver", ply)
	self:SetOwner(ply)
end

/******************
	Stuff
******************/
function ENT:Think()
	if CLIENT then return end
	
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then phys:Wake() end
	
	local driver = self:GetDriver()
	
	if driver:IsValid() then
		driver:DrawWorldModel(false)
		driver:DrawViewModel(false)
		driver:SetNoDraw(true)
		
		local weapon = driver:GetActiveWeapon()
		
		if weapon:IsValid() then
			weapon:SetNextPrimaryFire(CurTime() + 1.5)
			weapon:SetNextSecondaryFire(CurTime() + 1.5)
		end
	end
	
	self:NextThink(CurTime())
	return true
end

/*******************
	Now we can fly!
*******************/
ENT.K = 1

function ENT:PhysicsSimulate(phys, deltatime)
	if CLIENT then return end
	
	local angf = Vector(0, 0, 0)
	local vecf = Vector(0, 0, 0)
	local damping = -phys:GetAngleVelocity() * 5
	local ang1 = phys:GetAngles()
	
	local driver = self:GetDriver()
	
	if driver:IsValid() then
		if self:WaterLevel() >= 3 then 
			self:SetDriver(NULL) 
			vecf = vecf + VectorRand() * 3000 + vector_up * 5000
			angf = angf + vecf 
			driver:SetVelocity(VectorRand() * 200) 
		end
	
		local ang2 = driver:EyeAngles()
		
		local angy = math.NormalizeAngle(ang1.y - ang2.y)
		local angp = math.NormalizeAngle(ang1.p - ang2.p)
		local angr = math.NormalizeAngle(ang1.r - angy)
		
		// disabling mouse rotate
		if self.CameraRotate then angy = 0 angp = 0 angr = math.NormalizeAngle(ang1.r) end

		angf = angf + Vector(angr * deltatime * 30, angp * 15, angy * 25)

		/***
			Controls
		***/
		local max = 2
		
		self.Speed = 2000
		
		if driver:KeyDown(IN_SPEED) and (driver:KeyDown(IN_FORWARD) or driver:KeyDown(IN_BACK)) then
			self.K = math.min(max, self.K + 0.1)
		else
			self.K = 1
		end
		
		if driver:KeyDown(IN_JUMP) then
			vecf = vecf + vector_up * (self.Speed * 0.06) * (self.K * 5)
		end
			
		if driver:KeyDown(IN_RELOAD) then
			vecf = vecf - vector_up * (self.Speed * 0.06) * (self.K * 5)
		end
		
		if driver:KeyDown(IN_FORWARD) then
			vecf = vecf + phys:GetAngles():Forward() * self.Speed * self.K
		elseif driver:KeyDown(IN_BACK) then
			vecf = vecf - phys:GetAngles():Forward() * (self.Speed * 0.5) * self.K
		else		
			if driver:KeyDown(IN_MOVERIGHT) then
				vecf = vecf - phys:GetAngles():Right() * (self.Speed * 0.4) * self.K
				//angf = angf + Vector(100, 0, 0)
			end
			
			if driver:KeyDown(IN_MOVELEFT) then
				vecf = vecf + phys:GetAngles():Right() * (self.Speed * 0.4) * self.K
				//angf = angf - Vector(100, 0, 0)
			end
		end
	else
		local angp = math.NormalizeAngle(ang1.p - 0)
		local angr = math.NormalizeAngle(ang1.r - 0) * deltatime
		
		angf = angf + Vector(angr * 155, angp * 35, 0)
	end
	
	vecf = vecf + (-phys:GetVelocity() * 1.5) + vector_up * (586.5 + math.sin(CurTime() * 2) * 3)
	angf = angf + damping * deltatime * 90
	
	return angf, vecf, SIM_GLOBAL_ACCELERATION
end

function ENT:PhysicsCollide(data, phys)
	if CLIENT then return end

	if data.DeltaTime < 0.6 then return end
	
	local driver = self:GetDriver()
	
	if driver and driver:IsValid() and data.Speed > 250 then
		driver:TakeDamage(5)
		driver:EmitSound("physics/body/body_medium_break" .. math.random(2, 4) .. ".wav")
		
		if not data.HitEntity:IsWorld() and data.Speed > 900 then
			if self:IsValid() then 
				self:SetDriver(NULL) 
				driver:TakeDamage(15) 
				driver:EmitSound("physics/body/body_medium_break" .. math.random(2, 4) .. ".wav") 
				
				driver:SetVelocity((VectorRand() + vector_up * 600) * 800)
				
				self:GetPhysicsObject():SetVelocity(VectorRand() * 1000)
				self:GetPhysicsObject():AddAngleVelocity(VectorRand() * 2000)
				
				self:Diactivate(5)
			end
		end
	end
end


/***********************
	Stuff
	Hooks
	Rotating
	First/Third person
***********************/

hook.Add("ShouldDrawLocalPlayer", "fom_broom_drawply", function()
	local ent = LocalPlayer():GetNWEntity("broom_active")

	if ent and ent:IsValid() then 
		/* Drawing player if he is not in first person mode */

		local gh = ent:GetNWEntity("broom_ghost")
		if gh and gh:IsValid() then gh:SetNoDraw(false) end
		
		return false 
	end
end)

hook.Add("CalcView", "fom_broom_calcview", function(ply, pos, ang, fov)
	local ent = ply:GetNWEntity("broom_active")

	if not ent:IsValid() then return end
	if ply:InVehicle() or not ply:Alive() or ply:GetViewEntity() != ply then return end

	local dist = 200

	local dir = ply:GetAngles():Forward()
	local pos = ent:GetPos() + Vector(0, 0, 70) - dir * dist
	local ang = dir:Angle()

	local tr = util.TraceHull {
		start = ent:GetPos(),
		endpos = pos,
		filter = { ent, ply, ent:GetNWEntity("broom_active") },
		mask = MASK_NPCWORLDSTATIC,
		mins = Vector(-4, -4, -4),
		maxs = Vector(4, 4, 4)
	}

	local view = {
		origin = tr.HitPos,
		angles = ang,
		fov = fov,
	}

	return view
end)

hook.Add("Move", "create_move_broom", function(ply, mv)
	local ent = ply:GetNWEntity("broom_active")
	if not ent:IsValid() then return end
	if not ply:Alive() then ent:SetDriver(NULL) end
	
	mv:SetOrigin(ent:GetPos() - Vector(0, 0, 60)) // fixing bugs with view
	
	return true
end)

/***************
	Client stuff
***************/
if CLIENT then
	_addMagicEntity("Broom", "fom_broom", "fom_entity_stuff")

	hook.Add("PlayerBindPress", "fom_broom_bindpress", function(ply, bind, pressed)
		local ent = ply:GetNWEntity("broom_active")
		if not ent:IsValid() then return end
		
		local tools = {
			"phys_swap",
			"slot",
			"invnext",
			"invprev",
			"lastinv",
			"gmod_tool",
			"gmod_toolmode"
		}
		
		for k, v in pairs(tools) do
			if bind:find(v) then return true end
		end
	end)
end
