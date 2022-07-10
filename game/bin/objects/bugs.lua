local obj = {}
oopify(obj)

--class
	obj.class = {}
	local c = obj.class

	function c:load(x, y)
		self.x = x
		self.y = y
		self.dir = math.random() * math.pi * 2

		self:add(physics, {
			friction = 0.75,
		})

		self.sprite = spritemans:new(5, {
			center_x = 0.5,
			center_y = 0.5,
		})
		self.sprite:new("enemy1 idle", "idle", "idle")
		self.sprite:new("enemy1 hurt", "idle", "hurt")
	end

	function c:update()
		self.sprite:update()

		self.dir = self.dir + 0.01
	end

	function c:draw()
		self.sprite:draw(self.x, self.y, false, self.dir)
	end

return obj