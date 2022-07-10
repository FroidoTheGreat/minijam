tmaps = {}
oopify(tmaps)

function tmaps:load()
	self.maps = {}

	local all = love.filesystem.getDirectoryItems("tilemaps")
	for _, f_name in ipairs(all) do
		local name = string.sub(f_name, 1, #f_name - 4)

		self.maps[name] = tmaps:new(f_name)
	end
end

--class
	tmaps.class = {}
	local c = tmaps.class

	function c:load(name)
		self.map = lg.newImage("tilemaps/"..name)

		local twidth = 16
		local theight = 16
		self.twidth = twidth
		self.theight = theight

		local width = self.map:getWidth() / twidth
		local height = self.map:getHeight() / theight
		self.width = width
		self.height = height
		print(width, height)

		self.tiles = {}

		for x = 0, width - 1 do
			self.tiles[x] = {}
			for y = 0, height - 1 do
				local q = lg.newQuad(x * twidth, y * theight, twidth, theight, self.map:getDimensions())
				self.tiles[x][y] = q
			end
		end
	end

	function c:draw(t, x, y)
		lg.draw(self.map, self.tiles[t.x][t.y], x, y)
	end

tmaps:load()