/***
	Unites all parts and branches of this addon
	
	
	Coded and managed by Trojan
***/

if SERVER then return end

local fom_magic_entities = {}

//This function adds entity to spawnmenu (Q menu)
//give_type, icon and type is default variables
//Here is only two give_types weapon and entity!
function _addMagicEntity(name, code, type, give_type, icon)
	icon = icon or "icon16/page_white.png" //Default icon
	type = type or "fom_entity"	//Default type
	give_type = give_type or "entity" //Default give type

	local entity = { name = name, code = code, type = type, give_type = give_type, icon = icon }
	table.insert(fom_magic_entities, entity)
	
	return entity
end

//Use this function to add new guide to Help category
local guides = {}
function fom_spawnmenuaddinfotab(icon, name, text)
	local new_guide = { icon = icon, name = name, text = text }
	table.insert(guides, new_guide)
	
	return new_guide
end

function fom_spawnmenuaddtab(icon, name, content, tree, tab)
	local folder = tree:AddNode(name,icon)
	folder.DoPopulate = function(self)
		if self.SpawnPanel then return end

		self.SpawnPanel = vgui.Create("ContentContainer", tab)
		self.SpawnPanel:SetVisible(false)
		self.SpawnPanel:SetTriggerSpawnlistChange(false)

		for k, v in pairs(fom_magic_entities) do
			if v.type == content then spawnmenu.CreateContentIcon("fom_entity", self.SpawnPanel, v) end
		end
	end
	folder.DoClick = function(self)
		self:DoPopulate()
		tab:SwitchPanel(self.SpawnPanel)
	end
end

spawnmenu.AddContentType("fom_entity", function(cnt, obj)
	if not obj.name then return end

	local icon = vgui.Create("ContentIcon", cnt)
	icon:SetContentType("fom_entity")
	icon:SetName(obj.name)
	if obj.icon then icon:SetMaterial(obj.icon) end
	icon.DoClick = function()
		if obj.give_type == "weapon" then
			RunConsoleCommand("gm_giveswep", obj.code)
			//surface.PlaySound("garrysmod/content_downloaded.wav")
		elseif obj.give_type == "entity" then
			RunConsoleCommand("gm_spawnsent", obj.code)
			surface.PlaySound("garrysmod/content_downloaded.wav")
		end
	end
	
	icon.PaintOver = function(self, w, h)
		if self.icon then
			surface.SetMaterial(self.icon)
			surface.DrawTexturedRect(self.Border + 8, self.Border + 8, 16, 16)
		end
	end

	cnt:Add(icon)

	return icon
end)


spawnmenu.AddCreationTab("Magic", function()
	local tab = vgui.Create("SpawnmenuContentPanel")
	
	local tree = tab.ContentNavBar.Tree
	
	//Misc
	local folder_misc = tree:AddNode("Misc", "icon16/attach.png")
	fom_spawnmenuaddtab("icon16/book_open.png", "Black Magic", "fom_warlock", folder_misc, tab)
	fom_spawnmenuaddtab("icon16/wand.png", "Magic weapons", "fom_weapon", folder_misc, tab)
	fom_spawnmenuaddtab("icon16/bricks.png", "Magic items", "fom_entity_stuff", folder_misc, tab)
	
	//Alchemy
	local folder_alchemy = tree:AddNode("Alchemy", "icon16/ruby.png")
	fom_spawnmenuaddtab("icon16/pill.png", "Flasks", "fom_flasks", folder_alchemy, tab)
	fom_spawnmenuaddtab("icon16/box.png", "Alchemist's stuff", "fom_entity", folder_alchemy, tab)
	
	//Help and guides
	local folder_help = tree:AddNode("Help", "icon16/information.png")
	for k, v in pairs(guides) do
		local guide = folder_help:AddNode(v.name, v.icon)
		guide.DoPopulate = function(self)
			if self.SpawnPanel then return end
			
			self.SpawnPanel = vgui.Create("DPanel", tab)
			local helptext = vgui.Create("DLabel", self.SpawnPanel)
			
			helptext:SetText(v.text)
			helptext:SetFont("DefaultFixed")
			helptext:SetPos(25, 25)
			helptext:SizeToContents()
			helptext:SetColor(Color(0, 0, 0))
		end
		guide.DoClick = function(self)
			self:DoPopulate()
			tab:SwitchPanel(self.SpawnPanel)
		end
	end
	
	//Open all tabs
	folder_help:SetExpanded(true)
	folder_misc:SetExpanded(true)
	folder_alchemy:SetExpanded(true)
	
	return tab
end, "icon16/color_wheel.png", 200)



