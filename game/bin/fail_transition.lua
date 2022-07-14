fail_transition = {}
oopify(fail_transition)

--class
	fail_transition.class = {}
	local c = fail_transition.class

	function c:load(current_level)
		self.timer = 0
		self.current_level = current_level
		self.level = self.current_level
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