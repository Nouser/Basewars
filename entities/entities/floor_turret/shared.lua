
ENT.Type 				= "anim"
ENT.Base 				= "base_structure"
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.PrintName			= "Floor Turret"
ENT.Author				= "KuroLight"
ENT.Contact				= ""

ENT.Spawnable			= false
ENT.AdminSpawnable		= false
ENT.HealthRing			= {300,30,-16.5}
//Most of these variables are obsolete/not used.. dunno why the hell I didn't erase them tho.

ENT.BuiltAddition = 300
ENT.BaseHealth = 500
ENT.Power				= 1

ENT.PoseYaw = 0
ENT.PosePitch = 0

ENT.MaxRange = 1024
ENT.SawShit = 0
ENT.NextFireTime = 0
//0 = 0 Pitch, 1 = 5 Pitch, 2 = 10 Pitch, 3 = 15 Pitch, -1 = -5 Pitch.. so on
ENT.NextPitchChange = CurTime()
ENT.PoseState = 0
ENT.IdealPitch = 0
ENT.EntityTarget = NULL
ENT.colBeam = Color(0,255,0,255)

ENT.colPower = Color(255,0,0,255)

ENT.colBuild = Color(255,0,0,255)
ENT.colLarge = Color(255,0,0,255)
ENT.flashPowerWarning = false
ENT.flash = false
ENT.flashLarge = false
function ENT:GetLocalAnglesToTarget(target)
	return self:WorldToLocalAngles(self:GetAnglesToTarget(target))
end
function ENT:CalculatePoseAngles()
	//self.Owner:PrintMessage(HUD_PRINTTALK,"CalculatePoseAngles()")
	local owner = self:GetTurretOwner()
	local target = self:GetTurretTarget()
	local targetE = NULL
	if(target == -1) then target = NULL
	else
		for k,v in pairs(player.GetAll()) do
			if(k == target) then
				targetE = v
				break
			end
		end
	end
	if(targetE != NULL) then
		if(self.EntityTarget != targetE) then
			self.EntityTarget = targetE
		end
	else
		self.EntityTarget = NULL
	end
	if(self.EntityTarget != NULL) then
		local dotProduct = self:GetForward():DotProduct((self.EntityTarget:GetPos() - self:GetPos()):GetNormal())
		if(self.EntityTarget:GetPos():Distance(self:GetPos()) > self.MaxRange) then
			self.EntityTarget = NULL
		elseif(self.EntityTarget:Health() <= 0) then
			self.EntityTarget = NULL
		elseif(!(dotProduct >= 0.5 && dotProduct >= 0)) then
			self.EntityTarget = NULL
		end

	end
	//owner:PrintMessage(HUD_PRINTTALK,"SharedTarget="..tostring(target))
	if SERVER then
		if(self.EntityTarget != NULL) then
			if self.EntityTarget != NULL && self:IsPowered() && self:GetNWInt("built") == 1 && self:GetNWBool("ison") == true then
				local ang = self:WorldToLocalAngles(((self.EntityTarget:GetPos() + Vector(0,0,30)) - self:ShootPos()):Angle())
				self.PoseYaw = math.Approach(self.PoseYaw, math.Clamp(math.NormalizeAngle(ang.yaw), -60, 60), FrameTime() * 140)
				self.PosePitch = math.Approach(self.PosePitch, math.Clamp(math.NormalizeAngle(ang.pitch), -15, 15), FrameTime() * 100)
			end
			self:SetPoseParameter("aim_yaw", self.PoseYaw)
			self:SetPoseParameter("aim_pitch", self.PosePitch)
		end
	elseif CLIENT then
		if self.EntityTarget != NULL && self:IsPowered() && self:GetNWInt("built") == 1 && self:GetNWBool("ison") == true then
			local ang = self:WorldToLocalAngles(((self.EntityTarget:GetPos() + Vector(0,0,30)) - self:ShootPos()):Angle())
			self.PoseYaw = math.Approach(self.PoseYaw, math.Clamp(math.NormalizeAngle(ang.yaw), -60, 60), FrameTime() * 140)
			self.PosePitch = math.Approach(self.PosePitch, math.Clamp(math.NormalizeAngle(ang.pitch), -15, 15), FrameTime() * 100)
		elseif(!self:IsPowered() || self:GetNWInt("built") == 0 || self:GetNWBool("ison") == false) then
			self.PoseYaw = math.Approach(self.PoseYaw,0,FrameTime() * 60)
			self.PosePitch = math.Approach(self.PosePitch,15,FrameTime() * 60)
		elseif(self.EntityTarget == NULL && self:IsPowered() && self:GetNWInt("built") == 1 && self:GetNWBool("ison") == true) then
			local ct = CurTime()
			self.PoseYaw = math.Approach(self.PoseYaw, math.sin(ct) * 45, FrameTime() * 60)
			self.PosePitch = math.Approach(self.PosePitch,self.PoseState * 3, FrameTime() * 25)
			if(self.NextPitchChange < CurTime()) then
				if(math.Round(self.PoseYaw) == -45 || math.Round(self.PoseYaw) == 45) then
					if(self.PoseState == 0) then
						self.PoseState = 1
					elseif(self.PoseState == 1) then
						self.PoseState = 2
					elseif(self.PoseState == 2) then
						self.PoseState = 3
					elseif(self.PoseState == 3) then
						self.PoseState = 4
					elseif(self.PoseState == 4) then
						self.PoseState = 5
					elseif(self.PoseState == 5) then
						self.PoseState = -5
					elseif(self.PoseState == -5) then
						self.PoseState = -4
					elseif(self.PoseState == -4) then
						self.PoseState = -3
					elseif(self.PoseState == -3) then
						self.PoseState = -2
					elseif(self.PoseState == -2) then
						self.PoseState = -1
					elseif(self.PoseState == -1) then
						self.PoseState = 0
					end
					self.NextPitchChange = CurTime() + 0.5
				end
			end
		end
		self:SetPoseParameter("aim_yaw", self.PoseYaw)
		self:SetPoseParameter("aim_pitch", self.PosePitch)
	end
end
function ENT:DefaultPos()
	return self:GetPos() + self:GetUp() * 55 + self:GetForward() * 15
end
function ENT:SetTurretOwner(ent)
	self:SetNWEntity("owner",ent)
end
function ENT:GetTurretOwner()
	return self:GetNWEntity("owner")
end
function ENT:GetTurretTarget()
	local owner = self:GetTurretOwner()
	//owner:PrintMessage(HUD_PRINTTALK,"target="..tostring(self:GetNWInt("target")))
	return self:GetNWInt("target")
end
function ENT:SetTurretTarget(ent)
	local owner = self:GetTurretOwner()
	//owner:PrintMessage(HUD_PRINTTALK,"SetTarget("..tostring(ent)..")")
	if(ent >= 0) then
		self:SetNWInt("target",ent)
		//self:SetNWEntity("target",player.GetAll()[ent])
	else
		self:SetNWInt("target",-1)
	end
end
function ENT:ShootPos()
	local attachid = self:LookupAttachment("eyes")
	if attachid then
		local attach = self:GetAttachment(attachid)
		if attach then return attach.Pos end
	end

	return self:DefaultPos()
end

function ENT:LaserPos()
	/*
	local attachid = self:LookupAttachment("light")
	if attachid then
		local attach = self:GetAttachment(attachid)
		if attach then return attach.Pos end
	end*/
	local attachInfo = self:GetAttachment(self:LookupAttachment("eyes"))
	local ang = attachInfo.Ang
	return self:ShootPos() - ang:Forward()*3.5 + ang:Up() + ang:Right()/3
end

function ENT:GetGunAngles()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(ang:Right(), -self.PosePitch)
	ang:RotateAroundAxis(ang:Up(), self.PoseYaw)
	return ang
end
