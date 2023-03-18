local self = {}

self.NUMBER, self.BOOL = 0, 1;

self.bites = {
	{
		[0] = {
			{"0", "0"},
			{"0", "1"},
			{"1", "0"}
		},
		[1] = {
			{"1", "1"}
		},
		[3] = "&"
	},
	{
		[0] = {
			{"0", "0"},
		},
		[1] = {
			{"1", "0"},
			{"0", "1"},
			{"1", "1"}
		},
		[3] = "|"
	},
	{
		[0] = {
			{"0", "0"},
			{"1", "1"}
		},
		[1] = {
			{"0", "1"},
			{"1", "0"}
		},
		[3] = "~"
	}
};

self.decodeBin = function(...)
	local args = tostring((...) or error())

	return tonumber(args, 2)
end

self.randomForbit = function(...)
	local args, selfData, form = tonumber((...) or error()), {}, {
		{
			"+",
			"-"
		},
		{
			"-",
			"+"
		},
		{
			"<<",
			">>"
		}
	}

	selfData[1], selfData[2], selfData[3] = math.random(2, 8), form[(math.random(1, #form))], ""

	for n = 1, selfData[1] do
		selfData[3] = selfData[3] .. '\\' .. (math.random(0,9)) --(math.random(0, 255))
	end

	if selfData[2][1] == "+" then
		local operate = math.random(1, 2)

		selfData[1] = args + selfData[1]

		if operate == 1 then
			selfData[2], selfData[3] = '-', '#"' .. selfData[3] .. '"'
		elseif operate == 2 then
			selfData[2], selfData[3] = '+', '-#"' .. selfData[3] .. '"'
		end

	elseif selfData[2][1] == '-' then
		local operate = math.random(1, 2)

		selfData[1] = args - selfData[1]

		if operate == 1 then
			selfData[2], selfData[3] = '+', '#"' .. selfData[3] .. '"'
		elseif operate == 2 then
			selfData[2], selfData[3] = '-', '-#"' .. selfData[3] .. '"'
		end

	elseif selfData[2][1] == '<<' then
		selfData[1] = args << selfData[1]

		selfData[2], selfData[3] = '>>', '#"' .. selfData[3] .. '"'
	end

	if type(selfData[1]) == 'number' and selfData[1] < 0 then
		selfData[1] = '~' .. (tonumber(tostring(selfData[1]):match('%d+')) - 1)
	end

	return ('(' .. table.concat(selfData, ' ') .. ')')
end

self.createNumber = function(...)
	local args, selfData, operator, results = tonumber((...) or error()), {{}, "", {}}, self.bites[(math.random(1, #self.bites))]

	if args < 0 then
		return false
	end

	while (args > 0) do
		local modulus = (args % 2)

		local bitOperate = (operator[modulus] or error())

		bitOperate = bitOperate[(math.random(1, #bitOperate))]

		table.insert(selfData[1], 1, bitOperate[1])
		table.insert(selfData[3], 1, bitOperate[2])

		args = (args - modulus) / 2
	end

	selfData[1], selfData[2], selfData[3] = self.randomForbit(self.decodeBin(table.concat(selfData[1]))), operator[3], self.randomForbit(self.decodeBin(table.concat(selfData[3])))

	results = (table.concat(selfData, ' '))

	return (results)
end

self.boolSelfSource = function()
	return {
	['true'] = {
		{
			(function()
				return math.random(2, 9)
			end),
			">",
			(function(...)
				local max = tonumber((...) or error())

				return max - 1
			end)
		},
		{
			(function()
				return math.random(1, 9)
			end),
			"<",
			(function(...)
				local max = tonumber((...) or error())

				return max + 1
			end)
		},
		{
			(function()
				return math.random(1, 9)
			end),
			"==",
			(function(...)
				return tonumber((...) or error())
			end)
		},
		{
			(function()
				return math.random(2, 9)
			end),
			"~=",
			(function(...)
				return (({((...) + 1), ((...) - 1)})[(math.random(1, 2))])
			end)
		}
	},
	['false'] = {
		{
			(function()
				return math.random(1, 9)
			end),
			">",
			(function(...)
				local max = tonumber((...) or error())

				return max + 1
			end)
		},
		{
			(function()
				return math.random(2, 9)
			end),
			"<",
			(function(...)
				local max = tonumber((...) or error())

				return max - 1
			end)
		},
		{
			(function()
				return math.random(2, 9)
			end),
			"==",
			(function(...)
				return (({((...) + 1), ((...) - 1)})[(math.random(1, 2))])
			end)
		},
		{
			(function()
				return math.random(1, 9)
			end),
			"~=",
			(function(...)
				return tonumber((...) or error())
			end)
		}
	}
}
end

self.createBool = function(...)
	local args, selfRets = (...) or error()

	if self.boolSelfSource()[args] then
		selfRets = self.boolSelfSource()[args][(math.random(1, #self.boolSelfSource()[args]))]
		else
			return error()
	end

	selfRets[1] = selfRets[1]()
	selfRets[3] = selfRets[3](selfRets[1])

	if type(selfRets[1]) == 'number' and type(selfRets[3]) == 'number' then
		selfRets[1], selfRets[3] = '(' .. self.createNumber(selfRets[1]) .. ')', '(' .. self.createNumber(selfRets[3]) .. ')'
	end

	return (table.concat(selfRets, ' '))
end


self.create = function(...)
	local args = {...}

	if args[2] == self.NUMBER then
		return self.createNumber(args[1])
	elseif args[2] == self.BOOL then
		return self.createBool(args[1])
	end
end



return self