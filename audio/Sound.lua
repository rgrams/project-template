
-- A sound from a single source file.
-- ==================================
-- Manages multiple voices: Starts with an allocated amount, adds more as needed.

local Class = require "philtre.modules.base-class"
local Sound = Class:extend()

local function addVoice(self)
	local voice = self.voices[1]:clone()
	table.insert(self.voices, voice)
	self.voiceCount = self.voiceCount + 1
	return voice
end

local function playVoice(voice, pitch, volume)
	if pitch then  voice:setPitch(pitch)  end
	if volume then  voice:setVolume(volume)  end
	voice:play()
end

function Sound.play(self, pitch, volume)
	for i=1,self.voiceCount do
		local voice = self.voices[i]
		if not voice:isPlaying() then
			playVoice(voice, pitch, volume)
			return voice
		end
	end

	local voice = addVoice(self)
	playVoice(voice, pitch, volume)
end

function Sound.pause(self)
	for i=1,#self.pausedVoices do  self.pausedVoices[i] = nil  end

	for i=1,self.voiceCount do
		local voice = self.voices[i]
		if voice:isPlaying() then
			voice:pause()
			table.insert(self.pausedVoices, voice)
		end
	end
end

function Sound.resume(self)
	for i=1,#self.pausedVoices do
		self.pausedVoices[i]:play()
	end
end

function Sound.stop(self)
	for i=1,self.voiceCount do
		local voice = self.voices[i]
		if voice:isPlaying() then  voice:stop()  end
	end
end

function Sound.set(self, filename, sourceType, voiceCount, pitch, volume)
	local source = new.audio(filename, sourceType)
	if pitch then  source:setPitch(pitch)  end
	if volume then  source:setVolume(volume)  end
	self.voices = { source }
	for i=2,voiceCount or 1 do
		table.insert(self.voices, source:clone())
	end
	self.voiceCount = voiceCount
	self.pausedVoices = {}
end

return Sound
