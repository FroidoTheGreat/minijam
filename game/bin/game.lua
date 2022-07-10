game = {}
oopify(game)

--class
	game.class = {}
	local c = game.class

	function c:load(opt)
		self.player = players:new(0, 0)

		self.map = maps:new(tmaps.maps.tileset, 20, 20)

		camera:load()
		camera:set_target(self.player)
	end

	function c:update()
		self.player:update()

		camera:update()
	end

	function c:draw()
		camera:draw()

		self.map:draw(1, 0, 200)

		self.player:draw()
	end