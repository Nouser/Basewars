raidConfirm = nil
raidInfo = nil
raidPanel = nil
raidableList = {}
function GM:ClearRaidablesList()
	MsgC(nil,"//////////////////////////////////////\n")
	MsgC(nil,"Clear Raidables List...\n")
	raidableList = {}
	MsgC(nil,"//////////////////////////////////////\n")
end
function GM:GetRaidable(entIndex)
	MsgC(nil,"//////////////////////////////////////\n")
	MsgC(nil,"Receiving raidable... GM:GetRaidable("..entIndex..")")
	local ent = ents.GetByIndex(tonumber(entIndex))
	if(ent != NULL and ent != nil) then
		table.insert(raidableList,ent)
	end
	MsgC(nil,"//////////////////////////////////////\n")
end
function GM:OpenScanConfirm(ply)
	MsgC(nil,"//////////////////////////////////////\n")
	local index = tonumber(ply)
	MsgN("index="..index)
	local target = NULL
	for k,v in pairs(player.GetAll()) do
		if(index == k) then
			target = v
			MsgC(nil,"Scanned player is " .. target:Nick() .. "\n")
			break
		end
	end
	//Create a VGUI Menu..
	if(target != NULL) then
		raidInfo = vgui.Create("RaidInfo")
		raidInfo:GetEntries(raidableList,target)
		raidConfirm = vgui.Create("RaidConfirm")
		--raidConfirm = vgui.Create("RaidConfirm")
		raidConfirm.RaidInfo = raidInfo
		raidConfirm:NewEntry(LocalPlayer(),target)
	end
	MsgC(nil,"//////////////////////////////////////\n")
end
function GM:RaidSystemRemoveAll()
	MsgC(nil,"//////////////////////////////////////\n")
	MsgC(nil,"Due to an action, all the raids you are participating in are removed!\n")
	RaidLabels = {}
	RaidLabels["Raiding"] = {}
	RaidLabels["Raided"] = {}
	MsgC(nil,"//////////////////////////////////////\n")
end
local raidPanelInfo = {}
function GM:RaidPanelClear()
	MsgC(nil,"//////////////////////////////////////\n")
	MsgC(nil,"Clearing Raid Panel Info...\n")
	raidPanelInfo = {}
	MsgC(nil,"//////////////////////////////////////\n")
end
function GM:RaidPanelGet(raided,raider,tindex,timeStart,index)
	MsgC(nil,"New Raid Panel Info {\n  Raided="..raided.."\n  Raider="..raider.."\n  TargetIndex="..tindex.."\n  RaiderName="..team.GetName(raider).."\n  RaidedName="..team.GetName(raided).."\n  timeStart="..timeStart.."\nIndex="..index.."\n}\n")
	local tbl = {}
	tbl.Raided = tonumber(raided)
	tbl.Raider = tonumber(raider)
	tbl.TargetIndex = tonumber(tindex)
	tbl.StartTime = tonumber(CurTime() + timeStart)
	tbl.TblIndex = index
	table.insert(raidPanelInfo,tbl)
end
function GM:RaidPanelOpen(show)
	MsgC(nil,"//////////////////////////////////////\n")
	MsgN("GM:RaidPanelOpen("..show..")")
	show = tonumber(show)
	if(show == 0) then
		MsgC(nil,"Opening Raid Panel...\n")
		raidPanel = vgui.Create("RaidPanel")
		raidPanel:PopulateEntries(raidPanelInfo)
	else
		MsgC(nil,"Updating Raid Panel...\n")
		if(raidPanel != nil and raidPanel != NULL) then
			if(raidPanel:IsVisible()) then
				raidPanel:PopulateEntries(raidPanelInfo)
			end
		end
	end
	MsgC(nil,"//////////////////////////////////////\n")
end
function GM:Think()
	local pIndex = 0
	for k,v in pairs(player.GetAll()) do
		if(v == LocalPlayer()) then
			pIndex = k
			break
		end
	end
	if(RaidLabels != nil) then
		for k,v in pairs(RaidLabels) do
			if(v != nil and istable(v)) then
				for a,b in pairs(v) do
					if(b.timeEnd <= CurTime()) then
						MsgC(nil,"//////////////////////////////////////\n")
						ClientMsg(nil,"A raid you have participated in has expired.. so it has automatically been removed from the HUD!\n")
						ClientMsg(nil,"Raid Info {\n  Raider Team="..b.RaiderName..",Index="..b.Raider.."\n  Raided Team="..b.RaidedName..",Index="..b.Raided.."\n  Target="..b.TargetName.."\n}\n")
						table.remove(v,a)
						MsgC(nil,"//////////////////////////////////////\n")
						continue
					end
					if(LocalPlayer():Team() != b.Raided and LocalPlayer():Team() != b.Raider and pIndex != b.TargetIndex) then
						MsgC(nil,"//////////////////////////////////////\n")
						ClientMsg(nil,"A raid you have participated in does not include you as part of the raided target/faction, and you do not seem to be part of the raider team.. it has been removed!\n")
						ClientMsg(nil,"Raid Info {\n  Raider Team="..b.RaiderName..",Index="..b.Raider.."\n  Raided Team="..b.RaidedName..",Index="..b.Raided.."\n  Target="..b.TargetName.."\n}\n")
						table.remove(v,a)
						MsgC(nil,"//////////////////////////////////////\n")
						continue
					end
					if(team.NumPlayers(b.Raided) == 0 or team.NumPlayers(b.Raider) == 0 or !IsValid(b.Target)) then
						MsgC(nil,"//////////////////////////////////////\n")
						ClientMsg(nil,"A raid you have participated in seems to have become invalid! It has been removed.\n")
						ClientMsg(nil,"Raid Info {\n  Raider Team="..b.RaiderName..",Index="..b.Raider.."\n  Raided Team="..b.RaidedName..",Index="..b.Raided.."\n  Target="..b.TargetName.."\n}\n")
						table.remove(v,a)
						MsgC(nil,"//////////////////////////////////////\n")
						continue
					end
				end
			end
		end
	end
end
function GM:RaidSystemRaiding(target,time,tindex)
	local tbl = {}
	tbl.Team = target
	tbl.TargetIndex = tindex
	
	for k,v in pairs(player.GetAll()) do
		if(k == tindex) then
			tbl.Target = v
			break
		end
	end
	tbl.Raided = target
	tbl.Raider = LocalPlayer():Team()
	tbl.RaiderName = team.GetName(LocalPlayer():Team())
	tbl.RaidedName = team.GetName(target)
	tbl.TargetName = tbl.Target:Nick()
	MsgC(nil,"//////////////////////////////////////\n")
	MsgC(nil,"Your faction has initiated a raid against faction " .. team.GetName(target) .. " or player " .. tbl.Target:Nick() .. " for the default time of " .. time .. " seconds!\n")
	MsgN("GM:RaidSystemRaiding("..target..","..time..")")
	tbl.timeEnd = time + CurTime()
	table.insert(RaidLabels["Raiding"],tbl)
	MsgC(nil,"//////////////////////////////////////\n")
end
function GM:RaidSystemRaided(bywho,time)
	MsgC(nil,"//////////////////////////////////////\n")
	MsgC(nil,"You are being raided by faction " .. team.GetName(bywho) .. " for the default time of " .. time .. " seconds!\n")
	MsgN("GM:RaidSystemRaided("..bywho..","..time..")")
	local tbl = {}
	tbl.Team = bywho
	tbl.Raider = bywho
	tbl.Raided = LocalPlayer():Team()
	tbl.RaidedName = team.GetName(LocalPlayer():Team())
	tbl.RaiderName = team.GetName(bywho)
	tbl.TargetName = LocalPlayer():Nick()
	tbl.Target = LocalPlayer()
	tbl.timeEnd = time + CurTime()
	table.insert(RaidLabels["Raided"],tbl)
	MsgC(nil,"//////////////////////////////////////\n")
end
function GM:RaidingEnd(Team,target)
	eTarget = NULL
	for k,v in pairs(player.GetAll()) do
		if(k == target) then
			eTarget = v
			break
		end
	end
	MsgC(nil,"//////////////////////////////////////\n")
	MsgC(nil,"Your faction's raid against faction " .. team.GetName(Team) .. " or target " .. eTarget:Nick() .. " has expired!\n")
	MsgN("GM:RaidingEnd("..Team..","..target..")")
	for k,v in pairs(RaidLabels["Raiding"]) do
		if(v.Team == Team or v.Target == eTarget) then
			table.remove(RaidLabels["Raiding"],k)
			break
		end
	end
	MsgC(nil,"//////////////////////////////////////\n")
end
function GM:RaidedEnd(bywho)
	MsgC(nil,"//////////////////////////////////////\n")
	MsgC(nil,"The raid against you or your faction by " .. team.GetName(bywho) .. " has expired!\n")
	MsgN("GM:RaidedEnd("..bywho..")")
	for k,v in pairs(RaidLabels["Raided"]) do
		if(v.Team == bywho) then
			table.remove(RaidLabels["Raided"],k)
			break
		end
	end
	MsgC(nil,"//////////////////////////////////////\n")
end
function GM:RaidingTimeIncrease(Team,target,byhowmuch)
	eTarget = NULL
	for k,v in pairs(player.GetAll()) do
		if(k == target) then
			eTarget = v
			break
		end
	end
	MsgC(nil,"//////////////////////////////////////\n")
	MsgC(nil,"The raid against faction " .. team.GetName(Team) .. " or target " .. eTarget:Nick() .. " has increased by " .. byhowmuch .. " seconds!\n")
	MsgN("GM:RaidingTimeIncrease("..Team..","..target..","..byhowmuch..")")
	for k,v in pairs(RaidLabels["Raiding"]) do
		if(v.Team == Team or v.Target == eTarget) then
			v.timeEnd = v.timeEnd + byhowmuch
			break
		end
	end
	MsgC(nil,"//////////////////////////////////////\n")
end
function GM:RaidedTimeIncrease(Team,byhowmuch)
	MsgC(nil,"//////////////////////////////////////\n")
	MsgC(nil,"The raid against you or your faction by faction " .. team.GetName(Team) .. " has increased by " .. byhowmuch .. " seconds!\n")
	MsgN("GM:RaidedTimeIncrease("..Team..","..byhowmuch.."))")
	for k,v in pairs(RaidLabels["Raided"]) do
		if(v.Team == Team) then
			v.timeEnd = v.timeEnd + byhowmuch
			break
		end
	end
	MsgC(nil,"//////////////////////////////////////\n")
end