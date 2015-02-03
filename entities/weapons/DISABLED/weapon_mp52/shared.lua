// Variables that are used on both client and server

SWEP.Base 				= "weapon_mad_base"

SWEP.ViewModelFlip		= true
SWEP.ViewModel			= "models/weapons/v_smg_mp5.mdl"
SWEP.WorldModel			= "models/weapons/w_smg_mp5.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.Primary.Sound 		= Sound("Weapon_MP5Navy.Single")
SWEP.Primary.Recoil		= 0.6
SWEP.Primary.Damage		= 17
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.017
SWEP.Primary.Delay 		= 0.08

SWEP.Primary.ClipSize		= 30					// Size of a clip
SWEP.Primary.DefaultClip	= 30					// Default number of bullets in a clip
SWEP.Primary.Automatic		= true				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "Battery"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"
SWEP.Secondary.Sound			= Sound( "Weapon_USP.SilencedShot" )

SWEP.ShellEffect			= "effect_mad_shell_pistol"	// "effect_mad_shell_pistol" or "effect_mad_shell_rifle" or "effect_mad_shell_shotgun"

SWEP.Pistol				= false
SWEP.Rifle				= true
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos 		= Vector (4.7494, -4.114, 1.9335)
SWEP.IronSightsAng 		= Vector (1.018, -0.0187, 0)
SWEP.RunArmOffset 		= Vector (-2.6657, 0, 2.5)
SWEP.RunArmAngle 			= Vector (-20.0824, -20.5693, 0)

/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()

    	util.PrecacheSound("weapons/mp5navy/mp5-1.wav")
end

function SWEP:Upgrade(bool)
	self.Weapon:SetNWBool("upgraded",bool)
	if bool then
		self.Primary.Recoil = 0.3
        self.Primary.Sound = Sound( "Weapon_USP.SilencedShot" )
        self.Primary.Cone = 0.01
    else
        self.Primary.Recoil = 0.6
        self.Primary.Sound = Sound("Weapon_MP5Navy.Single")
        self.Primary.Cone = 0.017
    end
end