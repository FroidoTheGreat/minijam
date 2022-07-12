colliders = {}
oopify(colliders)

-- class
	colliders.class = {}
	local c = colliders.class

	function c:load(opt)
		self.is_collider = true
		self.collision_radius = opt.radius or 10
		self.col_radx = opt.radx or self.collision_radius
		self.col_rady = opt.rady or self.col_radx
		self.col_offy = opt.offy or 0
		self.family = opt.family or ""
		self.genus = opt.genus or ""
		self.species = opt.species or ""
		self.team = opt.team or "enemy"
	end

	function c:update_collider()

	end

	function c:draw_collider()
		lg.setColor(0, 1, 0)
		lg.ellipse("line", self.x, self.y - self.col_offy, self.col_radx, self.col_rady)
		lg.setColor(1, 1, 1, 1)
	end

	function c:check_collision(other)
		if not other.is_collider then
			return
		end
		local dx = self.x - other.x
		local dy = self.y - self.col_offy - other.y + other.col_offy
		local rx = self.col_radx + other.col_radx
		local ry = self.col_rady + other.col_rady

		if (self:box_collide(other)) then
			if (dx^2/rx^2 + dy^2/ry^2) <= 1 then
				return true
			end
		end
		return false
	end

	function c:box_collide(other)
		return true
	end

	function c:push(other, force)
		if not other.uses_physics then
			return
		end
		local dir = math.atan2(other.y - self.y, other.x - self.x)
		local dx = math.cos(dir)
		local dy = math.sin(dir)
		other:add_force(dx * force, dy * force)
	end

	function c:check_list(list, family, genus, species, team)
		list = list or state.state.reg
		local ret = {}
		for _, o in ipairs(list) do
			if ((family and (family == o.family))
				or (genus and (genus == o.genus))
				or (species and (species == o.species))
				or (team and (team == o.team)))
				and self:check_collision(o) then

				table.insert(ret, o)
			end
		end
		return ret
	end