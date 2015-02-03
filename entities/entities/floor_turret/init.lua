

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')
/*-----------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()
	if(self.Owner:GetTable().maxfloorturrets == nil) then
		self.Owner:GetTable().maxfloorturrets = 0
	end
	self.Owner:GetTable().maxfloorturrets = self.Owner:GetTable().maxfloorturrets + 1
	self.Entity:SetModel("models/Combine_turrets/Floor_turret.mdl")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	// it gets more health when built.
	self.Entity:SetNWInt("damage",self.BaseHealth)
	self.Entity:SetNWInt("upgrade", 0)
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass(50)
		phys:EnableMotion(false)
	end
	local ply = self.Owner
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
    self.Payout = {CfgVars["floorturretcost"],"Floor Turret"}
	local headshot = ents.Create("info_target")
	self.SawShit = 0
	util.PrecacheSound("buttons/blip2.wav")
	self:SetTurretOwner(self.Owner)
	self:SetTurretTarget(-1)
	self:SetNWInt("target",-1)
	self:SetSequence(self:LookupSequence("idlealert"))
	self:SetCycle(10)
//	self.scrap = false
end

// override the base class one to make it tell when a turret is killed.
function ENT:OnTakeDamage(dmg)
	local damage = dmg:GetDamage()
	local attacker=dmg:GetAttacker()
	local inflictor=dmg:GetInflictor()
	if !dmg:IsExplosionDamage() && IsValid(attacker) && attacker:IsPlayer() && attacker:GetTable().ArmorPiercered then
		damage = damage*drugeffect_armorpiercermod
	end
	if self.Entity:GetNWInt("damage")>0 then
		self.Entity:SetNWInt("damage",self.Entity:GetNWInt("damage") - damage)
		if(self.Entity:GetNWInt("damage") <= 0) then
			Notify(self.Owner,1,3,"One of your Floor Turrets have been Destroyed!")
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
	//self.Head:Remove()
end
function ENT:Think()
	if(self:GetPhysicsObject():IsValid()) then
		if(self:GetPhysicsObject():IsMotionEnabled()) then
			self:SetNWBool("ison",false)
		end
	end
	if(self:IsBuilt()) then self:SetNWInt("built",1) else self:SetNWInt("built",0) end
	// Note: If you're overriding the next think time you need to return true
	if (!IsValid(self.Owner) || self.Owner == NULL || self.Owner == nil) then
		self.Entity:Remove()
		return true;
	end
	self:CalculatePoseAngles()
	if self:IsPowered() and self:IsBuilt() && self:GetNWBool("ison") && (CurTime() >= self.NextFireTime) then
		//self.Owner:PrintMessage(HUD_PRINTTALK,"Hi?")
		local nearTarget = nil
		local nearTargetI = nil
		local hitThroughProp = false
		local shootOrigin = self:ShootPos()
		local entities = ents.FindInSphere(self:GetPos(),self.MaxRange)
		local validTargets = {}
		for k,v in pairs(entities) do
			if(v:IsPlayer()) then
				if(v:Health() >= 0) then
					if(v != self.Owner) then
						if(v:Team() != self.Owner:Team() or self.Owner:Team() == 1) then
							//self.Owner:PrintMessage(HUD_PRINTTALK,"DotProduct of " .. v:Nick() .. " is:"..tostring(self:GetForward():DotProduct((v:GetPos() - self:GetPos()):GetNormal())))
							//self.Owner:PrintMessage(HUD_PRINTTALK,"DotProduct of " .. v:Nick() .. " is:"..tostring(self:GetPos():DotProduct((v:GetPos() - self:GetPos()):Normalize()))
							local dotProduct = self:GetForward():DotProduct((v:GetPos() - self:GetPos()):GetNormal())
							if(dotProduct >= 0.5 && dotProduct >= 0) then
								if(validTargets[self:GetPos():Distance(v:GetPos())] == nil) then
									//self.Owner:PrintMessage(HUD_PRINTTALK,"Potential Target:"..tostring(v))
									validTargets[self:GetPos():Distance(v:GetPos())] = {ply = v, distance = self:GetPos():Distance(v:GetPos())}
								end
							end
						end
					end
				end
			end
		end
		for k,v in SortedPairs(validTargets) do
			local trace = {}
				trace.start = self:ShootPos()
				trace.endpos = v.ply:GetPos()
				trace.filter = {self,self.Owner,v.ply}
				trace.mask = MASK_SHOT
			tr = util.TraceLine(trace)
			//self.Owner:PrintMessage(HUD_PRINTTALK,tostring(tr.Entity))
			if(!tr.HitWorld && (tr.Entity == NULL || tr.Entity == nil || tr.Entity == v.ply)) then
				//self.Owner:PrintMessage(HUD_PRINTTALK,tostring(v.ply))

				nearTarget = v.ply
				for a,b in pairs(player.GetAll()) do
					if(b == v.ply) then
						nearTargetI = a
					end
				end
				if(nearTargetI != nil && nearTarget != NULL && nearTarget != nil && nearTargetI != NULL) then
					break
				end
			end
			--[[local traceA = {}
				traceA.start = self:ShootPos()
				traceA.endpos = v.ply:GetPos()
				traceA.filter = {self,self.Owner,v.ply,tr.Entity}
				traceA.mask = MASK_SHOT
			local trA = util.TraceLine(traceA)
			if(!trA.HitWorld && !trA.HitNonWorld) then
				hitThroughProp = true
				nearTarget = v.ply
				for a,b in pairs(player.GetAll()) do
					if(b == v.ply) then
						nearTargetI = a
					end
				end
				if(nearTargetI != nil && nearTarget != NULL && nearTarget != nil && nearTargetI != NULL) then
					break
				end
			end]]
		end
		//self.Owner:PrintMessage(HUD_PRINTTALK,tostring(nearTargetI))
		if(nearTarget != nil && nearTarget != NULL) then
			self:SetTurretTarget(nearTargetI)
			self.SawShit = self.SawShit + 0.5
			//self.Owner:PrintMessage(HUD_PRINTTALK,tostring(self.SawShit))	
			//self.Owner:PrintMessage(HUD_PRINTTALK,tostring(nearTarget))
			if(self.SawShit >= 1 || (self.SawShit >= 0.5 && self:GetNWInt("upgrade") >= 2)) then
				if(nearTarget:Health() > 0) then
					//self.Owner:PrintMessage(HUD_PRINTTALK,"Fire!")	
					self:SetTurretTarget(nearTargetI)
					self:FireShot(nearTarget,hitThroughProp)
					self.SawShit = 0
				else
					self:SetTurretTarget(-1)
					self.SawShit = 0
				end
				//self.Owner:PrintMessage(HUD_PRINTTALK,"Done Fire")
			end
		end
		if(nearTarget == nil || nearTarget == NULL) then
			self:SetTurretTarget(-1)
			self.SawShit = 0
		end
		if self:IsPowered() then
			if(self:GetNWInt("upgrade") <= 2) then
				self.NextFireTime = CurTime() + 0.25
			else
				self.NextFireTime = CurTime() + 0.2
			end
		else
			// underpowered turrets only fire/scans once every 2 seconds.
			self.NextFireTime = CurTime() + 2
		end
	end
	if(!self:IsPowered() || !self:IsBuilt() || !self:GetNWBool("ison")) then
		self:SetTurretTarget(-1)
		self.SawShit = 0
	end
	self:NextThink(CurTime())
	//self:SetTurretTarget(-1)
	return true
	
end

function ENT:Use(ply, caller)
	if (self.Build<=0) then
		timer.Create( tostring(self) .. "toggler", 0.2, 1, function() self:ToggleOn(ply) end)
	end
	if self.LastUsed>CurTime() then return end
	if (self.Build>0) then 
		if (self.LastUsed+0.3<CurTime()) then
			self.LastUsed = CurTime()-0.1
		end
		self.LastUsed = CurTime()+0.1
		
		if ply:GetTable().Tooled then
			self.Build = self.Build-3
			self:EmitSound("ambient/energy/spark" .. math.random(1,4) .. ".wav")
		else
			self.Build = self.Build-1
			if (self.Build%3==0) then
				self:EmitSound("ambient/energy/spark" .. math.random(1,4) .. ".wav")
			end
		end
		if (self.Build<=0) then
			self:SetNWInt("damage",self:GetNWInt("damage")+self.BuiltAddition)
			Notify( ply, 0, 3, "Floor Turret Built!")
			self:SetNWInt("NotBuilt",false)
		end
	end
end

function ENT:ToggleOn(ply)
	if (ply!=self.Owner && !ply:IsAdmin() && !ply:IsSuperAdmin()) then
		Notify( ply, 4, 3, "This is not your Turret!")
	else
		self:SetNWBool("ison", !self:GetNWBool("ison"))
		if (self:GetNWBool("ison")==false) then
			Notify( ply, 0, 3, "Floor Turret turned OFF" );
		else
			Notify( ply, 0, 3, "Floor Turret turned ON" );
		end
	end
end
function ENT:OnRemove()
	timer.Destroy(tostring(self))
	local ply = self.Owner
	if IsValid(ply) then
		ply:GetTable().maxfloorturret=ply:GetTable().maxfloorturret - 1
		if(ply:GetTable().maxfloorturret < 0) then
			ply:GetTable().maxfloorturret = 0
		end
	end
end

function ENT:IsBuilt()
	if (self.Build<=0) then return true else return false end
end

function ENT:FireShot(targ,throughProp)
	// bullet is just for effect, were gonna railgun this fucker.
	//self.Owner:PrintMessage(HUD_PRINTTALK,tostring(targ))
	//if ( self.NextShot > CurTime() || self:GetNWBool("ison")==false) then return end
	
	//self.NextShot = CurTime() + 0.17
	
	// Make a sound if you want to.


	// Get the muzzle attachment (this is pretty much always 1)
	//local Attachment = self.Entity:GetAttachment( 1 )
	// Msg(Attachment .. "\n")
	// Get the shot angles and stuff.
	local shootOrigin = self:ShootPos()
	//self.Owner:PrintMessage(HUD_PRINTTALK,"Done shootOrigin")
	local shootAngles = (((targ:GetPos() + Vector(0,0,30)) - self:ShootPos()):Angle())
	//self.Owner:PrintMessage(HUD_PRINTTALK,"Done shootAngles")
	local shootDir = shootAngles:Forward()
	self:EmitSound( "Weapon_SMG1.Single" )
	//self.Owner:PrintMessage(HUD_PRINTTALK,tostring(targ))
	local dmgAmount = 0
	if (self:GetNWInt("upgrade")>0 && self:GetNWInt("upgrade") <= 2) then
		dmgAmount = 10
	elseif(self:GetNWInt("upgrade") == 3) then
		dmgAmount = 12
	else
		dmgAmount = 8
	end
	if(throughProp) then
		dmgAmount = dmgAmount * 0.25
	end
	targ:TakeDamage(dmgAmount, self.Owner, self)
	// Shoot a bullet
	local bullet = {}
		bullet.Num 		= 1
		bullet.Src 		= shootOrigin
		bullet.Dir 		= shootDir
		bullet.Spread 		= Vector( 0, 0, 0 )
		bullet.Tracer		= 1
		bullet.TracerName 	= "Tracer"
		bullet.Force		= 50
		bullet.Damage		= 0
		bullet.Attacker 	= self:GetOwner()		
	self:FireBullets( bullet )
	
	// Make a muzzle flash
	local effectdata = EffectData()
		effectdata:SetStart(self:ShootPos())
		effectdata:SetOrigin( self:ShootPos() )
		effectdata:SetAngles( shootAngles )
		effectdata:SetScale( 0.5 )
	util.Effect( "MuzzleEffect", effectdata )
	effectdata = EffectData()
		effectdata:SetStart(self:ShootPos() - shootAngles:Forward()*10 + shootAngles:Up() + shootAngles:Right())
		effectdata:SetOrigin(self:ShootPos() - shootAngles:Forward()*10 + shootAngles:Up() + shootAngles:Right())
		effectdata:SetAngles(shootAngles + Angle(0,135,0))
		effectdata:SetScale(1)
	util.Effect("RifleShellEject",effectdata)
end