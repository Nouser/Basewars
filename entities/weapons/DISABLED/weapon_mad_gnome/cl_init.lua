include('shared.lua')

SWEP.PrintName			= "GNOMATRON"					// 'Nice' Weapon name (Shown on HUD)	
SWEP.Slot				= 5							// Slot in the weapon selection menu
SWEP.SlotPos			= 1							// Position in the slot

// Override this in your SWEP to set the icon in the weapon selection
if (file.Exists("materials/weapons/weapon_mad_gnome.vmt","GAME")) then
	SWEP.WepSelectIcon	= surface.GetTextureID("weapons/weapon_mad_gnome")
end

/*---------------------------------------------------------
   Name: SWEP:DrawHUD()
   Desc: You can draw to the HUD here. It will only draw when
	   the client has the weapon deployed.
---------------------------------------------------------*/
function SWEP:DrawHUD()
end

/*---------------------------------------------------------
   Name: SWEP:GetViewModelPosition()
   Desc: Allows you to re-position the view model.
---------------------------------------------------------*/
function SWEP:GetViewModelPosition(pos, ang)

	ang = ang * 1
	ang:RotateAroundAxis(ang:Right(), 0)
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 0)
	
	pos = pos + 0 * ang:Right()
	pos = pos - 100 * ang:Up()
	pos = pos + 0 * ang:Forward()
	
	return pos, ang
end

/*---------------------------------------------------------
   Name: Gnomatron()
---------------------------------------------------------*/
local function Gnomatron(ply, origin, angles, fov) 

	if LocalPlayer():Alive() then
		if LocalPlayer():GetNWBool("Gnome") then
			origin = origin + Vector(0, 0, -15)
			angles = angles
		end	
	end
end
hook.Add("CalcView", "Gnomatron", Gnomatron)