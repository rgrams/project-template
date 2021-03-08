
local Menu_interface = require "interface.widgets.Menu_interface"
local Menu = gui.Column:extend()
Menu.className = "Menu"
Menu:implements(Menu_interface)

local spacing = 20
local widthFraction, heightFraction = 0.5, 0.8

function Menu.init(self)
	Menu.super.init(self)
	self:mapWidgets(self.widgetIndices)
end

function Menu.set(self, rememberLastFocus)
	Menu.super.set(self, spacing)
	local w, h = love.window.getMode()
   w, h = w * widthFraction, h * heightFraction
	self:size(w, h)
	self.layer = "gui"
	self.rememberLastFocus = rememberLastFocus
end

return Menu
