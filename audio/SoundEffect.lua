
-- A sound effect with random variation.
-- =====================================
-- May use multiple source files, each with random pitch and volume variation.

local Class = require "philtre.modules.base-class"
local SoundEffect = Class:extend()

local Sound = require "audio.Sound"

local range = math.rand_range

function SoundEffect.play(self)
	local sound = self.sounds[math.random(self.soundCount)]
	local pitch, volume
	if sound.isPitchRandom then
		pitch = range(sound.pitchRange[1], sound.pitchRange[2])
	end
	if sound.isVolumeRandom then
		volume = range(sound.volumeRange[1], sound.volumeRange[2]) * self.masterVolume
	else
		volume = sound.baseVolume * self.masterVolume
	end
	sound:play(pitch, volume)
end

function SoundEffect.pause(self)
	for i=1,self.soundCount do
		self.sounds[i]:pause()
	end
end

function SoundEffect.resume(self)
	for i=1,self.soundCount do
		self.sounds[i]:resume()
	end
end

function SoundEffect.stop(self)
	for i=1,self.soundCount do
		self.sounds[i]:stop()
	end
end

function SoundEffect.setMasterVolume(self, masterVolume)
	self.masterVolume = masterVolume
end

-- local settings = {
-- 	{ filename=, sourceType=, voiceCount=, pitch=x or {}, volume=x or {} },
-- 	{ filename=, sourceType=, voiceCount=, pitch=x or {}, volume=x or {} },
-- 	...
-- }

local function isRange(r)
	return type(r) == "table"
end

function SoundEffect.set(self, settings, masterVolume)
	self.sounds = {}
	self.masterVolume = masterVolume or 1
	for i,sourceSettings in ipairs(settings) do
		local set = sourceSettings

		local isPitchRandom = isRange(set.pitch)
		local isVolumeRandom = isRange(set.volume)
		local pitch = isPitchRandom and range(set.pitch[1], set.pitch[2]) or set.pitch
		local volume = isVolumeRandom and range(set.volume[1], set.volume[2]) or set.volume

		local sound = Sound(set.filename, set.type, set.voiceCt, pitch, volume * self.masterVolume)

		sound.baseVolume = volume
		sound.isPitchRandom = isPitchRandom
		sound.isVolumeRandom = isVolumeRandom
		if isPitchRandom then  sound.pitchRange = set.pitch  end
		if isVolumeRandom then  sound.volumeRange = set.volume  end

		table.insert(self.sounds, sound)
	end
	self.soundCount = #self.sounds
end

return SoundEffect
