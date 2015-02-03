AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()

	self.Entity:SetModel( "models/props/de_prodigy/transformer.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end
	self.Entity:SetNWBool("sparking",false)
	self.Entity:SetNWInt("damage",500)
	self.Entity:SetNWInt("upgrade", 0)
	local ply = self.Owner
	ply:GetTable().maxgunfactory=ply:GetTable().maxgunfactory + 1
	self.Ready = true
	self.Entity:SetNWInt("power",0)
	self.GunType = nil
	self.LastUsed = CurTime()
	self.User = self.Owner
	self.Payout={CfgVars["gunfactorycost"],"Gun Factory"}
end

function ENT:Use( activator )
	if self.LastUsed>CurTime() then 
		self.LastUsed = CurTime()+0.3
		return
	end
	self.LastUsed = CurTime()+0.3
	if (!self.Ready) then
		umsg.Start( "killgunfactorygui", activator );
			umsg.Short( self.Entity:EntIndex() )
		umsg.End()
		umsg.Start( "gunfactorygui", activator );
			umsg.Short( self.Entity:GetNWInt("upgrade") )
			umsg.Short( self.Entity:EntIndex() )
			umsg.Bool(true)
		umsg.End()
		return
	end
	// to prevent having duplicates of it open.
	umsg.Start( "killgunfactorygui", activator );
		umsg.Short( self.Entity:EntIndex() )
	umsg.End()
	umsg.Start( "gunfactorygui", activator );
		umsg.Short( self.Entity:GetNWInt("upgrade") )
		umsg.Short( self.Entity:EntIndex() )
		umsg.Bool(false)
	umsg.End()
end


function ENT:StartProduction(ply,guntype)
	local time = 120
	if guntype=="grenadegun" then time=240 
		elseif guntype=="worldslayer" then time = 600 
		elseif guntype=="plasma" then time = 300 
	end
	self.User = ply
	if guntype=="resetbutton" then
		self.Entity:SetNWBool("sparking",false)
		timer.Destroy( tostring(self.Entity) .. "spawned_weapon")
		timer.Destroy( tostring(self.Entity) .. "dostuff")
		self.Ready = true
		self.GunType = nil
		Notify(ply, 2, 3, "Gun Production Stopped!" )
		umsg.Start("gunfactoryget",ply)
			umsg.Float(0)
			umsg.Entity(self.Entity)
		umsg.End()
	else
		self.Entity:SetNWBool("sparking",true)
		timer.Create( tostring(self.Entity) .. "spawned_weapon", time, 1,function()  self:createGun() end)
		timer.Create( tostring(self.Entity) .. "dostuff", 60, time/60,function()  self:DoStuff() end)
		self.Ready = false
		self.GunType = guntype
		Notify(ply, 2, 3, "Producing a " .. self.GunType )
		umsg.Start("gunfactoryget",ply)
			umsg.Float(time+CurTime())
			umsg.Entity(self.Entity)
		umsg.End()
	end
	umsg.Start( "killgunfactorygui", ply );
		umsg.Short( self.Entity:EntIndex() )
	umsg.End()
end

function ENT:DoStuff()
	local owner = self.User
	local productioncost = 750

	if !self.Entity:IsPowered() then
		Notify(owner, 4, 3, "Failed to create weapon, not enough power!")
		self.Entity:SetNWBool("sparking",false)
		timer.Destroy(tostring(self.Entity) .. "dostuff")
		timer.Destroy(tostring(self.Entity) .. "spawned_weapon")
		self.Ready = true
		umsg.Start("gunfactoryget",ply)
			umsg.Float(time+CurTime())
			umsg.Entity(self.Entity)
		umsg.End()
		return
	end
	if !owner:CanAfford(productioncost) then
		Notify(owner, 4, 3, "Failed to create weapon, not enough money!")
		self.Entity:SetNWBool("sparking",false)
		timer.Destroy(tostring(self.Entity) .. "dostuff")
		timer.Destroy(tostring(self.Entity) .. "spawned_weapon")
		self.Ready = true
		umsg.Start("gunfactoryget",ply)
			umsg.Float(time+CurTime())
			umsg.Entity(self.Entity)
		umsg.End()
		return
	end
	owner:AddMoney(-productioncost)
	Notify(owner,3,3, "Used $"..tostring(productioncost).." for creating a weapon in the Gun Factory!")
end

function ENT:createGun()
	self.Entity:SetNWBool("sparking",false)
	self.Ready = true
	local gun = ents.Create("spawned_weapon")
	if self.GunType=="worldslayer" then
		gun:SetModel("models/weapons/w_rocket_launcher.mdl")
		gun:SetNWString("weaponclass","weapon_worldslayer")
	end
	/*elseif self.GunType=="laserrifle" then
		gun:SetModel("models/weapons/w_snip_scout.mdl")
		gun:SetNWString("weaponclass","weapon_laserrifle")
	elseif self.GunType=="grenadegun" then
		gun:SetModel("models/weapons/b_m79.mdl")
		gun:SetNWString("weaponclass","weapon_fas_m79")
	elseif self.GunType=="plasma" then
		gun:SetModel("models/weapons/w_irifle.mdl")
		gun:SetNWString("weaponclass","weapon_plasma")
	elseif self.GunType=="worldslayer" then
		gun:SetModel("models/weapons/w_rocket_launcher.mdl")
		gun:SetNWString("weaponclass","weapon_worldslayer")		
	end
	*/
	local trace = { }
		trace.start = self.Entity:GetPos()+self.Entity:GetAngles():Up()*15;
		trace.endpos = trace.start + self.Entity:GetAngles():Forward()*-30 + self.Entity:GetAngles():Right()*-30 + self.Entity:GetAngles():Up()*60
		trace.filter = self.Entity
	local tr = util.TraceLine( trace );
	gun:SetPos(tr.HitPos)
	local ang = self.Entity:GetAngles()
	ang:RotateAroundAxis(ang:Up(), 90)
	gun:SetAngles(ang)
	gun:GetTable().spawner = self.User
	gun:Spawn()
	Notify(self.User,3,3,"Gun Factory Weapon Production Complete!")
end

function ENT:Think()
	if (IsValid(self.Owner)==false) then
		self.Entity:Remove()
	end
	if(self.Entity:GetNWBool("sparking") == true) then
		local ang = self.Entity:GetAngles()
	end
	
end

function ENT:OnRemove( )
	timer.Destroy(tostring(self.Entity) .. "spawned_weapon")
	timer.Destroy(tostring(self.Entity) .. "dostuff")
	local ply = self.Owner
	if IsValid(ply) then
		ply:GetTable().maxgunfactory=ply:GetTable().maxgunfactory - 1
	end
end