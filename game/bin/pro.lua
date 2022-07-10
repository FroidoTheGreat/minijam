pros = {}
oopify(pros)

--class
	pros.class = {}
	local c = pros.class

	function c:load(t)
		self.dir = t.dir or 0
		self.vx = math.cos(self.dir) * t.speed + (t.ivx or 0)
		self.vy = math.sin(self.dir) * t.speed + (t.ivy or 0)
		self.slow_factor = t.slow_factor or 1
	end

	function c:update_proj()
		self.x = self.x + self.vx
		self.y = self.y + self.vy

		self.vx = self.vx * self.slow_factor
		self.vy = self.vy * self.slow_factor
	end