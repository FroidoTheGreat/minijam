local obj = {}
oopify(obj)

--class
	obj.class = {}
	local c = obj.class

	function c:load(p)
		self.x = p.x
		self.y = p.y
		self.z = p.z + 8

		self.str = 4
		self.dying = 0

		self.sprite = sprites:new("player attack", {
			center_x = 0.5,
			center_y = 0.5,
		})

		local dir = math.atan2(mouse:gety() - p.y + 10, mouse:getx() - p.x)

		self:add(pros, {
			dir = dir,
			speed = 9,
			slow_factor = 0.85,
			ivx = p.vx,
			ivy = p.vy,
		})
	end

	function c:update()
		self:update_proj()

		local vel = self.vx^2 + self.vy^2
		if vel < 0.5^2 then
			self.destroy = true
		elseif vel < 0.8^2 then
			self.dying = 1
		end
	end

	function c:draw()
		self.sprite:draw(self.str * 2 + self.dying - 1, self.x, self.y - self.z, false, self.dir + math.pi / 2)
	end


return obj