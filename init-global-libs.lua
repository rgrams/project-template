
require "philtre.init"  -- Load all engine components into global variables.
require "philtre.lib.math-patch"
gui = require "philtre.objects.gui.all"
vec2 = require "philtre.lib.vec2xy"
flux = require "philtre.lib.flux"
entman = require "lib.entity-manager"
config = require "config"
SoundManager = require "audio.SoundManager"

require "interface.widgets.shrinkwrap"
