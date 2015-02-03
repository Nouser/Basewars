-- ============================================
-- =                                          =
-- =          Crate SENT by Mahalis           =
-- =                                          =
-- ============================================

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
	
	self.Entity:SetModel( "models/props/de_train/processor_nobase.mdl" )
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end
	timer.Create( tostring(self.Entity), 60, 0, function() self.giveMoney( self) end)
	timer.Create( tostring(self.Entity) .. "fuckafkfags", 1200, 1,function() self.shutOff( self) end)
	timer.Create( tostring(self.Entity) .. "notifyoff", 950, 1,function() self.notifypl( self) end)
	self.Entity:SetNWInt("damage",200)
	self.Entity:SetNWInt("upgrade", 0)
	local ply = self.Owner
	ply:GetTable().maxmethlab=ply:GetTable().maxmethlab + 1
	self.Inactive = false
	self.Entity:SetNWInt("power",0)
	self.drugmaking = false
	self.Payout = {CfgVars["methlabcost"], "Meth Lab"}
end

function ENT:giveMoney()
	local ply = self.Owner
	local explodechance = 0.05
	if self.drugmaking then
		explodechance = 0.1
	end
	if math.Rand(0,1)<explodechance then
		util.BlastDamage( self.Entity, self.Owner, self.Entity:GetPos(), 384, 55 )
		
		local vPoint = self.Entity:GetPos()
			local effectdata = EffectData() 
			effectdata:SetStart( vPoint )
			effectdata:SetOrigin( vPoint ) 
			effectdata:SetScale( 1 ) 
		util.Effect( "Explosion", effectdata ) 
		self.Entity:Remove()
		Notify( ply, 1, 3, "A METH LAB HAS BLOWN RIGHT THE FUCK UP" );
	else
		if(ply:Alive() && !self.Inactive) then
			if (self.Entity:GetNWInt("upgrade")==2) then
				ply:AddMoney( 1000 );
				Notify( ply, 2, 3, "Paid $1000 for Selling Low Quality Meth." );
			elseif(self.Entity:GetNWInt("upgrade")==1) then
				ply:AddMoney( 500 );
				Notify( ply, 2, 3, "Paid $500 for Selling Low Quality Meth." );
			else
				ply:AddMoney( 250 );
				Notify( ply, 2, 3, "Paid $250 for Selling Low Quality Meth." );
			end
		elseif (self.Inactive) then
			Notify( ply, 4, 3, "A meth lab is inactive, press use on it to make it active again." );
		end
	end
end

function ENT:shutOff()
	local ply = self.Owner
	self.Inactive = true
	Notify( ply, 1, 3, "NOTICE: A METH LAB HAS GONE INACTIVE" );
	Notify( ply, 1, 3, "PRESS USE ON IT TO KEEP GETTING MONEY" );
	self.Entity:SetColor(Color(255,0,0,255))
end
function ENT:notifypl()
	local ply = self.Owner
	Notify( ply, 4, 3, "NOTICE: A METH LAB IS ABOUT TO GO INACTIVE" );
	Notify( ply, 4, 3, "PRESS USE ON IT TO PREVENT THIS" );
	self.Entity:SetColor(Color(255,150,150,255))
end

function ENT:Use(activator,caller)
	self.Entity:SetNWBool("sparking",true)
	self.drugmaking = true
	timer.Create( tostring(self.Entity) .. "drug", 30, 1, function() self:createDrug() end)
	timer.Destroy( tostring(self.Entity) .. "fuckafkfags")
	timer.Create( tostring(self.Entity) .. "fuckafkfags", 1200, 1, function() self.shutOff( self) end)
	timer.Destroy( tostring(self.Entity) .. "notifyoff")
	timer.Create( tostring(self.Entity) .. "notifyoff", 950, 1, function() self.notifypl( self) end)
	self.Inactive = false
	self.Entity:SetColor(Color(200,255,200,255))
end

function ENT:createDrug()
	local spos=self.SparkPos
	local ang=self.Entity:GetAngles()
	self.drugmaking = false
	local drugPos = self.Entity:GetPos()
	drug = ents.Create("item_random")
	drug:SetPos(self.Entity:GetPos()+ang:Forward()*spos.x+ang:Right()*spos.y+ang:Up()*spos.z)
	drug:Spawn()
	self.Entity:SetNWBool("sparking",false)
	self.Entity:SetColor(Color(255,255,255,255))	
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
		ply:GetTable().maxmethlab=ply:GetTable().maxmethlab - 1
	end
end