pros = {}
oopify(pros)

--class
	pros.class = {}
	local c = pros.class

	function c:load(t)
		self.dir = t.dir or 0
		self.vx = math.cos(self.dir) * (t.speed or 5) + (t.ivx or 0)
		self.vy = math.sin(self.dir) * (t.speed or 5) + (t.ivy or 0)
		self.slow_factor = t.slow_factor or 0.995
		self.life = t.life or 80

		self.dying = false

		self:add(colliders, {
			radius = t.radius or 10,
			genus = "projectile",
		})
	end

	function c:update_proj()
		if self.dying then
			self.dying = self.dying - 1
			if self.dying < 0 then
				self.destroy = true
			end
			return
		end

		self.x = self.x + self.vx
		self.y = self.y + self.vy

		self.vx = self.vx * self.slow_factor
		self.vy = self.vy * self.slow_factor

		if self.life > 0 then
			self.life = self.life - 1
			if self.life < 1 then
				if self.kill then
					self:kill()
				else
					self.destroy = true
				end
			end
		end
	end