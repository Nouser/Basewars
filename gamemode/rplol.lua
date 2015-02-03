function DrugPlayer(pl)
	pl:ConCommand("pp_motionblur 1")  
	pl:ConCommand("pp_motionblur_addalpha 0.05")  
	pl:ConCommand("pp_motionblur_delay 0.035")  
	pl:ConCommand("pp_motionblur_drawalpha 0.75")  
	pl:ConCommand("pp_dof 1")  
	pl:ConCommand("pp_dof_initlength 9")  
	pl:ConCommand("pp_dof_spacing 100") 

	local IDSteam = string.gsub(pl:SteamID(), ":", "")
	
	
	// lol.
	if (pl:GetTable().Antidoted) then
		timer.Create( IDSteam, 5, 1, function() UnDrugPlayer(pl) end)
	else
		timer.Create( IDSteam, 10, 1, function() UnDrugPlayer(pl) end)
	end
end

function UnDrugPlayer(pl)
	pl:ConCommand("pp_motionblur 0")  
	pl:ConCommand("pp_dof 0")  
end

function BoozePlayer(pl)
	pl:ConCommand("pp_motionblur 1")  
	pl:ConCommand("pp_motionblur_addalpha 0.05")  
	pl:ConCommand("pp_motionblur_delay 0.035")  
	pl:ConCommand("pp_motionblur_drawalpha 0.75")  
	pl:ConCommand("pp_dof 1")  
	pl:ConCommand("pp_dof_initlength 9")  
	pl:ConCommand("pp_dof_spacing 100") 

	local IDSteam = string.gsub(pl:SteamID(), ":", "")
	
	
	// lol.
	if (pl:GetTable().Antidoted) then
		timer.Create( IDSteam, 5, 1,function() UnBoozePlayer(pl) end)
	else
		timer.Create( IDSteam, 10, 1,function() UnBoozePlayer(pl) end)
	end
end

function UnBoozePlayer(pl)
	pl:ConCommand("pp_motionblur 0")  
	pl:ConCommand("pp_dof 0")  
end

function dropWeapon( ply )

	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	local ent = ply:GetActiveWeapon()
	if !IsValid(ent) then return  ""; end
	local diddrop = true
	local upgrade = ent:GetNWBool("upgraded")

	if(ent:GetClass( ) == "cstm_pistol_glock18") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_glock18.mdl" );
		weapon:SetNWString("weaponclass", "cstm_pistol_glock18");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "cstm_pistol_usp45") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_usp.mdl" );
		weapon:SetNWString("weaponclass", "cstm_pistol_usp45");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();		
	elseif(ent:GetClass( ) == "cstm_pistol_p228") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_p228.mdl" );
		weapon:SetNWString("weaponclass", "cstm_pistol_p228");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "cstm_pistol_deagle") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_deagle.mdl" );
		weapon:SetNWString("weaponclass", "cstm_pistol_deagle");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "cstm_pistol_dualdeagles") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_deags.mdl" );
		weapon:SetNWString("weaponclass", "cstm_pistol_dualdeagles");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();		
	elseif(ent:GetClass( ) == "cstm_pistol_dualelites") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_elite.mdl" );
		weapon:SetNWString("weaponclass", "cstm_pistol_dualelites");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();		
	elseif(ent:GetClass( ) == "cstm_pistol_fiveseven") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_fiveseven.mdl" );
		weapon:SetNWString("weaponclass", "cstm_pistol_fiveseven");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "cstm_pistol_627") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_swp627.mdl" );
		weapon:SetNWString("weaponclass", "cstm_pistol_627");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();		
	elseif(ent:GetClass( ) == "cstm_shotgun_m3") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_shot_m3super90.mdl" );
		weapon:SetNWString("weaponclass", "cstm_shotgun_m3");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "cstm_shotgun_xm1014") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_shot_xm1014.mdl" );
		weapon:SetNWString("weaponclass", "cstm_shotgun_xm1014");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "cstm_smg_mac10") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_mac10.mdl" );
		weapon:SetNWString("weaponclass", "cstm_smg_mac10");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "cstm_pistol_dualmac10s") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_mac10.mdl" );
		weapon:SetNWString("weaponclass", "cstm_pistol_dualmac10s");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();		
	elseif(ent:GetClass( ) == "cstm_smg_tmp") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_tmp.mdl" );
		weapon:SetNWString("weaponclass", "cstm_smg_tmp");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "cstm_smg_mp5") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_mp5.mdl" );
		weapon:SetNWString("weaponclass", "cstm_smg_mp5");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "cstm_smg_mp7") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_mp7.mdl" );
		weapon:SetNWString("weaponclass", "cstm_smg_mp7");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();				
	elseif(ent:GetClass( ) == "cstm_smg_ump45") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_ump45.mdl" );
		weapon:SetNWString("weaponclass", "cstm_smg_ump45");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "cstm_smg_p90") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_p90.mdl" );
		weapon:SetNWString("weaponclass", "cstm_smg_p90");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "cstm_smg_vector") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_kriss.mdl" );
		weapon:SetNWString("weaponclass", "cstm_smg_vector");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "cstm_smg_bizon") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_biz.mdl" );
		weapon:SetNWString("weaponclass", "cstm_smg_bizon");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "cstm_smg_ar57") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_a57.mdl" );
		weapon:SetNWString("weaponclass", "cstm_smg_ar57");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();		
	elseif(ent:GetClass( ) == "cstm_rif_galil") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_galil.mdl" );
		weapon:SetNWString("weaponclass", "cstm_rif_galil");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "cstm_rif_famas") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_famas.mdl" );
		weapon:SetNWString("weaponclass", "cstm_rif_famas");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "cstm_rif_ak47") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_ak47.mdl" );
		weapon:SetNWString("weaponclass", "cstm_rif_ak47");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "cstm_rif_m4a1") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_m4cu.mdl" );
		weapon:SetNWString("weaponclass", "cstm_rif_m4a1");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();		
	elseif(ent:GetClass( ) == "cstm_sniper_aug") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_aug.mdl" );
		weapon:SetNWString("weaponclass", "cstm_sniper_aug");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "cstm_sniper_sg552") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_sg552.mdl" );
		weapon:SetNWString("weaponclass", "cstm_sniper_sg552");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "cstm_rif_g36c") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_g36c.mdl" );
		weapon:SetNWString("weaponclass", "cstm_rif_g36c");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "cstm_rif_asval") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_asval.mdl" );
		weapon:SetNWString("weaponclass", "cstm_rif_asval");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "cstm_rif_f2000") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_f20.mdl" );
		weapon:SetNWString("weaponclass", "cstm_rif_f2000");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "cstm_rif_scarh") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_scarh.mdl" );
		weapon:SetNWString("weaponclass", "cstm_rif_scarh");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "cstm_rif_m14ebr") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_m14.mdl" );
		weapon:SetNWString("weaponclass", "cstm_rif_m14ebr");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();		
	elseif(ent:GetClass( ) == "cstm_sniper_awp") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_snip_awp.mdl" );
		weapon:SetNWString("weaponclass", "cstm_sniper_awp");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "cstm_sniper_g3") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_snip_g3sg1.mdl" );
		weapon:SetNWString("weaponclass", "cstm_sniper_g3");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "cstm_sniper_sg550") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_snip_sg550.mdl" );
		weapon:SetNWString("weaponclass", "cstm_sniper_sg550");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();		
		
// Other		
	elseif(ent:GetClass( ) == "weapon_mad_c4") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_c4.mdl" );
		weapon:SetNWString("weaponclass", "weapon_mad_c4");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();	
/*
	elseif(ent:GetClass( ) == "fo3_flamer") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_flamer.mdl" );
		weapon:SetNWString("weaponclass", "fo3_flamer");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();

	elseif(ent:GetClass( ) == "fo3_fatman") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_fatman.mdl" );
		weapon:SetNWString("weaponclass", "fo3_fatman");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	
	elseif(ent:GetClass( ) == "fo3_alienblaster") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_alienpistol.mdl" );
		weapon:SetNWString("weaponclass", "fo3_alienblaster");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
*/		
	elseif(ent:GetClass( ) == "weapon_fas_vollmer") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/b_mc51.mdl" );
		weapon:SetNWString("weaponclass", "weapon_fas_vollmer");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();		
	elseif(ent:GetClass( ) == "weapon_fas_m79") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/b_m79.mdl" );
		weapon:SetNWString("weaponclass", "weapon_fas_m79");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();
	elseif(ent:GetClass( ) == "weapon_fas_m82") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/b_m82.mdl" );
		weapon:SetNWString("weaponclass", "weapon_fas_m82");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();	
	elseif(ent:GetClass( ) == "weapon_fas_m60") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/b_m60e3.mdl" );
		weapon:SetNWString("weaponclass", "weapon_fas_m60");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();

	elseif(ent:GetClass( ) == "weapon_turretgun") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg1.mdl" );
		weapon:SetNWString("weaponclass", "weapon_turretgun");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();

	elseif(ent:GetClass( ) == "weapon_worldslayer") then
		ply:StripWeapon( ent:GetClass( ) )
		local weapon = ents.CreateEx( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rocket_launcher.mdl" );
		weapon:SetNWString("weaponclass", "weapon_worldslayer");
		weapon:SetPos( tr.HitPos );
		weapon:SetUpgraded(upgrade)
		weapon:Spawn();

	else
		// wont include energy weapons as dropable since people will drop it to reload it.
		Notify( ply, 4, 3, "You can't Drop that Weapon!" );
		diddrop = false
	end
	return "";
end
AddChatCommand( "/drop", dropWeapon );

function scanPlayer( ply, args )
	args = Purify(args)
	if args=="" then return "" end
	if( not ply:CanAfford( CfgVars["scancost"] ) ) then
		Notify( ply, 4, 3, "You can't afford a Scan." );
		return "";
	end
	if !IsValid(ply:GetTable().Tower) then
		Notify(ply,4,3, "You must own a Radar Tower to use /scan command. Say /buyradar to buy a Radar Tower.")
	else
		local userExists = false
		local tower = ply:GetTable().Tower
		if tower:GetTable().Scans<=0 || !tower:IsPowered() then
			Notify(ply,4,3, "Your Radar Tower doesn't have enough charges to scan or doesn't have enough power.")
		else
			local target = FindPlayer(args)
			if target:GetNWBool("scannered") then
				Notify(ply,4,3,"The player has an Scan Blocker!")
				Notify(target,4,3,"Someone attempted to Scan YOU! Your Scan Blocker has been removed...")
				target:SetNWBool("scannered", false)
				return "";
			end
			if IsValid(target) then
				userExists = true
				tower:GetTable().Scans = tower:GetTable().Scans-1
				umsg.Start("RadarScan")
					umsg.Entity(target)
					umsg.Vector(target:GetPos())
					umsg.Short(target:EntIndex())
				umsg.End()
				local effectdata = EffectData()
					effectdata:SetOrigin(target:GetPos())
					effectdata:SetRadius(512)
				util.Effect("scanring", effectdata)
				ply:AddMoney( CfgVars["scancost"] * -1 );
				Notify( ply, 0, 3, "Scanning..." );
				Notify(target,1,3, ply:GetName() .. " has scanned you!")
				util.AddNetworkString( "SV_ScanAccepted");
				net.Start( "SV_ScanAccepted" );
					net.WriteEntity( target );
				net.Send( ply );
				
				if tower:GetNWInt("upgrade")<=1 then
					Notify(ply,1,3,"Notice: You must upgrade your Radar Tower to level 2 to scan for structures!")
				end				
				if tower:GetNWInt("upgrade")>=1 then
					SpyScan(ply,target,false)
				end
				if tower:GetNWInt("upgrade")>=2 then
					ReconScan(ply,target)
				end
			end
			
			if(!userExists) then
				Notify( ply, 4, 3, "Player not found!" );
			end
		end
	end
	return "";
end
AddChatCommand( "/scan", scanPlayer );


function BuyWeapon( ply, args )
	args = Purify(args)
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	local mult = 2	
	local tr = util.TraceLine( trace );

	
	if( args == "knife" ) then
		if( not ply:CanAfford( CfgVars["knifecost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a Knife." );
			return "";
		end
		ply:AddMoney( (CfgVars["knifecost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a Knife!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_knife_t.mdl" );
			weapon:SetNWString("weaponclass", "weapon_real_cs_knife");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "glock" || args == "glock18" ) then
		if( not ply:CanAfford( CfgVars["glockcost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a Glock." );
			return "";
		end
		ply:AddMoney( (CfgVars["glockcost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a Glock!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_pist_glock18.mdl" );
			weapon:SetNWString("weaponclass", "cstm_pistol_glock18");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "usp" || args == "usp45" ) then
		if( not ply:CanAfford( CfgVars["uspcost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a USP." );
			return "";
		end
		ply:AddMoney( (CfgVars["uspcost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a USP!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_pist_usp.mdl" );
			weapon:SetNWString("weaponclass", "cstm_pistol_usp45");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();
			
	elseif( args == "p228" ) then
		if( not ply:CanAfford( CfgVars["p228cost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a P228." );
			return "";
		end
		ply:AddMoney( (CfgVars["p228cost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a P228!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_pist_p228.mdl" );
			weapon:SetNWString("weaponclass", "cstm_pistol_p228");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();			

	elseif( args == "deagle" || args == "deserteagle" ) then
		if( not ply:CanAfford( CfgVars["deaglecost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a Deagle." );
			return "";
		end
		ply:AddMoney( (CfgVars["deaglecost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a Deagle!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_pist_deagle.mdl" );
			weapon:SetNWString("weaponclass", "cstm_pistol_deagle");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "dualdeagles" ) then
		if( not ply:CanAfford( CfgVars["dualdeaglescost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford Dual Deagles." );
			return "";
		end
		ply:AddMoney( (CfgVars["dualdeaglescost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought Dual Deagles!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_pist_deags.mdl" );
			weapon:SetNWString("weaponclass", "cstm_pistol_dualdeagles");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();
			
	elseif( args == "elites" || args == "dualelites" ) then
		if( not ply:CanAfford( CfgVars["elitescost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford Dual Elites." );
			return "";
		end
		ply:AddMoney( (CfgVars["elitescost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought Dual Elites!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_pist_elite.mdl" );
			weapon:SetNWString("weaponclass", "cstm_pistol_dualelites");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "five7" || args == "fiveseven" ) then
		if( not ply:CanAfford( CfgVars["fivesevencost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a Five Seven." );
			return "";
		end
		ply:AddMoney( (CfgVars["fivesevencost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a Five Seven!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_pist_fiveseven.mdl" );
			weapon:SetNWString("weaponclass", "cstm_pistol_fiveseven");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "magnum" || args == "627" ) then
		if( not ply:CanAfford( CfgVars["magnumcost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a Magnum." );
			return "";
		end
		ply:AddMoney( (CfgVars["magnumcost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a Magnum!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_pist_swp627.mdl" );
			weapon:SetNWString("weaponclass", "cstm_pistol_627");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "shotgun" || args == "pumpshotgun" ) then
		if( not ply:CanAfford( CfgVars["shotguncost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a Shotgun." );
			return "";
		end
		ply:AddMoney( (CfgVars["shotguncost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a Shotgun!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_shot_m3super90.mdl" );
			weapon:SetNWString("weaponclass", "cstm_shotgun_m3");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "autoshotgun" || args == "noobcannon" ) then
		if( not ply:CanAfford( CfgVars["autoshotguncost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a Auto Shotgun." );
			return "";
		end
		ply:AddMoney( (CfgVars["autoshotguncost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a Auto Shotgun!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_shot_xm1014.mdl" );
			weapon:SetNWString("weaponclass", "cstm_shotgun_xm1014");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "mac10" ) then
		if( not ply:CanAfford( CfgVars["mac10cost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a Mac10." );
			return "";
		end
		ply:AddMoney( (CfgVars["mac10cost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a Mac10!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_smg_mac10.mdl" );
			weapon:SetNWString("weaponclass", "cstm_smg_mac10");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "dualmac10s" ) then
		if( not ply:CanAfford( CfgVars["dualmac10scost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford Dual Mac10s." );
			return "";
		end
		ply:AddMoney( (CfgVars["dualmac10scost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought Dual Mac10s!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_smg_mac10.mdl" );
			weapon:SetNWString("weaponclass", "cstm_pistol_dualmac10s");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "tmp" ) then
		if( not ply:CanAfford( CfgVars["tmpcost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a TMP." );
			return "";
		end
		ply:AddMoney( (CfgVars["tmpcost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a TMP!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_smg_tmp.mdl" );
			weapon:SetNWString("weaponclass", "cstm_smg_tmp");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "mp5" || args == "mp5navy" ) then
		if( not ply:CanAfford( CfgVars["mp5cost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a MP5." );
			return "";
		end
		ply:AddMoney( (CfgVars["mp5cost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a MP5!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_smg_mp5.mdl" );
			weapon:SetNWString("weaponclass", "cstm_smg_mp5");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "mp7" ) then
		if( not ply:CanAfford( CfgVars["mp7cost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a MP7." );
			return "";
		end
		ply:AddMoney( (CfgVars["mp7cost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a MP7!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_smg_mp7.mdl" );
			weapon:SetNWString("weaponclass", "cstm_smg_mp7");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "ump" || args == "ump45" ) then
		if( not ply:CanAfford( CfgVars["umpcost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a UMP45." );
			return "";
		end
		ply:AddMoney( (CfgVars["umpcost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a UMP45!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_smg_ump45.mdl" );
			weapon:SetNWString("weaponclass", "cstm_smg_ump45");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "p90" ) then
		if( not ply:CanAfford( CfgVars["p90cost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a P90." );
			return "";
		end
		ply:AddMoney( (CfgVars["p90cost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a P90!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_smg_p90.mdl" );
			weapon:SetNWString("weaponclass", "cstm_smg_p90");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "kriss" ) then
		if( not ply:CanAfford( CfgVars["krisscost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a Kriss." );
			return "";
		end
		ply:AddMoney( (CfgVars["krisscost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a Kriss!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_smg_kriss.mdl" );
			weapon:SetNWString("weaponclass", "cstm_smg_vector");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "bizon" ) then
		if( not ply:CanAfford( CfgVars["bizoncost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a Bizon." );
			return "";
		end
		ply:AddMoney( (CfgVars["bizoncost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a Bizon!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_smg_biz.mdl" );
			weapon:SetNWString("weaponclass", "cstm_smg_bizon");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "ar57" ) then
		if( not ply:CanAfford( CfgVars["ar57cost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a AR-57." );
			return "";
		end
		ply:AddMoney( (CfgVars["ar57cost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a AR-57!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_smg_a57.mdl" );
			weapon:SetNWString("weaponclass", "cstm_smg_ar57");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "galil" ) then
		if( not ply:CanAfford( CfgVars["galilcost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a Galil." );
			return "";
		end
		ply:AddMoney( (CfgVars["galilcost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a Galil!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_rif_galil.mdl" );
			weapon:SetNWString("weaponclass", "cstm_rif_galil");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "famas" ) then
		if( not ply:CanAfford( CfgVars["famascost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a FAMAS." );
			return "";
		end
		ply:AddMoney( (CfgVars["famascost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a FAMAS!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_rif_famas.mdl" );
			weapon:SetNWString("weaponclass", "cstm_rif_famas");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "ak" || args == "ak47" ) then
		if( not ply:CanAfford( CfgVars["ak47cost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a AK47." );
			return "";
		end
		ply:AddMoney( (CfgVars["ak47cost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a AK47!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_rif_ak47.mdl" );
			weapon:SetNWString("weaponclass", "cstm_rif_ak47");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "m4" || args == "m4a1" ) then
		if( not ply:CanAfford( CfgVars["m4a1cost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a M4A1." );
			return "";
		end
		ply:AddMoney( (CfgVars["m4a1cost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a M4A1!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_rif_m4cu.mdl" );
			weapon:SetNWString("weaponclass", "cstm_rif_m4a1");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "aug" || args == "bullpop" ) then
		if( not ply:CanAfford( CfgVars["augcost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a AUG." );
			return "";
		end
		ply:AddMoney( (CfgVars["augcost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a AUG!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_rif_aug.mdl" );
			weapon:SetNWString("weaponclass", "cstm_sniper_aug");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "sg552" || args == "krieg" ) then
		if( not ply:CanAfford( CfgVars["sg552cost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a SG552." );
			return "";
		end
		ply:AddMoney( (CfgVars["sg552cost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a SG552!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_rif_sg552.mdl" );
			weapon:SetNWString("weaponclass", "cstm_sniper_sg552");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "g36c" ) then
		if( not ply:CanAfford( CfgVars["g36ccost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a G36C." );
			return "";
		end
		ply:AddMoney( (CfgVars["g36ccost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a G36C!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_rif_g36c.mdl" );
			weapon:SetNWString("weaponclass", "cstm_rif_g36c");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "asval" ) then
		if( not ply:CanAfford( CfgVars["asvalcost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a AS VAL." );
			return "";
		end
		ply:AddMoney( (CfgVars["asvalcost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a AS VAL!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_rif_asval.mdl" );
			weapon:SetNWString("weaponclass", "cstm_rif_asval");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "f2000" ) then
		if( not ply:CanAfford( CfgVars["f2000cost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a FN F2000." );
			return "";
		end
		ply:AddMoney( (CfgVars["f2000cost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a FN F2000!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_rif_f20.mdl" );
			weapon:SetNWString("weaponclass", "cstm_rif_f2000");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "scar" ) then
		if( not ply:CanAfford( CfgVars["scarcost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a FN Scar." );
			return "";
		end
		ply:AddMoney( (CfgVars["scarcost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a FN Scar!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_rif_scarh.mdl" );
			weapon:SetNWString("weaponclass", "cstm_rif_scarh");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "m14" ) then
		if( not ply:CanAfford( CfgVars["m14cost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a M14." );
			return "";
		end
		ply:AddMoney( (CfgVars["m14cost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a M14!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_rif_m14.mdl" );
			weapon:SetNWString("weaponclass", "cstm_rif_m14ebr");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();			

	elseif( args == "awp" || args == "sniper" ) then
		if( not ply:CanAfford( CfgVars["snipercost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a Sniper." );
			return "";
		end
		ply:AddMoney( (CfgVars["snipercost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a Sniper!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_snip_awp.mdl" );
			weapon:SetNWString("weaponclass", "cstm_sniper_awp");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "g3" || args == "autosniper" ) then
		if( not ply:CanAfford( CfgVars["autosnipercost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a Auto Sniper." );
			return "";
		end
		ply:AddMoney( (CfgVars["autosnipercost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a Auto Sniper!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_snip_g3sg1.mdl" );
			weapon:SetNWString("weaponclass", "cstm_sniper_g3");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

	elseif( args == "sg550" ) then
		if( not ply:CanAfford( CfgVars["sg550cost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a SG550." );
			return "";
		end
		ply:AddMoney( (CfgVars["snipercost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a SG550!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_snip_sg550.mdl" );
			weapon:SetNWString("weaponclass", "cstm_sniper_sg550");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();			

	elseif( args == "para" || args == "50cal" || args == "hmg" ) then
		if( not ply:CanAfford( CfgVars["paracost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a Para" );
			return "";
		end
		ply:AddMoney( CfgVars["paracost"] * mult * -1 );
		Notify( ply, 0, 3, "You bought a Para!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_mach_m249para.mdl" );
			weapon:SetNWString("weaponclass", "cstm_rif_m249");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

/*
-- Stun Nades
	elseif( args == "flashbang" || args == "stungrenade" || args == "stun" || args == "flash" ) then
		// it may say flashbang, but these are stun nades now.
		if( not ply:CanAfford( CfgVars["flashbangcost"]* .5 ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["flashbangcost"]* .5 * -1 );
		Notify( ply, 0, 3, "You bought a stun grenade!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_eq_flashbang.mdl" );
			weapon:SetNWString("weaponclass", "weapon_real_cs_flash");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();
--Gas Gernades
	elseif( args == "gasgrenade" || args == "bastardgas" || args=="teargas" || args=="mustardgas" || args =="gas") then
		if( not ply:CanAfford( CfgVars["gasgrenadecost"]* .5 ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["gasgrenadecost"]* .5 * -1 );
		Notify( ply, 0, 3, "You bought a Gas Grenade!" );
		
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_eq_smokegrenade.mdl" );
			weapon:SetNWString("weaponclass", "weapon_gasgrenade");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
			weapon:Spawn();

--Sticky
	elseif( args == "sticky" || args == "stickygrenade") then
		if( not ply:CanAfford( CfgVars["stickycost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["stickycost"] * -1 );
		Notify( ply, 0, 3, "You bought a shipment of Sticky Grenades!" );
		for i=-1, 1, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/magnusson_device.mdl" );
			weapon:SetNWString("weaponclass", "weapon_stickgrenade");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*25), tr.HitPos.z));
			weapon:Spawn();
		end
--Inced
	elseif( args == "inced" || args == "incediary") then
		if( not ply:CanAfford( 5000 )) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( -5000 );
		Notify( ply, 0, 3, "You bought a shipment of Inced Grenades!" );
		for i=-1, 1, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_eq_flashbang.mdl" );
			weapon:SetNWString("weaponclass", "weapon_incedgrenade");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
-- Door Charge
	elseif( args == "doorcharge" || args == "charge") then
		if( not ply:CanAfford( CfgVars["doorchargecost"] )) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["doorchargecost"] * -1 );
		Notify( ply, 0, 3, "You bought a shipment of Door Charges!" );
		for i=-1, 1, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_slam.mdl" );
			weapon:SetNWString("weaponclass", "weapon_mad_charge");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
-- C4
	elseif( args == "c4" || args == "c4charge") then
		if( not ply:CanAfford( CfgVars["c4cost"] )) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["c4cost"] * -1 );
		Notify( ply, 0, 3, "You bought a C4 Explovise!" );
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_c4.mdl" );
			weapon:SetNWString("weaponclass", "weapon_mad_c4");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon:Spawn();
-- Frags
	elseif( args == "grenade"  || args == "frag" || args == "fraggrenade" ) then
		if( not ply:CanAfford( CfgVars["grenadecost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["grenadecost"]*mult * -1 );
		Notify( ply, 0, 3, "You bought a shipment of grenades!" );
		for i=-1, 1, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_eq_fraggrenade.mdl" );
			weapon:SetNWString("weaponclass", "weapon_real_cs_grenade");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
-- Pipe Bombs
	elseif( args == "pipebombs"  || args == "pipebomb" || args == "pbomb" ) then
		if( not ply:CanAfford( CfgVars["pipebombcost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["pipebombcost"]*mult * -1 );
		Notify( ply, 0, 3, "You bought a pipe bomb!" );
		for i=-1, 1, 1 do 
			local weapon = ents.Create( "spawned_weapon" );
			weapon:SetModel( "models/props_lab/pipesystem03b.mdl" );
			weapon:SetNWString("weaponclass", "weapon_pipebomb");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
-- Molotov
	elseif( args == "molotov"  || args == "firebomb") then
		Notify( ply, 0, 3, "Molotovs are disabled!" );
--		if( not ply:CanAfford( CfgVars["molotovcost"]*.5 ) ) then
--			Notify( ply, 4, 3, "Cannot afford this" );
--			return "";
--		end
--		ply:AddMoney( -1000 );
--		Notify( ply, 0, 3, "You bought molotovs!" );
--		
--			local weapon = ents.CreateEx( "spawned_weapon" );
--			weapon:SetModel( "models/props_junk/garbage_glassbottle003a.mdl" );
--			weapon:SetNWString("weaponclass", "weapon_molotov");
--			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (10), tr.HitPos.z));
--			weapon:Spawn();
--		end
*/
	else
		Notify( ply, 4, 3, "That's not an available Weapon." );
	end
	
	return "";
end
AddChatCommand( "/buyweapon", BuyWeapon );

function BuyShipment( ply, args )
	args = Purify(args)
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	local mult = 12.5	
	local tr = util.TraceLine( trace );

	if(ply:GetTable().maxShipments >= CfgVars["maxshipments"])then
			Notify( ply, 4, 3, "Max Shipments Reached!" );
			return "";
	end	
	
	if( args == "knife" ) then
		if( not ply:CanAfford( CfgVars["knifecost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a Knife Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["knifecost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a Knife Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_knife_t.mdl" );
			weapon:SetNWString("weaponclass", "weapon_real_cs_knife");
			weapon:SetNWString("Contents", "Knife Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();

	elseif( args == "glock" || args== "glock18" ) then
		if( not ply:CanAfford( CfgVars["glockcost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a Glock Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["glockcost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a Glock Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_pist_glock18.mdl" );
			weapon:SetNWString("weaponclass", "cstm_pistol_glock18");
			weapon:SetNWString("Contents", "Glock Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();
			
	elseif( args == "p228" ) then
		if( not ply:CanAfford( CfgVars["p228cost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a P228 Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["p228cost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a P228 Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_pist_p228.mdl" );
			weapon:SetNWString("weaponclass", "cstm_pistol_p228");
			weapon:SetNWString("Contents", "P228 Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();			

	elseif( args == "deagle" || args== "deserteagle" ) then
		if( not ply:CanAfford( CfgVars["deaglecost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a Deagle Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["deaglecost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a Deagle Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_pist_deagle.mdl" );
			weapon:SetNWString("weaponclass", "cstm_pistol_deagle");
			weapon:SetNWString("Contents", "Deagle Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();

	elseif( args == "dualdeagles" ) then
		if( not ply:CanAfford( CfgVars["dualdeaglescost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford Dual Deagles Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["dualdeaglescost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought Dual Deagles Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_pist_deags.mdl" );
			weapon:SetNWString("weaponclass", "cstm_pistol_dualdeagles");
			weapon:SetNWString("Contents", "Dual Deagles Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();
			
	elseif( args == "elites" || args== "dualelites" ) then
		if( not ply:CanAfford( CfgVars["elitescost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford Dual Elites Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["elitescost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought Dual Elites Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_pist_elite.mdl" );
			weapon:SetNWString("weaponclass", "cstm_pistol_dualelites");
			weapon:SetNWString("Contents", "Dual Elites Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();

	elseif( args == "five7" || args== "fiveseven" ) then
		if( not ply:CanAfford( CfgVars["fivesevencost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a Five Seven Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["fivesevencost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a Five Seven Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_pist_fiveseven.mdl" );
			weapon:SetNWString("weaponclass", "cstm_pistol_fiveseven");
			weapon:SetNWString("Contents", "Five Seven Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();

	elseif( args == "magnum" || args== "627" ) then
		if( not ply:CanAfford( CfgVars["magnumcost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a Magnum Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["magnumcost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a Magnum Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_pist_swp627.mdl" );
			weapon:SetNWString("weaponclass", "cstm_pistol_627");
			weapon:SetNWString("Contents", "Magnum Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();

	elseif( args == "shotgun" || args== "pumpshotgun" ) then
		if( not ply:CanAfford( CfgVars["shotguncost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a Shotgun Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["shotguncost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a Shotgun Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_shot_m3super90.mdl" );
			weapon:SetNWString("weaponclass", "cstm_shotgun_m3");
			weapon:SetNWString("Contents", "Shotgun Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();

	elseif( args == "autoshotgun" || args== "noobcannon" ) then
		if( not ply:CanAfford( CfgVars["autoshotguncost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a Auto Shotgun Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["autoshotguncost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a Auto Shotgun Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_shot_xm1014.mdl" );
			weapon:SetNWString("weaponclass", "cstm_shotgun_xm1014");
			weapon:SetNWString("Contents", "Auto Shotgun Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();

	elseif( args == "mac10" ) then
		if( not ply:CanAfford( CfgVars["mac10cost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a Mac10 Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["mac10cost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a Mac10 Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_smg_mac10.mdl" );
			weapon:SetNWString("weaponclass", "cstm_smg_mac10");
			weapon:SetNWString("Contents", "Mac10 Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();

	elseif( args == "dualmac10s" ) then
		if( not ply:CanAfford( CfgVars["dualmac10scost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford Dual Mac10s Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["dualmac10scost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought Dual Mac10s Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_smg_mac10.mdl" );
			weapon:SetNWString("weaponclass", "cstm_pistol_dualmac10s");
			weapon:SetNWString("Contents", "Dual Mac10s Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();

	elseif( args == "tmp" ) then
		if( not ply:CanAfford( CfgVars["tmpcost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a TMP Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["tmpcost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a TMP Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_smg_tmp.mdl" );
			weapon:SetNWString("weaponclass", "cstm_smg_tmp");
			weapon:SetNWString("Contents", "TMP Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();

	elseif( args == "mp5" || args== "mp5navy" ) then
		if( not ply:CanAfford( CfgVars["mp5cost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a MP5 Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["mp5cost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a MP5 Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_smg_mp5.mdl" );
			weapon:SetNWString("weaponclass", "cstm_smg_mp5");
			weapon:SetNWString("Contents", "MP5 Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();

	elseif( args == "mp7" ) then
		if( not ply:CanAfford( CfgVars["mp7cost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a MP7 Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["mp7cost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a MP7 Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_smg_mp7.mdl" );
			weapon:SetNWString("weaponclass", "cstm_smg_mp7");
			weapon:SetNWString("Contents", "MP7 Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();

	elseif( args == "ump" || args== "ump45" ) then
		if( not ply:CanAfford( CfgVars["umpcost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a UMP45 Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["umpcost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a UMP45 Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_smg_ump45.mdl" );
			weapon:SetNWString("weaponclass", "cstm_smg_ump45");
			weapon:SetNWString("Contents", "UMP45 Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();

	elseif( args == "p90" ) then
		if( not ply:CanAfford( CfgVars["p90cost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a P90 Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["p90cost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a P90 Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_smg_p90.mdl" );
			weapon:SetNWString("weaponclass", "cstm_smg_p90");
			weapon:SetNWString("Contents", "P90 Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();

	elseif( args == "kriss" ) then
		if( not ply:CanAfford( CfgVars["krisscost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a Kriss Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["krisscost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a Kriss Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_smg_kriss.mdl" );
			weapon:SetNWString("weaponclass", "cstm_smg_vector");
			weapon:SetNWString("Contents", "Kriss Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();

	elseif( args == "bizon" ) then
		if( not ply:CanAfford( CfgVars["bizoncost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a Bizon Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["bizoncost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a Bizon Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_smg_biz.mdl" );
			weapon:SetNWString("weaponclass", "cstm_smg_bizon");
			weapon:SetNWString("Contents", "Bizon Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();

	elseif( args == "aks74u" || args== "ak74u" ) then
		if( not ply:CanAfford( CfgVars["aks74ucost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a AKS-74U Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["aks74ucost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a AKS-74U Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_rif_a74u.mdl" );
			weapon:SetNWString("weaponclass", "cstm_rif_ak74u");
			weapon:SetNWString("Contents", "AKS-74U Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();

	elseif( args == "galil" ) then
		if( not ply:CanAfford( CfgVars["galilcost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a Galil Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["galilcost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a Galil Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_rif_galil.mdl" );
			weapon:SetNWString("weaponclass", "cstm_rif_galil");
			weapon:SetNWString("Contents", "Galil Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();

	elseif( args == "famas" ) then
		if( not ply:CanAfford( CfgVars["famascost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a FAMAS Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["famascost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a FAMAS Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_rif_famas.mdl" );
			weapon:SetNWString("weaponclass", "cstm_rif_famas");
			weapon:SetNWString("Contents", "FAMAS Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();

	elseif( args == "ak" || args== "ak47" ) then
		if( not ply:CanAfford( CfgVars["ak47cost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a AK47 Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["ak47cost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a AK47 Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_rif_ak47.mdl" );
			weapon:SetNWString("weaponclass", "cstm_rif_ak47");
			weapon:SetNWString("Contents", "AK47 Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();

	elseif( args == "m4" || args== "m4a1" ) then
		if( not ply:CanAfford( CfgVars["m4a1cost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a M4A1 Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["m4a1cost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a M4A1 Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_rif_m4cu.mdl" );
			weapon:SetNWString("weaponclass", "cstm_rif_m4a1");
			weapon:SetNWString("Contents", "M4A1 Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();

	elseif( args == "aug" || args== "bullpop" ) then
		if( not ply:CanAfford( CfgVars["augcost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a AUG Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["augcost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a AUG Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_rif_aug.mdl" );
			weapon:SetNWString("weaponclass", "cstm_sniper_aug");
			weapon:SetNWString("Contents", "AUG Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();

	elseif( args == "sg552" || args== "krieg" ) then
		if( not ply:CanAfford( CfgVars["sg552cost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a SG552 Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["sg552cost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a SG552 Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_rif_sg552.mdl" );
			weapon:SetNWString("weaponclass", "cstm_sniper_sg552");
			weapon:SetNWString("Contents", "SG552 Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();

	elseif( args == "g36c" ) then
		if( not ply:CanAfford( CfgVars["g36ccost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a G36C Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["g36ccost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a G36C Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_rif_g36c.mdl" );
			weapon:SetNWString("weaponclass", "cstm_rif_g36c");
			weapon:SetNWString("Contents", "G36C Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();

	elseif( args == "awp" || args== "sniper" ) then
		if( not ply:CanAfford( CfgVars["snipercost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a Sniper Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["snipercost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a Sniper Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_snip_awp.mdl" );
			weapon:SetNWString("weaponclass", "cstm_sniper_awp");
			weapon:SetNWString("Contents", "Sniper Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();

	elseif( args == "g3" || args== "autosniper" ) then
		if( not ply:CanAfford( CfgVars["autosnipercost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a Auto Sniper Shipment." );
			return "";
		end
		ply:AddMoney( (CfgVars["autosnipercost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a Auto Sniper Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_snip_g3sg1.mdl" );
			weapon:SetNWString("weaponclass", "cstm_sniper_g3");
			weapon:SetNWString("Contents", "Auto Sniper Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();


	elseif( args == "para" || args == "50cal" || args == "hmg" ) then
		if( not ply:CanAfford( CfgVars["paracost"] * mult) ) then
			Notify( ply, 4, 3, "You can't afford a M249 Shipment" );
			return "";
		end
		ply:AddMoney( (CfgVars["paracost"]) * mult * -1 );
		Notify( ply, 0, 3, "You bought a M249 Shipment!" );
		
			local weapon = ents.Create( "spawned_shipment" );
			weapon.WeaponModel = ( "models/weapons/w_mach_m249para.mdl" );
			weapon:SetNWString("weaponclass", "cstm_rif_m249");
			weapon:SetNWString("Contents", "M249 Shipment");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z));
			weapon.Owner = ply
			weapon:Spawn();
			
	else
		Notify( ply, 4, 3, "That's not an available Weapon Shipment." );
	end
	
	return "";
end
AddChatCommand( "/buyshipment", BuyShipment );


function ccBuyWeapon(ply,command,args)
	if ply:GetTable().LastBuy+1.5<CurTime() then
		ply:GetTable().LastBuy=CurTime()
		BuyWeapon(ply,tostring(args[1]))
	end
end
concommand.Add("buyweapon",ccBuyWeapon)

function ccBuyShipment(ply,command,args)
	if ply:GetTable().LastBuy+1.5<CurTime() then
		ply:GetTable().LastBuy=CurTime()
		BuyShipment(ply,tostring(args[1]))
	end
end
concommand.Add("buyshipment",ccBuyShipment)

function BuyDrug( ply, args )
	args = Purify(args)
	//if( args == "" ) then return ""; end
	local count = tonumber(args)
	if count==nil then count = 1 end
	if count>CfgVars["maxdruglabs"] || count<1 then count = 1 end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	
	for i=1,count do
		if( not ply:CanAfford( CfgVars["druglabcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if(ply:GetTable().maxdrug >= CfgVars["maxdruglabs"])then
			Notify( ply, 4, 3, "Max Drug Labs Reached!" );
			return "";
		end
		ply:AddMoney( CfgVars["druglabcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Drug Lab" );
		local druglab = ents.Create( "drug_lab" );
 
		druglab:SetPos( tr.HitPos+Vector(0,0,i*10));
		druglab.Owner = ply
		druglab:Spawn();
	end
	return "";
end
AddChatCommand( "/buydruglab", BuyDrug );

function BuyMicrowave( ply )
  
      if( args == "" ) then return ""; end
  	local trace = { }
  	
  	trace.start = ply:EyePos();
  	trace.endpos = trace.start + ply:GetAimVector() * 85;
  	trace.filter = ply;
  	
  	local tr = util.TraceLine( trace );
  
  		if( not ply:CanAfford( CfgVars["microwavecost"] ) ) then
  			Notify( ply, 4, 3, "Cannot afford this" );
  			return "";
  		end
  		if(ply:GetTable().maxMicrowaves == CfgVars["maxmicrowaves"])then
  			Notify( ply, 4, 3, "Max Microwaves Reached!" );
  			return "";
  		end
  			ply:AddMoney( CfgVars["microwavecost"] * -1 );
  			Notify( ply, 0, 3, "You bought a Microwave" );
  			
  			local microwave = ents.Create( "microwave" );
  			microwave:SetNWEntity( "owner", ply )
			microwave.Owner = ply
  			microwave:SetPos( tr.HitPos );
  			microwave:Spawn();
  			return ""
end
AddChatCommand( "/buymicrowave", BuyMicrowave );

function BuyGunlab( ply )
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );

		if( not ply:CanAfford( CfgVars["gunlabcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if(ply:GetTable().maxgunlabs >= CfgVars["maxgunlabs"])then
			Notify( ply, 4, 3, "Max Gun Labs Reached!" );
			return "";
		end
			ply:AddMoney( CfgVars["gunlabcost"] * -1 );
			Notify( ply, 0, 3, "You bought a Gun Lab" );
			local gunlab = ents.Create( "gunlab" );
			 
			gunlab:SetPos( tr.HitPos + Vector(0,0,44));
			gunlab.Owner = ply
			gunlab:Spawn();
			return "";
end
AddChatCommand( "/buygunlab", BuyGunlab );

function BuyGunvault( ply )
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );

		if( not ply:CanAfford( CfgVars["gunvaultcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if(ply:GetTable().maxgunvaults >= CfgVars["maxgunvaults"])then
			Notify( ply, 4, 3, "Max Gun Vaults/Pill Boxes Reached!" );
			return "";
		end
		ply:AddMoney( CfgVars["gunvaultcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Gun Vault" );
		local gunlab = ents.Create( "gunvault" );
		 
		gunlab:SetPos( tr.HitPos );
		gunlab.Owner = ply
		gunlab:Spawn();
		return "";
end
AddChatCommand( "/buygunvault", BuyGunvault );

function BuyPillBox( ply )
    if( args == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );

		if( not ply:CanAfford( CfgVars["drugvaultcost"] ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		if(ply:GetTable().maxdrugvaults >= CfgVars["maxpillboxes"])then
			Notify( ply, 4, 3, "Max Gun Vaults/Pill Boxes Reached!" );
			return "";
		end
		ply:AddMoney( CfgVars["drugvaultcost"] * -1 );
		Notify( ply, 0, 3, "You bought a Pill Box" );
		local gunlab = ents.Create( "pillbox" );
		 
		gunlab:SetPos( tr.HitPos+Vector(0,0,40));
		gunlab.Owner = ply
		gunlab:Spawn();
		return "";
end
AddChatCommand( "/buypillbox", BuyPillBox );


function GetHelp( ply, args )
	ply:ConCommand("helpmenu")
end
AddChatCommand( "/help", GetHelp );


function GiveMoney( ply, args )
	args = Purify(args)
    if( args == "" ) then return ""; end
	
	local trace = ply:GetEyeTrace();
	
	if( trace.Entity:IsValid() and trace.Entity:IsPlayer() and trace.Entity:GetPos():Distance( ply:GetPos() ) < 150 and trace.Entity:GetNWBool("AFK")==false) then
	
		local amount = tonumber( args );
		if amount==nil then return "" end
		if( not ply:CanAfford( amount ) ) then
		
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		
		end
		if  (amount!=math.Round(amount)) then
			Notify(ply, 4, 3, "Must be a whole number" );
			return "";
		end
		trace.Entity:AddMoney( amount );
		ply:AddMoney( amount * -1 );
		
		Notify( trace.Entity, 2, 4, ply:Nick() .. " has given you " .. amount .. " dollars!" );
		Notify( ply, 0, 4, "Gave " .. trace.Entity:Nick() .. " " .. amount .. " dollars!" );
		
	else
	
		Notify( ply, 1, 3, "Must be looking at and be within distance of another player that is not AFK!" );
		
	end
	return "";
end
AddChatCommand( "/give", GiveMoney );

function DropMoney( ply, args )
	args = Purify(args)
    if( args == "" ) then return ""; end
	
	local amount = tonumber( args );
	if amount==nil then return "" end
	if( not ply:CanAfford( amount ) ) then
		
		Notify( ply, 4, 3, "You can't afford to drop that much." );
		return "";
		
	end
	
	if( amount < 1000 || amount!=math.Round(amount)) then
	
		Notify( ply, 4, 4, "Invalid amount of money, must be atleast $1000!" );
		return "";
	
	end
	
	ply:AddMoney( amount * -1 );
	Notify( ply, 0, 4, "You dropped $" .. amount .. "!" );
	
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	
	local moneybag = ents.Create( "prop_moneybag" );
	moneybag:SetModel( "models/props/cs_assault/Money.mdl" )
	moneybag:SetPos( tr.HitPos );
	moneybag:Spawn();
	moneybag:SetColor(Color(200,255,200,255))
	
	moneybag:GetTable().MoneyBag = true;
	moneybag:GetTable().Amount = amount;
	
	return "";

end
AddChatCommand( "/moneydrop", DropMoney );
AddChatCommand( "/dropmoney", DropMoney );

function GM:PlayerSpawnProp( ply, model )
	ply:ClearAFK()
	if( not self.BaseClass:PlayerSpawnProp( ply, model ) ) then return false; end
	
	local allowed = false;
	
	if (ply:GetNWBool("shitwelding")) then 
		Notify(ply, 4, 3, "You can't spawn props when someone is Blowtorching your stuff or have recently been bombed!")
		return false;
	end
	
	return true;

end

local function CanDupe(ply, tr, mode)
	// Msg(mode .. " " .. tostring(ply:GetNWBool("shitwelding")) .. "\n")
	if ply:GetNWBool("shitwelding") then -- mode=="duplicator" &&
		Notify(ply,4,3,"You cannot use toolgun when people have welded your stuff or have recently bombed you!")
		return false
	end
end
hook.Add( "CanTool", "CanDupe", CanDupe )


function GM:SetupMove( ply, move )

	if( ply == nil or not ply:Alive() ) then
		return;
	end
	if ply:IsOnGround() then
		ply:GetTable().Jump2 = false
	end
	if ( ply:GetTable().Roided) then
		ply:SetWalkSpeed(350-(ply:GetTable().StunDuration)*2)
		ply:SetRunSpeed(500-(ply:GetTable().StunDuration)*2.75)
		return;
	end
	// give gangsters the small speed boost, since cops already get guns AND bigger payday, just to balance the game a little.

end


function GM:KeyPress( ply, code )
	ply:ClearAFK()
	self.BaseClass:KeyPress( ply, code );
	
	if( code == IN_JUMP && !ply:GetTable().Jump2 && !ply:IsOnGround() && ply:GetTable().DoubleJumped) then
		ply:SetVelocity(ply:GetForward()*150+Vector(0,0,300))
		ply:GetTable().Jump2 = true
	end
	
	if( code == IN_USE ) then
	
		local trace = { }
	
		trace.start = ply:EyePos();
		trace.endpos = trace.start + ply:GetAimVector() * 95;
		trace.filter = ply;
		
		local tr = util.TraceLine( trace );

		if( tr.Entity!=nil and IsValid(tr.Entity) and not ply:KeyDown( IN_ATTACK ) ) then
		
--			if( tr.Entity:GetTable().Letter ) then
	
--				umsg.Start( "ShowLetter", ply );
--					umsg.Short( tr.Entity:GetTable().type );
--					umsg.Vector( tr.Entity:GetPos() );
--					umsg.String( tr.Entity:GetTable().content );
--				umsg.End();
			
--			end

			if( tr.Entity:GetTable().MoneyBag ) then
	
				Notify( ply, 2, 4, "You found $" .. tr.Entity:GetTable().Amount );
				ply:AddMoney( tr.Entity:GetTable().Amount );
				ply:ConCommand("play basewars/chaching.mp3" )
				tr.Entity:Remove();
			
			end
		
--		else
		
--			umsg.Start( "KillLetter", ply ); umsg.End();
		
		end
	
	end

end


function GM:EntityTakeDamage(ply,dmginfo)
	local ignoredrug = false
	local inflictor = dmginfo:GetInflictor()
	local attacker = dmginfo:GetAttacker()
	local dmg = dmginfo:GetDamage()
	local damage = dmginfo:GetDamage()
	if inflictor:GetClass()=="env_fire" || inflictor:GetClass()=="env_physexplosion" || inflictor:GetClass()=="auto_turret_gun" || inflictor:GetClass()=="weapon_molotov" || inflictor:GetClass()=="weapon_flamethrower" ||inflictor:GetClass()=="weapon_knife2" || inflictor:GetClass()=="weapon_gasgrenade" || inflictor:GetClass()=="weapon_tranqgun" || inflictor:GetClass()=="bigbomb" then
		ignoredrug = true
	end
	local scaler = 1
	if (inflictor:GetClass()=="env_physexplosion" || inflictor:GetClass()=="env_fire") && IsValid(inflictor:GetTable().attacker) then
		attacker = inflictor:GetTable().attacker
	end
	if (attacker.Amp == true && !inflictor:IsPlayer() && inflictor:GetClass()!="auto_turret_gun" && inflictor:GetClass()!="weapon_knife2" && inflictor:GetClass()!="weapon_gasgrenade" && inflictor:GetClass()!="weapon_tranqgun" && inflictor:GetClass()!="bigbomb") then
		//dmginfo:ScaleDamage(1.5)
		scaler = scaler*1.4
	end
	// before even applying painkiller or anything, take the max damage it can be, then bounce back part of that.
	// dont bounce knife damage because we dont want to risk bouncing poison
	// dont bounce burning damage because itl get annoying for people to have to burn with other people
	if (ply:GetTable().Mirror == true && attacker!=ply && !inflictor:IsPlayer() && ((dmginfo:IsExplosionDamage() && inflictor:GetClass()!="bigbomb" ) || !ignoredrug)) then
		attacker:TakeDamage(scaler*damage*0.25, ply, ply)
	end
	if (ply.PainKillered == true && attacker:IsPlayer() && attacker!=ply && inflictor:IsPlayer()==false) then
		//dmginfo:ScaleDamage(0.675)
		scaler = scaler*.675
	end
	
	// fuck the mingebags and thier propfaggotry. only thing that would be left is prop pushing, but at least you dont die and lose your gun.
	
	if (attacker!=nil && attacker:IsPlayer()==false) then
		local class = attacker:GetClass()
		local donotwant = false
		if class== "entityflame" || inflictor:IsVehicle() || attacker:IsVehicle() || class==v || (class==v && v=="bigbomb" && !dmginfo:IsExplosionDamage()) || (inflictor:IsWorld() && (!dmginfo:IsFallDamage() || ply:GetTable().Knockbacked)) then
			donotwant = true
		end
		for k, v in ipairs(physgunables) do
			if (class==v && v!="bigbomb") || (class==v && v=="bigbomb" && !dmginfo:IsExplosionDamage()) || (inflictor:IsWorld() && !dmginfo:IsFallDamage()) then
				donotwant = true
			end
		end 
		if donotwant then
			//dmginfo:ScaleDamage(0)
			scaler = 0
		end
	end
	
	if (inflictor!=nil && inflictor:IsPlayer()==false) then
		local class = inflictor:GetClass()
		local donotwant = false
		if class== "entityflame" || inflictor:IsVehicle() || attacker:IsVehicle() || class==v || (class==v && v=="bigbomb" && !dmginfo:IsExplosionDamage()) || (inflictor:IsWorld() && (!dmginfo:IsFallDamage() || ply:GetTable().Knockbacked)) then
			donotwant = true
		end
		if donotwant then
			//dmginfo:ScaleDamage(0)
			scaler = 0
		end
	end

	if (ply:IsPlayer() || ply:IsNPC()) && attacker:IsPlayer() && !inflictor:IsPlayer() && !ignoredrug && attacker.Knockbacked && math.Rand(0,1)>.3 then
		local origin = inflictor:GetPos()
		local pos = ply:GetPos()+Vector(0,0,50)
		local yomomma = (pos-origin)
		yomomma:Normalize()
		local force = (dmginfo:GetDamage()*5)
		if force<100 then force = 100 end
		if force>700 then force = 700 end
		local knockdirection = yomomma*force+Vector(0,0,20)
		ply:SetVelocity(knockdirection)
		StunPlayer(ply, math.ceil(dmginfo:GetDamage()*0.1))
	end
	
	local tdamage = damage*scaler
	if !ply:IsPlayer() then return end
	if (scaler>0 && tdamage>=(ply:Health()+ply:Armor()) && ply:GetTable().Shielded) then
		ply:GetTable().Shieldon = true
		local IDSteam = string.gsub(ply:SteamID(), ":", "")
		timer.Create(IDSteam .. "shield", 0.25, 1, function() UnShield(ply) end)
		Notify(ply, 1, 3, "Snipe Shield Activated")
		ply:SetNWBool("shielded", false)
		ply:GetTable().Shielded = false
		// this is here so that fags can stop making bullshit claims about godmode.
		if (attacker:IsPlayer() && attacker!=ply) then
			Notify(attacker, 1, 3, "Target survived using Snipe Shield!")
		end
		dmginfo:SetDamage((ply:Health()+ply:Armor())-1)
		dmginfo:ScaleDamage(1)
	elseif (ply:GetTable().Shieldon) then
		// for that 4th of a second, godmode them just so that this works against shotguns.
		//dmginfo:SetDamage(0)
		scaler = 0
		dmginfo:ScaleDamage(0)
	else
		dmginfo:ScaleDamage(scaler)
	end
	// let leech heal the attacker, but only if they hit a player or npc, and its not poison or returned damage
	if (ply:IsPlayer() || ply:IsNPC()) && attacker:IsPlayer() && !inflictor:IsPlayer() && !ignoredrug && attacker.Leeched && attacker:Health()<attacker:GetMaxHealth() then
		attacker:SetHealth(attacker:Health()+(tdamage*.35))
		if attacker:Health()>attacker:GetMaxHealth() then
			attacker:SetHealth(attacker:GetMaxHealth())
		end
	end
end


function BuyNWeapons( ply, args )
	args = Purify(args)
	args = string.Explode(" ", args)
   	if( args[1] == "" ) then return ""; end
	local trace = { }
	
	trace.start = ply:EyePos();
	trace.endpos = trace.start + ply:GetAimVector() * 85;
	trace.filter = ply;
	local mult=1	
	local tr = util.TraceLine( trace );
	
	if( args == "flashbang" || args == "stungrenade" || args == "stun" || args == "flash" ) then
		// it may say flashbang, but these are stun nades now.
		if( not ply:CanAfford( CfgVars["flashbangcost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["flashbangcost"]*mult * -1 );
		Notify( ply, 0, 3, "You bought a stun grenades!" );
		for i=-1, 1, 1 do 
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_eq_flashbang.mdl" );
			weapon:SetNWString("weaponclass", "weapon_real_cs_flash");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "smoke" || args == "smokegrenade" || args == "gasgrenade" || args == "bastardgas" || args=="teargas" || args=="mustardgas" || args =="gas") then
		if( not ply:CanAfford( CfgVars["gasgrenadecost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["gasgrenadecost"]*mult * -1 );
		Notify( ply, 0, 3, "You bought a gas grenades!" );
		for i=-1, 1, 1 do 
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_eq_smokegrenade.mdl" );
			weapon:SetNWString("weaponclass", "weapon_gasgrenade");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "grenade"  || args == "frag" || args == "fraggrenade" ) then
		if( not ply:CanAfford( CfgVars["grenadecost"]*mult ) ) then
			Notify( ply, 4, 3, "Cannot afford this" );
			return "";
		end
		ply:AddMoney( CfgVars["grenadecost"]*mult * -1 );
		Notify( ply, 0, 3, "You bought a grenades!" );
		for i=-3, 3, 1 do 
			local weapon = ents.CreateEx( "spawned_weapon" );
			weapon:SetModel( "models/weapons/w_eq_fraggrenade.mdl" );
			weapon:SetNWString("weaponclass", "weapon_real_cs_grenade");
			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
			weapon:Spawn();
		end
	elseif( args == "molotov"  || args == "firebomb") then
		Notify( ply, 0, 3, "Molotovs are disabled!" );
--		if( not ply:CanAfford( CfgVars["molotovcost"]*mult ) ) then
--			Notify( ply, 4, 3, "Cannot afford this" );
--			return "";
--		end
--		ply:AddMoney( -1000 );
--		Notify( ply, 0, 3, "You bought molotovs!" );
--		for i=-1, 1, 1 do 
--			local weapon = ents.CreateEx( "spawned_weapon" );
--			weapon:SetModel( "models/props_junk/garbage_glassbottle003a.mdl" );
--			weapon:SetNWString("weaponclass", "weapon_molotov");
--			weapon:SetPos( Vector(tr.HitPos.x, tr.HitPos.y + (i*10), tr.HitPos.z));
--			weapon:Spawn();
--		end
	else
		Notify( ply, 4, 3, "That's not an available weapon." );
	end
	
	return "";
end
AddChatCommand( "/buynade", BuyNWeapons );