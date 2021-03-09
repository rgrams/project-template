
local script = {}

local bodyController = require "common.character-body-controller"

local maxSpeed = 300
local maxAccel = 1000

function script.init(self)
	Input.enable(self)
	self.inputVec = vec2(Input.get("p1_x"), Input.get("p1_y"))
	self.mass = self.body:getMass()
end

function script.update(self, dt)
	local vx, vy = vec2.clamp(self.inputVec.x, self.inputVec.y, 0, 1)
	bodyController.update(self.body, dt, vx, vy, maxSpeed, maxAccel, self.mass)
end

function script.input(self, name, value, change, rawChange, isRepeat, x, y, dx, dy, isTouch, presses)
	if name == "p1_x" then
		self.inputVec.x = value
	elseif name == "p1_y" then
		self.inputVec.y = value
	end
end

return script
