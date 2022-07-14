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
		self.sprite:new("enemy3 idle", "idle", "idle")
		self.sprite:new("enemy3 run", "run", "run")
		self.sprite:new("enemy3 hurt", "idle", "hurt")
		self.sprite:new("enemy3 pre_explosion", "explode", "explode")

		self.hp = 27

		self.speed = 4

		self.mode = "idle"
		self.mode_timer = 0

		self.explode_timer = math.random(200, 300)

		self.sound = sfx:new("creep_blow")

		self.dx = 0
		self.dy = 0

		self.ox = self.x + math.random(-3,3)
		self.oy = self.y + math.random(-3,3)

		self:add(physics, {
			friction = 0.3,
		})
		self:add(colliders, {
			family = "unstuck",
			team = "enemy",
		})
		self:add(enemy, {
			corpse = "enemy2 death",
			corpse_opacity = 0.7,
			do_flying_corpse = false,
		})

		self.hurt_timer = 0
		self.hurt_timeout = 40
	end

	function c:update()
		if self.dying then
			self.dying = self.dying - 1
			if self.dying < 0 then
				self:kill()
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
			if self.mode_timer > 200 then
				self:set_idle()
			end

			self:add_force(self.dx, self.dy)
		end

		self:update_phys()

		if self.dx > 0 and self.wall_touches.right then
			self.dx = self.dx * -1
		end
		if self.dx < 0 and self.wall_touches.left then
			self.dx = self.dx * -1
		end
		if self.dy > 0 and self.wall_touches.bottom then
			self.dy = self.dy * -1
		end
		if self.dy < 0 and self.wall_touches.top then
			self.dy = self.dy * -1
		end

		local dis = 130^2
		local p = state.state.player
		if self.explode_timer < 40 or ((p.x - self.x)^2 + (p.y - self.y)^2) < dis then
			self.explode_timer = self.explode_timer - 1
			if self.explode_timer < 1 then
				for a=0, math.pi * 2, math.pi / 4 do
					state.state:new(game:get("plant_pro"), self, {d = a})
				end
				self.sound:play()
				self:set_idle()
				self.explode_timer = math.random(200, 300)
			elseif self.explode_timer < 40 then
				self.dx = math.random(10) - 5
				self.mode = "idle"
				self.mode_timer = 100
			end
		end

		self.hurt_timer = self.hurt_timer + 1
		if self.hurt_timer > self.hurt_timeout and self:check_collision(state.state.player) then
			state.state.player:hurt()
			self.hurt_timer = 0
			self:set_run()
		end
	end

	function c:draw()
		colors.set(1, 0.2)
		lg.ellipse("fill", self.x, self.y, 5, 3)
		lg.setColor(1, 1, 1, 1)
		self.sprite:draw(self.x, self.y, self.dx < 0)
	end

	function c:hurt(d)
		if self.dying then return end
		self.hp = self.hp - (d or 1)
		self.sprite:set("hurt")
		if self.hp < 1 then
			self.dying = 7
		end
	end

	function c:set_run()
		self.mode_timer = 0
		self.mode = "run"
		self.sprite:set("run")

		local p = state.state.player
		local d = 0
		if math.random() > 0.5 then
			d = math.atan2(p.y - self.y, p.x - self.x) + math.random(-0.2, 0.2) or math.random(0, math.pi * 2)
		else
			d = math.atan2(self.oy - self.y, self.ox - self.x) + math.random(-0.2, 0.2) or d
		end

		self.dx = math.cos(d) * self.speed
		self.dy = math.sin(d) * self.speed
	end

	function c:set_idle()
		self.mode_timer = math.random(1,40)
		self.mode = "idle"
		self.sprite:set("idle")
	end

	function c:update_active()
		return self.x > camera.x - 50
			and self.x < camera.x + gfx.res.x + 50
			and self.y > camera.y - 50
			and self.y < camera.y + gfx.res.y + 50
	end

return obj