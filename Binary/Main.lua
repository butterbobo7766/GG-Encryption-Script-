local self = {}

self.RANDOM_CALL = function(n)
	--local head = {string.byte(n, 2, 4)}

	return (string.sub(n, 1, 1) .. string.char(math.random(65, 124),math.random(200, 240), math.random(95, 124)))
end

self.DUMP = function(...)
	local args = {...}

	if not args[1] then
		assert(error())
	end

	local pattern = {
		{
			(string.char(table.unpack({231,3,0,0,231,3,0,0,250,250,250,40,46,46,46,46,41,0,0,0,0,40,46,46,46,46,41,0,0,0,0,40,46,46,46,46,41,0,0,0,0,40,46,46,46,46,41,0,0,0,0,40,46,46,46,46,41,0,0,0,0,40,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,41,0,0,0,0,40,46,46,46,46,41,64,0,128,0}))),
			function(...)
				local args = {...}

				return ((string.char(table.unpack({255,255,255,255,255,255,255,255,250,250,250}))) ..
					args[1] .. 
					self.RANDOM_CALL(args[7]) ..
					args[2] ..
					self.RANDOM_CALL(args[2]) ..
					args[3] ..
					self.RANDOM_CALL(args[5]) ..
					args[4] ..
					self.RANDOM_CALL(args[4]) ..
					args[5] ..
					self.RANDOM_CALL(args[3]) ..
					args[6] ..
					self.RANDOM_CALL(args[2]) ..
					args[7] ..
					self.RANDOM_CALL(args[7]))
			end
		},
		{
			(string.char(table.unpack({231,3,0,0,231,3,0,0,0,250,250,40,46,46,46,46,41,0,0,0,0,40,46,46,46,46,41,0,0,0,0,40,46,46,46,46,41,0,0,0,0,40,46,46,46,46,41,0,0,0,0,40,46,46,46,46,41,0,0,0,0,40,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,46,41,0,0,0,0,40,46,46,46,46,41,64,0,128,0}))),
			function(...)
				local args = {...}

				return ((string.char(table.unpack({255,255,255,255,255,255,255,255,0,250,250}))) ..
					args[1] .. 
					self.RANDOM_CALL(args[7]) ..
					args[2] ..
					self.RANDOM_CALL(args[2]) ..
					args[3] ..
					self.RANDOM_CALL(args[5]) ..
					args[4] ..
					self.RANDOM_CALL(args[4]) ..
					args[5] ..
					self.RANDOM_CALL(args[3]) ..
					args[6] ..
					self.RANDOM_CALL(args[2]) ..
					args[7] ..
					self.RANDOM_CALL(args[7]))
			end
		},
		{
			(string.char(table.unpack({95,62,0,1}))),
			function()
				return (string.char(
					({
						164, 228, 36, 100
					})[(math.random(1, 4))],
					(math.random(0, 63)),
					({
						0, 128
					})[(math.random(1, 2))],
					(math.random(0, 255))
					))
			end
		},
		
	}

	for n, b in next, pattern, nil do
		args[1] = string.gsub(args[1], b[1], b[2])
	end

	args[1] = (string.char(table.unpack({27,76,117,97,82,0,1,4,4,4,8,4,25,147,13,10,26,10,255,255,255,255,255,255,255,255,250,250,250,2,0,0,0,37,0,0,0,30,0,0}))) .. (string.sub(args[1], 53, -1))

	return args[1]
end

return self