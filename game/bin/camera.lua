camera = {}

function camera:load()
	self.x = 0
	self.y = 0
	self.speed = 9
	self.target = self

	self.shake_intensity = 0

	self.drawn = false
end

function camera:set_target(target)
	self.target = target
end

function camera:set(x, y)
	self.x = x - gfx.res.x / 2
	self.y = y - gfx.res.y / 2
end

function camera:update()
	local dx = self.target.x - self.x - gfx.res.x / 2
	local dy = self.target.y - self.y - gfx.res.y / 2
	if (dx^2 + dy^2) > 9 then
		self.x = self.x + dx / self.speed
		self.y = self.y + dy / self.speed
	end

	local m = math.max(self.shake_intensity, 0)
	self.x = self.x + math.random(-m, m)
	self.y = self.y + math.random(-m, m)
	self.shake_intensity = self.shake_intensity - 0.5

	self.drawn = false
end

function camera:shake(m)
	self.shake_intensity = math.max(self.shake_intensity, m)
end

function camera:draw()
	self.drawn = true
	lg.translate(-math.floor(self.x), -math.floor(self.y))
end

function camera:undraw()
	if self.drawn then
		self.drawn = false
		lg.translate(math.floor(self.x), math.floor(self.y))
	end
end