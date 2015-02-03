ENT.Type 					= "anim"
ENT.Base 					= "base_structure"
ENT.PrintName 				= "Gun Factory"
ENT.Author 					= "HLTV Proxy"
ENT.Spawnable 				= false
ENT.AdminSpawnable 			= false
ENT.HealthRing				= {500,60,2}
// used by gamemode for power plant
ENT.Power					= 3
ENT.SparkPos 				= Vector(-30,-30,60)

function ENT:CanProduce(guntype, ply)
	if guntype=="resetbutton" && ply==self.Owner then
		return true
	elseif !self.Entity:IsPowered() || !self.Ready then
		return false
	elseif guntype=="worldslayer" && self.Entity:GetNWInt("upgrade")>=2 then
		return true
	else
		return false
	end
end