state = {}
state.states = {}

require("bin/game")
require("bin/level_transition")
require("bin/fail_transition")

function state:get()
	return self.state
end

function state:set(state, ...)
	self.state = state:new(...)
end

function state:update()
	self.state:update()
end

function state:draw()
	self.state:draw()
end

function state:register(state, name)
	self.states[name] = state
	if not self.state then
		self.state = state
	end
end