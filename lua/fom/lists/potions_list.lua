/*****
	Name
	Description
	Recipe
	Collision function(potion flask, position)
	Color
	Time
	
	UseFunc(ply)
	
	Coded and managed by Trojan
	
	P.S Recipe may be a table if you want
*****/


fom_potions_manager.AddPotion({
	name = "Time potion",
	desc = "Slowing time",
	recipe = "Rubber Paper CombMet",
	color = Color(150, 150, 150),
	time = 18,
	
	CollisionFunc = function(ent, pos)
		game.SetTimeScale(0.1)
		
		timer.Create("fom_set_time", 3, 1, function() game.SetTimeScale(1) end)
	end
})

fom_potions_manager.AddPotion({
	name = "Kill potion",
	desc = "Kills enemy",
	recipe = "Skull Bone Flesh Rusted_Iron",
	color = Color(255, 0, 0),
	time = 20,
	
	UseFunc = function(ply)
		if ply:IsPlayer() then ply:Kill() end
	end,
	
	CollisionFunc = function(ent, pos)
		for k, v in pairs(ents.FindInSphere(ent:GetPos(), 150)) do
			if v:IsPlayer() then v:Kill() end
			if v:IsNPC() then v:Fire("sethealth", "0", 0) end
		end
	end
})

fom_potions_manager.AddPotion({
	name = "Heal potion",
	desc = "Heals",
	recipe = "Bone Titan Skull Iron",
	color = Color(255, 255, 255),
	time = 12,
	
	CollisionFunc = function(ent, pos)
		for k, v in pairs(ents.FindInSphere(ent:GetPos(), 150)) do
			if v:IsPlayer() then v:SetHealth(math.min(v:GetMaxHealth(), v:Health() + 20)) end
		end
	end
})

fom_potions_manager.AddPotion({
	name = "Damage potion",
	desc = "Damages smomething",
	recipe = "Leather Glass Wood",
	color = Color(255, 0, 255),
	time = 5,
	
	UseFunc = function(ply)
		if IsValid(ply) then ply:TakeDamage(20) end
	end,
	
	CollisionFunc = function(ent, pos)
		for k, v in pairs(ents.FindInSphere(ent:GetPos(), 150)) do
			if IsValid(v) and (v:IsNPC() or v:IsPlayer()) then v:TakeDamage(20) end
		end
	end
})

fom_potions_manager.AddPotion({
	name = "Ultra damage potion",
	desc = "Damages smomething",
	recipe = "Leather Glass Wood Wood Wood",
	color = Color(255, 100, 255),
	time = 10,
	
	UseFunc = function(ply)
		if IsValid(ply) then ply:TakeDamage(40) end
	end,
	
	CollisionFunc = function(ent, pos)
		for k, v in pairs(ents.FindInSphere(ent:GetPos(), 150)) do
			if IsValid(v) and (v:IsNPC() or v:IsPlayer()) then v:TakeDamage(40) end
		end
	end
})

fom_potions_manager.AddPotion({
	name = "Secret potion",
	desc = "asdsadasd",
	recipe = "Leather Leather Leather Leather Leather Wood",
	color = Color(255, 255, 120),
	time = 25,
	
	UseFunc = function(ply)
		if IsValid(ply) then ply:TakeDamage(999) end
	end,
	
	CollisionFunc = function(ent, pos)
		for k, v in pairs(ents.FindInSphere(ent:GetPos(), 450)) do
			if IsValid(v) and (v:IsNPC() or v:IsPlayer()) then v:TakeDamage(999) end
		end
	end
})

fom_potions_manager.AddPotion({
	name = "Fire potion",
	desc = "Ignites something",
	recipe = "Wood Bone",
	color = Color(255, 150, 0),
	time = 8,
	
	UseFunc = function(ply)
		if IsValid(ply) then ply:Ignite(5) end
	end,
	
	CollisionFunc = function(ent, pos)
		for k, v in pairs(ents.FindInSphere(ent:GetPos(), 650)) do
			if IsValid(v) then v:Ignite(10) end
		end
	end
})

fom_potions_manager.AddPotion({
	name = "Extinguish potion",
	desc = "Extinguishes something",
	recipe = "Bone Bone Wood Iron",
	color = Color(0, 255, 255),
	time = 8,
	
	UseFunc = function(ply)
		if IsValid(ply) then ply:Extinguish() end
	end,
	
	CollisionFunc = function(ent, pos)
		for k, v in pairs(ents.FindInSphere(ent:GetPos(), 650)) do
			if IsValid(v) then v:Extinguish() end
		end
	end
})

fom_potions_manager.AddPotion({
	name = "Power potion",
	desc = "Throwes",
	recipe = { [1] = "Wood Wood Wood Wood", [2] = "Wood Iron Iron Wood" },
	color = Color(0, 0, 255),
	time = 15,
	
	UseFunc = function(ply)
		if IsValid(ply) then ply:SetJumpPower(700) end
	end,
	
	CollisionFunc = function(ent, pos)
		for k, v in pairs(ents.FindInSphere(ent:GetPos(), 650)) do
			if IsValid(v) and IsValid(v:GetPhysicsObject()) then v:SetVelocity((v:GetPos() - pos):GetNormal() * 1500) end
		end
	end
})

fom_potions_manager.AddPotion({
	name = "Disintegrator potion",
	desc = "Throwes",
	recipe = { [1] = "Iron Gold CombMet Steel", [2] = "Iron Iron Iron Iron Steel CombMet", [3] = "Iron Steel CombMet CombMet CombMet" },
	color = Color(255, 255, 0),
	time = 25,
	
	UseFunc = function(ply)
		if IsValid(ply) then ply:Kill() end
	end,
	
	CollisionFunc = function(ent, pos)
		for k, v in pairs(ents.FindInSphere(ent:GetPos(), 650)) do
			if IsValid(v) and (v:IsNPC() or v:IsPlayer()) then 
				local dmg = DamageInfo()
				dmg:SetDamage(1500)
				dmg:SetAttacker(ent)
				dmg:SetInflictor(ent)
				dmg:SetDamageType(DMG_DISSOLVE)
				v:TakeDamageInfo(dmg)
				
				local ef = EffectData()
				ef:SetOrigin(v:GetPos())
				util.Effect("Explosion", ef)
				
				SafeRemoveEntity(ent)
			end
		end
	end
})