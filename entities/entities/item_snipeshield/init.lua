
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 20
	
	local ent = ents.Create( "item_snipeshield" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
	
end

function ENT:Initialize()
	self.Entity:SetModel( "models/items/car_battery01.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end
	self.Entity:SetVar("damage",20)
	self.Time = CurTime()
	self.damage = 100
end

function ENT:OnTakeDamage(dmg)
	self.Damage = (self.Damage or 100) - dmg:GetDamage()
	if self.Damage <= 0 then
		self:Remove()
		self:Destruct()
	end
end

function ENT:Destruct()
	local vPoint = self:GetPos()
	local effectdata = EffectData()
	effectdata:SetStart(vPoint)
	effectdata:SetOrigin(vPoint)
	effectdata:SetScale(1)
	util.Effect("Explosion", effectdata)
end

function ENT:Use(activator,caller)
	if (caller:GetNWBool("shielded")==false) then
		caller:GetTable().Shielded = true
		caller:SetNWBool("shielded", true)
		self.Entity:Remove()
	end
end

function ENT:Think()

end

