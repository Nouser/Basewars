
ChatCommands = { }

--Usage:
--Chat command, Callback, Should the prefix stay constant?
function AddChatCommand( cmd, callback, prefixconst )

	table.insert( ChatCommands, { cmd = cmd, callback = callback, prefixconst = prefixconst } );

end

function GM:PlayerSay( ply, text )
	ply:ClearAFK()
	self.BaseClass:PlayerSay( ply, text );

	local ftext = string.lower( text );
	
	local subArgs = string.Explode(" ", ftext)
	/*
	if(ply:GetUserGroup() == "junior admin") then
		for k,v in pairs(subArgs) do
			ply:PrintMessage(HUD_PRINTTALK,"subArgs["..k.."]: " .. v)
		end
	end
	*/
	if(subArgs[1] != nil) then
		if(string.lower(subArgs[1]) == "!raidpanel") then
			if(ply:GetUserGroup() == "moderator" || ply:GetUserGroup() == "junior moderator" || ply:GetUserGroup() == "admin" || ply:GetUserGroup() == "junior admin" || ply:GetUserGroup() == "developer" || ply:GetUserGroup() == "founder" || ply:GetUserGroup() == "community manager" || ply.GetUserGroup() == "superadmin") then
				//Send Ongoing Raids Info in the form of, Raided, Raider, Target Index.
				//Then Send the command to open up the panel.
				ply:SendLua("GAMEMODE:RaidPanelClear()")
				for k,v in pairs(self.OngoingRaids) do
					ply:SendLua("GAMEMODE:RaidPanelGet("..v.Raided..","..v.Raider..","..v.TargetIndex..","..(v.StartTime - CurTime())..","..k..")")
				end
				ply:SendLua("GAMEMODE:RaidPanelOpen(0)")
				
			else
				ply:PrintMessage(HUD_PRINTTALK,"Error! You have insufficient permissions.")
				return ""
			end
		elseif(string.lower(subArgs[1]) == "!raidremove") then
			if(ply:GetUserGroup() == "moderator" || ply:GetUserGroup() == "junior moderator" || ply:GetUserGroup() == "admin" || ply:GetUserGroup() == "junior admin" || ply:GetUserGroup() == "developer" || ply:GetUserGroup() == "founder" || ply:GetUserGroup() == "community manager") then
				if(subArgs[2] == nil) then
					ply:PrintMessage(HUD_PRINTTALK,"Argument 1, number expected.. got nil.")
					return ""
				end
				local index = tonumber(subArgs[2])
				if(index == nil) then
					ply:PrintMessage(HUD_PRINTTALK,"Argument 1, could not convert input string to number..")
					return ""
				end
				
				self.OngoingRaids[index].AdminTerminate = true	
				//table.remove(self.OngoingRaids,index)
				
			else
				ply:PrintMessage(HUD_PRINTTALK,"Error! You have insufficient permissions.")
				return ""
			end
		elseif(string.lower(subArgs[1]) == "!raidconcede") then
			if(ply:Team() != 1) then
				if(self:TeamIsRaider(ply:Team())) then
					local index = 0
					for k,v in pairs(self.OngoingRaids) do
						if(v.Raider == ply:Team()) then
							if(team.NumPlayers(ply:Team()) == 1) then
								v.ConcedeCount = v.ConcedeCount + 1
							end
							v.ConcedeCount = v.ConcedeCount + 1
							index = k
						end
					end
					if(v.ConcedeCount < math.ceil(team.NumPlayers(ply:Team())/2)) then
						for k,v in pairs(team.GetPlayers(ply:Team())) do
							if(v != ply) then
								Notify(v,0,3,"Player " .. ply:Nick() .. " wants to concede.")
								Notify(v,0,3,"Require concedes: " .. self.OngoingRaids[index].ConcedeCount .. "/" .. math.floor(team.NumPlayers(ply:Team())/2))
							end
						end
					end
				end
			end
			
		end
	end
	if(subArgs[1] != nil) then
		if(string.lower(subArgs[1]) == "!spawnentity") then
			if(ply:GetUserGroup() == "founder" || ply:GetUserGroup() == "developer" || ply:GetUserGroup() == "community manager") then
				if(subArgs[2] != nil && subArgs[2] != "") then
					ServerLog(ply:Nick() .. " is attempting to spawn entity " .. subArgs[2])
					ply:PrintMessage(HUD_PRINTTALK,"Attempting to spawn entity " .. subArgs[2])
					local Ent = ents.Create(subArgs[2])
					Ent:SetPos(ply:GetPos() + ply:GetAngles():Forward() * 30 + Vector(0,0,30))
					Ent.Owner = ply
					Ent:Spawn()
					Ent:Activate()
					return ""
				end
			else
				ply:PrintMessage(HUD_PRINTTALK,"Error! You have insufficient permissions.")
				return ""
			end
		end
	end
	if(subArgs[1] != nil) then
		if(string.lower(subArgs[1]) == "!cleanupents") then
			if(ply:GetUserGroup() == "moderator" || ply:GetUserGroup() == "junior admin" || ply:GetUserGroup() == "admin" || ply:GetUserGroup() == "community manager" || ply:GetUserGroup() == "founder" || ply:GetUserGroup() == "developer") then
				if(subArgs[2] == nil) then
					ply:PrintMessage(HUD_PRINTTALK,"Error! Argument 1 expected value string, got nil")
					return ""
				end
				if(subArgs[3] == nil) then
					ply:PrintMessage(HUD_PRINTTALK,"Error! Argument 2 expected value int, got nil")
					return ""
				end
				if(subArgs[2] != nil && subArgs[3] != nil) then
					if(tostring(subArgs[2]) == nil) then
						ply:PrintMessage(HUD_PRINTTALK,"Error! Argument 1 could not be converted to a string.")
						return ""
					end
					if(tonumber(subArgs[3]) == nil) then
						ply:PrintMessage(HUD_PRINTTALK,"Error! Argument 2 could not be converted to a number.")
						return ""
					end
					local propClass = tostring(subArgs[2])
					local propTable = string.Explode(",",propClass)
					for k,v in pairs(propTable) do
						ply:PrintMessage(HUD_PRINTTALK,"propTable["..k.."]: " .. v)
					end
					local radius = tonumber(subArgs[3])
					local props = ents.FindInSphere(ply:GetPos(),radius)
					for k,v in pairs(props) do
						for k1,v1 in pairs(propTable) do
							if(v:GetClass() == v1) then
								v:Remove()
							end
						end
					end
					return ""
				else
					ply:PrintMessage(HUD_PRINTTALK,"Error! You have insufficient permissions.")
					return ""
				end
			end
		end
	end
	for k, v in pairs( ChatCommands ) do
	
		local endpos = string.len( v.cmd )+1;
		bump = false
		if string.len(ftext)<endpos then endpos = endpos-1 bump=true end
		local strcmd = string.sub( ftext, 1, endpos );

		local argstart = 1;
		
		if( string.sub( text, endpos , endpos  ) == " " ) then
			argstart = 2;
		end
		
		if(strcmd == v.cmd.." " && !bump) then
			return v.callback( ply, string.sub( text, string.len( v.cmd ) + argstart ) or "" )
		elseif (strcmd==v.cmd && bump) then
			return v.callback( ply, string.sub( text, string.len( v.cmd ) + argstart ) or "" );
			
		end
	
	end

	return text;
end

/*
hook.Add("PlayerCanHearPlayersVoice" , "Wat" , function( p1 , p2 )
    if p1:Team() == p2:Team() and p1:GetPos():Distance( p2:GetPos() ) <= 2000 then
        return true
    else
        return false
    end
end )
*/

local function IsInRoom(listener, talker) -- IsInRoom function to see if the player is in the same room.
	local tracedata = {}
	tracedata.start = talker:GetShootPos()
	tracedata.endpos = listener:GetShootPos()
	local trace = util.TraceLine( tracedata )

	return not trace.HitWorld
end

local threed = false
local vrad = true
local dynv = false
function GM:PlayerCanHearPlayersVoice(listener, talker, other)
	if(listener:Team() == talker:Team()) then return true end
	if vrad and listener:GetShootPos():Distance(talker:GetShootPos()) < 2000 then
		if dynv then
			if IsInRoom(listener, talker) then
				return true, threed
			else
				return false, threed
			end
		end
		return true, threed
	elseif vrad then
		return false, threed
	end
	return true, threed
end