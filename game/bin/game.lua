game = {}
oopify(game)

--class
	game.class = {}
	local c = game.class

	function c:load(opt)
		self.reg = {}

		self.player = players:new(0, 0)
		self:regr(self.player)

		self.map = maps:new(tmaps.maps.tileset, 20, 20)

		camera:load()
		camera:set_target(self.player)
	end

	function c:update()
		for _, o in ipairs(self.reg) do
			o:update()
		end

		camera:update()
	end

	function c:draw()
		camera:draw()

		self.map:draw(1, 0, 0)

		for _, o in ipairs(self.reg) do
			o:draw()
		end

		for _, o in ipairs(self.reg) do
			if o.destroy then
				table.remove(self.reg, _)
			end
		end

		camera:undraw()
	end

	function c:regr(o)
		table.insert(self.reg, o)
	end

	function c:new(typ, ...)
		self:regr(typ:new(...))
	end