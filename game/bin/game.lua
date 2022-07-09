game = {}
oopify(game)

--class
	game.class = {}
	local c = game.class

	function c:load(opt)
		self.s = sprites:new("d")
	end

	function c:update()

	end

	function c:draw()
		self.s:draws(100, 100, 0.5, 0.5, 1)
	end