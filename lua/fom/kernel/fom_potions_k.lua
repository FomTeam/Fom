/***
	This is base of all potions
	Here is all functions and manipulations at potions
	And adding potions

	Coded and managed by Trojan
***/

fom_potions_list = {}
fom_potions_manager = {}

//Adds potion
fom_potions_manager.AddPotion = function(tab)
	table.insert(fom_potions_list, tab)
	return tab
end

//Checks all potions and returns it if found one
fom_potions_manager.GetPotionByName = function(name)
	for k, v in pairs(fom_potions_list) do
		if string.lower(v.name) == string.lower(name) then return v end
	end
	
	return nil
end

//Checks all potions and returns it if found one
fom_potions_manager.GetPotionByRecipe = function(recipe)
	local str = string.Explode(" ", string.lower(recipe))
	local count = 0

	for _, v in pairs(fom_potions_list) do
		local str1 = string.Explode(" ", string.lower(v.recipe))
	
		if #str == #str1 then
			for _, p in pairs(str1) do
				if not string.find(string.lower(recipe), string.lower(p)) then break end
				
				//Crutch! This is crutch!
				count = count + 1
			end
			
			if count == #str1 then return v end
			
			count = 0
		end
	end
	
	return nil
end


