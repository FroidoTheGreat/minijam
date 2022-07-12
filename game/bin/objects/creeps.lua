local obj = {}
oopify(obj)

--class
	obj.class = {}
	local c = obj.class

	function c:load(x, y)
		self.x = x
		self.y = y

		self.sprite = spritemans:new(5, {
			center_x = 0.5,
			center_y = 1,
		})
		self.sprite:new("enemy3 run", "run", "run")
		self.sprite:new("enemy3 idle", "idle", "idle")
		self.sprite:new("enemy3 hurt", "idle", "hurt")

		self.hp = 10

		self.mode = "idle"
		self.mode_timer = 0

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

		if self.mode == "idle" then
			self.mode_timer = self.mode_timer + 1
			if self.mode_timer > 100 then
				self:set_run()
			end
		end
		if self.mode == "run" then
			self.mode_timer = self.mode_timer + 1
			if self.mode_timer > 300 then
				self:set_idle()
			end
		end

		self:update_phys()

		if self:check_collision(state.state.player) then
			self.destroy = true
			state.state.player:hurt()
		end
	end

	function c:draw()
		colors.set(1, 0.2)
		lg.ellipse("fill", self.x, self.y, 5, 3)
		lg.setColor(1, 1, 1, 1)
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

	function c:set_run()
		self.mode_timer = 0
		self.mode = "run"
		self.sprite:set("run")
	end

	function c:set_idle()
		self.mode_timer = 0
		self.mode = "idle"
		self.sprite:set("idle")
	end

return obj