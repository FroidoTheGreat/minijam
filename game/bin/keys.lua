keys = {}

function keys:load(u, d, l, r)
	keys.u = u
	keys.d = d
	keys.l = l
	keys.r = r
end

function keys:up()
	return love.keyboard.isDown(self.u)
end

function keys:down()
	return love.keyboard.isDown(self.d)
end

function keys:left()
	return love.keyboard.isDown(self.l)
end

function keys:right()
	return love.keyboard.isDown(self.r)
end