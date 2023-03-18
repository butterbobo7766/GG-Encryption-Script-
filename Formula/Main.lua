local self = {}

self.randMax = function()
	return (math.random(math.maxinteger))
end

self.formulaReturn = {{}, {}, {}}

self.formulaType   = {
		{
			'+',
			'-'
		},
		{
			'-',
			'+'
		},
		{
			'+',
			'+'
		},
		{
			'-',
			'-'
		},
		{
			'%',
			'%'
		},
		{
			'*',
			'*'
		}
	}

self.formulaTemp = {}

self.multipleFormulaIsEnabled = false

self.count = 0

self.create = function(...)
	local formulaArgs = {...}

	self.formulaReturn = {{}, {}, {}}

	self.formulaTemp   = {}

	self.multipleFormulaIsEnabled = false

	for int, data in next, formulaArgs[1], nil do
		for x, y in next, data.keys, nil do
			local build_formula_itself, formulaSymbol, nameInput = {}, self.formulaType[(math.random(1, 2))], (data.name or '({...})[' .. int .. ']') .. '[' .. x .. ']'

			if formulaArgs[2] and formulaArgs[2] == true then
				nameInput = obfuscate.getRandomBoolMini(({'true', 'false'})[(math.random(1, 2))], (data.name or '({...})[' .. int .. ']') .. '[' .. obfuscate.getRandomBoolMini(({'false', 'true'})[(math.random(1, 2))], x) .. ']')
			end

			if x > 1 and x < (#data.keys - 1) and not multipleFormulaIsEnabled and math.random(1, 2) == 2 then
				multipleFormulaIsEnabled = true

				build_formula_itself[1] = formulaSymbol[1] .. '(({...})[' .. (int + 1) .. '].keys[' .. x .. ']'
				build_formula_itself[2] = formulaSymbol[2] .. '(' .. nameInput
				build_formula_itself[3] = formulaSymbol[1] .. '(' .. nameInput
			end

			if multipleFormulaIsEnabled and math.random(1, 8) == 4 and #build_formula_itself < 3 then
				formulaSymbol, multipleFormulaIsEnabled = self.formulaType[(math.random(3, 6))], false

				build_formula_itself[1] = formulaSymbol[1] .. '({...})[' .. (int + 1) .. '].keys[' .. x .. '])'
				build_formula_itself[2] = formulaSymbol[2] .. nameInput .. ')'
				build_formula_itself[3] = formulaSymbol[1] .. nameInput .. ')'
			end

			if multipleFormulaIsEnabled and #build_formula_itself < 3 then
				formulaSymbol = self.formulaType[(math.random(3, 6))]
			end

			if x < #data.keys and multipleFormulaIsEnabled and #build_formula_itself < 3 then
				formulaSymbol, multipleFormulaIsEnabled = self.formulaType[(math.random(3, 6))], false

				build_formula_itself[1] = formulaSymbol[1] .. '({...})[' .. (int + 1) .. '].keys[' .. x .. '])'
				build_formula_itself[2] = formulaSymbol[2] .. nameInput .. ')'
				build_formula_itself[3] = formulaSymbol[1] .. nameInput .. ')'
			end

			if #build_formula_itself < 3 then
				build_formula_itself[1] = formulaSymbol[1] .. '({...})[' .. (int + 1) .. '].keys[' .. x .. ']'
				build_formula_itself[2] = formulaSymbol[2] .. nameInput
				build_formula_itself[3] = formulaSymbol[1] .. nameInput
			end

			local formulaRandomPlace = self.randMax()

			self.formulaTemp[build_formula_itself[1]], self.formulaTemp[build_formula_itself[2]], self.formulaTemp[build_formula_itself[3]] = formulaRandomPlace, formulaRandomPlace, formulaRandomPlace

			if formulaSymbol == self.formulaType[1] or formulaSymbol == self.formulaType[2] then 
				table.insert(self.formulaReturn[1], build_formula_itself[1])
				table.insert(self.formulaReturn[2], build_formula_itself[2])
				table.insert(self.formulaReturn[3], build_formula_itself[3])
				else
					self.formulaReturn[1][#self.formulaReturn[1]] = self.formulaReturn[1][#self.formulaReturn[1]] .. build_formula_itself[1]
					self.formulaReturn[2][#self.formulaReturn[2]] = self.formulaReturn[2][#self.formulaReturn[2]] .. build_formula_itself[2]
					self.formulaReturn[3][#self.formulaReturn[3]] = self.formulaReturn[3][#self.formulaReturn[3]] .. build_formula_itself[3]

					self.formulaTemp[self.formulaReturn[1][#self.formulaReturn[1]]], self.formulaTemp[self.formulaReturn[2][#self.formulaReturn[2]]], self.formulaTemp[self.formulaReturn[3][#self.formulaReturn[3]]] = formulaRandomPlace, formulaRandomPlace, formulaRandomPlace
			end
		end
	end

	for int = 1, 3 do
		table.sort(self.formulaReturn[int], function(x, y)
			return self.formulaTemp[y] < self.formulaTemp[x]
		end)

		self.formulaReturn[int] = table.concat(self.formulaReturn[int])
	end

	self.formulaReturn[4] = load('return (function(...) return ({...})[1]' .. self.formulaReturn[1] .. ' end)', '')()

	return self.formulaReturn
end

return self