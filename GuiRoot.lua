
local function GuiRoot(name)
   local w, h = love.window.getMode()
   local self = gui.Node(0, 0, 0, w, h, "NW", "C", "fill")
   self.name = name or "GuiRoot"
   self.layer = "gui"
   return self
end

return GuiRoot
