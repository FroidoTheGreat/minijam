edit = {}
oopify(edit)

--class
	edit.class = {}
	local c = edit.class

	function c:load()
		self.tmap = tmaps.maps.tileset
		self.map = maps:new(tmaps.maps.tileset, 20, 20)
	end

	function c:update()
		if mouse:click() then
			local x = math.floor(mouse.x / self.tmap.twidth)
			local y = math.floor(mouse.y / self.tmap.theight)
			self.map:set({
				x=3,
				y=5
			}, x, y)
		end
	end

	function c:draw()
		self.map:draw(0, 0)
	end