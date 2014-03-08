-- ============================================
-- =                                          =
-- =          Crate SENT by Mahalis           =
-- =                                          =
-- ============================================

// copy pasta from DURG lab

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 20
	
	local ent = ents.Create( "pillbox" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
	
end

function ENT:Initialize()
	self.Entity:SetModel( "models/props_c17/furniturefridge001a.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then 
		//phys:SetMass(1000)
		phys:Wake()
	end
	self.Entity:SetNWBool("sparking",false)
	self.Entity:SetVar("damage",750)
	self.Entity:SetNWInt("upgrade", 0)
	local ply = self.Owner
	ply:GetTable().maxdrugvaults=ply:GetTable().maxdrugvaults + 1
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
	self.Entity:SetVar("damage",self.Entity:GetVar("damage") - damage)
	if(self.Entity:GetVar("damage") <= 0) then
		self.Entity:DropAllGuns()
		self.Entity:Destruct()  
		self.Entity:Remove()
	end
end

function ENT:Destruct()

	local vPoint = self.Entity:GetPos()
	local effectdata = EffectData() 
	effectdata:SetStart( vPoint )
	effectdata:SetOrigin( vPoint ) 
	effectdata:SetScale( 1 ) 
	util.Effect( "Explosion", effectdata ) 

end

function ENT:Use(activator,caller)
	if (self.LastUsed+0.5>CurTime()) then
		self.LastUsed = CurTime()
	else
		self.LastUsed = CurTime()
		local ply = self.Owner
		if (activator==ply || !self.Locked || activator:IsAllied(ply)) then
			if (activator==ply) then
				self.Locked = true
			end
			// to prevent having duplicates of it open.
			umsg.Start( "killpillboxgui", activator );
				umsg.Short( self.Entity:EntIndex() )
			umsg.End()
			umsg.Start( "pillboxgui", activator );
				umsg.String( table.concat(self.Guns, ",") )
				umsg.Short( self.Entity:EntIndex() )
			umsg.End()
		else
			Notify(activator,4,3,"This pill box is locked! use a lock pick to force it open.")
		end
	end
end

function ENT:Think()
	if (IsValid(self.Owner)==false) then
		self.Entity:DropAllGuns()
		self.Entity:Remove()
	end
end

function ENT:DropAllGuns()
	// explode into a shower of all its guns when destroyed. funny as hell if the guy that blew it up gets killed by a gun.
	for i=1, table.Count(self.Guns), 1 do
		self.Entity:DropGun(i, self.Entity, 20, true)
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
	local gun = string.gsub(gunt, "item_", "")
	local height = hgt
	// looking back on this, i probably wouldve been better to set some vars, then spawn the gun and apply those, so that to fuck around with it, wouldnt have to go through each statement.
	if (gun=="steroid") then
		local weapon = ents.Create("item_steroid")
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:Spawn();
	elseif (gun=="regen") then
		local weapon = ents.Create("item_regen")
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:Spawn();
	elseif (gun=="painkiller") then
		local weapon = ents.Create("item_painkiller")
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:Spawn();
	elseif (gun=="reflect") then
		local weapon = ents.Create("item_reflect")
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:Spawn();
	elseif (gun=="focus") then
		local weapon = ents.Create("item_focus")
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:Spawn();
	elseif (gun=="antidote") then
		local weapon = ents.Create("item_antidote")
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:Spawn();
	elseif (gun=="amp") then
		local weapon = ents.Create("item_amp")
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:Spawn();
	elseif (gun=="random") then
		local weapon = ents.Create("item_random")
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:Spawn();
	elseif (gun=="drug") then
		local weapon = ents.Create("item_drug")
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:Spawn();
	elseif (gun=="booze") then
		local weapon = ents.Create("item_booze")
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:Spawn();
	elseif (gun=="food") then
		local weapon = ents.Create("item_food")
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:Spawn();
	elseif (gun=="superdrug") then
		local weapon = ents.Create("item_superdrug")
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:Spawn();
	elseif (gun=="adrenaline") then
		local weapon = ents.Create("item_adrenaline")
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:Spawn();
	elseif (gun=="a.piercer") then
		local weapon = ents.Create("item_armorpiercer")
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:Spawn();
	elseif (gun=="leech") then
		local weapon = ents.Create("item_leech")
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:Spawn();
	elseif (gun=="doublejump") then
		local weapon = ents.Create("item_doublejump")
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:Spawn();
	elseif (gun=="doubletap") then
		local weapon = ents.Create("item_doubletap")
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:Spawn();
	elseif (gun=="shockwave") then
		local weapon = ents.Create("item_shockwave")
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:Spawn();
	elseif (gun=="magicbullet") then
		local weapon = ents.Create("item_magicbullet")
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:Spawn();
	elseif (gun=="knockback") then
		local weapon = ents.Create("item_knockback")
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:Spawn();
	elseif (gun=="s.offense") then
		local weapon = ents.Create("item_superdrugoffense")
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:Spawn();
	elseif (gun=="s.defense") then
		local weapon = ents.Create("item_superdrugdefense")
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:Spawn();
	elseif (gun=="s.weapmod") then
		local weapon = ents.Create("item_superdrugweapmod")
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:Spawn();
	elseif (gun=="uberdrug") then
		local weapon = ents.Create("item_uberdrug")
		weapon:SetPos( self.Entity:GetPos()+Vector(0,0,height));
		weapon:Spawn();
	end
	if (ply!=nil) then
		if (ply:IsPlayer()) then
			umsg.Start( "killgunvaultgui", ply );
				umsg.Short( self.Entity:EntIndex() )
			umsg.End()
		end
	end
end
function ENT:OnRemove( )
	timer.Destroy(self.Entity) 
	local ply = self.Owner
	if IsValid(ply) then
		ply:GetTable().maxsrugvaults=ply:GetTable().maxdrugvaults - 1
	end
	umsg.Start( "killgunvaultgui");
		umsg.Short( self.Entity:EntIndex() )
	umsg.End()
end

function ENT:Touch(gun)
	if ((gun:GetClass()=="item_adrenaline" || gun:GetClass()=="item_armorpiercer" || gun:GetClass()=="item_leech" || gun:GetClass()=="item_doublejump" || gun:GetClass()=="item_shockwave" || gun:GetClass()=="item_doubletap" || gun:GetClass()=="item_magicbullet" || gun:GetClass()=="item_knockback" || gun:GetClass()=="item_uberdrug" || gun:GetClass()=="item_superdrugweapmod" || gun:GetClass()=="item_superdrugdefense" || gun:GetClass()=="item_superdrugoffense" || gun:GetClass()=="item_superdrug" || gun:GetClass()=="item_regen" || gun:GetClass()=="item_steroid" || gun:GetClass()=="item_painkiller" || gun:GetClass()=="item_amp" || gun:GetClass()=="item_antidote" || gun:GetClass()=="item_reflect" || gun:GetClass()=="item_focus" || gun:GetClass()=="item_random" || gun:GetClass()=="item_drug" || gun:GetClass()=="item_booze" || gun:GetClass()=="item_food" ) && table.Count(self.Guns)<20 && gun:GetTime()<CurTime()-5) then
		local wepclass = string.gsub(gun:GetClass(), "item_", "")
		if wepclass=="armorpiercer" then wepclass= "a.piercer"
		elseif wepclass=="superdrugoffense" then wepclass="s.offense"
		elseif wepclass=="superdrugdefense" then wepclass="s.defense"
		elseif wepclass=="superdrugweapmod" then wepclass="s.weapmod"
		end
		table.insert(self.Guns, wepclass)
		gun:ResetTime()
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