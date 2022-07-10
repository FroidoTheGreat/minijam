physics = {}
oopify(physics)

--class
	physics.class = {}
	local c = physics.class

	function c:load(opt)
		self.friction = opt.friction

		self.vx = 0
		self.vy = 0

		if opt.col then
			self.collides = true
			self.col_off_y = opt.col_off_y or 0
		end

		self.col_t_x = 2
		self.col_t_y = 0
	end

	function c:update_phys()
		self.vx = self.vx * self.friction
		self.vy = self.vy * self.friction

		local tile, cx, cy = state.state.map:pos_get(1, self.x + self.vx, self.y)

		if not self.last_tx then
			self.last_tx = cx
			self.last_ty = cy
			self.x = self.x + self.vx
			self.y = self.y + self.vy
		end
		if maps:is_solid(tile) then
			self.col_t_x = cx
			self.col_t_y = cy
			if cx < self.last_tx then
				self.vx = 0
				self.x = cx * state.state.map.tmap.twidth + 1
			elseif cx > self.last_tx then
				self.vx = 0
				self.x = self.last_tx * state.state.map.tmap.twidth - 0.1
			end
		else
			self.last_tx = cx

			self.x = self.x + self.vx
		end

		tile, cx, cy = state.state.map:pos_get(1, self.x, self.y + self.vy)
		if maps:is_solid(tile) then
			self.col_t_x = cx
			self.col_t_y = cy
			if cy < self.last_ty then
				self.vy = 0
				self.y = cy * state.state.map.tmap.twidth + 1
			elseif cy > self.last_ty then
				self.vy = 0
				self.y = self.last_ty * state.state.map.tmap.twidth - 0.1
			end
		else
			self.last_ty = cy

			self.y = self.y + self.vy
		end
	end

	function c:add_force(x, y)
		self.vx = self.vx + x
		self.vy = self.vy + y
	end