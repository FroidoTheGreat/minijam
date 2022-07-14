local obj = {}
oopify(obj)

--class
	obj.class = {}
	local c = obj.class

	function c:load(x, y, opt)
		opt = opt or {}

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

		self.hp = 40

		self.dying = false

		local count = true
		if opt.count == "0" then
			count = false
		end

		self:add(physics, {

		})
		self:add(colliders, {
			family = "unstuck",
			team = "enemy",
		})
		self:add(basics)
		self:add(enemy, {
			corpse = "enemy2 death",
			corpse_opacity = 0.7,
			count = count,
		})
	end

	function c:update()
		if self.dying then
			self.dying = self.dying - 1
			if self.dying < 0 then
				self:kill()
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

	function c:hurt(d)
		if self.dying then return end
		self.hp = self.hp - (d or 1)
		self.sprite:set("hurt")
		if self.hp < 1 then
			self.dying = 7
		end
	end

return obj