local self = {}

encrypt = self

self.storage, self.TEMP, self.MAIN, self.GLOBAL, self.STRING, self.FORMULA, self.NAME, self.TONUMBER, self.STRING_CHAR, self.TABLE_CONCAT = {['main'] = {}, ['global'] = {}, ['string'] = {}, ['formula'] = {}}, {}, 0, 1, 2, 3, {['main'] = string.random(), ['global'] = string.random()}, string.random(), string.random(), string.random()

self.get = function(...)
	local args = {...}

	if args[1] == self.MAIN then
		return self.storage.main
	elseif args[1] == self.GLOBAL then
		return self.storage.global
	elseif args[1] == self.STRING then
		return self.storage.string
	elseif args[1] == self.FORMULA then
		return self.storage.formula
	end
end

self.INIT = function(...)
	if true then
		gg.toast('Running self initialization...')
	end

	local secure_getinfo = nil

	for i = 1, (math.random(2, 6)) do
		local queue_no = #self.storage.main + 1

		self.storage.main[queue_no] = {
			['keys']   = {},
			['name']   = string.random(),
			['string'] = {}
		}

		for j = 1, (math.random(8, 16)) do
			self.storage.main[queue_no].keys[#self.storage.main[queue_no].keys + 1] = (math.random(6, 66))
			self.storage.main[queue_no].string[#self.storage.main[queue_no].string + 1] = self.TONUMBER .. '(' .. encodes.CHAR_ENCRYPT(tostring(self.storage.main[queue_no].keys[#self.storage.main[queue_no].keys])) .. ')'
		end

		self.storage.main[queue_no].string = 'local ' .. self.storage.main[queue_no].name .. ' = {' .. table.concat(self.storage.main[queue_no].string, ',') .. '}'

		if queue_no > 1 then
			secure_getinfo = {
			encodes.encode((([=[local dginfo = debug.getinfo(Coww_NUMBER(2))]=])), encodes.CHAR_ENCRYPT),
			encodes.encode(((' + (dginfo.linedefined or Coww_NUMBER(' .. (math.random(1, 9)) .. ')) + (dginfo.lastlinedefined or Coww_NUMBER(' .. (math.random(1, 9)) .. ')) + Coww_NUMBER(250) - (dginfo.linedefined or Coww_NUMBER(' .. (math.random(1, 9)) .. ')) - (dginfo.lastlinedefined or Coww_NUMBER(' .. (math.random(1, 9)) .. ')) - (dginfo.nparams or Coww_NUMBER(' .. (math.random(1, 9)) .. ')) + Coww_NUMBER(1) - (dginfo.nups or Coww_NUMBER(' .. (math.random(1, 9)) .. ')) ')), encodes.CHAR_ENCRYPT),
			}

			local queue_global = #self.storage.global + 1

			self.storage.global[queue_global] = {
				['keys']   = {},
				['name']   = string.random(),
				['source'] = {self.storage.main[(queue_no - 1)], self.storage.main[queue_no]}
			}

			self.storage.global[queue_global].formula = formula.create(self.storage.global[queue_global].source)

			self.storage.global[queue_global].string, self.storage.main[queue_no].string = {self.storage.global[queue_global].name, obfuscate.getRandomBoolMini(({'true', 'false'})[(math.random(1, 2))], ('(vas ' .. self.storage.global[queue_global].formula[3]:gsub('%[(%d+)%]', function(t)
				return '[' .. bitwise.create(t, bitwise.NUMBER) .. ']'
			end) .. ') ' .. secure_getinfo[2]))}, self.storage.main[queue_no].string .. ';local ' .. self.storage.global[queue_global].name .. '={};'

			for i, m in next, self.storage.global[queue_global].source, nil do
				self.storage.string[#self.storage.string + 1] = ([=[
				for num, vas in _G[]=]) .. encodes.CHAR_ENCRYPT('ipairs') .. ([=[](]=]) .. m.name .. ([=[) do
					]=]) .. secure_getinfo[1] .. ' ' .. self.storage.global[queue_global].name .. '[#' .. self.storage.global[queue_global].name .. ' + (' .. bitwise.create(1, bitwise.NUMBER) .. ')] = ' .. self.storage.global[queue_global].string[2] .. ([=[
				end]=])

				self.TEMP[self.storage.string[#self.storage.string]] = math.random(math.maxinteger)

				for n, j in next, m.keys, nil do
					self.storage.global[queue_global].keys[#self.storage.global[queue_global].keys + 1] = (self.storage.global[queue_global].formula[4](j, table.unpack(self.storage.global[queue_global].source)))
				end
			end
		end
	end

	self.storage.formula[1], self.storage.formula[2] = formula.create(self.storage.main, true), formula.create(self.storage.global, true)
end



return self