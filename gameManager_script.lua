
local script = {}

local Game = require "Game"

function script.init(self)
	Input.enable(self)
end

function script.input(self, name, value, change, rawChange, isRepeat, x, y, dx, dy, isTouch, presses)
	if name == "pause" and change == 1 then
		if self.gameWorld then
			if self.gameWorld.timeScale == 0 and not self.isGameOver then -- game is paused, resume it.
				self.tree:get("/GuiRoot"):call("switchTo", nil)
				self:call("resume")
			elseif not self.gameWorld.timescale then -- game is running, pause it.
				self:call("pause")
				local menu = self.isGameOver and "gameOver" or "pause"
				self.tree:get("/GuiRoot"):call("switchTo", menu)
			end
		end
	end
end

local function setPlayersPaused(paused)
	local players = entman.getGroup("players")
	for player,_ in pairs(players) do
		player:call(paused and "pause" or "resume")
	end
end

function script.pause(self)
	if self.gameWorld then
		self.gameWorld.timeScale = 0
		sound.game:pause()
		setPlayersPaused(true)
	end
end

function script.resume(self)
	if self.gameWorld then
		self.gameWorld.timeScale = nil
		sound.game:resume()
		setPlayersPaused(false)
	end
end

function script.load(self)
	if self.gameWorld then
		print("ERROR: game-manager.load - game world already exists")
	else
		self.isGameOver = false
		self.gameWorld = Game()
		self.tree:add(self.gameWorld, self)
	end
end

function script.unload(self)
	if self.gameWorld then
		self.tree:remove(self.gameWorld)
		self.gameWorld = nil
		sound.game:stop()
	else
		print("ERROR: game-manager.unload - game world is not loaded")
	end
end

function script.reload(self)
	script.unload(self)
	self.tree:update(0.01)
	script.load(self)
end

function script.gameOver(self)
	script.pause(self)
	self.isGameOver = true
	self.tree:get("/GuiRoot"):call("switchTo", "gameOver")
end

function script.quit(self)
	love.event.quit(0)
end

return script
