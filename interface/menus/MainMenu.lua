
local MenuTitle = require "interface.MenuTitle"
local Button = require "interface.widgets.Button"
local Menu = require "interface.Menu"

local MainMenu = Menu:extend()
MainMenu.className = "MainMenu"

-- Button functions:
local function play(btn)
	btn.tree:get("/GameManager"):call("load")
	btn.menuSwitcher:call("switchTo", nil)
end

local function options(btn)
   btn.menuSwitcher:call("switchTo", "options")
end

local function quit(btn)
	btn.tree:get("/GameManager"):call("quit")
end

local rememberLastFocus = true

function MainMenu.set(self)
   self.super.set(self, rememberLastFocus)
	self:makeRuu()
   self.children = {
      MenuTitle("Main Menu"),
      Button(self.ruu, "Play", play),
      Button(self.ruu, "Options", options),
      Button(self.ruu, "Quit", quit),
   }
	self.widgetIndices = {2, 3, 4}
end

return MainMenu
