huds = {}
oopify(huds)

huds.objects = {}
local all = love.filesystem.getDirectoryItems("bin/hud")
for _, f_name in ipairs(all) do
	local name = string.sub(f_name, 1, #f_name - 4)
	huds.objects[name] = require("bin/hud/"..name)
end

--class
	huds.class = {}
	local c = huds.class

	function c:load()
		self.reg = {}

		self:new("bar")
	end

	function c:update()
		for _, o in ipairs(self.reg) do
			o:update()
		end
	end

	function c:draw()
		for _, o in ipairs(self.reg) do
			o:draw()
		end
	end

	function c:new(typ, ...)
		table.insert(self.reg, huds.objects[typ]:new(...))
	end