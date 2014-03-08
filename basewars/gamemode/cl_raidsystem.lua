local RAIDCONFIRM = {}
local RAIDINFO = {}
local RAIDPANEL = {}
local rS = {}
local function AddEntry(class,name)
	rS[class] = name
end
AddEntry("money_printer_silver","Silver Money Printer")
AddEntry("money_printer_gold","Gold Money Printer")
AddEntry("money_printer_goldensilo","Golden Money Silo")
AddEntry("money_printer_iridium","Iridium Money Printer")
AddEntry("money_printer_moneyfactory","Money Factory")
AddEntry("money_printer_nova","Nova Money Printer")
AddEntry("money_printer_nuclearfactory","Nuclear Money Factory")
AddEntry("money_printer_palladium","Palladium Money Printer")
AddEntry("money_printer_platinum","Platinum Money Printer")
AddEntry("money_printer_quantum","Quantum Money Printer")
AddEntry("money_printer_rhenium","Rhenium Money Printer")
AddEntry("money_printer_rhodium","Rhodium Money Printer")
AddEntry("money_printer_tunedgold","Tuned Gold Money Printer")
AddEntry("money_printer_tunedgolden","Tuned Golden Money Silo")
AddEntry("money_printer_tunediridium","Tuned Iridium Money Printer")
AddEntry("money_printer_tunedrhodium","Tuned Rhodium Money Printer")
AddEntry("money_printer_tunedsilver","Tuned Silver Money Printer")
AddEntry("drug_lab","Drug Lab")
AddEntry("meth_lab","Unstable Meth Lab")
AddEntry("meth_lab_stable","Stable Meth Lab")
RAIDCONFIRM.ConfirmB = nil
RAIDCONFIRM.DenyB = nil
RAIDCONFIRM.TextLabel = nil
RAIDINFO.TextLabel = nil
RAIDINFO.PanelList = nil
RAIDPANEL.PanelList = nil
RAIDPANEL.RaidedLabel = nil
RAIDPANEL.VSLabel = nil
RAIDPANEL.RaiderLabel = nil
RAIDPANEL.Offset = 0
RAIDPANEL.UpB = nil
RAIDPANEL.DownB = nil
RAIDPANEL.Info = nil
RAIDPANEL.MinorLabels = {}
function RAIDPANEL:Init()
	self:SetTitle("Admin - Raid Panel")
	self:SetSkin("stronghold")
	self.Offset = 0
	self:SetKeyboardInputEnabled(true)
    self:SetMouseInputEnabled(true)
	self:SetDeleteOnClose(true)
	self:SetSize(525,525)
	self:SetPos(ScrW()/2,ScrH()/2)
	self:Center()
	self:MakePopup()
	self.UpB = vgui.Create("DButton",self)
	self.UpB:SetSize(225,25)
	self.UpB:SetPos(25,25)
	self.UpB.DoClick = function()
		self:SetVisible(false)
		self.Offset = self.Offset - draw.GetFontHeight("AgencyFB24")
		self:SetVisible(true)
	end
	self.UpB:SetText("Up")
	self.DownB = vgui.Create("DButton",self)
	self.DownB:SetSize(225,25)
	self.DownB:SetPos(275,25)
	self.DownB.DoClick = function()
		self:SetVisible(false)
		if(self.Offset < 0) then
			self.Offset = self.Offset + draw.GetFontHeight("AgencyFB24")
		end
		self:SetVisible(true)
	end
	self.DownB:SetText("Down")
	surface.SetFont("AgencyFB24")
	local width,height = surface.GetTextSize("Raided")
	self.PanelList = vgui.Create("DPanelList",self)
	self.PanelList:SetParent(self)
	self.PanelList:SetSize(475,400)
	self.PanelList:SetPos(25,50)
	self.PanelList:SetSpacing(5)
	self.PanelList:EnableHorizontal(false)
	self.PanelList:EnableVerticalScrollbar(true)
	self.RaidedLabel = vgui.Create("DLabel",self)
	self.RaidedLabel:SetParent(self)
	self.RaidedLabel:SetSize(125,50)
	self.RaidedLabel:SetText("Raided")
	self.RaidedLabel:SetPos(25,50)
	self.RaidedLabel:SetFont("AgencyFB24")
	width,height = surface.GetTextSize("Time Started")
	self.VSLabel = vgui.Create("DLabel",self)
	self.VSLabel:SetParent(self)
	self.VSLabel:SetSize(125,50)
	self.VSLabel:SetText("Time Started")
	self.VSLabel:SetPos(self:GetWide()/2 - width/2,50)
	self.VSLabel:SetFont("AgencyFB24")
	width,height = surface.GetTextSize("Raider")
	self.RaiderLabel = vgui.Create("DLabel",self)
	self.RaiderLabel:SetParent(self)
	self.RaiderLabel:SetSize(125,50)
	self.RaiderLabel:SetText("Raider")
	self.RaiderLabel:SetPos(self:GetWide() -25 - width,50)
	self.RaiderLabel:SetFont("AgencyFB24")
	self:SetVisible(true)
end
function RAIDPANEL:PopulateEntries(info)
	MsgC(nil,"//////////////////////////////////////\n")
	MsgC(nil,"RAIDPANEL: Populating Entries...\n")
	self.Info = info
	self:SetVisible(false)
	if(#self.Info > 0) then
		if(self.NoRaidLabel != nil) then
			self.NoRaidLabel:Remove()
		end
		MsgC(nil,"RAIDPANEL: " .. #self.Info .. " entries received..\n")
		for k,v in pairs(self.Info) do	
			if(self.MinorLabels[k] == nil) then
				self.MinorLabels[k] = {}
			else
				self.MinorLabels[k].label:Remove()
				self.MinorLabels[k].timeLabel:Remove()
				self.MinorLabels[k].otherLabel:Remove()
			end
			local raidedName = "Index#" .. tostring(v.TblIndex) .. " - "
			if(v.Raided == 1) then
				for a,b in pairs(player.GetAll()) do
					if(a == v.TargetIndex) then
						raidedName = raidedName .. b:Nick()
						break
					end
				end
			else
				raidedName = raidedName .. team.GetName(v.Raided)
			end
			local raiderName = team.GetName(v.Raider)
			
			self.MinorLabels[k].label = vgui.Create("DLabel",self.PanelList)
			self.MinorLabels[k].label:SetFont("AgencyFB24")
			self.MinorLabels[k].label:SetText(raidedName)
			self.MinorLabels[k].label:SetSize(250,50)
			self.MinorLabels[k].label:SetTextColor(team.GetColor(v.Raided))
			self.MinorLabels[k].label:SetPos(0,draw.GetFontHeight("AgencyFB24")*(k) + self.Offset)
			self.MinorLabels[k].label.Paint = function()
				self.MinorLabels[k].label:SetPos(0,draw.GetFontHeight("AgencyFB24")*(k) + self.Offset)
			end
			
			self.MinorLabels[k].timeLabel = vgui.Create("DLabel",self.PanelList)
			self.MinorLabels[k].timeLabel:SetFont("AgencyFB24")
			local secsAgo = v.StartTime - CurTime()
			local timeText = math.abs(math.Round(secsAgo)) .. " sec(s) ago"
			self.MinorLabels[k].timeLabel:SetText(timeText)
			self.MinorLabels[k].timeLabel:SetSize(250,50)
			self.MinorLabels[k].timeLabel:SetTextColor(Color(255,255,255,255))
			surface.SetFont("AgencyFB24")
			local width,height = surface.GetTextSize(timeText)
			self.MinorLabels[k].timeLabel:SetPos(self.PanelList:GetWide()/2 - width/2,draw.GetFontHeight("AgencyFB24")*(k) + self.Offset)
			self.MinorLabels[k].timeLabel.Paint = function()
				local secsAgo = v.StartTime - CurTime()
				local timeText = math.abs(math.Round(secsAgo)) .. " sec(s) ago"
				self.MinorLabels[k].timeLabel:SetText(timeText)
			end
			
			self.MinorLabels[k].otherLabel = vgui.Create("DLabel",self.PanelList)
			self.MinorLabels[k].otherLabel:SetFont("AgencyFB24")
			self.MinorLabels[k].otherLabel:SetText(raiderName)
			self.MinorLabels[k].otherLabel:SetSize(250,50)
			self.MinorLabels[k].otherLabel:SetTextColor(team.GetColor(v.Raider))
			width,height = surface.GetTextSize(raiderName)
			self.MinorLabels[k].otherLabel:SetPos(self.PanelList:GetWide() - width,draw.GetFontHeight("AgencyFB24")*(k) + self.Offset)
			self.MinorLabels[k].otherLabel.Paint = function()
				local width,height = surface.GetTextSize(raiderName)
				self.MinorLabels[k].otherLabel:SetPos(self.PanelList:GetWide() - width,draw.GetFontHeight("AgencyFB24")*(k) + self.Offset)
			end
		end
	else
		self.NoRaidLabel = vgui.Create("DLabel",self.PanelList)
		self.NoRaidLabel:SetFont("AgencyFB24")
		self.NoRaidLabel:SetSize(self.PanelList:GetWide(),50)
		surface.SetFont("AgencyFB24")
		local width,height = surface.GetTextSize("Seems like there are no ongoing raids at the moment!")
		self.NoRaidLabel:SetPos(self.PanelList:GetWide()/2 - width/2,draw.GetFontHeight("AgencyFB24"))
		self.NoRaidLabel:SetText("Seems like there are no ongoing raids at the moment!")
		self.NoRaidLabel:SetTextColor(Color(255,127,0,255))
		self.NoRaidLabel:SetWrap(true)
	end
	self:SetVisible(true)
end
vgui.Register("RaidPanel",RAIDPANEL,"DFrame")
function RAIDINFO:Init()
	self:SetTitle("Raidable Structures Found")
	self:SetSkin("stronghold")
	self:SetDraggable(false)
	self:SetDeleteOnClose(true)
	self:SetKeyboardInputEnabled(true)
	self:SetMouseInputEnabled(true)
	self:SetSize(600,300)
	self:ShowCloseButton(false)
	self:SetPos(ScrW() / 2 - (self:GetWide() / 2),300)
	self.PanelList = vgui.Create("DPanelList",self)
	self.PanelList:SetParent(self)
	self.PanelList:SetSize(550,250)
	self.PanelList:SetPos(25,25)
	self.PanelList:SetSpacing(5)
	self.PanelList:EnableHorizontal(false)
	self.PanelList:EnableVerticalScrollbar(true)
	self.TextLabel = vgui.Create("DLabel",self.PanelList)
	self.TextLabel:SetPos(self.PanelList)
	self.TextLabel:SetSize(550,25)
	self.TextLabel:SetAutoStretchVertical(true)
	self.TextLabel:SizeToContentsY(true)
	self.TextLabel:SetWrap(true)
	self.TextLabel:SetPos(0,0)
	self.TextLabel:SetFont("AgencyFB24")
	self.TextLabel:SetText("This is the default label, blah blah blah.")
	self.PanelList:AddItem(self.TextLabel)
	self:SetVisible(true)
end
function RAIDINFO:GetEntries(List,target)
	self:SetVisible(false)
	self:SetTitle("Raidable Structures Found near " .. target:Nick())
	local ConcenText = ""
	local tbl = {}
	for k,v in pairs(List) do
		for a,b in SortedPairs(rS) do
			if(a == v:GetClass()) then
				if(tbl[b] == nil) then
					tbl[b] = 0
				end
				tbl[b] = tbl[b] + 1
				break
			end
		end
	end
	if(#tbl > 0) then
		MsgC(nil,"Scanned Player is raidable.")
	end
	for k,v in SortedPairs(tbl) do
		MsgC(nil,"Scan has found " .. tostring(v) .. " " .. k .. "\n")
		ConcenText = ConcenText .. tostring(v) .. " " .. k .. "\n"
	end
	self.TextLabel:SetText(ConcenText)
	self:SetVisible(true)
end
vgui.Register("RaidInfo",RAIDINFO,"DFrame")
function RAIDCONFIRM:Init()
	self:SetTitle("Confirm Raid")
	self:SetSkin("stronghold")
	self:SetDraggable(false)
	
	self:SetDeleteOnClose(true)
	self:SetKeyboardInputEnabled(true)
    self:SetMouseInputEnabled(true)
    self:MakePopup()
    self:SetSize(600,200)
	self:SetPos(ScrW() / 2 - (self:GetWide() / 2), 100)
	self.ConfirmB = vgui.Create("DButton",self)
	self.ConfirmB:SetParent(self)
	self.ConfirmB:SetSize(250,25)
	self.ConfirmB:SetPos(25,160)
	self.ConfirmB:SetText("Yes")
	self.DenyB = vgui.Create("DButton",self)
	self.DenyB:SetParent(self)
	self.DenyB:SetSize(250,25)
	self.DenyB:SetPos(325,160)
	self.DenyB:SetText("No")
	self.ConfirmB.DoClick = function()
		self.Removed = true
		self:Remove()
	end
	self.DenyB.DoClick = function()
		self.Removed = true
		self:Remove()
	end
	self.TextLabel = vgui.Create("DLabel",self)
	self.TextLabel:SetParent(self)
	self.TextLabel:SetSize(550,135)
	self.TextLabel:SetPos(25,15)
	self.TextLabel:SetText("This is the default label. Blah blah blah.")
	self.TextLabel:SetWrap(true)
	self.TextLabel:SetFont("AgencyFB24")
	self:SetVisible(true)
end
function RAIDCONFIRM:NewEntry(caller,target)
	if(self.RaidInfo == nil) then return end
	self:SetVisible(false)
	self:SetTitle("Confirm Raid against " .. target:Nick())
	self.ConfirmB:SetText("Yes")
	self.DenyB:SetText("No")
	local targetHasFaction = false
	if(target:Team() != 1) then targetHasFaction = true end
	if(targetHasFaction) then
		self.TextLabel:SetText("Do you want to raid " .. target:Nick() .. "? This will put your faction, " .. team.GetName(caller:Team()) .. " at war with the target and his/her faction, " .. team.GetName(target:Team()) .. ". Be prepared, however as they are able to counter-raid you!")
	else
		self.TextLabel:SetText("Do you want to raid " .. target:Nick() .. "? This will put your faction, " .. team.GetName(caller:Team()) .. " at war with the target. Be prepared, however as he/she can counter-raid you!")
	end
	self.ConfirmB.DoClick = function()
		local encryptionKey = ""
		encryptionKey = ""..target:Team()..","..caller:Team()..","..target:SteamID()..","..caller:SteamID()
		for k,v in pairs(player.GetAll()) do
			if(target == v) then
				MsgN("Running Console Command!")
				RunConsoleCommand("bw_raidsystem_confirm",k,encryptionKey)
				break
			end
		end
		self.RaidInfo.Removed = true
		self.RaidInfo:Remove()
		self.Removed = true
		self:Remove()
		
	end
	self.DenyB.DoClick = function()
		self.RaidInfo.Removed = true
		self.RaidInfo:Remove()
		self.Removed = true
		self:Remove()
	end
	self:SetVisible(true)
end
vgui.Register("RaidConfirm",RAIDCONFIRM,"DFrame")