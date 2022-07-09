lg = love.graphics

require("bin/oop")
serpent = require("bin/serpent")
require("bin/settings")
require("bin/gfx")
require("bin/state")
require("bin/game")
require("bin/sprites")
require("bin/animations")

function love.load()
	state:set(game)

	gfx.init()
end

function love.update()
	state:update()
end

function love.draw()
	gfx.clear()

	state:draw()

	gfx.draw()
end