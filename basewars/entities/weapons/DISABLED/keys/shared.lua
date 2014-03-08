if (SERVER) then
	AddCSLuaFile("shared.lua")
	SWEP.Weight				= 1
	SWEP.AutoSwitchTo		= true
	SWEP.AutoSwitchFrom		= true
	SWEP.IconLetter			= "I"
end
if (CLIENT) then
	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair		= true
	SWEP.ViewModelFOV		= 64
	SWEP.ViewModelFlip		= false
	SWEP.CSMuzzleFlashes	= false
	SWEP.PrintName			= "Keys"			
	SWEP.Author				= "Aperture"
	SWEP.Slot				= 1
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "C"
	killicon.AddFont("weapon_c4_re","CSKillIcons",SWEP.IconLetter,Color(255,80,0,255))
end
SWEP.Author			= "Aperture"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_fists.mdl"
SWEP.WorldModel			= ""
SWEP.Instructions		= "Left Click: Lock Doors, Right Click: Unlock Doors."

SWEP.Primary.Recoil			= 0
SWEP.Primary.Damage			= -1
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0
SWEP.Primary.Delay			= 1.0
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1

SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= 1
SWEP.Secondary.DefaultClip	= 1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

function SWEP:Initialize()
	self:SetWeaponHoldType("slam")
end

function SWEP:Deploy()
end

function SWEP:Reload()
end

function SWEP:Think()
end
	
function SWEP:PrimaryAttack()
	if CLIENT then return end
	local pos = self.Owner:EyePos()
	local posang = self.Owner:GetAimVector()
	local tracedata = {}
	tracedata.start = pos
	tracedata.endpos = pos+(posang*100)
	tracedata.filter = self.Owner
	local tr = util.TraceLine(tracedata)


	self:SetNextPrimaryFire(CurTime() + 0.5)
	if tr.HitWorld then return end
	if tr.HitNonWorld then
		local ent = tr.Entity
		if ent:IsDoor() then
			if ent:GetNWEntity("DOwner") == self.Owner then
				if !ent:GetNWBool("Locked") then
					if ent.NextLock and ent.NextLock >= CurTime() then
						self.Owner:PrintMessage(HUD_PRINTTALK, "This Door Cannot Be Locked For Another "..math.floor(ent.NextLock-CurTime()).." Seconds.")
						return
					end
					ent:Fire("Lock","",0)
					ent:SetNWBool("Locked", true)
					ent:EmitSound("doors/door_latch1.wav",70,100)
				end
			end
		end
	end
end

function SWEP:SecondaryAttack()
	if CLIENT then return end
	local pos = self.Owner:EyePos()
	local posang = self.Owner:GetAimVector()
	local tracedata = {}
	tracedata.start = pos
	tracedata.endpos = pos+(posang*100)
	tracedata.filter = self.Owner
	local tr = util.TraceLine(tracedata)

	self:SetNextPrimaryFire(CurTime() + 0.5)
	if tr.HitWorld then return end
	if tr.HitNonWorld then
		local ent = tr.Entity
		if ent:IsDoor() then
			if ent:GetNWEntity("DOwner") == self.Owner then
					if ent:GetNWBool("Locked") then
					ent:Fire("Unlock","",0)
					ent:SetNWBool("Locked", false)
					ent:EmitSound("doors/door_latch1.wav",70,100)
				end
			end
		end
	end
end


function SWEP:CanSecondaryAttack()
	return true
end

function SWEP:Holster()
	return true
end

function SWEP:OnRemove()
	return true
end

function SWEP:DrawWorldModel()
end

function SWEP:ShouldDropOnDie()
	return false
end