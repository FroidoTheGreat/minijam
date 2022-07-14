level_transition = {}
oopify(level_transition)

--class
	level_transition.class = {}
	local c = level_transition.class

	function c:load(current_level)
		self.timer = 0
		self.current_level = current_level
		self.level = self.current_level + 1
	end

	function c:update()
		self.timer = self.timer + 1
		if self.timer > 30 then
			state:set(game, {
				level = self.level,
			})
		end
	end

	function c:draw()

	end