game = {}
oopify(game)

require("bin/huds")
require("bin/colliders")
require("bin/stars")
require("bin/enemy")

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
		game.game = self

		self.reg = {}

		self.enemy_count = 0
		self.enemy_total = 0

		self.level = opt.level or 1

		camera:load()

		self.map = maps:new(tmaps.maps.tileset, 20, 20, tostring(self.level))
		self:resolve_objects()

		self.player = players:new(self.player_start_x or 0, self.player_start_y or 0)
		self:regr(self.player)

		self.hud = huds:new()

		self.starfield = stars:new(self.map.width * 16, self.map.height * 16)

		game.game = nil
	end

	function c:update()
		for _, o in ipairs(self.reg) do
			if o.update and ((not self.update_active) or self:update_active()) then
				o:update()
			end
			if o.destroy then
				table.remove(self.reg, _)
			end
		end

		table.sort(self.reg, function(o1, o2)
			if o1.draw_layer ~= o2.draw_layer then
				return (o1.draw_layer or 1) < (o2.draw_layer or 1)
			else
				return o2.y > o1.y
			end
		end)

		self.hud:update()

		camera:update()

		if self.destroy then
			if self.next == level_transition then
				state:set(level_transition, self.level)
			else
				state:set(fail_transition, self.level)
			end
		end
	end

	function c:next_level()
		self.destroy = true
		self.next = level_transition
	end

	function c:fail_level()
		self.destroy = true
		self.next = fail_transition
	end

	function c:draw()
		self.starfield:draw()

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
		elseif o.name == "player_start" then
			self.player_start_x = x
			self.player_start_y = y
		else
			local obj = game:get(o.name)
			self:new(obj, x, y, o.properties)
		end
	end

	function c:regr(o)
		table.insert(self.reg, o)
	end

	function c:new(typ, ...)
		if type(typ) == "string" then
			typ = game:get(typ)
		end
		self:regr(typ:new(...))
	end