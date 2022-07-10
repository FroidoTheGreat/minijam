spritemans = {}

spritemans.new = oop.new

-- class
	spritemans.class = {}
	local c = spritemans.class

	function c:load(spd, t)
		self.animations = {}

		self.time = 0
		self.timeout = spd or 3
		self.frame = 1

		self.had_ani = false

		if t then
			self.t = t
		end
	end

	function c:new(ref, default, name)
		local animation = animations:new(ref, default, name, self.t)

		animation.height = animation.sprite.height
		animation.width = animation.sprite.width

		if not name then local name = ref end
		self.animations[name] = animation

		if not self.has_ani then
			self.has_ani = true
			self:set(name)
			self.height = animation.height
			self.width = animation.width
		end
	end

	function c:set(name, on_finish, on_change)
		self.on_finish = nil
		self.on_change = nil
		self.on_finish = on_finish
		self.on_change = on_change
		if name and self.animations[name] and self.animations[name] ~= self.animation then
			self.animation = self.animations[name]
			self.frame_num = self.animation.sprite.frame_num
			self.default = self.animation.default
			self.frame = 1
			self.height = self.animation.height
			self.width = self.animation.width
		elseif (not name) or (not self.animations) then
			print("warning: animation not changed because name: \""..name.."\" was invalid")
		end
	end

	function c:get()
		return self.animation.name
	end

	function c:update(dt)
		self.time = self.time + 1
		if self.time > self.timeout then
			self.time = self.time - self.timeout
			self:inc_frame()
		end
	end

	function c:draw(...)
		self.animation.sprite:draw(self.frame, unpack{...})
	end

	function c:inc_frame()
		self.frame = self.frame + 1
		if self.on_change then
			local f = self.on_change
			f.fun(f.inst)
		end

		if self.frame > self.frame_num then
			if self.on_finish then
				local f = self.on_finish
				f.fun(f.inst)
			end
			if self.default and self.default ~= self.animation.name then
				self:set(self.default)
			else
				self.frame = 1
				self.time = 0
			end
		end
	end

animations = {}

animations.new = oop.new

-- class
	animations.class = {}
	local c = animations.class

	function c:load(ref, default, name, t)
		self.sprite = sprites:new(ref, t)
		self.name = name
		if name then self.name = name end
		self.default = default
	end