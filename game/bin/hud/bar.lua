local obj = {}
oopify(obj)

--class
	obj.class = {}
	local c = obj.class

	function c:load()
		self.sprite = sprites:new("ui bar", {
			center_x = 0.5,
			center_y = 0.5,
		})
	end

	function c:update()

	end

	function c:draw()
		self.sprite:draw(1, gfx.res.x/2, 30)
	end

return obj