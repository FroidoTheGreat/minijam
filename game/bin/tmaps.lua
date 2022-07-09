tmaps = {}
oopify(tmaps)

function tmaps:load()
	local all = love.filesystem.getDirectoryItems("tilemaps")
	for _, n in ipairs(all) do
		local f_name = string.sub(n, 1, #n - 4)

		print(f_name)
	end
end

tmaps:load()