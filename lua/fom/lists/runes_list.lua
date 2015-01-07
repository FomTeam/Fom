/***
	Runes
	
	Types:
		def, rune without recipe
		std, rune with recipe
	
	Coded and managed by Trojan
***/

fom_runes_manager.AddRune({
	name = "Damage",
	type = "def",
	
	func = function(ent)
		ent:TakeDamage(2)
	end
})

fom_runes_manager.AddRune({
	name = "Heal",
	type = "def",

	func = function(ent)
		if ent:IsNPC() or ent:IsPlayer() then ent:SetHealth(math.min(ent:GetMaxHealth(), ent:Health() + 1)) end
	end
})

fom_runes_manager.AddRune({
	name = "Acid",
	type = "def",

	func = function(ent)
		if ent:IsPlayer() or ent:IsNPC() then 
			timer.Create("fom_runes_acid" .. ent:EntIndex(), 1, 10, function()
				if IsValid(ent) then 
					ent:TakeDamage(5)
				end
			end)
		end
	end
})

fom_runes_manager.AddRune({
	name = "Blast",
	type = "def",

	func = function(ent)
		local ef = EffectData()
		ef:SetOrigin(ent:GetPos())
		util.Effect("Explosion", ef)
		
		util.BlastDamage(ent, ent, ent:GetPos(), 200, 15)
	end
})

fom_runes_manager.AddRune({
	name = "Fire",
	type = "def",
	
	func = function(ent)
		ent:Ignite(5, 20)
	end
})



/*********************************************************************************************************************************************/

fom_runes_manager.AddRune({
	name = "Cutter",
	recipe = "Damage Heal",
	
	func = function(ent)
		ent:TakeDamage(60)
	end
})

fom_runes_manager.AddRune({
	name = "Max Cutter",
	recipe = "Blast Damage Damage Heal",
	
	func = function(ent)
		ent:TakeDamage(90)
	end
})