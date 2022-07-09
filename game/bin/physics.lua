physics = {}
oopify(physics)

--class
	physics.class = {}
	local c = physics.class

	function c:load(opt)
		self.friction = opt.friction

		self.vx = 0
		self.vy = 0
	end

	function c:update_phys()
		self.vx = self.vx * self.friction
		self.vy = self.vy * self.friction

		self.x = self.x + self.vx
		self.y = self.y + self.vy
	end

	function c:add_force(x, y)
		self.vx = self.vx + x
		self.vy = self.vy + y
	end