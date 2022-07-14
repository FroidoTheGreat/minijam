local obj = {}
oopify(obj)

--class
	obj.class = {}
	local c = obj.class

	function c:load(x, y)
		self.draw_layer = 0
		self.x = x
		self.y = y

		self.active_timer = 50
	end

	function c:update()
		self.active_timer = self.active_timer - 1
		if self.active_timer > 0 then
			return
		end

		local p = state.state.player
		local dis = (p.x - self.x)^2 + (p.y - self.y)^2
		local rad2 = 20^2
		if dis < rad2 then
			state:get():next_level()
		end
	end

	function c:draw()
		lg.circle("fill", self.x, self.y, 20 + math.cos(self.active_timer/10) * 3)
	end

return obj