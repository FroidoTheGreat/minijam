maps = {}
oopify(maps)

--class
	maps.class = {}
	local c = maps.class

	function c:load(tmap, w, h)
		self.width = w
		self.height = h
		self.tmap = tmap
		self.map = {}
		for x = 1, w do
			self.map[x] = {}
			for y = 1, h do
				local t = { --FIXME
					x = math.floor(math.random(self.tmap.width - 1)),
					y = math.floor(math.random(self.tmap.height - 1))
				}
				self.map[x][y] = t
			end
		end
	end

	function c:draw(x, y)
		for x = 1, self.width do
			for y = 1, self.height do
				self.tmap:draw(self.map[x][y], (x-1)*self.tmap.twidth, (y-1)*self.tmap.theight)
			end
		end
	end