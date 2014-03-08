DeriveGamemode( "sandbox" );
AddCSLuaFile( "cl_deaths.lua" );
AddCSLuaFile( "cl_init.lua" );
AddCSLuaFile( "cl_msg.lua" )
AddCSLuaFile( "shared.lua" );
AddCSLuaFile( "cl_scoreboard.lua" );
AddCSLuaFile( "cl_helpvgui.lua" );
AddCSLuaFile( "cl_menu.lua" );
AddCSLuaFile( "copypasta.lua" );
--AddCSLuaFile( "sh_teammenu.lua" );
AddCSLuaFile( "extracrap.lua" );
AddCSLuaFile( "drugs.lua" );
AddCSLuaFile( "vars.lua" );
AddCSLuaFile( "donors.lua" );
AddCSLuaFile( "cl_skin.lua" );
AddCSLuaFile("cl_raidsystem.lua")
AddCSLuaFile("sh_netlib.lua")
AddCSLuaFile("cl_raidsystemhooks.lua")
AddCSLuaFile("mawstream.lua")
AddCSLuaFile("fn.lua")
--AddCSLuaFile("workarounds.lua");

//include( "properties.lua" )
//include( "properties/downtown_v2a.lua" )

//--Falco's prop protection
//local BlockedModelsExist = sql.QueryValue("SELECT COUNT(*) FROM FPP_BLOCKEDMODELS;") ~= false
//if not BlockedModelsExist then
//	sql.Query("CREATE TABLE IF NOT EXISTS FPP_BLOCKEDMODELS('model' TEXT NOT NULL PRIMARY KEY);")
//	include("FPP/FPP_DefaultBlockedModels.lua") -- Load the default blocked models
//end

include("fn.lua")

include( "shared.lua" );
include("sh_netlib.lua")
/*
AddCSLuaFile("FPP/sh_CPPI.lua")
AddCSLuaFile("FPP/sh_settings.lua")
AddCSLuaFile("FPP/client/FPP_Menu.lua")
AddCSLuaFile("FPP/client/FPP_HUD.lua")
AddCSLuaFile("FPP/client/FPP_Buddies.lua")

include("FPP/sh_settings.lua")
include("FPP/sh_CPPI.lua")
include("FPP/server/FPP_Settings.lua")
include("FPP/server/FPP_Core.lua")
include("FPP/server/FPP_Antispam.lua")
*/

//include( "help.lua" );
GM.OngoingRaids = {}
GM.Tribes = {}
GM.NumTribes = 1
GM.LoadedAdverts = false

include("decay.lua")
include("mysql.lua")

include( "donors.lua" );
include( "player.lua" );
include( "money.lua" );

include( "chat.lua" );
include( "rplol.lua" );
include( "drugs.lua" );
include( "hints.lua" );
include( "vars.lua" );
include( "swep_fix.lua" );
include( "extracrap.lua" );

include( "resources.lua" );

--include("workarounds.lua");

CSFiles = { }

LRP = { }
		/*file.Write( CFGPATH, [[// Keys:
//   {HOSTNAME}
//   {TIMELIMIT}
//   {TIMELEFT}
//   {FRAGLIMIT}
//   {SERVERTIME}
//   {CURRENTMAP}
//   {NEXTMAP}
//
// Colors:
//   1  = White
//   2  = Grey
//   3  = Red
//   4  = Green
//   5  = Blue
//   6  = Yellow
//   7  = Orange
//   8  = Teal
//   9  = Aqua
//   10 = Violet
//
// Console Command 'sh_reloadadverts' reloads this file into the advert system.

1;Press F1 to open the help menu.
4;You are currently playing {HOSTNAME}. Enjoy your stay.
7;It's a good idea to create a spawnpoint at your base.
9;Found a bug? Please report any bugs to an appropriate admin.
10;Making factions is the best way to earn money. Set up a base and then go raid!
1;If you want to create a faction, press F4.
6;Go check out our brand new forums at http://www.deathnetgaming.com/forum/
7;You need a level 2 Radar Tower to raid others.
4;Help the server grow! Spread the word! Get as many active players as you can!
3;You MUST have a base with silver+ printers to raid others.
9;Improvements will be coming at a steady rate, and bug fixes will be applied!
1;Inviting friends and spreading the word is an easy way to help us out :)
6;Join our steam community group http://steamcommunity.com/groups/DeathnetGaming
7;You are able to buy money and admin privileges for this server.
4;Remember to setup kill lines/zones outside your base if you want to kill them there.
3;Please don't raid people that lack silver+ printers.
10;Please don't write words with the rope/elastic tools.
6;Please include 3 standard ASCII characters in your name so players can /scan you.
6;You can customize your character! Press F3 to begin.
3;Please don't RDM.]] )*/
/*
updateLog = {}
updateLog[1] = {}
updateLog[2] = {}
updateLog[3] = {}
updateLog[1] = {"December 2nd, 2012", "Added new moderative commands to attempt to reduce lag.","--------------------","!cleanupents <class_name> <radius>",
"<class_name> - The class of the entity you want to remove, such as prop_physics, spawned_weapon, or spawned_shipment","<radius> - The radius in GMod units to remove in a sphere around you.","--------------------",
"!massfreeze, !massfreezesent, !massfreezephysics, !massunfreeze","--------------------", "!massfreeze - Freezes all physics props, spawned_shipments, spawned_weapons, and money.","--------------------", "!massfreezesent - Freezes all spawned_shipments, spawned_weapons, and money.","--------------------",
"!massfreezephysics - Freezes all physics props","--------------------","!massunfreeze Unfreezes all spawned_shipments, spawned_weapons, and money; Allowing them to be picked up again. (DOES NOT UNFREEZE PHYSICS PROPS)","--------------------","- Updates by FROST"}

updateLog[2] = {"December 3rd, 2012", "Added a new menu binded to the F3 key, called the 'Scan VGUI', it allows you to scan people with foreign letters, and serves as a VGUI for scanning, as well as storing something called 'Scan Logs'","--------------------",
"Added 2 commands related to Scan Logs, one requires Moderator+ rank to use, the other for everyone.","--------------------","!getscanlog <entry number> - Prints out into the console, the scan log archived at the entry number. (You can get the entry number in the Scan Log section of the VGUI)","--------------------",
"!agetscanlog <Player Name> <Entry Number> <RECENT/LAST> - A Moderator+ command, retrives the archived entry starting from the oldest, or newest from the targetted player. Use <player_name> 1 RECENT to get the most recent one.","- Update by FROST"}
updateLog[3] = {"December 4th, 2012", "Added this update VGUI to inform people of recent updates I have made and if there are any new commands.","Added new Moderator+ tab in the Scan VGUI to get player scanlogs.","- Update by FROST"}
*/

SetGlobalString( "cmdprefix", "/" ); 	--Prefix before any chat commands

----------------------------------------
----------------------------------------

//GenerateChatCommandHelp();

-- Adverst Info
GM.Adverts = {}    -- Loaded from file
GM.AdvertTime = 60 -- In Seconds

GM.KeyReplacements = {}
GM.KeyReplacements["{HOSTNAME}"] = function() return GetHostName() end
GM.KeyReplacements["{TIMELIMIT}"] = function() local t = (GetConVarNumber( "mp_timelimit" )*60) return Format("%01d:%02d",math.floor(t/60),math.floor(t%60)) end
GM.KeyReplacements["{TIMELEFT}"] = function() local t = (GetConVarNumber( "mp_timelimit" )*60) - (CurTime()-(GAMEMODE.LastGameReset or 0)) return Format("%01d:%02d",math.floor(t/60),math.floor(t%60)) end
GM.KeyReplacements["{FRAGLIMIT}"] = function() return GetConVarNumber( "mp_fraglimit" ) end
GM.KeyReplacements["{SERVERTIME}"] = function() return os.date("%H:%M:%S %z") end
GM.KeyReplacements["{CURRENTMAP}"] = function() return game.GetMap() end
GM.KeyReplacements["{NEXTMAP}"] = function() return game.GetMapNext() end

local CFGPATH = "bw_adverts.txt"
function GM:RaidEnd(raided,raider,targetindex)
	ServerLog("GM:RaidEnd("..raided..","..raider..","..targetindex..")")
	if(team.Valid(raider)) then
		for k,v in pairs(team.GetPlayers(raider)) do
			v:SendLua("GAMEMODE:RaidingEnd("..raided..","..targetindex..")")
		end
	end
	if(raided != 1 and team.Valid(raided)) then
		for k,v in pairs(team.GetPlayers(raided)) do
			v:SendLua("GAMEMODE:RaidedEnd("..raider..")")
		end
	elseif(raided == 0) then
		for k,v in pairs(player.GetAll()) do
			if(k == targetindex) then
				v:SendLua("GAMEMODE:RaidedEnd("..raider..")")
				break
			end
		end
	end
end
function GM:OnRaidTimeUp(raidIndex)
	ServerLog("Raid System: Removing raid at index " .. raidIndex .. " because the time has expired..\n")
	local raid = table.Copy(self.OngoingRaids[raidIndex])
	for k,v in pairs(team.GetPlayers(raid.Raider)) do
		if(raid.Raided != 1) then
			Notify(v,4,3,"Your raid against faction " .. team.GetName(raid.Raided) .. " has expired due to TIME_UP")
		else
			Notify(v,4,3,"Your raid against " .. raid.Target:Nick() .. " has expired due to TIME_UP")
		end
	end
	if(raid.Raided != 1) then
		for k,v in pairs(team.GetPlayers(raid.Raided)) do
			Notify(v,0,3,"The raid against your faction from faction " .. team.GetName(raid.Raider) .. " has expired due to TIME_UP")
		end
	else
		Notify(v,0,3,"The raid against you from faction " .. team.GetName(raid.Raider) .. " has expired due to TIME_UP")
	end
	self:RaidEnd(raid.Raided,raid.Raider,raid.TargetIndex)
	table.remove(self.OngoingRaids,raidIndex)
	for k,v in pairs(player.GetAll()) do
		if(v:GetUserGroup() == "moderator" || v:GetUserGroup() == "junior moderator" || v:GetUserGroup() == "admin" || v:GetUserGroup() == "junior admin" || v:GetUserGroup() == "developer" || v:GetUserGroup() == "founder" || v:GetUserGroup() == "community manager") then
			v:SendLua("GAMEMODE:RaidPanelClear()")
			for a,b in pairs(self.OngoingRaids) do
				v:SendLua("GAMEMODE:RaidPanelGet("..b.Raided..","..b.Raider..","..b.TargetIndex..","..(b.StartTime - CurTime())..","..a..")")
			end
			v:SendLua("GAMEMODE:RaidPanelOpen(1)")
		end
	end
end

function GM:TeamIsRaider(Team)
	for k,v in pairs(self.OngoingRaids) do
		if(v.Raider == Team) then
			return true
		end
	end
	return false
end
function GM:NewRaid(raider,raided,target)
	local newRaid = {}
	local defaultTime = 450
	newRaid.ConcedeCount = 0
	newRaid.AdminTerminate = false
	newRaid.StartTime = CurTime()
	newRaid.Index = #self.OngoingRaids + 1
	newRaid.TargetName = target:Nick()
	newRaid.RaiderName = team.GetName(raider)
	if(raided != 1) then
		newRaid.RaidedName = team.GetName(raided)
	else
		newRaid.RaidedName = target:Nick()
	end
	newRaid.Raider = raider
	newRaid.Target = target
	newRaid.Raided = raided
	newRaid.TimeUp = CurTime() + defaultTime
	local targetIndex = 0
	for k,v in pairs(player.GetAll()) do
		if(v == target) then
			targetIndex = k
			break
		end
	end
	newRaid.TargetIndex = targetIndex
	for k,v in pairs(team.GetPlayers(raider)) do
		v:SendLua("GAMEMODE:RaidSystemRaiding("..raided..","..defaultTime..","..targetIndex..")")
	end
	for k,v in pairs(team.GetPlayers(raided)) do
		v:SendLua("GAMEMODE:RaidSystemRaided("..raider..","..defaultTime..")")
	end
	--[[function newRaid.OnRaidedDisband()
		for k,v in pairs(team.GetPlayers(self.Raider)) do
			Notify(v,4,3,team.GetName(self.Raider).. " has disbanded.. your raid has expired.")
		end
		GAMEMODE:RaidEnd(self.Raided,self.Raider,self.TargetIndex)
		table.remove(self.OngoingRaids,self.Index)
	end
	function newRaid.OnRaiderDisband()
		for k,v in pairs(team.GetPlayers(self.Raided)) do
			Notify(v,0,3,team.GetName(self.Raider) .. " has disbanded.. the raid against you has expired.")
		end
		GAMEMODE:RaidEnd(self.Raided,self.Raider,self.TargetIndex)
		table.remove(self.OngoingRaids,self.Index)
	end
	function newRaid.OnTargetLeave()
		for k,v in pairs(team.GetPlayers(self.Raider)) do
			Notify(v,4,3,self.Target:Nick() .. " has left the server.. the raid against him/her has expired.")
		end
		GAMEMODE:RaidEnd(self.Raided,self.Raider,self.TargetIndex)
		table.remove(self.OngoingRaids,self.Index)
	end]]
	table.insert(self.OngoingRaids,newRaid)
	for k,v in pairs(player.GetAll()) do
		if(v:GetUserGroup() == "moderator" || v:GetUserGroup() == "junior moderator" || v:GetUserGroup() == "admin" || v:GetUserGroup() == "junior admin" || v:GetUserGroup() == "developer" || v:GetUserGroup() == "founder" || v:GetUserGroup() == "community manager") then
			v:SendLua("GAMEMODE:RaidPanelClear()")
			for a,b in pairs(self.OngoingRaids) do
				v:SendLua("GAMEMODE:RaidPanelGet("..b.Raided..","..b.Raider..","..b.TargetIndex..","..(b.StartTime - CurTime())..","..a..")")
			end
			v:SendLua("GAMEMODE:RaidPanelOpen(1)")
		end
	end
end
function GM:AddRaidTime(raidIndex,time,reason)
	local raid = table.Copy(self.OngoingRaids[raidIndex])
	raid.TimeUp = raid.TimeUp + time
	for k,v in pairs(team.GetPlayers(raid.Raider)) do
		if(raid.Raided != 1) then
			Notify(v,0,3,"Raid against faction " .. team.GetName(raid.Raided) .. " has increased by " .. time .. " seconds for " .. reason)
		else
			Notify(v,0,3,"Raid against " .. raid.Target:Nick() .. " has increased by " .. time .. " seconds for " .. reason)
		end
		v:SendLua("GAMEMODE:RaidingTimeIncrease("..raid.Raided..","..raid.TargetIndex..","..time..")")
	end
	for k,v in pairs(team.GetPlayers(raid.Raided)) do
		Notify(v,0,3,"Raid from faction " .. team.GetName(raid.Raider) .. " has increased by " .. time .. " seconds for them " .. reason)
		v:SendLua("GAMEMODE:RaidedTimeIncrease("..raid.Raider..","..time..")")
	end
	self.OngoingRaids[raidIndex] = table.Copy(raid)
end
function GM:RaidSystemCheckDeath(attacker,victim)
	if(attacker:Team() != 1) then
		for k,v in pairs(self.OngoingRaids) do
			if(attacker:Team() == v.Raider and victim == v.Target) then
				self:AddRaidTime(k,45,"killing a defender.")
			end
		end
	end
end
function GM:RaidSystemCheckBigbomb(owner)
	if(owner:Team() != 1) then
		for k,v in pairs(self.OngoingRaids) do
			if(owner:Team() == v.Raider) then
				self:AddRaidTime(k,300,"detonating a Big Bomb.")
				break
			end
		end
	end
end
function GM:RemoveRaid(index)
	table.remove(self.OngoingRaids,index)
	for k,v in pairs(player.GetAll()) do
		if(self.OngoingRaids[index].Raided != 1) then
			Notify(v,0,3,"The Raid against faction " .. self.OngoingRaids[index].RaidedName .. " has expired!")
		else
			Notify(v,0,3,"The Raid against player " .. self.OngoingRaids[index].TargetName .. " has expired!")
		end
	end
end
function GM:Tick()
	if(!self.LoadedAdverts or self.LoadedAdverts == nil) then
		self:LoadAdverts(NULL,true)
		self.LoadedAdverts = true
	end
	for k,v in pairs(self.OngoingRaids) do
		if(v.TimeUp <= CurTime()) then
			
			self:OnRaidTimeUp(k)
		end
		if(v.ConcedeCount >= math.ceil(team.NumPlayers(v.Raider)/2)) then
			for a,b in pairs(team.GetPlayers(v.Raider)) do
				b:SendLua("GAMEMODE:RaidingEnd("..v.Raided..","..v.TargetIndex..")")
				Notify(b,4,3,"Your raid against faction " .. v.RaidedName .. " has expired due to conceding.")
			end
			if(v.Raided != 1) then
				for a,b in pairs(team.GetPlayers(v.Raided)) do
					b:SendLua("GAMEMODE:RaidedEnd("..v.Raider..")")
					Notify(b,0,3,"A raid against your faction by faction " .. v.RaiderName .. " has expired due to CONCEDE.")
				end
			else
				v.Target:SendLua("GAMEMODE:RaidedEnd("..v.Raider..")")
				Notify(v.Target,0,3,"A raid against you by faction " .. v.RaiderName .. " has expired due to CONCEDE.")
			end
			table.remove(self.OngoingRaids,k)
		end
		if(v.AdminTerminate) then
			if(v.Raided != 1) then
				for a,b in pairs(team.GetPlayers(v.Raided)) do
					Notify(b,0,3,"A raid against your faction by faction " .. v.RaiderName .. " has been terminated by a staff member.")
				end
			else
				Notify(v.Target,0,3,"A raid against you by faction " .. v.RaiderName .. " has been terminated by a staff member.")
			end
			for a,b in pairs(team.GetPlayers(v.Raider)) do
				Notify(b,4,3,"A raid from your faction against " .. v.RaidedName .. " has been terminated by a staff member.")
			end
			for a,b in pairs(team.GetPlayers(v.Raided)) do
				b:SendLua("GAMEMODE:RaidedEnd("..v.Raider..")")
			end
			for a,b in pairs(team.GetPlayers(v.Raider)) do
				b:SendLua("GAMEMODE:RaidingEnd("..v.Raided..","..v.TargetIndex..")")
			end
			table.remove(self.OngoingRaids,k)
		end
		if(v.Target == NULL or v.Target == nil) then
			ServerLog("Raid System: Removing raid at index " .. k .. " because the target is no longer vaild..\n")
			for a,b in pairs(team.GetPlayers(v.Raider)) do
				b:SendLua("GAMEMODE:RaidingEnd("..v.Raided..","..v.TargetIndex..")")
			end
			table.remove(self.OngoingRaids,k)
			continue
		end
		if(team.NumPlayers(v.Raider) == 0 or team.GetName(v.Raider) != v.RaiderName) then
			ServerLog("Raid System: Removing raid at index " .. k .. " because the raiding team is no longer vaild..\n")
			for a,b in pairs(team.GetPlayers(v.Raided)) do
				b:SendLua("GAMEMODE:RaidedEnd("..v.Raider..")")
			end
			table.remove(self.OngoingRaids,k)
			continue
		end
		if(team.NumPlayers(v.Raided) == 0 or team.GetName(v.Raided) != v.RaidedName) then
			ServerLog("Raid System: Removing raid at index " .. k .. " because the team getting raided is no longer vaild..\n")
			for a,b in pairs(team.GetPlayers(v.Raider)) do
				b:SendLua("GAMEMODE:RaidingEnd("..v.Raided..","..v.TargetIndex..")")
			table.remove(self.OngoingRaids,k)
			continue
		end
	end
end
end
function RaidSystemBlockSpawning(ply,mdl)
	for k,v in pairs(GAMEMODE.OngoingRaids) do
		if(ply:Team() == 1 and v.Target == ply) then
			Notify(ply,4,3,"You are unable to build props under a raid!")
			return false;
		elseif(ply:Team() != 1 and v.Raided == ply:Team()) then
			Notify(ply,4,3,"You are unable to build props under a raid!")
			return false;
		end
	end
	return true;
end
hook.Add("PlayerSpawnProp","RaidSystemBlockSpawning",RaidSystemBlockSpawning)
function GM:RaidSystemConfirm(ply,args)
	if(args[1] == nil || args[2] == nil) then
		ply:PrintMessage(HUD_PRINTCONSOLE,"Are you sure you used the Confirm Box?")
		return
	end
	local targIndex = tonumber(args[1])
	local target = NULL
	if(targIndex != nil) then
		for k,v in pairs(player.GetAll()) do
			if(k == targIndex) then
				ply:PrintMessage(HUD_PRINTCONSOLE,"Target grabbed.")
				target = v
				break
			end
		end
	else
		ply:PrintMessage(HUD_PRINTCONSOLE,"Could not grab targetIndex")
	end
	if(target != NULL) then
		if(args[2] != (""..target:Team()..","..ply:Team()..","..target:SteamID()..","..ply:SteamID())) then
			ply:PrintMessage(HUD_PRINTCONSOLE,"Encryption Key did not match")
			return
		end
		//Broadcast that the player has initiated a war against the target.
		//MsgAll("BaseWars: Player " .. ply:Nick() .. " has initiated a raid against " .. target:Nick() .. "!\n")
		
		for k,v in pairs(player.GetAll()) do
			//v:PrintMessage(HUD_PRINTCONSOLE,"BaseWars: Player " .. ply:Nick() .. " has initiated a raid against " .. target:Nick() .. "!")
			//v:PrintMessage(HUD_PRINTCONSOLE,"  Factions Involved:\n")
			//v:PrintMessage(HUD_PRINTCONSOLE,"    Raiding Team: " .. team.GetName(ply:Team()).."\n")
			//v:PrintMessage(HUD_PRINTCONSOLE,"    Raided Team: " .. team.GetName(target:Team()).."\n")
			v:PrintMessage(HUD_PRINTCONSOLE,"/////////////////////////////////////////////////////////////")
			Notify( v, 0, 3, "Player " .. ply:Nick() .. " has initiated a raid against " .. target:Nick() .. "!" );
			Notify( v, 0, 3, "  Factions Involved:")
			Notify( v, 0, 3, "    Raiding Team: " .. team.GetName(ply:Team()))
			Notify( v, 0, 3, "    Raided Team: " .. team.GetName(target:Team()))
			if(v:Team() == ply:Team()) then
				Notify( v, 0, 3, "Your team has initiated a raid against faction " .. team.GetName(target:Team()).."!")
			elseif(v:Team() == target:Team()) then
				Notify( v, 4, 3, "Your team has been the target of a raid initiation by faction " .. team.GetName(ply:Team()).."!")
			end
			v:PrintMessage(HUD_PRINTCONSOLE,"/////////////////////////////////////////////////////////////")
		end
		self:ImposeRaidRestrictions(target:Team())
		self:NewRaid(ply:Team(),target:Team(),target)
	else
		ply:PrintMessage(HUD_PRINTCONSOLE,"Could not find player with index " .. targIndex)
	end
end
function GM:ImposeRaidRestrictions(targetteam)
	for k,v in pairs(team.GetPlayers(targetteam)) do
		Notify(v,4,3,"You have been imposed the following penalties for being raided:")
		Notify(v,4,3,"Killing structures impose a NEGATIVE amount if they belong to your faction.")
		Notify(v,4,3,"You will be unable to build new props.")
		//Impose
	end
end
concommand.Add("bw_raidsystem_confirm",function(ply,cmd,args)
	ply:PrintMessage(HUD_PRINTCONSOLE,"BW_RAIDYSSTEM_CONFIRM")
	for k,v in pairs(args) do
		ply:PrintMessage(HUD_PRINTCONSOLE,"args["..k.."]="..v)
	end
	GAMEMODE:RaidSystemConfirm(ply,args)
end)
function GM:Initialize()
	self.MYSQL:Connect(true)
	self.MYSQL:StartChecker()
	self.BaseClass:Initialize();
	//self:LoadAdverts(NULL,true)
	self:AddResources()
end
function GM:AddResources()
	resource.AddFile("resource/fonts/halflife2.ttf")
	resource.AddFile("resource/fonts/agencyr.ttf")
end
concommand.Add("__reloadResources",function(ply,cmd,args)
	GM:AddResources()
end)
function GM:LoadAdverts(ply,checkUsingData)
--	if IsValid( ply ) and !ply:IsAdmin() then return end
	local msgPlayer = IsValid(ply)
	self.Adverts = {}
	MsgN("-----Load Adverts-----")
	if(msgPlayer) then ply:PrintMessage(HUD_PRINTTALK,"Loading Adverts....") end
	if(checkUsingData) then
		if file.Exists( CFGPATH, "DATA" ) then
			MsgN("  File"..CFGPATH.." exists.")
			if(msgPlayer) then ply:PrintMessage(HUD_PRINTTALK,"Adverts File Found....") end
			local data = file.Read( CFGPATH, "DATA" )
			local tbl = string.Explode( "\n", data )
			for k=1,#tbl do
				local v = tbl[k]
				local sep = string.find( v, ";" )
				if sep and string.Left( v, 2 ) != "//" then
					table.insert( self.Adverts, {color=tonumber(string.Left(v,sep-1)),text=string.sub(v,sep+1)} )
				end
			end
		else
			MsgN("  File"..CFGPATH.." does not exist. Using Fallback Reroute to GAME")
			if(msgPlayer) then ply:PrintMessage(HUD_PRINTTALK,"Adverts File does not exist. Using Fallback Reroute to GAME") end
			self:LoadAdverts(ply,false)
		end
	else
		if file.Exists("gamemodes/basewars/content/data/"..CFGPATH,"GAME") then
			MsgN("  File".."gamemodes/basewars/content/data/"..CFGPATH.." exists.")
			if(msgPlayer) then ply:PrintMessage(HUD_PRINTTALK,"Adverts File exists, found using GAME fallback....") end
			local data = file.Read( "gamemodes/basewars/content/data/"..CFGPATH, "GAME" )
			local tbl = string.Explode( "\n", data )
			for k=1,#tbl do
				local v = tbl[k]
				local sep = string.find( v, ";" )
				if sep and string.Left( v, 2 ) != "//" then
					table.insert( self.Adverts, {color=tonumber(string.Left(v,sep-1)),text=string.sub(v,sep+1)} )
				end
			end
		else
			MsgN("  File"..CFGPATH.." does not exist.. Fall Back Reroute Failed. Loading Defaults.")
			if(msgPlayer) then ply:PrintMessage(HUD_PRINTTALK,"Adverts File does not exist.. Fallback Reroute Failed. Loading Defaults.") end
			self.Adverts[1] = { color=1, text="Welcome to {HOSTNAME}!" }
			self.Adverts[2] = { color=3, text="Please don't RDM." }
		end
	end
end				
concommand.Add( "bw_reloadadverts",function(ply,cmd,args) GAMEMODE:LoadAdverts(ply,true) end )

local function AdvertTimer()
	if #GAMEMODE.Adverts == 0 then return end

	for k = 1,#player.GetHumans() do
		local v = player.GetHumans()[k]
		if IsValid( v ) then
			umsg.Start( "bw_advert", v )
				local randind = math.random(1, #GAMEMODE.Adverts)
				umsg.Short( (GAMEMODE.Adverts[randind] and GAMEMODE.Adverts[randind].color) or 1 )
				local str = (GAMEMODE.Adverts[randind] and GAMEMODE.Adverts[randind].text) or ""
				for a, b in pairs(GAMEMODE.KeyReplacements) do str = string.gsub( str, b, tostring( GAMEMODE.KeyReplacements[b]() ) ) end
				umsg.String( str )
			umsg.End()
		end
	end
end

for k, v in pairs( player.GetAll() ) do
	v:NewData();
	v:SetNetworkedBool("helpMenu",false)
	getMoney(v);
end


function GM:ShowHelp( ply )

	ply:ConCommand( "ulx motd" );
	
end

function GM:ShowTeam( ply )
//	ply:DoorControl()
	ply:ConCommand( "bw_factionmenu" );
end

function GM:PlayerSpray ( ply )
	if(ply:GetUserGroup() == "junior admin" || ply:GetUserGroup() == "admin" || ply:GetUserGroup() == "founder" || ply:GetUserGroup() == "community manager" || ply:GetUserGroup() == "developer") then
		return false
	end
	Notify( ply, 1, 3, "Sprays have been disabled!");
	
	return true;
end

function GM:GetFallDamage( ply, vel )
	return 0
end

function GM:PlayerSpawnNPC(ply)
	if(ply:IsAdmin() or ply:IsSuperAdmin()) then
		return true
	end
	return false
end

function GM:PlayerSpawnSENT(ply)
	if(ply:IsAdmin() or ply:IsSuperAdmin()) then
		return true
	end
	return false
end

function GM:PlayerGiveSWEP(ply)
	if(ply:IsAdmin() or ply:IsSuperAdmin()) then
		return true
	end
	return false
end

function GM:PlayerSpawnSWEP()
	return false
end

function GM:PlayerSpawnVehicle()
	return false
end

function GM:CanDrive()
	return false
end

/*---------------------------------------------------------
   Tribe system
---------------------------------------------------------*/

function GM.SendTribes(ply)
for i,v in pairs(GAMEMODE.Tribes) do
	umsg.Start("recvTribes",ply)
	umsg.Short(v.id)
	umsg.String(i)
	umsg.Short(v.red)
	umsg.Short(v.green)
	umsg.Short(v.blue)
	umsg.End()
	end
end
hook.Add("PlayerInitialSpawn","getTribes",GM.SendTribes)

function CreateTribe( ply, name, red, green, blue, password )
	
	local Password = false
	
	if password and password != "" then
		Password = password
	end
		
	GAMEMODE.NumTribes = GAMEMODE.NumTribes + 1
	GAMEMODE.Tribes[name] = {
	id = GAMEMODE.NumTribes,
	red = red,
	green = green,
	blue = blue,
	Password = Password
	}
	local rp = RecipientFilter()
	rp:AddAllPlayers()
	umsg.Start("newTribe",rp)
		umsg.String(name)
		umsg.Short(GAMEMODE.NumTribes)
		umsg.Short(red)
		umsg.Short(green)
		umsg.Short(blue)
	umsg.End()
	team.SetUp(GAMEMODE.NumTribes,tostring(name),Color(red,green,blue,255))
	ply:SetTeam(GAMEMODE.NumTribes) 
	ply:ChatPrint("Faction Successfully Created!",5,Color(255,255,255,255))
	ply:SetNetworkedBool("FactionLeader", true)
end

function CreateTribeCmd( ply, cmd, args, argv )
	if !args[4] or args[4] == "" then
		ply:ChatPrint("Syntax is: bw_create \"factionname\" red green blue [password(optional)]") return 
	end
	if args[5] and args[5] != "" then
		CreateTribe( ply, args[1], args[2], args[3], args[4], args[5] )
	else
		CreateTribe( ply, args[1], args[2], args[3], args[4], "" )
	end
end
concommand.Add( "bw_create", CreateTribeCmd )

function joinTribe( ply, cmd, args )
	local pw = ""
	if !args[1] or args[1] == "" then
		ply:ChatPrint("Syntax is: bw_join \"faction\" [password(if needed)]") return 
	end
	if args[2] and args[2] != "" then
		pw = args[2]
	end
	for i,v in pairs(GAMEMODE.Tribes) do
		if string.lower(i) == string.lower(args[1]) then
			if v.Password and v.Password != pw then ply:PrintMessage(3,"Incorrect Faction Password!") return end
			if ply:Team() == v.id then return end
			ply:SetTeam(v.id)
			ply:SetNetworkedBool("FactionLeader", false)
			ply:ChatPrint("Successfully Joined a Faction!",5,Color(255,255,255,255))
		end
	end
end
concommand.Add( "bw_join", joinTribe )

function leaveTribe( ply, cmd, args )
	ply:SetTeam(1)
	ply:ChatPrint("Successfully Left a Faction!",5,Color(255,255,255,255))
	ply:SetNetworkedBool("FactionLeader", false)
end
concommand.Add( "bw_leave", leaveTribe )

function PromoteMember( ply, cmd, args )
	if !args[1] or args[1] == "" then
		ply:ChatPrint("Syntax is: bw_promote \"playername\"") return
	end
	local target = FindPlayer(args[1])
	if IsValid(target) then
		ply:SetNWBool("FactionLeader", false)
		target:SetNWBool("FactionLeader", true)
		ply:ChatPrint("Successfully Transferred Leadership!")
		target:ChatPrint("You are now the Leader of the Faction!")
	end
end
concommand.Add("bw_promote", PromoteMember)

function KickMember( ply, cmd, args )
	if !args[1] or args[1] == "" then
		ply:ChatPrint("Syntax is: bw_removeteammate \"playername\"") return
	end
	local target = FindPlayer(args[1])
	if IsValid(target) then
		target:SetNWBool("FactionLeader", false)
		target:SetTeam(1)
		ply:ChatPrint("Successfully Removed Member!")
		target:ChatPrint("You have been Kicked from the Faction!")
	end
end
concommand.Add("bw_removeteammate", KickMember)

/*
function KickMember(ply,cmd,args)
	if !args[1] then return end
	if (ply:GetNWBool("Factionleader",false) != true) then return end

	local kick = FindPlayer(args[1])
	if !kick then
		ply:ChatPrint("Player not found!",5,Color(255,255,255,255))
		return
	end

	if (ply == kick) then return end
	if (ply:Team() != kick:Team()) then return end

	
	
	kick:SetTeam(1)
	kick:ChatPrint("You have been kicked from your faction",5,Color(255,255,255,255))
	kicak:SetNetworkedBool("FactionLeader", false)

	ply:ChatPrint("You have kicked "..args[1],5,Color(255,255,255,255))
end
concommand.Add("bw_removeteammate", KickMember)

function PromoteMember(ply,cmd,args)
	if !args[1] then return end
	if (ply:GetNWBool("Factionleader",false) != true) then return end

	local prom = FindPlayer(args[1])
	if !prom then
		ply:ChatPrint("Player not found!",5,Color(255,255,255,255))
		return
	end

	if (ply == prom) then return end

	if (prom:Team() != ply:Team()) then return end

	

	prom:ChatPrint("You have been promoted to be the leader of your faction!",5,Color(255,255,255,255))
	prom:SetNWBool("FactionLeader",true)
	ply:SetNWBool("FactionLeader",false)

	ply:ChatPrint("You are no longer your faction leader",5,Color(255,255,255,255))
end
concommand.Add("bw_promote", PromoteMember)
*/

/*
function Init_TriggerLogic()
	for k,v in pairs(ents.FindByClass("bigbomb")) do
		v:SetKeyValue( "health", 0 )
		v:SetKeyValue( "minhealthdmg", 1000000 )
	end
end
hook.Add( "InitPostEntity", "GlassUnbreakable", UnbreakableGlass )
*/
//GM:LoadAdverts(NULL,true)

resource.AddWorkshop( "143193342" ); -- Customizable Weaponry
resource.AddWorkshop( "183665798" );
resource.AddWorkshop( "183662996" );
resource.AddWorkshop( "183651894" );

local Format	=	Format

local meta = FindMetaTable( "Player" )