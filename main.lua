
require "philtre.init"
_G.gui = require "philtre.objects.gui.all"
local sceneLoader = require "lib.scene-loader"

local startingScene = new.scene("root")
local debugDrawEnabled = true
local layers = {
	world = { "debug", "default" },
}
local defaultLayer = "default"

local scene

function love.load(arg)
	Input.init()
	scene = SceneTree(layers, defaultLayer)
	sceneLoader.addScene(startingScene, scene)
end

function love.update(dt)
	scene:update(dt)
end

function love.draw()
	scene:updateTransforms()
	Camera.current:applyTransform()
	if debugDrawEnabled then
		scene:callRecursive("debugDraw", "debug")
	end
	scene:draw("world")
	if debugDrawEnabled then
		scene.drawOrder:clear("debug")
	end
	Camera.current:resetTransform()
end

function love.resize(w, h)
	Camera.setAllViewports(0, 0, w, h)
end
