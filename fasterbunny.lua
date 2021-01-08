-- Авторство
chat.AddText(
	Color(255, 255, 255), 'Скрипт разработал (Telegram ID): ', 
	Color(255, 100, 100), '@sepulturesa'
	)

-- Клиентские ConVar переменные
CreateClientConVar('isBunny', 1, true, false)
CreateClientConVar('isAutoDuck', 1, true, false)

CreateClientConVar('option_GUI_Velocity', 1, true, false)

-- Команда-switch`ер для включения/выключения fasterbunny
concommand.Add('.bunny', function( )
	if GetConVar('isBunny'):GetInt() == 0 then
		
		GetConVar('isBunny'):SetInt(1)
		GetConVar('option_GUI_Velocity'):SetInt(1)
		GetConVar('isAutoDuck'):SetInt(1)

		RunConsoleCommand('+speed')
		chat.AddText(Color(100, 255, 100), '[+] FasterBunny - ON')
	
	else
		GetConVar('isBunny'):SetInt(0)
		GetConVar('option_GUI_Velocity'):SetInt(0)
		GetConVar('isAutoDuck'):SetInt(0)

		RunConsoleCommand('-speed')
		chat.AddText(Color(255, 100, 100), '[-] FasterBunny - OFF')
		timer.Destroy('Bhop')
	end
end )

-- Функция для получения данных об игроке
function GetPlayerData( )
	PlayerVelocity = LocalPlayer():GetVelocity()
	PlayerSpeed = PlayerVelocity:Length()
	Ypos = PlayerVelocity[3]
end

-- Функция для bunnyhop`а
function BunnyScript()
	if GetConVar('isBunny'):GetInt() == 1 then
	 	if input.IsKeyDown(KEY_SPACE) and LocalPlayer():IsOnGround() then
 			RunConsoleCommand('+jump')
 			timer.Create('Bhop', 0, 0, function()
 				RunConsoleCommand('-jump')
 			end )
 		end
 	end
end

-- Функция autoDucking
function AutoDuck( )
	if GetConVar('isAutoDuck'):GetInt() == 1 then
		if LocalPlayer():IsOnGround() == false then
			if math.Round(Ypos) >= 50 then
				RunConsoleCommand('+duck')
			elseif math.Round(Ypos) <= -10 then
				RunConsoleCommand('-duck')
			end
		else
			RunConsoleCommand('-duck')
		end
	end
end

-- Функция для GUI скорости
function GUI_Velocity( )
	if GetConVar('option_GUI_Velocity'):GetInt() == 1 then
		draw.DrawText('Velocity: ' .. math.Round(PlayerSpeed),
			'DermaLarge', 
			50, 
			50, 
			Color(255,255,255,255),
			TEXT_ALIGN_LEFT )
	end
end

-- Проверка NoClip`а
function NoClipChecker( )
	if GetConVar('isBunny'):GetInt() == 1 then
		RunConsoleCommand('.bunny')
		RunConsoleCommand('-duck')
	end
end

-- Hook`и
-- Функционал скрипта:
hook.Add( 'Think', 'GetPlayerData', GetPlayerData ) -- Получение данных об игроке

hook.Add( 'Think', 'AutoDuck', AutoDuck ) -- AutoDucking
hook.Add( 'Think', 'FasterBunnyScript', BunnyScript ) -- Bunnyhop
hook.Add( 'PlayerNoClip', 'NoClipChecker', NoClipChecker ) -- Noclip чекер

-- GUI:
hook.Add( 'HUDPaint', 'FasterBunny_Velocity', GUI_Velocity )
