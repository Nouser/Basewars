//ENT.Base = "base_entity"
ENT.Type = "anim"

ENT.PrintName		= "Sticky Grenade"
ENT.Author			= "Night-Eagle"
ENT.Contact			= "gmail sedhdi"
ENT.Purpose			= nil
ENT.Instructions	= nil


/*---------------------------------------------------------
   Name: ENT:OnRemove()
---------------------------------------------------------*/
function ENT:OnRemove()
end

/*---------------------------------------------------------
   Name: ENT:PhysicsUpdate()
---------------------------------------------------------*/
function ENT:PhysicsUpdate()
end


/*
function ENT:PhysicsCollide(data,phys)
	if data.Speed > 50 then
		self.Entity:EmitSound(Sound("HEGrenade.Bounce"))
	end
	
	local impulse = -data.Speed * data.HitNormal * .4 + (data.OurOldVelocity * -.6)
	phys:ApplyForceCenter(impulse)
end
*/