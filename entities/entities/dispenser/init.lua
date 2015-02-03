
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 42
	
	local ent = ents.Create( "dispenser" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
	
end

function ENT:Initialize()

	self.Entity:SetModel( "models/props_lab/reciever_cart.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetNWInt("upgrade", 0)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end
	self.Entity:SetNWBool("sparking",false)
	self.Entity:SetNWInt("damage",500)
	local ply = self.Owner
	ply:GetTable().maxdispensers=ply:GetTable().maxdispensers + 1
	self.Entity:SetNWInt("power",0)
	self.Payout={CfgVars["dispensercost"],"Ammo Dispenser"}
end

function ENT:Use(activator,caller)
	if self.Entity:GetNWBool("sparking") == true then return end
	plgun = activator:GetActiveWeapon()
//	if activator:Health()<activator:GetMaxHealth() then
//		activator:SetHealth(activator:Health()+15)
//		if (activator:Health()>activator:GetMaxHealth()) then activator:SetHealth(activator:GetMaxHealth()) end
//	end
	// if they have rocket launcher swep, and no ammo, give them ammo so they can select it.
	self.Entity:SetNWBool("sparking",true)
	if (self.Entity:GetNWInt("upgrade")>0) then
		timer.Create( tostring(self.Entity) .. "resup", 0.75, 1, function() self:resupply() end)
	else
		timer.Create( tostring(self.Entity) .. "resup", 1, 1, function() self:resupply() end)
	end
	if (activator:GetAmmoCount("rpg_round")<=0 && activator:HasWeapon("weapon_rocketlauncher")) then
		activator:GiveAmmo(2, "rpg_round")
		return "" ;
	end
	if (activator:GetAmmoCount("xbowbolt")<=0 && activator:HasWeapon("weapon_tranqgun")) then
		activator:GiveAmmo(5, "xbowbolt")
		return "" ;
	end
	if (plgun:GetClass() == "weapon_rpg") then
		activator:GiveAmmo(2, plgun:GetPrimaryAmmoType())
	elseif (plgun:Clip1()>0) then
		activator:GiveAmmo(plgun:Clip1()*2, plgun:GetPrimaryAmmoType())
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
		ply:GetTable().maxdispensers=ply:GetTable().maxdispensers - 1
	end
	timer.Destroy(tostring(self.Entity) .. "resup")
end