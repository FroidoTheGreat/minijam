players = {}
oopify(players)
players.pros = require("bin/objects/player/pro")

--class
	players.class = {}
	local c = players.class

	function c:load()
		self.sprite = spritemans:new(8, {
			center_x = 0.5,
			center_y = 0.9
		})
		self.sprite:new("player idle", "idle", "idle")

		self.x = 0
		self.y = 0
		self.z = 8

		self.str = 1

		self.can_shoot = true

		self.float_timer = 0

		self.speed = 1

		self:add(physics, {
			friction = 0.75,
			col = true,
			col_off_y = -10,
		})
	end

	function c:update()
		local sq2 = 1.41421
		if keys:right() and keys:up() then
			self:add_force(self.speed / sq2, -self.speed / sq2)
		elseif keys:right() and keys:down() then
			self:add_force(self.speed / sq2, self.speed / sq2)
		elseif keys:left() and keys:up() then
			self:add_force(-self.speed / sq2, -self.speed / sq2)
		elseif keys:left() and keys:down() then
			self:add_force(-self.speed / sq2, self.speed / sq2)
		elseif keys:right() then
			self:add_force(self.speed, 0)
		elseif keys:left() then
			self:add_force(-self.speed, 0)
		elseif keys:up() then
			self:add_force(0, -self.speed)
		elseif keys:down() then
			self:add_force(0, self.speed)
		end

		if mouse:click() then
			if self.can_shoot then
				state.state:new(players.pros, self)
			end
			self.can_shoot = false
		else
			self.can_shoot = true
		end

		self:update_phys()

		self.sprite:update()
		self.float_timer = self.float_timer + 0.05
	end

	function c:draw()
		local z = self.z + math.cos(self.float_timer)*2
		lg.setColor(0, 0, 0, 0.2)
		local shadow_multi = 1
		lg.ellipse("fill", self.x, self.y, 8 * shadow_multi, 4 * shadow_multi)
		lg.setColor(1, 1, 1, 1)
		self.sprite:draw(self.x, self.y - z)
	end