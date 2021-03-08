
local theme = require "interface.theme.theme"

local wrapWidth = 600

local function MenuTitle(text)
	local self = gui.Text(text, theme.fnt.menuTitle, 0, 0, 0, wrapWidth, "C", "C", "center")
	return self
end

return MenuTitle
