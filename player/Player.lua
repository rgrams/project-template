
local Player_script = require "player.Player_script"

local function new(x, y)
	return mod(Body("dynamic", x, y, 0,
		{"circle", {40}},
		{fixedRot = true}), {name = "player", children = {
		Sprite("common/tex/dot-hard_64.png")
	}, scripts = {Player_script}})
end

return new
