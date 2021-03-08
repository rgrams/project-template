
local MenuTitle = require "interface.MenuTitle"
local Button = require "interface.widgets.Button"
local Menu = require "interface.Menu"

local OptionsMenu = Menu:extend()
OptionsMenu.className = "OptionsMenu"

-- Button functions:
local function back(btn)
   btn.menuSwitcher:call("switchToLast")
end

local function controls(btn)
   -- btn.menuSwitcher:call("switchTo", "controlConfig")
end

local rememberLastFocus = true

function OptionsMenu.set(self)
   self.super.set(self, rememberLastFocus)
	self:makeRuu()
   self.children = {
      MenuTitle("Options"),
      Button(self.ruu, "Back", back),
      Button(self.ruu, "Controls", controls),
   }
   self.widgetIndices = {2, 3}
end

return OptionsMenu
