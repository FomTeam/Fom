/*****
	Name
	Description
	Recipe
	Color
	Next fire time
	Sound
	Pitch
	EffFunc
	Func
	
	Coded and managed by Trojan
*****/


fom_warlock_manager.AddSpell({
	name = "Slash",
	desc = "Slashes something",
	color = Color(150, 255, 150),
	time = 0.3,
	
	func = function(wep)
		local tr = util.TraceHull {
			start = wep.Owner:GetEyeTrace(),
			endpos = wep.Owner:GetShootPos() + wep.Owner:GetAimVector() * 90,
			filter = wep.Owner,
			mins = Vector(-20, -20, -20),
			maxs = Vector(20, 20, 20)
		}
		
		local ent = tr.Entity
		
		if IsValid(ent) and (ent:IsPlayer() or ent:IsNPC()) then ent:TakeDamage(35) end
	end
})

fom_warlock_manager.AddSpell({
	name = "Heal",
	desc = "Heals you",
	color = Color(0, 0, 0),
	time = -0.3,
	sound = "npc/antlion/attack_single2.wav",
	
	efffunc = function(wep)
		local ef = EffectData()
		ef:SetStart(Vector(255, 255, 255))
		ef:SetOrigin(wep.Owner:GetPos())
		ef:SetMagnitude(0.5)
		util.Effect("fom_effect_boom", ef)
	end,
	
	func = function(wep)
		if IsValid(wep.Owner) then wep.Owner:SetHealth(math.min(wep.Owner:GetMaxHealth(), wep.Owner:Health() + 15)) end
	end
})

fom_warlock_manager.AddSpell({
	name = "Flash",
	desc = "Flashes everything",
	color = Color(0, 0, 0),
	time = 0.2,
	sound = "npc/antlion/attack_double1.wav",
	
	efffunc = function(wep)
	end,
	
	func = function(wep)
		//Sending code to client to run it
		net.Start("fom_lua")
			net.WriteString([[
				local dlight = DynamicLight(]] .. wep.Owner:EntIndex() .. [[)
				if ( dlight ) then
					dlight.pos = Vector(]] .. wep.Owner:GetPos().x .. [[, ]] .. wep.Owner:GetPos().y .. [[, ]] .. wep.Owner:GetPos().z .. [[)
					dlight.r = 255
					dlight.g = 255
					dlight.b = 255
					dlight.brightness = 0
					dlight.Decay = 1000
					dlight.Size = 700
					dlight.Style = 0
					dlight.DieTime = CurTime() + 2
				end
			]])
		net.Send(wep.Owner)
	end
})

fom_warlock_manager.AddSpell({
	name = "Time",
	desc = "Changes time",
	color = Color(255, 255, 150),
	time = 1.8,
	
	func = function(wep)
		local time = 1
		
		timer.Create("fom_change_time", 0.1, 10, function()
			time = time - 0.1
			game.SetTimeScale(time)
			
			if time <= 0.2 then
				timer.Create("fom_change_time", 0.05, 100, function()
					time = time + 0.01
					game.SetTimeScale(time)
				end)
			end
		end)
	end
})

local revive_models = {
	[""] = "",
	[""] = "",
	[""] = "",
	[""] = "",
	[""] = "",
	[""] = "",
	[""] = "",
	[""] = "",
	[""] = "",
	[""] = "",
	[""] = "",
	[""] = "",
	[""] = "",
	[""] = "",
	[""] = "",
	[""] = "",
	[""] = "",
	[""] = "",
	[""] = "",
	[""] = "",
	[""] = "",
	[""] = "",
	[""] = "",
	[""] = "",
	[""] = "",
	[""] = "",
	[""] = "",
	[""] = ""
}
fom_warlock_manager.AddSpell({
	name = "Revive all",
	desc = "Revives all",
	color = Color(0, 0, 0),
	time = 2.5,
	
	efffunc = function() end,
	
	func = function(wep)
		for k, v in pairs(ents.FindByClass("prop_ragdoll")) do
			if revive_models[v:GetModel()] then
				local npc = ents.Create(revive_models[v:GetModel()])
				npc:SetPos(v:GetPos())
				npc:Spawn()
				
				SafeRemoveEntity(v)
			end
		end
	end
})

fom_warlock_manager.AddSpell({
	name = "Reduce time of making potion",
	desc = "Reduce potion making time",
	color = Color(0, 255, 255),
	time = 2.5,
	
	func = function(wep)
		local tr = util.TraceHull {
			start = wep.Owner:GetEyeTrace(),
			endpos = wep.Owner:GetShootPos() + wep.Owner:GetAimVector() * 90,
			filter = wep.Owner,
			mins = Vector(-20, -20, -20),
			maxs = Vector(20, 20, 20)
		}
		
		local ent = tr.Entity
		
		if IsValid(ent) and ent:GetClass() == "fom_cauldron" then
			ent.POTION_MAKING_TIME = 5
			
			timer.Create("fom_change_time_c" .. ent:EntIndex(), 15, 1, function()
				if IsValid(ent) then ent.POTION_MAKING_TIME = 0 end
			end)
		end
	end
})