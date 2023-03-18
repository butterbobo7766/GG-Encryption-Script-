local configuration, input_file, output_file = {
	['version']     = tonumber(tostring("8.0")),
	['status']      = 'Release',
	['config_path'] = gg.EXT_CACHE_DIR .. "/" .. ".CowwNS_Encryption_Configuration",
	['default_cfg'] = function()
		return {
		[1] = gg.getFile(),
	}
	end
}, '', '', gg.sleep(100), gg.setVisible(false), math.randomseed(os.time())

bitwise       = require('Bitwise/Main')
string        = require('String/Main')
formula       = require("Formula/Main")
encodes       = require("Encodes/Main")
encrypt       = require('Encrypt/Main')
obfuscate     = require('Obfuscate/Main')
LASMObfuscate = require('LASMObfuscate/Main')
binary        = require('Binary/Main')

encrypt.INIT()

scripts = require('Scripts/Main')

while true do
	::main_script::

	encrypt_info = gg.prompt({
		'📁 請選擇需要加密的檔案:',
	}, (loadfile(configuration.config_path) or configuration.default_cfg)(), {
		'file',
	})

	if not encrypt_info then
		local selfalert = gg.alert('🩲 真的決定要離開嗎？ \n\n😭 真的嗎？真的嗎？ ', '返回', '確定')

		if selfalert == 2 then
			while (0x9 == 0x9) do
				repeat
					local _G, _ENV =  os.exit();
				until false == true
			end
		end
	
		goto main_script
	end

	if not encrypt_info[1] or not loadfile(encrypt_info[1]) then
		while (#_G == #_ENV) do
			repeat
				local _G, _ENV =  os.exit();
			until false == true
		end
	end

	gg.saveVariable(encrypt_info ,configuration.config_path);

	input_file, output_file, input_path = encrypt_info[1], encrypt_info[1]:gsub('/([^/]+)$', function(i)
		return '/🐮' .. (i:gsub('.lua$', '')) .. '[密].lua'
	end), encrypt_info[1]:gsub('/[^/]+$', '') .. '/'

	if io.open(output_file) then
		os.remove(output_file)
	end

	gg.toast('⏳ 檔案正在加密，請耐心等候...')

	encryptedScript = scripts.GET_ENCRYPTED((io.input(input_file):read("*a")))

	gg.toast('⏳ 檔案正在加密，請耐心等候...')

	gg.sleep(100)

	gg.toast('⏳ 檔案正在加密，請耐心等候...')

	encryptedScript = LASMObfuscate.OBFUSCATE(encryptedScript)

	encryptedScript = binary.DUMP(encryptedScript)

	io.output(output_file):write(encryptedScript)

	print('🩲 檔案已成功加密 : ' .. output_file)

	gg.alert('📂 檔案輸出到 : \n\n📂 ' .. output_file)

	break
end -- while