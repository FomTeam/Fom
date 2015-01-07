/***
	Runes kernel
	
	Coded and managed by Trojan
***/

fom_runes_list = {}
fom_runes_manager = {}
fom_runes_manager.outdoor_temp = 20

fom_runes_manager.AddRune = function(tab)
	table.insert(fom_runes_list, tab)
	return tab
end

fom_runes_manager.GetRuneByName = function(name)
	for k, v in pairs(fom_runes_list) do
		if string.lower(v.name) == string.lower(name) then return v end
	end
	
	return nil
end

fom_runes_manager.GetRuneByRecipe = function(recipe)
	
end