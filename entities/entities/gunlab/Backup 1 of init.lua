-- ============================================
-- =                                          =
-- =          Crate SENT by Mahalis           =
-- =                                          =
-- ============================================

// gun lab has been changed to give upgrades instead of shitty guns.

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()

	self.Entity:SetModel( "models/props_c17/furnitureboiler001a.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end
	self.Entity:SetNWBool("sparking",false)
	self.Entity:SetNWInt("damage",500)
	self.Entity:SetNWInt("upgrade", 0)
	local ply = self.Owner
	ply:GetTable().maxgunlabs=ply:GetTable().maxgunlabs + 1
	self.Ready = true
	self.Entity:SetNWInt("power",0)
	self.Payout={CfgVars["gunlabcost"],"Gun Lab"}
end

function ENT:Use( activator )
	self.Entity:SetNWEntity( "user", activator )
	timer.Create( tostring(self.Entity) .. "spawned_weapon", 0.5, 1, function() self.createGun( self) end)
	if (!self.Ready) then return end
	local gun = activator:GetActiveWeapon()
	if !ValidEntity(gun) then return end
	if (gun:GetNWBool("upgraded")) then
		Notify(activator, 4, 3, "This weapon is already upgraded!")
		self.Ready = false
		return
	end
	local weapon = gun:GetClass()
	local upgradecost = 0
	local canupgrade = false
	local upgradestring = ""
	if (weapon=="weapon_p2282") then
		if (CfgVars["p228cost"]>0) then
			upgradecost = CfgVars["p228cost"]/2
		end
		canupgrade = true
		upgradestring = "Clip extended and accuracy increased."
	elseif (weapon=="weapon_deagle2") then
		if (CfgVars["deaglecost"]>0) then
			upgradecost = CfgVars["deaglecost"]/2
		end
		canupgrade = true
		upgradestring = "Sight zoom and accuracy increased."
	elseif (weapon=="weapon_glock2") then
		if (CfgVars["glockcost"]>0) then
			upgradecost = CfgVars["glockcost"]/2
		end
		canupgrade = true
		upgradestring = "Sight zoom and accuracy increased."
	elseif (weapon=="weapon_fiveseven2") then
		if (CfgVars["fivesevencost"]>0) then
			upgradecost = CfgVars["fivesevencost"]/2
		end
		canupgrade = true
		upgradestring = "Fully automatic."
	elseif (weapon=="weapon_usp2") then
		if (CfgVars["uspcost"]>0) then
			upgradecost = CfgVars["uspcost"]/2
		end
		canupgrade = true
		upgradestring = "Increased rate of fire."
	elseif (weapon=="weapon_mac102") then
		if (CfgVars["mac10cost"]>0) then
			upgradecost = CfgVars["mac10cost"]/20
		end
		canupgrade = true
		upgradestring = "Shoots faster."
	elseif (weapon=="weapon_tmp2") then
		if (CfgVars["tmpcost"]>0) then
			upgradecost = CfgVars["tmpcost"]/20
		end
		canupgrade = true
		upgradestring = "Shoot faster."
	elseif (weapon=="weapon_ump452") then
		if (CfgVars["umpcost"]>0) then
			upgradecost = CfgVars["umpcost"]/20
		end
		canupgrade = true
		upgradestring = "Right click to fire a burst."
	elseif (weapon=="weapon_m42") then
		if (CfgVars["m16cost"]>0) then
			upgradecost = CfgVars["m16cost"]/20
		end
		canupgrade = true
		upgradestring = "Full auto enabled, accuracy increased."
	elseif (weapon=="weapon_mp52") then
		if (CfgVars["mp5cost"]>0) then
			upgradecost = CfgVars["mp5cost"]/20
		end
		canupgrade = true
		upgradestring = "Lower recoil."
	elseif (weapon=="weapon_pumpshotgun2") then
		if (CfgVars["shotguncost"]>0) then
			upgradecost = CfgVars["shotguncost"]/20
		end
		canupgrade = true
		upgradestring = "Lower spread."
	elseif (weapon=="weapon_autoshotgun2") then
		if (CfgVars["autoshotguncost"]>0) then
			upgradecost = CfgVars["autoshotguncost"]/20
		end
		canupgrade = true
		upgradestring = "Faster reload."
	elseif (weapon=="weapon_autosnipe") then
		if (CfgVars["autosnipecost"]>0) then
			upgradecost = CfgVars["autosnipecost"]/20
		end
		canupgrade = true
		upgradestring = "Increased damage."
	elseif (weapon=="weapon_galil2") then
		if (CfgVars["galilcost"]>0) then
			upgradecost = CfgVars["galilcost"]/20
		end
		canupgrade = true
		upgradestring = "Lower recoil."
	elseif (weapon=="weapon_minigun") then
		if (CfgVars["miniguncost"]>0) then
			upgradecost = CfgVars["miniguncost"]/20
		end
		canupgrade = true
		upgradestring = "More Damage"
	elseif (weapon=="weapon_p902") then
		if (CfgVars["p90cost"]>0) then
			upgradecost = CfgVars["p90cost"]/20
		end
		canupgrade = true
		upgradestring = "Lower recoil."
	elseif (weapon=="weapon_rocketlauncher") then
		if (CfgVars["rpgcost"]>0) then
			upgradecost = CfgVars["rpgcost"]/20
		end
		canupgrade = true
		upgradestring = "Increased damage and accuracy."
	elseif (weapon=="weapon_ak472") then
		if (CfgVars["ak47cost"]>0) then
			upgradecost = CfgVars["ak47cost"]/20
		end
		canupgrade = true
		upgradestring = "Bigger clip."
	elseif (weapon=="weapon_aug2") then
		if (CfgVars["augcost"]>0) then
			upgradecost = CfgVars["augcost"]/20
		end
		canupgrade = true
		upgradestring = "Bigger clip."
	elseif (weapon=="ls_sniper") then
		if (CfgVars["snipercost"]>0) then
			upgradecost = CfgVars["snipercost"]/20
		end
		canupgrade = true
		upgradestring = "Increased damage."
	elseif (weapon=="weapon_50cal2") then
		if (CfgVars["paracost"]>0) then
			upgradecost = CfgVars["paracost"]/20
		end
		canupgrade = true
		upgradestring = "Increased rate of fire."
	elseif (weapon=="weapon_knife2") then
		if (CfgVars["knifecost"]>0) then
			upgradecost = CfgVars["knifecost"]/2
		end
		canupgrade = true
		upgradestring = "Poison knife, no deploy sound."
	elseif (weapon=="weapon_grenadegun") then
		upgradecost = 225
		canupgrade = true
		upgradestring = "Longer distance shots."
	elseif (weapon=="weapon_lasergun") then
		upgradecost = 150
		canupgrade = true
		upgradestring = "More battery."
	elseif (weapon=="weapon_laserrifle") then
		upgradecost = 150
		canupgrade = true
		upgradestring = "More battery."
	else
		Notify(activator, 4, 3, "This weapon cannot be upgraded!")
	end
	self.Ready = false
	if (canupgrade && activator:CanAfford(upgradecost)) then
		activator:AddMoney(-upgradecost)
		activator:UpgradeGun(weapon, true)
		Notify(activator, 0, 3, "Upgrade has been applied to your weapon for $" .. upgradecost)
		if (upgradestring!= "") then
			Notify(activator, 3, 4, upgradestring)
		end
		if (upgradecost>0) then
			local owner = self.Owner
			if ValidEntity(owner) && activator!=owner then
				owner:AddMoney(math.ceil(upgradecost/2))
				Notify(owner, 2, 3, "Paid $" .. math.ceil(upgradecost/2) .. " for selling a gun upgrade.")
			end
		end
		self.Entity:SetNWBool("sparking",true)
	end
end

function ENT:createGun()
	self.Entity:SetNWBool("sparking",false)
	self.Ready = true
end

function ENT:Think()
	if (ValidEntity(self.Owner)==false) then
		self.Entity:Remove()
	end
end

function ENT:OnRemove( )
	timer.Destroy(tostring(self.Entity))
	local ply = self.Owner
	if ValidEntity(ply) then
		ply:GetTable().maxgunlabs=ply:GetTable().maxgunlabs - 1
	end
end