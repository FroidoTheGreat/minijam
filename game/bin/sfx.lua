sfx = {}
oopify(sfx)

sfx.sfx = {}
function sfx:load(name)
	if sfx.sfx[name] then
		return sfx.sfx[name]
	end
	local srcs = {}
	local all = love.filesystem.getDirectoryItems("sfx/"..name)
	for _,__ in ipairs(all) do
		local filename = string.sub(__, 1, 1)
		local num = tonumber(filename)
		srcs[num] = love.audio.newSource("sfx/"..name.."/"..num..".wav", "static")
	end

	return srcs
end

-- class
	sfx.class = {}
	local c = sfx.class

	function c:load(name)
		self.sfx = {}
		local s = sfx:load(name)
		for i,o in ipairs(s) do
			self.sfx[i] = o:clone()
		end
	end

	function c:play(vol, x, y)
		vol = vol or 1
		if x then
			local p = state.state.player
			local dx = (p.x - x)^2
			local dy = (p.y - y)^2
			local dis = (dx + dy)^(3/5)

			vol = math.min(1, 100/dis)
			print(dis, vol)
		end
		local i = math.floor(math.random(1,#self.sfx))
		local s = self.sfx[i]
		s:setVolume(1)
		s:setPitch(1 - math.random(1,20)/70)
		s:setVolume(vol)

		s:play()
	end