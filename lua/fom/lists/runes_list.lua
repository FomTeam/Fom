
--[[
	Runes managemant and containment
	Use with mhands SWEP and runetable
	
	Coded and managed by [G - P.R.O]EgrOnWire
]]--

--[[
Runes must include: name, path to sprite, description string
Recipes must include: ability table like this: {"instaheal"} or {"damage1","blindess", ...}, rune1 to rune5 (default = nil, you need to have at least 1, e.g rune1="sas")
]]--
fom_rune_list = {}
fom_rune_recipe = {}
fom_rune_manager = {}


--[[Returns true if pushing the table to runetable is sucessfull]]--
fom_rune_manager.AddRune = function(na, pa, de)
	de = de or ""

	if na == nil or not isstring(na) or string.len(na) == 0 then print("Cant add rune! Name either too short, or the passed argument is not a string!") return end
	if pa == nil or not isstring(pa) or string.len(pa) == 0 then print("Cant add rune! Sprite path either too short, or the passed argument is not a string!") return end
	table.insert(fom_rune_list, {name = na, path = pa, description = de})
	return true
end

--[[Returns true if pushing the table to recipetable is sucessfull]]--
fom_rune_manager.AddRecipe = function(ab, r1, r2, r3, r4, r5)
	r1 = r1 or nil
	r2 = r2 or nil
	r3 = r3 or nil
	r4 = r4 or nil
	r5 = r5 or nil

	if not istable(ab) or table.count(ab) < 1 then print("Cant add recipe! Ability table is empty, ability is not a table, or simply does not excist!") return false end
	if not r1 and not r2 and not r3 and not r4 and not r5 then print("Cant add recipe! All runes are empty!") return false end
	table.insert(fom_recipe_list, {ability = ab, rune1 = r1, rune2 = r2, rune3 = r3, rune4 = r4, rune5 = r5})
	return true
end

fom_rune_manager.CheckRecipe = function(tab)
	--[[Shorting the name, other functions doesent need this]]--
	local frr = fom_rune_recipe
	for k, v in pairs(frr) do
		--[[As usual runes work only in correct order, for example "sa" and "wa" != "wa" and "sa"]]--
		if frr[k].rune1 == tab[k].rune1 and frr[k].rune2 == tab[k].rune2 and frr[k].rune3 == tab[k].rune3 and frr[k].rune4 == tab[k].rune4 and frr[k].rune5 == tab[k].rune5 then
			return frr[k].ability
		end
	end
	return nil --[[No special ability found, returning nothing]]--
end


--[[ Rune define list ]]--
fom_rune_manager.AddRune("af","/materials/fom/rune/rune01.vtf","Rune of fire, one of the main 4 elements.\rUsed to make destruction and chaos.")

--[[ Recipe define list ]]--