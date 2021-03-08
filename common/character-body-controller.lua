
local M = {}

function M.update(body, dt, inputX, inputY, maxSpeed, maxAccel, baseMass)
	inputX, inputY = vec2.clamp(inputX, inputY, 0, 1)
	local targetVX, targetVY = inputX * maxSpeed, inputY * maxSpeed
	local curVX, curVY = body:getLinearVelocity()
	local diffVX, diffVY = targetVX - curVX, targetVY - curVY
	local dvx, dvy = vec2.clamp(diffVX, diffVY, 0, maxAccel * dt)
	local k = baseMass
	local ix, iy = dvx * k, dvy * k
	body:applyLinearImpulse(ix, iy)
end

return M
