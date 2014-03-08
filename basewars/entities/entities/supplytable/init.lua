AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()

	self.Entity:SetModel( "models/props/cs_militia/table_shed.mdl" )
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	
	local phys = self.Entity:GetPhysicsObject()
	if(phys:IsValid()) then phys:Wake() end
	self.Entity:SetNWInt("damage",250)
	self.Entity:SetNWInt("upgrade", 0)
	local ply = self.Owner
	ply:GetTable().maxsupplytable=ply:GetTable().maxsupplytable + 1
	self.OwnerID = ply:UniqueID()
	self.Inactive = false
	self.unowned = false
	self.Entity:SetNWInt("power",0)

	self.Dontcall4 = false
	self.Dontcall3 = false
	self.Dontcall2 = false
	self.Dontcall1 = false

--	self.Entity:GetNWEntity( "upgrade" ) self.Entity:SetNWInt("upgrade", 0)
	
// Snipe Shield
	self.SnipeShield1 = ents.Create("prop_dynamic_override")
	self.SnipeShield1:SetModel( "models/items/car_battery01.mdl" )
	self.SnipeShield1:SetPos(self.Entity:GetPos()+self.Entity:GetAngles():Forward()*-10+self.Entity:GetAngles():Right()*-25+self.Entity:GetAngles():Up()*15)
	self.SnipeShield1:SetAngles(Angle(0,0,0))
	self.SnipeShield1:SetParent(self.Entity)
	self.SnipeShield1:SetSolid(SOLID_NONE)
	self.SnipeShield1:SetMoveType(MOVETYPE_NONE)
--	self.SnipeShield1:SetColor(Color(255,255,255,0))
	
	self.SnipeShield2 = ents.Create("prop_dynamic_override")
	self.SnipeShield2:SetModel( "models/items/car_battery01.mdl" )
	self.SnipeShield2:SetPos(self.Entity:GetPos()+self.Entity:GetAngles():Forward()*10+self.Entity:GetAngles():Right()*-25+self.Entity:GetAngles():Up()*15)
	self.SnipeShield2:SetAngles(Angle(0,0,0))
	self.SnipeShield2:SetParent(self.Entity)
	self.SnipeShield2:SetSolid(SOLID_NONE)
	self.SnipeShield2:SetMoveType(MOVETYPE_NONE)
--	self.SnipeShield2:SetColor(Color(255,255,255,0))
	
	self.SnipeShield3 = ents.Create("prop_dynamic_override")
	self.SnipeShield3:SetModel( "models/items/car_battery01.mdl" )
	self.SnipeShield3:SetPos(self.Entity:GetPos()+self.Entity:GetAngles():Forward()*-10+self.Entity:GetAngles():Right()*-5+self.Entity:GetAngles():Up()*15)
	self.SnipeShield3:SetAngles(Angle(0,0,0))
	self.SnipeShield3:SetParent(self.Entity)
	self.SnipeShield3:SetSolid(SOLID_NONE)
	self.SnipeShield3:SetMoveType(MOVETYPE_NONE)
--	self.SnipeShield3:SetColor(Color(255,255,255,0))
	
	self.SnipeShield4 = ents.Create("prop_dynamic_override")
	self.SnipeShield4:SetModel( "models/items/car_battery01.mdl" )
	self.SnipeShield4:SetPos(self.Entity:GetPos()+self.Entity:GetAngles():Forward()*10+self.Entity:GetAngles():Right()*-5+self.Entity:GetAngles():Up()*15)
	self.SnipeShield4:SetAngles(Angle(0,0,0))
	self.SnipeShield4:SetParent(self.Entity)
	self.SnipeShield4:SetSolid(SOLID_NONE)
	self.SnipeShield4:SetMoveType(MOVETYPE_NONE)
--	self.SnipeShield4:SetColor(Color(255,255,255,0))

// Fuel Tank & Armor
	self.FuelTank1 = ents.Create("prop_dynamic_override")
	self.FuelTank1:SetModel( "models/props_junk/gascan001a.mdl" )
	self.FuelTank1:SetPos(self.Entity:GetPos()+self.Entity:GetAngles():Forward()*10+self.Entity:GetAngles():Right()*-30+self.Entity:GetAngles():Up()*49)
	self.FuelTank1:SetAngles(Angle(0,0,0))
	self.FuelTank1:SetParent(self.Entity)
	self.FuelTank1:SetSolid(SOLID_NONE)
--	self.FuelTank1:SetColor(Color(100,100,150,255))
	self.FuelTank1:SetMoveType(MOVETYPE_NONE)
--	self.FuelTank1:SetColor(Color(255,255,255,0))
	
	self.FuelTank2 = ents.Create("prop_dynamic_override")
	self.FuelTank2:SetModel( "models/props_junk/gascan001a.mdl" )
	self.FuelTank2:SetPos(self.Entity:GetPos()+self.Entity:GetAngles():Forward()*-10+self.Entity:GetAngles():Right()*-30+self.Entity:GetAngles():Up()*49)
	self.FuelTank2:SetAngles(Angle(0,0,0))
	self.FuelTank2:SetParent(self.Entity)
	self.FuelTank2:SetSolid(SOLID_NONE)
--	self.FuelTank2:SetColor(Color(100,100,150,255))
	self.FuelTank2:SetMoveType(MOVETYPE_NONE)
--	self.FuelTank2:SetColor(Color(255,255,255,0))
	
	self.Armor1 = ents.Create("prop_dynamic_override")
	self.Armor1:SetModel( "models/pcv_hax.mdl" )
	self.Armor1:SetPos(self.Entity:GetPos()+self.Entity:GetAngles():Forward()*10+self.Entity:GetAngles():Right()*-10+self.Entity:GetAngles():Up()*33)
	self.Armor1:SetAngles(Angle(0,0,0))
	self.Armor1:SetParent(self.Entity)
	self.Armor1:SetSolid(SOLID_NONE)
--	self.Armor1:SetColor(Color(100,100,150,255))
	self.Armor1:SetMoveType(MOVETYPE_NONE)
--	self.Armor1:SetColor(Color(255,255,255,0))

	self.Armor2 = ents.Create("prop_dynamic_override")
	self.Armor2:SetModel( "models/pcv_hax.mdl" )
	self.Armor2:SetPos(self.Entity:GetPos()+self.Entity:GetAngles():Forward()*-10+self.Entity:GetAngles():Right()*-10+self.Entity:GetAngles():Up()*33)
	self.Armor2:SetAngles(Angle(0,0,0))
	self.Armor2:SetParent(self.Entity)
	self.Armor2:SetSolid(SOLID_NONE)
--	self.Armor2:SetColor(Color(100,100,150,255))
	self.Armor2:SetMoveType(MOVETYPE_NONE)
--	self.Armor2:SetColor(Color(255,255,255,0))

// Helmet
	self.Helmet1 = ents.Create("prop_dynamic_override")
	self.Helmet1:SetModel( "models/pasgt_no_glass_hax.mdl" )
	self.Helmet1:SetPos(self.Entity:GetPos()+self.Entity:GetAngles():Forward()*-10+self.Entity:GetAngles():Right()*30+self.Entity:GetAngles():Up()*10)
	self.Helmet1:SetAngles(Angle(0,270,0))
	self.Helmet1:SetParent(self.Entity)
	self.Helmet1:SetSolid(SOLID_NONE)
	self.Helmet1:SetMoveType(MOVETYPE_NONE)
--	self.Helmet1:SetColor(Color(255,255,255,0))
	     
	self.Helmet2 = ents.Create("prop_dynamic_override")
	self.Helmet2:SetModel( "models/pasgt_no_glass_hax.mdl" )
	self.Helmet2:SetPos(self.Entity:GetPos()+self.Entity:GetAngles():Forward()*10+self.Entity:GetAngles():Right()*30+self.Entity:GetAngles():Up()*10)
	self.Helmet2:SetAngles(Angle(0,270,0))
	self.Helmet2:SetParent(self.Entity)
	self.Helmet2:SetSolid(SOLID_NONE)
	self.Helmet2:SetMoveType(MOVETYPE_NONE)
--	self.Helmet2:SetColor(Color(255,255,255,0))
	     
	self.Helmet3 = ents.Create("prop_dynamic_override")
	self.Helmet3:SetModel( "models/pasgt_no_glass_hax.mdl" )
	self.Helmet3:SetPos(self.Entity:GetPos()+self.Entity:GetAngles():Forward()*-10+self.Entity:GetAngles():Right()*20+self.Entity:GetAngles():Up()*10)
	self.Helmet3:SetAngles(Angle(0,270,0))
	self.Helmet3:SetParent(self.Entity)
	self.Helmet3:SetSolid(SOLID_NONE)
	self.Helmet3:SetMoveType(MOVETYPE_NONE)
--	self.Helmet3:SetColor(Color(255,255,255,0))
	     
	self.Helmet4 = ents.Create("prop_dynamic_override")
	self.Helmet4:SetModel( "models/pasgt_no_glass_hax.mdl" )
	self.Helmet4:SetPos(self.Entity:GetPos()+self.Entity:GetAngles():Forward()*10+self.Entity:GetAngles():Right()*20+self.Entity:GetAngles():Up()*10)
	self.Helmet4:SetAngles(Angle(0,270,0))
	self.Helmet4:SetParent(self.Entity)
	self.Helmet4:SetSolid(SOLID_NONE)
	self.Helmet4:SetMoveType(MOVETYPE_NONE)
--	self.Helmet4:SetColor(Color(255,255,255,0))
	
// Scan Blocker & Defusal Kit	
	self.toolkit1 = ents.Create("prop_dynamic_override")
	self.toolkit1:SetModel( "models/weapons/w_defuser.mdl" )
	self.toolkit1:SetPos(self.Entity:GetPos()+self.Entity:GetAngles():Forward()*10+self.Entity:GetAngles():Right()*30+self.Entity:GetAngles():Up()*38)
	self.toolkit1:SetAngles(Angle(0,0,0))
	self.toolkit1:SetParent(self.Entity)
	self.toolkit1:SetSolid(SOLID_NONE)
--	self.toolkit1:SetColor(Color(100,100,150,255))
	self.toolkit1:SetMoveType(MOVETYPE_NONE)
--	self.toolkit1:SetColor(Color(255,255,255,255))
	
	self.toolkit2 = ents.Create("prop_dynamic_override")
	self.toolkit2:SetModel( "models/weapons/w_defuser.mdl" )
	self.toolkit2:SetPos(self.Entity:GetPos()+self.Entity:GetAngles():Forward()*-10+self.Entity:GetAngles():Right()*30+self.Entity:GetAngles():Up()*38)
	self.toolkit2:SetAngles(Angle(0,0,0))
	self.toolkit2:SetParent(self.Entity)
	self.toolkit2:SetSolid(SOLID_NONE)
--	self.toolkit2:SetColor(Color(100,100,150,255))
	self.toolkit2:SetMoveType(MOVETYPE_NONE)
--	self.toolkit2:SetColor(Color(255,255,255,255))
	
	self.toolkit3 = ents.Create("prop_dynamic_override")
	self.toolkit3:SetModel( "models/props_lab/monitor01b.mdl" )
	self.toolkit3:SetPos(self.Entity:GetPos()+self.Entity:GetAngles():Forward()*10+self.Entity:GetAngles():Right()*10+self.Entity:GetAngles():Up()*40.5)
	self.toolkit3:SetAngles(Angle(0,0,0))
	self.toolkit3:SetParent(self.Entity)
	self.toolkit3:SetSolid(SOLID_NONE)
--	self.toolkit3:SetColor(Color(100,100,150,255))
	self.toolkit3:SetMoveType(MOVETYPE_NONE)
--	self.toolkit3:SetColor(Color(255,255,255,255))

	self.toolkit4 = ents.Create("prop_dynamic_override")
	self.toolkit4:SetModel( "models/props_lab/monitor01b.mdl" )
	self.toolkit4:SetPos(self.Entity:GetPos()+self.Entity:GetAngles():Forward()*-10+self.Entity:GetAngles():Right()*10+self.Entity:GetAngles():Up()*40.5)
	self.toolkit4:SetAngles(Angle(0,0,0))
	self.toolkit4:SetParent(self.Entity)
	self.toolkit4:SetSolid(SOLID_NONE)
--	self.toolkit4:SetColor(Color(100,100,150,255))
	self.toolkit4:SetMoveType(MOVETYPE_NONE)
--	self.toolkit4:SetColor(Color(255,255,255,255))

	self.Payout = {CfgVars["supplytablecost"], "Supply Table"}

end

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

			if attacker:IsPlayer() then
					pay=(self.Payout[1] * .25 )
					Notify(attacker,2,3,"Paid $"..tostring(pay).." for destroying a "..self.Payout[2])
					pay=math.ceil(pay)
					attacker:AddMoney(pay)
			end
			
			self.Entity:Remove()
		
		end
	end
end

function ENT:Use(activator,caller)

		if (self.Entity:GetNWInt("upgrade")==4) then
			if (caller:GetNWBool("helmeted")==false) then
					if( not activator:CanAfford( CfgVars["helmetcost"] ) ) then
						return "";
					end
				caller:SetNWBool("helmeted", true)
					activator:AddMoney( CfgVars["helmetcost"] * -1 )
					Notify( activator, 4, 3, "You bought a Helmet for $500." )
			end
			if (caller:GetNWBool("shielded")==false) then
					if( not activator:CanAfford( CfgVars["shieldcost"] ) ) then
						return "";
					end
				caller:GetTable().Shielded = true
				caller:SetNWBool("shielded", true)
					activator:AddMoney( CfgVars["shieldcost"] * -1 )
					Notify( activator, 4, 3, "You bought a Snipe Shield for $1000." )
			end
			if (caller:GetNWBool("tooled")==false) then
					if( not activator:CanAfford( CfgVars["defusekitcost"] ) ) then
						return "";
					end
				caller:GetTable().Tooled = true
				caller:SetNWBool("tooled", true)
					activator:AddMoney( CfgVars["defusekitcost"] * -1 )
					Notify( activator, 4, 3, "You bought a Defusal Kit for $125." )
			end
			if (caller:Armor()<100) then
					if( not activator:CanAfford( CfgVars["armorcost"] ) ) then
						return "";
					end
				caller:SetArmor(100)
					activator:AddMoney( CfgVars["armorcost"] * -1 )
					Notify( activator, 4, 3, "You bought Body Armor for $2000." )
			end
			if (activator:GetNetworkedInt("Fuel") < 100) then		
					if( not activator:CanAfford( CfgVars["ammofuelcost"] ) ) then
						return "";
					end
				activator:SetNetworkedInt("Fuel", 100)
					activator:AddMoney( CfgVars["ammofuelcost"] * -1 )
					Notify( activator, 4, 3, "You bought a Fuel Tank for $1000." )
			end	
			if (caller:GetNWBool("scannered")==false) then
					if( not activator:CanAfford( CfgVars["scanblockcost"] ) ) then
						return "";
					end
				caller:SetNWBool("scannered", true)
					activator:AddMoney( CfgVars["scanblockcost"] * -1 )
					Notify( activator, 4, 3, "You bought a Scan Blocker for $250." )
			end
	
		elseif (self.Entity:GetNWInt("upgrade")==3) then
			if (caller:GetNWBool("helmeted")==false) then
					if( not activator:CanAfford( CfgVars["helmetcost"] ) ) then
						return "";
					end
				caller:SetNWBool("helmeted", true)
					activator:AddMoney( CfgVars["helmetcost"] * -1 )
					Notify( activator, 4, 3, "You bought a Helmet for $500." )
			end
			if (caller:GetNWBool("shielded")==false) then
					if( not activator:CanAfford( CfgVars["shieldcost"] ) ) then
						return "";
					end
				caller:GetTable().Shielded = true
				caller:SetNWBool("shielded", true)
					activator:AddMoney( CfgVars["shieldcost"] * -1 )
					Notify( activator, 4, 3, "You bought a Snipe Shield for $1000." )
			end
			if (caller:GetNWBool("tooled")==false) then
					if( not activator:CanAfford( CfgVars["defusekitcost"] ) ) then
						return "";
					end
				caller:GetTable().Tooled = true
				caller:SetNWBool("tooled", true)
					activator:AddMoney( CfgVars["defusekitcost"] * -1 )
					Notify( activator, 4, 3, "You bought a Defusal Kit for $125." )
			end
			if (caller:Armor()<100) then
					if( not activator:CanAfford( CfgVars["armorcost"] ) ) then
						return "";
					end
				caller:SetArmor(100)
					activator:AddMoney( CfgVars["armorcost"] * -1 )
					Notify( activator, 4, 3, "You bought Body Armor for $2000." )
			end
			if (caller:GetNWBool("scannered")==false) then
					if( not activator:CanAfford( CfgVars["scanblockcost"] ) ) then
						return "";
					end
				caller:SetNWBool("scannered", true)
					activator:AddMoney( CfgVars["scanblockcost"] * -1 )
					Notify( activator, 4, 3, "You bought a Scan Blocker for $250." )
			end

		elseif (self.Entity:GetNWInt("upgrade")==2) then
			if (caller:GetNWBool("helmeted")==false) then
					if( not activator:CanAfford( CfgVars["helmetcost"] ) ) then
						return "";
					end
				caller:SetNWBool("helmeted", true)
					activator:AddMoney( CfgVars["helmetcost"] * -1 )
					Notify( activator, 4, 3, "You bought a Helmet for $500." )
			end
			if (caller:GetNWBool("tooled")==false) then
					if( not activator:CanAfford( CfgVars["defusekitcost"] ) ) then
						return "";
					end
				caller:GetTable().Tooled = true
				caller:SetNWBool("tooled", true)
					activator:AddMoney( CfgVars["defusekitcost"] * -1 )
					Notify( activator, 4, 3, "You bought a Defusal Kit for $125." )
			end
			if (caller:Armor()<100) then
					if( not activator:CanAfford( CfgVars["armorcost"] ) ) then
						return "";
					end
				caller:SetArmor(100)
					activator:AddMoney( CfgVars["armorcost"] * -1 )
					Notify( activator, 4, 3, "You bought Body Armor for $2000." )
			end
			if (caller:GetNWBool("scannered")==false) then
					if( not activator:CanAfford( CfgVars["scanblockcost"] ) ) then
						return "";
					end
				caller:SetNWBool("scannered", true)
					activator:AddMoney( CfgVars["scanblockcost"] * -1 )
					Notify( activator, 4, 3, "You bought a Scan Blocker for $250." )
			end
	
		elseif (self.Entity:GetNWInt("upgrade")==1) then
			if (caller:GetNWBool("helmeted")==false) then
					if( not activator:CanAfford( CfgVars["helmetcost"] ) ) then
						return "";
					end
				caller:SetNWBool("helmeted", true)
					activator:AddMoney( CfgVars["helmetcost"] * -1 )
					Notify( activator, 4, 3, "You bought a Helmet for $500." )
			end
			if (caller:GetNWBool("tooled")==false) then
					if( not activator:CanAfford( CfgVars["defusekitcost"] ) ) then
						return "";
					end
				caller:GetTable().Tooled = true
				caller:SetNWBool("tooled", true)
					activator:AddMoney( CfgVars["defusekitcost"] * -1 )
					Notify( activator, 4, 3, "You bought a Defusal Kit for $125." )
			end
			if (caller:GetNWBool("scannered")==false) then
					if( not activator:CanAfford( CfgVars["scanblockcost"] ) ) then
						return "";
					end
				caller:SetNWBool("scannered", true)
					activator:AddMoney( CfgVars["scanblockcost"] * -1 )
					Notify( activator, 4, 3, "You bought a Scan Blocker for $250." )
			end
		
		else
			if (caller:GetNWBool("tooled")==false) then
					if( not activator:CanAfford( CfgVars["defusekitcost"] ) ) then
						return "";
					end
				caller:GetTable().Tooled = true
				caller:SetNWBool("tooled", true)
					activator:AddMoney( CfgVars["defusekitcost"] * -1 )
					Notify( activator, 4, 3, "You bought a Defusal Kit for $125." )
			if (caller:GetNWBool("scannered")==false) then
					if( not activator:CanAfford( CfgVars["scanblockcost"] ) ) then
						return "";
					end
				caller:SetNWBool("scannered", true)
					activator:AddMoney( CfgVars["scanblockcost"] * -1 )
					Notify( activator, 4, 3, "You bought a Scan Blocker for $250." )
			end
		end
	end
end
 
function ENT:Think()
	upgradenum = self.Entity:GetNWEntity("upgrade")

	if (IsValid(self.Owner)==false) then
		self.Entity:Remove()	
---	if (self.Owner == false) then
---		self.Entity:Remove()
	end
			if (self.Entity:GetNWInt("upgrade")==4) and self.Dontcall4==false then
		self.Dontcall4 = true
		self.FuelTank1:SetColor(255,255,255,255)
		self.FuelTank2:SetColor(255,255,255,255)		
			elseif (self.Entity:GetNWInt("upgrade")==3) and self.Dontcall3==false then
		self.Dontcall3 = true
		self.SnipeShield1:SetColor(255,255,255,255)
		self.SnipeShield2:SetColor(255,255,255,255)
		self.SnipeShield3:SetColor(255,255,255,255)
		self.SnipeShield4:SetColor(255,255,255,255)
			elseif (self.Entity:GetNWInt("upgrade")==2) and self.Dontcall2==false then
		self.Dontcall2 = true
		self.Armor1:SetColor(255,255,255,255)
		self.Armor2:SetColor(255,255,255,255)
			elseif (self.Entity:GetNWInt("upgrade")==1) and self.Dontcall1==false then
		self.Dontcall1 = true
		self.Helmet1:SetColor(255,255,255,255)
		self.Helmet2:SetColor(255,255,255,255)
		self.Helmet3:SetColor(255,255,255,255)
		self.Helmet4:SetColor(255,255,255,255)
		end
		
	self.Entity:NextThink(CurTime()+0.1)
	return true
end

function ENT:OnRemove( )

	local ply = self.Owner
	if IsValid(ply) then
		ply:GetTable().maxsupplytable=ply:GetTable().maxsupplytable - 1
	end
end