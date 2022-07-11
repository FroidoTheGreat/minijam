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
		self.sprite:new("player hurt", "idle", "hurt")

		self.x = 0
		self.y = 0
		self.z = 8

		self.str = 1
		self.str_timer = 0

		self.health = 6
		self.health_timer = 0
		self.death_countdown = 80
		self.do_countdown = false

		self.can_shoot = true

		self.float_timer = 0

		self.speed = 1

		self:add(physics, {
			friction = 0.75,
			col = true,
			col_off_y = -10,
		})
		self:add(colliders, {
			radx = 6,
			rady = 7,
			team = "player",
			family = "unstuck",
			--offy = 5,
		})
	end

	function c:update()
		if self.do_countdown then
			self.health_timer = self.health_timer + 1
			if self.health_timer > 80 then
				self.health_timer = 0
				self.health = self.health - 1
				self.sprite:set("hurt")
				self.sprite.frame = 1
			end
		end

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

	function c:hurt()
		self.sprite:set("hurt")
		self.sprite.frame = 1
		if self.str < 5 then
			self.str = self.str + 1
		elseif not self.do_countdown then
			self.do_countdown = true
			self.health_timer = 0
			self.health = 5
		end
	end

	function c:draw()
		local z = self.z + math.cos(self.float_timer)*2
		colors.set(1, 0.2)
		local shadow_multi = 1
		lg.ellipse("fill", self.x, self.y, 8 * shadow_multi, 4 * shadow_multi)
		lg.setColor(1, 1, 1, 1)
		self.sprite:draw(self.x, self.y - z)
	end