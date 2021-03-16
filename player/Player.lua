
local Player = Body:extend()
Player.className = "Player"

local bodyController = require "common.character-body-controller"

local maxSpeed = 300
local maxAccel = 1000

function Player.init(self)
	Player.super.init(self)
	Input.enable(self)
	self.inputVec = vec2(Input.get("p1_x"), Input.get("p1_y"))
	self.mass = self.body:getMass()
end

function Player.update(self, dt)
	local vx, vy = vec2.clamp(self.inputVec.x, self.inputVec.y, 0, 1)
	bodyController.update(self.body, dt, vx, vy, maxSpeed, maxAccel, self.mass)
end

function Player.input(self, name, value, change, rawChange, isRepeat, x, y, dx, dy, isTouch, presses)
	if name == "p1_x" then
		self.inputVec.x = value
	elseif name == "p1_y" then
		self.inputVec.y = value
	end
end

function Player.set(self, x, y)
	Player.super.set(self, "dynamic", x, y, 0, { "circle", {40} }, { fixedRot = true })
	self.sprite = Sprite("common/tex/dot-hard_64.png")
	self.children = { self.sprite }
end

return Player
