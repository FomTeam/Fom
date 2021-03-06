/***
	Hashtab of ingredients
	Model / Name
	Made by Mr. Mind
	Added more ingredients by Trojan
	
	Total 300 more models and 33 ingredients
	
	This list is used for cauldron
	
	Ingredients:
		CombMet
		Titan
		Aluminium
		Tin
		Brass
		Gunpowder
		Flesh
		Glass
		Alien_Flesh
		Rotten_Flesh
		Wood
		Iron
		Bone
		Paper
		Ceramics
		Copper
		Lead
		Skull
		Petrol
		Rubber
		Rusted_Tin
		Rusted_Iron
		Paint
		Spine
		Leather
		Plastic
		Stone
		Concrete
		Gold
		Platinum
		Palladium
		Silver
		Tungsten
		Steel
		Snow
***/

function fom_GetIngredient(ent)
	return fom_ingredients_list[string.lower(ent:GetModel())]
end

fom_ingredients_list = {
	//HL2 and GMOD
	
	["models/gman_high.mdl"] = "Flesh Bone",
	["models/gibs/hgibs.mdl"] = "Skull",
	["models/gibs/hgibs_rib.mdl"] = "Bone",
	["models/gibs/hgibs_scapula.mdl"] = "Bone",
	["models/gibs/hgibs_spine.mdl"] = "Spine",
	["models/gibs/fast_zombie_legs.mdl"] = "Rotten_Flesh Bone",
	["models/gibs/fast_zombie_torso.mdl"] = "Rotten_Flesh Bone",
	["models/gibs/antlion_gib_Large_2.mdl"] = "Alien_Flesh",
	["models/props_c17/briefcase001a.mdl"] = "Leather",
	["models/props_c17/suitcase_passenger_Physics.mdl"] = "Leather",
	["models/props_junk/shoe001a.mdl"] = "Leather",
	["models/props_c17/suitcase001a.mdl"] = "Leather",
	["models/props_c17/cashregister01a.mdl"] = "Iron",
	["models/props_c17/computer01_keyboard.mdl"] = "Plastic",
	["models/props_c17/doll01.mdl"] = "Plastic",
	["models/props_c17/consolebox05a.mdl"] = "Plastic Gold Rubber Lead Tin Copper",
	["models/props_c17/consolebox03a.mdl"] = "Plastic Gold Rubber Lead Tin Copper",
	["models/props_c17/consolebox01a.mdl"] = "Plastic Gold Rubber Lead Tin Copper",
	["models/props_c17/lamp001a.mdl"] = "Ceramics",
	["models/props_c17/playground_swingset_seat01a.mdl"] = "Wood",
	["models/props_c17/playground_teetertoter_stan.mdl"] = "Iron",
	["models/props_c17/playgroundTick-tack-toe_block01a.mdl"] = "Wood",
	["models/props_c17/trappropeller_lever.mdl"] = "Rusted_Iron",
	["models/props_c17/streetsign001c.mdl"] = "Iron",
	["models/props_c17/streetsign002b.mdl"] = "Iron",
	["models/props_c17/streetsign003b.mdl"] = "Iron",
	["models/props_c17/streetsign004e.mdl"] = "Iron",
	["models/props_c17/streetsign004f.mdl"] = "Iron",
	["models/props_c17/streetsign005b.mdl"] = "Iron",
	["models/props_c17/streetsign005c.mdl"] = "Iron",
	["models/props_c17/streetsign005d.mdl"] = "Iron",
	["models/props_c17/tv_monitor01.mdl"] = "Plastic",
	["models/props_combine/breenglobe.mdll"] = "Plastic",
	["models/props_combine/breenbust.mdl"] = "Concrete",
	["models/props_junk/CinderBlock01a.mdl"] = "Concrete",
	["mmodels/props_docks/dock01_cleat01a.mdl"] = "Concrete",
	["models/props_canal/mattpipe.mdl"] = "Rusted_Iron",
	["models/props_c17/tools_wrench01a.mdl"] = "Iron",
	["models/props_combine/health_charger001.mdl"] = "CombMet",
	["models/props_junk/garbage_bag001a.mdl"] = "Paper",
	["models/props_junk/garbage_coffeemug001a.mdl"] = "Ceramics",
	["models/props_junk/terracotta01.mdl"] = "Ceramics",
	["models/props_lab/cactus.mdl"] = "Ceramics Plant",
	["models/props_junk/trafficCone001a.mdl"] = "Plastic",
	["models/props_junk/garbage_coffeemug001a.mdl"] = "Ceramics",
	["models/props_junk/garbage_milkcarton001a.mdl"] = "Plastic",
	["models/props_junk/plasticbucket001a.mdl"] = "Plastic",
	["models/props_junk/garbage_plasticbottle001a.mdl"] = "Plastic",
	["models/props_junk/garbage_plasticbottle002a.mdl"] = "Plastic",
	["models/props_junk/garbage_plasticbottle003a.mdl"] = "Plastic",
	["models/props_junk/garbage_takeoutcarton001a.mdl"] = "Paper",
	["models/props_junk/garbage_milkcarton001a.mdl"] = "Plastic",
	["models/props_junk/garbage_newspaper001a.mdl"] = "Paper",
	["models/props_lab/binderblue.mdl"] = "Paper",
	["models/props_lab/binderbluelabel.mdl"] = "Paper",
	["models/props_lab/bindergraylabel01a.mdl"] = "Paper",
	["models/props_lab/bindergreen.mdl"] = "Paper",
	["models/props_lab/bindergraylabel01b.mdl"] = "Paper",
	["models/props_lab/bindergreenlabel.mdl"] = "Paper",
	["models/props_lab/binderredlabel.mdl"] = "Paper",
	["models/props_lab/box01a.mdl"] = "Paper",
	["models/props_lab/box01b.mdl"] = "Paper",
	["models/props_lab/clipboard.mdl"] = "Paper",
	["models/props_lab/frame002a.mdl"] = "Wood",
	["models/props_lab/box01b.mdl"] = "Paper",
	["models/props_combine/suit_charger001.mdl"] = "CombMet",
	["models/props_junk/garbage_metalcan001a.mdl"] = "Rusted_Tin",
	["models/props_junk/garbage_metalcan002a.mdl"] = "Rusted_Tin",
	["models/props_junk/metalbucket01a.mdl"] = "Iron",
	["models/props_junk/metalbucket02a.mdl"] = "Iron",
	["models/props_junk/metal_paintcan001a.mdl"] = "Iron Paint",
	["models/props_junk/metal_paintcan001b.mdl"] = "Iron Paint",
	["models/props_junk/gascan001a.mdl"] = "Petrol Iron",
	["models/props_junk/metalgascan.mdl"] = "Iron",
	["models/props_junk/propanecanister001a.mdl"] = "Iron",
	["models/props_vehicles/carparts_tire01a.mdl"] = "Rubber",
	["models/props_vehicles/tire001c_car.mdl"] = "Rubber",
	["models/props_wasteland/panel_leverHandle001a.mdl"] = "Iron",
	["models/props_wasteland/prison_lamp001c.mdl"] = "Iron",
	["models/props_vehicles/carparts_wheel01a.mdl"] = "Rubber Iron",
	["models/props_lab/hevplate.mdl"] = "Titan",
	["models/props_lab/partsbin01.mdl"] = "Iron",
	["models/props_trainstation/trainstation_ornament002.mdl"] = "Iron",
	["models/props_lab/jar01a.mdl"] = "Plastic",
	["models/props_lab/jar01b.mdl"] = "Plastic",
	["models/props_lab/huladoll.mdl"] = "Plastic",
	["models/props_trainstation/payphone_reciever001a.mdl"] = "Iron",	
	["models/props_junk/popcan01a.mdl"] = "Aluminium",
	["models/props_junk/sawblade001a.mdl"] = "Iron",
	["models/props_interiors/pot01a.mdl"] = "Iron",
	["models/props_interiors/pot02a.mdl"] = "Iron",
	["models/props_junk/plasticcrate01a.mdl"] = "Plastic",
	["models/props_junk/meathook001a.mdl"] = "Rusted_Iron",
	["models/props_vehicles/carparts_door01a.mdl"] = "Iron",
	["models/props_borealis/door_wheel001a.mdl"] = "Iron",
	["models/combine_helicopter/helicopter_bomb01.mdl"] = "CombMet Gunpowder",
	["models/props_junk/propane_tank001a.mdl"] = "Propane Iron",
	["models/props_c17/metalpot001a.mdl"] = "Rusted_Iron",
	["models/props_c17/metalpot002a.mdl"] = "Rusted_Iron",
	["models/props_interiors/refrigeratordoor02a.mdl"] = "Iron",
	["models/props_lab/tpplug.mdl"] = "Copper Iron Titan",
	["models/props_lab/tpplugholder_single.mdl"] = "Copper Iron Titan",
	["models/props_lab/tpplugholder.mdl"] = "Copper Iron Titan",
	["models/props_junk/glassbottle01a.mdl"] = "Glass",
	["models/props_junk/glassjug01.mdl"] = "Glass",
	["models/props_junk/garbage_glassbottle001a.mdl"] = "Glass",
	["models/props_junk/garbage_glassbottle002a.mdl"] = "Glass",
	["models/props_junk/garbage_glassbottle003a.mdl"] = "Glass",
	["models/props_junk/watermelon01.mdl"] = "Melon",
	["models/gibs/wood_gib01a.mdl"] = "Wood",
	["models/gibs/wood_gib01b.mdl"] = "Wood",
	["models/gibs/wood_gib01c.mdl"] = "Wood",
	["models/gibs/wood_gib01d.mdl"] = "Wood",
	["models/gibs/wood_gib01e.mdl"] = "Wood",
	["models/props_c17/frame002a.mdl"] = "Wood",
	["models/props_lab/bewaredog.mdl"] = "Iron",
	["models/items/item_item_crate_chunk09.mdl"] = "Wood",
	["models/items/item_item_crate_chunk08.mdl"] = "Wood",
	["models/items/item_item_crate_chunk07.mdl"] = "Wood",
	["models/items/item_item_crate_chunk06.mdl"] = "Wood",
	["models/items/item_item_crate_chunk05.mdl"] = "Wood",
	["models/items/item_item_crate_chunk02.mdl"] = "Wood",
	["models/items/item_item_crate_chunk01.mdl"] = "Wood",
	["models/props_phx/construct/wood/wood_boardx1.mdl"] = "Wood",
	["models/items/item_item_crate.mdl"] = "Wood",
	["models/props_c17/furnitureshelf001b.mdl"] = "Wood",
	["models/items/combine_rifle_ammo01.mdl"] = "CombMet Energy",
	["models/items/battery.mdl"] = "Iron Copper Energy",
	["models/items/healthkit.mdl"] = "CombMet Heal",
	["models/healthvial.mdl"] = "CombMet Heal",
	["models/headcrabclassic.mdl"] = "Alien_Flesh",
	["models/headcrab.mdl"] = "Alien_Flesh",
	["models/headcrabblack.mdl"] = "Alien_Flesh",
	["models/items/combine_rifle_cartridge01.mdl"] = "CombMet Energy",
	["models/items/crossbowrounds.mdl"] = "Iron",
	["models/items/ar2_grenade.mdl"] = "Iron Gunpowder",
	["models/items/grenadeAmmo.mdl"] = "Iron Gunpowder",
	["models/items/boxbuckshot.mdl"] = "Lead Gunpowder Paper Brass",
	["models/items/boxmrounds.mdl"] = "Copper Lead Gunpowder Brass",
	["models/items/boxsrounds.mdl"] = "Copper Lead Gunpowder Brass",
	["models/items/357ammo.mdl"] = "Copper Lead Gunpowder Brass",
	["models/items/357ammobox.mdl"] = "Copper Lead Gunpowder Brass",
	["models/mossman.mdl"] = "Flesh Bone",
	["models/alyx.mdl"] = "Flesh Bone",
	["models/barney.mdl"] = "Flesh Bone",
	["models/breen.mdl"] = "Flesh Bone",
	["models/eli.mdl"] = "Flesh Bone",
	["models/kleiner.mdl"] = "Flesh Bone",
	["models/monk.mdl"] = "Flesh Bone",
	["models/odessa.mdl"] = "Flesh Bone",
	["models/vortigaunt.mdl"] = "Alien_Flesh",
	["models/humans/group01/female_01.mdl"] = "Flesh Bone",
	["models/humans/group01/female_02.mdl"] = "Flesh Bone",
	["models/humans/group01/female_03.mdl"] = "Flesh Bone",
	["models/humans/group01/female_04.mdl"] = "Flesh Bone",
	["models/humans/group01/female_06.mdl"] = "Flesh Bone",
	["models/humans/group01/female_07.mdl"] = "Flesh Bone",
	["models/humans/group01/female_08.mdl"] = "Flesh Bone",
	["models/humans/group01/female_09.mdl"] = "Flesh Bone",
	["models/humans/group02/female_01.mdl"] = "Flesh Bone",
	["models/humans/group02/female_02.mdl"] = "Flesh Bone",
	["models/humans/group02/female_03.mdl"] = "Flesh Bone",
	["models/humans/group02/female_04.mdl"] = "Flesh Bone",
	["models/humans/group02/female_06.mdl"] = "Flesh Bone",
	["models/humans/group02/female_07.mdl"] = "Flesh Bone",
	["models/humans/group01/male_01.mdl"] = "Flesh Bone",
	["models/humans/group01/male_02.mdl"] = "Flesh Bone",
	["models/humans/group01/male_03.mdl"] = "Flesh Bone",
	["models/humans/group01/male_04.mdl"] = "Flesh Bone",
	["models/humans/group01/male_05.mdl"] = "Flesh Bone",
	["models/humans/group01/male_06.mdl"] = "Flesh Bone",
	["models/humans/group01/male_07.mdl"] = "Flesh Bone",
	["models/humans/group01/male_08.mdl"] = "Flesh Bone",
	["models/humans/group01/male_09.mdl"] = "Flesh Bone",
	["models/humans/group02/male_01.mdl"] = "Flesh Bone",
	["models/humans/group02/male_02.mdl"] = "Flesh Bone",
	["models/humans/group02/male_03.mdl"] = "Flesh Bone",
	["models/humans/group02/male_04.mdl"] = "Flesh Bone",
	["models/humans/group02/male_05.mdl"] = "Flesh Bone",
	["models/humans/group02/male_06.mdl"] = "Flesh Bone",
	["models/humans/group02/male_07.mdl"] = "Flesh Bone",
	["models/humans/group02/male_08.mdl"] = "Flesh Bone",
	["models/humans/group02/male_09.mdl"] = "Flesh Bone",
	["models/humans/group03/male_01.mdl"] = "Flesh Bone",
	["models/humans/group03/male_02.mdl"] = "Flesh Bone",
	["models/humans/group03/male_03.mdl"] = "Flesh Bone",
	["models/humans/group03/male_04.mdl"] = "Flesh Bone",
	["models/humans/group03/male_05.mdl"] = "Flesh Bone",
	["models/humans/group03/male_06.mdl"] = "Flesh Bone",
	["models/humans/group03/male_07.mdl"] = "Flesh Bone",
	["models/humans/group03/male_08.mdl"] = "Flesh Bone",
	["models/humans/group03/male_09.mdl"] = "Flesh Bone",
	["models/humans/group03/female_01.mdl"] = "Flesh Bone",
	["models/humans/group03/female_02.mdl"] = "Flesh Bone",
	["models/humans/group03/female_03.mdl"] = "Flesh Bone",
	["models/humans/group03/female_04.mdl"] = "Flesh Bone",
	["models/humans/group03/female_06.mdl"] = "Flesh Bone",
	["models/humans/group03/female_07.mdl"] = "Flesh Bone",
	["models/humans/group03m/female_01.mdl"] = "Flesh Bone",
	["models/humans/group03m/female_02.mdl"] = "Flesh Bone",
	["models/humans/group03m/female_03.mdl"] = "Flesh Bone",
	["models/humans/group03m/female_04.mdl"] = "Flesh Bone",
	["models/humans/group03m/female_06.mdl"] = "Flesh Bone",
	["models/humans/group03m/female_07.mdl"] = "Flesh Bone",
	["models/humans/group03m/male_01.mdl"] = "Flesh Bone",
	["models/humans/group03m/male_02.mdl"] = "Flesh Bone",
	["models/humans/group03m/male_03.mdl"] = "Flesh Bone",
	["models/humans/group03m/male_04.mdl"] = "Flesh Bone",
	["models/humans/group03m/male_05.mdl"] = "Flesh Bone",
	["models/humans/group03m/male_06.mdl"] = "Flesh Bone",
	["models/humans/group03m/male_07.mdl"] = "Flesh Bone",
	["models/humans/group03m/male_08.mdl"] = "Flesh Bone",
	["models/humans/group03m/male_09.mdl"] = "Flesh Bone",
	["models/humans/group01/male_cheaple.mdl"] = "Flesh Bone",
	["models/humans/charple01.mdl"] = "Rotten_Flesh Bone",
	["models/humans/charple02.mdl"] = "Rotten_Flesh Bone",
	["models/humans/charple03.mdl"] = "Rotten_Flesh Bone",
	["models/humans/charple04.mdl"] = "Rotten_Flesh Bone",
	["models/humans/corpse1.mdl"] = "Rotten_Flesh Bone",
	["models/combine_super_soldier.mdl"] = "Bone CombMet Flesh",
	["models/combine_soldier_PrisonGuard.mdl"] = "Bone CombMet Flesh",
	["models/combine_soldier.mdl"] = "Bone CombMet Flesh",
	["models/police.mdl"] = "Bone CombMet Flesh",
	["models/combine_scanner.mdl"] = "CombMet",
	["models/manhack.mdl"] = "CombMet",
	["models/roller.mdl"] = "CombMet",
	["models/props_combine/combine_mine01.mdl"] = "CombMet",
	["models/zombie/classic.mdl"] = "Flesh Bone",
	["models/zombie/classic_legs.mdl"] = "Flesh Bone",
	["models/zombie/classic_torso.mdl"] = "Flesh Bone",
	["models/antlion.mdl"] = "Alien_Flesh",
	["models/zombie/poison.mdl"] = "Rotten_Flesh Bone",
	["models/gibs/airboat_broken_engine.mdl"] = "Iron Copper",
	["models/gibs/antlion_gib_large_1.mdl"] = "Alien_Flesh",
	["models/gibs/antlion_gib_large_2.mdl"] = "Alien_Flesh",
	["models/gibs/antlion_gib_large_3.mdl"] = "Alien_Flesh",
	["models/gibs/antlion_gib_medium_1.mdl"] = "Alien_Flesh",
	["models/gibs/antlion_gib_medium_2.mdl"] = "Alien_Flesh",
	["models/gibs/antlion_gib_medium_3.mdl"] = "Alien_Flesh",
	["models/gibs/antlion_gib_small_1.mdl"] = "Alien_Flesh",
	["models/gibs/antlion_gib_small_2.mdl"] = "Alien_Flesh",
	["models/gibs/antlion_gib_small_3.mdl"] = "Alien_Flesh",
	["models/gibs/glass_shard.mdl"] = "Glass",
	["models/gibs/glass_shard01.mdl"] = "Glass",
	["models/gibs/glass_shard02.mdl"] = "Glass",
	["models/gibs/glass_shard03.mdl"] = "Glass",
	["models/gibs/glass_shard04.mdl"] = "Glass",
	["models/gibs/glass_shard05.mdl"] = "Glass",
	["models/gibs/glass_shard06.mdl"] = "Glass",
	["models/gibs/gunship_gibs_eye.mdl"] = "CombMet",
	["models/gibs/gunship_gibs_sensorarray.mdl"] = "CombMet",
	["models/gibs/manhack_gib01.mdl"] = "CombMet",
	["models/gibs/manhack_gib02.mdl"] = "CombMet",
	["models/gibs/manhack_gib03.mdl"] = "CombMet",
	["models/gibs/manhack_gib04.mdl"] = "CombMet",
	["models/gibs/manhack_gib05.mdl"] = "CombMet",
	["models/gibs/manhack_gib06.mdl"] = "CombMet",
	["models/gibs/metal_gib1.mdl"] = "CombMet",
	["models/gibs/metal_gib2.mdl"] = "CombMet",
	["models/gibs/metal_gib3.mdl"] = "CombMet",
	["models/gibs/metal_gib4.mdl"] = "CombMet",
	["models/gibs/metal_gib5.mdl"] = "CombMet",
	["models/gibs/scanner_gib01.mdl"] = "CombMet",
	["models/gibs/scanner_gib02.mdl"] = "CombMet",
	["models/gibs/scanner_gib03.mdl"] = "CombMet",
	["models/gibs/scanner_gib04.mdl"] = "CombMet",
	["models/gibs/scanner_gib05.mdl"] = "CombMet",
	["models/gibs/shield_scanner_gib1.mdl"] = "CombMet",
	["models/gibs/shield_scanner_gib2.mdl"] = "CombMet",
	["models/gibs/shield_scanner_gib3.mdl"] = "CombMet",
	["models/gibs/shield_scanner_gib4.mdl"] = "CombMet",
	["models/gibs/shield_scanner_gib5.mdl"] = "CombMet",
	["models/gibs/shield_scanner_gib6.mdl"] = "CombMet",
	["models/props_wasteland/gear01.mdl"] = "Rusted_Iron",
	["models/props_wasteland/gear02.mdl"] = "Rusted_Iron",
	["models/props_wasteland/light_spotlight01_lamp.mdl"] = "Iron",
	["models/props_wasteland/light_spotlight02_lamp.mdl"] = "Iron",
	["models/props_wasteland/prison_padlock001b.mdl"] = "Iron",
	["models/props_wasteland/prison_padlock001a.mdl"] = "Iron",
	["models/props_wasteland/tram_leverbase01.mdl"] = "Rusted_Iron",
	["models/props_lab/harddrive02.mdl"] = "Plastic Gold Rubber Copper Platinum Silver",
	["models/props_lab/harddrive01.mdl"] = "Plastic Gold Rubber Copper Platinum Silver",
	["models/props_lab/monitor01a.mdl"] = "Plastic Rubber Copper Lead Glass Silver",
	["models/props_lab/monitor01b.mdl"] = "Plastic Rubber Copper Lead Glass Silver",
	["models/props_lab/monitor02.mdl"] = "Plastic Rubber Copper Lead Glass Silver",
	["models/props_lab/reciever01a.mdl"] = "Plastic Rubber Copper Silver Palladium Gold Platinum Tungsten",
	["models/props_lab/reciever01b.mdl"] = "Plastic Rubber Copper Silver Palladium Gold Platinum Tungsten",
	["models/props_lab/reciever01c.mdl"] = "Plastic Rubber Copper Silver Palladium Gold Platinum Tungsten",
	["models/props_lab/reciever01d.mdl"] = "Plastic Rubber Copper Silver Palladium Gold Platinum Tungsten",
	
	//CSS, TF2 and PHX
	
	["models/weapons/w_knife_ct.mdl"] = "Steel Rubber",
	["models/weapons/w_knife_t.mdl"] = "Steel Rubber",
	["models/weapons/w_mach_m249para.mdl"] = "Steel Plastic",
	["models/weapons/w_pist_deagle.mdl"] = "Steel Plastic",
	["models/weapons/w_pist_elite.mdl"] = "Steel Plastic",
	["models/weapons/w_pist_fiveseven.mdl"] = "Steel Plastic",
	["models/weapons/w_pist_glock18.mdl"] = "Steel Plastic",
	["models/weapons/w_pist_p228.mdl"] = "Steel Plastic",
	["models/weapons/w_pist_usp.mdl"] = "Steel Plastic",
	["models/weapons/w_rif_ak47.mdl"] = "Steel Wood",
	["models/weapons/w_rif_aug.mdl"] = "Steel Plastic",
	["models/weapons/w_rif_famas.mdl"] = "Steel Plastic",
	["models/weapons/w_rif_galil.mdl"] = "Steel Plastic",
	["models/weapons/w_rif_m4a1.mdl"] = "Steel Plastic",
	["models/weapons/w_rif_sg552.mdl"] = "Steel Plastic",
	["models/weapons/w_shot_m3super90.mdl"] = "Steel Plastic",
	["models/weapons/w_shot_xm1014.mdl"] = "Steel Plastic",
	["models/weapons/w_smg_mac10.mdl"] = "Steel Plastic",
	["models/weapons/w_smg_mp5.mdl"] = "Steel Plastic",
	["models/weapons/w_smg_p90.mdl"] = "Steel Plastic",
	["models/weapons/w_smg_tmp.mdl"] = "Steel Plastic",
	["models/weapons/w_smg_ump45.mdl"] = "Steel Plastic",
	["models/weapons/w_snip_awp.mdl"] = "Steel Plastic Glass",
	["models/weapons/w_snip_g3sg1.mdl"] = "Steel Plastic Glass",
	["models/weapons/w_snip_scout.mdl"] = "Steel Plastic Glass",
	["models/weapons/w_snip_sg550.mdl"] = "Steel Plastic Glass",
	["models/weapons/w_pist_elite_dropped.mdl"] = "Steel Plastic",
	["models/weapons/w_eq_eholster_elite.mdl"] = "Steel Plastic Rubber",
	["models/weapons/w_rif_m4a1_silencer.mdl"] = "Steel Plastic",
	["models/weapons/w_pist_elite_single.mdl"] = "Steel Plastic",
	["models/props_c17/pulleywheels_small01.mdl"] = "Iron Rubber",
	["models/props_trainstation/trainstation_ornament002.mdl"] = "Iron",
	["models/props_vehicles/tire001c_car.mdl"] = "Rubber",
	["models/props_junk/TrafficCone001a.mdl"] = "Plastic",
	["models/balloons/balloon_classicheart.mdl"] = "Rubber",
	["models/balloons/balloon_dog.mdl"] = "Rubber",
	["models/balloons/balloon_star.mdl"] = "Rubber",
	["models/dav0r/camera.mdl"] = "Iron",
	["models/maxofs2d/balloon_classic.mdl"] = "Rubber",
	["models/maxofs2d/balloon_gman.mdl"] = "Rubber",
	["models/maxofs2d/balloon_mossman.mdl"] = "Rubber",
	["models/maxofs2d/button_01.mdl"] = "Steel",
	["models/maxofs2d/button_02.mdl"] = "Steel Plastic",
	["models/maxofs2d/button_03.mdl"] = "Steel Plastic",
	["models/maxofs2d/button_04.mdl"] = "Steel Plastic Rubber Glass",
	["models/maxofs2d/button_05.mdl"] = "Steel Plastic",
	["models/maxofs2d/button_06.mdl"] = "Steel Plastic",
	["models/maxofs2d/button_slider.mdl"] = "Steel Plastic",
	["models/maxofs2d/camera.mdl"] = "Iron Plastic Glass Rubber",
	["models/maxofs2d/companion_doll.mdl"] = "Plastic",
	["models/maxofs2d/cube_tool.mdl"] = "Plastic",
	["models/maxofs2d/hover_basic.mdl"] = "Iron Glass",
	["models/maxofs2d/hover_classic.mdl"] = "Iron",
	["models/maxofs2d/hover_plate.mdl"] = "Iron",
	["models/maxofs2d/hover_propeller.mdl"] = "Steel",
	["models/maxofs2d/hover_rings.mdl"] = "Steel Glass",
	["models/maxofs2d/lamp_flashlight.mdl"] = "Glass Plastic",
	["models/maxofs2d/lamp_projector.mdl"] = "Steel Plastic Glass",
	["models/maxofs2d/light_tubular.mdl"] = "Glass Plastic",
	["models/maxofs2d/motion_sensor.mdl"] = "Glass Plastic",
	["models/maxofs2d/thruster_propeller.mdl"] = "Steel",
	["models/player/ct_gign.mdl"] = "Flesh Bone",
	["models/player/ct_sas.mdl"] = "Flesh Bone",
	["models/player/ct_urban.mdl"] = "Flesh Bone",
	["models//player/ct_gsg9.mdl"] = "Flesh Bone",
	["models/player/t_guerilla.mdl"] = "Flesh Bone",
	["models/player/t_leet.mdl"] = "Flesh Bone",
	["models//player/t_arctic.mdl"] = "Flesh Bone",
	["models/player/t_phoenix.mdl"] = "Flesh Bone",
	["models/characters/hostage_01.mdl"] = "Flesh Bone",
	["models/characters/hostage_02.mdl"] = "Flesh Bone",
	["models/characters/hostage_03.mdl"] = "Flesh Bone",
	["models/characters/hostage_04.mdl"] = "Flesh Bone",
	["models/props/cs_office/snowman_head.mdl"] = "Snow",
	["models/props/cs_office/snowman_face.mdl"] = "Snow",
	["models/props/cs_office/snowman_body.mdl"] = "Snow",
	["models/props/cs_office/water_bottle.mdl"] = "Plastic",
	["models/props/cs_assault/dollar.mdl"] = "Paper",
	["models/props/cs_assault/firehydrant.mdl"] = "Steel",
	["models/props/cs_assault/camera.mdl"] = "Iron Glass",
	["models/props/cs_assault/floodlight01.mdl"] = "Plastic Glass",
	["models/props/cs_assault/floodlight02.mdl"] = "Plastic Glass",
	["models/props/cs_assault/money.mdl"] = "Paper",
	["models/props/cs_militia/axe.mdl"] = "Wood Iron",
	["models/props/cs_militia/barstool01.mdl"] = "Wood",
	["models/props/cs_militia/bottle01.mdl"] = "Glass",
	["models/props/cs_militia/bottle02.mdl"] = "Glass",
	["models/props/cs_militia/bottle03.mdl"] = "Glass",
	["models/props/cs_militia/caseofbeer01.mdl"] = "Wood Glass",
	["models/props/cs_militia/circularsaw01.mdl"] = "Steel",
	["models/props/cs_militia/fishriver01.mdl"] = "Flesh",
	["models/props/cs_militia/newspaperstack01.mdl"] = "Paper",
	["models/props/cs_office/paper_towels.mdl"] = "Paper",
	["models/props/cs_office/phone.mdl"] = "Plastic",
	["models/props/cs_office/phone_p1.mdl"] = "Plastic",
	["models/props/cs_office/phone_p2.mdl"] = "Plastic",
	["models/props/cs_office/projector.mdl"] = "Plastic",
	["models/props/cs_office/projector_remote.mdl"] = "Plastic",
	["models/props/cs_office/radio.mdl"] = "Plastic",
	["models/props/cs_office/snowman_arm.mdl"] = "Wood",
	["models/props/cs_office/snowman_nose.mdl"] = "Melon",
	["models/props/cs_office/trash_can.mdl"] = "Paper Plastic",
	["models/props/cs_office/trash_can_p8.mdl"] = "Aluminium",
	["models/props/cs_office/water_bottle.mdl"] = "Plastic",
	["models/hunter/blocks/cube025x025x025.mdl"] = "Plastic",
	["models/hunter/blocks/cube025x05x025.mdl"] = "Plastic",
	["models/dynamite/dynamite.mdl"] = "Iron",
	["models/weapons/w_models/w_baseball.mdl"] = "Flesh",
	["models/weapons/w_models/w_bat.mdl"] = "Iron",
	["models/weapons/w_models/w_bonesaw.mdl"] = "Steel",
	["models/weapons/w_models/w_bottle.mdl"] = "Glass",
	["models/weapons/w_models/w_builder.mdl"] = "Plastic",
	["models/weapons/w_models/w_cigarette_case.mdl"] = "Plastic",
	["models/weapons/w_models/w_fireaxe.mdl"] = "Wood Iron",
	["models/weapons/w_models/w_flaregun_shell.mdl"] = "Iron",
	["models/weapons/w_models/w_frontierjustice.mdl"] = "Steel Wood",
	["models/weapons/w_models/w_grenade_grenadelauncher.mdl"] = "Iron Glass",
	["models/weapons/w_models/w_grenadelauncher.mdl"] = "Steel Wood",
	["models/weapons/w_models/w_knife.mdl"] = "Steel",
	["models/weapons/w_models/w_minigun.mdl"] = "Steel",
	["models/weapons/w_models/w_pda_engineer.mdl"] = "Plastic",
	["models/weapons/w_models/w_pistol.mdl"] = "Steel Plastic",
	["models/weapons/w_models/w_revolver.mdl"] = "Steel Plastic",
	["models/weapons/w_models/w_rocket.mdl"] = "Steel",
	["models/weapons/w_models/w_rocketlauncher.mdl"] = "Steel Wood Plastic",
	["models/weapons/w_models/w_sapper.mdl"] = "Steel",
	["models/weapons/w_models/w_scattergun.mdl"] = "Steel Wood",
	["models/weapons/w_models/w_sd_sapper.mdl"] = "Steel",
	["models/weapons/w_models/w_shovel.mdl"] = "Iron Wood",
	["models/weapons/w_models/w_smg.mdl"] = "Steel Wood Plastic",
	["models/weapons/w_models/w_sniperrifle.mdl"] = "Steel Wood Glass",
	["models/weapons/w_models/w_stickybomb.mdl"] = "Steel",
	["models/weapons/w_models/w_stickybomb2.mdl"] = "Steel",
	["models/weapons/w_models/w_stickybomb3.mdl"] = "Steel",
	["models/weapons/w_models/w_stickybomb_d.mdl"] = "Steel",
	["models/weapons/w_models/w_stickybomb_launcher.mdl"] = "Steel Plastic",
	["models/weapons/w_models/w_syringe.mdl"] = "Glass Plastic",
	["models/weapons/w_models/w_syringegun.mdl"] = "Glass Plastic",
	["models/weapons/w_models/w_toolbox.mdl"] = "Iron",
	["models/weapons/w_models/w_ttg_max_gun.mdl"] = "Steel Wood",
	["models/weapons/w_models/w_wrangler.mdl"] = "Plastic Wood",
	["models/weapons/w_models/w_wrench.mdl"] = "Iron",
	
	//Debris
	
	["models/items/car_battery01.mdl"] = "Plastic Energy Copper",
	["models/dav0r/hoverball.mdl"] = "Steel Energy",
	["models/elderscrolls/wabbajack.mdl"] = "Wood Energy",
	["models/food/burger.mdl"] = "Flesh",
	["models/food/hotdog.mdl"] = "Flesh",
	["models/props_debris/concrete_chunk03a.mdl"] = "Stone",
	["models/props_debris/concrete_chunk04a.mdl"] = "Stone",
	["models/props_debris/concrete_chunk06c.mdl"] = "Stone",
	["models/props_debris/concrete_chunk08a.mdl"] = "Stone",
	["models/props_debris/concrete_chunk09a.mdl"] = "Stone",
	["models/props_debris/rebar004b_48.mdl"] = "Stone Iron",
	["models/props_debris/rebar001a_32.mdl"] = "Iron",
	["models/props_debris/rebar001b_48.mdl"] = "Iron",
	["models/props_debris/rebar001c_64.mdl"] = "Iron",
	["models/props_debris/rebar001d_96.mdl"] = "Iron",
	["models/props_debris/rebar002a_32.mdl"] = "Iron Stone",
	["models/props_debris/rebar002b_48.mdl"] = "Iron Stone",
	["models/props_debris/rebar002c_64.mdl"] = "Iron Stone",
	["models/props_debris/rebar002d_96.mdl"] = "Iron Stone",
	["models/props_debris/rebar003a_32.mdl"] = "Iron Stone",
	["models/props_debris/rebar003b_48.mdl"] = "Iron Stone",
	["models/props_debris/rebar003c_64.mdl"] = "Iron Stone",
	["models/props_debris/rebar004a_32.mdl"] = "Iron Stone",
	["models/props_debris/rebar004b_48.mdl"] = "Iron Stone",
	["models/props_debris/rebar004c_64.mdl"] = "Iron Stone",
	["models/props_debris/rebar_cluster001a.mdl"] = "Iron",
	["models/props_debris/rebar_cluster001b.mdl"] = "Iron",
	["models/props_debris/rebar_cluster002a.mdl"] = "Iron",
	["models/props_debris/rebar_cluster002b.mdl"] = "Iron",
	["models/props_debris/tile_wall001a_chunk06.mdl"] = "Stone",
	["models/props_debris/wood_board01a.mdl"] = "Wood",
	["models/props_debris/wood_board02a.mdl"] = "Wood",
	["models/props_debris/wood_board03a.mdl"] = "Wood",
	["models/props_debris/wood_board04a.mdl"] = "Wood",
	["models/props_debris/wood_board05a.mdl"] = "Wood",
	["models/props_debris/wood_board06a.mdl"] = "Wood",
	["models/props_debris/wood_board07a.mdl"] = "Wood",
	["models/props_junk/rock001a.mdl"] = "Stone"
}

