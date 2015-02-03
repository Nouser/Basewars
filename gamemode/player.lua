if ( CLIENT ) then

	CreateConVar( "cl_playercolor", "0.24 0.34 0.41", { FCVAR_ARCHIVE, FCVAR_USERINFO, FCVAR_DONTRECORD }, "The value is a Vector - so between 0-1 - not between 0-255" )
	CreateConVar( "cl_weaponcolor", "0.30 1.80 2.10", { FCVAR_ARCHIVE, FCVAR_USERINFO, FCVAR_DONTRECORD }, "The value is a Vector - so between 0-1 - not between 0-255" )

end

/*---------------------------------------------------------
 Variables
 ---------------------------------------------------------*/
local meta = FindMetaTable( "Player" );

function meta:NewData()
/*
	if( self:GetNWString("Status", "Founder")== "Founder") then
		self:GetTable().Money = 10000000
	end
	if( self:GetNWString("Status", "Guest")== "VIP") then
		if( self:GetNWString("SubStatus", "Guest")== "VIP01") then
			self:GetTable().Money = 1000000
		end
		if( self:GetNWString("SubStatus", "Guest")== "VIP02") then
			self:GetTable().Money = 5000000
		end
		if( self:GetNWString("SubStatus", "Guest")== "VIP03") then
			self:GetTable().Money = 10000000
		end
		if( self:GetNWString("SubStatus", "Guest")== "Staff") then
			self:GetTable().Money = 25000
		end		
	end
	if ( self:GetNWString("Status", "Guest")== "Guest") then
		self:GetTable().Money = 10000
	end
*/	
	self:GetTable().Pay = 1;
	self:GetTable().LastPayDay = CurTime();

	self:GetTable().Owned = { }
	self:GetTable().OwnedNum = 0;
	
	self:SetTeam( 1 );
	
    timer.Create( self:SteamID() .. "jobtimer", CfgVars["paydelay"], 0, function() self:PayDay() end);

end

function meta:IsAllied(ply)
	if tonumber(self:GetInfo("bw_ally_pl"..ply:EntIndex()))==1 then
		return true
	else
		return false
	end
end

function meta:NPCControl()
	for k,v in pairs(self.NPCs) do
		if IsValid(v) then
			if !v:HasCondition(COND_SEE_HATE) && !v:HasCondition(COND_SEE_ENEMY) then
				v:SetNPCState(1)
			end
			if (v:GetNPCState()!=3 || self.Entity:GetPos():Distance(v:GetPos())>1024) && self.Entity:GetPos():Distance(v:GetPos())>256 then
				local newpos = v:GetPos() + ((self.Entity:GetPos()-v:GetPos()):Normalize()*256)
				v:SetLastPosition(newpos)
				v:SetArrivalSpeed(1024)
				v:SetSchedule(SCHED_FORCED_GO_RUN)
				//v:SetNPCState(1)
			end
		end
	end
end

function meta:UpgradeGun( gun, bool)
	local weapon = self:GetWeapon(gun)
	if !IsValid(weapon) then return end
	weapon:Upgrade(bool)
end

function meta:CanAfford( amount ) 

	if( amount < 0 ) then return false; end

	if( self:GetTable().Money - amount < 0 ) then
		return false;
	end
	
	return true;

end

function meta:AddMoney( amount )

	local oldamount = self:GetTable().Money
	
	if (self:GetNWBool("AFK") && amount>0) then
		amount = -amount
		Notify(self,1,3,"You are AFK!, you just lost $" .. -amount .. "!")
	end
	self:GetTable().Money = oldamount + amount
	setMoney(self, amount);
	local plmoney = self:GetTable().Money

	umsg.Start("MoneyChange", self)
		umsg.String(tostring(amount))
		umsg.String(tostring(plmoney))
	umsg.End()
end

function meta:PayDay()
//	if IsValid(self) and self:GetTable().Pay == 1 then
	if !IsValid(self) then return end
	if( self:GetTable().Pay == 1 ) then

		local amount = 0;	

		amount = math.random( 400, 450 );
		
		if self:GetNWBool("AFK") then
			Notify(self,1,3,"You are AFK and won't recieve a Payday while AFK!")
			return
		end

//	ply:GetUserGroup()
//		if ( self:GetNWString("usergroup") == "founder" ) then
		if ( self:GetUserGroup() == "founder" ) then
			amount = amount + math.random(2000, 2500)
		end
	
//		if ( self:GetNWString("SubStatus", "Guest")== "Staff") then
//			amount = amount + math.random(500, 600)
//		end
/*
	if( self:GetNWString("Status", "Guest")== "VIP") then
		if ( self:GetNWString("SubStatus", "Guest")== "VIP" ) then
			amount = amount + math.random(550, 600)
		end
		if ( self:GetNWString("SubStatus", "Guest")== "VIP+" ) then
			amount = amount + math.random(650, 700)
		end	
		if ( self:GetNWString("SubStatus", "Guest")== "VIP++" ) then
			amount = amount + math.random(750, 800)
		end	
	end
*/	
		if ( self:GetUserGroup() == "donor01" ) then
			amount = amount + math.random(550, 600)
		end
		if ( self:GetUserGroup() == "donor02" ) then
			amount = amount + math.random(650, 700)
		end	
		if ( self:GetUserGroup() == "donor03" ) then
			amount = amount + math.random(750, 800)
		end			

//		if !self:CanAfford(10000) then
//			amount = amount + math.random(150, 200)
//		end	

		self:AddMoney( amount );
		Notify( self, 2, 4, "Payday! You got paid $" .. amount .. "!" );
		end
end

/*
function meta:UpdateJob( job )

	self:SetNWString( "job", job );

	if( string.lower( job ) != "mingebag") then
		
		self:GetTable().Pay = 1;
		self:GetTable().LastPayDay = CurTime();
		
		timer.Create( self:SteamID() .. "jobtimer", CfgVars["paydelay"], 0, self.PayDay, self );
		
	else
	
		timer.Destroy( self:SteamID() .. "jobtimer" );
	
	end

end
*/

function meta:CheckOverdose()
	local drugnum = 0
	if(!self:GetNWBool("superdrug")) then
		if (self:GetNWBool("regened")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("roided")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("amped")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("painkillered")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("mirrored")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("antidoted")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("focused")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("magicbulleted")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("shockwaved")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("leeched")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("doubletapped")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("doublejumped")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("adrenalined")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("knockbacked")==true) then
			drugnum = drugnum+1
		end
		if (self:GetNWBool("armorpiercered")==true) then
			drugnum = drugnum+1
		end
		if (drugnum>=5 && math.random(1,10)>2) then
			self:SetNWBool("shielded", false)
			self.Shielded = false
			self:TakeDamage(150,self)
			PoisonPlayer(self, 50, self, self)
			Notify(self, 1, 3, "You have overdosed!")
		elseif (drugnum==4 && math.random(1,10)>4) then
			self:SetNWBool("shielded", false)
			self.Shielded = false
			self:TakeDamage(90,self)
			PoisonPlayer(self, 40, self, self)
			Notify(self, 1, 3, "You have overdosed!")
		elseif drugnum==3 && math.random(1,10)>5 then
			PoisonPlayer(self, 40, self, self)
			self:TakeDamage(60, self)
			Notify(self, 1, 3, "You are overdosing!")
		elseif drugnum==2 && math.random(1,10)>9 then
			PoisonPlayer(self, 30, self, self)
			self:TakeDamage(30, self)
			Notify(self, 1, 3, "You are overdosing!")
		end
	end
end


function meta:UnownAllShit()

	for k, v in pairs( self:GetTable().Owned ) do
		
		v:UnOwn( self );
		self:GetTable().Owned[v:EntIndex()] = nil;
		
	end
	
	for k, v in pairs( player.GetAll() ) do
	
		for n, m in pairs( v:GetTable().Owned ) do
		
			if( m:AllowedToOwn( self ) ) then
				m:RemoveAllowed( self );
			end
		
		end
	
	end
	
	self:GetTable().OwnedNum = 0;

end

function GM:DoPlayerDeath( ply, attacker, dmginfo )

	ply:CreateRagdoll()
	
	ply:AddDeaths( 1 )
	
	ply:SetWalkSpeed(250)
	ply:SetRunSpeed(350)
	
	if ( attacker:IsValid() && attacker:IsPlayer() ) then
		//attacker:PrintMessage(HUD_PRINTTALK,"DoPlayerDeath..")
		self:RaidSystemCheckDeath(attacker,ply)
		if ( attacker == ply ) then
			attacker:AddFrags( -1 )
		else
			attacker:AddFrags( 1 )
		end
		
	end
	
end

function UpdateDrugs(ply)
	ply:GetTable().Roided = false
	ply:GetTable().Regened = false
	ply:GetTable().Shielded = false
	ply:GetTable().Tooled = false
	ply:GetTable().Focus = false
	ply:GetTable().Mirror = false
	ply:GetTable().Antidoted = false
	ply:GetTable().Poisoned = false
	ply:GetTable().Shielded = false
	ply:GetTable().Shieldon = false
	ply:GetTable().Stunned = false
	ply:GetTable().StunDuration = 0
	ply:GetTable().PoisonDuration = 0
	ply:GetTable().BurnDuration = 0
	ply:GetTable().Amp = false
	ply:GetTable().PainKillered = false
	ply:GetTable().MagicBulleted = false
	ply:GetTable().Adrenalined = false
	ply:GetTable().DoubleJumped = false
	ply:GetTable().ShockWaved = false
	ply:GetTable().DoubleTapped = false
	ply:GetTable().Leeched = false
	ply:GetTable().Knockbacked = false
	ply:GetTable().ArmorPiercered = false
	ply:GetTable().Superdrugoffense = false
	ply:GetTable().Superdrugdefense = false
	ply:GetTable().Superdrugweapmod = false
	ply:GetTable().Burned = false
	
	ply:SetNWBool("shielded", false)
	ply:SetNWBool("tooled", false)
	ply:SetNWBool("scannered", false)
	ply:SetNWBool("helmeted", false)
	ply:SetNWBool("roided", false)
	ply:SetNWBool("regened", false)
	ply:SetNWBool("amped", false)
	ply:SetNWBool("painkillered", false)
	ply:SetNWBool("magicbulleted", false)
	ply:SetNWBool("poisoned", false)
	ply:SetNWBool("focused", false)
	ply:SetNWBool("antidoted", false)
	ply:SetNWBool("mirrored", false)
	ply:SetNWBool("shockwaved", false)
	ply:SetNWBool("doubletapped", false)
	ply:SetNWBool("leeched", false)
	ply:SetNWBool("adrenalined", false)
	ply:SetNWBool("doublejumped", false)
	ply:SetNWBool("knockbacked", false)
	ply:SetNWBool("armorpiercered", false)
	ply:SetNWBool("burned", false)
	
	local IDSteam = string.gsub(ply:SteamID(), ":", "")
	timer.Destroy(IDSteam .. "ROID")
	timer.Destroy(IDSteam .. "REGEN")
	timer.Destroy(IDSteam .. "REGENTICK")
	timer.Destroy(IDSteam .. "AMP")
	timer.Destroy(IDSteam .. "PAINKILLER")
	timer.Destroy(IDSteam .. "MAGICBULLET")
	timer.Destroy(IDSteam .. "STUN")
	timer.Destroy(IDSteam .. "REFLECT")
	timer.Destroy(IDSteam .. "POISON")
	timer.Destroy(IDSteam .. "POISONTICK")
	timer.Destroy(IDSteam .. "BURN")
	timer.Destroy(IDSteam .. "ANTIDOTE")
	timer.Destroy(IDSteam .. "FOCUS")
	timer.Destroy(IDSteam .. "DOUBLETAP")
	timer.Destroy(IDSteam .. "LEECH")
	timer.Destroy(IDSteam .. "SHOCKWAVE")
	timer.Destroy(IDSteam .. "DOUBLEJUMP")
	timer.Destroy(IDSteam .. "ADRENALINE")
	timer.Destroy(IDSteam .. "KNOCKBACK")
	timer.Destroy(IDSteam .. "ARMORPIERCER")
	timer.Destroy(IDSteam .. "SUPERDRUGOFFENSE")
	timer.Destroy(IDSteam .. "SUPERDRUGDEFENSE")
	timer.Destroy(IDSteam .. "SUPERDRUGWEAPMOD")
end

function GM:PlayerDeath( ply, weapon, killer )

	if weapon:IsVehicle() and weapon:GetDriver():IsPlayer() then killer = weapon:GetDriver() end

	ply:Extinguish()	
	
	if ply:InVehicle() then ply:ExitVehicle() end	

	UpdateDrugs(ply)
	ply:ConCommand("pp_motionblur 0")
	ply:ConCommand("pp_dof 0")
	
	local IDSteam = string.gsub(ply:SteamID(), ":", "")
		local team = ply:Team()
		if (team == 19 ) then
			ply:RunConsoleCommand("stopsounds") 
				timer.Destroy("SonicTimer")
		end
	
	ply:GetTable().lasersight= 0
	ply:GetTable().acogscope= 0
	ply:GetTable().aimpoint= 0
	ply:GetTable().cmagazine= 0
	ply:GetTable().eotech557= 0
	ply:GetTable().m203= 0
	ply:GetTable().reflexsight= 0	
	ply:GetTable().verticalgrip= 0
	ply:GetTable().kobra= 0
	ply:GetTable().bipod= 0
	ply:GetTable().riflereflex= 0
	ply:GetTable().ballistic= 0		
	
	//self.BaseClass:PlayerDeath( ply, weapon, killer );
	self:PlayerDeathNotify(ply,weapon,killer)

	ply:GetTable().DeathPos = ply:GetPos();

	if( ply ~= killer or ply:GetTable().Slayed ) then
	
		ply:GetTable().DeathPos = nil;
		ply:GetTable().Slayed = false;

	end	
	
	for k, v in pairs(ply:GetWeapons()) do
		local class = v:GetClass()
		if (
		class!="lockpick" &&		
		class!="weapon_jihadbomb" && 
		class!="god_stick" &&
		class!="weapon_fas_m1" && 			
		class!="weapon_doorcharge" &&
		class!="weapon_mad_charge" && 			
		class!="weapon_mad_knife" && 
		class!="weapon_molotov" && 
		class!="weapon_gasgrenade" && 
		class!="weapon_real_cs_flash" && 
		class!="weapon_real_cs_grenade" && 
		class!="weapon_pipebomb" && 
		class!="weapon_physgun" && 
		class!="weapon_physcannon" && 
		class!="gmod_tool" && 
		class!="gmod_camera" && 
		class!="keys" && 
		class!="weapon_welder" && 
		class!="welder" && 
		class!="weapon_moneycannon" 
		) then

			local gun = ents.CreateEx("spawned_weapon")
			gun:SetModel(v:GetTable().WorldModel)
			gun:SetNWString("weaponclass", class)
			gun:SetPos(ply:GetPos()+Vector(math.random(-10,10),math.random(-10,10),math.random(10,40)))
			gun:SetUpgraded(v:GetNWBool("upgraded"))
			gun:Spawn()
			
			timer.Create( "Gun timer", 30, 1, function()
				if gun:IsValid() then
					gun:Remove()
				end
			end )

			
			v:Remove()
		end
	end

	
end


function GM:PlayerCanPickupWeapon( ply, wep )

	if wep:GetClass()=="weapon_worldslayer" && IsValid(ply:GetWeapon("weapon_worldslayer")) then return false end

	return true;

end

/*---------------------------------------------------------
   Name: gamemode:PlayerSetModel( )
   Desc: Set the player's model
---------------------------------------------------------*/

function GM:PlayerSetModel( ply )

	local cl_playermodel = ply:GetInfo("cl_playermodel")
    local modelname = player_manager.TranslatePlayerModel( cl_playermodel )
    ply:SetModel( modelname )
	
end

function GM:PlayerSpawn( ply )

	ply:Extinguish()
	if ply:GetActiveWeapon() and IsValid(ply:GetActiveWeapon()) then
		ply:GetActiveWeapon():Extinguish()
	end	

	UpdateDrugs(ply)

	ply:GetTable().Jump2 = false
	
	ply:ConCommand("pp_motionblur 0")
	ply:ConCommand("pp_dof 0")

	ply:SetWalkSpeed(250)
	ply:SetRunSpeed(350)	
	
	local IDSteam = string.gsub(ply:SteamID(), ":", "")
	
--	ply:GetTable().Headshot = false

	ply:UnSpectate()
	ply:StripWeapons()
	ply:RemoveAllAmmo()

	ply:SetCollisionGroup( 11 );		
	
	ply:CrosshairEnable();
	
	if( CfgVars["crosshair"] == 0 ) then
	
		ply:CrosshairDisable();
	
	end
	
	if( CfgVars["strictsuicide"] == 1 and ply:GetTable().DeathPos ) then
	
		ply:SetPos( ply:GetTable().DeathPos );
	
	end
	 
	
	if ( IsValid(ply:GetTable().Spawnpoint )  ) then 
    		local cspawnpos = ply:GetTable().Spawnpoint:GetPos()
		local trace = { }
    			trace.start = cspawnpos+Vector(0,0,2)
			trace.endpos = trace.start+Vector(0,0,16)
			trace.filter = ply:GetTable().Spawnpoint
		trace = util.TraceLine(trace)
		if IsValid(trace.Entity) then
			local minge = player.GetByUniqueID(trace.Entity:GetVar("PropProtection"))
			
					if (tobool(trace.Entity:GetVar("PropProtection"))) then
						trace.Entity:Remove()
					end
					ply:SetPos(cspawnpos+Vector(0,0,16))
			else
				ply:SetPos(cspawnpos+Vector(0,0,16))
		end

    end

	hook.Call( "PlayerSetModel", GAMEMODE, ply )	
--	GAMEMODE:PlayerSetModel(ply)

	hook.Call( "PlayerLoadout", GAMEMODE, ply )		
--	GAMEMODE:PlayerLoadout( ply )

	ply:AllowFlashlight(true)

	local col = ply:GetInfo( "cl_playercolor" )
	ply:SetPlayerColor( Vector( col ) )

	local col = ply:GetInfo( "cl_weaponcolor" )
	ply:SetWeaponColor( Vector( col ) )
	
end


function GM:PlayerLoadout( ply, tr )
	
	ply:Give( "keys" );
	ply:Give( "weapon_physcannon" );
	ply:Give( "gmod_tool" );
	ply:Give( "weapon_physgun" );
//	if ( ply:GetNWString("Status", "Guest")== "Founder") then
//		ply:Give("god_stick")
//	end
//	local team = ply:Team()
/*
// Donor02	
	if ply:SteamID() == "STEAM_0:0:37509240" then	//Velheart
		ply:Give( "cstm_pistol_dualdeagles" )
	end
	if ply:SteamID() == "STEAM_0:0:17116652" then	//Deadhammer
		ply:Give( "cstm_pistol_glock18" )
	end
	if ply:SteamID() == "STEAM_0:1:18310889" then	//Open Slot
		ply:Give( "cstm_pistol_glock18" )
	end
	if ply:SteamID() == "STEAM_0:0:39805120" then	//Error
		ply:Give( "cstm_pistol_dualdeagles" )
	end

//Donor03	
	if ply:SteamID() == "STEAM_0:1:7990197" then	//SweetWolf
		ply:Give( "cstm_pistol_627" )
	end
	if ply:SteamID() == "STEAM_0:0:17786223" then	//Memphis
		ply:Give( "cstm_pistol_glock18" )
	end
	if ply:SteamID() == "STEAM_0:1:29019011" then	//King Hitman
		ply:Give( "cstm_pistol_glock18" )
	end
	if ply:SteamID() == "STEAM_0:1:7788716" then	//Maliace
		ply:Give( "cstm_pistol_glock18" )
	end	
	if ply:SteamID() == "STEAM_0:1:17022775" then	//EvilHammer
		ply:Give( "cstm_smg_p90" )
	end
	if ply:SteamID() == "STEAM_0:1:35380751" then	//Bevbadass
		ply:Give( "cstm_pistol_dualmac10s" )
	end
*/
end


function GM:PlayerInitialSpawn( ply )
	ply:SetNWBool("OrginCam", true)
	self.BaseClass:PlayerInitialSpawn(ply)
	ply:NewData();

	ply.SID = ply:UniqueID()

	// Find items with their SID and update
	ply.maxmprinters = 0
	for k, v in pairs(ents.FindByClass("money_printer")) do
		if v.SID == ply.SID then
			v:SetNWEntity("owning_ent", ply)
			if ply.maxmprinters < 8 then
				ply.maxmprinters = ply.maxmprinters + 1
			end
		end
	end
--[[	
	// Find keypads with their SID and update
	for k, v in pairs(ents.FindByClass("sent_keypad")) do
		if v.SID == ply.SID then
			v:SetNetworkedEntity("keypad_owner", ply)
		end
	end
	for k, v in pairs(ents.FindByClass("sent_keypad_wire")) do
		if v.SID == ply.SID then
			v:SetNetworkedEntity("keypad_owner", ply)
		end
	end
]]--	
//	ply:SetNWBool("helpMenu",false)
	ply:GetTable().LastBuy=CurTime()	
	ply:GetTable().maxdrug= 0
	ply:GetTable().maxmoneyvault= 0
	ply:GetTable().maxMicrowaves=0
	ply:GetTable().maxsupplytable=0
	ply:GetTable().maxgunlabs=0
	ply:GetTable().maxdrugfactory=0
	ply:GetTable().maxdrugvaults=0
	ply:GetTable().maxgunvaults=0
	ply:GetTable().maxsolargenerator=0
	ply:GetTable().maxgenerator=0
	ply:GetTable().maxsupergenerator=0
	ply:GetTable().maxnucleargenerator=0
	ply:GetTable().maxgunfactory=0
	ply:GetTable().maxsupergunfactory= 0	
	ply:GetTable().maxweed=0
	ply:GetTable().maxturret=0
	ply:GetTable().maxfloorturret=0
	ply:GetTable().maxdispensers= 0
	ply:GetTable().maxhealthdispensers= 0
	ply:GetTable().maxarmordispensers= 0
	ply:GetTable().maxspawn= 0

	ply:GetTable().maxBronzePrinter= 0
	ply:GetTable().maxSilverPrinter= 0
	ply:GetTable().maxRheniumPrinter= 0
	ply:GetTable().maxIridiumPrinter= 0
	ply:GetTable().maxPalladiumPrinter= 0	
	ply:GetTable().maxGoldPrinter= 0
	ply:GetTable().maxPlatinumPrinter= 0
	ply:GetTable().maxRhodiumPrinter= 0
	ply:GetTable().maxMoneyFactory= 0
	ply:GetTable().maxGoldenSilo= 0
	ply:GetTable().maxNuclearFactory= 0
	ply:GetTable().maxNovaPrinter= 0

	ply:GetTable().maxTunedSilver= 0
	ply:GetTable().maxTunedIridium= 0
	ply:GetTable().maxTunedGold= 0
	ply:GetTable().maxTunedRhodium= 0
	ply:GetTable().maxTunedGolden= 0
	ply:GetTable().maxQuantumFactory= 0	

	ply:GetTable().lasersight= 0
	ply:GetTable().acogscope= 0
	ply:GetTable().aimpoint= 0
	ply:GetTable().cmagazine= 0
	ply:GetTable().eotech557= 0
	ply:GetTable().m203= 0
	ply:GetTable().reflexsight= 0	
	ply:GetTable().verticalgrip= 0
	ply:GetTable().kobra= 0
	ply:GetTable().bipod= 0
	ply:GetTable().riflereflex= 0
	ply:GetTable().ballistic= 0		

	ply:GetTable().maxdruglabs= 0		
	ply:GetTable().maxmethlab= 0
	ply:GetTable().maxstablemethlab= 0
	ply:GetTable().maxstill= 0
	ply:GetTable().maxBigBombs= 0
	ply:GetTable().maxtower = 0
	ply:GetTable().maxlamp = 0
	ply:GetTable().maxlocker = 0
	ply:GetTable().maxC4s= 0
	ply:GetTable().maxShipments = 0		
	ply:GetTable().shitweldcount = 0
	ply:GetTable().shitweldentries = { }
	ply:GetTable().scanlogs = { }
	--SetNetBool(ply,"FactionLeader",false)
	--SetNetBool(ply,"shitwelding",false)
	--SetNetBool(ply,"AFK",false)
	ply:SetNWBool("FactionLeader", false)
	ply:SetNWBool("shitwelding", false)
	ply:SetNWBool("AFK", false)
	getMoney(ply);
	ply:GetTable().StunDuration = 0
--	ply:GetTable().tickets = { }
	ply:PrintMessage( HUD_PRINTTALK, "Welcome to Last Resistance Gaming's Basewars Server!" ) 
	ply:PrintMessage( HUD_PRINTTALK, "Build Bases, Earn Money, Raid Enemies & Have Fun!" )
	ply:PrintMessage( HUD_PRINTTALK, "Need Help? Ask Other Players or Press F1." )
	ply:PrintMessage( HUD_PRINTTALK, "Please Read the Rules before Playing!" )	
	ply:PrintMessage( HUD_PRINTTALK, "Your donator status is " ..ply:GetNWString("Status").. ", " ..ply:GetNWString("SubStatus").. "!" )
--	ply:PrintMessage(HUD_PRINTTALK,"Please read the rules! Do not follow any rules that are not from Jr. Admins+ or from the MOTD!")
--	ply:PrintMessage(HUD_PRINTTALK,"Remember! If you are breaking rules, you will face a kick or ban!")

	umsg.Start( "bw_advert", v )
		local randind = math.random(1, #GAMEMODE.Adverts)
		umsg.Short( (GAMEMODE.Adverts[randind] and GAMEMODE.Adverts[randind].color) or 1 )
		local str = (GAMEMODE.Adverts[randind] and GAMEMODE.Adverts[randind].text) or ""
		for k, v in pairs(GAMEMODE.KeyReplacements) do str = string.gsub( str, k, tostring( GAMEMODE.KeyReplacements[k]() ) ) end
		umsg.String( str )
	umsg.End()
end

function GM:PlayerAuthed(ply)

	self.BaseClass:PlayerAuthed( ply );

end

function GM:PlayerDisconnected( ply )

	self.BaseClass:PlayerDisconnected( ply );
	
	ply:UnownAllShit();
	
	timer.Destroy( ply:SteamID() .. "jobtimer" );
	
	local IDSteam = string.gsub(ply:SteamID(), ":", "")
	timer.Destroy(IDSteam .. "ROID")
	timer.Destroy(IDSteam .. "REGEN")
	timer.Destroy(IDSteam .. "REGENTICK")
	timer.Destroy(IDSteam .. "AMP")
	timer.Destroy(IDSteam .. "PAINKILLER")
	timer.Destroy(IDSteam .. "MAGICBULLET")
	timer.Destroy(IDSteam .. "STUN")
	timer.Destroy(IDSteam .. "MIRROR")
	timer.Destroy(IDSteam .. "BURN")
	timer.Destroy(IDSteam .. "POISON")
	timer.Destroy(IDSteam .. "POISONTICK")
	timer.Destroy(IDSteam .. "ANTIDOTE")
	timer.Destroy(IDSteam .. "FOCUS")
	timer.Destroy(IDSteam .. "DOUBLETAP")
	timer.Destroy(IDSteam .. "LEECH")
	timer.Destroy(IDSteam .. "SHOCKWAVE")
	timer.Destroy(IDSteam .. "AFK")
	timer.Destroy(IDSteam .. "ADRENALINE")
	timer.Destroy(IDSteam .. "DOUBLEJUMP")
	timer.Destroy(IDSteam .. "KNOCKBACK")
	timer.Destroy(IDSteam .. "ARMORPIERCER")
	timer.Destroy(IDSteam .. "SUPERDRUGOFFENSE")
	timer.Destroy(IDSteam .. "SUPERDRUGDEFENSE")
	timer.Destroy(IDSteam .. "SUPERDRUGWEAPMOD")
	for k, v in pairs(player.GetAll()) do
		if IsValid(v) then
			v:ConCommand("bw_ally_pl"..ply:EntIndex().." 0\n")
		end
	end
end

function GM:ScalePlayerDamage( ply, hitgroup, dmginfo )
	ply:GetTable().Headshot = false
	if (ply:Team()==1) then
		dmginfo:ScaleDamage( 0.9 )
	end
	if ( hitgroup == HITGROUP_HEAD ) then
	
		ply:GetTable().Headshot = true
	 	if ply:GetNWBool("helmeted") then
			if (ply:Team()==1) then
				dmginfo:ScaleDamage( 0.18 )
			else
				dmginfo:ScaleDamage( 0.2 )
			end
			local effectdata = EffectData()
				effectdata:SetOrigin( ply:GetPos()+Vector(0,0,60) )
				effectdata:SetMagnitude( 1 )
				effectdata:SetScale( 1 )
				effectdata:SetRadius( 2 )
			util.Effect( "Sparks", effectdata )
		else
			if (ply:Team()==1) then
				dmginfo:ScaleDamage( 1.5 )
			else
				dmginfo:ScaleDamage( 1.75 )
			end
	 	end
	 end
	 
	// Less damage if we're shot in the arms or legs, or if its a citizen
	if ( hitgroup == HITGROUP_LEFTARM ||
		 hitgroup == HITGROUP_RIGHTARM || 
		 hitgroup == HITGROUP_LEFTLEG ||
		 hitgroup == HITGROUP_LEFTLEG ||
		 hitgroup == HITGROUP_GEAR ) then
	 
		if (ply:Team()==1) then
			dmginfo:ScaleDamage( 0.45 )
		else
			dmginfo:ScaleDamage( 0.5 )
		end
	 
	 end

end

/*
PrecacheParticleSystem("bday_confetti")
function Confettis( ply, hitgroup, dmginfo )
    if hitgroup == HITGROUP_HEAD and ply:Health() - dmginfo:GetDamage() <= 0 then 
        local HeadIndex = ply:LookupBone( "ValveBiped.Bip01_Head1" )  
        local HeadPos, HeadAng = ply:GetBonePosition( HeadIndex )
        ParticleEffect("bday_confetti",HeadPos,HeadAng,nil)
        ply:EmitSound("misc/happy_birthday.wav")
    end 
end
hook.Add("ScalePlayerDamage","Confettis",Confettis)
*/

function meta:SetAFK()
	self:SetNWBool("AFK", true)
	Notify(self,1,3,"You are now AFK!")	
end

function meta:ClearAFK()
	if (self:GetNWBool("AFK")) then
		self:SetNWBool("AFK", false)
		Notify(self, 2, 3, "You are no longer AFK!");
	end
	timer.Create( self:SteamID() .. "AFK", CfgVars["afktime"], 1, function() self:SetAFK() end);
end
// copypasta from base gamemode

function GM:PlayerDeathNotify( Victim, Inflictor, Attacker )
	if (Inflictor:GetClass()=="env_physexplosion" || Inflictor:GetClass()=="env_fire") && IsValid(Inflictor:GetTable().attacker) then
		Attacker = Inflictor:GetTable().attacker
	end
	// Don't spawn for at least 3 seconds
	if Inflictor==Victim && Attacker==Victim then
		Victim.NextSpawnTime = CurTime() + 5
	else
		Victim.NextSpawnTime = CurTime() + 3
	end

	// Convert the inflictor to the weapon that they're holding if we can.
	// This can be right or wrong with NPCs since combine can be holding a 
	// pistol but kill you by hitting you with their arm.
	// fuck all of this.
	
	if ( Inflictor && Inflictor == Attacker && ( Inflictor:IsNPC() || Inflictor:IsPlayer()) ) then
		local weap = Inflictor:GetActiveWeapon()
		if IsValid(weap) then
			local class=weap:GetClass()
			if class=="weapon_stunstick" || class=="weapon_crowbar" || class=="weapon_pistol" || class=="weapon_357" || class=="weapon_smg1" || class=="weapon_ar2" || class=="weapon_shotgun" then
				
				Inflictor = Inflictor:GetActiveWeapon()
				if ( !Inflictor || Inflictor == NULL ) then Inflictor = Attacker end
			end
		end
	
	end
	
	// send the inflictor class independently in case the inflictor is not in client PVS
	if (Attacker == Victim) then
		if !IsValid(Inflictor) then Inflictor = Victim end
		umsg.Start( "PlayerKilledSelf" )
			umsg.Entity( Victim )
			umsg.Entity( Inflictor )
			umsg.String( Inflictor:GetClass() )
			umsg.Bool(Victim:GetTable().Headshot)
		umsg.End()
		
		MsgAll( Attacker:Nick() .. " suicided using " .. Inflictor:GetClass() .. "!\n" )
		
	return end

	if ( Attacker:IsPlayer() ) then
	
		umsg.Start( "PlayerKilledByPlayer" )
		
			umsg.Entity( Victim )
			umsg.Entity( Inflictor )
			umsg.Entity( Attacker )
			umsg.String( Inflictor:GetClass() )
			umsg.Bool(Victim:GetTable().Headshot)
		
		umsg.End()
		
		MsgAll( Attacker:Nick() .. " killed " .. Victim:Nick() .. " using " .. Inflictor:GetClass() .. "\n" )
		
	return end
	
	umsg.Start( "PlayerKilled" )
	
		umsg.Entity( Victim )
		umsg.Entity( Inflictor )
		umsg.String( Attacker:GetClass() )
		umsg.String( Inflictor:GetClass() )
		umsg.Bool(Victim:GetTable().Headshot)

	umsg.End()
	
	MsgAll( Victim:Nick() .. " was killed by " .. Attacker:GetClass() .. "\n" )
	
end


local function LimitReachedProcess( ply, str )

	// Always allow in single player
	if (game.SinglePlayer()) then return true end

	local c = server_settings.Int( "sbox_max"..str, 0 )
	
	if ( ply:GetCount( str ) < c || c < 0 ) then return true end 
	
	ply:LimitHit( str ) 
	return false

end

function GM:SetupPlayerVisibility(ply)
	for k,v in pairs(ents.FindByClass("bigbomb")) do
		if v:GetNWBool("armed") then
			AddOriginToPVS(v:GetPos())
		end
	end
end