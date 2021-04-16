
local SoundManager = Object:extend()
SoundManager.className = "SoundManager"

local SoundGroup = require "audio.SoundGroup"

function SoundManager.set(self, data)
	SoundManager.super.set(self)
	for groupName,groupData in pairs(data) do
		self[groupName] = SoundGroup(groupData)
	end
end

return SoundManager
