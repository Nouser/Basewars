
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
				local pay=self.Payout[1] * .75
				if(attacker != self.Owner) then
					if ( attacker:GetNWString("Status", "Guest")== "VIP++") or ( attacker:GetNWString("Status", "Guest")== "Founder") then
						pay=self.Payout[1] * 1.75
					end
					if ( attacker:GetNWString("Status", "Guest")== "VIP+") then
						pay=self.Payout[1] * 1.50
					end
					if ( attacker:GetNWString("Status", "Guest")== "VIP") then
						pay=self.Payout[1] * 1.25
					end
				end
				local payoutFail = false
				if(attacker == self.Owner) then
					local owner = self.Owner
					for k,v in pairs(GAMEMODE.OngoingRaids) do
						//owner:PrintMessage(HUD_PRINTTALK,"Raider="..v.Raider)
						//owner:PrintMessage(HUD_PRINTTALK,"Target="..tostring(v.Target))
						//owner:PrintMessage(HUD_PRINTTALK,"Raided="..v.Raided)
						if(owner:Team() != 1 and v.Raided == owner:Team()) then
							pay = self.Payout[1] * -2
							payoutFail = true
							break
						elseif(owner:Team() == 1 and v.Target == owner) then
							pay = self.Payout[1] * -2
							payoutFail = true
							break
						end
					end
				end
				pay=math.ceil(pay)
				attacker:AddMoney(pay)
				if payoutFail then
					Notify(attacker,2,3,"Lost $"..tostring(pay).." for destroying a "..self.Payout[2].." during a raid!")
				else
					Notify(attacker,2,3,"Paid $"..tostring(pay).." for destroying a "..self.Payout[2].."!")
				end
			end
//			if inflictor:GetClass()!="bigbomb" && inflictor:GetClass()!="env_physexplosion" && self.MakeScraps!=nil then
//				self.Entity:MakeScraps()
//			end
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