AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()

	self.Entity:SetModel( "models/props_combine/combine_mine01.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end
	timer.Create( tostring(self.Entity), 180, 0, function() self:giveMoney() end)
	timer.Create( tostring(self.Entity) .. "fuckafkfags", 1200, 1, function() self:shutOff() end)
	timer.Create( tostring(self.Entity) .. "notifyoff", 1080, 1, function() self:notifypl() end)
	self.Entity:SetNWBool("sparking",false)
	self.Entity:SetNWInt("damage",250)
	self.Entity:SetNWInt("upgrade", 0)
	local ply = self.Owner
	ply:GetTable().maxdrug=ply:GetTable().maxdrug + 1
	self.Inactive = false
	self.unowned = false
	self.Entity:SetNWInt("power",0)
	self.Payout = {CfgVars["druglabcost"],"Drug Lab"}
end

function ENT:giveMoney()
	local ply = self.Owner
	if ValidEntity(ply) then
		if (self.Inactive) then
			Notify( ply, 4, 3, "A drug lab is inactive, press use on it to make it active again." );
		end
		if !self.Inactive then
			if (self.Entity:GetNWInt("upgrade")==5) then
				ply:AddMoney( 3200 );
				Notify( ply, 2, 3, "Paid $3,200 for selling drugs." );
			elseif (self.Entity:GetNWInt("upgrade")==4) then
				ply:AddMoney( 1600 );
				Notify( ply, 2, 3, "Paid $1,600 for selling drugs." );
			elseif (self.Entity:GetNWInt("upgrade")==3) then
				ply:AddMoney( 800 );
				Notify( ply, 2, 3, "Paid $800 for selling drugs." );
			elseif (self.Entity:GetNWInt("upgrade")==2) then
				ply:AddMoney( 400 );
				Notify( ply, 2, 3, "Paid $400 for selling drugs." );
			elseif(self.Entity:GetNWInt("upgrade")==1) then
				ply:AddMoney( 200 );
				Notify( ply, 2, 3, "Paid $200 for selling drugs." );
			else
				ply:AddMoney( 100 );
				Notify( ply, 2, 3, "Paid $100 for selling drugs." );
			end
		end
	end
end

function ENT:shutOff()
	local ply = self.Owner
	self.Inactive = true
	if ValidEntity(ply) then
		Notify( ply, 1, 3, "NOTICE: A DRUG LAB HAS GONE INACTIVE" );
		Notify( ply, 1, 3, "PRESS USE ON IT TO CONTINUE GETTING MONEY" );
		self.Entity:SetColor(Color(255,0,0,255))
	end
end
function ENT:notifypl()
	local ply = self.Owner
	if ValidEntity(ply) then
		Notify( ply, 4, 3, "NOTICE: A DRUG LAB IS ABOUT TO GO INACTIVE" );
		Notify( ply, 4, 3, "PRESS USE ON IT TO PREVENT THIS" );
		self.Entity:SetColor(Color(255,150,150,255))
	end
end

function ENT:Use(activator,caller)
	local ply = self.Owner
	if ValidEntity(ply) then
		self.Entity:SetNWBool("sparking",true)
		if (self.Entity:GetNWInt("upgrade")==5) then
			timer.Create( tostring(self.Entity) .. "drug", 5, 1, function() self:createDrug() end)
		end
		if (self.Entity:GetNWInt("upgrade")==4) then
			timer.Create( tostring(self.Entity) .. "drug", 10, 1, function() self:createDrug() end)
		end
		if (self.Entity:GetNWInt("upgrade")==3) then
			timer.Create( tostring(self.Entity) .. "drug", 15, 1, function() self:createDrug() end)
		end
		if (self.Entity:GetNWInt("upgrade")==2) then
			timer.Create( tostring(self.Entity) .. "drug", 20, 1, function() self:createDrug() end)
		end
		if (self.Entity:GetNWInt("upgrade")==1) then
			timer.Create( tostring(self.Entity) .. "drug", 25, 1, function() self:createDrug() end)
		end
		if (self.Entity:GetNWInt("upgrade")==0) then
			timer.Create( tostring(self.Entity) .. "drug", 30, 1, function() self:createDrug() end)
		end
		timer.Destroy( tostring(self.Entity) .. "fuckafkfags")
		timer.Create( tostring(self.Entity) .. "fuckafkfags", 1200, 1, function() self.shutOff() end)
		timer.Destroy( tostring(self.Entity) .. "notifyoff")
		timer.Create( tostring(self.Entity) .. "notifyoff", 1080, 1,function() self:notifypl() end)
		self.Inactive = false
		self.Entity:SetColor(Color(255,255,255,255))
	end
end

function ENT:createDrug()
	local spos = self.SparkPos
	local ang = self.Entity:GetAngles()
	drug = ents.Create("item_drug")
	drug:SetPos(self.Entity:GetPos()+ang:Forward()*spos.x+ang:Right()*spos.y+ang:Up()*spos.z)
	drug:Spawn()
	self.Entity:SetNWBool("sparking",false)
end
 
function ENT:Think()
	if (ValidEntity(self.Owner)==false) then
		self.Entity:Remove()
	end
	self.Entity:NextThink(CurTime()+0.1)
	return true
end

function ENT:noOwner()
	self.Inactive = true
	self.Entity:SetColor(Color(0,255,0,255))
	timer.Destroy(tostring(self.Entity) .. "drug")
	timer.Destroy(tostring(self.Entity) .. "fuckafkfags")
	timer.Destroy(tostring(self.Entity) .. "notifyoff")
	timer.Create( tostring(self.Entity) .. "findowner", 10, 12, function() self:ownerTick() end)
	timer.Create( tostring(self.Entity) .. "fail", 120, 1, function() self.Remove(self) end)
end

function ENT:ownerTick()
	local ply = self.Owner
	if (ValidEntity(ply)) then
		self.unowned = false
		Notify(ply,0,3,"A Drug Lab is inactive where you left it")
		timer.Destroy(tostring(self.Entity) .. "findowner")
		timer.Destroy(tostring(self.Entity) .. "fail")
		self.Entity:SetColor(Color(255,0,0,255))
		ply:GetTable().maxdrug=ply:GetTable().maxdrug + 1
	end
end

function ENT:OnRemove( )
	timer.Destroy(tostring(self.Entity) .. "findowner")
	timer.Destroy(tostring(self.Entity) .. "fail")
	timer.Destroy(tostring(self.Entity)) 
	timer.Destroy(tostring(self.Entity) .. "drug")
	timer.Destroy(tostring(self.Entity) .. "fuckafkfags")
	timer.Destroy(tostring(self.Entity) .. "notifyoff")
	local ply = self.Owner
	if ValidEntity(ply) then
		ply:GetTable().maxdrug=ply:GetTable().maxdrug - 1
	end
end