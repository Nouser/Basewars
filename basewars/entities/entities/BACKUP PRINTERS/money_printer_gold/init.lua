-- ============================================
-- =                                          =
-- =          Crate SENT by Mahalis           =
-- =                                          =
-- ============================================

// copy pasta from DURG lab

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')
ENT.OwnerID = nil
ENT.PayoutString = "goldprintercost"
ENT.ModelPath = "models/props_c17/consolebox01a.mdl"
ENT.Health = 900
ENT.PrintTime = 60
ENT.InactiveTime = 1500
ENT.NotifyTime = 1350
ENT.InactiveResupplyTime = 600
ENT.NotifyResupplyTime = 450
ENT.FancyName = "Gold Money Printer"
ENT.PrintAmounts = {
	{51000,54000},
	{54000,57000},
	{108000,111000},
	{216000,219000},
	{432000,435000},
}
function ENT:Initialize()
	self:ParentInitialize(self.Entity)
	function ENT:addPrinterCount()
		self.Owner:GetTable().maxGoldPrinter = self.Owner:GetTable().maxGoldPrinter + 1
	end
	function ENT:decreasePrinterCount()
		self.Owner:GetTable().maxGoldPrinter = eslf.Owner:GetTable().maxGoldPrinter - 1
	end
	function ENT:tableNotNil()
		if(self.Owner:GetTable().maxGoldPrinter == nil) then
			return false
		end
		return true
	end
end
--[[function ENT:Initialize()
	self.Entity:SetModel( "models/props_c17/consolebox01a.mdl" )
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	
	if(phys:IsValid()) then phys:Wake() end
	timer.Create( tostring(self.Entity), 60, 0, function() self:giveMoney() end)
	timer.Create( tostring(self.Entity) .. "fuckafkfags", 1500, 1,function() self:shutOff() end)
	timer.Create( tostring(self.Entity) .. "notifyoff", 1350, 1, function() self:notifypl() end)
	self.Entity:SetNWInt("damage",900)
	self.Entity:SetNWInt("upgrade", 0)
	local ply = self.Owner
	ply:GetTable().maxGoldPrinter=ply:GetTable().maxGoldPrinter + 1
	self.Inactive = false
	self.NearInact = false
	self.Entity:SetNWInt("power",0)
	self.OwnerID = ply:SteamID()
	self.Payout = {CfgVars["goldprintercost"], "Gold Money Printer"}
	
	self.dontcleanup = true
end

function ENT:giveMoney()
	local ply = self.Owner
	if(!self.Inactive && self.Entity:IsPowered()) then
		// ply:AddMoney( 25 );
		
		local trace = { }
		
		trace.start = self.Entity:GetPos()+self.Entity:GetAngles():Up()*15;
		trace.endpos = trace.start + self.Entity:GetAngles():Forward() + self.Entity:GetAngles():Right()
		trace.filter = self.Entity
		
		local tr = util.TraceLine( trace );
		if (self.Entity:GetNWInt("upgrade")==4) then
			amount = math.random( 432000, 435000 )
		elseif (self.Entity:GetNWInt("upgrade")==3) then
			amount = math.random( 216000, 219000 )
		elseif (self.Entity:GetNWInt("upgrade")==2) then
			amount = math.random( 108000, 111000 )			
		elseif (self.Entity:GetNWInt("upgrade")==1) then
			amount = math.random( 54000, 57000 )
		else
			amount = math.random( 51000, 54000 )		
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
		if(ply != NULL and ply != nil) then
			Notify( ply, 0, 3, "Gold Money Printer created $" .. amount );
		end
	elseif (self.Inactive) then
		if(ply != NULL and ply != nil) then
			Notify( ply, 4, 3, "A Money Printer is Inactive, Press 'E' on it to Reactivate it." );
		end
	elseif !self.Entity:IsPowered() then
		if(ply != NULL and ply != nil) then
			Notify(ply, 4, 3, "A Money Printer does't have enough Power.")
		end
	end
end

function ENT:shutOff()
	local ply = self.Owner
	self.Inactive = true
	if(ply != NULL and ply != nil) then
		Notify( ply, 1, 3, "NOTICE: A MONEY PRINTER HAS GONE INACTIVE" );
		Notify( ply, 1, 3, "PRESS USE ON IT TO CONTINUE GETTING MONEY" );
	end
	self.Entity:SetColor(Color(255,0,0,254))
end
function ENT:notifypl()
	self.NearInact = true
	local ply = self.Owner
	if(ply != NULL and ply != nil) then
		Notify( ply, 4, 3, "NOTICE: A MONEY PRINTER IS ABOUT TO GO INACTIVE" );
		Notify( ply, 4, 3, "PRESS USE ON IT TO PREVENT THIS" );
	end
	self.Entity:SetColor(Color(255,150,150,254))
end

function ENT:Use(activator,caller)
	local ply = self.Owner
	if(ply != NULL and ply != nil) then
		if (self.NearInact==true && activator==ply && self.Entity:GetNWBool("sparking")==false && ply:CanAfford(CfgVars["goldprintercost"] * .05)) then
			ply:AddMoney( CfgVars["goldprintercost"] * -.05 )
			self.NearInact = false
			self.Entity:SetNWBool("sparking",true)
			timer.Create( tostring(self.Entity) .. "resupply", 1, 1, function() self:Reload() end)
			
		end
	end
end

function ENT:Reload()
	Notify(self.Owner, 0, 3, "Gold Money Printer Resupplied!")
	timer.Destroy( tostring(self.Entity) .. "fuckafkfags")
	timer.Create( tostring(self.Entity) .. "fuckafkfags", 600, 1, function() self:shutOff() end)
	timer.Destroy( tostring(self.Entity) .. "notifyoff")
	timer.Create( tostring(self.Entity) .. "notifyoff", 450, 1, function() self:notifypl() end)
	self.Inactive = false
	self.NearInact = false
	self.Entity:SetColor(Color(255, 215, 0, 254))
	local drugPos = self.Entity:GetPos()
	self.Entity:SetNWBool("sparking",false)
end

function ENT:Think()
	local ply = self.Owner
	if(ply == nil or ply == NULL) then
		for k,v in pairs(player.GetAll()) do
			if(v:SteamID() == self.OwnerID and v:GetTable().maxGoldPrinter != nil) then
				self.Owner = v
				self.Owner:GetTable().maxGoldPrinter = self.Owner:GetTable().maxGoldPrinter + 1
				break
			end
		end
		self:NextThink(CurTime() + 1)
	end
	if self:GetNWInt("upgrade")==1 then
			self.Payout = {(CfgVars["goldprintercost"] * 2), "Level 2 Gold Money Printer"}
	end
	if self:GetNWInt("upgrade")==2 then
			self.Payout = {(CfgVars["goldprintercost"] * 4), "Level 3 Gold Money Printer"}
	end
	if self:GetNWInt("upgrade")==3 then
			self.Payout = {(CfgVars["goldprintercost"] * 8), "Level 4 Gold Money Printer"}			
	end
	if self:GetNWInt("upgrade")==4 then
			self.Payout = {(CfgVars["goldprintercost"] * 16), "Level 5 Gold Money Printer"}
	end
	if self:GetNWInt("upgrade")==0 then
			self.Payout = {CfgVars["goldprintercost"], "Level 1 Gold Money Printer"}		
	end	
end
function ENT:OnRemove( )
	timer.Destroy(tostring(self.Entity)) 
	timer.Destroy(tostring(self.Entity) .. "fuckafkfags")
	timer.Destroy(tostring(self.Entity) .. "notifyoff")
	local ply = self.Owner
	if IsValid(ply) then
		ply:GetTable().maxGoldPrinter=ply:GetTable().maxGoldPrinter - 1
	end
end]]