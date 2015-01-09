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
	//Here is bad way to find rune
	
	local count = 0
	for _, v in pairs(fom_runes_list) do
		if not v.type then
			local str = string.Explode(" ", string.lower(recipe))
			local str1 = string.Explode(" ", string.lower(v.recipe))
			
			local count = 0

			if #str == #str1 then
				for _, p in pairs(str1) do
					if not string.find(string.lower(recipe), string.lower(p)) then break end
					print(p .. recipe)
					count = count + 1
				end

				if count == #str1 then return v end
				
				count = 0
			end
		end
	end
	
	return nil
end