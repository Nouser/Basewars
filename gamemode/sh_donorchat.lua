if (SERVER) then
	AddCSLuaFile("sh_donorChat.lua")
end

if (CLIENT) then

	function DonorChat( player, strText, bTeamOnly, bPlayerIsDead )

		local tab = { }
		
		if ( bPlayerIsDead ) then
			table.insert( tab, Color( 255, 30, 40 ) )
			table.insert( tab, "(DEAD) " )
		end
		
		if ( bTeamOnly ) then
			table.insert( tab, Color( 168, 255, 0 ) )
			table.insert( tab, "(TEAM) " )
		end
		
		if ( player:GetNWString("usergroup") == "founder" ) then

				table.insert( tab, Color( 255, 255, 255 ) )
				table.insert( tab, "[" )
				table.insert( tab, Color( 205, 92, 92 ) )
//				table.insert( tab, Color(0, math.abs( math.sin(CurTime() * 2) ) * 198, math.abs( math.sin(CurTime() * 2) ) * 24) )
				table.insert( tab, "Founder" )
				table.insert( tab, Color( 255, 255, 255 ) )
				table.insert( tab, "] " )
			
			end

		if ( player:GetNWString("usergroup") == "community manager" ) then

				table.insert( tab, Color( 255, 255, 255 ) )
				table.insert( tab, "[" )
				table.insert( tab, Color( 51, 223, 25 ) )
				table.insert( tab, "CM" )
				table.insert( tab, Color( 255, 255, 255 ) )
				table.insert( tab, "] " )
			
			end
			
		if ( player:GetNWString("usergroup") == "trial" ) then
		
				table.insert( tab, Color( 255, 255, 255 ) )
				table.insert( tab, "[" )
			
				table.insert( tab, Color( 0, 0, 255 ) )
				table.insert( tab, "Trial" )
			
				table.insert( tab, Color( 255, 255, 255 ) )
				table.insert( tab, "] " )
			
			end
			
		if ( player:GetNWString("usergroup") == "donor01" ) then
		
				table.insert( tab, Color( 255, 255, 255 ) )
				table.insert( tab, "[" )
			
				table.insert( tab, Color( 51, 204, 255 ) )
				table.insert( tab, "VIP" )
			
				table.insert( tab, Color( 255, 255, 255 ) )
				table.insert( tab, "] " )
			
			end
		if ( player:GetNWString("usergroup") == "donor02" ) then
		
				table.insert( tab, Color( 255, 255, 255 ) )
				table.insert( tab, "[" )
			
				table.insert( tab, Color( 127, 255, 0 ) )
				table.insert( tab, "VIP" )
			
				table.insert( tab, Color( 255, 255, 255 ) )
				table.insert( tab, "] " )
			
			end
		if ( player:GetNWString("usergroup") == "donor03" ) then
		
				table.insert( tab, Color( 255, 255, 255 ) )
				table.insert( tab, "[" )
			
				table.insert( tab, Color( 51, 204, 255 ) )
				table.insert( tab, "VIP" )
			
				table.insert( tab, Color( 255, 255, 255 ) )
				table.insert( tab, "] " )
			
			end
		if ( player:GetNWString("usergroup") == "junior moderator" ) then

				table.insert( tab, Color( 255, 255, 255 ) )
				table.insert( tab, "[" )
				
				table.insert( tab, Color( 51, 204, 255 ) )
				table.insert( tab, "Jr Mod" )
				
				table.insert( tab, Color( 255, 255, 255 ) )
				table.insert( tab, "] " )
			
			end
		if ( player:GetNWString("usergroup") == "moderator" ) then

				table.insert( tab, Color( 255, 255, 255 ) )
				table.insert( tab, "[" )
				
				table.insert( tab, Color( 51, 204, 255 ) )
				table.insert( tab, "Mod" )
				
				table.insert( tab, Color( 255, 255, 255 ) )
				table.insert( tab, "] " )
			
			end
		if ( player:GetNWString("usergroup") == "super moderator" ) then

				table.insert( tab, Color( 255, 255, 255 ) )
				table.insert( tab, "[" )
				
				table.insert( tab, Color( 51, 204, 255 ) )
				table.insert( tab, "Super Mod" )
				
				table.insert( tab, Color( 255, 255, 255 ) )
				table.insert( tab, "] " )
			
			end
		if ( player:GetNWString("usergroup") == "junior admin" ) then

				table.insert( tab, Color( 255, 255, 255 ) )
				table.insert( tab, "[" )
				
				table.insert( tab, Color( 0, 0, 160 ) )
				table.insert( tab, "Jr Admin" )
				
				table.insert( tab, Color( 255, 255, 255 ) )
				table.insert( tab, "] " )
			
			end
		if ( player:GetNWString("usergroup") == "admin" ) then

				table.insert( tab, Color( 255, 255, 255 ) )
				table.insert( tab, "[" )
				
				table.insert( tab, Color( 128, 255, 0 ) )
				table.insert( tab, "Admin" )
				
				table.insert( tab, Color( 255, 255, 255 ) )
				table.insert( tab, "] " )
			
			end
		if ( player:GetNWString("usergroup") == "superadmin" ) then

				table.insert( tab, Color( 255, 255, 255 ) )
				table.insert( tab, "[" )
				
				table.insert( tab, Color( 255, 69, 0 ) )
				table.insert( tab, "Super Admin" )
				
				table.insert( tab, Color( 255, 255, 255 ) )
				table.insert( tab, "] " )
			
			end			
		if ( player:GetNWString("usergroup") == "developer") then
				table.insert(tab, Color(0,127,255,255))
				table.insert(tab, "[")
				table.insert(tab, Color(127,0,255,255))
				table.insert(tab, "Developer")
				table.insert(tab, Color(0,127,255,255))
				table.insert(tab, "]")
			end					
			
		if ( IsValid( player ) ) then
			table.insert( tab, player )
		else
			table.insert( tab, "Console" )
		end
			
		table.insert( tab, Color( 255, 255, 255 ) )
		table.insert( tab, ": "..strText )
		
		chat.AddText( unpack(tab) )
		
		return true
	end
	hook.Add("OnPlayerChat", "InsertDonorChat", DonorChat)

	
end