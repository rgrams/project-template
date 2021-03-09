
local script = {}

local Game = require "Game"

function script.init(self)
	Input.enable(self)
end

function script.input(self, name, value, change, rawChange, isRepeat, x, y, dx, dy, isTouch, presses)
	if name == "pause" and change == 1 then
		if self.gameWorld then
			if self.gameWorld.timeScale == 0 then -- game is paused, resume it.
				self.tree:get("/GuiRoot"):call("switchTo", nil)
				self:call("resume")
			elseif not self.gameWorld.timescale then -- game is running, pause it.
				self:call("pause")
				self.tree:get("/GuiRoot"):call("switchTo", "pause")
			end
		end
	end
end

function script.pause(self)
	if self.gameWorld then
		self.gameWorld.timeScale = 0
	end
end

function script.resume(self)
	if self.gameWorld then
		self.gameWorld.timeScale = nil
	end
end

function script.load(self)
	if self.gameWorld then
		print("ERROR: game-manager.load - game world already exists")
	else
		self.gameWorld = Game()
		self.tree:add(self.gameWorld, self)
	end
end

function script.unload(self)
	if self.gameWorld then
		self.tree:remove(self.gameWorld)
		self.gameWorld = nil
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
	self.tree:get("/GuiRoot"):call("switchTo", "gameOver")
end

function script.quit(self)
	love.event.quit(0)
end

return script
