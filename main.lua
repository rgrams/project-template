
require "philtre.init"
local sceneLoader = require "lib.scene-loader"

local startingScene = "start-scene"
local worldDebugDrawEnabled = true
local layers = {
	world = { "debug", "default" },
}
local defaultLayer = "default"

local scene

function love.load(arg)
	Input.init()
	scene = SceneTree(layers, defaultLayer)
	sceneLoader.addScene(scene, startingScene)
end

function love.update(dt)
	scene:update(dt)
end

function love.draw()
	scene:updateTransforms()
	Camera.current:applyTransform()
	if worldDebugDrawEnabled then
		love.graphics.setLineWidth(1/Camera.current.zoom)
		scene:callRecursive("debugDraw", "debug")
		love.graphics.setLineWidth(1)
	end
	scene:draw("world")
	if worldDebugDrawEnabled then
		scene.draw_order:clear("debug")
	end
	Camera.current:resetTransform()
end

function love.resize(w, h)
	Camera.setAllViewports(0, 0, w, h)
end
