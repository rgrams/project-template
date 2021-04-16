
-- A group of any number of different named sound effects.
-- =======================================================
-- Can play a sound effect with only its name.
-- Can pause, resume, stop, and change the master volume for all sounds in the group.

local Class = require "philtre.modules.base-class"
local SoundGroup = Class:extend()

local SoundEffect = require "audio.SoundEffect"

function SoundGroup.play(self, effectName)
	local effect = self.effects[effectName]
	effect:play()
end

function SoundGroup.pause(self)
	for _,effect in pairs(self.effects) do
		effect:pause()
	end
end

function SoundGroup.resume(self)
	for _,effect in pairs(self.effects) do
		effect:resume()
	end
end

function SoundGroup.stop(self)
	for _,effect in pairs(self.effects) do
		effect:stop()
	end
end

function SoundGroup.setVolume(self, volume)
	self.volume = volume
	for name,effect in pairs(self.effects) do
		effect:setMasterVolume(volume)
	end
end

-- local data = {
-- 	effectName = {
-- 		{ filename=, sourceType=, voiceCount=, pitch=x or {}, volume=x or {} },
-- 		{ filename=, sourceType=, voiceCount=, pitch=x or {}, volume=x or {} },
-- 		...
-- 	}
-- }

function SoundGroup.set(self, data, volume)
	self.effects = {}
	self.volume = volume or 1
	for effectName,settings in pairs(data) do
		self.effects[effectName] = SoundEffect(settings, self.volume)
	end
end

return SoundGroup
