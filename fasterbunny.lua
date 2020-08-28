chat.AddText(
	Color(255, 255, 255), 'Скрипт разработал (Telegram ID): ', 
	Color(255, 100, 100), '@amikoqfree'
	)
--

local isBunny = false -- включен ли bhop
local isSilent = false

concommand.Add('.bunny', function( )
	if isBunny == false then
		isBunny = true
		RunConsoleCommand('+speed')

		if isSilent == false then
			chat.AddText(Color(100, 255, 100), '[+] FasterBunny - ON')
		end
	else
		isBunny = false
		RunConsoleCommand('-speed')
		timer.Destroy('Bhop')

		if isSilent == false then
			chat.AddText(Color(255, 100, 100), '[-] FasterBunny - OFF')
		end
	end
end )

concommand.Add('+silent', function( )
	if isSilent == false then
		isSilent = true
		print('FasterBunny | Silent mode - ON')
	end
end)

concommand.Add('-silent', function( )
	if isSilent then
		isSilent = false
		print('FasterBunny | Silent mode - OFF')
	end
end)


function FasterBunny(  )
	if isBunny then
		if input.input.WasKeyTyped(65) and LocalPlayer():IsOnGround() then
			RunConsoleCommand('+jump')
			timer.Create('Bhop', 0, 0.01, function( )
				RunConsoleCommand('-jump')
			end)
		else
			RunConsoleCommand('-jump')
		end
	end
end

hook.Add('FasterBunny', 'BunnyHop', FasterBunny)