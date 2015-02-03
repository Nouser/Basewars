
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 20
	
	local ent = ents.Create( "item_armor" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
	
end

function ENT:Initialize()
	self.Entity:SetModel( "models/pcv_hax.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
//	self.Entity:SetColor(Color(255,255,255,255))
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end
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
	if (caller:Armor()<100) then
		caller:SetArmor(100)
		self.Entity:Remove()
	end
end

function ENT:Think()

end

