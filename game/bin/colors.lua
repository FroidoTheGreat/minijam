colors = {}

function colors.init()

end

function colors.normal(r, g, b)
	return r/255, g/255, b/255, 1
end
function colors.obj(r, g, b)
	r, g, b = colors.normal(r,g,b)
	return {r,g,b,1}
end

-- loading the palettes
	colors.palettes = {}
	local all = love.filesystem.getDirectoryItems("gfx/palettes")
	for _, file in ipairs(all) do
		local name = string.sub(file, 1, #file - 4)
		if name == "default" then
			local img = love.image.newImageData("gfx/palettes/"..file)
			colors.palettes[name] = {}
			for x = 0, img:getWidth() - 1 do
				local r, g, b, _ = img:getPixel(x, 0)
				local color = {r,g,b,1}
				colors.palettes[name][x + 1] = color
			end
		end
	end

function colors.set_palette(name)
	settings.set("palette", name)
	colors.palette = colors.palettes[name]
	local bg = 1
	lg.setBackgroundColor(colors.palette[bg][1],colors.palette[bg][2],colors.palette[bg][3],1)
end
if not colors.palettes[settings.get("palette")] then
	settings.set("palette", "default")
end
colors.set_palette(settings.get("palette"))

function colors.set(c, a)
	lg.setColor(colors.palette[c][1], colors.palette[c][2], colors.palette[c][3], 0.2)
end

function colors.reset()
	lg.setColor(1,1,1,1)
end