-- ============================================
-- =                                          =
-- =          Crate SENT by Mahalis           =
-- =                                          =
-- ============================================

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()

	self.Entity:SetModel( "models/basewars/gunfactory.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetColor(0,255,255,255)
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end
	self.Entity:SetNWBool("sparking",false)
	self.Entity:SetNWInt("damage",400)
	self.Entity:SetNWInt("upgrade", 0)
	local ply = self.Owner
	ply:GetTable().maxsupergunfactory=ply:GetTable().maxsupergunfactory + 1
	self.Ready = true
	self.Entity:SetNWInt("power",0)
	self.GunType = nil
	self.LastUsed = CurTime()
	self.User = self.Owner
end

function ENT:Use( activator )
	if self.LastUsed>CurTime() then 
		self.LastUsed = CurTime()+0.3
		return
	end
	self.LastUsed = CurTime()+0.3
	if (!self.Ready) then
		umsg.Start( "killsupergunfactorygui", activator );
			umsg.Short( self.Entity:EntIndex() )
		umsg.End()
		umsg.Start( "supergunfactorygui", activator );
			umsg.Short( self.Entity:GetNWInt("upgrade") )
			umsg.Short( self.Entity:EntIndex() )
			umsg.Bool(true)
		umsg.End()
		return
	end
	// to prevent having duplicates of it open.
	umsg.Start( "killsupergunfactorygui", activator );
		umsg.Short( self.Entity:EntIndex() )
	umsg.End()
	umsg.Start( "supergunfactorygui", activator );
		umsg.Short( self.Entity:GetNWInt("upgrade") )
		umsg.Short( self.Entity:EntIndex() )
		umsg.Bool(false)
	umsg.End()
end

function ENT:CanProduce(guntype, ply)
	if guntype=="resetbutton" && ply==self.Owner then
		return true
	elseif !self.Entity:IsPowered() || !self.Ready then
		return false
	elseif guntype=="flamer" then
		return true
	elseif guntype=="m82" && self.Entity:GetNWInt("upgrade")>=1 then
		return true
	elseif guntype=="vollmer" && self.Entity:GetNWInt("upgrade")>=2 then
		return true
	elseif guntype=="m60a3" && self.Entity:GetNWInt("upgrade")>=3 then
		return true
	elseif guntype=="fatman" && self.Entity:GetNWInt("upgrade")>=4 then
		return true
	else
		return false
	end
end

function ENT:StartProduction(ply,guntype)
	local time = 180
	if guntype=="m82" then time = 300 elseif guntype=="vollmer" then time = 420 elseif guntype=="m60a3" then time = 540 elseif guntype=="fatman" then time = 660 end
	self.User = ply
	if guntype=="resetbutton" then
		self.Entity:SetNWBool("sparking",false)
		timer.Destroy( tostring(self.Entity) .. "spawned_weapon")
		timer.Destroy( tostring(self.Entity) .. "dostuff")
		self.Ready = true
		self.GunType = nil
		Notify(ply, 2, 3, "Gun Production Stopped!" )
		umsg.Start("supergunfactoryget",ply)
			umsg.Float(0)
			umsg.Entity(self.Entity)
		umsg.End()
	else
		self.Entity:SetNWBool("sparking",true)
		timer.Create( tostring(self.Entity) .. "spawned_weapon", time, 1, self.createGun, self)
		timer.Create( tostring(self.Entity) .. "dostuff", 60, time/60, self.DoStuff, self)
		self.Ready = false
		self.GunType = guntype
		Notify(ply, 2, 3, "Producing a " .. self.GunType )
		umsg.Start("supergunfactoryget",ply)
			umsg.Float(time+CurTime())
			umsg.Entity(self.Entity)
		umsg.End()
	end
	umsg.Start( "killsupergunfactorygui", ply );
		umsg.Short( self.Entity:EntIndex() )
	umsg.End()
end

function ENT:DoStuff()
	local owner = self.User
	local productioncost = 1000	//Charged every minute
//	if owner!=self.Owner then
//		productioncost = 250
//	end
	if !self.Entity:IsPowered() then
		Notify(owner, 4, 3, "Failed to create weapon, not enough power!")
		self.Entity:SetNWBool("sparking",false)
		timer.Destroy(tostring(self.Entity) .. "dostuff")
		timer.Destroy(tostring(self.Entity) .. "spawned_weapon")
		self.Ready = true
		umsg.Start("supergunfactoryget",ply)
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
		umsg.Start("supergunfactoryget",ply)
			umsg.Float(time+CurTime())
			umsg.Entity(self.Entity)
		umsg.End()
		return
	end
	owner:AddMoney(-productioncost)
	Notify(owner,3,3, "Used $"..tostring(productioncost).." for creating a weapon in the Super Gun Factory")
end

function ENT:createGun()
	self.Entity:SetNWBool("sparking",false)
	self.Ready = true
	local gun = ents.Create("spawned_weapon")
	if self.GunType=="laserbeam" then
		gun:SetModel( "models/weapons/w_irifle.mdl" );
		gun:SetNWString("weaponclass", "weapon_lasergun")
	elseif self.GunType=="laserrifle" then
		gun:SetModel("models/weapons/w_snip_scout.mdl")
		gun:SetNWString("weaponclass","weapon_laserrifle")
	elseif self.GunType=="worldslayer" then
		gun:SetModel("models/weapons/w_rocket_launcher.mdl")
		gun:SetNWString("weaponclass","weapon_worldslayer")
	elseif self.GunType=="grenadegun" then
		gun:SetModel("models/weapons/w_rif_sg552.mdl")
		gun:SetNWString("weaponclass","weapon_grenadegun")
	elseif self.GunType=="plasma" then
		gun:SetModel("models/weapons/w_irifle.mdl")
		gun:SetNWString("weaponclass","weapon_plasma")
	end
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
	Notify(self.User,3,3,"Super Gun Factory Weapon Production Completed!")
end

function ENT:Think()
	if (ValidEntity(self.Owner)==false) then
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
	if ValidEntity(ply) then
		ply:GetTable().maxgunfactory=ply:GetTable().maxgunfactory - 1
	end
end

/*
//function ENT:MakeScraps()
--	if !self.scrap then
--		self.scrap = false
--		local value = CfgVars["gunfactorycost"]/25
--		if value<5 then value = 5 end
--		for i=0, 5, 1 do
--			local scrapm = ents.Create("scrapmetal")
--			scrapm:SetModel( "models/gibs/metal_gib" .. math.random(1,5) .. ".mdl" );
--			local randpos = Vector(math.random(-5,5), math.random(-5,5), math.random(0,5))
--			scrapm:SetPos(self.Entity:GetPos()+randpos)
--			scrapm:Spawn()
--			scrapm:GetTable().ScrapMetal = true
--			scrapm:GetTable().Amount = math.random(3,value)
--			scrapm:Activate()
--			scrapm:GetPhysicsObject():SetVelocity(randpos*35)
--			
--			timer.Create( "scraptimer" ..i, 10, 1, function(removeme)
--				removeme:Remove()
--			end, scrapm )
--
--			
--		end 
--	end
//end
*/