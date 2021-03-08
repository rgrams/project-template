
-- { "button", combo, actionName }
-- { "axis", -combo, +combo, actionName }
local M = {
	{ "button", "enter", "confirm" },
	{ "axis", "left", "right", "move x" },
	{ "button", "up", "up" },
	{ "button", "down", "down" },
	{ "button", "left", "left" },
	{ "button", "right", "right" },
	{ "button", "enter", "enter" },
	{ "button", "escape", "pause" },
	{ "text", "text" },
	{ "button", "M:1", "left click" },
	{ "mouseMoved", "updateCursor" },

	{ "axis", "a", "d", "p1_x"},
	{ "axis", "w", "s", "p1_y"},
	{ "axis", "left", "right", "p1_x" },
	{ "axis", "up", "down", "p1_y" },
}

return M
