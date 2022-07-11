local obj = {}
oopify(obj)

-- class
	obj.class = {}
	local c = obj.class

	function c:load(plant)
		self.plant = plant
		self.x = plant.x
		self.y = plant.y
		self.z = 20

		self.sprite = spritemans:new(8, {
			center_x = 0.5,
			center_y = 0.5,
		})
		self.sprite:new("projectile1 idle", "idle", "idle")
		self.sprite:new("projectile1 die", "die", "die")

		local p = state.state.player
		self:add(pros, {
			dir = math.atan2(p.y - self.y, p.x - self.x),
			speed = 2,
			life = 80,
			radius = 5,
		})
	end

	function c:update()
		self:update_proj()

		if self:check_collision(state.state.player) then
			self.destroy = true
			state.state.player:hurt()
		end
	end

	function c:draw()
		colors.set(1, 0.2)
		lg.ellipse("fill", self.x, self.y, 3, 3)
		lg.setColor(1, 1, 1, 1)
		self.sprite:draw(self.x, self.y - self.z)
	end

	function c:kill()
		if self.dying then return end
		self.dying = 4
		self.sprite:set("die")
	end


return obj