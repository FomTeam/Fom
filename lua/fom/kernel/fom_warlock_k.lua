/***
	Here is spells list
	This is very simple kernel
	I hope you have not got confusions
	
	Coded and managed by Trojan
***/

fom_spells_list = {}
fom_warlock_manager = {}

if CLIENT then
	//Running received code on client side
	net.Receive("fom_lua", function()
		local code = net.ReadString()
		RunString(code)
	end)
else
	util.AddNetworkString("fom_lua")
end

fom_warlock_manager.AddSpell = function(tab)
	table.insert(fom_spells_list, tab)
	return tab
end


