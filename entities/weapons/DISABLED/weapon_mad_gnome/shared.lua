// Variables that are used on both client and server

SWEP.Base 				= "weapon_mad_base"

SWEP.ViewModelFOV			= 47
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/props_junk/PopCan01a.mdl" // Don't want to see a view model so I put a random model to hide it
SWEP.WorldModel			= "models/weapons/w_fists_t.mdl"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true

SWEP.Primary.Sound		= Sound("weapons/ar2/npc_ar2_altfire.wav")
SWEP.Primary.Recoil		= 0
SWEP.Primary.Damage		= 0
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.075
SWEP.Primary.Delay 		= 0.35

SWEP.Primary.ClipSize		= -1					// Size of a clip
SWEP.Primary.DefaultClip	= 1					// Default number of bullets in a clip
SWEP.Primary.Automatic		= false				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.Delay 		= 0.40

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "none"				// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"
SWEP.ShellDelay			= 0

SWEP.Pistol				= true
SWEP.Rifle				= false
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos 		= Vector (0, 0, 0)
SWEP.IronSightsAng 		= Vector (0, 0, 0)
SWEP.RunArmOffset 		= Vector (0, 0, 0)
SWEP.RunArmAngle 			= Vector (0, 0, 0)

SWEP.Model				= "none"

/*---------------------------------------------------------
   Name: SWEP:Initialize()
   Desc: Called when the weapon is first loaded.
---------------------------------------------------------*/
function SWEP:Initialize()

	if (SERVER) then
		self:SetWeaponHoldType(self.HoldType)

		self:SetNPCMinBurst(30)
		self:SetNPCMaxBurst(30)
		self:SetNPCFireRate(self.Primary.Delay)
	end

	self.Owner:SetNWBool("Gnome", false)
end

/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()

	util.PrecacheSound("weapons/ar2/npc_ar2_altfire.wav")
end

/*---------------------------------------------------------
   Name: SWEP:SecondThink()
---------------------------------------------------------*/
function SWEP:SecondThink()

	if self.Owner:GetNWBool("Gnome") then
		self.Owner:ConCommand("-duck")
	end
end

/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack()
   Desc: +attack1 has been pressed.
---------------------------------------------------------*/
function SWEP:PrimaryAttack()

	self.Weapon:SetNextPrimaryFire(CurTime() + 1)

	local smoke = EffectData()
		smoke:SetOrigin(self.Owner:GetPos())
	util.Effect("effect_mad_gnomatron", smoke)

	if not self.Owner:GetNWBool("Gnome") then
		self.Model = self.Owner:GetModel()
		self.Owner:SetModel("models/props_junk/gnome.mdl")
		self.Owner:SetNWBool("Gnome", true)
	else
		self.Owner:SetModel(self.Model)
		self.Owner:SetNWBool("Gnome", false)
	end

	self.Owner:EmitSound(self.Primary.Sound)
end

/*---------------------------------------------------------
   Name: SWEP:SecondaryAttack()
   Desc: +attack2 has been pressed.
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
end

/*---------------------------------------------------------
   Name: SWEP:Holster()
   Desc: Weapon wants to holster.
	   Return true to allow the weapon to holster.
---------------------------------------------------------*/
function SWEP:Holster()

	if self.Owner:GetNWBool("Gnome") then
		self.Owner:SetModel(self.Model)
		self.Owner:SetNWBool("Gnome", false)

		local smoke = EffectData()
			smoke:SetOrigin(self.Owner:GetPos())
		util.Effect("effect_mad_gnomatron", smoke)

		self.Owner:EmitSound(self.Primary.Sound)
	end

	return true
end