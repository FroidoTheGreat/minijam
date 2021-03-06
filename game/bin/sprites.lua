sprites = {}

local f = lg.newImage("sprites/ui/bar/1.png")

-- loading all the sprites
function sprites.load(folder, loc)
	if not folder then
		folder = "sprites"
		sprites.imgs = {}
		loc = sprites.imgs
	end
	all = lf.getDirectoryItems(folder)

	if #all == 0 then
		print(folder)
		return nil
	elseif #all[1] >= 4 and string.sub(all[1], #all[1] - 3, #all[1]) == ".png" then
		for i, f_name in ipairs(all) do -- look through folder
			--print(folder, f_name, num)
			local img = lg.newImage(folder.."/"..f_name)
			local num = tonumber(string.sub(f_name, 1, #f_name - 4))
			
			loc[num] = img
		end
	else
		for i, name in ipairs(all) do -- find subfolders
			loc[name] = {}
			sprites.load(folder.."/"..name, loc[name])
		end
	end
end

sprites.new = oop.new

-- class
	sprites.class = {}
	local c = sprites.class

	function c:load(name, align_settings)
		local path = string.gmatch(name, "[^%s]+")
		local sprite = sprites.imgs
		for sub in path do
			sprite = sprite[sub]
			if not sprite then
				print("failed to load sprite \""..name.."\": does not exist")
				return self:load("default")
			end
		end

		if (#sprite == 0) then
			error(name)
		end
		self.sprite = sprite
		self.frame_num = #self.sprite

		local w = self.sprite[1]:getWidth()
		local h = self.sprite[1]:getHeight()

		self.height = h
		self.width = w

		self.offx = math.floor(w/2)
		self.offy = h
		if align_settings then
			local s = align_settings
			if s.center_x then
				self.offx = s.center_x * w
			end
			if s.center_y then
				self.offy = s.center_y * h
			end
		end

		self.flip = false
	end

	function c:draw(frame, x, y, flip, r)
		local scalex = 1 if flip then scalex = -1 end
		lg.draw(self.sprite[frame],
			math.floor(x),
			math.floor(y),
			r or 0,
			scalex, 1,
			math.floor(self.offx),
			math.floor(self.offy)
			)
	end

	function c:draws(x, y, r, g, b)
		if r then
			lg.setColor(r, g, b)
		end
		lg.rectangle("fill", x, y, self.width, self.height)
		lg.setColor(1, 1, 1)
	end

sprites.load()