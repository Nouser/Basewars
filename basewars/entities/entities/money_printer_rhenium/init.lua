AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
	self.Entity:SetModel( "models/props_c17/consolebox03a.mdl" )
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	
	local phys = self.Entity:GetPhysicsObject()
	
	if(phys:IsValid()) then phys:Wake() end

	timer.Create( tostring(self.Entity), 60, 0, function() self:giveMoney() end)
	timer.Create( tostring(self.Entity) .. "fuckafkfags", 1500, 1, function() self:shutOff() end)
	timer.Create( tostring(self.Entity) .. "notifyoff", 1350, 1, function() self:notifypl() end)

	self.Entity:SetNWBool("sparking",false)
	self.Entity:SetNWInt("damage",450)
	self.Entity:SetNWInt("upgrade", 0)
	local ply = self.Owner
	ply:GetTable().maxRheniumPrinter=ply:GetTable().maxRheniumPrinter + 1
	self.Inactive = false
	self.NearInact = false
	self.Entity:SetNWInt("power",0)
--	self.Payout = {CfgVars["rheniumprintercost"], "Rhenium Money Printer"}

	self.dontcleanup = true
end

function ENT:giveMoney()
	local ply = self.Owner
	if(IsValid(ply) && !self.Inactive && self.Entity:IsPowered()) then
		// ply:AddMoney( 25 );
		
		local trace = { }
		
		trace.start = self.Entity:GetPos()+self.Entity:GetAngles():Up()*15;
		trace.endpos = trace.start + self.Entity:GetAngles():Forward() + self.Entity:GetAngles():Right()
		trace.filter = self.Entity
		
		local tr = util.TraceLine( trace );
		if (self.Entity:GetNWInt("upgrade")==4) then
			amount = math.random( 8000, 10250 )
		elseif (self.Entity:GetNWInt("upgrade")==3) then
			amount = math.random( 6000, 6250 )
		elseif (self.Entity:GetNWInt("upgrade")==2) then
			amount = math.random( 2000, 3250 )			
		elseif (self.Entity:GetNWInt("upgrade")==1) then
			amount = math.random( 1000, 1550 )
		else
			amount = math.random( 500, 750 )		
		end

		local moneybag = ents.Create( "prop_moneybag" );
		moneybag:SetModel( "models/props/cs_assault/Money.mdl" );
		moneybag:SetPos( tr.HitPos );
		moneybag:SetAngles(self.Entity:GetAngles())
		moneybag:Spawn();
		moneybag:SetColor(Color(200,255,200,255))
		moneybag:SetMoveType( MOVETYPE_VPHYSICS )
		
		moneybag:GetTable().MoneyBag = true;
		moneybag:GetTable().Amount = amount
		
		Notify( ply, 0, 3, "Rhenium Money Printer created $" .. amount );
	elseif (self.Inactive) then
		Notify( ply, 4, 3, "A Money Printer is Inactive, Press 'E' on it to Reactivate it." );
	elseif !self.Entity:IsPowered() then
		Notify(ply, 4, 3, "A Money Printer does't have enough Power.")
	end
end

function ENT:shutOff()
	local ply = self.Owner
	self.Inactive = true
	Notify( ply, 1, 3, "NOTICE: A MONEY PRINTER HAS GONE INACTIVE" );
	Notify( ply, 1, 3, "PRESS 'E' ON IT TO REACTIVATE IT" );
	self.Entity:SetColor(Color(255,0,0,254))
end
function ENT:notifypl()
	self.NearInact = true
	local ply = self.Owner
	Notify( ply, 4, 3, "NOTICE: A MONEY PRINTER IS ABOUT TO GO INACTIVE" );
	Notify( ply, 4, 3, "PRESS 'E' ON IT TO PREVENT THIS" );
	self.Entity:SetColor(Color(255,150,150,254))
end

function ENT:Use(activator,caller)
	local ply = self.Owner
	if (self.NearInact==true && self.Entity:GetNWBool("sparking")==false && ply:CanAfford(CfgVars["rheniumprintercost"] * .05)) then
		ply:AddMoney( CfgVars["rheniumprintercost"] * -.05 )
		self.NearInact = false
		self.Entity:SetNWBool("sparking",true)
		timer.Create( tostring(self.Entity) .. "resupply", 1, 1, function() self:Reload() end)
		
	end
end

function ENT:Reload()
	Notify(self.Owner, 0, 3, "Rhenium Money Printer Resupplied!")
	timer.Destroy( tostring(self.Entity) .. "fuckafkfags")
	timer.Create( tostring(self.Entity) .. "fuckafkfags", 600, 1, function() self:shutOff() end)
	timer.Destroy( tostring(self.Entity) .. "notifyoff")
	timer.Create( tostring(self.Entity) .. "notifyoff", 450, 1, function() self:notifypl() end)
	self.Inactive = false
	self.NearInact = false
	self.Entity:SetColor(Color(190, 190, 190, 255))
	local drugPos = self.Entity:GetPos()
	self.Entity:SetNWBool("sparking",false)
end

function ENT:Think()
	if self:GetNWInt("upgrade")==1 then
			self.Payout = {(CfgVars["rheniumprintercost"] * 2), "Level 1 Rhenium Money Printer"}
	end
	if self:GetNWInt("upgrade")==2 then
			self.Payout = {(CfgVars["rheniumprintercost"] * 4), "Level 2 Rhenium Money Printer"}
	end
	if self:GetNWInt("upgrade")==3 then
			self.Payout = {(CfgVars["rheniumprintercost"] * 8), "Level 3 Rhenium Money Printer"}			
	end
	if self:GetNWInt("upgrade")==4 then
			self.Payout = {(CfgVars["rheniumprintercost"] * 16), "Level 4 Rhenium Money Printer"}
	end
	if self:GetNWInt("upgrade")==0 then
			self.Payout = {CfgVars["rheniumprintercost"], "Rhenium Money Printer"}		
	end	
end

function ENT:OnRemove( )
	timer.Destroy(tostring(self.Entity)) 
	timer.Destroy(tostring(self.Entity) .. "fuckafkfags")
	timer.Destroy(tostring(self.Entity) .. "notifyoff")
	local ply = self.Owner
	if IsValid(ply) then
		ply:GetTable().maxRheniumPrinter=ply:GetTable().maxRheniumPrinter - 1
	end
end