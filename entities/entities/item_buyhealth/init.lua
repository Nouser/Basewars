
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 20
	
	local ent = ents.Create( "item_buyhealth" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
	self.Entity:SetModel( "models/items/healthkit.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end
	self.Usable=false
	timer.Create(tostring(self.Entity) .. "lol", 2, 1, function() self:UsableGet() end)
	self.Time = CurTime()
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
	if (caller:Health()<caller:GetMaxHealth() && self.Usable==true) then
		caller:SetHealth(caller:GetMaxHealth())
		if caller:GetTable().PoisonDuration>0 && math.random()>0.5 then
			PoisonPlayer(caller, caller:GetTable().PoisonDuration*2, caller:GetTable().PoisonAttacker, caller:GetTable().PoisonInflictor)
			Notify(caller,1,3,"Bought medkits usually only make the poison worse! Find a Medic or dispenser!")
		end
		self.Entity:Remove()
	end
end

function ENT:Think()

end
function ENT:UsableGet()
	self.Usable=true
end
