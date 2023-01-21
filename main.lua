
require "philtre.init"
_G.gui = require "philtre.objects.gui.all"
local sceneLoader = require "lib.editor-scene-loader"

local startingScene = new.scene("root-scene")
local debugDrawEnabled = true
local guiDebugDrawEnabled = true
local layers = {
	world = { "debug", "default" },
	gui = { "gui-debug", "gui" },
}
local defaultLayer = "default"

local scene
local UI, Game
local screenRect = gui.Alloc(0, 0, love.graphics.getDimensions())

function love.load(arg)
	Input.init()
	scene = SceneTree(layers, defaultLayer)
	local root = sceneLoader.addScene(startingScene, scene)
	Game, UI = root[1], root[2]
	UI:allocate(screenRect:unpack())
end

function love.update(dt)
	scene:update(dt)
end

function love.draw()
	scene:updateTransforms()

	-- Draw World:
	Camera.current:applyTransform()
	if debugDrawEnabled then  Game:callRecursive("debugDraw", "debug")  end
	scene:draw("world")
	if debugDrawEnabled then  scene.drawOrder:clear("debug")  end
	Camera.current:resetTransform()

	-- Draw GUI:
	if guiDebugDrawEnabled then  UI:callRecursive("debugDraw", "gui-debug")  end
	scene:draw("gui")
	if guiDebugDrawEnabled then  scene.drawOrder:clear("gui-debug")  end
end

function love.resize(w, h)
	Camera.setAllViewports(0, 0, w, h)
	screenRect.w, screenRect.h = w, h
	UI:allocate(screenRect:unpack())
end
