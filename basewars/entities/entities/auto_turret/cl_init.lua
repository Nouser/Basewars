
include('shared.lua')

ENT.RenderGroup 		= RENDERGROUP_OPAQUE

function ENT:Draw( bDontDrawModel )
	if LocalPlayer():GetPos():Distance(self:GetPos()) > 1000 then return end
	
	self.Entity:DrawModel()
end
function ENT:GetOverlayText()

	return self:GetPlayerName()	
	
end
