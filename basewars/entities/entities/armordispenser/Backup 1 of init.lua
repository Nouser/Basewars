// copypasta from microwave.

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 42
	
	local ent = ents.Create( "armordispenser" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
	
end

function ENT:Initialize()

	self.Entity:SetModel( "models/props_combine/suit_charger001.mdl" )
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetNWInt("upgrade", 0)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end
	self.Entity:SetNWBool("sparking",false)
	self.Entity:SetNWInt("damage",500)
	local ply = self.Owner
	ply:GetTable().maxarmordispensers=ply:GetTable().maxarmordispensers + 1
	self.Entity:SetNWInt("power",0)
//	self.scrap = false
	self.Payout = {CfgVars["armordispensercost"],"Armor Dispenser"}
end

function ENT:Use(activator,caller)
	if self.Entity:GetNWBool("sparking") == true then return end
	self.Entity:SetNWBool("sparking",true)
	if (self.Entity:GetNWInt("upgrade")==2) then
        if activator:Armor()<100 then
            activator:SetArmor(activator:Armor()+35)
            if (activator:Armor()>100) then activator:SetArmor(100) end
        end
		timer.Create( tostring(self.Entity) .. "resup", 0.75, 1,function() self:resupply() end)
	elseif (self.Entity:GetNWInt("upgrade")==1) then
        if activator:Armor()<100 then
            activator:SetArmor(activator:Armor()+25)
            if (activator:Armor()>100) then activator:SetArmor(100) end
        end
		timer.Create( tostring(self.Entity) .. "resup", 0.85, 1,function() self:resupply() end)
	elseif (self.Entity:GetNWInt("upgrade")==0) then
        if activator:Armor()<100 then
            activator:SetArmor(activator:Armor()+15)
            if (activator:Armor()>100) then activator:SetArmor(100) end
        end
        timer.Create( tostring(self.Entity) .. "resup", 0.95, 1,function() self:resupply() end)
    end
end

function ENT:resupply()
	self.Entity:SetNWBool("sparking",false)
end
 
function ENT:Think()
	if (ValidEntity(self.Owner)!=true) then
		self.Entity:Remove()
	end
end

function ENT:OnRemove( )
	timer.Destroy(tostring(self.Entity)) 
	local ply = self.Owner
	if ValidEntity(ply) then
		ply:GetTable().maxarmordispensers=ply:GetTable().maxarmordispensers - 1
	end
	timer.Destroy(tostring(self.Entity) .. "resup")
end