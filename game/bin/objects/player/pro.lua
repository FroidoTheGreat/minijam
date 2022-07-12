local obj = {}
oopify(obj)

--class
	obj.class = {}
	local c = obj.class

	function c:load(p, opt)
		opt = opt or {}

		self.x = p.x
		self.y = p.y
		self.z = p.z + 8

		self.str = p.str
		self.f = math.min(4, p.str) * 2 - 1

		self.sprite = sprites:new("player attack", {
			center_x = 0.5,
			center_y = 0.5,
		})

		local dir = opt.d or math.atan2(mouse:gety() - p.y + 10, mouse:getx() - p.x)
		if self.str == 5 and not opt.d then
			local spread = 0.4
			opt.d = dir + spread
			state.state:new(game:get("player pro"), p, opt)
			opt.d = dir - spread
			state.state:new(game:get("player pro"), p, opt)
		end

		local speed = 11
		local slow_factor = 0.85
		local radius = 13
		self.damage = 5
		if self.str == 1 then
			speed = 6
			radius = 7
			self.damage = 4
		elseif self.str == 2 then
			speed = 7
			radius = 8
			self.damage = 6
		elseif self.str == 3 then
			speed = 9
			radius = 8.5
			self.damage = 8
		elseif self.str == 4 then
			speed = 10
			self.damage = 9
		end

		self:add(pros, {
			dir = dir,
			speed = speed,
			slow_factor = slow_factor,
			ivx = p.vx,
			ivy = p.vy,
			radius = radius,
		})
	end

	function c:update()
		self:update_proj()

		local vel = self.vx^2 + self.vy^2
		if vel < 0.8^2 then
			self:kill()
		end

		for _, o in ipairs(self:check_list(nil, nil, nil, nil, "enemy")) do
			self:push(o, 0.1 + (self.str - 1) / 20)
			if o.hurt then
				o:hurt()
				self:kill()
			end
		end
	end

	function c:draw()
		self.sprite:draw(self.f, self.x, self.y - self.z, false, self.dir + math.pi / 2)
	end

	function c:kill()
		if self.dying then return end
		self.dying = 1
		self.f = self.f + 1
	end


return obj