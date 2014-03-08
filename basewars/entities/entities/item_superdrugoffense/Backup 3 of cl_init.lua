include('shared.lua')

function ENT:Initialize()
end

function ENT:Draw()
	if ( EyePos():Distance( self.Entity:GetPos() ) < 256 ) then
	
		if ( self.RenderGroup == RENDERGROUP_OPAQUE ) then
			self.OldRenderGroup = self.RenderGroup
			self.RenderGroup = RENDERGROUP_TRANSLUCENT
		end

	else
	
		if ( self.OldRenderGroup != nil ) then
		
			self.RenderGroup = self.OldRenderGroup
			self.OldRenderGroup = nil
		
		end
	
	end

	if ( !bDontDrawModel ) then self:DrawModel() end
end


function ENT:DrawTranslucent( bDontDrawModel )

	if ( bDontDrawModel ) then return end
	
	if (  EyePos():Distance( self.Entity:GetPos() ) < 256 ) then
	
		self:DrawEntityOutline( 1.0 )
		
	end
	
	self:Draw()

end

function ENT:Think()
	self.Entity:SetColor(Color(math.random(1,255), math.random(1,25), math.random(1,155), 255))
end

local matOutlineWhite 	= Material( "Models/effects/comball_tape" )
local ScaleNormal		= Vector()
local ScaleOutline1		= Vector() * 1.25
local ScaleOutline2		= Vector() * 1.2
local matOutlineBlack 	= Material( "Models/effects/comball_sphere" )

function ENT:DrawEntityOutline( size )
	
	size = size or 1.0
	render.SuppressEngineLighting( true )
	render.SetAmbientLight( 1, 1, 1 )
	render.SetColorModulation(Color( 1, 1, 1 ))
	
	// First Outline
	self.Entity:SetModelScale( ScaleOutline2 * size )
	self.Entity:SetupBones( matOutlineWhite)
	render.MaterialOverride( matOutlineBlack )
	self.Entity:DrawModel()
	
	// Second Outline
	self.Entity:SetModelScale( ScaleOutline1 )
	self.Entity:SetupBones()
	render.MaterialOverride( matOutlineWhite )
	self.Entity:DrawModel()
	
	// Revert everything back to how it should be
	render.MaterialOverride( nil )
	self.Entity:SetModelScale( ScaleNormal )
	self.Entity:SetupBones()
	
	render.SuppressEngineLighting( false )
	
	local r, g, b = self:GetColor()
	render.SetColorModulation(Color( r/255, g/255, b/255 ))
end