
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:OnTakeDamage(dmg)
	local damage = dmg:GetDamage()
	local attacker=dmg:GetAttacker()
	local inflictor=dmg:GetInflictor()
	if !dmg:IsExplosionDamage() && IsValid(attacker) && attacker:IsPlayer() && attacker:GetTable().ArmorPiercered then
		damage = damage*drugeffect_armorpiercermod
	end
	if self.Entity:GetNWInt("damage")>0 then
		self.Entity:SetNWInt("damage",self.Entity:GetNWInt("damage") - damage)
		if(self.Entity:GetNWInt("damage") <= 0) then
			self.Entity:Explode() 
			if self.Payout!=nil && attacker:IsPlayer() then
				local pay=self.Payout[1]*.75
				if ( attacker:GetNWString("DonorStatus", Guest)== "Bronze") or ( attacker:GetNWString("DonorStatus", Guest)== "Silver") or ( attacker:GetNWString("DonorStatus", Guest)== "Gold") or ( attacker:GetNWString("DonorStatus", Guest)== "Diamond") or ( attacker:GetNWString("DonorStatus", Guest)== "Platinum") or ( attacker:GetNWString("DonorStatus", Guest)== "CoOwner") or ( attacker:GetNWString("DonorStatus", Guest)== "Founder") or ( attacker:GetNWString("DonorStatus", Guest)== "Admin") then
					pay=self.Payout[1]
				end
				pay=math.ceil(pay)
				attacker:AddMoney(pay)
				Notify(attacker,2,3,"Paid "..tostring(pay).." for destroying a "..self.Payout[2])
			end
			if inflictor:GetClass()!="bigbomb" && inflictor:GetClass()!="env_physexplosion" && self.MakeScraps!=nil then
				self.Entity:MakeScraps()
			end
			self.Entity:Remove()
		
		end
	end
end

function ENT:Explode()

	local vPoint = self.Entity:GetPos()
	local effectdata = EffectData() 
	effectdata:SetStart( vPoint )
	effectdata:SetOrigin( vPoint ) 
	effectdata:SetScale( 1 ) 
	util.Effect( "Explosion", effectdata )
end