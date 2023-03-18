local self = {}

self.METHOD = {}

self.maxStack = nil

self.varargs = nil

self.TFORSUB = function(...)
	local args = {...}

	return 'TFORLOOP v' .. tostring(({248, 243, 239, 236, 232})[(math.random(1, 5))]) .. ' ' .. args[1]
end


self.getLines = function(...)
	local args, lines, line, dataLine = {...}, {}, {}, {}

	for value in io.lines(args[1]) do
		if value:match('%.func F%d+') then
			line[#line + 1] = #lines + 1;

			if #line == 2 then
				if line[2] > (line[1] + 2) then
					dataLine[#dataLine + 1] = line
				end

				line = {line[2]}
			end
		end

		if value:match('%.end ; F%d+') then
			line[#line + 1] = #lines + 1;

			if #line == 2 then
				if line[2] > (line[1] + 2) then
					dataLine[#dataLine + 1] = line
				end

				line = {line[2]}
			end
		end

		if value:match('%.linedefined') or value:match('%.lastlinedefined') then
			value = value:gsub('%d+', '999')
		end

		lines[#lines + 1] = value
	end

	for a, n in next, dataLine, nil do
		dataLine[a] = (table.concat(lines, '\n', n[1], n[2])):gsub('%p', function(e)
			return '%' .. e
		end)
	end

	return {
		['line'] = dataLine,
		['lasm'] = table.concat(lines, '\n')
	}
end

self.DUMP = function(...)
	return (string.dump(load((...), ''), false, false))
end

self.METHOD[1] = function(...)
	local scriptData = self.getLines((...))

	for i, sub in next, scriptData.line, nil do
		scriptData.lasm = scriptData.lasm:gsub(sub, function(w)
			local max = string.sub(tostring(math.random(math.maxinteger)), 1, 7)

			w = w:gsub('%.maxstacksize (%d+)', function(m)
				self.maxStack = {
					tostring(m + 1),
					tostring(m + 3),
				}

				return '.maxstacksize 250'
			end)

			w = w:gsub('%.is_vararg (%d+)', function(v)
				self.varargs = tonumber(v) or error()

				return '.is_vararg 250'
			end)

			if self.varargs ~= 1 then
				w = w:gsub('%.numparams (%d+)', '.numparams 250')
			end

			w = w:gsub('\t+%u+.-\n', function(line)
				local doubleMath = line:match('%u+ ([%p%d]+) ([%p%d]+)')
				local stringIn   = (line:match('(%b"")'))
				local numberIn   = (line:match('%u+ ([%p%d]+) v%d+') or line:match('%u+ v%d+ ([%p%d]+)'))
				local opName     = (line:match('%u+'))
				local isLoadK    = (opName == 'LOADK')
				local tempdata   = {}
				local space      = line:match('(.-)%u+')
				local CALLER     = line:match('%u+ v%d+..v%d+$') or line:match('%u+ v%d+$') 

				if doubleMath and tonumber(numberIn) and not isLoadK then
					for num in line:gmatch('([%p%d]+)') do
						parm = #tempdata + 1

						tempdata[parm] = space .. 'LOADK v' .. (self.maxStack[parm]) .. ' ' .. num
					end

					tempdata[#tempdata + 1] = space .. opName .. ' v' .. self.maxStack[1] .. ' v' .. self.maxStack[2]

					return table.concat(tempdata, '\n')
				end

				if stringIn and not isLoadK then
					local randomizeStack = self.maxStack[math.random(1, 2)] + (math.random(1, 9))

					tempdata[#tempdata + 1] = space .. 'LOADK v' .. randomizeStack .. ' ' .. stringIn

					tempdata[#tempdata + 1] = '' .. (line:gsub(stringIn, 'v' .. randomizeStack))

					return table.concat(tempdata, '\n')
				end

				if numberIn and tonumber(numberIn) and #opName > 2 and not isLoadK and opName ~= 'TESTSET' and opName ~= 'LOADBOOL' and opName ~= 'TEST' and opName ~= 'NEWTABLE' and opName ~= 'SETLIST' then
					local randomizeStack = self.maxStack[math.random(1, 2)] + (math.random(1, 9))

					tempdata[#tempdata + 1] = space .. 'LOADK v' .. randomizeStack .. ' ' .. numberIn

					numberIn = numberIn:gsub('%p', function(q)
						return '%' .. q
					end)

					tempdata[#tempdata + 1] = '' .. (line:gsub('%s' .. numberIn, ' v' .. randomizeStack))

					return table.concat(tempdata, '\n')
				end

				if opName == 'RETURN' then
					local newLine = {}

					newLine[1] = line
					newLine[2] = space .. 'RETURN v249..v249'

					return table.concat(newLine, '\n') .. '\n'
				end

				return line
			end)

			return w
		end)
	end

	return scriptData.lasm
end

self.METHOD[2] = function(...)
	local scriptData = self.getLines((...))

	for i, sub in next, scriptData.line, nil do
		scriptData.lasm = scriptData.lasm:gsub(sub, function(w)
			local max = string.sub(tostring(math.random(math.maxinteger)), 1, 7)

			w = w:gsub('\n\n\t+%u+', function(line)
				local temp = {}

				if (line:match('%u+')) and (line:match('%u+') ~= 'JMP') then
					temp[1] = ':goto_' .. max
					temp[2] = 'JMP :goto_' .. (max + 1)
					temp[3] = ':goto_' .. (max + 1)

					max = max + 2
				end

				if #temp > 1 then
					line = '\n' .. table.concat(temp, '\n') .. line
				end

				return line
			end)

			w = w:gsub('\t+:goto_0\n', function(g_0)
				local temp = {}

				temp[1] = 'JMP :goto_0'
				temp[2] = ':goto_0'

				return table.concat(temp, '\n') .. '\n'
			end)

			return w
		end)
	end

	return scriptData.lasm
end

self.METHOD[3] = function(...)
	local scriptData = self.getLines((...))

	for i, sub in next, scriptData.line, nil do
		scriptData.lasm = scriptData.lasm:gsub(sub, function(w)
			local tab = {{}, {}}

			for n, pattern in next, {'\n\t+:goto_%d+\n.-JMP :goto_%d+  ; %+0 ↓.-\n', '\t+:goto_%d+\n\t+%u+.-\n'}, nil do
				w = w:gsub(pattern, function(line)
					line = line:gsub('JMP (:goto_%d+.-\n)', self.TFORSUB)

					if line:match('%CowwxString%[(%d+)%]') and encodes.STORAGE[1][tonumber(line:match('%[(%d+)%]'))] then
						line = line:gsub('%CowwxString%[(%d+)%]', function(num)
							return (encodes.STORAGE[1][tonumber(num)] or error)()
						end)
					end

					line = line .. '\n\tRETURN v249..v249'

					tab[1][#tab[1] + 1], tab[2][line] = line, (math.random(math.maxinteger))

					return '\n'
				end)
			end

			table.sort(tab[1], function(y, x)
				return tab[2][x] < tab[2][y]
			end)

			w = w:gsub('(%.upval.-)""(.-u%d+)\n', function(a, b)
				return a .. ' "\\' .. (math.random(0, 255)) .. '" ' .. b .. '\n'
			end)

			w = w:gsub('\t+JMP :goto_1  ; %+0 ↓.-\n', function(e)
				e = 'MOVE v0 v0\n\nTFORLOOP v'.. (math.random(230, 248)) .. ' GOTO[' .. (math.random(-255, 255)) .. ']\n\nMOVE v0 v0\n\nTFORLOOP v243 GOTO[' .. (math.random(-255, 255)) .. ']\n\nMOVE v0 v0\n\nTFORLOOP v239 GOTO[' .. (math.random(-255, 255)) .. ']\n\nMOVE v0 v0\n\nTFORLOOP v236 GOTO[' .. (math.random(-255, 255)) .. ']\n\nMOVE v0 v0\n\nTFORLOOP v232 GOTO[' .. (math.random(-255, 255)) .. ']\n\nLOADK v249 0\n\nLOADK v244 0\n\nLOADK v240 0\n\nLOADK v237 0\n\nLOADK v233 0\n\nLOADK v229 0\n\n' .. (e:gsub('JMP (:goto_%d+  ; %+0 ↓.-\n)', self.TFORSUB)) .. '\n\nMOVE v0 v0\n\nTFORLOOP v228 GOTO[' .. (math.random(-255, 255)) .. ']\n\nMOVE v1 v1'

				return e .. '\n\n' .. table.concat(tab[1], '\n')
			end)

			return w
		end)
	end

	return scriptData.lasm
end

self.OBFUSCATE = function(...)
	local args, temporaryFile = {...}, os.tmpname()

	gg.internal2(load(self.DUMP(args[1])), temporaryFile)

	for s in pairs(self.METHOD) do
		gg.internal2(load(self.DUMP(args[1])), temporaryFile)
		args[1] = self.DUMP(self.METHOD[s](temporaryFile), os.remove(temporaryFile))
	end

	return args[1]
end

return self