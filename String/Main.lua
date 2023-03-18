local self, total_random = string, 0

self.random = function(...)
	local max, data = (({...})[1] or math.random(2, 5));

	total_random    = total_random + 1;

	if ({...})[2] then
		data = ""

		for n = 1, max do
			data = data .. "\\" .. ({'x' .. string.format('%02x', math.random(255)), 'x' .. string.format('%02X', math.random(255,512)), math.random(0, 255)})[math.random(1, 3)];
		end

		data = data .. "\\x" .. string.format('%02X', total_random)

		else
			data, number = {({
				'_',
				string.char(math.random(65, 90)),
				string.char(math.random(97, 122)),
			})[math.random(1, 3)]}, {string.byte(total_random, 1, -1)};

			for n = 1, max do
				data[#data + 1] = ({
					'_',
					math.random(0, 9),
					string.char(math.random(65, 90)),
					string.char(math.random(97, 122)),
				})[math.random(1, 4)];
			end

			for n = 1, #number do
				j = math.random(2, #data)
				data[j] = data[j] .. string.char(number[n]);
			end

			data = table.concat(data, string.char());
	end

	return data
end


return self