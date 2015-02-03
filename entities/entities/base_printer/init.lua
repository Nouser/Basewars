
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.OwnerID = nil //Nil by default, it becomes a string during ENT:Initialize()
ENT.PayoutString = "bronzeprintercost" //The 'payout' string. You get this from the CfgVars["bronzeprintercost"] for example..
ENT.ModelPath = "models/props_lab/reciever01b.mdl" //The model path.
ENT.Health = 150 //How much damage it can endure.
ENT.PrintTime = 30 //The time it takes for one print to come out.
ENT.InactiveTime = 900 //The time it takes to make your printer inactive.
ENT.NotifyTime = 750 //The time it takes to notify your printer is gonna go inactive.
ENT.InactiveResupplyTime = 750 //The time it takes after you resupply for it to go inactive again.
ENT.NotifyResupplyTime = 600 //The Notification time after you resupply
ENT.FancyName = "Base Money Printer" //The 'Fancy' name of the printer. Displayed in notifications.
ENT.PrintAmounts = {
	{50,80}, //Default Print Amount (math.Random([1],[2])), putting more than 2 values in each sub-table is useless.
	{80,110}, //Level 1 Print Amount
	{190,210}, //Level 2 Print Amount
	{300,330}, //Level 3 Print Amount
	{420,450}, //Level 4 Print Amount
}
function ENT:ParentInitialize(ent)
	ent:SetModel(self.ModelPath)
	ent:PhysicsInit(SOLID_VPHYSICS)
	ent:SetMoveType(MOVETYPE_VPHYSICS)
	ent:SetSolid(SOLID_VPHYSICS)
	function ENT:addPrinterCount() //The table values to modify when another count should be added. (Such as during init)
		--This is commented out on purpose.. this shows how you would apply it for a bronze printer..
		--self.Owner:GetTable().maxBronzePrinter = self.Owner:GetTable().maxBronzePrinter + 1
	end
	function ENT:decreasePrinterCount() -- The table values to modify when another count should be decreased. (Such as during removal)
		--This is commented out on purpose.. this shows how you would apply this function for a bronze printer.
		--self.Owner:GetTable().maxBronzePrinter = eslf.Owner:GetTable().maxBronzePrinter - 1
	end
	function ENT:tableNotNil() --A function check to see if the owner's table is nil. This is an important function so that players rejoining get back their printers, and are unable to spawn new ones.
		--This is commented out on purpose.. this shows how you would apply this function for a bronze printer.
		--[[if(self.Owner:GetTable().maxBronzePrinter == nil) then
			return false
		end]]
		return true
	end
	local phys = ent:GetPhysicsObject()
	
	if(phys:IsValid()) then phys:Wake() end
	
	timer.Create(tostring(ent).."inactive",self.InactiveTime,1, function() self:shutOff() end)
	timer.Create(tostring(ent),self.PrintTime,0,function() self:giveMoney() end)
	timer.Create(tostring(ent).."notify",self.NotifyTime,1,function() self:notifyply() end)
	self.Payout = {CfgVars[self.PayoutString],self.FancyName}
	ent:SetNWBool("sparking",false)
	ent:SetNWInt("damage",self.Health)
	ent:SetNWInt("upgrade",0)
	local ply = self.Owner
	self.OwnerID = ply:SteamID()
	self:addPrinterCount()
	self.Inactive = false
	self.NearInact = false
	ent:SetNWInt("power",0)
	self.dontcleanup = true
end
function ENT:Initialize()
	self:ParentInitialize(self.Entity)
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
		local upgrade = self.Entity:GetNWInt("upgrade")
		local amount = math.random( self.PrintAmounts[upgrade+1][1], self.PrintAmounts[upgrade+1][2] )

		local moneybag = ents.Create( "prop_moneybag" );
		moneybag:SetModel( "models/props/cs_assault/Money.mdl" );
		moneybag:SetPos( tr.HitPos );
		moneybag:SetAngles(self.Entity:GetAngles())
		moneybag:Spawn();
		moneybag:SetColor(Color(200,255,200,255))
		moneybag:SetMoveType( MOVETYPE_VPHYSICS )
		
		moneybag:GetTable().MoneyBag = true;
		moneybag:GetTable().Amount = amount
		if(ply != nil and ply != NULL) then
			Notify( ply, 0, 3, "A " .. self.FancyName .. " created $" .. amount );
		end
	elseif (self.Inactive) then
		if(ply != nil and ply != NULL) then
			Notify( ply, 4, 3, "A " .. self.FancyName .." is Inactive, Press 'E' on it to Reactivate it." );
		end
	elseif !self.Entity:IsPowered() then
		if(ply != nil and ply != NULL) then
			Notify(ply, 4, 3, "A " .. self.FancyName .. "M does not have enough power.")
		end
	end
end
function ENT:shutOff()
	local ply = self.Owner
	self.Inactive = true
	if(ply != nil and ply != NULL) then
		Notify( ply, 1, 3, "NOTICE: A " .. string.upper(self.FancyName) .. " HAS GONE INACTIVE" );
		Notify( ply, 1, 3, "PRESS 'E' ON IT TO REACTIVATE IT" );
	end
	self.Entity:SetColor(Color(255,0,0,254))
end

function ENT:notifyply()
	self.NearInact = true
	local ply = self.Owner
	if(ply != nil and ply != NULL) then
		Notify( ply, 4, 3, "NOTICE: A " .. string.upper(self.FancyName) .. " IS ABOUT TO GO INACTIVE" );
		Notify( ply, 4, 3, "PRESS 'E' ON IT TO PREVENT THIS" );
	end
	self.Entity:SetColor(Color(255,150,150,254))
end

function ENT:Use(activator,caller)
	local ply = self.Owner
	if(ply != nil and ply != NULL) then
		if (self.NearInact==true && activator==ply && self.Entity:GetNWBool("sparking")==false && ply:CanAfford(CfgVars[self.PayoutString] * .05)) then
			ply:AddMoney( CfgVars[self.PayoutString] * -.05 )
			self.NearInact = false
			self.Entity:SetNWBool("sparking",true)
			timer.Create( tostring(self.Entity) .. "resupply", 1, 1, function() self:Reload() end)

		end
	end
end

function ENT:Reload()
	Notify(self.Owner, 0, 3, self.FancyName .. " Resupplied!")
	timer.Destroy( tostring(self.Entity) .. "inactive")
	timer.Create( tostring(self.Entity) .. "inactive", self.InactiveResupplyTime, 1, function() self:shutOff() end)
	timer.Destroy( tostring(self.Entity) .. "notify")
	timer.Create( tostring(self.Entity) .. "notify", self.NotifyResupplyTime, 1, function() self:notifyply() end)
	self.Inactive = false
	self.NearInact = false
	self.Entity:SetColor(Color(140, 120, 83, 255))
	local drugPos = self.Entity:GetPos()
	self.Entity:SetNWBool("sparking",false)
end
function ENT:Think()
	local ply = self.Owner
	if(ply == nil or ply == NULL) then
		for k,v in pairs(player.GetAll()) do
			if(v:SteamID() == self.OwnerID and self:tableNotNil()) then
				self.Owner = v
				self:addPrinterCount()
				break
			end
		end
		self:NextThink(CurTime() + 1)
	end
	local upgrade = self.Entity:GetNWInt("upgrade")
	if upgrade==1 then
		self.Payout = {(CfgVars[self.PayoutString] * 2), "Level 2 " .. self.FancyName}
	end
	if upgrade==2 then
		self.Payout = {(CfgVars[self.PayoutString] * 4), "Level 3 " .. self.FancyName}
	end
	if upgrade==3 then
		self.Payout = {(CfgVars[self.PayoutString] * 8), "Level 4 " .. self.FancyName}			
	end
	if upgrade==4 then
		self.Payout = {(CfgVars[self.PayoutString] * 16), "Level 5 " .. self.FancyName}
	end
	if upgrade==0 then
		self.Payout = {CfgVars[self.PayoutString], "Level 1 " .. self.FancyName}		
	end	
end


function ENT:OnRemove( )
	timer.Destroy(tostring(self.Entity)) 
	timer.Destroy(tostring(self.Entity) .. "inactive")
	timer.Destroy(tostring(self.Entity) .. "notify")
	local ply = self.Owner
	if IsValid(ply) then
		self:decreasePrinterCount()
	end
end