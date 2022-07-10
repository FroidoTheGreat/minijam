maps = {}
oopify(maps)

maps.solids = {
	{x=6, y=10},
	{x=6, y=9},
	{x=6, y=11},
	{x=5, y=10},
	{x=7, y=10},
	{x=5, y=9},
	{x=7, y=9},
	{x=5, y=11},
	{x=7, y=11},
	{x=6, y=7},
	{x=7, y=7},
	{x=7, y=8},
	{x=6, y=8},
}

function maps:is_solid(tile)
	for _, o in ipairs(self.solids) do
		if o.x == tile.x and o.y == tile.y then
			return true
		end
	end
	return false
end

--class
	maps.class = {}
	local c = maps.class

	function c:load(tmap, w, h)
		self.tmap = tmap

		self:load_map("1")
	end

	function c:load_map(name)
		self.map = {}
		local ref = require("maps/"..name) -- FIXME
										   -- use lf.load in future
										   -- (probably)

		local width = 1
		local height = 1
		local minx = 0
		local miny = 0
		local maxx = 0
		local maxy = 0

		local layers = ref.layers
		for l, layer in ipairs(layers) do
			self.map[l] = {}
			for _, chunk in ipairs(layer.chunks) do
				local i = 0
				-- to find width and height
				if chunk.x < minx then
					minx = chunk.x
				end
				if chunk.x + chunk.width > maxx then
					maxx = chunk.x + chunk.width
				end
				if chunk.y < miny then
					miny = chunk.y
				end
				if chunk.y + chunk.width > maxy then
					maxy = chunk.y + chunk.height
				end
				-- collect map data
				for y = chunk.y, chunk.y + chunk.height do
					for x = chunk.x, chunk.x + chunk.width do
						i = i + 1
						local t = chunk.data[i]
						if t then
							self:set(t - 1, l, x, y)
						end
					end
					i = i - 1
				end
			end
		end

		self.width = maxx - minx
		self.height = maxy - miny
		self.startx = minx
		self.starty = miny
	end

	function c:draw(l, x_, y_)
		local layer = self.map[l]
		local i = 0
		local i2 = 0
		for x = self.startx, self.startx + self.width do
			i2 = i2 + 1
			if layer[x] then
				for y = self.starty, self.starty + self.height do
					if layer[x][y] then
						i = i + 1
						local t = layer[x][y]
						local ptx = state.state.player.last_tx
						local pty = state.state.player.last_ty
						self.tmap:draw(layer[x][y], x_ + (x-1)*self.tmap.twidth, y_ + (y-1)*self.tmap.theight)
						if maps:is_solid(t) or
							x == ptx and y==pty then
							lg.setColor(1,0,1,0.5)
							lg.rectangle("fill", x_ + (x-1)*self.tmap.twidth, y_ + (y-1)*self.tmap.theight, 16, 16)
							lg.setColor(1,1,1,1)
						end
					end
				end
			end
		end
	end

	function c:set(tile, l, x, y)
		if not self.map[l] then
			self.map[l] = {}
		end
		if not self.map[l][x] then
			self.map[l][x] = {}
		end
		if type(tile) == "number" then
			if tile < 0 then
				return
			end
			local cy = math.floor(tile / self.tmap.width)
			local cx = tile - cy * self.tmap.width
			tile = {
				x=cx,
				y=cy,
			}
		end
		self.map[1][x][y] = {
			x = tile.x,
			y = tile.y
		}
	end

	function c:pos_get(l, x, y)
		x = x + 16
		y = y + 16
		local cx = math.floor(x/self.tmap.twidth)
		local cy = math.floor(y/self.tmap.theight)
		if not self.map[l][cx] or not self.map[l][cx][cy] then
			return {x=-1,y=-1}, cx, cy
		end
		return self.map[l][cx][cy],
			cx, cy
	end