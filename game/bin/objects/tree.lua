local obj = {}
oopify(obj)

-- class
	obj.class = {}
	local c = obj.class

	function c:load(x, y, typ)
		self.x = x
		self.y = y

		self.sprite = sprites:new("tree"..typ, {
			center_x = 0.5,
			center_y = 0.95,
		})

		self:add(physics, {

		})
		self:add(colliders, {
			team = "neutral",
			radx = 7,
			rady = 7,
			offy = 3,
			family = "stuck",
		})
	end

	function c:update()
		for _, o in ipairs(self:check_list(nil, "unstuck", "projectile")) do
			if o.family == "unstuck" then
				self:push(o, 0.5)
			else
				if o.kill then
					o:kill()
				else
					o.destroy = true
				end
			end
		end
	end

	function c:draw()
		self.sprite:draw(1, self.x, self.y)
	end

return obj