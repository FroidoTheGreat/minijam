oop = {}

function oop:new(...)
	local obj = {}

	for k,v in pairs(object.class) do
		obj[k] = v
	end

	for k,v in pairs(self.class) do
		obj[k] = v
	end

	obj:load(unpack{...})

	if self.extends then
		for _, typ in ipairs(self.extends) do
			local class = typ.class
			for k,v in pairs(class) do
				if k == "afterload" then
				elseif k == "load" then
					obj.tempload = v
					obj:tempload()
					obj.tempload = nil
				else
					obj[k] = v
				end
			end
		end
	end

	if obj.afterload then obj:afterload() end

	return obj
end

function oop:add(obj) -- adds obj to self
	for k,v in pairs(obj) do
		if not self[k] then
			print("warning: overwriting from one object to another")
		end
		self[k] = v
	end
end

function oop:extend(typ)
	if not self.extends then
		self.extends = {}
	end
	table.insert(self.extends, typ)
end

function oopify(obj)
	for k,v in pairs(oop) do
		obj[k] = v
	end
end

function new(typ, ...)
	return typ:new(unpack{...})
end

object = {}
oopify(object)
	
	-- 
	object.class = {}
	local c = object.class

	function c:addobj(obj)
		for k,v in pairs(obj) do
			if not self[k] then
				self[k] = v
			else
				--print("warning: NOT overwriting \""..k.."\" from one object to another")
			end
		end
	end

	function c:add(typ, ...)
		self:addobj(typ:new(...))
	end

function icontains(o, val)
	for i, v in ipairs(o) do
		if val == v then
			return true
		end
	end
	return false
end