players = {}
oopify(players)

--class
	players.class = {}
	local c = players.class

	function c:load()
		self.sprite = spritemans:new({
			center_x = 0.5,
			center_y = 0.5
		})
		self.sprite:new("default", "default", "default")

		self.x = 0
		self.y = 0

		self.speed = 3

		self:add(physics, {
			friction = 0.7
		})
	end

	function c:update()
		if keys:right() and keys:up() then
			self:add_force(self.speed, -self.speed)
		elseif keys:right() and keys:down() then
			self:add_force(self.speed, self.speed)
		elseif keys:left() and keys:up() then
			self:add_force(-self.speed, -self.speed)
		elseif keys:left() and keys:down() then
			self:add_force(-self.speed, self.speed)
		elseif keys:right() then
			self:add_force(self.speed, 0)
		elseif keys:left() then
			self:add_force(-self.speed, 0)
		elseif keys:up() then
			self:add_force(0, -self.speed)
		elseif keys:down() then
			self:add_force(0, self.speed)
		end

		self:update_phys()
	end

	function c:draw()
		self.sprite:draw(self.x, self.y)
	end