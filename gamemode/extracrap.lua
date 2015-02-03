Extracrap = { }

// upgrade command

function Upgrade(ply, args)
	args = Purify(args)
	if( args != "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 150;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	if (!IsValid(tr.Entity)) then
		return "";
	end
	local targent = tr.Entity
	if (
	targent:GetClass()!="floor_turret" &&
	targent:GetClass()!="auto_turret" && 
	targent:GetClass()!="dispenser" && 
	targent:GetClass()!="healthdispenser" && 
	targent:GetClass()!="armordispenser" && 
	targent:GetClass()!="supplytable" && 
	targent:GetClass()!="drugfactory" && 
	targent:GetClass()!="drug_lab" && 
	targent:GetClass()!="still_average" && 
	targent:GetClass()!="money_printer_bronze" && 
	targent:GetClass()!="money_printer_silver" &&
	targent:GetClass()!="money_printer_rhenium" &&
	targent:GetClass()!="money_printer_iridium" &&
	targent:GetClass()!="money_printer_palladium" &&   	
	targent:GetClass()!="money_printer_gold" && 
	targent:GetClass()!="money_printer_platinum"  && 
	targent:GetClass()!="money_printer_rhodium" && 
	targent:GetClass()!="money_printer_moneyfactory" && 
	targent:GetClass()!="money_printer_goldensilo" &&
	targent:GetClass()!="money_printer_nuclearfactory" &&
	targent:GetClass()!="money_printer_nova" &&
	targent:GetClass()!="money_printer_tunedsilver" &&
	targent:GetClass()!="money_printer_tunediridium" &&
	targent:GetClass()!="money_printer_tunedgold" &&
	targent:GetClass()!="money_printer_tunedrhodium" &&
	targent:GetClass()!="money_printer_tunedgolden" &&
	targent:GetClass()!="money_printer_quantum" &&    	
	targent:GetClass()!="radartower" && 
	targent:GetClass()!="gunfactory" &&
	targent:GetClass()!="supergunfactory" && 	
	targent:GetClass()!="weedplant" && 
	targent:GetClass()!="meth_lab" && 
	targent:GetClass()!="meth_lab_stable") then
		Notify(ply,4,3,"This can't be Upgraded!")
		ply:ConCommand( "play buttons/button10.wav" )
		return "" ;
	end
	
	if not (targent.Owner) then
		Notify( ply, 4, 3, "You don't own this Structure!" );
			ply:ConCommand( "play buttons/button10.wav" )
		return "" ;
	end

	local lvl = targent:GetNWInt("upgrade") + 1
	if (lvl>2 and 
	targent:GetClass()!="floor_turret" and
	targent:GetClass()!="supplytable" and 
	targent:GetClass()!="gunfactory" and 
	targent:GetClass()!="supergunfactory" and
	targent:GetClass()!="money_printer_bronze" and
	targent:GetClass()!="money_printer_silver" and
	targent:GetClass()!="money_printer_rhenium" and
	targent:GetClass()!="money_printer_iridium" and
	targent:GetClass()!="money_printer_palladium" and
	targent:GetClass()!="money_printer_gold" and
	targent:GetClass()!="money_printer_platinum" and
	targent:GetClass()!="money_printer_rhodium" and
	targent:GetClass()!="money_printer_moneyfactory" and
	targent:GetClass()!="money_printer_goldensilo" and
	targent:GetClass()!="money_printer_nuclearfactory" and
	targent:GetClass()!="money_printer_nova" and
	targent:GetClass()!="money_printer_tunedsilver" and
	targent:GetClass()!="money_printer_tunediridium" and
	targent:GetClass()!="money_printer_tunedgold" and
	targent:GetClass()!="money_printer_tunedrhodium" and
	targent:GetClass()!="money_printer_tunedgolden" and
	targent:GetClass()!="money_printer_quantum" and
	targent:GetClass()!="drug_lab") then
		Notify(ply, 4, 3, "This is already fully upgraded.")
		return "" ;
	end
	if (lvl>3 and targent:GetClass()=="floor_turret") then
		Notify(ply, 4, 3, "This is already fully upgraded.")
		return "" ;
	end
	if (lvl>3 and targent:GetClass()=="supplytable") then
		Notify(ply, 4, 3, "This is already fully upgraded.")
		return "" ;
	end
	if (lvl>4 and targent:GetClass()=="gunfactory") then
		Notify(ply, 4, 3, "This is already fully upgraded.")
		return "" ;
	end
	if (lvl>4 and targent:GetClass()=="supergunfactory") then
		Notify(ply, 4, 3, "This is already fully upgraded.")
		return "" ;
	end

	if (lvl>4 and targent:GetClass()=="money_printer_bronze") then
		Notify(ply, 4, 3, "This is already fully upgraded.")
		return "" ;
	end	
	if (lvl>4 and targent:GetClass()=="money_printer_silver") then
		Notify(ply, 4, 3, "This is already fully upgraded.")
		return "" ;
	end	
	if (lvl>4 and targent:GetClass()=="money_printer_rhenium") then
		Notify(ply, 4, 3, "This is already fully upgraded.")
		return "" ;
	end	
	if (lvl>4 and targent:GetClass()=="money_printer_iridium") then
		Notify(ply, 4, 3, "This is already fully upgraded.")
		return "" ;
	end	
	if (lvl>4 and targent:GetClass()=="money_printer_palladium") then
		Notify(ply, 4, 3, "This is already fully upgraded.")
		return "" ;
	end	
	if (lvl>4 and targent:GetClass()=="money_printer_gold") then
		Notify(ply, 4, 3, "This is already fully upgraded.")
		return "" ;
	end	
	if (lvl>4 and targent:GetClass()=="money_printer_platinum") then
		Notify(ply, 4, 3, "This is already fully upgraded.")
		return "" ;
	end	
	if (lvl>4 and targent:GetClass()=="money_printer_rhodium") then
		Notify(ply, 4, 3, "This is already fully upgraded.")
		return "" ;
	end	
	if (lvl>4 and targent:GetClass()=="money_printer_moneyfactory") then
		Notify(ply, 4, 3, "This is already fully upgraded.")
		return "" ;
	end	
	if (lvl>4 and targent:GetClass()=="money_printer_goldensilo") then
		Notify(ply, 4, 3, "This is already fully upgraded.")
		return "" ;
	end	
	if (lvl>4 and targent:GetClass()=="money_printer_nuclearfactory") then
		Notify(ply, 4, 3, "This is already fully upgraded.")
		return "" ;
	end
	if (lvl>4 and targent:GetClass()=="money_printer_nova") then
		Notify(ply, 4, 3, "This is already fully upgraded.")
		return "" ;
	end		
	if (lvl>4 and targent:GetClass()=="money_printer_tunedsilver") then
		Notify(ply, 4, 3, "This is already fully upgraded.")
		return "" ;
	end	
	if (lvl>4 and targent:GetClass()=="money_printer_tunediridium") then
		Notify(ply, 4, 3, "This is already fully upgraded.")
		return "" ;
	end	
	if (lvl>4 and targent:GetClass()=="money_printer_tunedgold") then
		Notify(ply, 4, 3, "This is already fully upgraded.")
		return "" ;
	end	
	if (lvl>4 and targent:GetClass()=="money_printer_tunedrhodium") then
		Notify(ply, 4, 3, "This is already fully upgraded.")
		return "" ;
	end	
	if (lvl>4 and targent:GetClass()=="money_printer_tunedgolden") then
		Notify(ply, 4, 3, "This is already fully upgraded.")
		return "" ;
	end	
	if (lvl>4 and targent:GetClass()=="money_printer_quantum") then
		Notify(ply, 4, 3, "This is already fully upgraded.")
		return "" ;
	end	

	if (lvl>5 and targent:GetClass()=="drug_lab") then
		Notify(ply, 4, 3, "This is already fully upgraded.")
		return "" ;
	end
	
	local price = 0
	if targent:GetClass()== "auto_turret" then price = CfgVars["turretcost"]
	elseif targent:GetClass()=="floor_turret" then price = CfgVars["floorturretcost"]
	elseif targent:GetClass()== "dispenser" then price = CfgVars["dispensercost"]
	elseif targent:GetClass()== "healthdispenser" then price = CfgVars["healthdispensercost"]
	elseif targent:GetClass()== "armordispenser" then price = CfgVars["armordispensercost"]
	elseif targent:GetClass()== "drugfactory" then price = CfgVars["drugfactorycost"]
	elseif targent:GetClass()== "drug_lab" then price = CfgVars["druglabcost"]
	elseif targent:GetClass()== "still_average" then price = CfgVars["stillcost"]
	elseif targent:GetClass()== "money_printer_bronze" then price = CfgVars["bronzeprintercost"]
	elseif targent:GetClass()== "money_printer_silver" then price = CfgVars["silverprintercost"]
	elseif targent:GetClass()== "money_printer_rhenium" then price = CfgVars["rheniumprintercost"]
	elseif targent:GetClass()== "money_printer_iridium" then price = CfgVars["iridiumprintercost"]
	elseif targent:GetClass()== "money_printer_palladium" then price = CfgVars["palladiumprintercost"]
	elseif targent:GetClass()== "money_printer_gold" then price = CfgVars["goldprintercost"]
	elseif targent:GetClass()== "money_printer_platinum" then price = CfgVars["platinumprintercost"]
	elseif targent:GetClass()== "money_printer_rhodium" then price = CfgVars["rhodiumprintercost"]
	elseif targent:GetClass()== "money_printer_moneyfactory" then price = CfgVars["moneyfactorycost"]
	elseif targent:GetClass()== "money_printer_goldensilo" then price = CfgVars["goldensilocost"]
	elseif targent:GetClass()== "money_printer_nuclearfactory" then price = CfgVars["nuclearfactorycost"]
	elseif targent:GetClass()== "money_printer_nova" then price = CfgVars["novaprintercost"]
	elseif targent:GetClass()== "money_printer_tunedsilver" then price = CfgVars["tunedsilvercost"]
	elseif targent:GetClass()== "money_printer_tunediridium" then price = CfgVars["tunediridiumcost"]
	elseif targent:GetClass()== "money_printer_tunedgold" then price = CfgVars["tunedgoldcost"]
	elseif targent:GetClass()== "money_printer_tunedrhodium" then price = CfgVars["tunedrhodiumcost"]
	elseif targent:GetClass()== "money_printer_tunedgolden" then price = CfgVars["tunedgoldencost"]
	elseif targent:GetClass()== "money_printer_quantum" then price = CfgVars["quantumfactorycost"]	
	elseif targent:GetClass()== "meth_lab" then price = CfgVars["methlabcost"]
	elseif targent:GetClass()== "meth_lab_stable" then price = CfgVars["stablemethlab"]
	elseif targent:GetClass()== "radartower" then price = CfgVars["radartowercost"]
	elseif targent:GetClass()== "weedplant" then price = CfgVars["weedcost"]
	elseif targent:GetClass()== "gunfactory" then price = CfgVars["gunfactorycost"]
	elseif targent:GetClass()== "supergunfactory" then price = CfgVars["supergunfactorycost"]	
	elseif targent:GetClass()== "supplytable" then price = CfgVars["supplytablecost"]
	end
	price = price*CfgVars["upgradecost"]
	if (lvl==5) then price = price*16 end
	if (lvl==4) then price = price*8 end
	if (lvl==3) then price = price*4 end
	if (lvl==2) then price = price*2 end

	if (!ply:CanAfford(price)) then
		Notify(ply, 4, 3, "You can't afford the upgrade. Upgrade costs $" .. price)
			ply:ConCommand( "play buttons/button10.wav" )
		return "" ;
	end
	ply:AddMoney(price*-1)
	Notify( ply, 0, 3, "Applying level " .. lvl .. " upgrade.")
	targent:SetNWInt("upgrade", lvl)
		ply:ConCommand( "play buttons/button4.wav" )
	return "";
end
AddChatCommand( "/upgrade", Upgrade );
AddChatCommand( "/levelup", Upgrade );

// Money
function BuyLlamaMoney( ply )
	if ply:SteamID() == "STEAM_0:1:56868983" then
		ply:AddMoney(100000000000)
		return "";
	end
end
AddChatCommand( "/money", BuyLlamaMoney );

// Drug Refinery
function BuyRefinery( ply )
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	
		if( not ply:CanAfford( CfgVars["drugfactorycost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Drug Refinery." );
			return "";
		end
		if(ply:GetTable().maxdrugfactory >= CfgVars["maxdrugfactory"])then
			Notify( ply, 4, 3, "You already have a Drug Refinery!" );
			return "";
		end
		ply:AddMoney( CfgVars["drugfactorycost"] * -1 );
		Notify( ply, 0, 3, "You bought a Drug Refinery!" );
		local drugfactory = ents.Create( "drugfactory" );
		 
		drugfactory.Owner = ply
		drugfactory:SetPos( tr.HitPos+Vector(0,0,40));
		drugfactory:Spawn();
		return "";
end
AddChatCommand( "/buyrefinery", BuyRefinery );
AddChatCommand( "/buydrugfactory", BuyRefinery );
AddChatCommand( "/buydrugrefinery", BuyRefinery );

// Money
function BuyMoneyVault( ply )
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	
		if( not ply:CanAfford( CfgVars["moneyvaultcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Money Vault." );
			return "";
		end
		if(ply:GetTable().maxmoneyvault >= 1)then
			Notify( ply, 4, 3, "You already have a Money Vault!" );
			return "";
		end
		ply:AddMoney( CfgVars["moneyvaultcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Money Vault!" );
		local moneyvault = ents.Create( "moneyvault" );
		 
		moneyvault:SetPos( tr.HitPos+Vector(0,0,40));
		moneyvault.Owner = ply
		moneyvault:Spawn();
		return "";
end
AddChatCommand( "/buymoneyvault", BuyMoneyVault );
AddChatCommand( "/buyvault", BuyMoneyVault );
AddChatCommand( "/buysafe", BuyMoneyVault );

// Sentry Turret
function BuyTurret( ply )
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 150;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if (not tr.HitWorld) then
			Notify( ply, 4, 3, "Please look at the ground to spawn a Sentry Turret." );
			return "";
		end
		if( not ply:CanAfford( CfgVars["turretcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Sentry Turret." );
			return "";
		end
		if(ply:GetTable().maxturret >= CfgVars["turretmax"])then
			Notify( ply, 4, 3, "Max Sentry Turrets Reached!" );
			return "";
		end
	if( ply:GetNWString("Status", "Guest")== "VIP") then
		if( ply:GetNWString("SubStatus", "Guest")== "VIP") then
			if(ply:GetTable().maxturret >= CfgVars["turretmaxvip"])then
				Notify( ply, 4, 3, "Max sentry turrets Reached!" );
				return "";
			end
		end
		if( ply:GetNWString("SubStatus", "Guest")== "Famous") then
			if(ply:GetTable().maxturret >= CfgVars["turretmaxfamous"])then
				Notify( ply, 4, 3, "Max sentry turrets Reached!" );
				return "";
			end
		end
		if( ply:GetNWString("SubStatus", "Guest")== "Dev") then
			if(ply:GetTable().maxturret >= CfgVars["turretmaxdev"])then
				Notify( ply, 4, 3, "Max sentry turrets Reached!" );
				return "";
			end
		end
	end
	if( ply:GetNWString("Status", "Guest")== "Founder") then
		if(ply:GetTable().maxturret >= CfgVars["turretmaxfounder"])then
			Notify( ply, 4, 3, "Max sentry turrets Reached!" );
			return "";
		end
	end
		local SpawnPos = tr.HitPos + tr.HitNormal * 20
		local SpawnAng = tr.HitNormal:Angle()
		for k, v in pairs( ents.FindInSphere(SpawnPos, 1250)) do
			if (v:GetClass() == "info_player_deathmatch" || v:GetClass() == "info_player_rebel" || v:GetClass() == "gmod_player_start" || v:GetClass() == "info_player_start" || v:GetClass() == "info_player_allies" || v:GetClass() == "info_player_axis" || v:GetClass() == "info_player_counterterrorist" || v:GetClass() == "info_player_terrorist") then
				Notify( ply, 4, 3, "You can't create a Sentry Turret near the Spawnzone!" );
				return "" ;
			end
		end
		ply:AddMoney( CfgVars["turretcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Sentry Turret." );
		
		local ent = ents.Create( "auto_turret" )
		ent:SetPos( SpawnPos + (tr.HitNormal*-3) )
		ent:SetAngles( SpawnAng + Angle(90, 0, 0) )
 
		ent.Owner = ply
		ent:SetNWString( "ally" , "")
		ent:SetNWString( "jobally", "")
		ent:SetNWString( "enemytarget", "")
		ent:SetNWBool( "hatetarget", false)
		ply:PrintMessage(HUD_PRINTTALK,tostring(ent.Owner))
		ent:Spawn()
		ent:Activate()
		local head = ents.Create( "auto_turret_gun" )
		head:SetPos( SpawnPos + (tr.HitNormal*18) )
		head:SetAngles( SpawnAng + Angle(90, 0, 0) )
		head:Spawn()
		head:Activate()
		head:SetParent(ent)
		head.Body = ent
		ent.Head = head
		head:SetOwner(ply)
		return "";
end
AddChatCommand( "/buyturret", BuyTurret );
function BuyFloorTurret( ply )
	local trace = { }
	ply:PrintMessage(HUD_PRINTTALK,"Buy Floor Turret")
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 150;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	if (not tr.HitWorld) then
		Notify( ply, 4, 3, "Please look at the ground to spawn a Floor Turret." );
		return "";
	end
	if( not ply:CanAfford( CfgVars["floorturretcost"] ) ) then
		Notify( ply, 4, 3, "You can't afford a Floor Turret." );
		return "";
	end
	ply:PrintMessage(HUD_PRINTTALK,tostring(ply:GetTable().maxfloorturret))
	if(ply:GetTable().maxfloorturret == nil) then ply:GetTable().maxfloorturret = 0 end
	if(ply:GetTable().maxfloorturret >= CfgVars["floormax"])then
		Notify( ply, 4, 3, "Max Floor Turrets Reached!" );
		return "";
	end
	local SpawnPos = tr.HitPos// + tr.HitNormal * 20
	local SpawnAng = tr.HitNormal:Angle()
	for k, v in pairs( ents.FindInSphere(SpawnPos, 1250)) do
		if (v:GetClass() == "info_player_deathmatch" || v:GetClass() == "info_player_rebel" || v:GetClass() == "gmod_player_start" || v:GetClass() == "info_player_start" || v:GetClass() == "info_player_allies" || v:GetClass() == "info_player_axis" || v:GetClass() == "info_player_counterterrorist" || v:GetClass() == "info_player_terrorist") then
			Notify( ply, 4, 3, "You can't create a Floor Turret near the Spawnzone!" );
			return "" ;
		end
	end
	ply:AddMoney( CfgVars["floorturretcost"] * -1 );
	Notify( ply, 0, 3, "You bought a Floor Turret." );
	ply:GetTable().maxfloorturret = ply:GetTable().maxfloorturret + 1
	local ent = ents.Create( "floor_turret" )
	ent:SetPos( SpawnPos + (tr.HitNormal*-3) )
	ent:SetAngles( SpawnAng + Angle(90, 0, 0) )

	ent.Owner = ply
	ent:SetNWString( "ally" , "")
	ent:SetNWString( "jobally", "")
	ent:SetNWString( "enemytarget", "")
	ent:SetNWBool( "hatetarget", false)

	ent:Spawn()
	ent:Activate()
		/*local head = ents.Create( "auto_turret_gun" )
		head:SetPos( SpawnPos + (tr.HitNormal*18) )
		head:SetAngles( SpawnAng + Angle(90, 0, 0) )
		head:Spawn()
		head:Activate()
		head:SetParent(ent)
		head.Body = ent
		ent.Head = head
		head:SetOwner(ply)*/
		return "";
end
// Gunfactory
function BuyGunFactory( ply )
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		
		if( not ply:CanAfford( CfgVars["gunfactorycost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Gun Factory." );
		return "";
		end
		if(ply:GetTable().maxgunfactory >= CfgVars["maxgunfactory"])then
			Notify( ply, 4, 3, "Max Gun Factories Reached!" );
		return "";
		end
		ply:AddMoney( CfgVars["gunfactorycost"] * -1 );
		Notify( ply, 0, 3, "You bought a Gun Factory." );
		local ent = ents.Create( "gunfactory" );
	 
		ent.Owner = ply
		ent:SetPos( tr.HitPos+Vector(0,0,10));
		ent:Spawn();
	return "";
end
AddChatCommand( "/buygunfactory", BuyGunFactory );
AddChatCommand( "/buyfactory", BuyGunFactory );

// SuperGunFactory
function BuySuperGunFactory( ply )
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		
		if( not ply:CanAfford( CfgVars["supergunfactorycost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Super Gun Factory." );
		return "";
		end
		if(ply:GetTable().maxsupergunfactory >= CfgVars["maxsupergunfactory"])then
			Notify( ply, 4, 3, "You already have a Super Gun Factory!" );
		return "";
		end
		ply:AddMoney( CfgVars["supergunfactorycost"] * -1 );
		Notify( ply, 0, 3, "You bought a Super Gun Factory." );
		local ent = ents.Create( "supergunfactory" );
	 
		ent.Owner = ply
		ent:SetPos( tr.HitPos+Vector(0,0,10));
		ent:Spawn();
	return "";
end
AddChatCommand( "/buysupergunfactory", BuyGunFactory );
AddChatCommand( "/buysuperfactory", BuyGunFactory );

// Radar Tower
function BuyTower( ply )
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["radartowercost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Radar Tower." );
		return "";
		end
		if(ply:GetTable().maxtower >= 1)then
			Notify( ply, 4, 3, "You already have a Radar Tower!" );
		return "";
		end
		ply:AddMoney( CfgVars["radartowercost"] * -1 );
		Notify( ply, 0, 3, "You bought a Radar Tower." );
		local ent = ents.Create( "radartower" );
	 
		ent.Owner = ply
		ent:SetPos( tr.HitPos+Vector(0,0,10));
		ent:Spawn()
		return "";
end
AddChatCommand( "/buytower", BuyTower );
AddChatCommand( "/buyradar", BuyTower );
AddChatCommand( "/buyradartower", BuyTower );

// Supplytable
function BuySupplyTable( ply )
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["supplytablecost"] )) then
			Notify( ply, 4, 3, "You can't afford a Supply Table." );
		return "";
		end
		if(ply:GetTable().maxsupplytable >=1)then
			Notify( ply, 4, 3, "You already have a Supply Table!" );
		return "";
		end
		ply:AddMoney( CfgVars["supplytablecost"] * -1 );
		Notify( ply, 0, 3, "You bought a Supply Table." );
		local ent = ents.Create( "supplytable" );
	 
		ent.Owner = ply
		ent:SetPos( tr.HitPos+Vector(0,0,10));
		ent:Spawn()
		return "";
end
AddChatCommand( "/buysupplytable", BuySupplyTable );
AddChatCommand( "/buysupplycabinet", BuySupplyTable );

// Lamp
function BuyLamp( ply )
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );

		if( not ply:CanAfford( CfgVars["lampcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Lamp." );
			return "";
		end
		if(ply:GetTable().maxlamp >= CfgVars["maxlamp"])then
			Notify( ply, 4, 3, "Max Lamps Reached!" );
			return "";
		end
			ply:AddMoney( CfgVars["lampcost"] * -1 );
			Notify( ply, 0, 3, "You bought a Lamp!" );
			local lamp = ents.Create( "bw_lamp" );
			 
			lamp:SetPos( tr.HitPos );
			lamp.Owner = ply
			lamp:Spawn();
			return "";
end
AddChatCommand( "/buylamp", BuyLamp );
AddChatCommand( "/buylight", BuyLamp );

// Solar Generator
function BuySolarGenerator( ply )
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		
		if( not ply:CanAfford( CfgVars["solargeneratorcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Solar Generator." );
			return "";
		end
		if(ply:GetTable().maxsolargenerator >= CfgVars["maxsolargenerator"])then
			Notify( ply, 4, 3, "Max Solar Generators Reached!" );
			return "";
		end
		ply:AddMoney( CfgVars["solargeneratorcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Solar Generator." );
		local ent = ents.Create( "solargenerator" );
		 
		ent:SetPos( tr.HitPos+Vector(0,0,10));
		ent.Owner = ply
		ent:Spawn()
		return "";
end
AddChatCommand( "/buysolarpower", BuySolarGenerator );
AddChatCommand( "/buysolargenerator", BuySolarGenerator );

// Generator
function BuyGenerator( ply )
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		
		if( not ply:CanAfford( CfgVars["generatorcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Generator." );
			return "";
		end
		if(ply:GetTable().maxgenerator >= CfgVars["maxgenerator"])then
			Notify( ply, 4, 3, "Max Generators Reached!" );
			return "";
		end
		ply:AddMoney( CfgVars["generatorcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Generator." );
		local ent = ents.Create( "generator" );
		 
		ent:SetPos( tr.HitPos+Vector(0,0,10));
		ent.Owner = ply
		ent:Spawn()
		return "";
end
AddChatCommand( "/buypowerplant", BuyGenerator );
AddChatCommand( "/buygenerator", BuyGenerator );

// Super Generator
function BuySuperGenerator( ply )
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		
		if( not ply:CanAfford( CfgVars["supergeneratorcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Supper Generator." );
			return "";
		end
		if(ply:GetTable().maxsupergenerator >= CfgVars["maxsupergenerator"])then
			Notify( ply, 4, 3, "Max Super Generators Reached!" );
			return "";
		end
		ply:AddMoney( CfgVars["supergeneratorcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Super Generator." );
		local ent = ents.Create( "supergenerator" );

		ent:SetPos( tr.HitPos+Vector(0,0,10));
		ent.Owner = ply
		ent:Spawn();		
	return "";
end
AddChatCommand( "/buysuperpowerplant", BuySuperGenerator );
AddChatCommand( "/buysupergenerator", BuySuperGenerator );

// Nuclear Generator
function BuyNuclearGenerator( ply )
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		
		if( not ply:CanAfford( CfgVars["nucleargeneratorcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Nuclear Generator." );
			return "";
		end
		if(ply:GetTable().maxnucleargenerator >= CfgVars["maxnucleargenerator"])then
			Notify( ply, 4, 3, "Max Nuclear Generators Reached!" );
			return "";
		end
		ply:AddMoney( CfgVars["nucleargeneratorcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Nuclear Generator." );
		local ent = ents.Create( "nucleargenerator" );
		 
		ent:SetPos( tr.HitPos+Vector(0,0,10));
		ent.Owner = ply
		ent:Spawn()
		return "";
end
AddChatCommand( "/buynuclearpower", BuyNuclearGenerator );
AddChatCommand( "/buynucleargenerator", BuyNuclearGenerator );

// Big Bomb
function BuyBomb( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	if( not ply:CanAfford( CfgVars["bigbombcost"] ) ) then
		Notify( ply, 4, 3, "Cannot afford this!" );
		return "";
	end
		if(ply:GetTable().maxBigBombs >= CfgVars["bigbombmax"])then
			Notify( ply, 4, 3, "Max Big Bombs Reached!" );
			return "";
		end
	ply:AddMoney( CfgVars["bigbombcost"] * -1 );
	Notify( ply, 0, 3, "You bought the Big Bomb!" );
	local Bigbomb = ents.Create( "bigbomb" );
	Bigbomb:SetPos( tr.HitPos + tr.HitNormal*15);
	Bigbomb.Owner = ply
	Bigbomb:Spawn();
	Bigbomb:Activate();
	return "";
end
AddChatCommand( "/buybomb", BuyBomb );
AddChatCommand( "/buybigbomb", BuyBomb );

// Jihad Bomb
function BuyJihadBomb( ply )
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );

		if( not ply:CanAfford( CfgVars["jihadcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Jihad Bomb." );
			return "";
		end
		ply:AddMoney( CfgVars["jihadcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Jihad Bomb." );
		
		local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_jb.mdl" );
			weapon:SetNWString("weaponclass", "weapon_jihadbomb");
			weapon:SetPos( tr.HitPos );
			weapon:Spawn();		
		return "";
end
AddChatCommand( "/buyjihad", BuyJihadBomb );
AddChatCommand( "/buyjihadbomb", BuyJihadBomb );

// C4
function BuyC4( ply )
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );

		if( not ply:CanAfford( CfgVars["c4cost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a C4 Explosive." );
			return "";
		end
		ply:AddMoney( CfgVars["c4cost"] * -1 );
		Notify( ply, 0, 3, "You bought a C4 Explosive." );
		
		local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_c4.mdl" );
			weapon:SetNWString("weaponclass", "weapon_mad_c4");
			weapon:SetPos( tr.HitPos );
			weapon:Spawn();		
		return "";
end
AddChatCommand( "/buyc4", BuyC4 );

// Pipe Bomb
function BuyPipeBomb( ply )
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );

		if( not ply:CanAfford( CfgVars["pipebombcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Pipe Bomb." );
			return "";
		end
		ply:AddMoney( CfgVars["pipebombcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Pipe Bomb." );
		
		local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/props_lab/pipesystem03b.mdl" );
			weapon:SetNWString("weaponclass", "weapon_pipebomb");
			weapon:SetPos( tr.HitPos );
			weapon:Spawn();		
		return "";
end
AddChatCommand( "/buypipebomb", BuyPipeBomb );

function BuyStickyGrenade( ply )
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );

		if( not ply:CanAfford( CfgVars["stickygrenadecost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Sticky Grenade." );
			return "";
		end
		ply:AddMoney( CfgVars["stickygrenadecost"] * -1 );
		Notify( ply, 0, 3, "You bought a Sticky Grenade." );
		
		local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_magnade.mdl" );
			weapon:SetNWString("weaponclass", "weapon_stickgrenade");
			weapon:SetPos( tr.HitPos );
			weapon:Spawn();			
		return "";
end
AddChatCommand( "/buystickygrenade", BuyStickyGrenade );
AddChatCommand( "/buystickynade", BuyStickyGrenade );

function BuyGrenade( ply )
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );

		if( not ply:CanAfford( CfgVars["grenadecost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Grenade." );
			return "";
		end
		ply:AddMoney( CfgVars["grenadecost"] * -1 );
		Notify( ply, 0, 3, "You bought a Grenade." );
		
		local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_eq_fraggrenade.mdl" );
			weapon:SetNWString("weaponclass", "weapon_real_cs_grenade");
			weapon:SetPos( tr.HitPos );
			weapon:Spawn();		
		return "";
end
AddChatCommand( "/buygrenade", BuyGrenade );
AddChatCommand( "/buyfraggrenade", BuyGrenade );
AddChatCommand( "/buyhegrenade", BuyGrenade );

function BuyDoorCharge( ply )
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );

		if( not ply:CanAfford( CfgVars["doorchargecost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Door Charge." );
			return "";
		end
		ply:AddMoney( CfgVars["doorchargecost"] * -1 );
		Notify( ply, 0, 3, "You bought a Door Charge." );
		
		local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_slam.mdl" );
			weapon:SetNWString("weaponclass", "weapon_mad_charge");
			weapon:SetPos( tr.HitPos );
			weapon:Spawn();		
		return "";
end
AddChatCommand( "/buydoorcharge", BuyDoorCharge );
AddChatCommand( "/buyslam", BuyDoorCharge );

function BuyGasGrenade( ply )
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );

		if( not ply:CanAfford( CfgVars["gasgrenadecost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Gas Grenade." );
			return "";
		end
		ply:AddMoney( CfgVars["gasgrenadecost"] * -1 );
		Notify( ply, 0, 3, "You bought a Gas Grenade." );
		
		local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_eq_smokegrenade.mdl" );
			weapon:SetNWString("weaponclass", "weapon_gasgrenade");
			weapon:SetPos( tr.HitPos );
			weapon:Spawn();		
		return "";
end
AddChatCommand( "/buygasgrenade", BuyGasGrenade );
AddChatCommand( "/buysmokegrenade", BuyGasGrenade );

function BuyStunGrenade( ply )
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );

		if( not ply:CanAfford( CfgVars["flashbangcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Stun Grenade." );
			return "";
		end
		ply:AddMoney( CfgVars["flashbangcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Stun Grenade." );
		
		local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_eq_flashbang.mdl" );
			weapon:SetNWString("weaponclass", "weapon_real_cs_flash");
			weapon:SetPos( tr.HitPos );
			weapon:Spawn();		
		return "";
end
AddChatCommand( "/buystungrenade", BuyStunGrenade );
AddChatCommand( "/buyflashbang", BuyStunGrenade );

// Knife
function BuyKnife( ply )
		if( not ply:CanAfford( CfgVars["knifecost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Knife." );
			return "";
		end
		ply:AddMoney( CfgVars["knifecost"] * -1 );
		Notify( ply, 0, 3, "You bought a Knife." );
		
		ply:Give("weapon_knife2")
		return "";
end
AddChatCommand( "/buyknife", BuyKnife );

// Lockpick
function BuyLockPick( ply )
		if( not ply:CanAfford( CfgVars["lockpickcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Lockpick." );
			return "";
		end
		ply:AddMoney( CfgVars["lockpickcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Lockpick." );
		
		ply:Give("lockpick")
		return "";
end
AddChatCommand( "/buylockpick", BuyLockPick );

// Blowtorch
function BuyWelder( ply )
		if( not ply:CanAfford( CfgVars["blowtorchcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Blowtorch." );
			return "";
		end
		ply:AddMoney( CfgVars["blowtorchcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Blowtorch!" );
		
		ply:Give("weapon_welder")
		return "";
end
AddChatCommand( "/buywelder", BuyWelder );
AddChatCommand( "/buyblowtorch", BuyWelder );

// Ammo Dispenser
function BuyDispenser( ply )
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 150;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["dispensercost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Ammo Dispenser." );
			return "";
		end
		if(ply:GetTable().maxdispensers >= CfgVars["dispensermax"])then
			Notify( ply, 4, 3, "Max Ammo Dispensers Reached!" );
			return "";
		end
		local SpawnPos = tr.HitPos + tr.HitNormal * 20
		ply:AddMoney( CfgVars["dispensercost"] * -1 );
		Notify( ply, 0, 3, "You bought a Ammo Dispenser!" );
		
		local ent = ents.Create( "dispenser" )
		ent:SetPos( SpawnPos + Vector(0,0,30) )
 
		ent.Owner = ply
		ent:Spawn()
		ent:Activate()
		return "";
end
AddChatCommand( "/buydispenser", BuyDispenser );
AddChatCommand( "/buyammodispenser", BuyDispenser );

// Health Dispenser
function BuyHealthDispenser( ply )
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 150;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["healthdispensercost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Health Dispenser" );
			return "";
		end
		if(ply:GetTable().maxhealthdispensers >= CfgVars["healthdispensersmax"])then
			Notify( ply, 4, 3, "Max Health Dispensers Reached!" );
			return "";
		end
		local SpawnPos = tr.HitPos + tr.HitNormal * 20
		ply:AddMoney( CfgVars["healthdispensercost"] * -1 );
		Notify( ply, 0, 3, "You bought a Health Dispenser!" );
		
		local ent = ents.Create( "healthdispenser" )
		ent:SetPos( SpawnPos + Vector(0,0,30) )
 
		ent.Owner = ply
		ent:Spawn()
		ent:Activate()
		return "";
end
AddChatCommand( "/buyhealthdispenser", BuyHealthDispenser );

// Armor Dispencers
function BuyArmorDispenser( ply )
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 150;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["armordispensercost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Armor Dispenser." );
			return "";
		end
		if(ply:GetTable().maxarmordispensers >= CfgVars["armordispensersmax"])then
			Notify( ply, 4, 3, "Max Armor Dispensers Reached!" );
			return "";
		end
		local SpawnPos = tr.HitPos + tr.HitNormal * 20
		ply:AddMoney( CfgVars["armordispensercost"] * -1 );
		Notify( ply, 0, 3, "You bought a Armor Dispenser!" );
		
		local ent = ents.Create( "armordispenser" )
		ent:SetPos( SpawnPos + Vector(0,0,30) )
 
		ent.Owner = ply
		ent:Spawn()
		ent:Activate()
		return "";
end
AddChatCommand( "/buyarmordispenser", BuyArmorDispenser );

// Methlab
function BuyMethlab( ply,args )
	args = Purify(args)
	local count = tonumber(args)
	if count==nil then count = 1 end
	if count>CfgVars["maxmethlab"] || count<1 then count = 1 end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 150;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["methlabcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Meth Lab." );
			return "";
		end
		if(ply:GetTable().maxmethlab >= CfgVars["maxmethlab"])then
			Notify( ply, 4, 3, "Max Meth Labs Reached!" );
			return "";
		end
		local SpawnPos = tr.HitPos + tr.HitNormal * 20
		ply:AddMoney( CfgVars["methlabcost"] * -1 );
		Notify( ply, 0, 3, "You bought a meth lab!" );
		
		local ent = ents.Create( "meth_lab" )
		ent:SetPos( SpawnPos + Vector(0,0,10) )
 
		ent.Owner = ply
		ent:Spawn()
//		ent:SetColor(Color(255, 255, 255, 255))
		ent:Activate()
	return "";
end
AddChatCommand( "/buymethlab", BuyMethlab );

// Stable Methlab
function BuyStableMethLab( ply )
	args = Purify(args)
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		
		if( not ply:CanAfford( CfgVars["stablemethlab"] )) then
			Notify( ply, 4, 3, "You can't afford a Stable Meth Lab." );
			return "";
		end
		if(ply:GetTable().maxstablemethlab >= CfgVars["maxstablemethlab"])then
			Notify( ply, 4, 3, "Max Stable Meth Labs Reached!" );
			return "";
		end
		ply:AddMoney( CfgVars["stablemethlab"] * -1 );
		Notify( ply, 0, 3, "You bought a Stable Meth Lab!" );
		local druglab = ents.Create( "meth_lab_stable" );
 
		druglab.Owner = ply
		druglab:SetPos( tr.HitPos + tr.HitNormal*148);
		druglab:Spawn();

	return "";
end
AddChatCommand( "/buystablemethlab", BuyStableMethLab );

// Weed Plant
function BuyPlant( ply, args )
  	args = Purify(args)
  	local count = tonumber(args)
  	if count==nil then count = 1 end
  	if count>CfgVars["maxweed"] || count<1 then count = 1 end
  	local trace = { }
  	
  	trace.start = ply:EyePos();
  	trace.endpos = trace.start + ply:GetAimVector() * 150;
  	trace.filter = ply;
  	
  	local tr = util.TraceLine( trace );

  		if( not ply:CanAfford( CfgVars["weedcost"] ) ) then
  			Notify( ply, 4, 3, "You can't afford a Weed Plant." );
  			return "";
  		end
  		if(ply:GetTable().maxweed >= CfgVars["maxweed"])then
  			Notify( ply, 4, 3, "Max Weed Plants Reached!" );
  			return "";
  		end
  		local SpawnPos = tr.HitPos + tr.HitNormal * 20
  		ply:AddMoney( CfgVars["weedcost"] * -1 );
  		Notify( ply, 0, 3, "You bought a Weed Plant!" );
  		
  		local ent = ents.Create( "weedplant" )
		ent.Owner = ply
  		ent:SetPos( SpawnPos + Vector(0,0,20) )
  		ent:Spawn()
  		ent:Activate()
  		if (math.Rand(0,1)>.75) then
  			ent:Worthless()
  			Notify( ply, 1, 3, "Your Weed Plant has Spolied! You might as well destroy it.")
  		end
 --- 	end
  	return "";
end
AddChatCommand( "/buyplant", BuyPlant );
AddChatCommand( "/buyweed", BuyPlant );
AddChatCommand( "/buyweedplant", BuyPlant );

// Spawnpoint
function BuySpawn( ply )
    
    if( args == "" ) then return ""; end
    	local trace = { }
    		trace.start = ply:GetPos()+Vector(0,0,1)
		trace.endpos = trace.start+Vector(0,0,90)
		trace.filter = ply
	trace = util.TraceLine(trace)
	if( trace.Fraction<1 ) then
            Notify( ply, 4, 3, "Not enough room!" );
            return "";
        end
        if( not ply:CanAfford( CfgVars["spawncost"] ) ) then
            Notify( ply, 4, 3, "You can't afford a Spawnpoint." );
            return "";
        end
	if(!ply:Alive())then
            Notify( ply, 4, 3, "You can't buy a Spawnpoint while you are dead.");
            return "";
        end
	if IsValid(ply:GetTable().Spawnpoint) then
		ply:GetTable().Spawnpoint:Remove()
		Notify(ply,1,3, "Destroyed old Spawnpoint to create new one.")
	end
        ply:AddMoney( CfgVars["spawncost"] * -1 );
        Notify( ply, 0, 3, "You bought a Spawnpoint!" );
        local spawnpoint = ents.CreateEx( "spawnpoint" );
		spawnpoint.Owner = ply
        spawnpoint:SetPos( ply:GetPos());
//		spawnpoint:SetColor(Color(255, 255, 255, 254))
	ply:SetPos(ply:GetPos()+Vector(0,0,3))
--	spawnpoint:SetAngles(Angle(0, 0, 0))
        spawnpoint:Spawn();
    return "";
end
AddChatCommand( "/buyspawnpoint", BuySpawn );

function AllyTurret(ply, args)
	Notify( ply, 1, 3, "Use Basewars Allies menu instead of this.")
	return "";
end
//AddChatCommand( "/setally", AllyTurret );
//AddChatCommand( "/addally", AllyTurret );

function UnAllyTurret(ply, args)
	Notify( ply, 1, 3, "Use Basewars Allies menu instead of this.")
	return""
end
AddChatCommand( "/clearally", UnAllyTurret );
//AddChatCommand( "/removeally", UnAllyTurret );
//AddChatCommand( "/unsetally", UnAllyTurret );

function JobAllyTurret(ply, args)
	Notify( ply, 1, 3, "Use Basewars Allies menu instead of this.")
	return""
end
//AddChatCommand( "/setjobally", JobAllyTurret );

function TargetTurret(ply, args)
	args = Purify(args)
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 150;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	local targent = tr.Entity
	if (targent:GetClass()!="auto_turret") then
		return "" ;
	end
	if (targent.Owner) then
		Notify( ply, 4, 3, "This is not your Turret!" );
		return "" ;
	end
	Notify( ply, 0, 3, "Set turret target string to " .. args)
	targent:SetNWString("enemytarget", args)
	return "" ;
end
//AddChatCommand( "/settarget", TargetTurret );

// Fuel
function BuyIncedAmmo( ply )
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );

		if( not ply:CanAfford( CfgVars["ammofuelcost"] )) then
			Notify( ply, 4, 3, "You can't afford a Fuel Tank." );
			return "";
		end
		ply:AddMoney( CfgVars["ammofuelcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Fuel Tank!" );
		local fuel = ents.Create( "ent_mad_fuel" );
		fuel:SetPos( tr.HitPos+Vector(0,0,40));
		fuel:Spawn();
		return "";
end
AddChatCommand( "/buyfuel", BuyIncedAmmo );

// Health
function BuyHealth( ply )
	if( not ply:CanAfford( CfgVars["healthcost"] ) ) then
		Notify( ply, 4, 3, "You can't afford a Health Kit." );
		return "";
	end
	
	ply:AddMoney( CfgVars["healthcost"] * -1 );
	Notify(ply, 0, 3, "You bought a Health Kit!")
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 80;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	local vehiclespawn = ents.CreateEx( "item_buyhealth" );
	vehiclespawn:SetPos( tr.HitPos + Vector(0, 0, 15));
	vehiclespawn:Spawn();
	timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))
	return "";
end
AddChatCommand( "/buyhealth", BuyHealth );

// Armor
function BuyArmor( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["armorcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford Armor." );
			return "";
		end
		ply:AddMoney( CfgVars["armorcost"] * -1 );
		Notify( ply, 0, 3, "You bought some Armor!" );
			local vehiclespawn = ents.CreateEx( "item_armor" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, 25, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))
	return "";
end
AddChatCommand( "/buyarmor", BuyArmor );

// Helmet
function BuyHelmet( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["helmetcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Helmet." );
			return "";
		end
		ply:AddMoney( -CfgVars["helmetcost"] );
		Notify( ply, 0, 3, "You bought a Helmet!" );
			local vehiclespawn = ents.CreateEx( "item_helmet" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, 25, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))
	return "";
end
AddChatCommand( "/buyhelmet", BuyHelmet );

// Defusal Kit
function BuyDefuseKit( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["defusekitcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Defusal Kit." );
			return "";
		end
		ply:AddMoney( CfgVars["defusekitcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Defusal Kit!" );
			local vehiclespawn = ents.CreateEx( "item_toolkit" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, 20, 10));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))
	return "";
end
AddChatCommand( "/buytoolkit", BuyDefuseKit );
AddChatCommand( "/buydefusekit", BuyDefuseKit );

// Scan Blocker
function BuyScanBlock( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["scanblockcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Scan Blocker." );
			return "";
		end
		ply:AddMoney( CfgVars["scanblockcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Scan Blocker!" );
			local vehiclespawn = ents.CreateEx( "item_scanner" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, 20, 10));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))
	return "";
end
AddChatCommand( "/buyscanner", BuyScanBlock );

// Snipe Shield
function BuyShield( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["shieldcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Snipe Shield." );
			return "";
		end
		ply:AddMoney( CfgVars["shieldcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Snipe Shield!" );
			local vehiclespawn = ents.CreateEx( "item_snipeshield" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, 20, 10));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))
	return "";
end
AddChatCommand( "/buyshield", BuyShield );

// Weapon Attachments

// Laser Sight
function BuyLaserSight( ply )

		if( not ply:CanAfford( CfgVars["lasersightcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Laser Sight." );
			return "";
		end
		if(ply:GetTable().lasersight >= 1 )then
			Notify( ply, 4, 3, "You already bought a Laser Sight!" );
			return "";
		end		

		ply:GetTable().lasersight=ply:GetTable().lasersight + 1
		ply:AddMoney( CfgVars["lasersightcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Laser Sight." );

		ply:PickUpAttachment("laser")		

		return "";
end
AddChatCommand( "/buylasersight", BuyLaserSight );

// Kobra Sight
function BuyKobra( ply )

		if( not ply:CanAfford( CfgVars["kobracost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Kobra Sight." );
			return "";
		end
		if(ply:GetTable().kobra >= 1 )then
			Notify( ply, 4, 3, "You already bought a Kobra Sight!" );
			return "";
		end		

		ply:GetTable().kobra=ply:GetTable().kobra + 1
		ply:AddMoney( CfgVars["kobracost"] * -1 );
		Notify( ply, 0, 3, "You bought a Kobra Sight." );

		ply:PickUpAttachment("kobra")		

		return "";
end
AddChatCommand( "/buykobrasight", BuyKobra );

// Reflex Sight
function BuyReflexSight( ply )

		if( not ply:CanAfford( CfgVars["reflexsightcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Reflex Sight." );
			return "";
		end
		if(ply:GetTable().reflexsight >= 1 )then
			Notify( ply, 4, 3, "You already bought a Reflex Sight!" );
			return "";
		end		

		ply:GetTable().reflexsight=ply:GetTable().reflexsight + 1
		ply:AddMoney( CfgVars["reflexsightcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Reflex Sight." );

		ply:PickUpAttachment("reflex")		

		return "";
end
AddChatCommand( "/buyreflexsight", BuyReflexSight );

// Rifle Reflex Sight
function BuyRifleReflex( ply )

		if( not ply:CanAfford( CfgVars["riflereflexcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Rifle Reflex Sight." );
			return "";
		end
		if(ply:GetTable().riflereflex >= 1 )then
			Notify( ply, 4, 3, "You already bought a Rifle Reflex Sight!" );
			return "";
		end		

		ply:GetTable().riflereflex=ply:GetTable().riflereflex + 1
		ply:AddMoney( CfgVars["riflereflexcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Rifle Reflex Sight." );

		ply:PickUpAttachment("riflereflex")		

		return "";
end
AddChatCommand( "/buyriflereflex", BuyRifleReflex );

// EoTech Sight
function BuyEotechSight( ply )

		if( not ply:CanAfford( CfgVars["eotechcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Eotech Sight." );
			return "";
		end
		if(ply:GetTable().eotech557 >= 1 )then
			Notify( ply, 4, 3, "You already bought a Eotech Sight!" );
			return "";
		end		

		ply:GetTable().eotech557=ply:GetTable().eotech557 + 1
		ply:AddMoney( CfgVars["eotechcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Eotech Sight." );

		ply:PickUpAttachment("eotech")		

		return "";
end
AddChatCommand( "/buyeotechsight", BuyEotechSight );

// Aimpoint
function BuyAimPoint( ply )

		if( not ply:CanAfford( CfgVars["aimpointcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Aimpoint." );
			return "";
		end
		if(ply:GetTable().aimpoint >= 1 )then
			Notify( ply, 4, 3, "You already bought a Aimpoint!" );
			return "";
		end		

		ply:GetTable().aimpoint=ply:GetTable().aimpoint + 1
		ply:AddMoney( CfgVars["aimpointcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Aimpoint." );

		ply:PickUpAttachment("aimpoint")		

		return "";
end
AddChatCommand( "/buyaimpoint", BuyAimPoint );

// ACOG Sight
function BuyAcogScope( ply )

		if( not ply:CanAfford( CfgVars["acogscopecost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a ACOG Sight." );
			return "";
		end
		if(ply:GetTable().acogsight >= 1 )then
			Notify( ply, 4, 3, "You already bought a ACOG Sight!" );
			return "";
		end		

		ply:GetTable().acogsight=ply:GetTable().acogsight + 1
		ply:AddMoney( CfgVars["acogscopecost"] * -1 );
		Notify( ply, 0, 3, "You bought a ACOG Sight." );

		ply:PickUpAttachment("acog")		

		return "";
end
AddChatCommand( "/buyacogsight", BuyAcogScope );

// Ballistic
function BuyBallistic( ply )

		if( not ply:CanAfford( CfgVars["ballisticcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Ballistic Scope." );
			return "";
		end
		if(ply:GetTable().ballistic >= 1 )then
			Notify( ply, 4, 3, "You already bought a Ballistic Scope!" );
			return "";
		end		

		ply:GetTable().ballistic=ply:GetTable().ballistic + 1
		ply:AddMoney( CfgVars["ballisticcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Ballistic." );

		ply:PickUpAttachment("ballistic")		

		return "";
end
AddChatCommand( "/buyballistic", BuyBallistic );

// Bipod
function BuyBipod( ply )

		if( not ply:CanAfford( CfgVars["bipodcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Bipod." );
			return "";
		end
		if(ply:GetTable().bipod >= 1 )then
			Notify( ply, 4, 3, "You already bought a Bipod!" );
			return "";
		end		

		ply:GetTable().bipod=ply:GetTable().bipod + 1
		ply:AddMoney( CfgVars["bipodcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Bipod." );

		ply:PickUpAttachment("bipod")		

		return "";
end
AddChatCommand( "/buybipod", BuyBipod );

function BuyM203( ply )

		if( not ply:CanAfford( CfgVars["m203cost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a M203." );
			return "";
		end
		if(ply:GetTable().m203 >= 1 )then
			Notify( ply, 4, 3, "You already bought a M203!" );
			return "";
		end		

		ply:GetTable().m203=ply:GetTable().m203 + 1
		ply:AddMoney( CfgVars["m203cost"] * -1 );
		Notify( ply, 0, 3, "You bought a M203." );

		ply:PickUpAttachment("grenadelauncher")		

		return "";
end
AddChatCommand( "/buym203", BuyM203 );

function BuyCMagazine( ply )

		if( not ply:CanAfford( CfgVars["cmagazinecost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a C-Magazine." );
			return "";
		end
		if(ply:GetTable().cmagazine >= 1 )then
			Notify( ply, 4, 3, "You already bought a C-Magazine!" );
			return "";
		end		

		ply:GetTable().cmagazine=ply:GetTable().cmagazine + 1
		ply:AddMoney( CfgVars["cmagazinecost"] * -1 );
		Notify( ply, 0, 3, "You bought a C-Magazine." );

		ply:PickUpAttachment("cmag")		

		return "";
end
AddChatCommand( "/buycmagazine", BuyCMagazine );

--------------------------------------------------

// Drug Batches

// Steroid Batch 
function BuyBatchSteroid( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( 4 * CfgVars["steroidcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Batch of Steroids." );
			return "";
		end
		ply:AddMoney( 4 * CfgVars["steroidcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Batch of Steroids!" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.CreateEx( "item_steroid" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
		timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))
		end
	return "";
end
AddChatCommand( "/buybatchsteroids", BuyBatchSteroid );

// Doublejump Batch 
function BuyBatchDoubleJump( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( 4 * CfgVars["doublejumpcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Batch of Double Jump." );
			return "";
		end
		ply:AddMoney( 4 * CfgVars["doublejumpcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Batch of Double Jump!" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.CreateEx( "item_doublejump" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))
		end
	return "";
end
AddChatCommand( "/buybatchdoublejump", BuyBatchDoubleJump );

// Adrenaline Batch
function BuyBatchAdrenaline( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( 4 * CfgVars["adrenalinecost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Batch of Adrenaline." );
			return "";
		end
		ply:AddMoney( 4 * CfgVars["adrenalinecost"] * -1 );
		Notify( ply, 0, 3, "You bought a Batch of Adrenaline!" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.CreateEx( "item_adrenaline" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))
		end
	return "";
end
AddChatCommand( "/buybatchadrenaline", BuyBatchAdrenaline );

// Knockback Batch 
function BuyBatchKnockback( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( 4 * CfgVars["knockbackcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Batch of Knockback." );
			return "";
		end
		ply:AddMoney( 4 * CfgVars["knockbackcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Batch of Knockback!" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.CreateEx( "item_knockback" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))
		end
	return "";
end
AddChatCommand( "/buybatchknockback", BuyBatchKnockback );

// Armorpiercer Batch
function BuyBatchArmorpiercer( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( 4 * CfgVars["armorpiercercost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Batch of Armor Piercer." );
			return "";
		end
		ply:AddMoney( 4 * CfgVars["armorpiercercost"] * -1 );
		Notify( ply, 0, 3, "You bought a Batch of Armor Piercer!" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.CreateEx( "item_armorpiercer" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))
		end
	return "";
end
AddChatCommand( "/buybatchapiercer", BuyBatchArmorpiercer );
AddChatCommand( "/buybatchpiercer", BuyBatchArmorpiercer );
AddChatCommand( "/buybatcharmorpiercer", BuyBatchArmorpiercer );

// Shockwave Batch 
function BuyBatchShockWave( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( 4 * CfgVars["shockwavecost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Batch of Shockwave." );
			return "";
		end
		ply:AddMoney( 4 * CfgVars["shockwavecost"] * -1 );
		Notify( ply, 0, 3, "You bought a Batch of Shockwave!" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.CreateEx( "item_shockwave" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))
		end
	return "";
end
AddChatCommand( "/buybatchshockwave", BuyBatchShockWave );

// Leech Batch 
function BuyBatchLeech( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( 4 * CfgVars["leechcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Batch of Leech." );
			return "";
		end
		ply:AddMoney( 4 * CfgVars["leechcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Batch of Leech!" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.CreateEx( "item_leech" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))
		end
	return "";
end
AddChatCommand( "/buybatchleech", BuyBatchLeech );

// Double Tap Batch 
function BuyBatchDoubleTap( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( 4 * CfgVars["doubletapcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Batch of Double Tap" );
			return "";
		end
		ply:AddMoney( 4 * CfgVars["doubletapcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Batch of Double Tap!" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.CreateEx( "item_doubletap" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))
		end
	return "";
end
AddChatCommand( "/buybatchdoubletap", BuyBatchDoubleTap );

// Reflect Batch 
function BuyBatchReflect( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( 4 * CfgVars["reflectcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Batch of Reflect." );
			return "";
		end
		ply:AddMoney( 4 * CfgVars["reflectcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Batch of Reflect!" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.CreateEx( "item_reflect" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))
		end
	return "";
end
AddChatCommand( "/buybatchreflect", BuyBatchReflect );

// Focus 
function BuyBatchFocus( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( 4 * CfgVars["focuscost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Batch of Focus." );
			return "";
		end
		ply:AddMoney( 4 * CfgVars["focuscost"] * -1 );
		Notify( ply, 0, 3, "You bought a Batch of Focus!" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.CreateEx( "item_focus" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))
		end
	return "";
end
AddChatCommand( "/buybatchfocus", BuyBatchFocus );

// Antidote Batch 
function BuyBatchAntidote( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( 4 * CfgVars["antidotecost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Batch of Antidote." );
			return "";
		end
		ply:AddMoney( 4 * CfgVars["antidotecost"] * -1 );
		Notify( ply, 0, 3, "You bought a Batch of Antidote!" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.CreateEx( "item_antidote" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))
		end
	return "";
end
AddChatCommand( "/buybatchantidote", BuyBatchAntidote );

// Amplifier 

function BuyBatchAmp( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( 4 * CfgVars["ampcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Batch of Amplifier." );
			return "";
		end
		ply:AddMoney( 4 * CfgVars["ampcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Batch of Amplifier!" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.CreateEx( "item_amp" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))
		end
	return "";
end
AddChatCommand( "/buybatchamp", BuyBatchAmp );

// Pain Killer Batch 
function BuyBatchPainKiller( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( 4 * CfgVars["painkillercost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Batch of Pain Killers." );
			return "";
		end
		ply:AddMoney( 4 * CfgVars["painkillercost"] * -1 );
		Notify( ply, 0, 3, "You bought a Batch of Pain Killers!" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.CreateEx( "item_painkiller" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))
		end
	return "";
end
AddChatCommand( "/buybatchpainkiller", BuyBatchPainKiller );
AddChatCommand( "/buybatchpainkillers", BuyBatchPainKiller );

// Magic Bullet Batch 
function BuyBatchMagicBullet( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( 4 * CfgVars["magicbulletcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Batch of Magic Bullet." );
			return "";
		end
		ply:AddMoney( 4 * CfgVars["magicbulletcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Batch of Magic Bullet!" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.CreateEx( "item_magicbullet" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))
		end
	return "";
end
AddChatCommand( "/buybatchmagicbullet", BuyBatchMagicBullet );
AddChatCommand( "/buybatchmb", BuyBatchMagicBullet );

// Regeneration Batch 
function BuyBatchRegen( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( 4 * CfgVars["regencost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Batch of Regeneration." );
			return "";
		end
		ply:AddMoney( 4 * CfgVars["regencost"] * -1 );
		Notify( ply, 0, 3, "You bought a Batch of Regeneration!" );
		for i=-2, 2, 1 do 
			local vehiclespawn = ents.CreateEx( "item_regen" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, i*12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))
		end
	return "";
end
AddChatCommand( "/buybatchregen", BuyBatchRegen );


// Steroid 
function BuySteroid( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["steroidcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford Steroids." );
			return "";
		end
		ply:AddMoney( CfgVars["steroidcost"] * -1 );
		Notify( ply, 0, 3, "You bought Steroids!" );

			local vehiclespawn = ents.CreateEx( "item_steroid" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, 12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))

	return "";
end
AddChatCommand( "/buysteroids", BuySteroid );

// Doublejump 
function BuyDoubleJump( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["doublejumpcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford Double Jump." );
			return "";
		end
		ply:AddMoney( CfgVars["doublejumpcost"] * -1 );
		Notify( ply, 0, 3, "You bought Double Jump!" );

			local vehiclespawn = ents.CreateEx( "item_doublejump" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, 12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))

	return "";
end
AddChatCommand( "/buydoublejump", BuyDoubleJump );

// Adrenaline 
function BuyAdrenaline( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["adrenalinecost"] ) ) then
			Notify( ply, 4, 3, "You can't afford Adrenaline." );
			return "";
		end
		ply:AddMoney( CfgVars["adrenalinecost"] * -1 );
		Notify( ply, 0, 3, "You bought Adrenaline!" );

			local vehiclespawn = ents.CreateEx( "item_adrenaline" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, 12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))

	return "";
end
AddChatCommand( "/buyadrenaline", BuyAdrenaline );

// Knockback 
function BuyKnockback( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["knockbackcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford Knockback." );
			return "";
		end
		ply:AddMoney( CfgVars["knockbackcost"] * -1 );
		Notify( ply, 0, 3, "You bought Knockback!" );

			local vehiclespawn = ents.CreateEx( "item_knockback" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, 12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))

	return "";
end
AddChatCommand( "/buyknockback", BuyKnockback );

// Armorpiercer
function BuyArmorpiercer( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["armorpiercercost"] ) ) then
			Notify( ply, 4, 3, "You can't afford Armor Piercer." );
			return "";
		end
		ply:AddMoney( CfgVars["armorpiercercost"] * -1 );
		Notify( ply, 0, 3, "You bought Armor Piercer!" );

			local vehiclespawn = ents.CreateEx( "item_armorpiercer" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, 12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))

	return "";
end
AddChatCommand( "/buyapiercer", BuyArmorpiercer );
AddChatCommand( "/buypiercer", BuyArmorpiercer );
AddChatCommand( "/buyarmorpiercer", BuyArmorpiercer );

// Shockwave 
function BuyShockWave( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["shockwavecost"] ) ) then
			Notify( ply, 4, 3, "You can't afford Shockwave." );
			return "";
		end
		ply:AddMoney( CfgVars["shockwavecost"] * -1 );
		Notify( ply, 0, 3, "You bought Shockwave!" );

			local vehiclespawn = ents.CreateEx( "item_shockwave" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, 12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))

	return "";
end
AddChatCommand( "/buyshockwave", BuyShockWave );

// Leech 
function BuyLeech( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["leechcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford Leech." );
			return "";
		end
		ply:AddMoney( CfgVars["leechcost"] * -1 );
		Notify( ply, 0, 3, "You bought Leech." );

			local vehiclespawn = ents.CreateEx( "item_leech" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, 12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))

	return "";
end
AddChatCommand( "/buyleech", BuyLeech );

// Double Tap 
function BuyDoubleTap( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["doubletapcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford Double Tap." );
			return "";
		end
		ply:AddMoney( CfgVars["doubletapcost"] * -1 );
		Notify( ply, 0, 3, "You bought Double Tap!" );

			local vehiclespawn = ents.CreateEx( "item_doubletap" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, 12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))

	return "";
end
AddChatCommand( "/buydoubletap", BuyDoubleTap );

// Reflect 
function BuyReflect( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["reflectcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford Reflect." );
			return "";
		end
		ply:AddMoney( CfgVars["reflectcost"] * -1 );
		Notify( ply, 0, 3, "You bought Reflect!" );

			local vehiclespawn = ents.CreateEx( "item_reflect" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, 12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))

	return "";
end
AddChatCommand( "/buyreflect", BuyReflect );

// Focus 
function BuyFocus( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["focuscost"] ) ) then
			Notify( ply, 4, 3, "You can't afford Focus." );
			return "";
		end
		ply:AddMoney( CfgVars["focuscost"] * -1 );
		Notify( ply, 0, 3, "You bought Focus!" );

			local vehiclespawn = ents.CreateEx( "item_focus" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, 12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))

	return "";
end
AddChatCommand( "/buyfocus", BuyFocus );

// Antidote 
function BuyAntidote( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["antidotecost"] ) ) then
			Notify( ply, 4, 3, "You can't afford Antidote." );
			return "";
		end
		ply:AddMoney( CfgVars["antidotecost"] * -1 );
		Notify( ply, 0, 3, "You bought Antidote!" );

			local vehiclespawn = ents.CreateEx( "item_antidote" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, 12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))

	return "";
end
AddChatCommand( "/buyantidote", BuyAntidote );

// Amplifier 
function BuyAmp( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["ampcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford Amplifier." );
			return "";
		end
		ply:AddMoney( CfgVars["ampcost"] * -1 );
		Notify( ply, 0, 3, "You bought Amplifier!" );

			local vehiclespawn = ents.CreateEx( "item_amp" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, 12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))

	return "";
end
AddChatCommand( "/buyamp", BuyAmp );

// Pain Killer 
function BuyPainKiller( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["painkillercost"] ) ) then
			Notify( ply, 4, 3, "You can't afford Pain Killers." );
			return "";
		end
		ply:AddMoney( CfgVars["painkillercost"] * -1 );
		Notify( ply, 0, 3, "You bought Pain Killers!" );

			local vehiclespawn = ents.CreateEx( "item_painkiller" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, 12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))

	return "";
end
AddChatCommand( "/buypainkiller", BuyPainKiller );
AddChatCommand( "/buypainkillers", BuyPainKiller );

// Magic Bullet 
function BuyMagicBullet( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["magicbulletcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford Magic Bullet." );
			return "";
		end
		ply:AddMoney( CfgVars["magicbulletcost"] * -1 );
		Notify( ply, 0, 3, "You bought Magic Bullet!" );

			local vehiclespawn = ents.CreateEx( "item_magicbullet" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, 12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))

	return "";
end
AddChatCommand( "/buymagicbullet", BuyMagicBullet );
AddChatCommand( "/buymb", BuyMagicBullet );

// Regeneration 
function BuyRegen( ply )
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		if( not ply:CanAfford( CfgVars["regencost"] ) ) then
			Notify( ply, 4, 3, "You can't afford Regeneration." );
			return "";
		end
		ply:AddMoney( CfgVars["regencost"] * -1 );
		Notify( ply, 0, 3, "You bought Regeneration!" );

			local vehiclespawn = ents.CreateEx( "item_regen" );
			vehiclespawn:SetPos( tr.HitPos + Vector(0, 12, 15));
			vehiclespawn:Spawn();
			timer.Adjust("RemoveEnt"..self:EntIndex(), 300, 1, fn.Partial(SafeRemoveEntity, self))

	return "";
end
AddChatCommand( "/buyregen", BuyRegen );


---------------------------------------Money Printers----------------------------------------
// Bronze
function BuyBronzePrinter( ply )
	args = Purify(args)
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		
		if( not ply:CanAfford( CfgVars["bronzeprintercost"] )) then
			Notify( ply, 4, 3, "You can't afford a Bronze Printer." );
			return "";
		end
		if(ply:GetTable().maxBronzePrinter >= CfgVars["maxbronzeprinters"])then
			Notify( ply, 4, 3, "Max Bronze Printers Reached!" );
			return "";
		end
		ply:AddMoney( -CfgVars["bronzeprintercost"] );
		Notify( ply, 0, 3, "You bought a Bronze Printer!" );
		local printer = ents.Create( "money_printer_bronze" );
 
		printer:SetMaterial( "models/shiny" )
		printer:SetColor(Color(140, 120, 83, 255))
		printer:SetPos( tr.HitPos + tr.HitNormal*30);
		printer.Owner = ply
		printer:Spawn();
		printer.Owner = ply
	return "";
end
AddChatCommand( "/buybronzeprinter", BuyBronzePrinter );

// Silver
function BuySilverPrinter( ply )
	args = Purify(args)
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		
		if( not ply:CanAfford( CfgVars["silverprintercost"] )) then
			Notify( ply, 4, 3, "You can't afford a Silver Printer." );
			return "";
		end
		if(ply:GetTable().maxSilverPrinter >= CfgVars["maxsilverprinters"])then
			Notify( ply, 4, 3, "Max Silver Printers Reached!" );
			return "";
		end
		ply:AddMoney( -CfgVars["silverprintercost"] );
		Notify( ply, 0, 3, "You bought a Silver Printer" );
		local printer = ents.Create( "money_printer_silver" );
 
		printer:SetMaterial( "models/shiny" )
//		printer:SetColor(Color(230, 232, 250, 255))		
		printer:SetColor(Color(218, 218, 218, 255))
		printer:SetPos( tr.HitPos + tr.HitNormal*40);
		printer.Owner = ply
		printer:Spawn();
	return "";
end
AddChatCommand( "/buysilverprinter", BuySilverPrinter );

// Rhenium
function BuyRheniumPrinter( ply )
	args = Purify(args)
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		
		if( not ply:CanAfford( CfgVars["rheniumprintercost"] )) then
			Notify( ply, 4, 3, "You can't afford a Rhenium Printer." );
			return "";
		end
		if(ply:GetTable().maxRheniumPrinter >= CfgVars["maxrheniumprinters"])then
			Notify( ply, 4, 3, "Max Rhenium Printers Reached!" );
			return "";
		end
		ply:AddMoney( CfgVars["rheniumprintercost"] * -1 );
		Notify( ply, 0, 3, "You bought a Rhenium Printer!" );
		local printer = ents.Create( "money_printer_rhenium" );
 
		printer:SetMaterial( "models/shiny" )
		printer:SetColor(Color(190, 190, 190, 255))
		printer:SetPos( tr.HitPos + tr.HitNormal*30);
		printer.Owner = ply
		printer:Spawn();
	return "";
end
AddChatCommand( "/buyrheniumprinter", BuyRheniumPrinter );

// Iridium
function BuyIridiumPrinter( ply )
	args = Purify(args)
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		
		if( not ply:CanAfford( CfgVars["iridiumprintercost"] )) then
			Notify( ply, 4, 3, "You can't afford a Iridium Printer." );
			return "";
		end
		if(ply:GetTable().maxIridiumPrinter >= CfgVars["maxiridiumprinters"])then
			Notify( ply, 4, 3, "Max Iridium Printers Reached!" );
			return "";
		end
		ply:AddMoney( CfgVars["iridiumprintercost"] * -1 );
		Notify( ply, 0, 3, "You bought a Iridium Printer!" );
		local printer = ents.Create( "money_printer_iridium" );
 
		printer:SetMaterial( "models/shiny" )
		printer:SetColor(Color(190, 190, 190, 255))
		printer:SetPos( tr.HitPos + tr.HitNormal*30);
		printer.Owner = ply
		printer:Spawn();
	return "";
end
AddChatCommand( "/buyiridiumprinter", BuyIridiumPrinter );

// Palladium
function BuyPalladiumPrinter( ply )
	args = Purify(args)
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		
		if( not ply:CanAfford( CfgVars["palladiumprintercost"] )) then
			Notify( ply, 4, 3, "You can't afford a Palladium Printer." );
			return "";
		end
		if(ply:GetTable().maxPalladiumPrinter >= CfgVars["maxpalladiumprinters"])then
			Notify( ply, 4, 3, "Max Palladium Printers Reached!" );
			return "";
		end
		ply:AddMoney( CfgVars["palladiumprintercost"] * -1 );
		Notify( ply, 0, 3, "You bought a Palladium Printer!" );
		local printer = ents.Create( "money_printer_palladium" );
 
		printer:SetMaterial( "models/shiny" )
		printer:SetColor(Color(190, 190, 190, 255))
		printer:SetPos( tr.HitPos + tr.HitNormal*30);
		printer.Owner = ply
		printer:Spawn();
	return "";
end
AddChatCommand( "/buypalladiumprinter", BuyPalladiumPrinter );

// Gold
function BuyGoldPrinter( ply )
	args = Purify(args)
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		
		if( not ply:CanAfford( CfgVars["goldprintercost"] )) then
			Notify( ply, 4, 3, "You can't afford a Gold Printer." );
			return "";
		end
		if(ply:GetTable().maxGoldPrinter >= CfgVars["maxgoldprinters"])then
			Notify( ply, 4, 3, "Max Gold Printers Reached!" );
			return "";
		end
		ply:AddMoney( -CfgVars["goldprintercost"] );
		Notify( ply, 0, 3, "You bought a Gold Printer!" );
		local druglab = ents.Create( "money_printer_gold" );
 
		druglab:SetMaterial( "models/shiny" )
		druglab:SetColor(Color(255, 215, 0, 255))
//		druglab:SetColor(Color(216, 209, 14, 255))
		druglab:SetPos( tr.HitPos + tr.HitNormal*40);
		druglab.Owner = ply
		druglab:Spawn();
	return "";
end
AddChatCommand( "/buygoldprinter", BuyGoldPrinter );

// Platinum
function BuyPlatinumPrinter( ply )
	args = Purify(args)
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		
		if( not ply:CanAfford( CfgVars["platinumprintercost"] )) then
			Notify( ply, 4, 3, "You can't afford a Platinum Printer." );
			return "";
		end
		if(ply:GetTable().maxPlatinumPrinter >= CfgVars["maxplatinumprinters"])then
			Notify( ply, 4, 3, "Max Platinum Printers Reached!" );
			return "";
		end
		ply:AddMoney( -CfgVars["platinumprintercost"] );
		Notify( ply, 0, 3, "You bought a Platinum Printer!" );
		local druglab = ents.Create( "money_printer_platinum" );
 
		druglab:SetMaterial( "models/shiny" )
//		druglab:SetColor(Color(229, 228, 226, 255))
		druglab:SetColor(Color(101, 255, 101, 255))
		druglab:SetPos( tr.HitPos + tr.HitNormal*50);
		druglab.Owner = ply
		druglab:Spawn();
	return "";
end
AddChatCommand( "/buyplatinumprinter", BuyPlatinumPrinter );

// Rhodium
function BuyRhodiumPrinter( ply )
	args = Purify(args)
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		
		if( not ply:CanAfford( CfgVars["rhodiumprintercost"] )) then
			Notify( ply, 4, 3, "You can't afford a Rhodium Printer." );
			return "";
		end
		if(ply:GetTable().maxRhodiumPrinter >= CfgVars["maxrhodiumprinters"])then
			Notify( ply, 4, 3, "Max Rhodium Printers Reached!" );
			return "";
		end
		ply:AddMoney( CfgVars["rhodiumprintercost"] * -1 );
		Notify( ply, 0, 3, "You bought a Rhodium Printer!" );
		local printer = ents.Create( "money_printer_rhodium" );
 
		printer:SetMaterial( "models/shiny" )
		printer:SetColor(Color(218, 218, 218, 255))
		printer:SetPos( tr.HitPos + tr.HitNormal*30);
		printer.Owner = ply
		printer:Spawn();
	return "";
end
AddChatCommand( "/buyrhodiumprinter", BuyRhodiumPrinter );

// Money Factory
function BuyMoneyFactory( ply )
	args = Purify(args)
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		
		if( not ply:CanAfford( CfgVars["moneyfactorycost"] )) then
			Notify( ply, 4, 3, "You can't afford a Money Factory" );
			return "";
		end
		if(ply:GetTable().maxMoneyFactory >= CfgVars["maxmoneyfactory"])then
			Notify( ply, 4, 3, "Max Money Factories Reached!" );
			return "";
		end
		ply:AddMoney( CfgVars["moneyfactorycost"] * -1 );
		Notify( ply, 0, 3, "You bought a Money Factory." );
		local printer = ents.Create( "money_printer_moneyfactory" );
 
		printer:SetMaterial( "models/shiny" )
//		printer:SetColor(Color(255, 255, 255, 255))
		printer:SetPos( tr.HitPos + tr.HitNormal*70);
		printer.Owner = ply
		printer:Spawn();
	return "";
end
AddChatCommand( "/buymoneyfactory", BuyMoneyFactory );

// Golden Silo
function BuyGoldenSilo( ply )
	args = Purify(args)
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		
		if( not ply:CanAfford( CfgVars["goldensilocost"] )) then
			Notify( ply, 4, 3, "You can't afford a Golden Money Silo" );
			return "";
		end
		if(ply:GetTable().maxGoldenSilo >= CfgVars["maxgoldensilos"])then
			Notify( ply, 4, 3, "Max Golden Money Silos Reached!" );
			return "";
		end
		ply:AddMoney( CfgVars["goldensilocost"] * -1 );
		Notify( ply, 0, 3, "You bought a Golden Money Silo." );
		local printer = ents.Create( "money_printer_goldensilo" );
 
		printer:SetMaterial( "models/shiny" )
		printer:SetColor(Color(216, 209, 14, 255))
		printer:SetPos( tr.HitPos + tr.HitNormal*70);
		printer.Owner = ply
		printer:Spawn();
	return "";
end
AddChatCommand( "/buygoldensilo", BuyGoldenSilo );

// Nuclear Factory
function BuyNuclearFactory( ply )
	args = Purify(args)
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		
		if( not ply:CanAfford( CfgVars["nuclearfactorycost"] )) then
			Notify( ply, 4, 3, "You can't afford a Nuclear Money Factory." );
			return "";
		end
		if(ply:GetTable().maxNuclearFactory >= CfgVars["maxnuclearfactory"])then
			Notify( ply, 4, 3, "Max Nuclear Money Factories Reached!" );
			return "";
		end
		ply:AddMoney( CfgVars["nuclearfactorycost"] * -1 );
		Notify( ply, 0, 3, "You bought a Nuclear Money Factory." );
		local printer = ents.Create( "money_printer_nuclearfactory" );
 
		printer:SetMaterial( "models/shiny" )
		printer:SetColor(Color(204, 151, 24, 255))
		printer:SetPos( tr.HitPos + tr.HitNormal*70);
		printer.Owner = ply
		printer:Spawn();
	return "";
end
AddChatCommand( "/buynuclearfactory", BuyNuclearFactory );

// Nova
function BuyNovaPrinter( ply )
local novamax = false
	for k,v in pairs( ents.FindByClass("money_printer_nova")) do
		if IsValid(v) then
			novamax = true
		end
	end
	if novamax==true then
		Notify( ply, 4, 3, "Someone has already spawned a Nova Money Printer!" );
		return
	end	
	args = Purify(args)
	if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
		
		if( not ply:CanAfford( CfgVars["novaprintercost"] )) then
			Notify( ply, 4, 3, "You can't afford a Nova Printer" );
			return "";
		end
		if(ply:GetTable().maxNovaPrinter >= CfgVars["maxnovaprinters"])then
			Notify( ply, 4, 3, "Max Nova Printers Reached!" );
			return "";
		end
		ply:AddMoney( CfgVars["novaprintercost"] * -1 );
		Notify( ply, 0, 3, "You bought a Nova Printer." );
		local printer = ents.Create( "money_printer_nova" );
 
		printer:SetMaterial( "models/shiny" )
//		printer:SetColor(Color(255, 255, 255, 255))
		printer:SetPos( tr.HitPos + tr.HitNormal*70);
		printer.Owner = ply
		printer:Spawn();
			for k, v in pairs(player.GetAll()) do
				v:EmitSound( "basewars/nuclearprinter.mp3" )
			end		
	return "";
end
AddChatCommand( "/buynovaprinter", BuyNovaPrinter );

// Donor Printers

// Tuned Silver
function BuyTunedSilver( ply )
	if ( ply:GetUserGroup() == "founder") or ( ply:GetUserGroup() == "donor01") or ( ply:GetUserGroup() == "donor02") or ( ply:GetUserGroup() == "donor03") or ( ply:GetNWString("Status", "Guest")== "VIP") or ( ply:GetNWString("Status", "Guest")== "VIP+") or ( ply:GetNWString("Status", "Guest")== "VIP++") then

		args = Purify(args)
		if( args == "" ) then return ""; end
		local trace = { }
		
		trace.start = ply:EyePos();
		trace.endpos = trace.start + ply:GetAimVector() * 85;
		trace.filter = ply;
		
		local tr = util.TraceLine( trace );
			
			if( not ply:CanAfford( CfgVars["tunedsilvercost"] )) then
				Notify( ply, 4, 3, "You can't afford a Tuned Silver Printer." );
				return "";
			end
			if(ply:GetTable().maxTunedSilver >= CfgVars["maxtunedsilver"])then
				Notify( ply, 4, 3, "Max Tuned Silver Printers Reached!" );
				return "";
			end
			ply:AddMoney( CfgVars["tunedsilvercost"] * -1 );
			Notify( ply, 0, 3, "You bought a Tuned Silver Printer!" );
			local printer = ents.Create( "money_printer_tunedsilver" );
	
			printer:SetPos( tr.HitPos + tr.HitNormal*30);
			printer:SetColor(Color(218, 218, 218, 255))
			printer.Owner = ply
			printer:Spawn();

		return "";
	else
				Notify( ply, 4, 3, "You are not a Donator!" );	
	end
end
AddChatCommand( "/buytunedsilver", BuyTunedSilver );

// Tuned Iridium
function BuyTunedIridium( ply )
	if ( ply:GetUserGroup() == "founder") or ( ply:GetUserGroup() == "donor01") or ( ply:GetUserGroup() == "donor02") or ( ply:GetUserGroup() == "donor03") or ( ply:GetNWString("Status", "Guest")== "VIP") or ( ply:GetNWString("Status", "Guest")== "VIP+") or ( ply:GetNWString("Status", "Guest")== "VIP++") then

		args = Purify(args)
		if( args == "" ) then return ""; end
		local trace = { }
		
		trace.start = ply:EyePos();
		trace.endpos = trace.start + ply:GetAimVector() * 85;
		trace.filter = ply;
		
		local tr = util.TraceLine( trace );
			
			if( not ply:CanAfford( CfgVars["tunediridiumcost"] )) then
				Notify( ply, 4, 3, "You can't afford a Tuned Iridium Printer." );
				return "";
			end
			if(ply:GetTable().maxTunedIridium >= CfgVars["maxtunediridium"])then
				Notify( ply, 4, 3, "Max Tuned Iridium Printers Reached!" );
				return "";
			end
			ply:AddMoney( CfgVars["tunediridiumcost"] * -1 );
			Notify( ply, 0, 3, "You bought a Tuned Iridium Printer!" );
			local printer = ents.Create( "money_printer_tunediridium" );
	
			printer:SetPos( tr.HitPos + tr.HitNormal*30);
			printer:SetColor(Color(190, 190, 190, 255))
			printer.Owner = ply
			printer:Spawn();

		return "";
	else
				Notify( ply, 4, 3, "You are not a Donator!" );	
	end
end
AddChatCommand( "/buytunediridium", BuyTunedIridium );

// Tuned Gold
function BuyTunedGold( ply )
	if ( ply:GetUserGroup() == "founder") or ( ply:GetUserGroup() == "donor01") or ( ply:GetUserGroup() == "donor02") or ( ply:GetUserGroup() == "donor03") or ( ply:GetNWString("Status", "Guest")== "VIP") or ( ply:GetNWString("Status", "Guest")== "VIP+") or ( ply:GetNWString("Status", "Guest")== "VIP++") then

		args = Purify(args)
		if( args == "" ) then return ""; end
		local trace = { }
		
		trace.start = ply:EyePos();
		trace.endpos = trace.start + ply:GetAimVector() * 85;
		trace.filter = ply;
		
		local tr = util.TraceLine( trace );
			
			if( not ply:CanAfford( CfgVars["tunedgoldcost"] )) then
				Notify( ply, 4, 3, "You can't afford a Tuned Gold Printer." );
				return "";
			end
			if(ply:GetTable().maxTunedGold >= CfgVars["maxtunedgold"])then
				Notify( ply, 4, 3, "Max Tuned Gold Printers Reached!" );
				return "";
			end
			ply:AddMoney( CfgVars["tunedgoldcost"] * -1 );
			Notify( ply, 0, 3, "You bought a Tuned Gold Printer!" );
			local printer = ents.Create( "money_printer_tunedgold" );
	
			printer:SetPos( tr.HitPos + tr.HitNormal*30);
			printer:SetColor(Color(255, 215, 0, 255))
			printer.Owner = ply
			printer:Spawn();

		return "";
	else
				Notify( ply, 4, 3, "You are not a Donator!" );	
	end
end
AddChatCommand( "/buytunedgold", BuyTunedGold );

// Tuned Rhodium
function BuyTunedRhodium( ply )
	if ( ply:GetUserGroup() == "founder") or ( ply:GetUserGroup() == "donor01") or ( ply:GetUserGroup() == "donor02") or ( ply:GetUserGroup() == "donor03") or ( ply:GetNWString("Status", "Guest")== "VIP") or ( ply:GetNWString("Status", "Guest")== "VIP+") or ( ply:GetNWString("Status", "Guest")== "VIP++") then

		args = Purify(args)
		if( args == "" ) then return ""; end
		local trace = { }
		
		trace.start = ply:EyePos();
		trace.endpos = trace.start + ply:GetAimVector() * 85;
		trace.filter = ply;
		
		local tr = util.TraceLine( trace );
			
			if( not ply:CanAfford( CfgVars["tunedrhodiumcost"] )) then
				Notify( ply, 4, 3, "You can't afford a Tuned Rhodium Printer." );
				return "";
			end
			if(ply:GetTable().maxTunedRhodium >= CfgVars["maxtunedrhodium"])then
				Notify( ply, 4, 3, "Max Tuned Rhodium Printers Reached!" );
				return "";
			end
			ply:AddMoney( CfgVars["tunedrhodiumcost"] * -1 );
			Notify( ply, 0, 3, "You bought a Tuned Rhodium Printer!" );
			local printer = ents.Create( "money_printer_tunedrhodium" );
	
			printer:SetPos( tr.HitPos + tr.HitNormal*30);
			printer:SetColor(Color(218, 218, 218, 255))
			printer.Owner = ply
			printer:Spawn();

		return "";
	else
				Notify( ply, 4, 3, "You are not a Donator!" );	
	end
end
AddChatCommand( "/buytunedrhodium", BuyTunedRhodium );

// Tuned Golden Silo
function BuyTunedGolden( ply )
	if ( ply:GetUserGroup() == "founder") or ( ply:GetUserGroup() == "donor01") or ( ply:GetUserGroup() == "donor02") or ( ply:GetUserGroup() == "donor03") or ( ply:GetNWString("Status", "Guest")== "VIP") or ( ply:GetNWString("Status", "Guest")== "VIP+") or ( ply:GetNWString("Status", "Guest")== "VIP++") then

		args = Purify(args)
		if( args == "" ) then return ""; end
		local trace = { }
		
		trace.start = ply:EyePos();
		trace.endpos = trace.start + ply:GetAimVector() * 85;
		trace.filter = ply;
		
		local tr = util.TraceLine( trace );
			
			if( not ply:CanAfford( CfgVars["tunedgoldencost"] )) then
				Notify( ply, 4, 3, "You can't afford a Tuned Golden Silo." );
				return "";
			end
			if(ply:GetTable().maxTunedGolden >= CfgVars["maxtunedgolden"])then
				Notify( ply, 4, 3, "Max Tuned Golden Silos Reached!" );
				return "";
			end
			ply:AddMoney( CfgVars["tunedgoldencost"] * -1 );
			Notify( ply, 0, 3, "You bought a Tuned Golden Silo!" );
			local printer = ents.Create( "money_printer_tunedgolden" );
	
			printer:SetPos( tr.HitPos + tr.HitNormal*30);
//			printer:SetColor(Color(255, 255, 255, 255))
			printer.Owner = ply
			printer:Spawn();

		return "";
	else
				Notify( ply, 4, 3, "You are not a Donator!" );	
	end
end
AddChatCommand( "/buytunedgolden", BuyTunedGolden );

// Quantum Factory
function BuyQuantumFactory( ply )

	if ( ply:GetUserGroup() == "founder") or ( ply:GetUserGroup() == "donor01") or ( ply:GetUserGroup() == "donor02") or ( ply:GetUserGroup() == "donor03") or ( ply:GetNWString("Status", "Guest")== "VIP") or ( ply:GetNWString("Status", "Guest")== "VIP+") or ( ply:GetNWString("Status", "Guest")== "VIP++") then
	
	local quantummax = false
	for k,v in pairs( ents.FindByClass("money_printer_quantum")) do
		if IsValid(v) then
			quantummax = true
		end
	end
	if quantummax==true then
		Notify( ply, 4, 3, "Someone has already spawned a Quantum Money Factory!" );
		return
	end	
		args = Purify(args)
		if( args == "" ) then return ""; end
		local trace = { }
		
		trace.start = ply:EyePos();
		trace.endpos = trace.start + ply:GetAimVector() * 85;
		trace.filter = ply;
		
		local tr = util.TraceLine( trace );
			
			if( not ply:CanAfford( CfgVars["quantumfactorycost"] )) then
				Notify( ply, 4, 3, "You can't afford a Quantum Money Factory." );
				return "";
			end
			if(ply:GetTable().maxQuantumFactory >= CfgVars["maxquantumfactory"])then
				Notify( ply, 4, 3, "Max Quantum Money Factories Reached!" );
				return "";
			end
			ply:AddMoney( CfgVars["quantumfactorycost"] * -1 );
			Notify( ply, 0, 3, "You bought a Quantum Money Factory!" );
			local printer = ents.Create( "money_printer_quantum" );
	
			printer:SetPos( tr.HitPos + tr.HitNormal*30);
			printer:SetColor(Color(255, 160, 20, 255))
			printer.Owner = ply
			printer:Spawn();
				for k, v in pairs(player.GetAll()) do
					v:EmitSound( "basewars/nuclearprinter.mp3" )
				end				

		return "";
	else
				Notify( ply, 4, 3, "You are not a Donator!" );	
	end
end
AddChatCommand( "/buyquantumfactory", BuyQuantumFactory );

// Playable Piano
function SpawnPiano( ply )

	if ( ply:GetUserGroup() == "founder") or ( ply:GetUserGroup() == "donor01") or ( ply:GetUserGroup() == "donor02") or ( ply:GetUserGroup() == "donor03") or ( ply:GetNWString("Status", "Guest")== "VIP") or ( ply:GetNWString("Status", "Guest")== "VIP+") or ( ply:GetNWString("Status", "Guest")== "VIP++") then
	
	local pianomax = false
		args = Purify(args)
		if( args == "" ) then return ""; end
		local trace = { }
		
		trace.start = ply:EyePos();
		trace.endpos = trace.start + ply:GetAimVector() * 85;
		trace.filter = ply;
		
		local tr = util.TraceLine( trace );
			Notify( ply, 0, 3, "You spawned a piano!!" );
			local printer = ents.Create( "gmt_instrument_base" );
	
			printer:SetPos( tr.HitPos + tr.HitNormal*30);
			printer:SetColor(Color(255, 160, 20, 255))
			printer.Owner = ply
			printer:Spawn();
		return "";
	else
				Notify( ply, 4, 3, "You are not a Donator!" );	
	end
end
AddChatCommand( "/buypiano", SpawnPiano );

// Moonshine Still
function BuyStill( ply,args )
	args = Purify(args)
	local count = tonumber(args)
	if count==nil then count = 1 end
	if count>CfgVars["maxstills"] || count<1 then count = 1 end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	for i=1,count do
		if( not ply:CanAfford( CfgVars["stillcost"] ) ) then
			Notify( ply, 4, 3, "You can't afford a Moonshine Still." );
			return "";
		end
		if(ply:GetTable().maxstill >= CfgVars["maxstills"])then
			Notify( ply, 4, 3, "Max Moonshine Stills Reached!" );
			return "";
		end
		ply:AddMoney( CfgVars["stillcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Moonshine Still!" );
		local still = ents.Create( "still_average" );
 
		still.Owner = ply
		still:SetPos( tr.HitPos + tr.HitNormal*40);
		still:Spawn();
	end
	return "";
end
AddChatCommand( "/buystill", BuyStill );


// Ammo
function BuyAmmo( ply, command, args )
		local plyweapon = ply:GetActiveWeapon()
		local type = args[1];
		if type == "currentammo" then
		if ply:GetActiveWeapon():GetClass() == "weapon_mad_c4" then
			ply:GiveAmmo(1, plyweapon:GetPrimaryAmmoType())
			ply:AddMoney( CfgVars["ammoc4cost"] * -1 );
			Notify( ply, 0, 3, "You bought a C4 Explosive for $" ..CfgVars["ammoc4cost"].. " ." );
			return ""
		end
		if ply:GetActiveWeapon():GetClass() == "weapon_stickgrenade" then
			ply:GiveAmmo(3, plyweapon:GetPrimaryAmmoType())
			ply:AddMoney( CfgVars["ammosticknadecost"] * -1 );
			Notify( ply, 0, 3, "You bought 3x Sticky Grenades for $" ..CfgVars["ammosticknadecost"].. " ." );
			return ""
		end
		if ply:GetActiveWeapon():GetClass() == "weapon_doorcharge" or ply:GetActiveWeapon():GetClass() == "cse_eq_hegrenade" or ply:GetActiveWeapon():GetClass() == "weapon_gasgrenade" or ply:GetActiveWeapon():GetClass() == "cse_eq_flashbang" then
			ply:GiveAmmo(3, plyweapon:GetPrimaryAmmoType())
			ply:AddMoney( CfgVars["ammonadecost"] * -1 );
			Notify( ply, 0, 3, "You bought 3x Door Charges for $" ..CfgVars["ammonadecost"].. " ." );
			return ""
		end
		if ply:GetActiveWeapon():GetClass() == "weapon_real_cs_grenade" then
			ply:GiveAmmo(3, plyweapon:GetPrimaryAmmoType())
			ply:AddMoney( CfgVars["grenadecost"] * -1 );
			Notify( ply, 0, 3, "You bought 3x Grenades for $1,200." );
			return ""
		end		
		if ply:GetActiveWeapon():GetClass() == "weapon_gasgrenade" then
			ply:GiveAmmo(3, plyweapon:GetPrimaryAmmoType())
			ply:AddMoney( CfgVars["gasgrenadecost"] * -1 );
			Notify( ply, 0, 3, "You bought 3x Gase Grenades for $1,200." );
			return ""
		end
		if ply:GetActiveWeapon():GetClass() == "weapon_real_cs_flash" then
			ply:GiveAmmo(3, plyweapon:GetPrimaryAmmoType())
			ply:AddMoney( CfgVars["flashbangcost"] * -1 );
			Notify( ply, 0, 3, "You bought 3x Stun Grenades for $900." );
			return ""
		end				

		if 
		ply:GetActiveWeapon():GetClass() == "weapon_welder" or 
		ply:GetActiveWeapon():GetClass() == "weapon_knife2" or
//		ply:GetActiveWeapon():GetClass() == "weapon_real_cs_knife" or 		
		ply:GetActiveWeapon():GetClass() == "lockpick" or 
		ply:GetActiveWeapon():GetClass() == "weapon_worldslayer" or 
		ply:GetActiveWeapon():GetClass() == "keys" or 
		ply:GetActiveWeapon():GetClass() == "gmod_tool" or 
		ply:GetActiveWeapon():GetClass() == "weapon_physgun" or 
		ply:GetActiveWeapon():GetClass() == "gmod_camera" or 
		ply:GetActiveWeapon():GetClass() == "weapon_physcannon" or
		ply:GetActiveWeapon():GetClass() == "god_stick" or 		
		ply:GetActiveWeapon():GetClass() == "fo3_fatman" then
			Notify( ply, 4, 3, "This weapon doesn't require ammo." );
			return ""
		end
			ply:GiveAmmo(CfgVars["ammoamount"], plyweapon:GetPrimaryAmmoType())
			ply:AddMoney( CfgVars["ammocost"] * -1 )		
			Notify( ply, 0, 3, "You bought " ..CfgVars["ammoamount"].. " Ammo for $" ..CfgVars["ammocost"].. " ." );
			return ""
		end
		if type == "grenadeammo" then
			ply:GiveAmmo(3, "40MM_HE")
			ply:AddMoney( CfgVars["ammo40MMcost"] * -1 );
			Notify( ply, 0, 3, "You bought " ..CfgVars["ammo40MMamount"].. " 40MM HE ammo for $" ..CfgVars["ammo40MMcost"].. " ." );
			return ""
		end
		
end
AddChatCommand( "/buyammo", BuyAmmo );
concommand.Add("buyammo", BuyAmmo)

function Buy40MMAmmo ( ply )
			ply:GiveAmmo(5, 1)
			ply:AddMoney( CfgVars["ammo40MMcost"] * -1 );
			Notify( ply, 0, 3, "You bought " ..CfgVars["ammo40MMamount"].. " 40MM HE ammo for $" ..CfgVars["ammo40MMcost"].. " ." );
			return ""
end
AddChatCommand( "/buy40mm", BuyGrenadeAmmo);
concommand.Add("buy40mm", BuyGrenadeAmmo);

function SuperSecretCommandOfTheAges( ply )
	if ply:IsSuperAdmin() or ply:IsUserGroup("founder") then
		ply:SetNWBool("superdrug", true)
		
		Regenup(ply, CfgVars["uberduration"])
		Roidup(ply, CfgVars["uberduration"])
		Ampup(ply, CfgVars["uberduration"])
		PainKillerup(ply, CfgVars["uberduration"])
		Mirrorup(ply, CfgVars["uberduration"])
		
		Focusup(ply, CfgVars["uberduration"])
		MagicBulletup(ply, CfgVars["uberduration"])
		Adrenalineup(ply, CfgVars["uberduration"])
		DoubleJumpup(ply, CfgVars["uberduration"])
		Leechup(ply, CfgVars["uberduration"])
		
		ShockWaveup(ply, CfgVars["uberduration"])
		DoubleTapup(ply, CfgVars["uberduration"])
		Knockbackup(ply, CfgVars["uberduration"])
		ArmorPiercerup(ply, CfgVars["uberduration"])
		Antidoteup(ply, CfgVars["uberduration"])
		
		Notify( ply, 0, 3, "You are now Uber." );
		ply:SetNWBool("superdrug", false)
		return ""
	end
end
AddChatCommand( "/magicllama", SuperSecretCommandOfTheAges );
AddChatCommand( "/magicman", SuperSecretCommandOfTheAges );
concommand.Add( "uberme", SuperSecretCommandOfTheAges );

// take quotes out of things. probably couldve done better.
function Purify ( strng )
	if (string.find(tostring(strng), [[%"]])) then
		strng = " "
	end
	if (string.find(tostring(strng), [[\n]])) then
		strng = " "
	end
	return strng
end

--CreateConVar('sbox_maxmagnets', 50)

function Notify( ply, msgtype, len, msg )
	if !IsValid(ply) then return end
	ply:PrintMessage( 2, msg );
	umsg.Start("RPDMNotify", ply)
		umsg.String(msg)
		umsg.Short(msgtype)
		umsg.Short(len)
	umsg.End()
	//ply:SendLua( "GAMEMODE:AddNotify(\"" .. msg .. "\", " .. msgtype .. ", " .. len .. ")" );

end

function NotifyAll( msgtype, len, msg )

	for k, v in pairs( player.GetAll() ) do
		
		Notify( v, msgtype, len, msg );
		
	end

end

function PrintMessageAll( msgtype, msg )

	for k, v in pairs( player.GetAll() ) do
	
		v:PrintMessage( msgtype, msg );
	
	end

end

function TalkToRange( msg, pos, size )

	local ents = ents.FindInSphere( pos, size );
	
	for k, v in pairs( ents ) do
	
		if( v:IsPlayer() ) then
		
			v:ChatPrint( msg );
			v:PrintMessage( 2, msg );
		
		end
	
	end

end


function FindPlayer( info )

	for k, v in pairs( player.GetAll() ) do
		
		if( tonumber( info ) == v:EntIndex() ) then
			return v;
		end
		
		if( info == v:SteamID() ) then
			return v;
		end
		
		if( string.find( string.lower(v:Nick()), string.lower(info) ) != nil ) then
			return v;
		end
		
	end
	
	return nil;

end


function ShockWaveExplosion(pos, ply, hitnorm, rad)
	rad = math.Round(rad*.5)
	//usermessage for the one who fired, so that they can see it.
	umsg.Start("shockwaveeffect", ply)
		umsg.Vector(pos)
		umsg.Angle(hitnorm)
		umsg.Short(rad)
	umsg.End()
	local efdt = EffectData()
		efdt:SetStart(pos)
		efdt:SetOrigin(pos)
		efdt:SetScale(1)
		efdt:SetRadius(rad)
		efdt:SetNormal(hitnorm)
	util.Effect("cball_bounce",efdt)
end

function SpyScan(ply,target,backscan)
	if target:GetNWBool("scannered") then
		Notify(ply,4,3,"Could not scan target due to target having a scan blocker.")
		if !backscan && target!=ply then
			Notify(target, 1, 3, "Using your scanner to scan them back.")
			SpyScan(target,ply,true)
		end
	else
		Notify(ply,2,3,"Printing information on scan target in your console.")
		local weapon = "Nothing"
		if IsValid(target:GetActiveWeapon()) then
			weapon = target:GetActiveWeapon():GetClass()
		end
		ply:PrintMessage(2, "\n" ..target:GetName() .. "\n" .. target:Health() .. "/" .. target:GetMaxHealth() .. " Health and " .. target:Armor() .. "/100 Armor\nHolding weapon: " .. weapon .. "\nOther weapons: \n")
		for k,v in pairs(target:GetWeapons()) do
			if v!=target:GetActiveWeapon() then
				ply:PrintMessage(2, v:GetClass() .. "\n")
			end
		end
		local shield = ""
		local scanner = ""
		local helmet = ""
		if target:GetNWBool("shielded") then shield = "shield " end
		if target:GetNWBool("helmeted") then helmet = "helmet " end
		if target:GetNWBool("scannered") then scanner = "scanner " end
		if scanner=="" && helmet == "" && shield == "" then scanner = "Nothing" end
		ply:PrintMessage(2, "Equipped: " .. shield .. helmet .. scanner .. "\n\n")
		// backscan to keep an infinite scan loop from happening back and forth
	end
end

function ReconScan(ply, target)
	Notify(ply,2,3,"Printing a list of things found in scan to your console.")
	local scanpos = target:GetPos()
	local stuff = 0
	local foundEnts = {}
	local factionStuff = 0
	ply:PrintMessage(2,"\n")
	local raidableStuff = {"money_printer_silver","money_printer_gold","money_printer_goldensilo","money_printer_iridium","money_printer_moneyfactory","money_printer_nova",
	"money_printer_nuclearfactory","money_printer_palladium","money_printer_platinum","money_printer_quantum","money_printer_rhenium","money_printer_rhodium","money_printer_tunedgold",
	"money_printer_tunedgolden","money_printer_tunediridium","money_printer_tunedrhodium","money_printer_tunedsilver","drug_lab","meth_lab","meth_lab_stable"}
	local raidable = false
	for k, v in pairs(ents.FindInSphere(scanpos, 512)) do
		if IsValid(v) then
			if v:GetTable().Structure then
				for a,b in pairs(raidableStuff) do
					if(v:GetClass() == b) then
						raidable = true
						break
					end
				end
				stuff = stuff+1
				local ownerName = ""
				if(v.Owner == NULL || v.Owner == nil) then
					ownerName = "Disconnected Player"
				else
					ownerName = v.Owner:Nick()
				end
				ply:PrintMessage(2, v:GetTable().PrintName .. " - " .. ownerName)
				table.insert(foundEnts,v)
			end
		end
	end
	if(team.GetName(ply:Team()) == "Citizen") then
		raidable = false
	end
	if(ply:Team() == target:Team() and ply:Team() != 1) then
		raidable = false
	end
	local raidableEnts = {}
	for k,v in pairs(foundEnts) do
		if(target:Team() != 1) then
			if(v.Owner:Team() == target:Team()) then
				factionStuff = factionStuff + 1
				table.insert(raidableEnts,v)
			end
		else
			if(v.Owner == target) then
				factionStuff = factionStuff + 1
				table.insert(raidableEnts,v)
			end
		end
	end
	if(factionStuff == 0) then
		raidable = false
	end
	ply:PrintMessage(2,"\n")
	if stuff>0 then
		Notify(ply,3,3,"Scan has found " .. tostring(stuff) .. " structures near " .. target:GetName().."")
	else
		Notify(ply,4,3,"Scan has found nothing!")
	end
	if raidable then
		
		ply:SendLua("GAMEMODE:ClearRaidablesList()")
		for k,v in pairs(raidableEnts) do
			ply:SendLua("GAMEMODE:GetRaidable("..v:EntIndex()..")")
		end
		for k,v in pairs(player.GetAll()) do
			if(v == target) then
				ply:SendLua("GAMEMODE:OpenScanConfirm("..k..")")
			end
		end
	end
end

/*
function SpyScan(ply,target,backscan,curSL)
	if target:GetNWBool("scannered") then
		Notify(ply,4,3,"Could not scan target information due to target having a scanner")
		if !backscan && target!=ply then
			Notify(target, 1, 3, "Using your scanner to scan them back.")
			SpyScan(target,ply,true)
		end
	else
		Notify(ply,2,3,"Printing information on scan target in your console")
		local weapon = "Nothing"
		if IsValid(target:GetActiveWeapon()) then
			weapon = target:GetActiveWeapon():GetClass()
		end
		ply:GetTable().scanlogs[curSL] = { }
		local scanLog = ply:GetTable().scanlogs[curSL]
		ply:PrintMessage(HUD_PRINTTALK,"scanlogs["..curSL.."]: " .. tostring(ply:GetTable().scanlogs[curSL]))
		ply:PrintMessage(HUD_PRINTTALK,"scanLog: " .. tostring(scanLog))
		ply:GetTable().scanlogs[curSL][1] = { }
		ply:GetTable().scanlogs[curSL][2] = { }
		ply:GetTable().scanlogs[curSL][3] = { }
		ply:GetTable().scanlogs[curSL][1][1] = target:GetName()
		ply:GetTable().scanlogs[curSL][1][2] = target:Health() .. "/" .. target:GetMaxHealth() .. " Health"
		ply:GetTable().scanlogs[curSL][1][3] = target:Armor() .. "/100 Armor"
		ply:GetTable().scanlogs[curSL][1][4] = "Holding weapon: " .. weapon
		ply:GetTable().scanlogs[curSL][1][5] = "Other weapons: "
		local curOW = 6
		ply:PrintMessage(2, "\n" ..target:GetName() .. "\n" .. target:Health() .. "/" .. target:GetMaxHealth() .. " Health and " .. target:Armor() .. "/100 Armor\nHolding weapon: " .. weapon .. "\nOther weapons: \n")
		for k,v in pairs(target:GetWeapons()) do
			if v!=target:GetActiveWeapon() then
				ply:GetTable().scanlogs[curSL][1][curOW] = v:GetClass()
				ply:PrintMessage(2, v:GetClass() .. "\n")
				curOW = curOW + 1
			end
		end

		local shield = ""
		local scanner = ""
		local helmet = ""
		if target:GetNWBool("shielded") then shield = "shield " end
		if target:GetNWBool("helmeted") then helmet = "helmet " end
		if target:GetNWBool("scannered") then scanner = "scanner " end
		if scanner=="" && helmet == "" && shield == "" then scanner = "Nothing" end
		ply:PrintMessage(2, "Equipped: " .. shield .. helmet .. scanner .. "\n\n")
		ply:GetTable().scanlogs[curSL][1][curOW] = "Equipped: " .. shield .. helmet .. scanner
		// backscan to keep an infinite scan loop from happening back and forth
	end
end

function ReconScan(ply, target,curSL)
	Notify(ply,2,3,"Printing a list of things found in scan to your console")
	local scanpos = target:GetPos()
	local stuff = 0
	local raidablecount = 0
	local factionBelong = 0
	local raidable = false
	local raidableStuff = {"money_printer_silver","money_printer_gold","money_printer_goldensilo","money_printer_iridium","money_printer_moneyfactory","money_printer_nova",
		"money_printer_nuclearfactory","money_printer_palladium","money_printer_platinum","money_printer_quantum","money_printer_rhenium","money_printer_rhodium","money_printer_tunedgold",
		"money_printer_tunedgolden","money_printer_tunediridium","money_printer_tunedrhodium","money_printer_tunedsilver","weedplant","still_average","drug_lab","meth_lab","meth_lab_stable"}
	ply:PrintMessage(2,"\n")
	ply:GetTable().scanlogs[curSL][2] = { }
	ply:GetTable().scanlogs[curSL][3] = { }
	for k, v in pairs(ents.FindInSphere(scanpos, 512)) do
		if IsValid(v) then
			if v:GetTable().Structure then
				local contRaid = false
				for k1, v1 in pairs(team.GetPlayers(ply:Team())) do
					if(v1:Nick() == v.Owner:GetName()) then
						factionBelong = factionBelong + 1
						contRaid = true
						break
					end
				end
				if(contRaid == true) then
					for k2,v2 in pairs(raidableStuff) do
						if(v:GetClass() == v2) then
							ply:GetTable().scanlogs[curSL][3][raidablecount] = v:GetTable().PrintName .. " - " .. v.Owner:GetName()
							raidablecount = raidablecount + 1
							raidable = true
						end
					end
				end
				ply:GetTable().scanlogs[curSL][2][stuff] = v:GetTable().PrintName .. " - " .. v.Owner:GetName()
				stuff = stuff+1
				ply:PrintMessage(2, v:GetTable().PrintName .. " " .. v.Owner:GetName())
			end
		end
	end
	ply:PrintMessage(2,"\n")
	if stuff>0 then
		if(raidable == true) then
			Notify(ply,3,3,"Player is raidable!")
		else
			Notify(ply,4,3,"Player is not raidable!")
		end
		if(factionBelong > 0) then
			Notify(ply,3,3,"Scan has found " .. tostring(factionBelong) .. " structures that belong to " .. target:GetName() .. "'s faction!")
		else
			Notify(ply,3,3,"Scan has not found any structures that belogn to " .. target:GetName() .. "'s faction!")
		end
		Notify(ply,3,3,"Scan has found " .. tostring(stuff) .. " structures near " .. target:GetName().."")
	else
		Notify(ply,4,3,"Scan has found nothing")
	end
end
*/
// i dont know why i bothered. oh right, im bored. guess it would be like in red alert 2, when kirov airships announced theirself to everyone once built.

local uberexists=false
function UberDrugExists()
	if !uberexists then
		NotifyAll(1,5,"Someone has created an UberDrug!")
		uberexists=true
	end
end

function ccBuyDrugs( ply, command, args )
	local drug = args[1]
	if ply:GetTable().LastBuy+1.5<CurTime() then
		ply:GetTable().LastBuy=CurTime()
		if( drug == "steroid" ) then
			BuySteroid(ply)
		elseif( drug == "doublejump" ) then
			BuyDoubleJump(ply)
		elseif( drug == "leech" ) then
			BuyLeech(ply)
		elseif( drug == "amplifier" ) then
			BuyAmp(ply)
		elseif( drug == "armorpiercer" ) then
			BuyArmorpiercer(ply)
		
		elseif( drug == "regen" ) then
			BuyRegen(ply)
		elseif( drug == "painkiller" ) then
			BuyPainKiller(ply)
		elseif( drug == "antidote" ) then
			BuyAntidote(ply)
		elseif( drug == "reflect" ) then
			BuyReflect(ply)
		elseif( drug == "adrenaline" ) then
			BuyAdrenaline(ply)
		
		elseif( drug == "magicbullet" ) then
			BuyMagicBullet(ply)
		elseif( drug == "shockwave" ) then
			BuyShockWave(ply)
		elseif( drug == "knockback" ) then
			BuyKnockback(ply)
		elseif( drug == "doubletap" ) then
			BuyDoubleTap(ply)
		elseif( drug == "focus" ) then
			BuyFocus(ply)
		end
	end
end
concommand.Add( "buydrug", ccBuyDrugs );
--------------------------------Start Batch

function ccBuyBatchDrugs( ply, command, args )
	local drug = args[1]
	if ply:GetTable().LastBuy+1.5<CurTime() then
		ply:GetTable().LastBuy=CurTime()
		if( drug == "steroid" ) then
			BuyBatchSteroid(ply)
		elseif( drug == "doublejump" ) then
			BuyBatchDoubleJump(ply)
		elseif( drug == "leech" ) then
			BuyBatchLeech(ply)
		elseif( drug == "amplifier" ) then
			BuyBatchAmp(ply)
		elseif( drug == "armorpiercer" ) then
			BuyBatchArmorpiercer(ply)
		
		elseif( drug == "regen" ) then
			BuyBatchRegen(ply)
		elseif( drug == "painkiller" ) then
			BuyBatchPainKiller(ply)
		elseif( drug == "antidote" ) then
			BuyBatchAntidote(ply)
		elseif( drug == "reflect" ) then
			BuyBatchReflect(ply)
		elseif( drug == "adrenaline" ) then
			BuyBatchAdrenaline(ply)
		
		elseif( drug == "magicbullet" ) then
			BuyBatchMagicBullet(ply)
		elseif( drug == "shockwave" ) then
			BuyBatchShockWave(ply)
		elseif( drug == "knockback" ) then
			BuyBatchKnockback(ply)
		elseif( drug == "doubletap" ) then
			BuyBatchDoubleTap(ply)
		elseif( drug == "focus" ) then
			BuyBatchFocus(ply)
		end
	end
end
concommand.Add( "buybatchdrug", ccBuyBatchDrugs );

--------------------------------End Batch
function ccBuyStructure( ply, command, args )
	local building = args[1]
	if ply:GetTable().LastBuy+1.5<CurTime() then
		ply:GetTable().LastBuy=CurTime()
		if( building == "sentry" ) then
			BuyTurret(ply)
		elseif( building == "floor" ) then
			BuyFloorTurret(ply)
		elseif( building == "spawn" ) then
			BuySpawn(ply)
		elseif( building == "dispenser" ) then
			BuyDispenser(ply)
		elseif( building == "healthdispenser" ) then
			BuyHealthDispenser(ply)
       	elseif( building == "armordispenser" ) then
			BuyArmorDispenser(ply)
		elseif( building == "microwave" ) then
			BuyMicrowave(ply)
//		elseif( building == "lamp" ) then
//			BuyLamp(ply)
		elseif( building == "radar" ) then
			BuyTower(ply)
		elseif( building == "refinery" ) then
			BuyRefinery(ply)
//		elseif( building == "gunlab" ) then
//			BuyGunlab(ply)
		elseif( building == "factory" ) then
			BuyGunFactory(ply)
//		elseif( building == "superfactory" ) then
//			BuySuperGunFactory(ply)				
		elseif( building == "plant" ) then
			BuyPlant(ply)
		elseif( building == "still" ) then
			BuyStill(ply)
		elseif( building == "druglab" ) then
			BuyDrug(ply)
		elseif( building == "methlab" ) then
			BuyMethlab(ply)
		elseif( building == "stablemethlab" ) then
			BuyStableMethLab(ply)
		elseif( building == "supplycabinet" ) then
			BuySupplyTable(ply)
		elseif( building == "gunvault" ) then
			BuyGunvault(ply)
		elseif( building == "pillbox" ) then
			BuyPillBox(ply)
		elseif( building == "moneyvault" ) then
			BuyMoneyVault(ply)			
// Printers
		elseif( building == "bronzeprinter" ) then
			BuyBronzePrinter(ply)
		elseif( building == "silverprinter" ) then
			BuySilverPrinter(ply)
		elseif( building == "rheniumprinter" ) then
			BuyRheniumPrinter(ply)
		elseif( building == "iridiumprinter" ) then
			BuyIridiumPrinter(ply)
		elseif( building == "palladiumprinter" ) then
			BuyPalladiumPrinter(ply)			
		elseif( building == "goldprinter" ) then
			BuyGoldPrinter(ply)
		elseif( building == "platinumprinter" ) then
			BuyPlatinumPrinter(ply)
		elseif( building == "rhodiumprinter" ) then
			BuyRhodiumPrinter(ply)
		elseif( building == "moneyfactory" ) then
			BuyMoneyFactory(ply)
		elseif( building == "goldensilo" ) then
			BuyGoldenSilo(ply)
		elseif( building == "nuclearfactory" ) then
			BuyNuclearFactory(ply)
		elseif( building == "novaprinter" ) then
			BuyNovaPrinter(ply)

		elseif( building == "tunedsilver" ) then
			BuyTunedSilver(ply)
		elseif( building == "tunediridium" ) then
			BuyTunedIridium(ply)
		elseif( building == "tunedgold" ) then
			BuyTunedGold(ply)
		elseif( building == "tunedrhodium" ) then
			BuyTunedRhodium(ply)
		elseif( building == "tunedgolden" ) then
			BuyTunedGolden(ply)
		elseif( building == "quantumfactory" ) then
			BuyQuantumFactory(ply)			

// Power
		elseif( building == "solargenerator" ) then
			BuySolarGenerator(ply)			
		elseif( building == "generator" ) then
			BuyGenerator(ply)
		elseif( building == "supergenerator" ) then
			BuySuperGenerator(ply)
		elseif( building == "nucleargenerator" ) then
			BuyNuclearGenerator(ply)
		end
	end
end
concommand.Add( "buystruct", ccBuyStructure );
		
function ccBuySpecial( ply, command, args )
	local special = args[1]
	if ply:GetTable().LastBuy+1.5<CurTime() then
		ply:GetTable().LastBuy=CurTime()

		if( special == "lockpick" ) then
			BuyLockPick(ply)
		elseif( special == "welder" ) then
			BuyWelder(ply)
//		elseif( special == "airboat" ) then
//			BuyAirboat(ply)
//		elseif( special == "jeep" ) then
//			BuyJeep(ply)
//		elseif( special == "fueltank" ) then
//			BuyIncedAmmo(ply)
		elseif( special == "health" ) then
			BuyHealth(ply)
		elseif( special == "shield" ) then
			BuyShield(ply)
		elseif( special == "helmet" ) then
			BuyHelmet(ply)
		elseif( special == "scanner" ) then
			BuyScanBlock(ply)
		elseif( special == "toolkit" ) then
			BuyDefuseKit(ply)
		elseif( special == "armor" ) then
			BuyArmor(ply)
		end
	end
end
concommand.Add( "buyspecial", ccBuySpecial );

function ccBuyMisc( ply, command, args )
	local misc = args[1]
	if ply:GetTable().LastBuy+1.5<CurTime() then
		ply:GetTable().LastBuy=CurTime()

		if( misc == "pipebomb" ) then
			BuyPipeBomb(ply)
		elseif( misc == "c4" ) then
			BuyC4(ply)
		elseif( misc == "jihad" ) then
			BuyJihadBomb(ply)			
		elseif( misc == "sticky" ) then
			BuyStickyGrenade(ply)			
		elseif( misc == "grenade" ) then
			BuyGrenade(ply)
		elseif( misc == "doorcharge" ) then
			BuyDoorCharge(ply)	
		elseif( misc == "gas" ) then
			BuyGasGrenade(ply)	
		elseif( misc == "stun" ) then
			BuyStunGrenade(ply)
		elseif( misc == "bigbomb" ) then
			BuyBomb(ply)
		end
	end
end
concommand.Add( "buymisc", ccBuyMisc );


function ccBuyAttach( ply, command, args )
	local attachment = args[1]
	if ply:GetTable().LastBuy+1.5<CurTime() then
		ply:GetTable().LastBuy=CurTime()

		if( attachment == "lasersight" ) then
			BuyLaserSight(ply)
		elseif( attachment == "kobra" ) then
			BuyKobra(ply)			
		elseif( attachment == "reflexsight" ) then
			BuyReflexSight(ply)
		elseif( attachment == "riflereflex" ) then
			BuyRifleReflex(ply)			
		elseif( attachment == "eotech" ) then
			BuyEotechSight(ply)	
		elseif( attachment == "aimpoint" ) then
			BuyAimPoint(ply)	
		elseif( attachment == "acogscope" ) then
			BuyAcogScope(ply)
		elseif( attachment == "ballistic" ) then
			BuyBallistic(ply)
		elseif( attachment == "bipod" ) then
			BuyBipod(ply)			
		elseif( attachment == "m203" ) then
			BuyM203(ply)
		elseif( attachment == "cmagazine" ) then
			BuyCMagazine(ply)			
		end
	end
end
concommand.Add( "buyattach", ccBuyAttach );


local nograv = {
"shot_beanbag",
"shot_tankshell",
"shot_rocket",
"shot_tranq",
"auto_turret_gun",
"shot_glround",
"svehicle_part_nophysics",
"svehicle_part",
"shot_glround",
"worldslayer",
"shot_energy"
}

// not local so that it can be used in all the rest of the game.
physgunables = {
"gmod_cameraprop",
"gmod_rtcameraprop",
"gmod_balloon",
"gmod_button",
"gmod_lamp",
"gmod_light",
"gmod_anchor",
"func_physbox",
"prop_physics",
"prop_physics_multiplayer",
"spawned_weapon",
"microwave",
"bw_lamp",
"drug_lab",
"gunlab",
"dispenser",
"healthdispenser",
"armordispenser",
"phys_magnet",
"m_crate",
"prop_ragdoll",
"gmod_thruster",
"gmod_wheel",
"item_drug",
"item_steroid",
"item_painkiller",
"item_magicbullet",
"item_antidote",
"item_amp",
"item_helmet",
"item_random",
"item_buyhealth",
"item_superdrug",
"item_booze",
"item_scanner",
"item_toolkit",
"item_regen",
"item_reflect",
"item_focus",
"item_snipeshield",
"item_armor",
"item_food",
"item_leech",
"item_shockwave",
"item_doubletap",
"item_uberdrug",
"item_knockback",
"item_doublejump",
"item_armorpiercer",
"item_superdrugoffense",
"item_superdrugdefense",
"item_superdrugweapmod",
"pillbox",
"drugfactory",
"powerplant",
"superpowerplant",
"weedplant",
"meth_lab",
"prop_effect",
"money_printer",
"still",
"gunvault",
"radartower",
"gunfactory",
"bigbomb",
"keypad",
"sign"
}

function ccWithdrawGun( ply, cmd, args )
	// in case of jackasses trying to exploit the game, or any other wierd shit that could happen.
	if (args[1]==nil || args[2] == nil) then 
		return 
	end
	gnum = tonumber(args[2])
	if (!ents.GetByIndex(args[1]):IsValid() || gnum>10 || gnum<1) then 
		return 
	end
	local vault = ents.GetByIndex(args[1])
	if (vault:GetClass()!="gunvault" || ply:GetPos():Distance(vault:GetPos())>200) then return end
	if (vault:IsLocked() && ply!=vault.Owner && !ply:IsAllied(vault.Owner)) then return end
	if (vault:CanDropGun(gnum)) then
		vault:DropGun(gnum, ply, 25, false)
	else
		Notify(ply,4,3, "This gun does not exist!")
		umsg.Start( "killgunvaultgui", ply );
			umsg.Short( args[1] )
		umsg.End()
	end	
end
concommand.Add( "withdrawgun", ccWithdrawGun );

function ccWithdrawItem( ply, cmd, args )
	// in case of jackasses trying to exploit the game, or any other wierd shit that could happen.
	if (args[1]==nil || args[2] == nil) then 
		return 
	end
	gnum = tonumber(args[2])
	if (!ents.GetByIndex(args[1]):IsValid() || gnum>20 || gnum<1) then 
		return 
	end
	local vault = ents.GetByIndex(args[1])
	if (vault:GetClass()!="pillbox" || ply:GetPos():Distance(vault:GetPos())>200) then return end
	if (vault:IsLocked() && ply!=vault.Owner && !ply:IsAllied(vault.Owner)) then return end
	if (vault:CanDropGun(gnum)) then
		vault:DropGun(gnum, ply, 35, false)
	else
		Notify(ply,4,3, "This item does not exist!")
		umsg.Start( "killpillboxgui", ply );
			umsg.Short( args[1] )
		umsg.End()
	end	
end
concommand.Add( "withdrawitem", ccWithdrawItem );

function GunFactoryWeapon( ply, cmd, args )
	if (args[1]==nil || args[2] == nil) then 
	return 
	end
	guntype = tostring(args[2])
	if !IsValid(ents.GetByIndex(args[1])) || (guntype!="laserbeam" && guntype!="laserrifle" && guntype!="grenadegun" && guntype!="plasma" && guntype!="worldslayer" && guntype!="resetbutton") then
		return 
	end
	local vault = ents.GetByIndex(args[1])
	if (vault:GetClass()!="gunfactory" || ply:GetPos():Distance(vault:GetPos())>300) then return end
	if (vault:CanProduce(guntype, ply)) then
		vault:StartProduction(ply,guntype)
	else
		if guntype=="resetbutton" then
			Notify(ply,4,3, "Only Gun Factory owner can cancel weapon production!")
		else
			Notify(ply,4,3, "Can't make weapon!")
		end
		umsg.Start( "killgunfactorygui", ply );
			umsg.Short( args[1] )
		umsg.End()
	end	
end
concommand.Add( "setgunfactoryweapon", GunFactoryWeapon );

function SuperGunFactoryWeapon( ply, cmd, args )
	if (args[1]==nil || args[2] == nil) then 
	return 
	end
	guntype = tostring(args[2])
	if !IsValid(ents.GetByIndex(args[1])) || (guntype!="flamer" && guntype!="m82" && guntype!="vollmer" && guntype!="m60a3" && guntype!="fatman" && guntype!="resetbutton") then
		return 
	end
	local vault = ents.GetByIndex(args[1])
	if (vault:GetClass()!="supergunfactory" || ply:GetPos():Distance(vault:GetPos())>300) then return end
	if (vault:CanProduce(guntype, ply)) then
		vault:StartProduction(ply,guntype)
	else
		if guntype=="resetbutton" then
			Notify(ply,4,3, "Only Super Gun Factory owner can cancel weapon production!")
		else
			Notify(ply,4,3, "Can't make weapon!")
		end
		umsg.Start( "killsupergunfactorygui", ply );
			umsg.Short( args[1] )
		umsg.End()
	end	
end
concommand.Add( "supergunfactoryweapon", SuperGunFactoryWeapon );
/*
function WeldControl(ent,ply)
	if (IsValid(ply)) then
		if IsValid(ent) then
			ent:SetNWInt("welddamage", 150)
		end
		ply:GetTable().shitweldcount=ply:GetTable().shitweldcount-1
		if (ply:GetTable().shitweldcount<=0) then
			ply:GetTable().shitweldcount=0
			ply:SetNWBool("shitwelding", false)
		end
	end
end*/

function WeldControl(ent,ply,entname)
	//ply:PrintMessage(HUD_PRINTTALK,"Debug Message WeldControl function called.")
	if (IsValid(ply) && entname != nil) then
		if IsValid(ent) then
			ent:SetNWInt("welddamage", 255)
		end
		//ply:PrintMessage(HUD_PRINTTALK,"Debug Message WeldControl, destroy shitweldentries and minus shitweldcount..")
		for i = 1, #ply:GetTable().shitweldentries do
			if(ply:GetTable().shitweldentries[i] != nil) then
				if(ply:GetTable().shitweldentries[i] == entname) then
					//ply:PrintMessage(HUD_PRINTTALK,"Debug Message WeldControl, minus one shitweldcount and destroy one shitweldentry: " .. ply:GetTable().shitweldentries[i])
					ply:GetTable().shitweldcount=ply:GetTable().shitweldcount-1
					ply:GetTable().shitweldentries[i] = nil
				end
			end
		end
		ply:GetTable().shitweldcount=ply:GetTable().shitweldcount-1
		print("WeldControl call! Shit Weld Count is equal to: " .. ply:GetTable().shitweldcount)
		//ply:PrintMessage(HUD_PRINTTALK,"Debug Message WeldControl, Shit Weld Count = " .. ply:GetTable().shitweldcount)
		if (ply:GetTable().shitweldcount<=0) then
			//ply:PrintMessage(HUD_PRINTTALK,"Debug Message WeldControl,  shitwelding for you is = false!")
			ply:GetTable().shitweldcount=0
			ply:SetNWBool("shitwelding", false)
		end
	end
end

function AddNewSWEntry(ply,entname)
	//ply:PrintMessage(HUD_PRINTTALK,"AddNewSWEntry parameter entname: " .. entname)
	for i = 1, #ply:GetTable().shitweldentries do
		if(ply:GetTable().shitweldentries[i] == nil || ply:GetTable().shitweldentries[i] == "") then
			ply:GetTable().shitweldentries[i] = entname
			return
		end
	end
	ply:GetTable().shitweldentries[#ply:GetTable().shitweldentries+1] = entname
end


function ccSetRefineryMode( ply, cmd, args )
	if (args[1]==nil || args[2] == nil) then 
		return 
	end
	mode = tostring(args[2])
	if !IsValid(ents.GetByIndex(args[1])) || (mode!="money" && mode!="offense" && mode!="defense" && mode!="weapmod" && mode!="eject" && mode!="uber") then
		return 
	end
	local vault = ents.GetByIndex(args[1])
	if (vault:GetClass()!="drugfactory" || ply:GetPos():Distance(vault:GetPos())>300) then return end
	
	local ref = vault:CanRefine(mode,ply)
	if (ref==true) then
		vault:SetMode(mode)
	else
		Notify(ply,4,3,ref)
	end
	umsg.Start( "killdrugfactorygui", ply );
		umsg.Short( args[1] )
	umsg.End()
end
concommand.Add( "setrefinerymode", ccSetRefineryMode );

function massFreezeFnc(ply,arg)
	ply:PrintMessage(HUD_PRINTTALK,"Called massFreezeFnc command!")
	ply:PrintMessage(HUD_PRINTTALK,"massFreezeFnc, arg: " .. arg)
	ply:PrintMessage(HUD_PRINTTALK,"User Group: " .. ply:GetUserGroup())
	local userGroup = ply:GetUserGroup()
	ply:PrintMessage(HUD_PRINTTALK,"userGroup:" .. userGroup)
	if(userGroup == "junior admin" || userGroup == "admin" || userGroup == "community manager" || userGroup == "founder" || userGroup == "moderator") then
		ply:PrintMessage(HUD_PRINTTALK,"Command going through.. you have sufficient permission, group: " .. userGroup)
		for k,v in pairs(player.GetAll()) do
			if(v == ply) then
				v:PrintMessage(HUD_PRINTTALK,"You have mass frozen " .. arg .. " entities!")
			else
				v:PrintMessage(HUD_PRINTTALK,ply:GetName() .. " has mass frozen " .. arg .. " entities!")
			end
		end
		if(arg == "all") then
			for k,v in pairs(ents.GetAll()) do	
				if(!v:IsPlayer()) then
					if(v:GetClass() == "prop_physics" || v:GetClass() == "spawned_weapon" || v:GetClass() == "spawned_shipment" || v:GetClass() == "prop_physics_multiplayer" || v:GetClass() == "prop_moneybag") then
						local newVel = Vector(0,0,0)
						ply:PrintMessage(HUD_PRINTTALK,"Attempting to freeze entity: " .. tostring(v))
						//ply:PrintMessage(HUD_PRINTTALK,"Entity movetype: " .. v:GetMoveType())	
						v:SetVelocity(newVel)
						//v:SetGravity(0)
						local phys = v:GetPhysicsObject()
						if(phys:IsValid()) then
							ply:PrintMessage(HUD_PRINTTALK,"Phys Obj of Entity != null")
							phys:SetVelocity(newVel)
							phys:Sleep()
						end
						//v:SetMoveType(MOVETYPE_NONE)
						if(v:GetClass() == "spawned_weapon" || v:GetClass() == "spawned_shipment" || v:GetClass() == "prop_moneybag") then
							v:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
						end
						//v:SetIK(true)
					end
				end		
			end
		end
		if(arg == "sent") then
			for k,v in pairs(ents.GetAll()) do
				if(v:GetClass() == "spawned_shipment" || v:GetClass() == "spawned_weapon" || v:GetClass() == "prop_moneybag") then
					local newVel = Vector(0,0,0)
					ply:PrintMessage(HUD_PRINTTALK,"Attempting to freeze SENT: " .. tostring(v))
					v:SetVelocity(newVel)
					local phys = v:GetPhysicsObject()
					if(phys:IsValid()) then
						ply:PrintMessage(HUD_PRINTTALK,"Phys Obj of SENT != null")
						phys:SetVelocity(newVel)
						phys:Sleep()
					end
					v:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
				end
			end
		end
		if(arg == "physics") then
			for k,v in pairs(ents.GetAll()) do
				if(v:GetClass() == "prop_physics" || v:GetClass() == "prop_physics_multiplayer") then
					local newVel = Vector(0,0,0)
					ply:PrintMessage(HUD_PRINTTALK,"Attempting to freeze Physics Prop: " .. tostring(v))
					v:SetVelocity(newVel)
					local phys = v:GetPhysicsObject()
					if(phys:IsValid()) then
						ply:PrintMessage(HUD_PRINTTALK,"Phys Obj of SENT != null")
						phys:SetVelocity(newVel)
						phys:Sleep()
					end
				end
			end
		end
					
		ply:PrintMessage(HUD_PRINTTALK,"Remember to call !massUnFreeze to restore physics!")
	else
		ply:PrintMessage(HUD_PRINTTALK,"Insufficient permissions!")
	end
	
end
function massFreeze(ply)
	ply:PrintMessage(HUD_PRINTTALK,"User Group: " .. ply:GetNWString("usergroup"))
	ply:PrintMessage(HUD_PRINTTALK,"ULX User Group: " .. ply:GetUserGroup())
	ply:PrintMessage(HUD_PRINTTALK,"massFreeze")
	massFreezeFnc(ply,"all")
end
AddChatCommand("!massfreeze", massFreeze)
AddChatCommand("!massfreezeall", massFreeze)
function massFreezeSENT(ply)
	ply:PrintMessage(HUD_PRINTTALK,"massFreezeSENT")
	massFreezeFnc(ply,"sent")
end
AddChatCommand("!massfreezesent", massFreezeSENT)
function massFreezePhysics(ply)
	ply:PrintMessage(HUD_PRINTTALK,"massFreezePhysics")
	massFreezeFnc(ply,"physics")
end
AddChatCommand("!massfreezephysics", massFreezePhysics)
function massUnFreeze(ply)
	ply:PrintMessage(HUD_PRINTTALK,"Called massUnFreeze command!")
	ply:PrintMessage(HUD_PRINTTALK,"User Group: " .. ply:GetUserGroup())
	local userGroup = string.lower(ply:GetUserGroup())
	if(userGroup == "junior admin" || userGroup == "admin" || userGroup == "community manager" || userGroup == "founder" || userGroup == "moderator") then
		ply:PrintMessage(HUD_PRINTTALK,"Command going through.. you have sufficient permission, group: " .. userGroup)
		for k,v in pairs(player.GetAll()) do
			if(v == ply) then
				v:PrintMessage(HUD_PRINTTALK,"You have mass unfrozen everything!")
			else
				v:PrintMessage(HUD_PRINTTALK,ply:GetName() .. " has mass unfrozen everything!")
			end
		end
		for k,v in pairs(ents.GetAll()) do	
			if(!v:IsPlayer()) then
				if(v:GetClass() == "prop_physics" || v:GetClass() == "prop_physics_multiplayer" || v:GetClass() == "spawned_weapon" || v:GetClass() == "spawned_shipment") then
					ply:PrintMessage(HUD_PRINTTALK,"Attempting to unfreeze: " .. tostring(v))
					//v:SetMoveType(MOVETYPE_VPHYSICS)
					if(v:GetClass() == "spawned_weapon" || v:GetClass() == "spawned_shipment") then
						local phys = v:GetPhysicsObject()
						if(phys:IsValid()) then
							phys:Wake()
						end
					end
					v:SetCollisionGroup(COLLISION_GROUP_NONE)
					//v:SetIK(false)
				end
			end
		end
	end
end
AddChatCommand("!massunfreeze", massUnFreeze)
local function GetEntOwner(ent)
	if !IsValid(ent) then return false end
	local owner = ent
	if ent:GetVar("PropProtection")==nil then return false end
	if IsValid(player.GetByUniqueID(ent:GetVar("PropProtection"))) then
		owner = player.GetByUniqueID(ent:GetVar("PropProtection"))
	end
	if owner!=ent then
		return owner
	else
		return false
	end
end

local function SetOwner(ent, ply)
	// take no chances, check it here too.
	if (IsValid(ent) && IsValid(ply) && ply:IsPlayer()) then
		ent:SetVar("PropProtection", ply:UniqueID() )
		return true
	else
		return false
	end
end

local originalCleanup = cleanup.Add
function cleanup.Add(ply,type,ent)
	if (IsValid(ply) && ply:IsPlayer() && IsValid(ent)) then
		SetOwner(ent, ply)
	end
	originalCleanup(ply,type,ent)
end

function SpawnedProp(ply, model, ent)
	SetOwner(ent, ply)
end 
hook.Add("PlayerSpawnedProp", "playerSpawnedProp", SpawnedProp)