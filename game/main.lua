lg = love.graphics

require("bin/oop")
serpent = require("bin/serpent")
require("bin/settings")
require("bin/gfx")
require("bin/state")
require("bin/game")
require("bin/editor/edit")
require("bin/sprites")
require("bin/animations")
require("bin/mouse")
require("bin/tmaps")
require("bin/maps")
require("bin/physics")
require("bin/player")
require("bin/keys")

function love.load()
	state:set(game)

	gfx.init()
	keys:load("w", "s", "a", "d")
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