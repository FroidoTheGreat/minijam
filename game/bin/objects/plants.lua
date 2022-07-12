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
		self.sprite:new("enemy2 hurt", "idle", "hurt")

		self.shoot_timer = 0
		self.shoot_timeout = 80

		self.hp = 18

		self.dying = false

		self:add(physics, {

		})
		self:add(colliders, {
			family = "unstuck",
			team = "enemy",
		})
		self:add(basics)
	end

	function c:update()
		if self.dying then
			self.dying = self.dying - 1
			if self.dying < 0 then
				self.destroy = true
			end
		end

		self.sprite:update()

		self.shoot_timer = self.shoot_timer + 1
		if self.shoot_timer > self.shoot_timeout then
			self.shoot_timer = 0 - math.random(20)
			state.state:new(game.objects.plant_pro, self)
		end

		self:update_phys()
	end

	function c:draw()
		self.sprite:draw(self.x, self.y)
	end

	function c:hurt()
		if self.dying then return end
		self.hp = self.hp - 1
		self.sprite:set("hurt")
		if self.hp < 1 then
			self.dying = 7
		end
	end

return obj