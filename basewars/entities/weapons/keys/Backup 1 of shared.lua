if( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

if( CLIENT ) then
	SWEP.PrintName 		= "Keys";
	SWEP.Slot 			= 0;
	SWEP.SlotPos 		= 3;
	SWEP.DrawAmmo 		= false;
	SWEP.DrawCrosshair 	= false;

	if (file.Exists("materials/weapons/weapon_mad_fists.vmt","GAME")) then
		SWEP.WepSelectIcon	= surface.GetTextureID("weapons/weapon_mad_fists")
	end

end

// Variables that are used on both client and server

SWEP.Author			= "Rickster"
SWEP.Instructions 	= "Left Click: Lock Door, Right Click: Unlock Door"
SWEP.Contact		= ""
SWEP.Purpose		= ""

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.AnimPrefix		= "rpg"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false
  
//SWEP.Sound = "doors/door_latch3.wav";
SWEP.LockSound 		= "doors/door_latch1.wav"
SWEP.UnlockSound 	= "doors/door_latch3.wav"
  
SWEP.Primary.ClipSize		= -1			// Size of a clip
SWEP.Primary.DefaultClip	= 0				// Default number of bullets in a clip
SWEP.Primary.Automatic		= false			// Automatic/Semi Auto
SWEP.Primary.Ammo			= ""

SWEP.Secondary.ClipSize		= -1			// Size of a clip
SWEP.Secondary.DefaultClip	= 0				// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false			// Automatic/Semi Auto
SWEP.Secondary.Ammo			= ""

SWEP.ViewModel 		= "models/perp2/v_fists.mdl";
SWEP.WorldModel 	= "models/perp2/w_fists.mdl";

/*---------------------------------------------------------
   Name: SWEP:Initialize( )
   Desc: Called when the weapon is first loaded
---------------------------------------------------------*/
function SWEP:Initialize()

//	if( SERVER ) then
	
		self:SetWeaponHoldType( "normal" );
	
//	end

end

/*---------------------------------------------------------
   Name: SWEP:Precache( )
   Desc: Use this function to precache stuff
---------------------------------------------------------*/
/*
function SWEP:Precache()
end

function SWEP:Deploy()

	if( SERVER ) then

		self.Owner:DrawViewModel( false );
		self.Owner:DrawWorldModel( false );
		
	end

end
*/
/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/
/*
function SWEP:PrimaryAttack()
	local trace = self.Owner:GetEyeTrace()
		if SERVER then
		--	self.Owner:EmitSound("npc/metropolice/gear".. math.floor(math.Rand(1,7)) ..".wav")
			trace.Entity:Fire("lock", "", 0) -- Lock the door immediately so it won't annoy people
//			timer.Simple(0.2, function(ply, sound) if ValidEntity(ply) then ply:EmitSound(sound) end end, self.Owner, self.Sound)

		self.Owner:EmitSound( self.Sound );
		self.Weapon:SetNextPrimaryFire( CurTime() + 1.0 );
			
//			local RP = RecipientFilter()
//			RP:AddAllPlayers()
			
//			umsg.Start("anim_keys", RP) 
//				umsg.Entity(self.Owner)
//				umsg.String("usekeys")
//			umsg.End()
//			self.Owner:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_ITEM_PLACE)
		end
		self.Weapon:SetNextPrimaryFire(CurTime() + 0.5)
end

function SWEP:SecondaryAttack()
	local trace = self.Owner:GetEyeTrace()
		if SERVER then
		--	self.Owner:EmitSound("npc/metropolice/gear".. math.floor(math.Rand(1,7)) ..".wav")
			trace.Entity:Fire("unlock", "", 0)-- Unlock the door immediately so it won't annoy people
//			timer.Simple(0.2, function(ply, sound) if ValidEntity(ply) then ply:EmitSound(sound) end end, self.Owner, self.Sound)

		self.Owner:EmitSound( self.Sound );
		self.Weapon:SetNextPrimaryFire( CurTime() + 1.0 );

//			umsg.Start("anim_keys", RP) 
//				umsg.Entity(self.Owner)
//				umsg.String("usekeys")
//			umsg.End()
//			self.Owner:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_ITEM_PLACE)
		end
		self.Weapon:SetNextSecondaryFire(CurTime() + 0.5)
end

SWEP.OnceReload = false
function SWEP:Reload()
	local trace = self.Owner:GetEyeTrace()
	if not ValidEntity(trace.Entity) or (ValidEntity(trace.Entity) and ((not trace.Entity:IsDoor() and not trace.Entity:IsVehicle()) or self.Owner:EyePos():Distance(trace.HitPos) > 200)) then
		if not self.OnceReload then
			if SERVER then Notify(self.Owner, 1, 3, "You need to be looking at a door/vehicle in order to bring up the menu") end
			self.OnceReload = true
			timer.Simple(3, function() self.OnceReload = false end)
		end
		return
	end
	if SERVER then
		umsg.Start("KeysMenu", self.Owner)
			umsg.Bool(self.Owner:GetEyeTrace().Entity:IsVehicle())
		umsg.End()
	end
end
*/

function SWEP:Deploy()
	if SERVER then
		self.Owner:DrawWorldModel(false)
	end
end

---function SWEP:CanPrimaryAttack ( ) return true; end

function SWEP:PrimaryAttack()
	if CLIENT then return false; end

//	local EyeTrace = util.TraceLine(tr)
	local EyeTrace = self.Owner:GetEyeTrace()
	
	if (!EyeTrace.Entity || !IsValid(EyeTrace.Entity)) then return false; end
	
	local Distance = self.Owner:EyePos():Distance(EyeTrace.HitPos);
	
	if Distance > 75 and EyeTrace.Entity:GetClass() ~= "prop_door_rotating" then return false; end
//	if Distance > 75 and EyeTrace.Entity:IsDoor() then return false; end
//	if Distance > 100 and EyeTrace.Entity:IsVehicle() then return false; end
	
	self.Weapon:SetNextPrimaryFire(CurTime() + 1)
	
//	if (!self.Owner:CanManipulateDoor(EyeTrace.Entity)) then
		
		
//		return false;
//	end
	
	EyeTrace.Entity:Fire("lock", "", 0)
	self.Owner:EmitSound(self.LockSound)
end

function SWEP:SecondaryAttack()
	if CLIENT then return false; end

//	local EyeTrace = util.TraceLine(tr)
	local EyeTrace = self.Owner:GetEyeTrace()	
	
	if (!EyeTrace.Entity || !IsValid(EyeTrace.Entity)) then return false; end
	
	local Distance = self.Owner:EyePos():Distance(EyeTrace.HitPos);

	if Distance > 75 and EyeTrace.Entity:GetClass() ~= "prop_door_rotating" then return false; end
//	if Distance > 75 and EyeTrace.Entity:IsDoor() then return false; end
//	if Distance > 100 and EyeTrace.Entity:IsVehicle() then return false; end
	
	self.Weapon:SetNextSecondaryFire(CurTime() + 1)
	
//	if (!self.Owner:CanManipulateDoor(EyeTrace.Entity)) then
		
		
//		return false;
//	end


	EyeTrace.Entity:Fire("unlock", "", 0)
	self.Owner:EmitSound(self.UnlockSound)
end