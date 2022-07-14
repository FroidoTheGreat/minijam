enemy = {}
oopify(enemy)

--class
	enemy.class = {}
	local c = enemy.class
	function c:load(opt)
		self.corpse = opt.corpse
		self.corpse_opacity = opt.corpse_opacity or 1
		self.do_flying_corpse = opt.do_flying_corpse
		if opt.count == nil then opt.count = true end
		self.count = opt.count

		if self.count then
			game.game.enemy_count = game.game.enemy_count + 1
			game.game.enemy_total = game.game.enemy_total + 1
		end
	end

	function c:kill()
		self.destroy = true
		local vx = self.vx * 6
		local vy = self.vy * 6
		state.state.enemy_count = state.state.enemy_count - 1
		if not self.do_flying_corpse then
			vx, vy = 0, 0
		end
		if self.count and state.state.enemy_count < 1 then
			state.state:new("finish", self.x, self.y)
		else
			state.state:new("corpse", self.x, self.y, self.corpse, self.corpse_opacity, {
				vx = vx,
				vy = vy,
			})
		end
	end