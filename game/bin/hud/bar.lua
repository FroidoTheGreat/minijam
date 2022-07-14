local obj = {}
oopify(obj)

--class
	obj.class = {}
	local c = obj.class

	function c:load()
		self.sprite = sprites:new("ui bar", {
			center_x = 0,
			center_y = 0,
		})
		self.icon = sprites:new("ui health", {
			center_x = 0,
			center_y = 0,
		})
	end

	function c:update()
		if not self.player then
			self.player = state:get().player
		end
		if not self.player.do_countdown then
			self.f1 = self.player.str
			self.f2 = 1
		elseif self.player.health > 0 then
			self.f1 = 11 - self.player.health
			self.f2 = 2
		else
			self.f1 = 11
			self.f2 = 3
		end
	end

	function c:draw()
		local x = 10
		self.sprite:draw(self.f1 or 1, x, 5)
		self.icon:draw(self.f2 or 1, x - 8, 5)
	end

return obj