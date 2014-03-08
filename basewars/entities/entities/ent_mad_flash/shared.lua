/*ENT.Type 			= "anim"
ENT.PrintName		= "Flash"
ENT.Author			= "Worshipper"
ENT.Contact			= "Josephcadieux@hotmail.com"
ENT.Purpose			= ""
ENT.Instructions		= ""


function ENT:SetupDataTables()  

	self:DTVar("Boal", 0, "Explode")
end 


function ENT:OnRemove()
end


function ENT:PhysicsUpdate()
end

function ENT:PhysicsCollide(data, phys)

	if data.Speed > 50 then
		self.Entity:EmitSound(Sound("Flashbang.Bounce"))
	end
	
	local impulse = -data.Speed * data.HitNormal * 0.4 + (data.OurOldVelocity * -0.6)
	phys:ApplyForceCenter(impulse)

	if not self.Collide then self.Collide = false end
	if self.Collide then return end

	timer.Simple(0.9, function()
		if not self.Entity then return end
		if not IsFirstTimePredicted() then return end

		self.Entity:SetDTBool(0, true)
	end)

	timer.Simple(1, function()
		if not self.Entity then return end
		if not IsFirstTimePredicted() then return end
	
		self:Explode()
	end)

	self.Entity.Collide = true
end*/

// raped version of flashbang.

//ENT.Base = "base_entity"
ENT.Type = "anim"

ENT.PrintName		= "Stungrenade"
ENT.Author			= "HLTV Proxy"
ENT.Contact			= ""
ENT.Purpose			= nil
ENT.Instructions	= nil


/*---------------------------------------------------------
   Name: OnRemove
   Desc: Called just before entity is deleted
---------------------------------------------------------*/
function ENT:OnRemove()
end

function ENT:PhysicsUpdate()
end

function ENT:PhysicsCollide(data,phys)
	if data.Speed > 50 then
		self.Entity:EmitSound(Sound("Flashbang.Bounce"))
	end
	
	local impulse = -data.Speed * data.HitNormal * .4 + (data.OurOldVelocity * -.6)
	phys:ApplyForceCenter(impulse)
end
