
local Player = require "player.Player"

local function Game()
	return mod(World(), {name = "GameWorld", children = {
		Camera(),
		Player()
	}})
end

return Game
