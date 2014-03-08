// copypasta from microwave.

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 42
	
	local ent = ents.Create( "healthdispenser" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
	
end

function ENT:Initialize()

	self.Entity:SetModel( "models/props_combine/health_charger001.mdl" )
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetNWInt("upgrade", 0)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end
	self.Entity:SetNWBool("sparking",false)
	self.Entity:SetNWInt("damage",500)
	local ply = self.Owner
	ply:GetTable().maxhealthdispensers=ply:GetTable().maxhealthdispensers + 1
	self.Entity:SetNWInt("power",0)
	self.Payout={CfgVars["healthdispensercost"],"Health Dispenser"}
end

function ENT:Use(activator,caller)
	if self.Entity:GetNWBool("sparking") == true then return end
	self.Entity:SetNWBool("sparking",true)
	if (self.Entity:GetNWInt("upgrade")==2) then
        if activator:Health()<activator:GetMaxHealth() then
            activator:SetHealth(activator:Health()+35)
            if (activator:Health()>activator:GetMaxHealth()) then activator:SetHealth(activator:GetMaxHealth()) end
        end
		timer.Create( tostring(self.Entity) .. "resup", 0.75, 1,function() self:resupply() end)
	elseif (self.Entity:GetNWInt("upgrade")==1) then
        if activator:Health()<activator:GetMaxHealth() then
            activator:SetHealth(activator:Health()+25)
            if (activator:Health()>activator:GetMaxHealth()) then activator:SetHealth(activator:GetMaxHealth()) end
        end
		timer.Create( tostring(self.Entity) .. "resup", 0.85, 1,function() self:resupply() end)
	elseif (self.Entity:GetNWInt("upgrade")==0) then
        if activator:Health()<activator:GetMaxHealth() then
            activator:SetHealth(activator:Health()+15)
            if (activator:Health()>activator:GetMaxHealth()) then activator:SetHealth(activator:GetMaxHealth()) end
        end
        timer.Create( tostring(self.Entity) .. "resup", 0.95, 1, function() self:resupply() end)
    end
end

function ENT:resupply()
	self.Entity:SetNWBool("sparking",false)
end
 
function ENT:Think()
	if (IsValid(self.Owner)!=true) then
		self.Entity:Remove()
	end
end

function ENT:OnRemove( )
	timer.Destroy(tostring(self.Entity)) 
	local ply = self.Owner
	if IsValid(ply) then
		ply:GetTable().maxhealthdispensers=ply:GetTable().maxhealthdispensers - 1
	end
	timer.Destroy(tostring(self.Entity) .. "resup")
end