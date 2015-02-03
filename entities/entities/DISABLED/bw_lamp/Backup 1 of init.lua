
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

local MODEL = Model( "models/props_wasteland/prison_lamp001c.mdl" )

AccessorFunc( ENT, "Texture", "FlashlightTexture" )

ENT:SetFlashlightTexture( "effects/flashlight001" )

/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()

	self:SetModel( MODEL )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	local ply = self.Owner
	ply:GetTable().maxlamp=ply:GetTable().maxlamp + 1
	self.Entity:SetNWInt("damage",100)
    
    self.Entity:SetNWInt("power",0)
		
	local phys = self:GetPhysicsObject()
	
	self.KeyPress = CurTime()
	
	if (phys:IsValid()) then
		phys:Wake()
	end

	self.Payout={CfgVars["lampcost"],"Lamp"}
end


/*---------------------------------------------------------
   Name: Sets the color of the light
---------------------------------------------------------*/
function ENT:SetLightColor( r, g, b )

	self:SetVar( "lightr", r )
	self:SetVar( "lightg", g )
	self:SetVar( "lightb", b )
	
	self:SetColor( r, g, b, 255 )
	
	self.m_strLightColor = Format( "%i %i %i", r, g, b )
	
	if ( self.flashlight ) then
		self.flashlight:SetKeyValue( "lightcolor", self.m_strLightColor )
	end
    self:TurnOn()
end

/*---------------------------------------------------------
   Name: Sets the texture
---------------------------------------------------------*/
function ENT:SetFlashlightTexture( tex )

	self.Texture = tex
	
	if ( self.flashlight ) then
		self.flashlight:Input( "SpotlightTexture", NULL, NULL, self:GetFlashlightTexture() )
	end
	
end


/*---------------------------------------------------------
   Name: Use
---------------------------------------------------------*/
function ENT:Use( activator, caller )
    self:Toggle()
end

function ENT:Toggle()
    local power = self:GetNWInt("power")
	local ply = self.Owner
	if CurTime( ) >= self.KeyPress then
		if power == self.Power then
			if !self.flashlight then 
				self:TurnOn()
			elseif self.flashlight then
				self:TurnOff()
			end
			self.KeyPress = CurTime( ) + 1;
		else
			Notify(ply,4,3,"Not enough power to turn on!");
			self.KeyPress = CurTime( ) + 1;
		end;
	end;
end

/*---------------------------------------------------------
   Name: Turn On
---------------------------------------------------------*/
function ENT:TurnOn()
    
	
	self:SetOn( true )
    
	local angForward = self:GetAngles() + Angle( 90, 0, 0 )
	
	self.flashlight = ents.Create( "env_projectedtexture" )
	
		self.flashlight:SetParent( self.Entity )
		
		// The local positions are the offsets from parent..
		self.flashlight:SetLocalPos( Vector( 0, 0, 0 ) )
		self.flashlight:SetLocalAngles( Angle(90,90,90) )
		
		// Looks like only one flashlight can have shadows enabled!
		self.flashlight:SetKeyValue( "enableshadows", 1 )
		self.flashlight:SetKeyValue( "farz", 2048 )
		self.flashlight:SetKeyValue( "nearz", 8 )
		
		//Todo: Make this tweakable?
		self.flashlight:SetKeyValue( "lightfov", 50 )
		
		// Color.. Bright pink if none defined to alert us to error
		self.flashlight:SetKeyValue( "lightcolor", self.m_strLightColor or "255 255 255" )
		
	self.flashlight:Spawn()
	self.flashlight:Input( "SpotlightTexture", NULL, NULL, self:GetFlashlightTexture() )
	
	local power = self:GetNWInt("power")
		if power != 1 then
			self:SetOn(false)
			SafeRemoveEntity( self.flashlight )
			self.flashlight = nil
		return ""
	end
        
end

function ENT:TurnOff()
	self:SetOn(false)
	SafeRemoveEntity( self.flashlight )
	self.flashlight = nil
end

function ENT:Think()
	if (ValidEntity(self.Owner)==false) then
		self.Entity:Remove()
	end
	self.Entity:NextThink(CurTime()+0.1)
	return true
end

function ENT:OnRemove( )
	local ply = self.Owner
	if ValidEntity(ply) then
		ply:GetTable().maxlamp=ply:GetTable().maxlamp - 1
	end
end