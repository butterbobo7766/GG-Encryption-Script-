local self = {}

scripts = self

self.STORAGE, self.GLOBAL_FUNC, self.STRING_CHAR, self.TABLE_UNPACK, self.TABLE_CONCAT, self.TONUMBER = {{}, {}}, string.random(), encrypt.STRING_CHAR, string.random(), encrypt.TABLE_CONCAT, encrypt.TONUMBER

self.STORAGE[1][1] = (function()
	local HEMAT_CONCAT, TEMP, HEMAT_DONE = {
		{
			'(Coww_BOOL(true) and string.char' .. ')',
			'(Coww_BOOL(false) and table.concat' .. ')',
		},
		{
			'(Coww_BOOL(true) and table.unpack' .. ')',
			'(Coww_BOOL(false) and string.char' .. ')',
		},
		{
			'(Coww_BOOL(true) and table.concat' .. ')',
			'(Coww_BOOL(false) and string.pack' .. ')',
		},
		{
			'(Coww_BOOL(true) and _G["tonumber"]' .. ')',
			'(Coww_BOOL(false) and _G["tostring"]' .. ')',
		}
	}, {{}, {}, {}, {}}

	for i in next, HEMAT_CONCAT, nil do
		for j in next, HEMAT_CONCAT[i], nil do
			TEMP[i][HEMAT_CONCAT[i][j]] = math.random(math.maxinteger)
		end
	end

	table.sort(HEMAT_CONCAT[1], function(x, y)
		return TEMP[1][y] < TEMP[1][x]
	end)

	table.sort(HEMAT_CONCAT[2], function(x, y)
		return TEMP[2][y] < TEMP[2][x]
	end)

	HEMAT_DONE = 'local ' .. self.STRING_CHAR .. ',' .. self.TABLE_UNPACK .. ',' .. self.TABLE_CONCAT .. ',' .. self.TONUMBER .. '=' .. table.concat(HEMAT_CONCAT[1], ' or ') .. ',' .. table.concat(HEMAT_CONCAT[2], ' or ') .. ',' .. table.concat(HEMAT_CONCAT[3], ' or ') .. ',' .. table.concat(HEMAT_CONCAT[4], ' or ')

	return (encodes.encode(HEMAT_DONE .. ([=[
		gg.setVisible(Coww_BOOL(false))
		]=]), encodes.BYTE_CHAR_ORIG))
end)()

self.STORAGE[1][2] = (function()
	local keys_main, final_main_keys, auto_random = encrypt.get(encrypt.MAIN), {}, {}

	for n in next, keys_main, nil do
		final_main_keys[#final_main_keys + 1] = keys_main[n].string
		auto_random[#auto_random + 1] = keys_main[n].name .. '[Coww_NUMBER(' .. (math.random(1, #keys_main[n].keys)) .. ')] = ' .. keys_main[n].name .. '[Coww_NUMBER(' .. (math.random(1, #keys_main[n].keys)) .. ')] & ' .. keys_main[n].name .. '[Coww_NUMBER(' .. (math.random(1, #keys_main[n].keys)) .. ')]'
	end

	local functionName, ggFunctionName, resultFunction = {
		{
			'io.input',
			'io_input'
		},
		{
			'io.read',
			'io_read'
		},
		{
			'io.open',
			'io_open'
		},
		{
			'io.write',
			'io_write'
		},
		{
			'string.match',
			'string_match'
		},
		{
			'string.gsub',
			'string_gsub'
		},
	}, {}, {{}, {}}

	for name, replace in next, functionName, nil do
		resultFunction[1][#resultFunction[1] + 1] = ([=[
		]=]) .. replace[1] .. ([=[ = function(...)
			if true then
				for n = Coww_NUMBER(3), Coww_NUMBER(4) do
					if pcall(debug.getinfo, n) then
						if debug.getinfo(n).what and debug.getinfo(n).what == 'main' and (debug.getinfo(n).func) and not string.match(tostring(debug.getinfo(n).func), script_name_regex) or debug.getinfo(n).what and debug.getinfo(n).what == 'main' then
							]=]) .. table.concat(auto_random, '\n') .. ([=[
						end
					end
				end
				return ]=]) .. replace[2] .. ([=[(...)
			end
		end
		]=])

		resultFunction[2][resultFunction[1][#resultFunction[1]]] = (math.random(math.maxinteger))
	end

	for name, replace in next, ggFunctionName, nil do
		resultFunction[1][#resultFunction[1] + 1] = ([=[
		]=]) .. replace[1] .. ([=[ = function(...)
			if true then
				for n = Coww_NUMBER(3), Coww_NUMBER(4) do
					if pcall(debug.getinfo, n) then
						if debug.getinfo(n).what and debug.getinfo(n).what == 'main' and (debug.getinfo(n).func) and not string.match(tostring(debug.getinfo(n).func), script_name_regex) or debug.getinfo(n).what and debug.getinfo(n).what == 'main' then
							]=]) .. table.concat(auto_random, '\n') .. ([=[
						end
					end
				end
				gg.setVisible(]=]) .. bitwise.create('false', bitwise.BOOL) .. ([=[)
				local temp, temp1, temp2, orig = gg_searchNumber((TEMPORARY_CODES[Coww_NUMBER(1)]), Coww_NUMBER(4)), gg_addListItems(TEMPORARY_CODES[Coww_NUMBER(2)]), gg.removeListItems(TEMPORARY_CODES[Coww_NUMBER(2)]), ]=]) .. replace[2] .. ([=[(...)
				if gg.isVisible(Coww_BOOL(true)) then
					while true do
						if true then
							while true do
							end
						end
					end
				end
				return orig
			end
		end
		]=])

		resultFunction[2][resultFunction[1][#resultFunction[1]]] = (math.random(math.maxinteger))
	end

	table.sort(resultFunction[1], function(y, x)
		return resultFunction[2][x] < resultFunction[2][y]
	end)

	return (table.concat(final_main_keys, '\n') .. encodes.encode(((([=[

	gg.toast("🛡 Noob️ Encryption by 🐮Butter ")

	if true then
		if string.match('/' .. tostring(os.time()), '/([^/]+)$') ~= tostring(os.time()) then
			while true do
				if true then
					gg.alert('Error, time is not acceptable.')
					os.exit()
				end
				if false then
				end
			end
		end
	end

	local script_name_regex, script_data = gg.getFile():gsub('%p', function(...)
	return '%' .. (...)
	end), (io.input(gg.getFile()):read('*a'))

	if pcall(debug.getinfo, Coww_NUMBER(1)) and pcall(debug.getinfo, Coww_NUMBER(2)) and pcall(debug.getinfo, Coww_NUMBER(3)) and string.match(debug.traceback(), script_name_regex) then
		if not debug.getinfo(Coww_NUMBER(1)).func == debug.getinfo and not debug.getinfo(Coww_NUMBER(1)).what == 'Java' and not debug.getinfo(Coww_NUMBER(1)).source == '=[Java]' and not debug.getinfo(Coww_NUMBER(1)).short_src == '[Java]' then
			while true do
				if true then
					gg.alert('Error, java info is not same.')
					os.exit()

					if false then
						if true then
						end
					end
				end
			end
		end

		if not string.match(tostring(debug.getinfo(Coww_NUMBER(2)).func), script_name_regex) and not debug.getinfo(Coww_NUMBER(2)).what == 'Lua' and not string.match(debug.getinfo(Coww_NUMBER(2)).source, script_name_regex) and not string.match(debug.getinfo(Coww_NUMBER(2)).short_src, script_name_regex) then
			while true do
				if true then
					gg.alert('Error, selfinfo is not same.')
					os.exit()
					if false then
						if true then
						end
					end
				end
			end
		end

		if not string.match(tostring(debug.getinfo(Coww_NUMBER(3)).func), script_name_regex) and not debug.getinfo(Coww_NUMBER(3)).what == 'main' and not string.match(debug.getinfo(Coww_NUMBER(3)).source, script_name_regex) and not string.match(debug.getinfo(Coww_NUMBER(3)).short_src, script_name_regex) then
			while true do
				if true then
					gg.alert('Error, selfsecondinfo is not same.')

					if false then
						if true then
						end
					end
				end
			end
		end
	end

	local short_name, script_header = string.match(gg.getFile(), '/([^/]+)$'), (string.sub(script_data, (Coww_NUMBER(1)), (Coww_NUMBER(12))))

	os.rename(short_name, '..' .. short_name)

	if string.byte(script_header, -(Coww_NUMBER(1)), -(Coww_NUMBER(1))) ~= (Coww_NUMBER(4)) then
		]=]) .. table.concat(auto_random, ';') .. ([=[
	end

loadfile('..' .. short_name) 
os.rename('..' .. short_name, short_name) 

	local TEMPORARY_CODES = {{}, {}}

	for n = Coww_NUMBER(1), Coww_NUMBER(10000) do
		TEMPORARY_CODES[Coww_NUMBER(1)][#TEMPORARY_CODES[Coww_NUMBER(1)] + 1], TEMPORARY_CODES[Coww_NUMBER(2)][#TEMPORARY_CODES[Coww_NUMBER(2)] + 1] = utf8.char(math.random(Coww_NUMBER(10000), Coww_NUMBER(16000))), {
			['flags'] = Coww_NUMBER(4),
			['address'] = Coww_NUMBER(110) + n,
		}
	end

	TEMPORARY_CODES[Coww_NUMBER(1)] = (string.rep(string.rep((table.concat(TEMPORARY_CODES[Coww_NUMBER(1)])), Coww_NUMBER(999)), Coww_NUMBER(2)))

	assert(not (gg.setVisible(Coww_BOOL(false))))

	local io_input, io_read, io_open, io_write, string_gsub, string_match, gg_searchNumber, gg_editAll, gg_addListItems = io.input, io.read, io.open, io.write, string.gsub, string.match, gg.searchNumber, gg.editAll, gg.addListItems

	]=]) .. table.concat(resultFunction[1], '\n') .. ([=[

		]=])):gsub('\t+', ''):gsub('\n', ' ')), encodes.CHAR_ENCRYPT) .. table.concat(encrypt.get(encrypt.STRING), '\n'))
end)()

self.STORAGE[1][3] = (function()
	local numRandom = {(math.random(1, 9)), (math.random(1, 9))}

	local fakeShit  = {{}, {}}

	for j = 5, math.random(6, 16) do
		fakeShit[1][#fakeShit[1] + 1] = '["' ..string.random() .. '"] = Coww_NUMBER(' .. (math.random(1, 9)) .. ')'
		fakeShit[2][#fakeShit[2] + 1] = '["' ..string.random() .. '"] = Coww_NUMBER(' .. (math.random(1, 9)) .. ')'
	end

	return (encodes.encode(((([=[
	local save_char, itsChars, len = {}, {}, Coww_NUMBER(1)

	if true then
		repeat
			itsChars[#itsChars + Coww_NUMBER(1)] = ]=]) .. self.STRING_CHAR .. ([=[(Coww_NUMBER(255) - len)
			len = len + Coww_NUMBER(1)
		until len > Coww_NUMBER(255)
	end

	local ]=]) .. self.GLOBAL_FUNC .. ([=[ = function(...)
		local args, xchars = {...}, {}

		if not save_char[args[Coww_NUMBER(3)]] then
			if true then
				local xnumber = {Coww_NUMBER(]=]) .. numRandom[1] .. ([=[) - Coww_NUMBER(]=]) .. numRandom[1] .. ([=[), Coww_NUMBER(]=]) .. numRandom[2] .. ([=[) - Coww_NUMBER(]=]) .. numRandom[2] .. ([=[), string.byte(args[Coww_NUMBER(2)]), (args[Coww_NUMBER(3)])}
				local dginf = Coww_BOOL(false) and ({]=]) .. table.concat(fakeShit[1], ',') .. ([=[}) or not Coww_BOOL(true) and ({]=]) .. table.concat(fakeShit[2], ',') .. ([=[}) or not Coww_BOOL(false) and debug.getinfo(Coww_NUMBER(3)), debug.getinfo(Coww_NUMBER(4))

				for n = Coww_NUMBER(3), Coww_NUMBER(4) do
					if pcall(debug.getinfo, n) then
						local debug_data = (debug.getinfo(n))
						if debug_data.what and debug_data.what == 'main' and not ((debug_data.linedefined) == -(Coww_NUMBER(1))) and not ((debug_data.lastlinedefined) == -(Coww_NUMBER(1))) then
							xnumber[Coww_NUMBER(1)], xnumber[Coww_NUMBER(2)] = (xnumber[Coww_NUMBER(1)] + (Coww_NUMBER(7) * Coww_NUMBER(2))), (xnumber[Coww_NUMBER(2)] + (Coww_NUMBER(5) * Coww_NUMBER(3)))
							else
								xnumber[Coww_NUMBER(1)], xnumber[Coww_NUMBER(2)] = (xnumber[Coww_NUMBER(1)] + (Coww_NUMBER(2) * Coww_NUMBER(2))), (xnumber[Coww_NUMBER(2)] + (Coww_NUMBER(4) * Coww_NUMBER(2)))
						end
					end
				end

				for t, n in next, {string.byte(args[Coww_NUMBER(1)], Coww_NUMBER(1), -(Coww_NUMBER(1)))}, nil do
					xchars[#xchars + Coww_NUMBER(1)] = itsChars[(((((n FORMULA_Coww(1)) FORMULA_Coww(2)) - (((xnumber[Coww_NUMBER(3)] * (xnumber[Coww_NUMBER(4)] - xnumber[Coww_NUMBER(1)]) * t * (string.byte(script_header, -(Coww_NUMBER(1)), -(Coww_NUMBER(1))))) * xnumber[Coww_NUMBER(2)]) * (string.byte(script_header, -(Coww_NUMBER(1)), -(Coww_NUMBER(1)))))) % Coww_NUMBER(256)) + (dginf.linedefined) - (dginf.lastlinedefined) + (dginf.currentline) - (dginf.lastlinedefined) + (dginf.nparams) - (dginf.nparams) + (dginf.nups + dginf.lastlinedefined) - (dginf.linedefined + dginf.nups) + (dginf.nparams + dginf.linedefined) - (dginf.nparams + dginf.lastlinedefined))]
				end

				if true then
					save_char[args[Coww_NUMBER(3)]] = (]=]) .. self.TABLE_CONCAT .. ([=[(xchars))
				end
			end
		end

		return ((save_char[args[Coww_NUMBER(3)]]))
	end
		]=])):gsub('\t+', ''):gsub('\n', ' ')), encodes.CHAR_ENCRYPT):gsub('%FORMULA%_Coww%(%d+%)', function(q)
			local w = q:match('%d+')
				if w then
					q = (encrypt.get(encrypt.FORMULA))[tonumber(w or error())][2]
				end
			return q
		end))
end)()


self.GET_ENCRYPTED = function(...)
	local encryptedScript = encodes.encode((...), encodes.GLOBAL_ENCRYPT)

	return (string.dump(load(([=[
	return (function()
		return (function()
			]=]) .. (self.STORAGE[1][1] .. ([=[

			local gchar = {]=]) .. table.concat(obfuscate.get(), ',') .. ([=[}

			]=]) .. self.STORAGE[1][2] .. '\n' .. self.STORAGE[1][3]) .. ([=[

			;(function()
			
			
			]=]) .. encryptedScript .. ([=[
			
			
			end)()
		end)()
	end)("🛡 Noob️ Encryption by 🐮Butter ")
		]=]), '🛡 Noob️ Encryption by 🐮Butter '), true, true))
end

return self