game = {}
oopify(game)

game.objects = {}
local g = game.objects
g.bugs = require("bin/objects/bugs")
g.plants = require("bin/objects/plants")
require("bin/huds")

--class
	game.class = {}
	local c = game.class

	function c:load(opt)
		self.reg = {}

		self.player = players:new(0, 0)
		self:regr(self.player)
		self:new(game.objects.plants, 16, 16)
		self:new(game.objects.bugs, -16, 16)

		self.map = maps:new(tmaps.maps.tileset, 20, 20)

		self.hud = huds:new()

		camera:load()
		camera:set_target(self.player)
	end

	function c:update()
		for _, o in ipairs(self.reg) do
			o:update()
		end

		for _, o in ipairs(self.reg) do
			if o.destroy then
				table.remove(self.reg, _)
			end
		end

		table.sort(self.reg, function(o1, o2)
			return o2.y > o1.y
		end)

		self.hud:update()

		camera:update()
	end

	function c:draw()
		camera:draw()

		self.map:draw(1, 0, 0)

		for _, o in ipairs(self.reg) do
			o:draw()
		end

		--self.map:draw(2, 0, 0)

		camera:undraw()

		self.hud:draw()
	end

	function c:regr(o)
		table.insert(self.reg, o)
	end

	function c:new(typ, ...)
		self:regr(typ:new(...))
	end