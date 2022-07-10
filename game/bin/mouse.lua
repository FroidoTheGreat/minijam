mouse = {}
mouse.x = 0
mouse.y = 0
mouse.sprite = sprites:new("cursor", {
	center_x = 0.5,
	center_y = 0.5,
})

love.mouse.setVisible(false)

function mouse:draw()
	self.sprite:draw(1, self.x, self.y)
end

function mouse:click()
	return love.mouse.isDown(1)
end

function mouse:getx()
	return self.x + camera.x
end

function mouse:gety()
	return self.y + camera.y
end

function love.mousemoved(x, y, dx, dy)
	if not x then
		x, y = love.mouse.getPosition()
	end
	if not mouse then return end
	--[[if settings and settings.get("fullscreen") then
		if x < gfx.off.x + 1 then
			love.mouse.setX(gfx.off.x + 1)
		end
		if x > gfx.off.x + gfx.res.x * gfx.scale - 1 then
			love.mouse.setX(gfx.off.x + gfx.res.x * gfx.scale - 1)
		end
		if y < gfx.off.y + 1 then
			love.mouse.setY(gfx.off.y + 1)
		end
		if y > gfx.off.y + gfx.res.y * gfx.scale - 1 then
			love.mouse.setY(gfx.off.y + gfx.res.y * gfx.scale - 1)
		end
	end]]
	x, y = love.mouse.getPosition()
	mouse.x, mouse.y = (x) / gfx.scale, (y) / gfx.scale
end