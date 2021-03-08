
local script = {}

function script.init(self)
	Input.enable(self)
	self.inputVec = vec2(Input.get("p1_x"), Input.get("p1_y"))
end

function script.update(self, dt)
	local iv = self.inputVec
	local vx, vy = vec2.clamp(self.inputVec.x, self.inputVec.y, 0, 1)
	local speed = 10000
	vx, vy = vx * speed, vy * speed
	self.body:applyForce(vx, vy)
end

function script.input(self, name, value, change, isRepeat, x, y, dx, dy, isTouch, presses)
	if name == "p1_x" then
		self.inputVec.x = value
	elseif name == "p1_y" then
		self.inputVec.y = value
	end
end

return script
