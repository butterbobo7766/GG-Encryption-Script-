local self = {}

self.storage, self.temporary, self.NAME, self.CHAR, self.FUNCTION = {{}, {}}, {{}, {}}, {string.random(), string.random()}, 0, 1

self.getRandomBool = function(...)
	local args = {...}

	if args[1] == 'true' then
		local temp = {{}, {}}

		temp[1][1] = bitwise.create('false', bitwise.BOOL)
		temp[2][1] = bitwise.create('false', bitwise.BOOL)

		temp[1][1] = ({
			temp[1][1] .. ' and ' .. temp[2][1],
			temp[2][1] .. ' and ' .. temp[1][1],
		})[(math.random(1, 2))]

		temp[1][1] = temp[1][1] .. ' or (...) and ' .. args[2]

		return ('(function(...) return ' .. table.concat(temp[1], ' or ') .. ' end)(' .. bitwise.create('true', bitwise.BOOL) .. ')')
	end

	if args[1] == 'false' then
		local temp = {{}, {}}

		temp[1][1] = bitwise.create('false', bitwise.BOOL)
		temp[2][1] = bitwise.create('false', bitwise.BOOL)

		temp[1][1] = ({
			temp[1][1] .. ' and ' .. temp[2][1],
			temp[1][1] .. ' and not ' .. bitwise.create('true', bitwise.BOOL),
			temp[2][1] .. ' and ' .. temp[1][1],
		})[(math.random(1, 2))]

		temp[1][1] = temp[1][1] .. ' or ' .. bitwise.create('true', bitwise.BOOL) .. ' and ' .. args[2]

		return ('(function(...) return ' .. table.concat(temp[1], ' or ') .. ' end)(' .. bitwise.create('true', bitwise.BOOL) .. ')')
	end
end


self.getRandomBoolNumber = function(...)
	local args = {...}

	args[2] = '((...)' .. args[2] .. ')'

	if args[1] == 'true' then
		local temp = {{}, {}}

		temp[1][1] = bitwise.create('false', bitwise.BOOL)
		temp[2][1] = bitwise.create('false', bitwise.BOOL)

		temp[1][1] = ({
			temp[1][1] .. ' and ' .. temp[2][1],
			temp[2][1] .. ' and ' .. temp[1][1],
		})[(math.random(1, 2))]

		temp[1][1] = temp[1][1] .. ' or ' .. bitwise.create('true', bitwise.BOOL) .. ' and ' .. args[2]

		return ('(function(...) return ' .. table.concat(temp[1], ' or ') .. ' end)')
	end

	if args[1] == 'false' then
		local temp = {{}, {}}

		temp[1][1] = bitwise.create('false', bitwise.BOOL)
		temp[2][1] = bitwise.create('false', bitwise.BOOL)

		temp[1][1] = ({
			temp[1][1] .. ' and ' .. temp[2][1],
			temp[1][1] .. ' and not ' .. bitwise.create('true', bitwise.BOOL),
			temp[2][1] .. ' and ' .. temp[1][1],
		})[(math.random(1, 2))]

		temp[1][1] = temp[1][1] .. ' or ' .. bitwise.create('true', bitwise.BOOL) .. ' and ' .. args[2]

		return ('(function(...) return ' .. table.concat(temp[1], ' or ') .. ' end)')
	end
end



self.getRandomBoolMini = function(...)
	local args = {...}

	if args[1] == 'true' then
		local temp = {{}, {}}

		temp[1][1] = '(' .. bitwise.create('false', bitwise.BOOL) .. ')'

		temp[1][1] = temp[1][1] .. ' or (not (' .. bitwise.create('false', bitwise.BOOL) .. ') and ' .. args[2] .. ')'

		return ('(' .. temp[1][1] .. ')')
	end

	if args[1] == 'false' then
		local temp = {{}, {}}

		temp[1][1] = '(' .. bitwise.create('false', bitwise.BOOL) .. ')'

		temp[1][1] = temp[1][1] .. ' or ((' .. bitwise.create('true', bitwise.BOOL) .. ') and ' .. args[2] .. ')'

		return ('(' .. temp[1][1] .. ')')
	end
end

self.input = function(...)
	local args = {...}

	if args[2] == self.CHAR then
		if self.temporary[1][args[1]] then
			return self.temporary[1][args[1]]
		end

		local name = bitwise.create(#self.storage[1] + 1, bitwise.NUMBER)

		self.temporary[1][args[1]], self.storage[1][#self.storage[1] + 1] = 'gchar[' .. name .. ']', self.getRandomBool(({'true', 'false'})[(math.random(1, 2))], args[1])

		return self.temporary[1][args[1]]
	end
end

self.get = function()
	return self.storage[1]
end


return self