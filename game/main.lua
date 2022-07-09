require("bin/oop")
serpent = require("bin/serpent")
require("bin/settings")
require("bin/state")
require("bin/game")

function love.load()
	state:set(game)
end

function love.update()
	state:update()
end

function love.draw()
	state:draw()
end