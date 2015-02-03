/* ======================================
	AUTO_TURRET/init
	main body
   ====================================== */

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 20
	
	local ent = ents.Create( "auto_turret" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	local head = ents.Create( "auto_turret_gun" )
	head:SetPos( SpawnPos + Vector(0,0,18) )
	head:Spawn()
	head:Activate()
	head:SetParent(ent)
	head.Body = ent
	ent.Head = head
	head:SetOwner( ply )
	return ent
	
end
/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()
	self.Entity:SetModel( "models/props_c17/TrapPropeller_Engine.mdl" )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	// it gets more health when built.
	self.Entity:SetNWInt("damage",300)
	self.Entity:SetNWInt("upgrade", 0)
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass(1000)
		phys:EnableMotion(false)
	end
	local ply = self.Owner
	ply:GetTable().maxturret=ply:GetTable().maxturret + 1
	self.Entity:SetNWBool("ison", false)
	self.Build = 50
	self.LastUsed = CurTime()

	util.PrecacheSound("ambient/energy/spark1.wav")
	util.PrecacheSound("ambient/energy/spark2.wav")
	util.PrecacheSound("ambient/energy/spark3.wav")
	util.PrecacheSound("ambient/energy/spark4.wav")
	self.AllyTable = {}
	self.Entity:SetNWInt("NotBuilt",true)
	self.Entity:SetNWInt("power",0)
    self.Payout = {CfgVars["turretcost"],"Sentry Turret"}
//	self.scrap = false
end

// override the base class one to make it tell when a turret is killed.
function ENT:OnTakeDamage(dmg)
	local damage = dmg:GetDamage()
	local attacker=dmg:GetAttacker()
	local inflictor=dmg:GetInflictor()
	if !dmg:IsExplosionDamage() && ValidEntity(attacker) && attacker:IsPlayer() && attacker:GetTable().ArmorPiercered then
		damage = damage*drugeffect_armorpiercermod
	end
	if self.Entity:GetNWInt("damage")>0 then
		self.Entity:SetNWInt("damage",self.Entity:GetNWInt("damage") - damage)
		if(self.Entity:GetNWInt("damage") <= 0) then
			Notify(self.Owner,1,3,"One of your Sentry Turrets have been Destroyed!")
			self.Entity:Explode() 
			self.Entity:Remove()
		end
	end
end

function ENT:Explode()
	local effectdata = EffectData() 
	effectdata:SetStart( self.Entity:GetPos() )
	effectdata:SetOrigin( self.Entity:GetPos() ) 
	effectdata:SetScale( 1 ) 
	util.Effect( "Explosion", effectdata ) 
	self.Head:Remove()
end

function ENT:Think()
	
	// Note: If you're overriding the next think time you need to return true
	if (!ValidEntity(self.Owner)) then
		self.Entity:Remove()
	end
	self.Entity:NextThink(CurTime())
	return true
	
end

function ENT:Use(ply, caller)
	if (self.Build<=0) then
		timer.Create( tostring(self.Entity) .. "toggler", 0.2, 1, function() self:ToggleOn(ply) end)
	end
	if self.LastUsed>CurTime() then return end
	if (self.Build>0) then 
		if (self.LastUsed+0.3<CurTime()) then
			self.LastUsed = CurTime()-0.1
		end
		self.LastUsed = CurTime()+0.1
		
		if ply:GetTable().Tooled then
			self.Build = self.Build-3
			self.Entity:EmitSound("ambient/energy/spark" .. math.random(1,4) .. ".wav")
		else
			self.Build = self.Build-1
			if (self.Build%3==0) then
				self.Entity:EmitSound("ambient/energy/spark" .. math.random(1,4) .. ".wav")
			end
		end
		if (self.Build<=0) then
			self.Entity:SetNWInt("damage",self.Entity:GetNWInt("damage")+225)
			Notify( ply, 0, 3, "Sentry Turret Built!")
			self.Entity:SetNWInt("NotBuilt",false)
		end
	end
end

function ENT:ToggleOn(ply)
	if (ply!=self.Owner) then
		Notify( ply, 4, 3, "This is not your Turret!")
	else
		self.Entity:SetNWBool("ison", !self.Entity:GetNWBool("ison"))
		if (self.Entity:GetNWBool("ison")==false) then
			Notify( ply, 0, 3, "Sentry Turret turned OFF" );
		else
			Notify( ply, 0, 3, "Sentry Turret turned ON" );
		end
	end
end
function ENT:OnRemove()
	timer.Destroy(tostring(self.Entity))
	local ply = self.Owner
	if ValidEntity(ply) then
		ply:GetTable().maxturret=ply:GetTable().maxturret - 1
	end
end

function ENT:IsBuilt()
	if (self.Build<=0) then return true else return false end
end