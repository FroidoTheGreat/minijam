game = {}
oopify(game)

--class
	game.class = {}
	local c = game.class

	function c:load(opt)
		self.player = players:new(0, 0)

		self.map = maps:new(tmaps.maps.tileset, 20, 20)
	end

	function c:update()
		self.player:update()
	end

	function c:draw()
		lg.translate(-math.floor(self.player.x), -math.floor(self.player.y))
		self.map:draw(1, 0, 200)

		self.player:draw()
	end