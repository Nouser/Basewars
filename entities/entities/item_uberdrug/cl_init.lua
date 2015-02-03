include('shared.lua')

function ENT:Initialize()
	self.orbit = 0
end

function ENT:Draw()
	/*
	if ( EyePos():Distance( self.Entity:GetPos() ) < 512 ) then
	
		if ( self.RenderGroup == RENDERGROUP_OPAQUE ) then
			self.OldRenderGroup = self.RenderGroup
			self.RenderGroup = RENDERGROUP_TRANSLUCENT
		end

	else
	
		if ( self.OldRenderGroup != nil ) then
		
			self.RenderGroup = self.OldRenderGroup
			self.OldRenderGroup = nil
		
		end
	
	end*/
	self:DrawEntityOutline(1.0)
	self:DrawModel()
end


function ENT:DrawTranslucent( bDontDrawModel )

	if ( bDontDrawModel ) then return end
	//render.SuppressEngineLighting( true )
	self:DrawEntityOutline(1.0)
	
	self:DrawModel()
	//render.SuppressEngineLighting( false )
end

function ENT:Think()
	self.Entity:SetColor(Color(math.random(1,255), math.random(1,255), math.random(1,255), 255))
end


function ENT:DrawEntityOutline( sizeA )
	local matOutlineWhite 	= Material( "Models/effects/comball_tape" )
	local ScaleNormal		= 1
	local ScaleOutline1		= 1.15
	local ScaleOutline2		= 1.25
	local matOutlineBlack 	= Material( "Models/effects/comball_sphere" )
	local sprite = Material("sprites/light_glow02_add")
	local size = sizeA or 1.0
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
	self.Entity:SetModelScale( ScaleNormal,0 )
	self.Entity:SetupBones()
	
	
	local color = self:GetColor()
	local r = color.r
	local g = color.g
	local b = color.b
	render.SetColorModulation( r/255, g/255, b/255 )
	self.orbit = self.orbit + (5 * FrameTime())
	if self.orbit>=360 then
		self.orbit=self.orbit-360
	end
	local dist = 10
	local pos = self.Entity:GetPos()
	self.orbitpos = Vector((math.cos(self.orbit)*dist)+pos.x, (math.sin(self.orbit)*dist)+pos.y, (math.sin(self.orbit)*dist)+pos.z)
	render.SetMaterial(sprite)
	render.DrawSprite(self.orbitpos, 10, 10, Color(math.random(0,255),math.random(0,255),math.random(0,255),255))
	self.orbitpos2 = Vector((math.cos(self.orbit)*dist)+pos.x, (math.sin(self.orbit)*dist)+pos.y, (math.sin(-self.orbit)*dist)+pos.z)
	render.DrawSprite(self.orbitpos2, 10, 10, Color(math.random(0,255),math.random(0,255),math.random(0,255),255))
	self.orbitpos3 = Vector((math.cos(self.orbit)*dist)+pos.x, (math.sin(-self.orbit)*dist)+pos.y, (math.sin(-self.orbit)*dist)+pos.z)
	render.DrawSprite(self.orbitpos3, 10, 10, Color(math.random(0,255),math.random(0,255),math.random(0,255),255))
	self.orbitpos4 = Vector((math.cos(self.orbit)*dist)+pos.x, (math.sin(-self.orbit)*dist)+pos.y, (math.sin(self.orbit)*dist)+pos.z)
	render.DrawSprite(self.orbitpos4, 10, 10, Color(math.random(0,255),math.random(0,255),math.random(0,255),255))
	render.DrawSprite(pos,40,40,Color(255,255,255,math.random(100,255)))
	self.randpos = Vector(pos.x+math.random(-10,10), pos.y+math.random(-10,10), pos.z+math.random(-10,10))
	self.tempsize = math.random(5,15)
	render.DrawSprite(self.randpos, self.tempsize, self.tempsize, Color(255,255,255,math.random(100,255)))
end