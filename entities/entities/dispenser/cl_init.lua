include('shared.lua')

function ENT:Draw( bDontDrawModel )
	if LocalPlayer():GetPos():Distance(self:GetPos()) > 1000 then return end
	
	self.Entity:DrawModel()
end