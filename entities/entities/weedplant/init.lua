-- ============================================
-- =                                          =
-- =          Crate SENT by Mahalis           =
-- =                                          =
-- ============================================

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
	
	self.Entity:SetModel( "models/props/cs_office/plant01.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end
	timer.Create( tostring(self.Entity), 60, 0, function() self:giveMoney() end)
	timer.Create( tostring(self.Entity) .. "fuckafkfags", 1200, 1, function() self:shutOff() end)
	timer.Create( tostring(self.Entity) .. "notifyoff", 600, 1, function() self:notifypl() end)
	self.Entity:SetNWInt("damage",150)
	self.Entity:SetNWInt("upgrade", 0)
	local ply = self.Owner
	self.nodupe = true
	self.Owner:GetTable().maxweed=self.Owner:GetTable().maxweed + 1
	self.Inactive = false
	self.Entity:SetNWInt("power",0)
	self.Hemp = false
	self.Payout = {CfgVars["weedcost"],"Weed Plant"}
end

function ENT:giveMoney()
	local ply = self.Owner
	
	if(ply:Alive() && !self.Inactive) then
		if self.Hemp==true then
			if (self.Entity:GetNWInt("upgrade")==2) then
				ply:AddMoney( 20 );
				Notify( ply, 2, 3, "Paid $20 for selling drugs." );
			elseif(self.Entity:GetNWInt("upgrade")==1) then
				ply:AddMoney( 15 );
				Notify( ply, 2, 3, "Paid $15 for selling drugs." );
			else
				ply:AddMoney( 10 );
				Notify( ply, 2, 3, "Paid $10 for selling drugs." );
			end
		else
			if (self.Entity:GetNWInt("upgrade")==2) then
				ply:AddMoney( 75 );
				Notify( ply, 2, 3, "Paid $75 for selling drugs." );
			elseif(self.Entity:GetNWInt("upgrade")==1) then
				ply:AddMoney( 50 );
				Notify( ply, 2, 3, "Paid $50 for selling drugs." );
			else
				ply:AddMoney( 25 );
				Notify( ply, 2, 3, "Paid $25 for selling drugs." );
			end
		end
	end
		
end

function ENT:shutOff()
	local ply = self.Owner
	self.Inactive = true
	Notify( ply, 1, 3, "NOTICE: A PLANT HAS DIED FROM LACK OF WATER" );
	self.Entity:Remove()
end
function ENT:notifypl()
	local ply = self.Owner
	Notify( ply, 4, 3, "NOTICE: A WEED PLANT NEEDS WATER" );
	Notify( ply, 4, 3, "PRESS USE ON IT TO WATER IT" );
	self.Entity:SetColor(Color(255,150,0,255))
end

function ENT:Use(activator,caller)
//	timer.Create( tostring(self.Entity) .. "drug", 30, 1, function() self.createDrug(self) end)
	timer.Destroy( tostring(self.Entity) .. "fuckafkfags")
	timer.Create( tostring(self.Entity) .. "fuckafkfags", 1200, 1, function() self:shutOff() end)
	timer.Destroy( tostring(self.Entity) .. "notifyoff")
	timer.Create( tostring(self.Entity) .. "notifyoff", 600, 1, function() self:notifypl() end)
	self.Inactive = false
	if self.Hemp then
		self.Entity:SetColor(Color(200,255,200,255))
	else
		self.Entity:SetColor(Color(255,255,255,255))
	end
end

function ENT:Think()
	if (IsValid(self.Owner)==false) then
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
	if IsValid(ply) then
		ply:GetTable().maxweed=ply:GetTable().maxweed - 1
	end
end

function ENT:Worthless()
	self.Hemp=true
	self.Entity:SetNWInt("damage",50)
	self.Entity:SetColor(Color(200,255,200,255))
end