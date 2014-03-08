AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
	// hey, if you can think of a better model, then go right ahead.
	self.Entity:SetModel( "models/props/de_inferno/wine_barrel.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end
	timer.Create( tostring(self.Entity), 60, 0, function() self:giveMoney() end)
	timer.Create( tostring(self.Entity) .. "fuckafkfags", 1800, 1, function() self:shutOff() end)
	timer.Create( tostring(self.Entity) .. "notifyoff", 1680, 1, function() self:notifypl() end)
	self.Entity:SetNWBool("sparking",false)
	self.Entity:SetNWInt("damage",100)
	self.Entity:SetNWInt("upgrade", 0)
	local ply = self.Owner
	ply:GetTable().maxstill=ply:GetTable().maxstill + 1
	self.Inactive = false
	self.Entity:SetNWInt("power",0)
	self.Payout={CfgVars["stillcost"],"Moonshine Still"}
end

function ENT:giveMoney()
	local ply = self.Owner
	if(ply:Alive() && !self.Inactive) then
		if (self.Entity:GetNWInt("upgrade")==2) then
			ply:AddMoney( 200 );
			Notify( ply, 2, 3, "Paid $200 for making Moonshine." );
		elseif(self.Entity:GetNWInt("upgrade")==1) then
			ply:AddMoney( 100 );
			Notify( ply, 2, 3, "Paid $100 for making Moonshine." );
		else
			ply:AddMoney( 50 );
			Notify( ply, 2, 3, "Paid $50 for making Moonshine." );
		end
	elseif (self.Inactive) then
		Notify( ply, 4, 3, "A Moonshine Still is Inactive, Press 'E' on it to Reactivate it." );
	end
end

function ENT:shutOff()
	local ply = self.Owner
	self.Inactive = true
	Notify( ply, 1, 3, "NOTICE: A MOONSHINE STILL HAS GONE INACTIVE" );
	Notify( ply, 1, 3, "PRESS 'E' ON IT TO REACTIVATE IT" );
	self.Entity:SetColor(Color(255,0,0,255))
end

function ENT:notifypl()
	local ply = self.Owner
	Notify( ply, 4, 3, "NOTICE: A MOONSHINE STILL IS ABOUT TO GO INACTIVE" );
	Notify( ply, 4, 3, "PRESS USE ON IT TO PREVENT THIS" );
	self.Entity:SetColor(Color(255,150,150,255))
end

function ENT:Use(activator,caller)
	self.Entity:SetNWBool("sparking",true)
	timer.Create( tostring(self.Entity) .. "drug", 30, 1, function() self:createDrug() end)
	timer.Destroy( tostring(self.Entity) .. "fuckafkfags")
	timer.Create( tostring(self.Entity) .. "fuckafkfags", 1800, 1, function() self:shutOff() end)
	timer.Destroy( tostring(self.Entity) .. "notifyoff")
	timer.Create( tostring(self.Entity) .. "notifyoff", 1680, 1, function() self:notifypl() end)
	self.Inactive = false
	self.Entity:SetColor(Color(255,255,255,255))
end

function ENT:createDrug()
	local ang = self.Entity:GetAngles()
	local spos = self.SparkPos
	drug = ents.Create("item_booze")
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

function ENT:OnRemove( )
	timer.Destroy(tostring(self.Entity)) 
	timer.Destroy(tostring(self.Entity) .. "drug")
	timer.Destroy(tostring(self.Entity) .. "fuckafkfags")
	timer.Destroy(tostring(self.Entity) .. "notifyoff")
	local ply = self.Owner
	if ValidEntity(ply) then
		ply:GetTable().maxstill=ply:GetTable().maxstill - 1
	end
end