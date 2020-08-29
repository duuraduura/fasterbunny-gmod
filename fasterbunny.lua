chat.AddText(
	Color(255, 255, 255), 'Скрипт разработал (Telegram ID): ', 
	Color(255, 100, 100), '@amikoqfree'
	)
--

-- Переменные
CreateClientConVar('isBunny', 1, true, false)
local ply = LocalPlayer()
--

concommand.Add('.bunny', function( )
	if GetConVar('isBunny'):GetInt() == 0 then
		GetConVar('isBunny'):SetInt(1)
		RunConsoleCommand('+speed')
		chat.AddText(Color(100, 255, 100), '[+] FasterBunny - ON')
	
	else
		GetConVar('isBunny'):SetInt(0)
		RunConsoleCommand('-speed')
		chat.AddText(Color(255, 100, 100), '[-] FasterBunny - OFF')
		timer.Destroy('Bhop')
	end
end )

function Bunnyhop()
	if GetConVar('isBunny'):GetInt() == 1 then
	 	if input.IsKeyDown(KEY_SPACE) then
	 		if ply:IsOnGround() then
	 			RunConsoleCommand('+jump')

	 			timer.Create('Bhop', 0, 0, function()
	 				RunConsoleCommand('-jump')
	 			end )
	 		end
 		end
 	end
end

hook.Add( 'Think', 'FasterBunnyScript', Bunnyhop )