
include('shared.lua')



function ENT:GetOverlayText()

	return self:GetPlayerName()	
	
end

function ENT:Initialize()
	killicon.AddFont("floor_turret","CSKillIcons","C",Color(100,100,100,255))
	self.colBeam = Color(0,255,0,255)

	self.colPower = Color(255,0,0,255)
	self.colLarge = Color(255,0,0,255)
	self.colBuild = Color(255,0,0,255)
	self.flashPowerWarning = false
	self.flash = false
end
local matBeam = Material("effects/laser1")
local matGlow = Material("sprites/glow04_noz")
local aScreen = Angle(0, 270, 60)
local vScreen = Vector(0, -2, 45)

function ENT:Draw()
	if LocalPlayer():GetPos():Distance(self:GetPos()) > 1000 then return end
	
	self.Entity:DrawModel()
	local owner = self:GetTurretOwner()
	self:CalculatePoseAngles()
	
	//self:DrawShadow()
	
	local wid, hei = 128, 122
	cam.Start3D2D(self:LocalToWorld(vScreen), self:LocalToWorldAngles(aScreen), 0.075)

		surface.SetDrawColor(0, 0, 0, 160)
		surface.DrawRect(0, 0, wid, hei)

		surface.SetDrawColor(200, 200, 200, 160)
		//surface.DrawRect(0, 0, 8, 16)
		//surface.DrawRect(wid - 8, 0, 8, 16)
		surface.DrawRect(0,0,8,hei)
		surface.DrawRect(wid-8,0,8,hei)
		surface.DrawRect(8, 0, wid - 16, 8)

		//surface.DrawRect(0, hei - 16, 8, 16)
		//surface.DrawRect(wid - 8, hei - 16, 8, 16)
		surface.DrawRect(8, hei - 8, wid - 16, 8)
		local healthpercent = 0
		if(self:GetNWInt("built") == 0) then
			healthpercent = self:GetNWInt("damage") / self.BaseHealth
		else
			healthpercent = self:GetNWInt("damage") / (self.BaseHealth + self.BuiltAddition)
		end
		healthpercent = healthpercent
		if owner:IsValid() and owner:IsPlayer() then
			draw.SimpleText("["..owner:Nick().."]", "DefaultBold", wid * 0.5, hei - 70, Color(0,255,0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		end
		draw.SimpleText("[Integrity: "..math.ceil(healthpercent * 100).."%]", "DefaultBold", wid * 0.5, hei - 55, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		local powerText = ""
		local buildText = ""
		if(self:GetNWBool("ison") == true) then
			local rate = FrameTime() * 396
			buildText = "[STATUS: ON]"
			self.colBuild.r = math.Approach(self.colBuild.r,0,rate)
			self.colBuild.g = math.Approach(self.colBuild.g,255,rate)
			self.colBuild.b = math.Approach(self.colBuild.b,0,rate)
		else
			local rate = FrameTime() * 396
			buildText = "[STATUS: OFF]"
			self.colBuild.r = math.Approach(self.colBuild.r,255,rate)
			self.colBuild.g = math.Approach(self.colBuild.g,0,rate)
			self.colBuild.b = math.Approach(self.colBuild.b,0,rate)
		end
		if(self:IsPowered()) then
			powerText = "[POWERED]"
			local rate = FrameTime() * 396
			self.colPower.r = math.Approach(self.colPower.r,0,rate)
			self.colPower.g = math.Approach(self.colPower.g,255,rate)
			self.colPower.b = math.Approach(self.colPower.b,0,rate)
		else
			powerText = "[NO POWER]"
			local rate = FrameTime() * 128
			if(self.flashPowerWarning) then
				self.colPower.r = math.Approach(self.colPower.r,255,rate)
				self.colPower.g = math.Approach(self.colPower.g,0,rate)
				self.colPower.b = math.Approach(self.colPower.b,0,rate)
			else
				self.colPower.r = math.Approach(self.colPower.r,255,rate)
				self.colPower.g = math.Approach(self.colPower.g,127,rate)
				self.colPower.b = math.Approach(self.colPower.b,0,rate)
			end
		end
		if(self.flashPowerWarning && self.colPower.r == 255 && self.colPower.g == 0) then
			self.flashPowerWarning = false
		elseif(!self.flashPowerWarning && self.colPower.r == 255 && self.colPower.g == 127) then
			self.flashPowerWarning = true
		end
		draw.SimpleText("[Range:"..self.MaxRange.."]","DefaultBold",wid*0.5,hei-100,Color(0,127,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP)
		draw.SimpleText(powerText,"DefaultBold",wid * 0.5, hei - 25, self.colPower, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		draw.SimpleText("[Target="..tostring(self:GetTurretTarget()).."]","DefaultBold",wid * 0.5, hei - 85, Color(0,127,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		draw.SimpleText(buildText,"DefaultBold",wid * 0.5, hei - 40, self.colBuild, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		draw.SimpleText("[UPGRADE LEVEL "..self:GetNWInt("upgrade").." / ".."3".."]", "DefaultBold", wid * 0.5, hei - 10, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)


	cam.End3D2D()
	return true;
end
function ENT:DrawTranslucent()
	//Msg("DrawTranslucent")
	local lightpos = self:LaserPos()

	local ang = self:GetGunAngles()


	if self:GetTurretTarget() != -1 && self:IsPowered() && self:GetNWInt("built") == 1 && self:GetNWBool("ison") == true then
		local rate = FrameTime() * 1024
		self.colBeam.r = math.Approach(self.colBeam.r, 255, rate)
		self.colBeam.g = math.Approach(self.colBeam.g, 0, rate)
		self.colBeam.b = math.Approach(self.colBeam.b, 0, rate)
	elseif(!self:IsPowered() || self:GetNWInt("built") == 0) then
		local rate = FrameTime() * 256
		if(!self.flash) then
			self.colBeam.r = math.Approach(self.colBeam.r, 255, rate)
			self.colBeam.g = math.Approach(self.colBeam.g, 127, rate)
			self.colBeam.b = math.Approach(self.colBeam.b, 0, rate)
		elseif(self.flash) then
			self.colBeam.r = math.Approach(self.colBeam.r,255,rate)
			self.colBeam.g = math.Approach(self.colBeam.g,0,rate)
			self.colBeam.b = math.Approach(self.colBeam.b,0,rate)
		end
		if(self.colBeam.r >= 255 && self.colBeam.g >= 127 && !self.flash) then self.flash = true
		elseif(self.colBeam.r >= 255 && self.colBeam.g <= 0 && self.flash) then self.flash = false end
	elseif(self:IsPowered() && self:GetNWInt("built") == 1 && self:GetNWBool("ison") == false) then
		local rate = FrameTime() * 256
		self.colBeam.r = math.Approach(self.colBeam.r,0,rate)
		self.colBeam.g = math.Approach(self.colBeam.g,127,rate)
		self.colBeam.b = math.Approach(self.colBeam.b,255,rate)
	elseif(self:IsPowered() && self:GetNWInt("built") == 1 && self:GetNWBool("ison") == true && self:GetTurretTarget() == -1) then
		local rate = FrameTime() * 256
		self.colBeam.r = math.Approach(self.colBeam.r, 0, rate)
		self.colBeam.g = math.Approach(self.colBeam.g, 255, rate)
		self.colBeam.b = math.Approach(self.colBeam.b, 0, rate)
	else
		local rate = FrameTime() * 256
		self.colBeam.r = math.Approach(self.colBeam.r, 0, rate)
		self.colBeam.g = math.Approach(self.colBeam.g, 127, rate)
		self.colBeam.b = math.Approach(self.colBeam.b, 255, rate)
	end
	//render.SetMaterial(matBeam)
	//render.DrawBeam(lightpos, tr.HitPos, 1, 0, 1, COLOR_WHITE)
	//render.DrawBeam(lightpos, tr.HitPos, 4, 0, 1, self.colBeam)
	//render.SetMaterial(matGlow)
	//render.DrawSprite(lightpos, 4, 4, COLOR_WHITE)
	//render.DrawSprite(lightpos, 16, 16, self.colBeam)
	//render.DrawSprite(tr.HitPos, 2, 2, COLOR_WHITE)
	//render.DrawSprite(tr.HitPos, 8, 8, self.colBeam)
	local shootPos = Vector(0,0,0)
	local attachInfo = self:GetAttachment(self:LookupAttachment("eyes"))
	local lightInfo = self:GetAttachment(self:LookupAttachment("light"))
	ang = attachInfo.Ang
	shootPos = self:ShootPos() - ang:Forward()*3.5 + ang:Up() + ang:Right()/3
	//local tr = util.TraceLine({start = lightpos, endpos = lightpos + ang:Forward() * self.MaxRange, mask = MASK_SHOT,filter = self})
	local trA = util.TraceLine({start = self:ShootPos(), endpos = (self:ShootPos() - ang:Forward()*3.5 + ang:Up() + ang:Right()/3) + ang:Forward() * self.MaxRange, mask = MASK_SHOT, filter = self})
	render.SetMaterial(matGlow)
	if(self:IsPowered() && self:GetNWInt("built") == 1) then
		if(self:GetNWInt("target") != -1) then
			if(self.flashLarge) then
				local rate = FrameTime() * 396
				self.colLarge.r = math.Approach(self.colLarge.r,255,rate)
				self.colLarge.g = math.Approach(self.colLarge.g,0,rate)
				self.colLarge.b = math.Approach(self.colLarge.b,0,rate)
				render.DrawSprite(lightInfo.Pos + lightInfo.Ang:Forward()/3,4,4,COLOR_WHITE)
				render.DrawSprite(lightInfo.Pos + lightInfo.Ang:Forward()/3,16,16,self.colLarge)
			else
				local rate = FrameTime() * 396
				self.colLarge.r = math.Approach(self.colLarge.r,255,rate)
				self.colLarge.g = math.Approach(self.colLarge.g,127,rate)
				self.colLarge.b = math.Approach(self.colLarge.b,0,rate)
				render.DrawSprite(lightInfo.Pos + lightInfo.Ang:Forward()/3,4,4,COLOR_WHITE)
				render.DrawSprite(lightInfo.Pos + lightInfo.Ang:Forward()/3,16,16,self.colLarge)
			end
			if(self.flashLarge && self.colLarge.r == 255 && self.colLarge.g == 0) then
				self.flashLarge = false
			elseif(!self.flashLarge && self.colLarge.r == 255 && self.colLarge.g == 127) then
				self.flashLarge = true
			end
		else
			if(self:GetNWBool("ison")) then
				local rate = FrameTime() * 256
				self.colLarge.r = math.Approach(self.colLarge.r,255,rate)
				self.colLarge.g = math.Approach(self.colLarge.g,127,rate)
				self.colLarge.b = math.Approach(self.colLarge.b,0,rate)
				render.DrawSprite(lightInfo.Pos + lightInfo.Ang:Forward()/3,4,4,COLOR_WHITE)
				render.DrawSprite(lightInfo.Pos + lightInfo.Ang:Forward()/3,16,16,self.colLarge)
			else
				local rate = FrameTime() * 256
				self.colLarge.r = math.Approach(self.colLarge.r,127,rate)
				self.colLarge.g = math.Approach(self.colLarge.g,255,rate)
				self.colLarge.b = math.Approach(self.colLarge.b,0,rate)
				render.DrawSprite(lightInfo.Pos + lightInfo.Ang:Forward()/3,2,2,COLOR_WHITE)
				render.DrawSprite(lightInfo.Pos + lightInfo.Ang:Forward()/3,12,12,self.colLarge)
			end
		end
	else
		local rate = FrameTime() * 256
		self.colLarge.r = math.Approach(self.colBeam.r,0,rate)
		self.colLarge.g = math.Approach(self.colBeam.g,0,rate)
		self.colLarge.b = math.Approach(self.colBeam.b,0,rate)
		render.DrawSprite(lightInfo.Pos + lightInfo.Ang:Forward()/3,4,4,COLOR_WHITE)
		render.DrawSprite(lightInfo.Pos + lightInfo.Ang:Forward()/3,16,16,self.colLarge)
	end
	if(self:IsPowered() && self:GetNWInt("built") == 1) then
		render.SetMaterial(matBeam)
	//	render.DrawBeam(shootPos, trA.HitPos,0.25,0,1,COLOR_WHITE)
		render.DrawBeam(shootPos, trA.HitPos,2,0,1,self.colBeam)
		render.SetMaterial(matGlow)
		render.DrawSprite(shootPos,2,2, COLOR_WHITE)
		render.DrawSprite(shootPos,12,12, self.colBeam)
		render.DrawSprite(trA.HitPos,1,1, COLOR_WHITE)
		render.DrawSprite(trA.HitPos,3,3, self.colBeam)
	end
	return true;
end