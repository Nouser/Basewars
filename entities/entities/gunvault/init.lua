AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 20
	
	local ent = ents.Create( "gunvault" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
	
end

function ENT:Initialize()
	self.Entity:SetModel( "models/props/cs_militia/footlocker01_closed.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then 
		phys:SetMass(250)
		phys:Wake()
	end
	self.Entity:SetNWBool("sparking",false)
	self.Entity:SetNWInt("damage",750)
	self.Entity:SetNWInt("upgrade", 0)
	local ply = self.Owner
	ply:GetTable().maxgunvaults=ply:GetTable().maxgunvaults + 1
	self.Locked = true
	self.LastUsed = CurTime()
	self.Guns = {}
	self.Upgrades = {}
end

function ENT:OnTakeDamage(dmg)
	local damage = dmg:GetDamage()
	local attacker=dmg:GetAttacker()
	if !dmg:IsExplosionDamage() && IsValid(attacker) && attacker:IsPlayer() && attacker:GetTable().ArmorPiercered then
		damage = damage*drugeffect_armorpiercermod
	end
	self:SetNWInt("damage",self:GetNWInt("damage") - damage)
	if(self:GetNWInt("damage") <= 0) then
		self:DropAllGuns()
		self:Destruct()  
		self:Remove()
	end
end

function ENT:Destruct()

	local vPoint = self:GetPos()
	local effectdata = EffectData() 
	effectdata:SetStart( vPoint )
	effectdata:SetOrigin( vPoint ) 
	effectdata:SetScale( 1 ) 
	util.Effect( "Explosion", effectdata ) 

end

/*
function ENT:OnTakeDamage(dmg)
	local damage = dmg:GetDamage()
	local attacker=dmg:GetAttacker()
	if !dmg:IsExplosionDamage() && IsValid(attacker) && attacker:IsPlayer() && attacker:GetTable().ArmorPiercered then
		damage = damage*drugeffect_armorpiercermod
	end
	self.Entity:SetNWInt("damage",self.Entity:GetNWInt("damage") - damage)
	if(self.Entity:GetNWInt("damage") <= 0) then
		self.Owner:PrintMessage(HUD_PRINTTALK,"Damage <= 0")
		self.Entity:DropAllGuns()
		self.Entity:Destruct()  
		self.Entity:Remove()
	end
end

function ENT:Destruct()
	self.Owner:PrintMessage(HUD_PRINTTALK,"ENT:Destruct()")
	local vPoint = self.Entity:GetPos()
	local effectdata = EffectData() 
	effectdata:SetStart( vPoint )
	effectdata:SetOrigin( vPoint ) 
	effectdata:SetScale( 1 ) 
	util.Effect( "Explosion", effectdata ) 
	local ply = self.Owner
	ply:PrintMessage(HUD_PRINTTALK,"ENT:OnRemove()")
	ply:PrintMessage(HUD_PRINTTALK,"ply:GetTable().maxgunvaults="..tostring(ply:GetTable().maxgunvaults))
	if IsValid(ply) then
		ply:GetTable().maxgunvaults=ply:GetTable().maxgunvaults - 1
	end
	ply:PrintMessage(HUD_PRINTTALK,"ply:GetTable().maxgunvaults now="..tostring(ply:GetTable().maxgunvaults))
//	umsg.Start( "killgunvaultgui");
//		umsg.Short( self.Entity:EntIndex() )
//	umsg.End()
end
*/

function ENT:Use(activator,caller)
	if (self.LastUsed+0.5>CurTime()) then
		self.LastUsed = CurTime()
	else
		self.LastUsed = CurTime()
		local ply = self.Owner
		if (activator==ply || !self.Locked || activator:IsAllied(ply)) then
			if (activator==ply || activator:IsAllied(ply)) then
				self.Locked = true
			end
			// to prevent having duplicates of it open.
//			umsg.Start( "killgunvaultgui", activator );
//				umsg.Short( self.Entity:EntIndex() )
//			umsg.End()
			umsg.Start( "gunvaultgui", activator );
				umsg.String( table.concat(self.Guns, ",") )
				umsg.Short( self.Entity:EntIndex() )
				umsg.String( table.concat(self.Upgrades, ",") )
			umsg.End()
		else
			Notify(activator,4,3,"This gun vault is locked! use a lock pick to force it open.")
		end
	end
end

function ENT:Think()
	if (IsValid(self.Owner)==false) then
		self.Entity:DropAllGuns()
		self.Entity:Remove()
	end
end

/*
function ENT:DropAllGuns()
	// explode into a shower of all its guns when destroyed. funny as hell if the guy that blew it up gets killed by a gun.
	//self.Owner:PrintMessage(HUD_PRINTTALK,"ENT:DropAllGuns()")
	if(self.Guns != nil) then
		for i=1, table.Count(self.Guns) do
			self.Entity:DropGun(i,self.Owner,10,true)
		end
	end
	//self.Owner:PrintMessage(HUD_PRINTTALK,"ENT:DropAllGuns() finished.")
end
*/

function ENT:DropAllGuns()
	// explode into a shower of all its guns when destroyed. funny as hell if the guy that blew it up gets killed by a gun.
	for i=1, table.Count(self.Guns), 1 do
		self:DropGun(i, self, 10, true)
	end
end

function ENT:CanDropGun(gunnum)
	local gunt = self.Guns[gunnum]
	if (gunt!=nil) then return true else return false end
end

function ENT:DropGun(gunnum, ply, hgt, bigdrop)
	local gunt = self.Guns[gunnum]
	if (bigdrop!=true) then
		local gunt = table.remove(self.Guns, tonumber(gunnum))
	end
	local upgrade = util.tobool(self.Upgrades[gunnum])
	if (!bigdrop) then
		local upgrade = util.tobool(table.remove(self.Upgrades, tonumber(gunnum)))
	end
	// i typed in all the gun names without the weapon_ prefix because i forgot i commented it out. well fuck you. im not going through all this to fix it.
//	local gun = string.gsub(gunt, "weapon_", "")
	gun = gunt
	local height = hgt
	// looking back on this, i probably wouldve been better to set some vars, then spawn the gun and apply those, so that to fuck around with it, wouldnt have to go through each statement.

// Pistols
	if(gun == "weapon_real_cs_glock18") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_glock18.mdl" );
		weapon:SetNWString("weaponclass", "weapon_real_cs_glock18");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "weapon_real_cs_usp") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_usp.mdl" );
		weapon:SetNWString("weaponclass", "weapon_real_cs_usp");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();		
	elseif(gun == "weapon_real_cs_p228") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_p228.mdl" );
		weapon:SetNWString("weaponclass", "weapon_real_cs_p228");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "weapon_real_cs_desert_eagle") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_deagle.mdl" );
		weapon:SetNWString("weaponclass", "weapon_real_cs_desert_eagle");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "weapon_real_cs_elites") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_elite.mdl" );
		weapon:SetNWString("weaponclass", "weapon_real_cs_elites");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "weapon_real_cs_five-seven") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_fiveseven.mdl" );
		weapon:SetNWString("weaponclass", "weapon_real_cs_five-seven");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();

// Shotguns & Submachine Guns
	elseif(gun == "weapon_real_cs_pumpshotgun") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_shot_m3super90.mdl" );
		weapon:SetNWString("weaponclass", "weapon_real_cs_pumpshotgun");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "weapon_real_cs_xm1014") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_shot_xm1014.mdl" );
		weapon:SetNWString("weaponclass", "weapon_real_cs_xm1014");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "weapon_real_cs_mac10") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_mac10.mdl" );
		weapon:SetNWString("weaponclass", "weapon_real_cs_mac10");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "weapon_real_cs_tmp") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_tmp.mdl" );
		weapon:SetNWString("weaponclass", "weapon_real_cs_tmp");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "weapon_real_cs_mp5a5") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_mp5.mdl" );
		weapon:SetNWString("weaponclass", "weapon_real_cs_mp5a5");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "weapon_real_cs_ump45") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_ump45.mdl" );
		weapon:SetNWString("weaponclass", "weapon_real_cs_ump45");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "weapon_real_cs_p90") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_p90.mdl" );
		weapon:SetNWString("weaponclass", "weapon_real_cs_p90");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();

// Assault Rilfes, Sniper Rifles and Machine Guns		
	elseif(gun == "weapon_real_cs_galil") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_galil.mdl" );
		weapon:SetNWString("weaponclass", "weapon_real_cs_galil");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();		
	elseif(gun == "weapon_real_cs_famas") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_famas.mdl" );
		weapon:SetNWString("weaponclass", "weapon_real_cs_famas");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "weapon_real_cs_ak47") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_ak47.mdl" );
		weapon:SetNWString("weaponclass", "weapon_real_cs_ak47");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();		
	elseif(gun == "weapon_real_cs_m4a1") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_m4a1.mdl" );
		weapon:SetNWString("weaponclass", "weapon_real_cs_m4a1");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "weapon_real_cs_aug") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_aug.mdl" );
		weapon:SetNWString("weaponclass", "weapon_real_cs_aug");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();		
	elseif(gun == "weapon_real_cs_sg552") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_sg552.mdl" );
		weapon:SetNWString("weaponclass", "weapon_real_cs_sg552");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "weapon_real_cs_scout") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_snip_scout.mdl" );
		weapon:SetNWString("weaponclass", "weapon_real_cs_scout");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "weapon_real_cs_sg550") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_snip_sg550.mdl" );
		weapon:SetNWString("weaponclass", "weapon_real_cs_sg550");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();		
	elseif(gun == "weapon_real_cs_awp") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_snip_awp.mdl" );
		weapon:SetNWString("weaponclass", "weapon_real_cs_awp");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "weapon_real_cs_g3sg1") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_snip_g3sg1.mdl" );
		weapon:SetNWString("weaponclass", "weapon_real_cs_g3sg1");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();		
		
// Other		
	elseif (gun=="turretgun") then
		local weapon = ents.Create("spawned_weapon")
		weapon:SetModel( "models/weapons/w_smg1.mdl" );
		weapon:SetNWString("weaponclass", "weapon_turretgun");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif (gun=="lasergun") then
		local weapon = ents.Create("spawned_weapon")
		weapon:SetModel( "models/weapons/w_irifle.mdl" );
		weapon:SetNWString("weaponclass", "weapon_lasergun");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif (gun=="laserrifle") then
		local weapon = ents.Create("spawned_weapon")
		weapon:SetModel( "models/weapons/w_snip_scout.mdl" );
		weapon:SetNWString("weaponclass", "weapon_laserrifle");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif (gun=="plasma") then
		local weapon = ents.Create("spawned_weapon")
		weapon:SetModel( "models/weapons/w_irifle.mdl" );
		weapon:SetNWString("weaponclass", "weapon_plasma");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
/*		
	elseif(gun == "weapon_mad_c4") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_c4.mdl" );
		weapon:SetNWString("weaponclass", "weapon_mad_c4");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
*/		
	elseif(gun == "fo3_flamer") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_flamer.mdl" );
		weapon:SetNWString("weaponclass", "fo3_flamer");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "fo3_fatman") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_fatman.mdl" );
		weapon:SetNWString("weaponclass", "fo3_fatman");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();	
	elseif(gun == "fo3_alienblaster") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_alienpistol.mdl" );
		weapon:SetNWString("weaponclass", "fo3_alienblaster");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "weapon_fas_vollmer") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/b_mc51.mdl" );
		weapon:SetNWString("weaponclass", "weapon_fas_vollmer");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();		
	elseif(gun == "weapon_fas_m79") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/b_m79.mdl" );
		weapon:SetNWString("weaponclass", "weapon_fas_m79");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "weapon_fas_m82") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/b_m82.mdl" );
		weapon:SetNWString("weaponclass", "weapon_fas_m82");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();	
	elseif(gun == "weapon_fas_m60") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/b_m60e3.mdl" );
		weapon:SetNWString("weaponclass", "weapon_fas_m60");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "weapon_worldslayer") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rocket_launcher.mdl" );
		weapon:SetNWString("weaponclass", "weapon_worldslayer");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();				
	end
/*
// Pistols
	if(gun == "cstm_pistol_glock18") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_glock18.mdl" );
		weapon:SetNWString("weaponclass", "cstm_pistol_glock18");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "cstm_pistol_p228") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_p228.mdl" );
		weapon:SetNWString("weaponclass", "cstm_pistol_p228");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "cstm_pistol_deagle") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_deagle.mdl" );
		weapon:SetNWString("weaponclass", "cstm_pistol_deagle");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "cstm_pistol_dualdeagles") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_deags.mdl" );
		weapon:SetNWString("weaponclass", "cstm_pistol_dualdeagles");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "cstm_pistol_dualelites") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_elite.mdl" );
		weapon:SetNWString("weaponclass", "cstm_pistol_dualelites");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "cstm_pistol_fiveseven") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_fiveseven.mdl" );
		weapon:SetNWString("weaponclass", "cstm_pistol_fiveseven");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "cstm_pistol_627") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_pist_swp627.mdl" );
		weapon:SetNWString("weaponclass", "cstm_pistol_627");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();		

// Shotguns & Submachine Guns
	elseif(gun == "cstm_shotgun_m3") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_shot_m3super90.mdl" );
		weapon:SetNWString("weaponclass", "cstm_shotgun_m3");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "cstm_shotgun_xm1014") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_shot_xm1014.mdl" );
		weapon:SetNWString("weaponclass", "cstm_shotgun_xm1014");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "cstm_smg_mac10") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_mac10.mdl" );
		weapon:SetNWString("weaponclass", "cstm_smg_mac10");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "cstm_pistol_dualmac10s") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_mac10.mdl" );
		weapon:SetNWString("weaponclass", "cstm_pistol_dualmac10s");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "cstm_smg_tmp") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_tmp.mdl" );
		weapon:SetNWString("weaponclass", "cstm_smg_tmp");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "cstm_smg_mp5") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_mp5.mdl" );
		weapon:SetNWString("weaponclass", "cstm_smg_mp5");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "cstm_smg_mp7") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_mp7.mdl" );
		weapon:SetNWString("weaponclass", "cstm_smg_mp7");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "cstm_smg_ump45") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_ump45.mdl" );
		weapon:SetNWString("weaponclass", "cstm_smg_ump45");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "cstm_smg_p90") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_p90.mdl" );
		weapon:SetNWString("weaponclass", "cstm_smg_p90");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "cstm_smg_vector") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_kriss.mdl" );
		weapon:SetNWString("weaponclass", "cstm_smg_vector");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "cstm_smg_bizon") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_smg_biz.mdl" );
		weapon:SetNWString("weaponclass", "cstm_smg_bizon");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();		

// Assault Rilfes, Sniper Rifles and Machine Guns		
	elseif(gun == "cstm_rif_ak74u") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_a74u.mdl" );
		weapon:SetNWString("weaponclass", "cstm_rif_ak74u");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "cstm_rif_galil") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_galil.mdl" );
		weapon:SetNWString("weaponclass", "cstm_rif_galil");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();		
	elseif(gun == "cstm_rif_famas") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_famas.mdl" );
		weapon:SetNWString("weaponclass", "cstm_rif_famas");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "cstm_rif_ak47") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_ak47.mdl" );
		weapon:SetNWString("weaponclass", "cstm_rif_ak47");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();		
	elseif(gun == "cstm_rif_m4a1") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_m4cu.mdl" );
		weapon:SetNWString("weaponclass", "cstm_rif_m4a1");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "cstm_sniper_aug") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_aug.mdl" );
		weapon:SetNWString("weaponclass", "cstm_sniper_aug");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();		
	elseif(gun == "cstm_sniper_sg552") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_sg552.mdl" );
		weapon:SetNWString("weaponclass", "cstm_sniper_sg552");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "cstm_rif_g36c") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rif_g36c.mdl" );
		weapon:SetNWString("weaponclass", "cstm_rif_g36c");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "cstm_sniper_awp") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_snip_awp.mdl" );
		weapon:SetNWString("weaponclass", "cstm_sniper_awp");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "cstm_sniper_g3") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_snip_g3sg1.mdl" );
		weapon:SetNWString("weaponclass", "cstm_sniper_g3");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();		
		
	elseif (gun=="turretgun") then
		local weapon = ents.Create("spawned_weapon")
		weapon:SetModel( "models/weapons/w_smg1.mdl" );
		weapon:SetNWString("weaponclass", "weapon_turretgun");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif (gun=="lasergun") then
		local weapon = ents.Create("spawned_weapon")
		weapon:SetModel( "models/weapons/w_irifle.mdl" );
		weapon:SetNWString("weaponclass", "weapon_lasergun");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif (gun=="laserrifle") then
		local weapon = ents.Create("spawned_weapon")
		weapon:SetModel( "models/weapons/w_snip_scout.mdl" );
		weapon:SetNWString("weaponclass", "weapon_laserrifle");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif (gun=="plasma") then
		local weapon = ents.Create("spawned_weapon")
		weapon:SetModel( "models/weapons/w_irifle.mdl" );
		weapon:SetNWString("weaponclass", "weapon_plasma");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
		
// Other		
	elseif(gun == "weapon_mad_c4") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_c4.mdl" );
		weapon:SetNWString("weaponclass", "weapon_mad_c4");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();	
	elseif(gun == "fo3_flamer") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_flamer.mdl" );
		weapon:SetNWString("weaponclass", "fo3_flamer");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "fo3_fatman") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_fatman.mdl" );
		weapon:SetNWString("weaponclass", "fo3_fatman");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();	
	elseif(gun == "fo3_alienblaster") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_alienpistol.mdl" );
		weapon:SetNWString("weaponclass", "fo3_alienblaster");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "weapon_fas_vollmer") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/b_mc51.mdl" );
		weapon:SetNWString("weaponclass", "weapon_fas_vollmer");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();		
	elseif(gun == "weapon_fas_m79") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/b_m79.mdl" );
		weapon:SetNWString("weaponclass", "weapon_fas_m79");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "weapon_fas_m82") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/b_m82.mdl" );
		weapon:SetNWString("weaponclass", "weapon_fas_m82");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();	
	elseif(gun == "weapon_fas_m60") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/b_m60e3.mdl" );
		weapon:SetNWString("weaponclass", "weapon_fas_m60");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();
	elseif(gun == "weapon_worldslayer") then
		local weapon = ents.Create( "spawned_weapon" );
		weapon:SetModel( "models/weapons/w_rocket_launcher.mdl" );
		weapon:SetNWString("weaponclass", "weapon_worldslayer");
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:SetUpgraded(upgrade)
				weapon.Ejected = true;
		weapon:Spawn();				
	end
*/	
//	if (ply!=nil) then
//		if (ply:IsPlayer()) then
//			umsg.Start( "killgunvaultgui", ply );
//				umsg.Short( self.Entity:EntIndex() )
//			umsg.End()
//		end
//	end
end

function ENT:OnRemove( )
	timer.Destroy(tostring(self))
	local ply = self.Owner
	if IsValid(ply) then
		ply:GetTable().maxgunvaults=ply:GetTable().maxgunvaults - 1
	end
end

/*
function ENT:OnRemove()
	/*timer.Destroy(self.Entity) 
	local ply = self.Owner
	ply:PrintMessage(HUD_PRINTTALK,"ENT:OnRemove()")
	ply:PrintMessage(HUD_PRINTTALK,"ply:GetTable().maxgunvaults="..tostring(ply:GetTable().maxgunvaults))
	if IsValid(ply) then
		ply:GetTable().maxgunvaults=ply:GetTable().maxgunvaults - 1
	end
	umsg.Start( "killgunvaultgui");
		umsg.Short( self.Entity:EntIndex() )
	umsg.End()
end
*/

function ENT:Touch(gun)
	if (gun:GetClass()=="spawned_weapon" && gun:GetNWString("weaponclass")!=nil && gun:GetNWString("weaponclass")!="weapon_physgun" && gun:GetNWString("weaponclass")!="" and not gun.Ejected  && table.Count(self.Guns)<10) then
		local wepclass = gun:GetNWString("weaponclass")
		local upgraded = gun:IsUpgraded()
		// put it into a string, so i can concat it.
		if (upgraded) then
			upgraded = "1"
		else
			upgraded = "0"
		end
		table.insert(self.Guns, wepclass)
		table.insert(self.Upgrades, upgraded)
		// its a damn shame that the weapon doesnt actually remove instantly.
		gun:SetNWString("weaponclass", "weapon_physgun")
		gun:Remove()	
	end
end

function ENT:IsLocked()
	return self.Locked
end

function ENT:SetUnLocked()
	self.Locked = false
	return true
end