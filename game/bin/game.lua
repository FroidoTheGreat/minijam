game = {}
oopify(game)

--class
	game.class = {}
	local c = game.class

	function c:load(opt)
		self.player = players:new(0, 0)
	end

	function c:update()
		self.player:update()
	end

	function c:draw()
		self.player:draw()
	end