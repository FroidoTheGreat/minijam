lf = love.filesystem

settings = {}

settings.settings = {}

settings.defs = {
	fullscreen = true,
	screen_w = 600,
	screen_h = 600,
	highscore = 0,
	do_score = true,
	palette = "default",
}

function settings.load()
	local is = lf.getInfo("settings")
	for k,v in pairs(settings.defs) do
		if not settings.settings[k] then
			settings.settings[k] = v
		end
	end
	print(lf.getSaveDirectory())
	if is then
		local file = lf.read("settings", is.size)
		local _
		_, settings.settings = serpent.load(file)
	end
	if settings.settings.palette == 1 then
		settings.settings.palette = "default"
	end
	settings.save()
end

function settings.save()
	local val = serpent.dump(settings.settings)
	lf.write("settings", val)
end

function settings.set(name, val)
	settings.settings[name] = val
	settings.save()
end

function settings.get(name)
	return settings.settings[name]
end

settings.load()