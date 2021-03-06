AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()

	self.Entity:SetModel( "models/lmaollama/solarpanel-3.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end
	self.Entity:SetNWInt("damage",300)
	self.Entity:SetNWInt("upgrade", 0)
	local ply = self.Owner
	ply:GetTable().maxsolargenerator=ply:GetTable().maxsolargenerator + 1
	self.Inactive = false
	self.Powdist=1024
	self.Entity:SetNWEntity("socket1",nil)
	self.Entity:SetNWEntity("socket2",nil)
	self.Entity:SetNWEntity("socket3",nil)
	self.Entity:SetNWEntity("socket4",nil)
	self.Entity:SetNWEntity("socket5",nil)
---	self.scrap = false
	timer.Create( tostring(self.Entity), 60, 0, function() self:giveMoney() end)
	timer.Create( tostring(self.Entity) .. "fuckafkfags", 1200, 1, function() self:shutOff() end)
	timer.Create( tostring(self.Entity) .. "notifyoff", 1080, 1, function() self:notifypl() end)

	self.Payout = {CfgVars["solargeneratorcost"], "Solar Generator"}
end

function ENT:giveMoney()
	local ply = self.Owner
	if(ValidEntity(ply) && !self.Inactive) then
		if ply:CanAfford(CfgVars["solargeneratorcost"] * .025) then
			ply:AddMoney( CfgVars["solargeneratorcost"] * -.025 );
			Notify( ply, 2, 3, "Costed $25 to keep a Solar Generator Running." );
		else
			Notify( ply, 4, 3, "Solar Generator has Shut Off from Lack of Money!" )
			self.Entity:shutOff()
			timer.Destroy( tostring(self.Entity) .. "fuckafkfags")
			timer.Destroy( tostring(self.Entity) .. "notifyoff")
		end
	elseif (self.Inactive) then
		Notify( ply, 4, 3, "A Solar Generator is Inactive, Press 'E' on it to Reactivate it." );
	end
end

function ENT:shutOff()
	local ply = self.Owner
	self.Inactive = true
	Notify( ply, 1, 3, "NOTICE: A SOLAR GENERATOR HAS GONE INACTIVE" );
	Notify( ply, 1, 3, "PRESS 'E' ON IT TO REACTIVATE IT" );
	self.Entity:SetColor(255,0,0,255)
end
function ENT:notifypl()
	local ply = self.Owner
	Notify( ply, 4, 3, "NOTICE: A SOLAR GENERATOR IS ABOUT TO GO INACTIVE" );
	Notify( ply, 4, 3, "PRESS 'E' ON IT TO KEEP IT WORKING" );
	self.Entity:SetColor(255,150,150,255)
end

function ENT:Use(activator,caller)
	if activator:CanAfford(CfgVars["solargeneratorcost"] * .025) then
---	if activator:CanAfford(5) && activator==self.Owner then	
		timer.Destroy( tostring(self.Entity) .. "fuckafkfags")
		timer.Create( tostring(self.Entity) .. "fuckafkfags", 1200, 1, function() self:shutOff() end)
		timer.Destroy( tostring(self.Entity) .. "notifyoff")
		timer.Create( tostring(self.Entity) .. "notifyoff", 1080, 1, function() self:notifypl() end)
		self.Inactive = false
		self.Entity:SetColor(255,255,255,255)
	end
end
 
function ENT:Think()
	if (ValidEntity(self.Owner)==false) then
		self.Entity:Remove()
	end
	self.Entity:UpdateSockets()
	self.Entity:NextThink(CurTime()+1)
	return true
end

function ENT:OnRemove( )
	self.Entity:UnSocket()
	timer.Destroy(tostring(self.Entity)) 
	timer.Destroy(tostring(self.Entity) .. "fuckafkfags")
	timer.Destroy(tostring(self.Entity) .. "notifyoff")
	local ply = self.Owner
	if ValidEntity(ply) then
		ply:GetTable().maxsolargenerator=ply:GetTable().maxsolargenerator - 1
	end
end

function ENT:UpdateSockets()
	if self.Inactive then
		self.Entity:UnSocket()
		for i=1,5,1 do
			self.Entity:SetNWEntity("socket"..tostring(i),ents.GetByIndex(0))
		end
	else
		for i=1,5,1 do
			if !ValidEntity(self.Entity:GetNWEntity("socket"..tostring(i))) then
				local newstructure = self.Entity:FindStructure()
				if ValidEntity(newstructure) then
					self.Entity:SetNWEntity("socket"..tostring(i), newstructure)
					newstructure:SetNWInt("power", newstructure:GetNWInt("power")+1)
				end
			end
		end
		for i=1,5,1 do
			if ValidEntity(self.Entity:GetNWEntity("socket"..tostring(i))) && self.Entity:GetNWEntity("socket"..tostring(i)):GetPos():Distance(self.Entity:GetPos())>self.Powdist then
				self.Entity:GetNWEntity("socket"..tostring(i)):SetNWInt("power", self.Entity:GetNWEntity("socket"..tostring(i)):GetNWInt("power")-1)
				// since it doesnt want to send a nil, or itself, well just "ground it out" so to speak.
				self.Entity:SetNWEntity("socket"..tostring(i),ents.GetByIndex(0))
			end
		end
	end
end

function ENT:FindStructure()
	for k, v in pairs( ents.FindInSphere(self.Entity:GetPos(), self.Powdist)) do
		if v:GetTable().Structure && v:GetNWInt("power")<v:GetTable().Power && v:GetPos():Distance(self.Entity:GetPos())<=self.Powdist then
			return v
		end
	end
	return nil
end

function ENT:UnSocket()
	for i=1,5,1 do
		if ValidEntity(self.Entity:GetNWEntity("socket"..tostring(i))) then
			self.Entity:GetNWEntity("socket"..tostring(i)):SetNWInt("power", self.Entity:GetNWEntity("socket"..tostring(i)):GetNWInt("power")-1)
		end
	end
end