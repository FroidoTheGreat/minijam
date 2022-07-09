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
		self.map:draw(0, 0)

		self.player:draw()
	end