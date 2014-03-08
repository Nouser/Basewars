ENT.Type 				= "anim"
ENT.Base 				= "base_structure"
ENT.PrintName 			= "Super Gun Factory"
ENT.Author 				= "HLTV Proxy"
ENT.Spawnable 			= false
ENT.AdminSpawnable 		= false

// Gamemode Settings
ENT.HealthRing			= {1000,60,2}
ENT.Power				= 6
ENT.SparkPos 			= Vector(-30,-30,60)

function ENT:CanProduce(guntype, ply)
	if guntype=="resetbutton" && ply==self.Owner then
		return true
	elseif !self.Entity:IsPowered() || !self.Ready then
		return false
	elseif guntype=="flamer" then
		return true
	elseif guntype=="m82" && self.Entity:GetNWInt("upgrade")>=1 then
		return true
	elseif guntype=="vollmer" && self.Entity:GetNWInt("upgrade")>=2 then
		return true
	elseif guntype=="m60a3" && self.Entity:GetNWInt("upgrade")>=3 then
		return true
	elseif guntype=="fatman" && self.Entity:GetNWInt("upgrade")>=4 then
		return true
	else
		return false
	end
end