stars = {}
oopify(stars)

--class
	stars.class = {}
	local c = stars.class

	function c:load(w, h)
		self.sprite = sprites:new("stars", {
			center_x = 0.5,
			center_y = 0.5,
		})

		self.stars = {}
		local space = 10
		local chance = 0.03
		for x = -w/2, w/2, 10 do
			for y = -h/2, w/2, 10 do
				if math.random() < chance then
					local z = math.random()/10
					table.insert(self.stars, {
						x = x,
						y = y,
						z = z,
						f = math.floor(math.random(1, 8))
					})
				end
			end
		end
	end

	function c:draw()
		for _, o in ipairs(self.stars) do
			lg.setColor(1,1,1,(1 - o.z)/4)
			self.sprite:draw(o.f, o.x - camera.x*o.z, o.y - camera.y*o.z)
		end
		lg.setColor(1,1,1,1)
	end