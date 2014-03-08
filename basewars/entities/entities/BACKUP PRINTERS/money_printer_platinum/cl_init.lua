include('shared.lua')

function ENT:Draw( bDontDrawModel )
	self.Entity:DrawModel()
	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	
	local owner = self.Owner
	owner = (IsValid(owner) and owner:Nick()) or "unknown"
	local upgrade = self.Entity:GetNWInt("upgrade")
	
	surface.SetFont("HUDNumber5")
	local TextWidth = surface.GetTextSize("Platinum Money Printer")
	local TextWidth2 = surface.GetTextSize("Level:"..upgrade)
	local TextWidth3 = surface.GetTextSize(owner) 

	Ang:RotateAroundAxis(Ang:Up(), 90)

	local Health = self:GetNWInt("damage") / 10
	local DamageColorScale = Color(0, 159, 107, 155)

		if Health < 50 then 
			DamageColorScale = Color(255, 205, 0, 155)
end
			if Health < 25 then 
			DamageColorScale = Color(180, 0, 0, 100)

end

	cam.Start3D2D(Pos + Ang:Up() * 13, Ang, 0.2)
		draw.WordBox(.75, -TextWidth*0.5, -70, "Platinum Money Printer", "HUDNumber5", Color(101, 255, 101, 155), Color(255,255,255,255))
		draw.WordBox(.75, -TextWidth2*0.5, -24, "Level:"..upgrade, "HUDNumber5", Color(101, 255, 101, 155), Color(255,255,255,255))
		draw.RoundedBox(5, -TextWidth2*0.5 + 30, 22, math.Clamp(Health,0,100)*2, TextWidth2 * 0.3, DamageColorScale)
	cam.End3D2D()
end