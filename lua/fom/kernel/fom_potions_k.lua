/***
	This is base of all potions
	Here is all functions and manipulations at potions
	And adding potions

	Coded and managed by Trojan
***/

fom_potions_list = {}
fom_potions_manager = {}

//This function checks for potions with same recipes
fom_potions_manager.CheckPotion = function(tab)
	if type(tab.recipe) == "string" then
		if fom_potions_manager.GetPotionByRecipe(tab.recipe) then return true end
	elseif type(tab.recipe) == "table" then
		for _, r in pairs(tab.recipe) do
			if fom_potions_manager.GetPotionByRecipe(r) then return true end
		end
	end
	
	return false
end

//Adds potion
fom_potions_manager.AddPotion = function(tab)
	if fom_potions_manager.CheckPotion(tab) then print("FOM: Potion '" .. tab.name .. "' was not added! Reason: this potion is already exists!") return {} end
	
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

local function findRecipe(potion, recipe, crecipe)
	local str = string.Explode(" ", string.lower(crecipe))
	local str1 = string.Explode(" ", string.lower(recipe))
	
	local count = 0

	if #str == #str1 then
		for _, p in pairs(str1) do
			if not string.find(string.lower(crecipe), string.lower(p)) then break end
					
			count = count + 1
		end
		
		if count == #str1 then return potion end
		
		count = 0
	end
	
	return nil
end

//Checks all potions and returns it if found one
fom_potions_manager.GetPotionByRecipe = function(recipe)
	local str = string.Explode(" ", string.lower(recipe))

	//Here is bad way to find potion
	local count = 0
	for _, v in pairs(fom_potions_list) do
		if type(v.recipe) == "string" then
			local result = findRecipe(v, v.recipe, recipe)
			if result then return result end
		elseif type(v.recipe) == "table" then
			for _, r in pairs(v.recipe) do
				local result = findRecipe(v, r, recipe)
				if result then return result end
			end
		end
	end
	
	return nil
end


