AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()

	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:DrawShadow( false )
	
	// Don't collide with the player
	// too bad this doesn't actually work.
	self.Entity:SetCollisionGroup( COLLISION_GROUP_WEAPON )


	
	local phys = self.Entity:GetPhysicsObject()
	
	
	if (phys:IsValid()) then
		phys:Wake()
	end
  self.pressed = false
	
end

function ENT:Explode()
	local vPoint = self.Entity:GetPos()
	local effectdata = EffectData() 
	effectdata:SetStart( vPoint )
	effectdata:SetOrigin( vPoint ) 
	effectdata:SetScale( 0.5 ) 
	util.Effect( "Explosion", effectdata ) 
	self:Kill()
	SafeRemoveEntity(self)
end

function ENT:Use(activator)
if not activator:IsPlayer() then return end
if( self.Pressed ) then return end
	self.pressed = true
    self:Explode()
    activator:Kill()
	--self:EmitSound( "vo/npc/male01/gethellout.wav" )

end
	