basics = {}
oopify(basics)

--class
	basics.class = {}
	local c = basics.class

	function c:load()

	end

	function c:update_active()
		return self.x > camera.x - 200
			and self.x < camera.x + gfx.res.x + 200
			and self.y > camera.y - 200
			and self.y < camera.y + gfx.res.y + 200
	end