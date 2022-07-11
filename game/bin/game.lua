game = {}
oopify(game)

require("bin/huds")
require("bin/colliders")

game.objects = {}
local g = game.objects
function game:load_objects(dir, loc)
	if not dir then dir = "bin/objects" end
	if not loc then loc = self.objects end
	local all = love.filesystem.getDirectoryItems(dir)

	for _, f_name in ipairs(all) do
		if #f_name > 4 and string.sub(f_name, #f_name - 3, #f_name) == ".lua" then
			local name = string.sub(f_name, 1, #f_name - 4)
			local path = dir.."/"..name
			loc[name] = require(path)
		else
			loc[f_name] = {}
			self:load_objects(dir.."/"..f_name, loc[f_name])
		end
	end
end
game:load_objects()

function game:get(n)
	local path = string.gmatch(n, "[^%s]+")
	local obj = self.objects
	for sub in path do
		obj = obj[sub]
	end
	return obj
end

--class
	game.class = {}
	local c = game.class

	function c:load(opt)
		self.reg = {}

		self.player = players:new(0, 0)
		self:regr(self.player)
		--self:new(game.objects.plants, 16, 16)
		--self:new(game.objects.bugs, -16, 16)

		self.map = maps:new(tmaps.maps.tileset, 20, 20)
		self:resolve_objects()

		self.hud = huds:new()

		camera:load()
		camera:set_target(self.player)
	end

	function c:update()
		for _, o in ipairs(self.reg) do
			o:update()
		end

		for _, o in ipairs(self.reg) do
			if o.destroy then
				table.remove(self.reg, _)
			end
		end

		table.sort(self.reg, function(o1, o2)
			return o2.y > o1.y
		end)

		self.hud:update()

		camera:update()
	end

	function c:draw()
		camera:draw()

		self.map:draw(1, 0, 0)

		for _, o in ipairs(self.reg) do
			o:draw()
		end

		for _, o in ipairs(self.reg) do
			if o.draw_collider then
				--o:draw_collider()
			end
		end

		--self.map:draw(2, 0, 0)

		camera:undraw()

		self.hud:draw()
	end

	function c:resolve_objects()
		for _, o in ipairs(self.map.objects) do
			self:resolve_object(o)
		end
	end

	function c:resolve_object(o)
		local x = o.x-- + o.width / 2
		local y = o.y-- + o.height / 2
		if o.name == "tree" then
			local obj = game.objects.tree
			self:new(obj, x, y, math.ceil(math.random(1,2)))
		else
			print("name: ", o.name)
			local obj = game:get(o.name)
			self:new(obj, x, y)
		end
	end

	function c:regr(o)
		table.insert(self.reg, o)
	end

	function c:new(typ, ...)
		self:regr(typ:new(...))
	end