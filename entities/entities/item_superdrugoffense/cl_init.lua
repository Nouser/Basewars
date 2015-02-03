include('shared.lua')

function ENT:Initialize()
end

function ENT:Draw()
	self:DrawModel()
	self:DrawEntityOutline(1.0)
end


function ENT:DrawTranslucent( bDontDrawModel )

end

function ENT:Think()
	self.Entity:SetColor(Color(math.random(1,255), math.random(1,25), math.random(1,155), 255))
end


function ENT:DrawEntityOutline( size )
	local matOutlineWhite 	= Material( "Models/effects/comball_tape" )
	local ScaleNormal		= 1
	local ScaleOutline1		= 1.15
	local ScaleOutline2		= 1.25
	local matOutlineBlack 	= Material( "Models/effects/comball_sphere" )
	size = size or 1.0
	render.SuppressEngineLighting( true )
	render.SetAmbientLight( 1, 1, 1 )
	render.SetColorModulation( 1, 1, 1 )
	
	// First Outline
	self.Entity:SetModelScale( ScaleOutline2 * size,0 )
	self.Entity:SetupBones( matOutlineWhite)
	render.MaterialOverride( matOutlineBlack )
	self.Entity:DrawModel()
	
	// Second Outline
	self.Entity:SetModelScale( ScaleOutline1,0 )
	self.Entity:SetupBones()
	render.MaterialOverride( matOutlineWhite )
	self.Entity:DrawModel()
	
	// Revert everything back to how it should be
	render.MaterialOverride( nil )
	self.Entity:SetModelScale( ScaleNormal ,0)
	self.Entity:SetupBones()
	
	render.SuppressEngineLighting( false )
	
	local color = self:GetColor()
	local r = color.r
	local g = color.g
	local b = color.b
	render.SetColorModulation( r/255, g/255, b/255 )
end