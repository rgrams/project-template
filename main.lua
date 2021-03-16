
io.stdout:setvbuf("no") -- For use with external console.

require "init-global-libs"

local worldDebugEnabled = true
local guiDebugEnabled = false

local scene, guiRoot, gameRoot

local sw, sh = love.window.getMode()
local screenAlloc = { x = 0, y = 0, w = sw, h = sh, designW = sw, designH = sh, scale = 1 }

function love.load()
	math.randomseed(love.timer.getTime() * 10000)

	Input.init()
	Input.bindMultiple(require("input-bindings"))

	physics.setCategoryNames(unpack(config.physicsCategoryNames))

	-- Root objects & scripts may require physics categories, and are only used in load().
	local GuiRoot = require "GuiRoot"
	local gameManager_script = require "gameManager_script"
	local menuSwitcher_script = require "interface.menuSwitcher_script"

	scene = SceneTree(config.drawLayers, config.defaultDrawLayer)

   guiRoot = mod(GuiRoot(), {scripts = {menuSwitcher_script}})
	scene:add(guiRoot)
	guiRoot:allocate(screenAlloc)
	guiRoot:call("loadMenus", config.menuList, config.startMenuName)

	gameRoot = mod(Object(), {scripts = {gameManager_script}, name = "GameManager"})
	scene:add(gameRoot)
end

function love.update(dt)
	scene:update(dt)
end

local function debugDraw(rootObject, layer)
	rootObject:callRecursive("debugDraw", layer)
	rootObject.tree:draw(layer)
	rootObject.tree.draw_order:clear(layer)
end

function love.draw()
	Camera.current:applyTransform()
	scene:draw("world")
	if worldDebugEnabled then  debugDraw(gameRoot, "debug")  end
	Camera.current:resetTransform()
	scene:draw("gui")
	if guiDebugEnabled then  debugDraw(guiRoot, "guiDebug")  end
end

function love.resize(w, h)
	Camera.setAllViewports(0, 0, w, h)
	screenAlloc.w, screenAlloc.h = w, h
	guiRoot:allocate(screenAlloc)
end
