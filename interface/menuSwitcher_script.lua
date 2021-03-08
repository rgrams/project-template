
-- A script to manage switching between different menus.

-- loadMenus() will instantiate the menus, adding them to the object the script is on.

local script = {}

local maxHistorySteps = 10

-- menus = { [name] = Class, ...}
function script.loadMenus(self, menus, startMenuName)
	self.menus = {}
	for name, MenuClass in pairs(menus) do
		local menu = MenuClass()
		self.menus[name] = menu
		self.tree:add(menu, self)
		if name ~= startMenuName then
			menu:call("setEnabled", false)
		end
	end
	self.menuStack = { startMenuName }
end

function script.switchToLast(self)
	script.switchTo(self, self.menuStack[2])
end

function script.switchTo(self, newMenuName)
	local curMenuName = self.menuStack[1]
	if curMenuName ~= newMenuName then
		table.insert(self.menuStack, 1, newMenuName)
		self.menuStack[maxHistorySteps + 1] = nil
		local oldMenu = self.menus[curMenuName]
		if oldMenu then  oldMenu:call("setEnabled", false)  end
		if not newMenuName then -- No menu, turning menu off.
			return
		else
			local newMenu = self.menus[newMenuName]
			if not newMenu then
				print("Error - menuSwitcher.switchTo, invalid menu name: "..tostring(newMenuName))
			else
				newMenu:call("setEnabled", true)
			end
		end
	end
end

return script
