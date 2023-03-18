local self = {}

self.encodes, self.STORAGE, self.TEMPORARY_CHAR, self.TEMPORARY_GLOBAL = {}, {{}, {}}, {{}, {}}, {{}, {}}

self.encodes[1] = function(...)
	local args, matchRequire = {...}, {
		'require%(%".-%"%)',
		"require%(%'.-%'%)",
	}

	for int, get in next, matchRequire, nil do
		repeat
			args[1] = args[1]:gsub(get, function(q)
				local w = q:match('%(.-%)')

				if w then
					local name = load('return ' .. w)

					if name then
						name = name() .. '.lua'

						local input_data = io.open(input_path .. name)

						if input_data then
							input_data = io.input(input_path .. name):read('*a')

							q = '(function() ' .. input_data .. ' end)()'
						end
					end
				end

				return q
			end)
		until args[1]:match(get) == nil
	end

	return args[1]
end

self.encodes[2] = function(...)
	local selfData = {...}

	local data, this = {selfData[1]:byte(1, -1)}, {}

	for u, v in next, data, nil do
		local change, Values;
		if data[u] == 34 or data[u] == 39 or (data[u] == 91 and data[u + 1] == 91) or (data[u] == 91 and data[u + 1] == 61) then
			change = {}
			if data[u] == 34 or data[u] == 39 then
				change[1] = data[u]
			end
			if data[u] == 91 and data[u + 1] == 91 then
				change[2], change[3] = 93, 93
			end
			if data[u] == 91 and data[u + 1] == 61 then
				change[4], change[5], change[6], change[7], change[8] = 61, 93, 0, 0, false
				for i = u + 1, #data do
					if data[i] == 91 then
						break
						else
						if data[i] == 61 then
							change[6] = change[6] + 1
						end
					end
				end
			end
			values = {}
			values[1], data[u] = data[u],""
			for i = u + 1, #data do
				if (change[1] and data[i] == change[1] and values[#values] ~= 92) or (change[1] and #values > 1 and data[i] == change[1] and values[#values] == 92 and values[#values - 1] == 92) or (change[2] and change[3] and data[i] == change[2] and values[#values] == change[3]) or (change[4] and change[5] and change[6] and change[7] and change[6] > 0 and change[7] > 0 and change[6] == change[7] and data[i] == change[5] and values[#values] == change[4]) then
					table.insert(values, data[i])
					data[i] = ""
					break
				else
					if change[6] and change[7] and change[8] == false and values[#values] == change[5] and data[i] == change[4] then
						change[8] = true
					end
					if change[6] and change[7] and change[8] == true and data[i] == 61 then
						change[7] = change[7] + 1
					end
					if change[6] and change[7] and change[7] > 0 and change[8] == true and data[i] ~= 61 then
						change[8], change[7] = false, 0
					end
					table.insert(values, data[i])
					data[i] = ""
				end
			end
			if not load("return " .. string.char(table.unpack(values))) then
				print((string.char(table.unpack(values))))
				Values = {(string.char(table.unpack(values))):byte(1, -1)}
				else
				Values = {(selfData[2](load("return " .. string.char(table.unpack(values)))())):byte(1, -1)}
			end
		end
		if Values then
			for i, v in next, Values, nil do
				table.insert(this, v)
			end
		end
		if data[u] and type(data[u]) == 'number' or type(data[u]) == 'integer' then
			table.insert(this, data[u])
		end
	end
	return string.char(table.unpack(this))
end

self.encodes[3] = function(...)
	local args = {...}
	for s, p in next, {
		{
			"(function)%s+([%a%w_]+%..-)%(",
			function(a, b) return b .." = function(" end
		}, 
		{
			"%.?%.[%a%w_]+",
			function(i)
				local q = i:match("^%.(%a.-)$")
				if q then
					i = "[" .. args[2](tostring(q)) .. "]"
				end
				return i
			end
		}
	}, nil do
		args[1] = string.gsub(args[1], p[1], p[2])
	end
	return args[1]
end

self.encodes[4] = function(...)
	local args = {...}

	for name, content in next, {"assert", "collectgarbage", "dofile", "error", "getmetatable", "ipairs", "load", "loadfile", "next", "pairs", "pcall", "print", "rawequal", "rawget", "rawlen", "rawset", "require", "select", "setmetatable", "tonumber", "tostring", "type", "xpcall", "gg", "debug", "os", "string", "math", "coroutine", "io", "table", "bit32", "package", "utf8"}, nil do
		repeat
			args[1] = string.gsub(args[1], '' .. tostring(content) .. '%(', function(get)
					local q = get:match('(.-)%(')
					if q and _G[tostring(q)] then
						get = '_G[' .. args[2](tostring(q)) .. ']('
					end
					return get;
				end)
		until string.match(args[1], '' .. tostring(content) .. '%(') == nil

		repeat
			args[1] = string.gsub(args[1], '' .. tostring(content) .. '%[', function(get)
					local q = get:match('(.-)%[')
					if q and _G[tostring(q)] then
						get = '_G[' .. args[2](tostring(q)) .. ']['
					end
					return get;
				end)
		until string.match(args[1], '' .. tostring(content) .. '%[') == nil
	end

	return args[1]
end

self.encodes[5] = function(...)
	local args, regex = {...}, {
		"([%if%%while]+)([%s%(]+)([%%true%%false]+)([%s%)]+)([%then%%do]+)",
		"%Coww%_NUMBER%(%d+%)",
		"%Coww%_BOOL%(%a+%)",
		}

	if args[1]:match(regex[1]) then
		repeat
			args[1] = args[1]:gsub(regex[1], function(...)
				local w = {...}

				if w[3] == 'true' or w[3] == 'false' then
					w[3] = bitwise.create(w[3], bitwise.BOOL)
				end

				return table.concat(w)
			end)
		until args[1]:match(regex[1]) == nil
	end

	if args[1]:match(regex[2]) then
		repeat
			args[1] = args[1]:gsub(regex[2], function(...)
				local s = tonumber(((...):match('%d+')))

				if s and s > 0 then
					s = bitwise.create(s, bitwise.NUMBER)

					else
						local new = math.random(1, 100)

						s = bitwise.create(new, bitwise.NUMBER) .. ' - ' .. bitwise.create(new, bitwise.NUMBER)
				end

				return '(' .. s .. ')'
			end)
		until args[1]:match(regex[2]) == nil
	end

	if args[1]:match(regex[3]) then
		repeat
			args[1] = args[1]:gsub(regex[3], function(...)
				local s = tostring(((...):match('%((%a+)%)')))

				if s and s == 'true' or s == 'false' then
					s = bitwise.create(s, bitwise.BOOL)

					else
						error()
				end

				return '(' .. s .. ')'
			end)
		until args[1]:match(regex[3]) == nil
	end

	return args[1]
end

self.encode = function(...)
	local args = {...}

	for y in next, self.encodes, nil do
		if args[3] and y > 2 then
			args[1] = self.encodes[y](args[1], args[3])
			else
				args[1] = self.encodes[y](args[1], args[2])
		end
	end

	return args[1]
end

self.BYTE_CHAR_ORIG = function(...)
	if (...):sub(1, 1) == '\0' or (...):sub(1, 1) == '\\' then
		return '"' .. (...) .. '"'
	end

	local args = {...}

	return ('(string.char(' .. table.concat({args[1]:byte(1, -1)}, ',') .. '))')
end

self.CHAR_ENCRYPT = function(...)
	local args, tempt = {...}, {}

	if not self.TEMPORARY_CHAR[args[1]] then
		for int, byte in next, {args[1]:byte(1, -1)}, nil do
			tempt[int] = ((encrypt.STRING_CHAR .. '(' .. bitwise.create(byte, bitwise.NUMBER) .. ')'))
		end

		if #tempt > 194 then
			self.TEMPORARY_CHAR[args[1]] = '(' .. encrypt.TABLE_CONCAT .. '({' .. table.concat(tempt, ',') .. '}))'
			else
				self.TEMPORARY_CHAR[args[1]] = '(' .. table.concat(tempt, '..') .. ')'
		end
	end

	return self.TEMPORARY_CHAR[args[1]]
end

self.CONVERT_TO = function(...)
	local formula, varargs = encrypt.get(encrypt.FORMULA), {...}

	return (
		(
			(
				formula[2][4](
					(
						formula[1][4](
							255 - varargs[1],
							table.unpack(encrypt.get(encrypt.MAIN))
							)
						),
					table.unpack(encrypt.get(encrypt.GLOBAL))
					)
				)
				+ (varargs[2] * 4)
			) % 256
		)
end

self.GLOBAL_ENCRYPT = function(...)
	local args = {...}

	if not self.TEMPORARY_GLOBAL[args[1]] then
		local result, number = {}, {#self.STORAGE[1] + 1, (math.random(1, 255))}

		self.TEMPORARY_GLOBAL[args[1]] = '(' .. scripts.GLOBAL_FUNC .. '("CowwxString[' .. number[1] .. ']", "\\' .. tostring(number[2]) .. '", ' .. tostring(number[1] + 8) .. '))'

		self.STORAGE[1][number[1]] = (function()
			for num, byte in next, {args[1]:byte(1, -1)}, nil do
				local finalByte = (self.CONVERT_TO(byte, ((number[2] * number[1] * num * 4) * 16)))

				result[num] = '\\' .. finalByte
			end

			return table.concat(result)
		end)
	end

	return self.TEMPORARY_GLOBAL[args[1]]
end

return self