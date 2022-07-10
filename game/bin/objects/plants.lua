local obj = {}
oopify(obj)

--class
	obj.class = {}
	local c = obj.class

	function c:load(x, y)
		self.x = x
		self.y = y

		self.sprite = spritemans:new(9, {
			center_x = 0.5,
			center_y = 0.94,
		})
		self.sprite:new("enemy2 idle", "idle", "idle")
	end

	function c:update()
		self.sprite:update()
	end

	function c:draw()
		self.sprite:draw(self.x, self.y)
	end

return obj