if CLIENT then return end

--[[
	Main core of mod, functions for interacting with enviroment
	Used by all parts of it (potions, runes, etc...)
	
	Coded and managed by [G - P.R.O]EgrOnWire
]]--

fom_magic_manager = {}

--[[Constants]]--
fom_magic_manager.outdoor_temp = 20

--[[Heal in sphere function]]--
fom_magic_manager.HealInSphere = function(position, radius, amount)
	for k, v in pairs(ents.FindInSphere(position, radius)) do
			if v:IsPlayer() then v:Kill() end
	end
end

--[[Damage in sphere function]]--

--[[
List of all damages:

DMG_GENERIC	0	Generic damage
DMG_CRUSH	1	Caused by physics interaction
DMG_BULLET	2	Bullet damage
DMG_SLASH	4	Sharp objects, such as Manhacks or other NPCs attacks
DMG_BURN	8	Damage from fire
DMG_VEHICLE	16	Hit by a vehicle
DMG_FALL	32	Fall damage
DMG_BLAST	64	Explosion damage
DMG_CLUB	128	Crowbar damage
DMG_SHOCK	256	Electrical damage, shows smoke at the damage position
DMG_SONIC	512	Sonic damage,used by the Gargantua and Houndeye NPCs
DMG_ENERGYBEAM	1024	Laser
DMG_NEVERGIB	4096	Don't create gibs
DMG_ALWAYSGIB	8192	Always create gibs
DMG_DROWN	16384	Drown damage
DMG_PARALYZE	32768	Same as DMG_POISON
DMG_NERVEGAS	65536	Neurotoxin damage
DMG_POISON	131072	Poison damage
DMG_ACID	1048576	
DMG_AIRBOAT	33554432	Airboat gun damage
DMG_BLAST_SURFACE	134217728	This won't hurt the player underwater
DMG_BUCKSHOT	536870912	The pellets fired from a shotgun
DMG_DIRECT	268435456	
DMG_DISSOLVE	67108864	Forces the entity to dissolve on death
DMG_DROWNRECOVER	524288	Damage applied to the player to restore health after drowning
DMG_PHYSGUN	8388608	Damage done by the gravity gun
DMG_PLASMA	16777216	Dissolve anything, like combine ball
DMG_PREVENT_PHYSICS_FORCE	2048	
DMG_RADIATION	262144	Radiation
DMG_REMOVENORAGDOLL	4194304	Don't create a ragdoll on death
DMG_SLOWBURN	2097152	Same as DMG_BURN
]]--

fom_magic_manager.DamageInSphere = function(position, radius, dtype, amount)
	local dmg = DamageInfo()
	dmg:SetDamage(amount)
	dmg:SetDamageType(dtype)
	for k, v in pairs(ents.FindInSphere(position, radius)) do
		if v:IsPlayer() then v:Kill() end
	end
end