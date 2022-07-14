local obj = {}
oopify(obj)

--class
	obj.class = {}
	local c = obj.class

	function c:load(x, y, sprite_name, opacity, opt)
		opt = opt or {}
		self.sprite = sprites:new(sprite_name)
		self.x = x
		self.y = y
		self.opacity = opacity

		self:add(physics, {

		})

		self:add_force(opt.vx or 0, opt.vy or 0)
	end

	function c:update()
		self:update_phys()
	end

	function c:draw()
		lg.setColor(1, 1, 1, self.opacity)
		self.sprite:draw(1, self.x, self.y)
		lg.setColor(1, 1, 1, 1)
	end

return obj