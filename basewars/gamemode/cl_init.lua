
DeriveGamemode( "sandbox" );

include( "cl_skin.lua" );
include( "cl_deaths.lua" );
include( "shared.lua" );
include( "copypasta.lua" );
include( "cl_helpvgui.lua" );
include( "cl_scoreboard.lua" );
include( "cl_msg.lua" );
include( "cl_menu.lua" );
include( "cl_raidsystem.lua")
include( "swep_fix.lua" );
include( "vars.lua" );
include( "sh_netlib.lua")
include("cl_raidsystemhooks.lua")
include( "mawstream.lua")
include("fn.lua")
--include("workarounds.lua");

-- include("FPP/sh_settings.lua")
-- include("FPP/client/FPP_Menu.lua")
-- include("FPP/client/FPP_HUD.lua")
-- include("FPP/client/FPP_Buddies.lua")
-- include("FPP/sh_CPPI.lua")

drugeffect_doubletapmod = 0.675

GUIToggled = false;
HelpToggled = false;

HelpLabels = { }
HelpCategories = { }
RaidLabels = {}
RaidLabels["Raiding"] = {}
RaidLabels["Raided"] = {}


--------------Tribe
Tribes = {}

MoneyAlpha = -1
MoneyY = 0
MoneyAmount = 0

MyMoney = "Error Loading Money, rejoin or drop some money!"

local playerScanLogs

afkbigness = 255
afkdir = true
local Extracrap = { }

if( HelpVGUI ) then
	HelpVGUI:Remove();
end

HelpVGUI = nil;
DPan = nil;
StunStickFlashAlpha = -1;

local viewpl = nil
local viewpltime = 0

local viewstructure = nil
local viewstructuretime = 0

local bHitActive = false
local flFrameTime = 0
local x
local y
function ClientMsg(col,msg)
	MsgC(col,"(CLIENTSIDE) " .. msg)
end
function GM:Initialize()

	self.BaseClass:Initialize();

	surface.CreateFont( "HUDFont",
		{
			font      = "Default",
			size      = 16,
			weight    = 700,
		}

	)
	surface.CreateFont( "TickerFont",
		{
			font      = "HudHintTextSmall",
			size      = 18,
			weight    = 700,
		}
	)
	
	surface.CreateFont( "arial20", 
		{
		font = "arial",
		size = 16, 
		weight = 500
		}
	)
	
	surface.CreateFont( "arialbold", 
		{
		font = "arial",
		size = 16, 
		weight = 600
		}
	)
	
	surface.CreateFont( "teamfont", 
		{
		font = "DefaultBold",
		size = 30, 
		weight = 300
		}
	)
	surface.CreateFont( "HL2SelectIcons", 
		{ 
		font = "HL2MPTypeDeath",
		size = ScreenScale( 60 ), 
		weight = 500
		}
	)
	surface.CreateFont( "CSKillIcons", 
		{
		font = "csd",
		size = ScreenScale( 30 ), 
		weight = 500
		}
	)
	surface.CreateFont( "CSSelectIcons", 
		{
		font = "csd",
		size = ScreenScale( 60 ), 
		weight = 500
		}
	)
	surface.CreateFont("DRfont", 
		{
		font = "coolvertica", 
		size = 13, 
		weight = 500
		}
	)
	surface.CreateFont("SandboxLabel",
		{
		font = "coolvetica", 
		size = 64, 
		weight = 500
		}
	)
	surface.CreateFont("Upgradedeath",
		{
		font = "csd", 
		size = ScreenScale( 20 ), 
		weight = 500
		}
	)
	surface.CreateFont("HalfLife2",
		{
		font = "halflife2", 
		size = ScreenScale(32), 
		weight = 500
		}
	)
	surface.CreateFont("AFKFont",
		{
		font = "ChatFont", 
		size = 72, 
		weight = 700
		}
	)

	local tsize = 12
	if ScrW()>1000 then
		tsize=16
	end

	surface.CreateFont("MessageFont",
		{
		font = "Default", 
		size = tsize, 
		weight = 500
		}
	)
	surface.CreateFont("ArmorFont",
		{
		font = "ChatFont", 
		size = 22, 
		weight = 400
		}
	)
	surface.CreateFont("DrugFont",
		{
		font = "csd", 
		size = 32, 
		weight = 400
		}
	)
	surface.CreateFont("CSDFont",
		{
		font = "Counter-Strike", 
		size = 32, 
		weight = 400
		}
	)
	surface.CreateFont("DrugFont2",
		{
		font = "HalfLife2", 
		size = 50, 
		weight = 400
		}
	)
	surface.CreateFont("DefaultSmallDropShadow",
		{
		font = "Default", 
		size = 20, 
		weight = 500,
		shadow = true		
		}
	)
	
end


local function RecieveAdvert( um )
	GAMEMODE.LastAdvertColor = GAMEMODE.CurAdvertColor
	GAMEMODE.LastAdvertMsg = GAMEMODE.CurAdvertMsg
	GAMEMODE.CurAdvertColor = um:ReadShort()
	GAMEMODE.CurAdvertMsg = um:ReadString()
	GAMEMODE.LastAdvertChange = CurTime()
	--surface.PlaySound( "advert.wav" )
end
usermessage.Hook( "bw_advert", RecieveAdvert )

/*
function GM:Initialize()

	self.BaseClass:Initialize();
end

surface.CreateFont( "AFKFont", {
	font 		= "ChatFont",
	size 		= ScreenScale(72),
	weight 		= 700,
	shadow 		= false,	
	antialias 	= true
} )

//surface.CreateFont( "ChatFont", 72, 700, true, false, "AFKFont" );
// make it so that the small message font isnt too small to read for people with high res
local tsize = 12
if ScrW()>1000 then
	tsize=16
end
surface.CreateFont( "MessageFont", {
	font 		= "Default",
	size 		= tsize,
	weight 		= 500,
	shadow 		= false,	
	antialias 	= true
} )
surface.CreateFont( "Scoreboard", {
	font 		= "Default",
	size 		= ScreenScale(11),
	weight 		= 500,
	shadow 		= false,	
	antialias 	= true
} )

//surface.CreateFont( "Default", tsize, 500, true, false, "MessageFont")

//surface.CreateFont( "akbar", 20, 500, true, false, "AckBarWriting" );
surface.CreateFont( "AckBarWriting", {
	font 		= "akbar",
	size 		= 20,
	weight 		= 500,
	shadow		= false,		
	antialias 	= true
} )
*/
//surface.CreateFont( "HalfLife2", 74, 500, true, false, "HL2Symbols" );
surface.CreateFont( "HL2Symbols", {
	font 		= "HalfLife2",
	size 		= 74,
	weight 		= 500,
	shadow 		= false,	
	antialias 	= true
} )


function GetTextHeight( font, str )

	surface.SetFont( font );
	local w, h = surface.GetTextSize( str );
	
	return h;
	
end


function GetTextWidth( font, str )

	surface.SetFont( font );
	local w, h = surface.GetTextSize( str );
	
	return w;
	
end


local function DrawBox(startx, starty, sizex, sizey, color1,color2 )
	draw.RoundedBox( 0, startx, starty, sizex, sizey, color2 )
	draw.RoundedBox( 0, startx+1, starty+1, sizex-2, sizey-2, color1 )
end


function DrawPlayerInfo( ply, scn )

	if( not ply:Alive() ) then return; end

	local pos = ply:EyePos();
				
	pos.z = pos.z + 14;
	pos = pos:ToScreen();
	local mudkips = 0
	if scn then
		local weapn = ply:GetActiveWeapon()
		local wepclass = "Nothing"
		local wepammo = 0
		if IsValid(weapn) then
			wepclass = weapn:GetClass()
			wepammo = weapn:Clip1()
		end
---		draw.DrawText( "H: " .. tostring(ply:Health()) .. " A: " .. tostring(ply:Armor()) .. "\n" .. wepclass .. " " .. wepammo, "TargetID", pos.x + 1, pos.y + 41+mudkips, Color( 0, 0, 0, 255 ), 1 );
---		draw.DrawText( "H: " .. tostring(ply:Health()) .. " A: " .. tostring(ply:Armor()) .. "\n" .. wepclass .. " " .. wepammo, "TargetID", pos.x, pos.y+40+mudkips, Color(120,120,120,255), 1 );
	end
end


local Scans = {}

function ScannerSweep(msg)
	local ply = msg:ReadEntity()
	local pos = msg:ReadVector()
	local num = msg:ReadShort()
	Scans[num] = {}
	Scans[num].Time = CurTime()+10
	Scans[num].Pos = pos
	Scans[num].Ply = ply
end
usermessage.Hook("RadarScan", ScannerSweep)

function clearscan(index)
	//Msg(player.GetByID(index):GetName().."\n")
	Scans[index] = nil
end

function DrawScans()
	for k, v in pairs(Scans) do
		if v!=nil then
			local ply = v.Ply
			if IsValid(ply) then
				local pos = v.Pos + Vector(0,0,100)
				
				pos = pos:ToScreen();
				draw.DrawText( ply:Nick(), "TargetID", pos.x + 1, pos.y + 1, Color( 0, 0, 0, 255 ), 1 );
				draw.DrawText( ply:Nick(), "TargetID", pos.x, pos.y, team.GetColor( ply:Team() ), 1 );
				draw.DrawText( "SCAN", "TargetID", pos.x + 1, pos.y-16 + 1, Color( 0, 0, 0, 255 ), 1 );
				draw.DrawText( "SCAN", "TargetID", pos.x, pos.y-16, Color(255,0,0,255 ), 1 );
			end
			if v.Time<CurTime() then
				clearscan(k)
			end
		end
	end
end

function DrawBombInfo( ent )
	if LocalPlayer():GetPos():Distance(ent:GetPos())<2048 && ent:GetNWBool("armed") then
		local pos = ent:GetPos()+ent:GetAngles():Up()*30;
		
		pos.z = pos.z + 14;
		pos = pos:ToScreen();
		local time = math.ceil(ent:GetNWFloat("goofytiem")-CurTime())
		if time<=2 then
			time = CfgVars["bigbomblastmessage"]
		end
		draw.DrawText( "BOMB\n" .. tostring(time), "TargetID", pos.x + 1, pos.y + 1, Color( 0, 0, 0, 255 ), 1 );
		draw.DrawText( "BOMB\n" .. tostring(time), "TargetID", pos.x, pos.y, Color(255,0,0,255), 1 );
	end
end

function DrawNuclearInfo( ent )
		local pos = ent:GetPos()+ent:GetAngles():Up()*40;
		
		pos.z = pos.z + 14;
		pos = pos:ToScreen();
		draw.DrawText( "Nuclear Money Printer\n", "TargetID", pos.x + 1, pos.y + 1, Color( 0, 0, 0, 255 ), 1 );
		draw.DrawText( "Nuclear Money Printer\n", "TargetID", pos.x, pos.y, Color(255,0,0,255), 1 );
end

function DrawNovaInfo( ent )
		local pos = ent:GetPos()+ent:GetAngles():Up()*40;
		
		pos.z = pos.z + 14;
		pos = pos:ToScreen();
		draw.DrawText( "Nova Money Printer\n", "TargetID", pos.x + 1, pos.y + 1, Color( 0, 0, 0, 255 ), 1 );
		draw.DrawText( "Nova Money Printer\n", "TargetID", pos.x, pos.y, Color(255,0,0,255), 1 );
end


function DrawTurretInfo( ent )
	if LocalPlayer():GetPos():Distance(ent:GetPos())<258 && ent:GetNWBool("NotBuilt") then
		local pos = ent:GetPos()+ent:GetAngles():Up()*15;
		
		pos.z = pos.z + 14;
		pos = pos:ToScreen();
		
		draw.DrawText( "Press and Hold the Use Key to\nActivate your Turret!", "TargetID", pos.x, pos.y, Color(255,255,255,255), 1 );
	end
end

function DrawStructureInfo3d2d( ent, alpha )
	local pos = ent:GetPos();
	
	pos.z = pos.z + 14;
	pos = pos:ToScreen();
			if ent:GetClass()=="nucleargenerator" then
					DrawBox(pos.x-100, pos.y-50, 650, 100, Color(0,0,0,alpha), Color(50,50,50,alpha*1.5),1)
				elseif ent:GetClass()=="supergenerator" then
					DrawBox(pos.x-100, pos.y-50, 500, 100, Color(0,0,0,alpha), Color(50,50,50,alpha*1.5),1)
				elseif ent:GetClass()=="generator" then
					DrawBox(pos.x-100, pos.y-50, 350, 100, Color(0,0,0,alpha), Color(50,50,50,alpha*1.5),1)
				elseif ent:GetClass()=="supergunfactory" then
					DrawBox(pos.x-100, pos.y-50, 235, 100, Color(0,0,0,alpha), Color(50,50,50,alpha*1.5),1)
				elseif ent:GetClass()=="money_printer_nuclearfactory" then
					DrawBox(pos.x-100, pos.y-50, 235, 100, Color(0,0,0,alpha), Color(50,50,50,alpha*1.5),1)
				elseif ent:GetClass()=="money_printer_nova" then
					DrawBox(pos.x-100, pos.y-50, 275, 100, Color(0,0,0,alpha), Color(50,50,50,alpha*1.5),1)				
				else
					DrawBox(pos.x-100, pos.y-50, 200, 100, Color(0,0,0,alpha), Color(50,50,50,alpha*1.5),1)
			end
	local power = ent.Power
	local upgradestring = ""
	local upgrade = ent:GetNWInt("upgrade")
	if upgrade==1 then
		upgradestring= "I"
	elseif upgrade==2 then
		upgradestring = "II"
	elseif upgrade==3 then
		upgradestring = "III"
	elseif upgrade==4 then
		upgradestring = "IV"
	elseif upgrade==5 then
		upgradestring = "V"
	elseif upgrade==6 then
		upgradestring = "VI"
	elseif upgrade==7 then
		upgradestring = "VII"
	elseif upgrade==8 then
		upgradestring = "VIII"
	elseif upgrade==9 then
		upgradestring = "IX"
	elseif upgrade==10 then
		upgradestring = "X"
	end
	if ent:GetClass()=="nucleargenerator" then
			draw.DrawText(ent.PrintName, "TargetID", pos.x+209,pos.y-49, Color(0,0,0,alpha*2.55),1)
			draw.DrawText(ent.PrintName, "TargetID", pos.x+210,pos.y-50, Color(100,150,200,alpha*2.55),1)
			draw.RoundedBox(0,pos.x-100,pos.y-28, 650, 1, Color(50,50,50,alpha*1.5))
			draw.RoundedBox(0,pos.x-100,pos.y+27, 650, 1, Color(50,50,50,alpha*1.5))	
		elseif ent:GetClass()=="supergenerator" then
			draw.DrawText(ent.PrintName, "TargetID", pos.x+129,pos.y-49, Color(0,0,0,alpha*2.55),1)
			draw.DrawText(ent.PrintName, "TargetID", pos.x+130,pos.y-50, Color(100,150,200,alpha*2.55),1)
			draw.RoundedBox(0,pos.x-100,pos.y-28, 500, 1, Color(50,50,50,alpha*1.5))
			draw.RoundedBox(0,pos.x-100,pos.y+27, 500, 1, Color(50,50,50,alpha*1.5))
		elseif ent:GetClass()=="generator" then
			draw.DrawText(ent.PrintName, "TargetID", pos.x+49,pos.y-49, Color(0,0,0,alpha*2.55),1)
			draw.DrawText(ent.PrintName, "TargetID", pos.x+50,pos.y-50, Color(100,150,200,alpha*2.55),1)
			draw.RoundedBox(0,pos.x-100,pos.y-28, 350, 1, Color(50,50,50,alpha*1.5))
			draw.RoundedBox(0,pos.x-100,pos.y+27, 350, 1, Color(50,50,50,alpha*1.5))
		elseif ent:GetClass()=="supergunfactory" then
			draw.DrawText(ent.PrintName, "TargetID", pos.x+14,pos.y-49, Color(0,0,0,alpha*2.55),1)
			draw.DrawText(ent.PrintName, "TargetID", pos.x+15,pos.y-50, Color(100,150,200,alpha*2.55),1)
			draw.RoundedBox(0,pos.x-100,pos.y-28, 235, 1, Color(50,50,50,alpha*1.5))
			draw.RoundedBox(0,pos.x-100,pos.y+27, 235, 1, Color(50,50,50,alpha*1.5))
		elseif ent:GetClass()=="money_printer_nuclearfactory" then
			draw.DrawText(ent.PrintName, "TargetID", pos.x+14,pos.y-49, Color(0,0,0,alpha*2.55),1)
			draw.DrawText(ent.PrintName, "TargetID", pos.x+15,pos.y-50, Color(100,150,200,alpha*2.55),1)
			draw.RoundedBox(0,pos.x-100,pos.y-28, 235, 1, Color(50,50,50,alpha*1.5))
			draw.RoundedBox(0,pos.x-100,pos.y+27, 235, 1, Color(50,50,50,alpha*1.5))
		elseif ent:GetClass()=="money_printer_nova" then
			draw.DrawText(ent.PrintName, "TargetID", pos.x+14,pos.y-49, Color(0,0,0,alpha*2.55),1)
			draw.DrawText(ent.PrintName, "TargetID", pos.x+15,pos.y-50, Color(100,150,200,alpha*2.55),1)
			draw.RoundedBox(0,pos.x-100,pos.y-28, 275, 1, Color(50,50,50,alpha*1.5))
			draw.RoundedBox(0,pos.x-100,pos.y+27, 275, 1, Color(50,50,50,alpha*1.5))
		else
			draw.DrawText(ent.PrintName, "TargetID", pos.x-9,pos.y-49, Color(0,0,0,alpha*2.55),1)
			draw.DrawText(ent.PrintName, "TargetID", pos.x-10,pos.y-50, Color(100,150,200,alpha*2.55),1)
			draw.RoundedBox(0,pos.x-100,pos.y-28, 200, 1, Color(50,50,50,alpha*1.5))
			draw.RoundedBox(0,pos.x-100,pos.y+27, 200, 1, Color(50,50,50,alpha*1.5))
		end
	if upgrade>0 then
		draw.DrawText(upgradestring, "Default", pos.x+91,pos.y-45, Color(0,0,0,alpha*2.55),1)
		draw.DrawText(upgradestring, "Default", pos.x+90,pos.y-46, Color(200,200,0,alpha*2.55),1)
	end
	local pwr = false
	for i=1,power,1 do
		draw.DrawText( "Z", "HL2Symbols", pos.x-89+(i*30), pos.y-74, Color(0,0,0,alpha*1.55), 1 );
		if ent:GetNWInt("power")>=i then
			draw.DrawText( "Z", "HL2Symbols", pos.x-90+(i*30), pos.y-75, Color(0,255,0,alpha*1.55), 1 );
		else
			pwr = true
			draw.DrawText( "Z", "HL2Symbols", pos.x-90+(i*30), pos.y-75, Color(90,90,90,alpha*1.55), 1 );
		end
	end
	if pwr then
		draw.DrawText("Low power.", "TargetID", pos.x-9,pos.y-1, Color(0,0,0,alpha*2.55),1)
		draw.DrawText("Low power.", "TargetID", pos.x-10,pos.y, Color(150,0,0,alpha*2.55),1)
	end
	if ent:GetTable().TimeToFinish!=nil && ent:GetClass()=="gunfactory" && ent:GetTable().TimeToFinish>CurTime() then
		draw.DrawText(tostring(math.ceil(ent:GetTable().TimeToFinish-CurTime())), "TargetID", pos.x+79,pos.y-1, Color(0,0,0,alpha*2.55),1)
		draw.DrawText(tostring(math.ceil(ent:GetTable().TimeToFinish-CurTime())), "TargetID", pos.x+80,pos.y, Color(150,150,150,alpha*2.55),1)
	end
	if ent:GetTable().TimeToFinish2!=nil && ent:GetClass()=="supergunfactory" && ent:GetTable().TimeToFinish2>CurTime() then
		draw.DrawText(tostring(math.ceil(ent:GetTable().TimeToFinish2-CurTime())), "TargetID", pos.x+79,pos.y-1, Color(0,0,0,alpha*2.55),1)
		draw.DrawText(tostring(math.ceil(ent:GetTable().TimeToFinish2-CurTime())), "TargetID", pos.x+80,pos.y, Color(150,150,150,alpha*2.55),1)
	end	
end

function DrawStructureInfo( ent, alpha )
	local pos = ent:GetPos();
	
	pos.z = pos.z + 14;
	pos = pos:ToScreen();
			if ent:GetClass()=="nucleargenerator" then
					DrawBox(pos.x-100, pos.y-50, 650, 100, Color(0,0,0,alpha), Color(50,50,50,alpha*1.5),1)
				elseif ent:GetClass()=="supergenerator" then
					DrawBox(pos.x-100, pos.y-50, 500, 100, Color(0,0,0,alpha), Color(50,50,50,alpha*1.5),1)
				elseif ent:GetClass()=="generator" then
					DrawBox(pos.x-100, pos.y-50, 350, 100, Color(0,0,0,alpha), Color(50,50,50,alpha*1.5),1)
				elseif ent:GetClass()=="supergunfactory" then
					DrawBox(pos.x-100, pos.y-50, 235, 100, Color(0,0,0,alpha), Color(50,50,50,alpha*1.5),1)
				elseif ent:GetClass()=="money_printer_nuclearfactory" then
					DrawBox(pos.x-100, pos.y-50, 235, 100, Color(0,0,0,alpha), Color(50,50,50,alpha*1.5),1)
				elseif ent:GetClass()=="money_printer_nova" then
					DrawBox(pos.x-100, pos.y-50, 275, 100, Color(0,0,0,alpha), Color(50,50,50,alpha*1.5),1)
				else
					DrawBox(pos.x-100, pos.y-50, 200, 100, Color(0,0,0,alpha), Color(50,50,50,alpha*1.5),1)
			end
	local power = ent.Power
	local upgradestring = ""
	local upgrade = ent:GetNWInt("upgrade")
	if upgrade==1 then
		upgradestring= "I"
	elseif upgrade==2 then
		upgradestring = "II"
	elseif upgrade==3 then
		upgradestring = "III"
	elseif upgrade==4 then
		upgradestring = "IV"
	elseif upgrade==5 then
		upgradestring = "V"
	elseif upgrade==6 then
		upgradestring = "VI"
	elseif upgrade==7 then
		upgradestring = "VII"
	elseif upgrade==8 then
		upgradestring = "VIII"
	elseif upgrade==9 then
		upgradestring = "IX"
	elseif upgrade==10 then
		upgradestring = "X"
	end
	if ent:GetClass()=="nucleargenerator" then
			draw.DrawText(ent.PrintName, "TargetID", pos.x+209,pos.y-49, Color(0,0,0,alpha*2.55),1)
			draw.DrawText(ent.PrintName, "TargetID", pos.x+210,pos.y-50, Color(100,150,200,alpha*2.55),1)
			draw.RoundedBox(0,pos.x-100,pos.y-28, 650, 1, Color(50,50,50,alpha*1.5))
			draw.RoundedBox(0,pos.x-100,pos.y+27, 650, 1, Color(50,50,50,alpha*1.5))	
		elseif ent:GetClass()=="supergenerator" then
			draw.DrawText(ent.PrintName, "TargetID", pos.x+129,pos.y-49, Color(0,0,0,alpha*2.55),1)
			draw.DrawText(ent.PrintName, "TargetID", pos.x+130,pos.y-50, Color(100,150,200,alpha*2.55),1)
			draw.RoundedBox(0,pos.x-100,pos.y-28, 500, 1, Color(50,50,50,alpha*1.5))
			draw.RoundedBox(0,pos.x-100,pos.y+27, 500, 1, Color(50,50,50,alpha*1.5))
		elseif ent:GetClass()=="generator" then
			draw.DrawText(ent.PrintName, "TargetID", pos.x+49,pos.y-49, Color(0,0,0,alpha*2.55),1)
			draw.DrawText(ent.PrintName, "TargetID", pos.x+50,pos.y-50, Color(100,150,200,alpha*2.55),1)
			draw.RoundedBox(0,pos.x-100,pos.y-28, 350, 1, Color(50,50,50,alpha*1.5))
			draw.RoundedBox(0,pos.x-100,pos.y+27, 350, 1, Color(50,50,50,alpha*1.5))
		elseif ent:GetClass()=="supergunfactory" then
			draw.DrawText(ent.PrintName, "TargetID", pos.x+14,pos.y-49, Color(0,0,0,alpha*2.55),1)
			draw.DrawText(ent.PrintName, "TargetID", pos.x+15,pos.y-50, Color(100,150,200,alpha*2.55),1)
			draw.RoundedBox(0,pos.x-100,pos.y-28, 235, 1, Color(50,50,50,alpha*1.5))
			draw.RoundedBox(0,pos.x-100,pos.y+27, 235, 1, Color(50,50,50,alpha*1.5))
		elseif ent:GetClass()=="money_printer_nuclearfactory" then
			draw.DrawText(ent.PrintName, "TargetID", pos.x+14,pos.y-49, Color(0,0,0,alpha*2.55),1)
			draw.DrawText(ent.PrintName, "TargetID", pos.x+15,pos.y-50, Color(100,150,200,alpha*2.55),1)
			draw.RoundedBox(0,pos.x-100,pos.y-28, 235, 1, Color(50,50,50,alpha*1.5))
			draw.RoundedBox(0,pos.x-100,pos.y+27, 235, 1, Color(50,50,50,alpha*1.5))
		elseif ent:GetClass()=="money_printer_nova" then
			draw.DrawText(ent.PrintName, "TargetID", pos.x+14,pos.y-49, Color(0,0,0,alpha*2.55),1)
			draw.DrawText(ent.PrintName, "TargetID", pos.x+15,pos.y-50, Color(100,150,200,alpha*2.55),1)
			draw.RoundedBox(0,pos.x-100,pos.y-28, 275, 1, Color(50,50,50,alpha*1.5))
			draw.RoundedBox(0,pos.x-100,pos.y+27, 275, 1, Color(50,50,50,alpha*1.5))
		else
			draw.DrawText(ent.PrintName, "TargetID", pos.x-9,pos.y-49, Color(0,0,0,alpha*2.55),1)
			draw.DrawText(ent.PrintName, "TargetID", pos.x-10,pos.y-50, Color(100,150,200,alpha*2.55),1)
			draw.RoundedBox(0,pos.x-100,pos.y-28, 200, 1, Color(50,50,50,alpha*1.5))
			draw.RoundedBox(0,pos.x-100,pos.y+27, 200, 1, Color(50,50,50,alpha*1.5))
		end
	if upgrade>0 then
		draw.DrawText(upgradestring, "Default", pos.x+91,pos.y-45, Color(0,0,0,alpha*2.55),1)
		draw.DrawText(upgradestring, "Default", pos.x+90,pos.y-46, Color(200,200,0,alpha*2.55),1)
	end
	local pwr = false
    local xOff = GetTextWidth( "HL2Symbols" , "*" )
	for i=1,power,1 do
		local xOff = xOff + i*5.3
		draw.DrawText( "*", "HL2Symbols", pos.x-138+(i*30)+xOff, pos.y-51, Color(0,0,0,alpha*1.55), 1 );
		if ent:GetNWInt("power")>=i then
			draw.DrawText( "*", "HL2Symbols", pos.x-139+(i*30)+xOff, pos.y-52, Color(0,255,0,alpha*1.55), 1 );
		else
			pwr = true
			draw.DrawText( "*", "HL2Symbols", pos.x-139+(i*30)+xOff, pos.y-52, Color(90,90,90,alpha*1.55), 1 );
		end
	end
	if pwr then
		draw.DrawText("Low power.", "TargetID", pos.x-9,pos.y-1, Color(0,0,0,alpha*2.55),1)
		draw.DrawText("Low power.", "TargetID", pos.x-10,pos.y, Color(150,0,0,alpha*2.55),1)
	end
	if ent:GetTable().TimeToFinish!=nil && ent:GetClass()=="gunfactory" && ent:GetTable().TimeToFinish>CurTime() then
		draw.DrawText(tostring(math.ceil(ent:GetTable().TimeToFinish-CurTime())), "TargetID", pos.x+79,pos.y-1, Color(0,0,0,alpha*2.55),1)
		draw.DrawText(tostring(math.ceil(ent:GetTable().TimeToFinish-CurTime())), "TargetID", pos.x+80,pos.y, Color(150,150,150,alpha*2.55),1)
	end
	if ent:GetTable().TimeToFinish2!=nil && ent:GetClass()=="supergunfactory" && ent:GetTable().TimeToFinish2>CurTime() then
		draw.DrawText(tostring(math.ceil(ent:GetTable().TimeToFinish2-CurTime())), "TargetID", pos.x+79,pos.y-1, Color(0,0,0,alpha*2.55),1)
		draw.DrawText(tostring(math.ceil(ent:GetTable().TimeToFinish2-CurTime())), "TargetID", pos.x+80,pos.y, Color(150,150,150,alpha*2.55),1)
	end	
	if ent:GetClass()=="solargenerator" then
		for i=1,5,1 do
			draw.DrawText( "*", "HL2Symbols", pos.x-89+(i*30), pos.y-51, Color(0,0,0,alpha*1.55), 1 );
			if IsValid(ent:GetNWEntity("socket"..tostring(i))) || ent:GetNWEntity("socket"..tostring(i))==ent then
				draw.DrawText( "*", "HL2Symbols", pos.x-90+(i*30), pos.y-52, Color(255,0,0,alpha*1.55), 1 );
			else
				draw.DrawText( "*", "HL2Symbols", pos.x-90+(i*30), pos.y-52, Color(0,255,0,alpha*1.55), 1 );
			end
		end
	end

	if ent:GetClass()=="generator" then
		for i=1,10,1 do
			draw.DrawText( "*", "HL2Symbols", pos.x-89+(i*30), pos.y-51, Color(0,0,0,alpha*1.55), 1 );
			if IsValid(ent:GetNWEntity("socket"..tostring(i))) || ent:GetNWEntity("socket"..tostring(i))==ent then
				draw.DrawText( "*", "HL2Symbols", pos.x-90+(i*30), pos.y-52, Color(255,0,0,alpha*1.55), 1 );
			else
				draw.DrawText( "*", "HL2Symbols", pos.x-90+(i*30), pos.y-52, Color(0,255,0,alpha*1.55), 1 );
			end
		end
	end

	if ent:GetClass()=="supergenerator" then
		for i=1,15,1 do
			draw.DrawText( "*", "HL2Symbols", pos.x-89+(i*30), pos.y-51, Color(0,0,0,alpha*1.55), 1 );
			if IsValid(ent:GetNWEntity("socket"..tostring(i))) || ent:GetNWEntity("socket"..tostring(i))==ent then
				draw.DrawText( "*", "HL2Symbols", pos.x-90+(i*30), pos.y-52, Color(255,0,0,alpha*1.55), 1 );
			else
				draw.DrawText( "*", "HL2Symbols", pos.x-90+(i*30), pos.y-52, Color(0,255,0,alpha*1.55), 1 );
			end
		end
	end
	
	if ent:GetClass()=="nucleargenerator" then
		for i=1,20,1 do
			draw.DrawText( "*", "HL2Symbols", pos.x-89+(i*30), pos.y-51, Color(0,0,0,alpha*1.55), 1 );
			if IsValid(ent:GetNWEntity("socket"..tostring(i))) || ent:GetNWEntity("socket"..tostring(i))==ent then
				draw.DrawText( "*", "HL2Symbols", pos.x-90+(i*30), pos.y-52, Color(255,0,0,alpha*1.55), 1 );
			else
				draw.DrawText( "*", "HL2Symbols", pos.x-90+(i*30), pos.y-52, Color(0,255,0,alpha*1.55), 1 );
			end
		end
	end
/*	
	if ent:GetClass()=="powerplant" then
		for i=1,5,1 do
		local xOff = xOff + i*5.3
			draw.DrawText( "*", "HL2Symbols", pos.x-138+(i*30)+xOff, pos.y-51, Color(0,0,0,alpha*1.55), 1 );
			if IsValid(ent:GetNWEntity("socket"..tostring(i))) || ent:GetNWEntity("socket"..tostring(i))==ent then
				render.SetMaterial(Material('cable/redlaser'))
				render.DrawBeam( ent:GetPos(), ent:GetNWEntity("socket"..tostring(i)):GetPos(), 2, 0, 0, Color(255,255,255,255) )
				draw.DrawText( "*", "HL2Symbols", pos.x-139+(i*30)+xOff, pos.y-52, Color(255,0,0,alpha*1.55), 1 );
			else
				draw.DrawText( "*", "HL2Symbols", pos.x-139+(i*30)+xOff, pos.y-52, Color(0,255,0,alpha*1.55), 1 );
			end
		end
	end
	--Superpowerplant
		if ent:GetClass()=="superpowerplant" then
		for i=1,10,1 do
        local xOff = xOff + i*3.8
			draw.DrawText( "*", "HL2Symbols", pos.x-142+(i*30)+xOff, pos.y-51, Color(0,0,0,alpha*3.55), 1 );
			if IsValid(ent:GetNWEntity("socket"..tostring(i))) || ent:GetNWEntity("socket"..tostring(i))==ent then
				render.SetMaterial(Material('cable/redlaser'))
				render.DrawBeam( ent:GetPos(), ent:GetNWEntity("socket"..tostring(i)):GetPos(), 2, 0, 0, Color(255,255,255,255) )
				draw.DrawText( "*", "HL2Symbols", pos.x-143+(i*30)+xOff, pos.y-52, Color(255,0,0,alpha*1.55), 1 );
			else
				draw.DrawText( "*", "HL2Symbols", pos.x-143+(i*30)+xOff, pos.y-52, Color(0,255,0,alpha*1.55), 1 );
			end
		end
	end
*/	
end

function DrawDisplay()		
	local tr = LocalPlayer():GetEyeTrace();
	for k, v in pairs( ents.FindByClass("bigbomb") ) do
		
		DrawBombInfo( v );
		
	end
	for k, v in pairs( ents.FindByClass("money_printer_nuclear") ) do
		
		DrawNuclearInfo( v );
		
	end
	for k, v in pairs( ents.FindByClass("money_printer_nova") ) do
		
		DrawNovaInfo( v );
		
	end
	for k, v in pairs( ents.FindByClass("auto_turret") ) do
		
		DrawTurretInfo( v );
		
	end

	DrawScans()
	
	if !IsValid(tr.Entity) && IsValid(viewpl) && viewpltime>CurTime() && LocalPlayer():GetNWBool("scannered") then
		DrawPlayerInfo(viewpl,LocalPlayer():GetNWBool("scannered"))
	end
	if( tr.Entity!=nil and tr.Entity:IsValid() and tr.Entity:GetPos():Distance( LocalPlayer():GetPos() ) <= 768 ) then
	
		if( tr.Entity:IsPlayer() ) then
			viewpl = tr.Entity
			viewpltime = CurTime()+.5
			local scanner = LocalPlayer():GetNWBool("scannered")
			if(tr.Entity:GetPos():Distance(LocalPlayer():GetPos())<512 || scanner) then
				DrawPlayerInfo( tr.Entity,scanner );
			end
				
		elseif (tr.Entity:GetTable().Structure) then
			viewpltime = 0
			/*
			if tr.Entity:GetTable().HealthRadius!=nil then
				DrawStructureHealth(tr.Entity)
			end*/
			if viewstructure==tr.Entity then
				viewstructuretime = viewstructuretime+30*FrameTime()
			else
				viewstructure = tr.Entity
				viewstructuretime = 0
			end
			if viewstructuretime>=30 then
				local scanner = LocalPlayer():GetNWBool("scannered")
				if(tr.Entity:GetPos():Distance(LocalPlayer():GetPos())<256) then
					DrawStructureInfo( tr.Entity, math.Clamp((viewstructuretime-30)*5, 0, 100) );
				end
			end
		else
			if IsValid(viewpl) && viewpltime>CurTime() && LocalPlayer():GetNWBool("scannered") then
				DrawPlayerInfo(viewpl,LocalPlayer():GetNWBool("scannered"))
			end
			viewstructure = nil
			viewstructuretime = 0
		end
	end
end

-- Advert Stuff
local ADVERT_FADE_TIME = 2.00
GM.CurAdvertColor = 1 -- Using a color index for cached colors above
GM.CurAdvertMsg = ""
GM.LastAdvertColor = 1 -- ^
GM.LastAdvertMsg = ""
GM.LastAdvertChange = 0

-- Cached colors
local CachedColors = {}
CachedColors[1] =  Color( 255, 255, 255, 255 ) -- White
CachedColors[2] =  Color( 127, 127, 127, 255 ) -- Grey
CachedColors[3] =  Color( 255,   0,   0, 255 ) -- Red
CachedColors[4] =  Color(   0, 255,   0, 255 ) -- Green
CachedColors[5] =  Color(   0,   0, 255, 255 ) -- Blue
CachedColors[6] =  Color( 255, 255,   0, 255 ) -- Yellow
CachedColors[7] =  Color( 255, 128,   0, 255 ) -- Orange
CachedColors[8] =  Color(   0, 128, 255, 255 ) -- Teal
CachedColors[9] =  Color(   0, 255, 255, 255 ) -- Aqua
CachedColors[10] = Color( 255,   0, 255, 255 ) -- Violet
function GM:DrawRaidMessages()
	local height = draw.GetFontHeight("AgencyFB24")
	local raidedOffset = #RaidLabels["Raiding"]*height
	for k,v in pairs(RaidLabels["Raiding"]) do
		if(v.Team != 1) then
			draw.SimpleText("Raiding " .. team.GetName(v.Team) .. " - Time Left " .. tostring(math.Round(v.timeEnd - CurTime())) .. " seconds","AgencyFB24",ScrW()/2,k*height,Color(0,255,0,255),TEXT_ALIGN_CENTER)
		else
			draw.SimpleText("Raiding " .. v.Target:Nick() .. " - Time Left " .. tostring(math.Round(v.timeEnd - CurTime())) .. " seconds","AgencyFB24",ScrW()/2,k*height,Color(0,255,0,255),TEXT_ALIGN_CENTER)
		end
		if(math.Round(v.timeEnd - CurTime()) <= 0) then table.remove(RaidLabels["Raiding"],k) end
	end
	for k,v in pairs(RaidLabels["Raided"]) do
		draw.SimpleText("Getting Raided by " .. team.GetName(v.Team) .. " - Time Left " .. tostring(math.Round(v.timeEnd - CurTime())) .. " seconds","AgencyFB24",ScrW()/2,k*height+raidedOffset,Color(255,0,0,255),TEXT_ALIGN_CENTER)
		if(math.Round(v.timeEnd - CurTime()) <= 0) then table.remove(RaidLabels["Raided"],k) end
	end
end
function GM:HUDPaint()

	DrawDrugs()

	self.BaseClass:HUDPaint();
	self:PaintMessages()

	local sscale = ScrH() / 900 -- For scaling meters
	self:DrawAdvertBar( sscale )	
	self:DrawRaidMessages()
	
    local client = LocalPlayer()
 
	local hx = 9;
	local hy = ScrH() - 25;
	local hw = 190;
	local hh = 10;
    
    local heart = surface.GetTextureID( "gui/silkicons/heart" )
    local shield = surface.GetTextureID( "gui/silkicons/shield" )
    local money = surface.GetTextureID( "gui/silkicons/money" )
    
    local health = client:Health()
    local armor = client:Armor()
    local moneh = tostring(MyMoney)

	--draw.RoundedBox( 0, hx - 4, hy - 4, hw + 8, hh + 8, Color( 0, 0, 0, 200 ) );
	
	if( health > 0 ) then
        draw.RoundedBox( 0, 55, ScrH( ) -50, math.Clamp( health /100, 0, 1 ) *180, 15, Color( 255, 40, 40, 200 ) )
        draw.RoundedBox( 0, 55, ScrH( ) -50, math.Clamp( health /100, 0, 1 ) *180, 7, Color( 255, 255, 255, 20 ) )
        draw.SimpleText( health, "CloseCaption_Bold", 145, ScrH( ) -50, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )

        surface.SetTexture( heart )
        surface.SetDrawColor( 255, 255, 255, 255 )
        surface.DrawTexturedRect( 25, ScrH( ) -50, 16, 16 )

        surface.SetDrawColor( 0, 0, 0, 200 )
        surface.DrawOutlinedRect( 55, ScrH( ) -50, 180, 15 )
	end
	
	--draw.DrawText( LocalPlayer():Health(), "TargetID", hx + hw / 2, hy - 6, Color( 255, 255, 255, 200 ), 1 );

	--Drawing The Commas
	local function AddComma(n)
		local sn = tostring(n)
		sn = string.ToTable(sn)
		
		local tab = {}
		for i=0,#sn-1 do
			
			if i%3 == #sn%3 and !(i==0) then
				table.insert(tab, ",")
			end
			table.insert(tab, sn[i+1])
		
		end
		
		return string.Implode("",tab)
	end
	--Drawing The Commas
	
	draw.SimpleText( "$"..AddComma(moneh), "CloseCaption_Bold", 55, ScrH( ) -72, Color( 255, 255, 255, 255 ) )
	surface.SetTexture( money )
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( 25, ScrH( ) -72, 16, 16 )
	
	// Current Armor has to be a networked var, because player:Armor() doesn't do shit clientside.
	// ok so this was fixed. well too late. fuckit.
	// lets do nonsensical shit such as player:SetHealth(player:Health()+(100-player:Health()))
	if( armor > 0 ) then
		if ( health > 0 ) then
			draw.RoundedBox( 1, 55, ScrH( ) -28, math.Clamp( armor/100, 0, 1 ) *180, 15, Color( 40, 40, 170, 200 ) )
			draw.RoundedBox( 1, 55, ScrH( ) -28, math.Clamp( armor /100, 0, 1 ) *180, 7, Color( 255, 255, 255, 20 ) )
			draw.SimpleText( armor, "CloseCaption_Bold", 145, ScrH( ) -28, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )

			surface.SetTexture( shield )
			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.DrawTexturedRect( 25, ScrH( ) -28, 16, 16 )
        
			surface.SetDrawColor( 0, 0, 0, 200 )
			surface.DrawOutlinedRect( 55, ScrH( ) -28, 180, 15 )
		end
	end
	if( MoneyAlpha >= 0 ) then
		mul=-0.1
		if MoneyAmount<0 then
			draw.DrawText( tostring(MoneyAmount), "TargetID", 11, MoneyY + 1, Color( 0, 0, 0, MoneyAlpha ), 0 );
			draw.DrawText( tostring(MoneyAmount), "TargetID", 10, MoneyY, Color( 150, 20, 20, MoneyAlpha ), 0 );
		else
			draw.DrawText( "+" .. tostring(MoneyAmount), "TargetID", 11, MoneyY + 1, Color( 0, 0, 0, MoneyAlpha ), 0 );
			draw.DrawText( "+" .. tostring(MoneyAmount), "TargetID", 10, MoneyY, Color( 20, 150, 20, MoneyAlpha ), 0 );
		end
		MoneyAlpha = math.Clamp( MoneyAlpha - (255 * FrameTime()), -1, 255 );
		MoneyY = MoneyY - (50*FrameTime())
	
	end
/*	
	if( LetterAlpha > -1 ) then
	
		if( LetterY > ScrH() * .25 ) then
		
			LetterY = math.Clamp( LetterY - 300 * FrameTime(), ScrH() * .25, ScrH() / 2 );
		
		end
		
		if( LetterAlpha < 255 ) then
		
			LetterAlpha = math.Clamp( LetterAlpha + 400 * FrameTime(), 0, 255 );
		
		end
		
		local font = "";
		
		if( LetterType == 1 ) then
			font = "AckBarWriting";
		else
			font = "Default";
		end
		
		draw.RoundedBox( 2, ScrW() * .2, LetterY, ScrW() * .8 - ( ScrW() * .2 ), ScrH(), Color( 255, 255, 255, math.Clamp( LetterAlpha, 0, 200 ) ) );
		draw.DrawText( LetterMsg, font, ScrW() * .25 + 20, LetterY + 80, Color( 0, 0, 0, LetterAlpha ), 0 );
	end
*/	
	DrawDisplay();
end

function GM:DrawAdvertBar( sscale )
	local w, h = ScrW(), 20
	local scale = math.Clamp( (CurTime() - self.LastAdvertChange) / ADVERT_FADE_TIME, 0, 1 )
	local scale_flash = math.Clamp( (CurTime() - self.LastAdvertChange) / 0.80, 0, 1 )
	local scale_flash_r = (-scale_flash+1)
	local lscale = -scale+1

	surface.SetDrawColor( 20, 20, 20, 120 )
	surface.DrawRect( 0, 0, ScrW(), 20 )
	surface.SetDrawColor( 200, 200, 200, 120 )
	surface.DrawLine( 0, 20, ScrW(), 20 )
	surface.SetDrawColor( 0, 0, 0, 120 )
	surface.DrawLine( 0, 21, ScrW(), 21 )
	draw.RoundedBox( 4, 2, 2, w-4, 16, Color(scale_flash_r*255,scale_flash_r*255,scale_flash_r*255,200+55*scale_flash_r) )
	
	-- Ticker
	surface.SetFont( "HUDFont" )
	surface.SetTextColor( 255, 255, 255, 220 )
	surface.SetTextPos( 5, 4 )
	surface.DrawText( "F1: MOTD | F2: Factions | F3: (DISABLED) | F7: Music" )
	surface.SetTextPos(ScrW() - surface.GetTextSize("Clock: " .. tostring(os.date()) .. "     Ping: "..LocalPlayer():Ping()) - 50, 4)
	surface.DrawText("Clock: " .. tostring(os.date()) .. "     Ping: "..LocalPlayer():Ping())
	
	surface.SetFont( "arial20" )
	if scale > 0 then
		local c = CachedColors[self.CurAdvertColor or 1] or CachedColors[1]
		local tw, _ = surface.GetTextSize( self.CurAdvertMsg )
		surface.SetTextPos( w*0.50-tw*0.50, 1 )
		surface.SetTextColor( c.r, c.g, c.b, c.a*scale )
		surface.DrawText( self.CurAdvertMsg )
	end
	if lscale > 0 then
		local c = CachedColors[self.LastAdvertColor or 1] or CachedColors[1]
		local tw, _ = surface.GetTextSize( self.LastAdvertMsg )
		surface.SetTextPos( w*0.50-tw*0.50, 1 )
		surface.SetTextColor( c.r, c.g, c.b, c.a*lscale )
		surface.DrawText( self.LastAdvertMsg )
	end
end

function GM:HUDDrawTargetID()
end

function GM:HUDShouldDraw( name )

	if( name == "CHudHealth" or name == "CHudBattery" or name == "CHudSuitPower" ) then return false; end
	if( HelpToggled and name == "CHudChat" ) then return false; end
	
	return true;

end
/*
//surface.CreateFont( "ChatFont", 22, 400, true, false, "ArmorFont" );
surface.CreateFont( "ArmorFont", {
	font 		= "ChatFont",
	size 		= 22,
	weight 		= 400,
	antialias 	= true
} )
//surface.CreateFont( "csd", 32, 400, true, false, "DrugFont" );
surface.CreateFont( "DrugFont", {
	font 		= "csd",
	size 		= 32,
	weight 		= 400,
	antialias 	= true
} )
//surface.CreateFont( "Counter-Strike", 32, 400, true, false, "CSDFont");
surface.CreateFont( "CSDFont", {
	font 		= "Counter-Strike",
	size 		= 32,
	weight 		= 400,
	antialias 	= true
} )
//surface.CreateFont( "HalfLife2", 50, 400, true, false, "DrugFont2" );
surface.CreateFont( "DrugFont2", {
	font 		= "HalfLife2",
	size 		= 50,
	weight 		= 400,
	antialias 	= true
} )
*/
function DrawDrugs()
	local effects = 0
	local x = 7;
	local y = ScrH() - 36;
	
	// put a little circle at the health bar or some shit to show having snipe shield
	// better yet, a cs armor logo.
	if (LocalPlayer():GetNWBool("shielded")==true) then
		draw.DrawText( "p", "DrugFont", x+129, y-109, Color(  0,  0,  0,200), 0)--49
		draw.DrawText( "p", "DrugFont", x+128, y-110, Color(255,255,255,255),0) --50
	end
	if (LocalPlayer():GetNWBool("helmeted")==true) then
		draw.DrawText( "E", "DrugFont", x+149, y-109, Color(  0,  0,  0,200), 0)--49
		draw.DrawText( "E", "DrugFont", x+148, y-110, Color(255,255,255,255),0) --50
	end
	if (LocalPlayer():GetNWBool("poisoned")==true) then
		draw.DrawText("C", "DrugFont", x+93, y-94, Color( 0,0,  0,200), 0)--39
		draw.DrawText("C", "DrugFont", x+92, y-95, Color(50,250,0,255),0) --40
	end
	if (LocalPlayer():GetNWBool("scannered")==true) then
		draw.DrawText( "H", "DrugFont", x+132, y-89, Color(  0,  0,  0,200), 0) --29
		draw.DrawText( "H", "DrugFont", x+131, y-90, Color(255,255,255,255),0)  --30
	end
	if (LocalPlayer():GetNWBool("tooled")==true) then
		draw.DrawText( "f", "CSDFont", x+153, y-96, Color(  0,  0,  0,200), 0) --34
		draw.DrawText( "f", "CSDFont", x+154, y-97, Color(255,255,255,255),0) ---35
	end
	if (LocalPlayer():GetNWBool("nightvisioned")==true) then
		draw.DrawText( "s", "CSDFont",x+169, y-94, Color(0,0,0,200),0) ------59
		draw.DrawText( "s", "CSDFont",x+168, y-95, Color(255,255,255,255),0) -----60
	end
	
	local effectslots = {}
	effectslots[0] = 0
	effectslots[1] = 0
	effectslots[2] = 0
	
	for k,v in pairs(drugtable) do
		if LocalPlayer():GetNWBool(drugtable[k].string)==true then
			local offset = 0
			local soffset = 0
			local soffset2 = 0
			if k=="leech" then soffset=-2 soffset2=5 end
			if k=="focus" then soffset=-4 end
			if drugtable[k].font == "DrugFont2" then offset = -25 end
			
			draw.DrawText(drugtable[k].symbol, drugtable[k].font, x+soffset+(effectslots[drugtable[k].type]*20)-3, y-133+soffset2+(drugtable[k].type*20)+offset-1, Color(0,0,0,200), 0)
			draw.DrawText(drugtable[k].symbol, drugtable[k].font, x+soffset+(effectslots[drugtable[k].type]*20)-3, y-133+soffset2+(drugtable[k].type*20)+offset, drugtable[k].color,0)
			effectslots[drugtable[k].type] = effectslots[drugtable[k].type]+1
		end
	end
	DrugTrails()
	
end

function DrawDrugTrail(color, ent, effect)
	local type = effect or "drug_trail"
	if type==none then return end
	local r = color.r
	local g = color.g
	local b = color.b
	if type=="drug_bolt" then
		local gun = ent:GetActiveWeapon()
		if IsValid(gun) then
			local attachpos = gun:GetAttachment(1)
			if attachpos!=nil then
				local effectdata = EffectData()
					effectdata:SetOrigin( attachpos.Pos )
					effectdata:SetStart( Vector( r, g, b ) )
					effectdata:SetEntity( ent )
					effectdata:SetNormal(ent:GetAimVector())
				util.Effect( effect, effectdata )
			end
		end
	else
		local effectdata = EffectData()
			effectdata:SetOrigin( ent:GetPos() )
			effectdata:SetStart( Vector( r, g, b ) )
			effectdata:SetRadius(64)
			effectdata:SetEntity( ent )
		util.Effect( effect, effectdata )
	end
end

local drawstuff = false
function DrugTrails()
	if drawstuff then
		for i, q in pairs(player.GetAll()) do
			if q!=LocalPlayer() then
				for k,v in pairs(drugtable) do
					if q:GetNWBool(drugtable[k].string)==true && math.random(1,5)>4 then
						local type="drug_trail"
						if drugtable[k].type == 1 then type="drug_glow" end
						if drugtable[k].type == 2 then type="drug_bolt" end
						DrawDrugTrail(drugtable[k].color,q,type)
					end
				end
			end
		end
	end
	drawstuff = !drawstuff
end

function EndStunStickFlash()

	StunStickFlashAlpha = -1;

end

/*
LetterY = 0;
LetterAlpha = -1;
LetterMsg = "";
LetterType = 0;
LetterStartTime = 0;
LetterPos = Vector( 0, 0, 0 );

function ShowLetter( msg )

	LetterType = msg:ReadShort();
	LetterPos = msg:ReadVector();
	LetterMsg = msg:ReadString();
	LetterY = ScrH() / 2;
	LetterAlpha = 0;
	LetterStartTime = CurTime();

end
usermessage.Hook( "ShowLetter", ShowLetter );


function GM:Think()

	if( LetterAlpha > -1 and LocalPlayer():GetPos():Distance( LetterPos ) > 125 ) then
	
		LetterAlpha = -1;
	
	end

end

function KillLetter( msg )

	LetterAlpha = -1;

end
usermessage.Hook( "KillLetter", KillLetter );
*/

function UpdateHelp()

	function tDelayHelp()

		if( HelpVGUI ) then

			HelpVGUI:Remove();
			
			if( HelpToggled ) then
				HelpVGUI = vgui.Create( "HelpVGUI" );
			end
			
		end
	
	end
	
	timer.Simple( .5, tDelayHelp );
	
end
usermessage.Hook( "UpdateHelp", UpdateHelp );
/*
function ToggleClicker()

	GUIToggled = !GUIToggled;

	gui.EnableScreenClicker( GUIToggled );

	for k, v in pairs( VoteVGUI ) do
	
		v:SetMouseInputEnabled( GUIToggled );
	
	end

end
usermessage.Hook( "ToggleClicker", ToggleClicker );
*/
function AddHelpLabel( msg )

	local id = msg:ReadShort();
	local category = msg:ReadShort();
	local text = msg:ReadString();
	local constant = msg:ReadShort();
	
	local function tAddHelpLabel( id, category, text, constant )

		for k, v in pairs( HelpLabels ) do
		
			if( v.id == id ) then
			
				v.text = text;
				return;
			
			end
		
		end
		
		table.insert( HelpLabels, { id = id, category = category, text = text, constant = constant } );
		
	end
	
	timer.Simple( .01,function() tAddHelpLabel( id, category, text, constant ) end);

end
usermessage.Hook( "AddHelpLabel", AddHelpLabel );

function ChangeHelpLabel( msg )

	local id = msg:ReadShort();
	local text = msg:ReadString();

	local function tChangeHelpLabel( id, text )
	
		for k, v in pairs( HelpLabels ) do
		
			if( v.id == id ) then
			
				v.text = text;
				return;
			
			end
		
		end
		
	end
	
	timer.Simple( .01, function() tChangeHelpLabel( id, text ) end);

end
usermessage.Hook( "ChangeHelpLabel", ChangeHelpLabel );

function AddHelpCategory( msg )

	local id = msg:ReadShort();
	local text = msg:ReadString();
	
	local function tAddHelpCategory( id, text )
	
		table.insert( HelpCategories, { id = id, text = text } );

	end
		
	timer.Simple( .01, function() tAddHelpCategory( id, text ) end);
		
end
usermessage.Hook( "AddHelpCategory", AddHelpCategory );


function MoneyChange( msg )
	
	MoneyAmount = tonumber(msg:ReadString())
	MyMoney = tonumber(msg:ReadString())
	MoneyAlpha = 255;
	MoneyY = ScrH() - 75;
	
end
usermessage.Hook( "MoneyChange", MoneyChange );


/*==========================================================
==							  ==
==							  ==
==========================================================*/

// the damn children with microphones never shut the fuck up.
// copy pastad this from ULX admin mod, ulyssesmod.net

GVGUI = { }
PanelNumg = 0;

function MsgGunVault( msg )
	local gunlist = string.Explode(",", msg:ReadString() )
	local vault = msg:ReadShort()
	local upgradelist = string.Explode(",", msg:ReadString() )
	local inputenabled = false;
	if( HelpToggled or GUIToggled ) then
		inputenabled = true;
	end
	local panel = vgui.Create( "DFrame" );
	panel:SetPos( ScrW()/2-200 , ScrH() / 2 - 50 );
--	panel:SetName( "Panel" );
	panel:SetSize( 160, 200 );
	panel:SetTitle( "Select Gun" );

	panel:SetKeyboardInputEnabled( false );
	panel:SetMouseInputEnabled( true );
	panel:SetVisible( true );
	panel:MakePopup( );
	local divider = vgui.Create( "Divider" );
	divider:SetParent( panel );
	divider:SetPos( 2, 30 );
	divider:SetSize( 180, 2 );
	divider:SetVisible( true );
	local ybutton = {}
	local upgradelabel = {}
	if gunlist[1]!="" then
		for i=1, table.Count(gunlist), 1 do
			_G["PickFunc" .. i] = function( msg )
				LocalPlayer():ConCommand( "withdrawgun " .. vault .. " " .. i .. "\n" );
			end
			
			ybutton[i] = vgui.Create( "Button" );
			ybutton[i]:SetParent( panel );
			ybutton[i]:SetPos( 15, 20+(i*15) );
			ybutton[i]:SetSize( 130, 14 );
			ybutton[i]:SetCommand( "!" );
			local gunname = gunlist[i]
			ybutton[i]:SetText( gunname );
			ybutton[i]:SetActionFunction( _G["PickFunc" .. i] );
			ybutton[i]:SetVisible( true );
		
			table.insert( GVGUI, ybutton[i] );

			if (util.tobool(upgradelist[i])) then
				upgradelabel[i] = vgui.Create("DLabel")
				upgradelabel[i]:SetParent(panel)
				upgradelabel[i]:SetPos(146, 18+(i*15))
				upgradelabel[i]:SetSize(12,12)
				upgradelabel[i]:SetText("+")
				upgradelabel[i]:SetVisible(true)
			
				table.insert(GVGUI, upgradelabel[i])
			end
		
		end
	else
		// just tell them its empty, in the event of stupid people.
		local label = vgui.Create( "DLabel" );
		label:SetParent( panel );
		label:SetPos( 15, 45 );
		label:SetSize( 130, 40 );
		label:SetText( "Gun Vault is Empty! \nDrop guns into it before \ntrying to take guns out." );
		label:SetVisible( true );
		table.insert( GVGUI, label )
	end
	PanelNumg = PanelNumg + 1;
	GVGUI[vault] = panel;
end
usermessage.Hook( "gunvaultgui", MsgGunVault );

function MsgPillBox( msg )
	local gunlist = string.Explode(",", msg:ReadString() )
	local vault = msg:ReadShort()
	// local upgradelist = string.Explode(",", msg:ReadString() )
	local inputenabled = false;
	if( HelpToggled or GUIToggled ) then
		inputenabled = true;
	end
	local panel = vgui.Create( "DFrame" );
	panel:SetPos( ScrW()/2-200 , ScrH() / 2 - 50 );
--	panel:SetName( "Panel" );
	panel:SetSize( 320, 200 );
	panel:SetTitle( "Select Drug" );

	panel:SetKeyboardInputEnabled( false );
	panel:SetMouseInputEnabled( true );
	panel:SetVisible( true );
	panel:MakePopup( );
	local divider = vgui.Create( "Divider" );
	divider:SetParent( panel );
	divider:SetPos( 2, 30 );
	divider:SetSize( 360, 2 );
	divider:SetVisible( true );
	local ybutton = {}
	local upgradelabel = {}
	if gunlist[1]!="" then
		for i=1, table.Count(gunlist), 1 do
			_G["PickFunc" .. i] = function( msg )
				LocalPlayer():ConCommand( "withdrawitem " .. vault .. " " .. i .. "\n" );
			end
			
			ybutton[i] = vgui.Create( "Button" );
			ybutton[i]:SetParent( panel );
			if (i>10) then
				ybutton[i]:SetPos( 15+135, 20+((i-10)*15) )
			else
				ybutton[i]:SetPos( 15, 20+(i*15) );
			end
			ybutton[i]:SetSize( 130, 14 );
			ybutton[i]:SetCommand( "!" );
			local gunname = gunlist[i]
			ybutton[i]:SetText( gunname );
			ybutton[i]:SetActionFunction( _G["PickFunc" .. i] );
			ybutton[i]:SetVisible( true );
		
			table.insert( GVGUI, ybutton[i] );
		
		end
	else
		// just tell them its empty, in the event of stupid people.
		local label = vgui.Create( "DLabel" );
		label:SetParent( panel );
		label:SetPos( 15, 45 );
		label:SetSize( 130, 40 );
		label:SetText( "Drug Vault is Empty! \nDrop drugs into it before \ntrying to take drugs out." );
		label:SetVisible( true );
		table.insert( GVGUI, label )
	end
	PanelNumg = PanelNumg + 1;
	GVGUI[vault] = panel;
end
usermessage.Hook( "pillboxgui", MsgPillBox );


-----------------------------------------------------Gun Factory-----------------------------------------------------
function MsgGunFactory( msg )
	local upgrade = msg:ReadShort()
	local vault = msg:ReadShort()
	local inputenabled = false;
	local cancelmode = msg:ReadBool()
	if( HelpToggled or GUIToggled ) then
		inputenabled = true;
	end
	local panel = vgui.Create( "DFrame" );
	panel:SetPos( ScrW()/2-200 , ScrH() / 2 - 50 );
--	panel:SetName( "Panel" );
	local ttl = "Select Weapon"
	if cancelmode then
		ttl = "Cancel Weapon"
	end
	panel:SetSize( 160, 140 );
	panel:SetTitle( ttl );

	panel:SetKeyboardInputEnabled( false );
	panel:SetMouseInputEnabled( true );
	panel:SetVisible( true );
	panel:MakePopup( );
	local divider = vgui.Create( "Divider" );
	divider:SetParent( panel );
	divider:SetPos( 2, 30 );
	divider:SetSize( 180, 2 );
	divider:SetVisible( true );
	local ybutton = {}
	_G["PickFunc1"] = function( msg )
		LocalPlayer():ConCommand( "setgunfactoryweapon " .. vault .. " laserbeam\n" );
	end
	_G["PickFunc2"] = function( msg )
		LocalPlayer():ConCommand( "setgunfactoryweapon " .. vault .. " laserrifle\n" );
	end
	_G["PickFunc3"] = function( msg )
		LocalPlayer():ConCommand( "setgunfactoryweapon " .. vault .. " grenadegun\n" );
	end
	_G["PickFunc4"] = function( msg )
		LocalPlayer():ConCommand( "setgunfactoryweapon " .. vault .. " worldslayer\n" );
	end
	_G["PickFunc5"] = function (msg)
		LocalPlayer():ConCommand( "setgunfactoryweapon " .. vault .. " resetbutton\n" );
	end
	_G["PickFunc6"] = function (msg)
		LocalPlayer():ConCommand( "setgunfactoryweapon " .. vault .. " plasma\n" );
	end
	if !cancelmode then
	ybutton[1] = vgui.Create( "Button" );
	ybutton[1]:SetParent( panel );
	ybutton[1]:SetPos( 15, 35 );
	ybutton[1]:SetSize( 130, 14 );
	ybutton[1]:SetCommand( "!" );
	ybutton[1]:SetText( "Laser Pistol $1500" );
	ybutton[1]:SetActionFunction( _G["PickFunc1"] );
	ybutton[1]:SetVisible( true );
	table.insert( GVGUI, ybutton[1] );
	
	ybutton[2] = vgui.Create( "Button" );
	ybutton[2]:SetParent( panel );
	ybutton[2]:SetPos( 15, 50 );
	ybutton[2]:SetSize( 130, 14 );
	ybutton[2]:SetCommand( "!" );
	ybutton[2]:SetText( "Laser Rifle $1500" );
	ybutton[2]:SetActionFunction( _G["PickFunc2"] );
	ybutton[2]:SetVisible( true );
	table.insert( GVGUI, ybutton[2] );
	
	if upgrade>=1 then
		ybutton[3] = vgui.Create( "Button" );
		ybutton[3]:SetParent( panel );
		ybutton[3]:SetPos( 15, 65 );
		ybutton[3]:SetSize( 130, 14 );
		ybutton[3]:SetCommand( "!" );
		ybutton[3]:SetText( "Grenade Launcher $3000" );
		ybutton[3]:SetActionFunction( _G["PickFunc3"] );
		ybutton[3]:SetVisible( true );
		table.insert( GVGUI, ybutton[3] );
		
		ybutton[4] = vgui.Create( "Button" );
		ybutton[4]:SetParent( panel );
		ybutton[4]:SetPos( 15, 80 );
		ybutton[4]:SetSize( 130, 14 );
		ybutton[4]:SetCommand( "!" );
		ybutton[4]:SetText( "Plasma Rifle $3750" );
		ybutton[4]:SetActionFunction( _G["PickFunc6"] );
		ybutton[4]:SetVisible( true );
		table.insert( GVGUI, ybutton[4] );
	end
	
	if upgrade>=2 then
		ybutton[5] = vgui.Create( "Button" );
		ybutton[5]:SetParent( panel );
		ybutton[5]:SetPos( 15, 95 );
		ybutton[5]:SetSize( 130, 14 );
		ybutton[5]:SetCommand( "!" );
		ybutton[5]:SetText( "Worldslayer $7500" );
		ybutton[5]:SetActionFunction( _G["PickFunc4"] );
		ybutton[5]:SetVisible( true );
		table.insert( GVGUI, ybutton[5] );
		
	end
	else
	ybutton[1] = vgui.Create( "Button" );
	ybutton[1]:SetParent( panel );
	ybutton[1]:SetPos( 15, 35 );
	ybutton[1]:SetSize( 130, 14 );
	ybutton[1]:SetCommand( "!" );
	ybutton[1]:SetText( "Cancel" );
	ybutton[1]:SetActionFunction( _G["PickFunc5"] );
	ybutton[1]:SetVisible( true );
	table.insert( GVGUI, ybutton[1] );
	end
	PanelNumg = PanelNumg + 1;
	GVGUI[vault] = panel;
end
usermessage.Hook( "gunfactorygui", MsgGunFactory );


function MsgGunFactoryGet( msg )
	local time = msg:ReadFloat()
	local ent = msg:ReadEntity()
	if IsValid(ent) then
		ent:GetTable().TimeToFinish = time
	end
end
usermessage.Hook( "gunfactoryget", MsgGunFactoryGet );

-------------------------------------------------- Super Gun Factory --------------------------------------------------
function MsgSuperGunFactory( msg )
	local upgrade = msg:ReadShort()
	local vault = msg:ReadShort()
	local inputenabled = false;
	local cancelmode = msg:ReadBool()
	if( HelpToggled or GUIToggled ) then
		inputenabled = true;
	end
	local panel = vgui.Create( "DFrame" );
	panel:SetPos( ScrW()/2-200 , ScrH() / 2 - 50 );
--	panel:SetName( "Panel" );
	local ttl = "Select Weapon"
	if cancelmode then
		ttl = "Cancel Weapon"
	end
	panel:SetSize( 160, 140 );
	panel:SetTitle( ttl );

	panel:SetKeyboardInputEnabled( false );
	panel:SetMouseInputEnabled( true );
	panel:SetVisible( true );
	panel:MakePopup( );
	local divider = vgui.Create( "Divider" );
	divider:SetParent( panel );
	divider:SetPos( 2, 30 );
	divider:SetSize( 180, 2 );
	divider:SetVisible( true );
	local ybutton = {}
	_G["PickFunc1"] = function( msg )
		LocalPlayer():ConCommand( "supergunfactoryweapon " .. vault .. " flamer\n" );
	end
	_G["PickFunc2"] = function( msg )
		LocalPlayer():ConCommand( "supergunfactoryweapon " .. vault .. " m82\n" );
	end
	_G["PickFunc3"] = function( msg )
		LocalPlayer():ConCommand( "supergunfactoryweapon " .. vault .. " vollmer\n" );
	end
	_G["PickFunc4"] = function( msg )
		LocalPlayer():ConCommand( "supergunfactoryweapon " .. vault .. " m60a3\n" );
	end
	_G["PickFunc5"] = function (msg)
		LocalPlayer():ConCommand( "supergunfactoryweapon " .. vault .. " resetbutton\n" );
	end
	_G["PickFunc6"] = function (msg)
		LocalPlayer():ConCommand( "supergunfactoryweapon " .. vault .. " fatman\n" );
	end
	if !cancelmode then
	ybutton[1] = vgui.Create( "Button" );
	ybutton[1]:SetParent( panel );
	ybutton[1]:SetPos( 15, 35 );
	ybutton[1]:SetSize( 130, 14 );
	ybutton[1]:SetCommand( "!" );
	ybutton[1]:SetText( "Flamethrower $3000" );
	ybutton[1]:SetActionFunction( _G["PickFunc1"] );
	ybutton[1]:SetVisible( true );
	table.insert( GVGUI, ybutton[1] );

	if upgrade>=1 then	
		ybutton[2] = vgui.Create( "Button" );
		ybutton[2]:SetParent( panel );
		ybutton[2]:SetPos( 15, 50 );
		ybutton[2]:SetSize( 130, 14 );
		ybutton[2]:SetCommand( "!" );
		ybutton[2]:SetText( "Barret M82 $5000" );
		ybutton[2]:SetActionFunction( _G["PickFunc2"] );
		ybutton[2]:SetVisible( true );
		table.insert( GVGUI, ybutton[2] );
	end
	
	if upgrade>=2 then
		ybutton[3] = vgui.Create( "Button" );
		ybutton[3]:SetParent( panel );
		ybutton[3]:SetPos( 15, 65 );
		ybutton[3]:SetSize( 130, 14 );
		ybutton[3]:SetCommand( "!" );
		ybutton[3]:SetText( "MC51 Vollmer $7000" );
		ybutton[3]:SetActionFunction( _G["PickFunc3"] );
		ybutton[3]:SetVisible( true );
		table.insert( GVGUI, ybutton[3] );
	end
	
	if upgrade>=3 then	
		ybutton[4] = vgui.Create( "Button" );
		ybutton[4]:SetParent( panel );
		ybutton[4]:SetPos( 15, 80 );
		ybutton[4]:SetSize( 130, 14 );
		ybutton[4]:SetCommand( "!" );
		ybutton[4]:SetText( "Auto Ordance $9000" );
		ybutton[4]:SetActionFunction( _G["PickFunc4"] );
		ybutton[4]:SetVisible( true );
		table.insert( GVGUI, ybutton[4] );
	end
	
	if upgrade>=4 then
		ybutton[5] = vgui.Create( "Button" );
		ybutton[5]:SetParent( panel );
		ybutton[5]:SetPos( 15, 95 );
		ybutton[5]:SetSize( 130, 14 );
		ybutton[5]:SetCommand( "!" );
		ybutton[5]:SetText( "Fat Man $11000" );
		ybutton[5]:SetActionFunction( _G["PickFunc6"] );
		ybutton[5]:SetVisible( true );
		table.insert( GVGUI, ybutton[5] );
	end
	
	else
	ybutton[1] = vgui.Create( "Button" );
	ybutton[1]:SetParent( panel );
	ybutton[1]:SetPos( 15, 35 );
	ybutton[1]:SetSize( 130, 14 );
	ybutton[1]:SetCommand( "!" );
	ybutton[1]:SetText( "Cancel" );
	ybutton[1]:SetActionFunction( _G["PickFunc5"] );
	ybutton[1]:SetVisible( true );
	table.insert( GVGUI, ybutton[1] );
	end
	PanelNumg = PanelNumg + 1;
	GVGUI[vault] = panel;
end
usermessage.Hook( "supergunfactorygui", MsgSuperGunFactory );


function MsgSuperGunFactoryGet( msg )
	local time = msg:ReadFloat()
	local ent = msg:ReadEntity()
	if IsValid(ent) then
		ent:GetTable().TimeToFinish2 = time
	end
end
usermessage.Hook( "supergunfactoryget", MsgSuperGunFactoryGet );


function msgShockWaveEffect(msg)
	local start = msg:ReadVector()
	local norm = msg:ReadAngle()
	local radius = msg:ReadShort()
	local efdt = EffectData()
		efdt:SetStart(start)
		efdt:SetOrigin(start)
		efdt:SetScale(1)
		efdt:SetRadius(radius)
		efdt:SetNormal(norm)
	util.Effect("cball_bounce",efdt)
end
usermessage.Hook("shockwaveeffect", msgShockWaveEffect)

function MsgDrugFactory( msg )
	local upgrade = msg:ReadShort()
	local vault = msg:ReadShort()
	local booze = msg:ReadShort()
	local drugs = msg:ReadShort()
	local rands = msg:ReadShort()
	local sdefense = msg:ReadShort()
	local soffense = msg:ReadShort()
	local sweapmod = msg:ReadShort()
	local mode = msg:ReadShort()
	
	local inputenabled = false;
	if( HelpToggled or GUIToggled ) then
		inputenabled = true;
	end
	local panel = vgui.Create( "DFrame" );
	panel:SetPos( ScrW()/2-200 , ScrH() / 2 - 50 );
--	panel:SetName( "Panel" );
	panel:SetSize( 160, 210 );
	panel:SetTitle( "Drug Refinery" );

	panel:SetKeyboardInputEnabled( false );
	panel:SetMouseInputEnabled( true );
	panel:SetVisible( true );
	panel:MakePopup( );
	local divider = vgui.Create( "Divider" );
	divider:SetParent( panel );
	divider:SetPos( 2, 30 );
	divider:SetSize( 180, 2 );
	divider:SetVisible( true );
	local ybutton = {}
	local ylabel = {}
	
	local maxbooze = 50
	local maxdrug = 100
	if upgrade==1 then
		maxdrug=70
		maxbooze=40
	elseif upgrade==2 then
		maxdrug=50
		maxbooze=30
	end
	
	ylabel[1] = vgui.Create( "DLabel" );
	ylabel[1]:SetParent( panel );
	ylabel[1]:SetPos( 15, 35 );
	ylabel[1]:SetSize( 130, 14 );
	ylabel[1]:SetText( "Booze: "..tostring(booze).."/"..tostring(maxbooze) );
	ylabel[1]:SetVisible(true)
	table.insert( GVGUI, ylabel[1] );
	
	ylabel[2] = vgui.Create( "DLabel" );
	ylabel[2]:SetParent( panel );
	ylabel[2]:SetPos( 15, 50 );
	ylabel[2]:SetSize( 130, 14 );
	ylabel[2]:SetText( "Drugs: "..tostring(drugs).."/"..tostring(maxdrug) );
	ylabel[2]:SetVisible( true );
	table.insert( GVGUI, ylabel[2] );
	
	ylabel[3] = vgui.Create( "DLabel" );
	ylabel[3]:SetParent( panel );
	ylabel[3]:SetPos( 15, 65 );
	ylabel[3]:SetSize( 130, 14 );
	ylabel[3]:SetText( "RandomDrugs: "..tostring(rands).."/10" );
	ylabel[3]:SetVisible( true );
	table.insert( GVGUI, ylabel[3] );
	
	ylabel[4] = vgui.Create( "DLabel" );
	ylabel[4]:SetParent( panel );
	ylabel[4]:SetPos( 15, 80 );
	ylabel[4]:SetSize( 130, 14 );
	ylabel[4]:SetText( "Superdrugs: "..tostring(soffense).."/3, "..tostring(sdefense).."/3, "..tostring(sweapmod).."/3" );
	ylabel[4]:SetVisible( true );
	table.insert( GVGUI, ylabel[4] );
	
	local rmode = "Money"
	if mode==1 then rmode="S. Offense"
	elseif mode==2 then rmode="S. Defense"
	elseif mode==3 then rmode="S. Weapon Mod"
	end
	
	ylabel[5] = vgui.Create( "DLabel" );
	ylabel[5]:SetParent( panel );
	ylabel[5]:SetPos( 15, 95 );
	ylabel[5]:SetSize( 130, 14 );
	ylabel[5]:SetText( "Refining to "..rmode );
	ylabel[5]:SetVisible( true );
	table.insert( GVGUI, ylabel[5] );
	
	_G["PickFunc1"] = function( msg )
		LocalPlayer():ConCommand( "setrefinerymode " .. vault .. " money\n" );
	end
	_G["PickFunc2"] = function( msg )
		LocalPlayer():ConCommand( "setrefinerymode " .. vault .. " offense\n" );
	end
	_G["PickFunc3"] = function( msg )
		LocalPlayer():ConCommand( "setrefinerymode " .. vault .. " defense\n" );
	end
	_G["PickFunc4"] = function( msg )
		LocalPlayer():ConCommand( "setrefinerymode " .. vault .. " weapmod\n" );
	end
	_G["PickFunc5"] = function (msg)
		LocalPlayer():ConCommand( "setrefinerymode " .. vault .. " eject\n" );
	end
	_G["PickFunc6"] = function(msg)
		LocalPlayer():ConCommand("setrefinerymode "..vault.." uber\n")
	end
	ybutton[1] = vgui.Create( "Button" );
	ybutton[1]:SetParent( panel );
	ybutton[1]:SetPos( 15, 110 );
	ybutton[1]:SetSize( 130, 14 );
	ybutton[1]:SetCommand( "!" );
	ybutton[1]:SetText( "Eject SuperDrugs" );
	ybutton[1]:SetActionFunction( _G["PickFunc5"] );
	ybutton[1]:SetVisible( true );
	table.insert( GVGUI, ybutton[1] );
	
	ybutton[5] = vgui.Create( "Button" );
	ybutton[5]:SetParent( panel );
	ybutton[5]:SetPos( 15, 125 );
	ybutton[5]:SetSize( 130, 14 );
	ybutton[5]:SetCommand( "!" );
	ybutton[5]:SetText( "Refine to Money" );
	ybutton[5]:SetActionFunction( _G["PickFunc1"] );
	ybutton[5]:SetVisible( true );
	table.insert( GVGUI, ybutton[5] );
	local ymod=0
	if upgrade>=1 then
		ybutton[2] = vgui.Create( "Button" );
		ybutton[2]:SetParent( panel );
		ybutton[2]:SetPos( 15, 140 );
		ybutton[2]:SetSize( 130, 14 );
		ybutton[2]:SetCommand( "!" );
		ybutton[2]:SetText( "Refine to Offense" );
		ybutton[2]:SetActionFunction( _G["PickFunc2"] );
		ybutton[2]:SetVisible( true );
		table.insert( GVGUI, ybutton[2] );

		ybutton[3] = vgui.Create( "Button" );
		ybutton[3]:SetParent( panel );
		ybutton[3]:SetPos( 15, 155 );
		ybutton[3]:SetSize( 130, 14 );
		ybutton[3]:SetCommand( "!" );
		ybutton[3]:SetText( "Refine to Defense" );
		ybutton[3]:SetActionFunction( _G["PickFunc3"] );
		ybutton[3]:SetVisible( true );
		table.insert( GVGUI, ybutton[3] );
		
		ybutton[4] = vgui.Create( "Button" );
		ybutton[4]:SetParent( panel );
		ybutton[4]:SetPos( 15, 170 );
		ybutton[4]:SetSize( 130, 14 );
		ybutton[4]:SetCommand( "!" );
		ybutton[4]:SetText( "Refine to Weapon Mod" );
		ybutton[4]:SetActionFunction( _G["PickFunc4"] );
		ybutton[4]:SetVisible( true );
		table.insert( GVGUI, ybutton[4] );
		ymod = 45
	end
	if upgrade>=2 && soffense>=3 && sdefense>=3 && sweapmod>=3 then
		ybutton[6] = vgui.Create( "Button" );
		ybutton[6]:SetParent( panel );
		ybutton[6]:SetPos( 15, 140+ymod );
		ybutton[6]:SetSize( 130, 14 );
		ybutton[6]:SetCommand( "!" );
		ybutton[6]:SetText( "Create UberDrug" );
		ybutton[6]:SetActionFunction( _G["PickFunc6"] );
		ybutton[6]:SetVisible( true );
		table.insert( GVGUI, ybutton[6] );
	end
	table.insert( GVGUI, ybutton[1] );
	PanelNumg = PanelNumg + 1;
	GVGUI[vault] = panel;
end
usermessage.Hook( "drugfactorygui", MsgDrugFactory );


// exact typo every time.
function Curtime()
	return CurTime()
end

language.Add("CombineCannon_ammo", "Flamethrower Fuel")
language.Add("SniperRound_ammo", "Sniper Rounds")
language.Add("SMG_ammo", "Rifle Rounds")
language.Add("Pistol_ammo", "Pistol Ammo")
language.Add("SLAM_ammo", "Grenades")
language.Add("XBowBolt_ammo", "Dart Gun Bolts")
language.Add("env_fire", "Fire")
language.Add("env_physexplosion", "The Game")
language.Add("entityflame", "Flames")
language.Add("env_explosion", "Explosion")
language.Add("SBoxLimit_magnets", "You have hit the Magnet limit!")

-- setpos 43.548927 711.829834 -65.131531;setang 4.179978 -176.199966 0.000000



--function OriginCam( ply )
--if LocalPlayer():GetNWBool("OrginCam") then
--local camangleX = math.Clamp( input, -36, 66 )
--local camangleY = math.Clamp( input, -106, 166  )
--
--	local StartCam = {}
--	StartCam.angles = Angle(camangleX,camangleY,0) -- x = -6, 
--	StartCam.origin = Vector(46,652,20)
--	StartCam.drawviewmodel = false
--	StartCam.drawhud = false
--	StartCam.x = 0
--	StartCam.y = 0
--	StartCam.w = ScrW()
--	StartCam.h = ScrH()
--	render.RenderView( StartCam )
--
--        cam.Start3D2D( Vector(43, 711, -65), Angle(0, 0, 0), 1 )
--                draw.DrawText("Enter the Server...", "ScoreboardText", 0, 0, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
--        cam.End3D2D()
--
--	end
--end
--hook.Add("HUDPaint", "OriginCam", OriginCam)


--local focalDistance = 500
--local focalRadius = 4
--local focalPoint = Vector(0)
--
--function GM:CalcView( pl, origin, angles, fov )
--	local view = {}
--	local lookAt = origin + angles:Forward() * focalDistance + focalPoint
--	focalPoint = Vector( math.sin( RealTime() ) * focalRadius, math.cos( RealTime() / 5 ) * focalRadius, math.sin( RealTime() ) * focalRadius );
--		view.angles = LerpAngle( 0.9, angles, (lookAt-origin):Angle() )
--			return view
--end

/*---------------------------------------------------------
   Tribe
---------------------------------------------------------*/
function TribesMenu(ply)
local DermaPanel = vgui.Create( "DFrame" )
         DermaPanel:SetTitle("Faction Menu")
		 DermaPanel:SetSkin("stronghold")
                 DermaPanel:SetDraggable(true)
                 DermaPanel:SetDeleteOnClose(false)
         DermaPanel:SetKeyboardInputEnabled(true)
         DermaPanel:SetMouseInputEnabled(true)
         DermaPanel:MakePopup()
         DermaPanel:SetSize(ScrW() / 4, 400)
         DermaPanel:SetPos(ScrW() / 2 - (DermaPanel:GetWide() / 2), 50)
                 DermaPanel:Center()
         
         local line = 30
         local tab = 0      
                 
    local PropertySheet = vgui.Create( "DPropertySheet", DermaPanel )
        PropertySheet:SetPos( 5, 30 )
        PropertySheet:SetSize(DermaPanel:GetWide() - 12, DermaPanel:GetTall() - 35);
       
        local SheetItemOne = vgui.Create( "DPanel", PropertySheet )
        SheetItemOne:SetSize(PropertySheet:GetWide(), PropertySheet:GetTall())
//		SheetItemOne.Paint = function() -- Paint function
//	surface.SetDrawColor( 50, 50, 50, 255 )
//	surface.DrawRect( 0, 0, SheetItemOne:GetWide(), SheetItemOne:GetTall() ) -- Draw the rect
                //end
        local tnamelabel = vgui.Create("DLabel", SheetItemOne)
                tnamelabel:SetPos(3,0) //30
                tnamelabel:SetText("Faction Name")
                tnamelabel:SizeToContents()
               
        local tname = vgui.Create("DTextEntry",SheetItemOne)
                tname:SetSize(SheetItemOne:GetWide()-20, 30)
        tname:SetPos(3, 20) //50
               
        local tpwlabel = vgui.Create("DLabel", SheetItemOne)
                tpwlabel:SetPos(3,55) //85
                tpwlabel:SetText("Faction Password")
	tpwlabel:SizeToContents()
               
        local tpw = vgui.Create("DTextEntry", SheetItemOne)
                tpw:SetSize(SheetItemOne:GetWide()-20, 30)
        tpw:SetPos(3, 75) //105
               
        local tcollabel = vgui.Create("DLabel", SheetItemOne)
                tcollabel:SetPos(3,110) //140
                tcollabel:SetText("Faction Color")
                tcollabel:SizeToContents()
               
        local tcolor = vgui.Create("DColorMixer", SheetItemOne)
                tcolor:SetSize(SheetItemOne:GetWide()+5, 150)
        tcolor:SetPos(3, 130) //160
               
        local button = vgui.Create("DButton", SheetItemOne)
         button:SetSize(SheetItemOne:GetWide()-15, 30)
         button:SetPos(3, 290) //315
         button:SetText("Create Your Faction!")
                 button.DoClick = function()
                        RunConsoleCommand("bw_create", tname:GetValue(), tcolor:GetColor().r, tcolor:GetColor().g, tcolor:GetColor().b, tpw:GetValue())
                        DermaPanel:SetVisible(false)
                 end
                 
        local SheetItemTwo = vgui.Create( "DPanel", PropertySheet )
        SheetItemTwo:SetSize(PropertySheet:GetWide(), PropertySheet:GetTall())
//		SheetItemTwo.Paint = function() -- Paint function
//	surface.SetDrawColor( 50, 50, 50, 255 )
//	surface.DrawRect( 0, 0, SheetItemTwo:GetWide(), SheetItemTwo:GetTall() ) -- Draw the rect
//				end
        local factionlist = vgui.Create("DListView", SheetItemTwo)
        factionlist:SetPos(3,5)
        factionlist:SetSize(SheetItemTwo:GetWide()-20,SheetItemTwo:GetTall()-200)
        factionlist:SetMultiSelect(false)
        factionlist:AddColumn("Name")
        //local ScoreboardInfo = GM:GetTeamScoreInfo()
        for k,v in pairs(team.GetAllTeams()) do  //could probably be simplified A LOT. this is terrible, never use it.
			if team.NumPlayers(k) >= 1 then
				for k1,v1 in pairs(v) do 
					if (k1 == "Name") then
						factionlist:AddLine(v1)
					end
				end
			end
		end
        
        local tpwlabel = vgui.Create("DLabel", SheetItemTwo)
                tpwlabel:SetPos(3,210) //85
                tpwlabel:SetText("Faction Password")
               
        local tpw = vgui.Create("DTextEntry", SheetItemTwo)
                tpw:SetSize(SheetItemOne:GetWide()-20, 30)
        tpw:SetPos(3, 230) //105
 
        local button = vgui.Create("DButton", SheetItemTwo)
         button:SetSize(SheetItemTwo:GetWide()-15, 30)
         button:SetPos(3, 290) //315
         button:SetText("Join")
                 button.DoClick = function()
                        local selectedfaction = factionlist:GetLine(factionlist:GetSelectedLine()):GetValue(1)
						if (selectedfaction == "Citizen") then
							RunConsoleCommand("bw_leave")
						else
							RunConsoleCommand("bw_join", selectedfaction, tpw:GetValue())
						end
                        DermaPanel:SetVisible(false)
                 end
				
		local SheetItemThree = vgui.Create( "DPanel", PropertySheet )
        SheetItemThree:SetSize(PropertySheet:GetWide(), PropertySheet:GetTall())
//		SheetItemThree.Paint = function() -- Paint function
//	surface.SetDrawColor( 50, 50, 50, 255 )
//	surface.DrawRect( 0, 0, SheetItemThree:GetWide(), SheetItemThree:GetTall() ) -- Draw the rect
//				end
		if !(LocalPlayer():GetNWBool("FactionLeader")) then 
			local label = vgui.Create("DLabel", SheetItemThree)
			label:SetPos(SheetItemThree:GetWide() - 275,5)
			label:SetText("You are not the leader of your faction!\n\n\n\nIf you're looking to leave your current faction,\njust rejoin Citizen's in the Join tab :)")
			label:SizeToContents()
		else
        local factionlist = vgui.Create("DListView", SheetItemThree)
        factionlist:SetPos(3,5)
        factionlist:SetSize(SheetItemThree:GetWide()-20,SheetItemThree:GetTall()-200)
        factionlist:SetMultiSelect(false)
        factionlist:AddColumn("Name")
        //local ScoreboardInfo = GM:GetTeamScoreInfo()
        for k,v in pairs(team.GetPlayers(LocalPlayer():Team())) do
			factionlist:AddLine(v:Nick())
		end
        local button1 = vgui.Create("DButton", SheetItemThree)
         button1:SetSize(SheetItemThree:GetWide() / 2, 30)
         button1:SetPos(3, 290) //315
         button1:SetText("Promote to leader")
                 button1.DoClick = function()
                        local selectedfaction = factionlist:GetLine(factionlist:GetSelectedLine()):GetValue(1)
						RunConsoleCommand("bw_promote", selectedfaction)
                        DermaPanel:SetVisible(false)
                 end
		local button2 = vgui.Create("DButton", SheetItemThree)
		button2:SetSize((SheetItemThree:GetWide() / 2) - 15, 30)
		button2:SetPos(3 + (SheetItemThree:GetWide() / 2), 290)
		button2:SetText("Remove user from faction")
			button2.DoClick = function()
                        local selectedfaction = factionlist:GetLine(factionlist:GetSelectedLine()):GetValue(1)
						RunConsoleCommand("bw_removeteammate", selectedfaction)
                        DermaPanel:SetVisible(false)
                 end
		end

        PropertySheet:AddSheet( "Create", SheetItemOne, "icon16/brick_add.png", false, false, "Create your faction" )
        PropertySheet:AddSheet( "Join", SheetItemTwo, "icon16/group.png", false, false, "Join someone's faction" )
		PropertySheet:AddSheet( "Management", SheetItemThree, "icon16/wrench.png", false, false, "Manage your faction" )
end

/*---------------------------------------------------------
  Tribe menu
---------------------------------------------------------*/
concommand.Add("bw_factionmenu", TribesMenu)

/*---------------------------------------------------------
   Tribe system
---------------------------------------------------------*/
function GM.getTribes(data)
	team.SetUp(data:ReadShort(),data:ReadString(),Color(data:ReadShort(),data:ReadShort(),data:ReadShort(),255))
end
usermessage.Hook("recvTribes",GM.getTribes)

function GM.ReceiveTribe(data)
	local name = data:ReadString()
	local id = data:ReadShort()
	local red = data:ReadShort()
	local green = data:ReadShort()
	local blue = data:ReadShort()
	team.SetUp(id,name,Color(red,green,blue,255))
end
usermessage.Hook("newTribe",GM.ReceiveTribe)

/*
hook.Add( "PlayerTraceAttack", "PlayerHitMarker", function( ply, dmginfo, dir, trace )
  if ( dmginfo:GetAttacker() == LocalPlayer() ) then
    bHitActive = true
	flFrameTime = CurTime() + FrameTime() * 15
  end
end )

hook.Add( "HUDPaint", "CHitMarker", function()

  local player	= LocalPlayer()
  if ( !player:Alive() ) then return end

  // Ask the gamemode if it's ok to do this
  if ( !gamemode.Call( "HUDShouldDraw", "CHitMarker" ) ) then return end

  if ( bHitActive and flFrameTime > CurTime() ) then
	x = ScrW() / 2
	y = ScrH() / 2
	surface.SetDrawColor( 255, 255, 255, 200 )
	surface.DrawLine( x+7, y-7, x+15, y-15 )
	surface.DrawLine( x-7, y+7, x-15, y+15 )
	surface.DrawLine( x+7, y+7, x+15, y+15 )
	surface.DrawLine( x-7, y-7, x-15, y-15 )
  else
    bHitActive = false
  end

end )



local DoorType = {"func_door","prop_door_rotating","func_door_rotating"}

hook.Add("HUDPaint", "DoorTrace", function()
	local pos = LocalPlayer():GetShootPos()
	local ang = LocalPlayer():GetAimVector()
	local trd = {}
	trd.start = pos
	trd.endpos = pos+(ang*300)
	trd.filter = LocalPlayer()
	local tr = util.TraceLine(trd)
		if tr.HitNonWorld then
			local tar = tr.Entity
			--if !tar then return end
			if tar:GetPos():Distance(LocalPlayer():GetPos()) < 300 then
				if table.HasValue(DoorType, tar:GetClass()) then
					if tar:GetNWInt("State") == 0 then
						draw.DrawText("Unowned Door", "HUDNumber2", ScrW()/2, ScrH()/2, Color(0, 0, 0),TEXT_ALIGN_CENTER)
						draw.DrawText("Unowned Door", "HUDNumber2", ScrW()/2-1, ScrH()/2-1, Color(0, 143, 52),TEXT_ALIGN_CENTER)
						local prop = tar:GetNWString("Property", "None")
						draw.DrawText("Property: "..prop, "Trebuchet20", ScrW()/2, ScrH()/2+40, Color(255, 255, 255),TEXT_ALIGN_CENTER)
						draw.DrawText("Price: "..tar:GetNWInt("Price", 75), "Trebuchet20", ScrW()/2, ScrH()/2+60, Color(255, 255, 255),TEXT_ALIGN_CENTER)
					elseif tar:GetNWInt("State") == -1 then
						draw.DrawText("Unownable Door", "HUDNumber2", ScrW()/2, ScrH()/2, Color(0, 0, 0),TEXT_ALIGN_CENTER)
						draw.DrawText("Unownable Door", "HUDNumber2", ScrW()/2-1, ScrH()/2-1, Color(0, 143, 52),TEXT_ALIGN_CENTER)
					elseif tar:GetNWInt("State") == 1 then
						local own = tar:GetNWEntity("DOwner")
						local w, h = surface.GetTextSize("Owned Door")
//						local w, h = surface.GetTextSize("Owned By: "..own:Nick())						
						draw.DrawText("Owned Door", "HUDNumber2", ScrW()/2, ScrH()/2, Color(0, 0, 0),TEXT_ALIGN_CENTER)
						draw.DrawText("Owned Door", "HUDNumber2", ScrW()/2-1, ScrH()/2-1, Color(255, 143, 4),TEXT_ALIGN_CENTER)
//						draw.DrawText("Owned By: "..own:Nick(), "HUDNumber2", ScrW()/2, ScrH()/2, Color(0, 0, 0),TEXT_ALIGN_CENTER)
//						draw.DrawText("Owned By: "..own:Nick(), "HUDNumber2", ScrW()/2-1, ScrH()/2-1, Color(255, 143, 4),TEXT_ALIGN_CENTER)
						local prop = tar:GetNWString("Property", "None")
						draw.DrawText("Property: "..prop, "Trebuchet20", ScrW()/2, ScrH()/2+40, Color(255, 255, 255),TEXT_ALIGN_CENTER)
					end
				end
			end
		end
end)
*/

local tblFonts = { }
tblFonts["DebugFixed"] = {
	font = "Courier New",
	size = 10,
	weight = 500,
	antialias = true,
}

tblFonts["DebugFixedSmall"] = {
	font = "Courier New",
	size = 7,
	weight = 500,
	antialias = true,
}

tblFonts["DefaultFixedOutline"] = {
	font = "Lucida Console",
	size = 10,
	weight = 0,
	outline = true,
}

tblFonts["MenuItem"] = {
	font = "Tahoma",
	size = 12,
	weight = 500,
}

tblFonts["Default"] = {
	font = "Tahoma",
	size = 13,
	weight = 500,
}

tblFonts["TabLarge"] = {
	font = "Tahoma",
	size = 13,
	weight = 700,
	shadow = true,
}

tblFonts["DefaultBold"] = {
	font = "Tahoma",
	size = 13,
	weight = 500,
}

tblFonts["DefaultUnderline"] = {
	font = "Tahoma",
	size = 13,
	weight = 500,
	underline = true,
}

tblFonts["DefaultSmall"] = {
	font = "Tahoma",
	size = 11,
	weight = 490,
}

tblFonts["DefaultSmallDropShadow"] = {
	font = "Tahoma",
	size = 11,
	weight = 400,
	shadow = true,
}

tblFonts["DefaultVerySmall"] = {
	font = "Tahoma",
	size = 10,
	weight = 400,
}

tblFonts["DefaultLarge"] = {
	font = "Tahoma",
	size = 16,
	weight = 400,
}

tblFonts["UiBold"] = {
	font = "Tahoma",
	size = 12,
	weight = 1000,
}

tblFonts["MenuLarge"] = {
	font = "Verdana",
	size = 15,
	weight = 600,
	antialias = true,
}

tblFonts["ConsoleText"] = {
	font = "Lucida Console",
	size = 10,
	weight = 500,
}

tblFonts["Marlett"] = {
	font = "Marlett",
	size = 13,
	weight = 400,
	symbol = true,
}

tblFonts["HUDNumber"] = {
	font = "Trebuchet MS",
	size = 40,
	weight = 900,
}

tblFonts["HUDNumber1"] = {
	font = "Trebuchet MS",
	size = 41,
	weight = 900,
}

tblFonts["HUDNumber2"] = {
	font = "Trebuchet MS",
	size = 42,
	weight = 900,
}

tblFonts["HUDNumber3"] = {
	font = "Trebuchet MS",
	size = 43,
	weight = 900,
}

tblFonts["HUDNumber4"] = {
	font = "Trebuchet MS",
	size = 44,
	weight = 900,
}

tblFonts["HUDNumber5"] = {
	font = "Trebuchet MS",
	size = 45,
	weight = 900,
}

tblFonts["HudHintTextLarge"] = {
	font = "Verdana",
	size = 14,
	weight = 1000,
	antialias = true,
	additive = true,
}

tblFonts["HudHintTextSmall"] = {
	font = "Verdana",
	size = 11,
	weight = 400,
	antialias = true,
	additive = true,
}

tblFonts["CenterPrintText"] = {
	font = "Trebuchet MS",
	size = 18,
	weight = 900,
	antialias = true,
	additive = true,
}

tblFonts["DefaultFixed"] = {
	font = "Lucida Console",
	size = 10,
	weight = 400,
}

tblFonts["DefaultFixedDropShadow"] = {
	font = "Lucida Console",
	size = 10,
	weight = 400,
	shadow = true,
}

tblFonts["CloseCaption_Normal"] = {
	font = "Tahoma",
	size = 16,
	weight = 500,
}

tblFonts["CloseCaption_Italic"] = {
	font = "Tahoma",
	size = 16,
	weight = 500,
	italic = true,
}

tblFonts["CloseCaption_Bold"] = {
	font = "Tahoma",
	size = 16,
	weight = 900,
}

tblFonts["CloseCaption_BoldItalic"] = {
	font = "Tahoma",
	size = 16,
	weight = 900,
	italic = true,
}

tblFonts["TargetID"] = {
	font = "Trebuchet MS",
	size = 22,
	weight = 900,
	antialias = true,
}

tblFonts["TargetIDSmall"] = {
	font = "Trebuchet MS",
	size = 18,
	weight = 900,
	antialias = true,
}

tblFonts["Trebuchet19"] = {
	font = "Trebuchet MS",
	size = 19,
	weight = 400,
	antialias = true,
}

tblFonts["Trebuchet22"] = {
	font = "Trebuchet MS",
	size = 22,
	weight = 400,
	antialias = true,
}

tblFonts["Trebuchet24"] = {
	font = "Trebuchet MS",
	size = 24,
	weight = 400,
	antialias = true,
}

tblFonts["BudgetLabel"] = {
	font = "Courier New",
	size = 14,
	weight = 400,
	outline = true,
}
tblFonts["AgencyFB36"] = {
		font = "AGENCY FB Bold",
		size = 36,
		weight = 400,
		antialias = true,
}
tblFonts["AgencyFB12"] = {
		font = "AGENCY FB Bold",
		size = 12,
		weight = 400,
		antialias = true,
}
tblFonts["AgencyFB24"] = {
		font = "AGENCY FB Bold",
		size = 24,
		weight = 400,
		antialias = true,
}


for k,v in SortedPairs( tblFonts ) do
	surface.CreateFont( k, tblFonts[k] );

	print( "Added font '"..k.."'" );
end