
local MenuTitle = require "interface.MenuTitle"
local Button = require "interface.widgets.Button"
local Menu = require "interface.Menu"

local GameOverMenu = Menu:extend()
GameOverMenu.className = "GameOverMenu"

-- Button functions:
local function restart(btn)
	btn.tree:get("/GameManager"):call("reload")
	btn.menuSwitcher:call("switchTo", nil)
end

local function options(btn)
   btn.menuSwitcher:call("switchTo", "options")
end

local function quitMenu(btn)
	btn.tree:get("/GameManager"):call("unload")
	btn.menuSwitcher:call("switchTo", "main")
end

local function quit(btn)
   btn.tree:get("/GameManager"):call("quit")
end

local rememberLastFocus = false

function GameOverMenu.set(self)
	self.super.set(self, rememberLastFocus)
	self:makeRuu()
   self.children = {
      MenuTitle("You Died"),
      Button(self.ruu, "Restart", restart),
      Button(self.ruu, "Options", options),
      Button(self.ruu, "Quit to Menu", quitMenu),
      Button(self.ruu, "Quit Game", quit)
   }
	self.widgetIndices = {2, 3, 4, 5}
end

return GameOverMenu
