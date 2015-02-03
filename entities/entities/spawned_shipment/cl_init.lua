include("shared.lua")

function ENT:Draw()
	if LocalPlayer():GetPos():Distance(self:GetPos()) > 1000 then return end
	
	self.Entity:DrawModel()
	
	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	
	local content = self.contents
	local contents = self:GetNWString("Contents")
	--if not contents then return end
	--contents = contents.name
	
	surface.SetFont("Trebuchet24")
	local TextWidth = surface.GetTextSize("Contents:")
	local TextWidth2 = surface.GetTextSize(contents)
	
	cam.Start3D2D(Pos + Ang:Up() * 25, Ang, 0.2)
		draw.WordBox(2, -TextWidth*0.5 + 5, -30, "Contents:", "Trebuchet24", Color(140, 0, 0, 100), Color(255,255,255,255))
		draw.WordBox(2, -TextWidth2*0.5 + 5, 18, contents, "Trebuchet24", Color(140, 0, 0, 100), Color(255,255,255,255))
	cam.End3D2D()
	
	Ang:RotateAroundAxis(Ang:Forward(), 90)
	
	local contentremaining = self:GetNWString("ContentsRemain")
	
	TextWidth = surface.GetTextSize("Amount left:")
	TextWidth2 = surface.GetTextSize(contentremaining)
	
	cam.Start3D2D(Pos + Ang:Up() * 17, Ang, 0.14)
		draw.WordBox(2, -TextWidth*0.5 + 5, -150, "Amount left:", "Trebuchet24", Color(140, 0, 0, 100), Color(255,255,255,255))
		draw.WordBox(2, -TextWidth2*0.5 + 0, -102, contentremaining, "Trebuchet24", Color(140, 0, 0, 100), Color(255,255,255,255))
	cam.End3D2D()
end