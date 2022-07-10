gfx = {}

function gfx.init(dim)
	lg.setDefaultFilter("nearest", "nearest")
	lg.setLineStyle("rough")

	gfx.res = {
		x = 500,
		y = 500,
	}

	gfx.def = {
		x = settings.get("screen_w"),
		y = settings.get("screen_h"),
	}
	gfx.fs = settings.get("fullscreen")

		gfx.off = {}
		gfx.configure_window(gfx.fs, nil, nil, true)

	gfx.pre_canvas = lg.newCanvas(gfx.res.x, gfx.res.y)
end

function gfx.configure_window(fs, w, h, default)
	if fs then
		love.window.setFullscreen(true)
		gfx.fs = true
	elseif w then
		gfx.fs = false
		love.window.setMode(w, h, {
			resizable = true
		})
	elseif default then
		gfx.fs = false
		love.window.setMode(gfx.def.x, gfx.def.y, {
			resizable = true
		})
	end

	local w, h = lg.getDimensions()

	if not gfx.fs then
		gfx.def.x = w
		settings.set("screen_w", w)
		gfx.def.y = h
		settings.set("screen_h", h)
	end
	settings.set("fullscreen", gfx.fs)

	gfx.off.x = 0
	gfx.off.y = 0
	if w / gfx.res.x > h / gfx.res.y then
		gfx.scale = h / gfx.res.y
		gfx.off.x = (w / gfx.scale - gfx.res.x) / 2
	else
		gfx.scale = w / gfx.res.x
		gfx.off.y = (h / gfx.scale - gfx.res.y) / 2
	end
end

function gfx.clear()
	lg.setCanvas(gfx.pre_canvas)
	lg.clear(0.1,0.1,0.15,1)
	--lg.clear(colors.palette[1][1],colors.palette[1][2],colors.palette[1][3],1)
end

function gfx.draw()
	lg.origin()
	lg.setCanvas()
	lg.setShader()
	lg.scale(gfx.scale)
	lg.draw(gfx.pre_canvas, gfx.off.x, gfx.off.y)
end

-- do this whenever the window changes
	function love.resize()
		gfx.configure_window()
	end