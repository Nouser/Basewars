// Variables that are used on both client and server

SWEP.Base 				= "weapon_mad_base"

SWEP.ViewModel			= "models/weapons/v_minigun.mdl"
SWEP.WorldModel			= "models/weapons/w_minigun.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.Primary.Sound 		= Sound("weapons/minigun/mini-1.wav")
SWEP.Primary.Recoil		= 0.3
SWEP.Primary.Damage		= 15
function SWEP:Upgrade(bool)
	self.Weapon:SetNWBool("upgraded",bool)
	if bool then
		self.Primary.Damage = 15
    else
        self.Primary.Damage = 30
    end
end
SWEP.Primary.NumShots	= 1
SWEP.Primary.Cone		= 0.03
SWEP.Primary.Delay 		= 0.03

SWEP.Primary.ClipSize		= 500					// Size of a clip
SWEP.Primary.DefaultClip	= 2000				// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "AirboatGun"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ShellEffect			= "effect_mad_shell_rifle"	// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"

SWEP.Pistol				= false
SWEP.Rifle				= true
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos 		= Vector (-4.6804, -17.5719, 4.4145)
SWEP.IronSightsAng 		= Vector (-0.022, -1.8518, 0)
SWEP.RunArmOffset 		= Vector (1.1073, -19.625, -0.7316)
SWEP.RunArmAngle 			= Vector (25.9554, 34.4127, 0)

/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()

    	util.PrecacheSound("weapons/minigun/mini-1.wav")
end