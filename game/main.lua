lg = love.graphics

require("bin/oop")
serpent = require("bin/serpent")
require("bin/settings")
require("bin/colors")
require("bin/gfx")
require("bin/state")
require("bin/editor/edit")
require("bin/basics")
love.graphics.setDefaultFilter("nearest", "nearest")
require("bin/sprites")
require("bin/animations")
require("bin/mouse")
require("bin/tmaps")
require("bin/maps")
require("bin/physics")
require("bin/player")
require("bin/keys")
require("bin/camera")
require("bin/pro")
require("bin/sfx")

math.randomseed(os.time())

function love.load()
	state:set(level_transition, 0)

	gfx.init()
	keys:load("w", "s", "a", "d")

	song = love.audio.newSource("song.wav", "stream")
	song:setLooping(true)
	song:setVolume(0.6)
	song:play()
end

function love.update()
	state:update()
end

function love.draw()
	gfx.clear()

	state:draw()

	mouse:draw()

	gfx.draw()
end