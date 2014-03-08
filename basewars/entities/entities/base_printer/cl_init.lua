include('shared.lua')


function ENT:Draw( bDontDrawModel )
	if LocalPlayer():GetPos():Distance(self:GetPos()) > 1000 then return end
	
	self.Entity:DrawModel()
	if(self.ShouldDraw) then
		local Pos = self:GetPos()
		local Ang = self:GetAngles()
		
		local owner = self.Owner
		owner = (IsValid(owner) and owner:Nick()) or "unknown"
		local upgrade = self.Entity:GetNWInt("upgrade")
		
		surface.SetFont("HUDNumber5")
		local TextWidth = surface.GetTextSize(self.HoverName)
		local TextWidth2 = surface.GetTextSize("Level:"..upgrade)
		local TextWidth3 = surface.GetTextSize(owner) 

		Ang:RotateAroundAxis(Ang:Up(), 90)

		local Health = self:GetNWInt("damage")
		local HealthPercent = (self:GetNWInt("damage") / 150) * 200
		local DamageColorScale = Color(0, 159, 107, 155)

		if Health < 50 then 
			DamageColorScale = Color(255, 205, 0, 155)
		end
		if Health < 25 then 
			DamageColorScale = Color(180, 0, 0, 100)

		end
			--cam.IgnoreZ( true )
		cam.Start3D2D(Pos + Ang:Up() * self.UpOffset, Ang, self.CamScale)
			draw.WordBox(.75, -TextWidth*0.5, -70, self.HoverName, "HUDNumber5", self.BackColor,self.TextColor)
			draw.WordBox(.75, -TextWidth2*0.5, -24, "Level:"..upgrade, "HUDNumber5", self.BackColor,self.TextColor)
			draw.RoundedBox(.75,  -100, 22, HealthPercent, TextWidth2 * 0.3, DamageColorScale)
	//		draw.RoundedBox(5, TextWidth2 * 0.3 * 0.5, 22, math.Clamp(Health,0,100)*2, TextWidth2 * 0.3, DamageColorScale)
		cam.End3D2D()
			--cam.IgnoreZ( false )
	end
end