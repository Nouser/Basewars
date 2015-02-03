-- ========================
-- =          Crate SENT by Mahalis
-- ========================

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self.Destructed = false
	self:SetModel("models/Items/item_item_crate.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self.locked = false
	self:SetContents()
	self.damage = 100
	self.ShareGravgun = true
	local ply = self.Owner
	ply:GetTable().maxShipments = ply:GetTable().maxShipments + 1
	local phys = self:GetPhysicsObject()
	if phys and phys:IsValid() then phys:Wake() end
end

function ENT:OnTakeDamage(dmg)
	self.damage = self.damage - dmg:GetDamage()
	if self.damage <= 0 then
		self:Destruct()
	end
end

function ENT:SetContents()
	self.contents = self:GetNWString("Contents")
	self.count = 10
	self:SetNWInt("ContentsRemain",self.count + 1)
end

function ENT:Use()
--	if not self.locked then
--		self.locked = true -- One activation per second
--		self.sparking = true
		timer.Create(tostring(self) ..  "crate", 1, 1,  function() self:SpawnItem() end)
--	end
end

function ENT:SpawnItem()
	if not IsValid(self) then return end
	timer.Destroy(tostring(self) .. "crate")
	--self.sparking = false
	local count = self.count
	local pos = self:GetPos()
	if count <= 0 then 
		if( self.Owner:IsValid() ) then
			local ply = self.Owner
			ply:GetTable().maxShipments = ply:GetTable().maxShipments - 1
		end
		self:Remove()  
	end
	local contents = self.contents
	local weapon = ents.CreateEx("spawned_weapon")
	
	
	
	--local found = false
	--for k,v in pairs(CustomShipments) do
		--if k == contents then
			--found = true
			local wepclass = self:GetNWString("weaponclass")
			weapon:SetNWInt("weaponclass",wepclass)
			--table.insert(self.Guns, wepclass)
			weapon:SetModel(self.WeaponModel)
			self:SetNWInt("ContentsRemain",self.count)
			self:EmitSound( "ambient/alarms/klaxon1.wav" )
			--break
		--end
	--end
	--if not found then weapon:Remove() end

	weapon.ShareGravgun = true
	weapon:SetPos(pos + Vector(0,0,35))
	--weapon.nodupe = true
	weapon:Spawn()
	count = count - 1
	self.count = count
	--self.locked = false
end

function ENT:Think()
	if count == 0  then
		self:Remove()
	end
	if self.sparking then
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos())
		effectdata:SetMagnitude(1)
		effectdata:SetScale(1)
		effectdata:SetRadius(2)
		util.Effect("Sparks", effectdata)
	end
end


function ENT:Destruct()
	if self.Destructed then return end
	self.Destructed = true
	local vPoint = self:GetPos()
	local contents = self.contents
	local count = self.count
	local class = nil
	local model = nil
	
--	local found = false

--	if not found then self:Remove() return end
	
	for i=1, count, 1 do
		local weapon = ents.CreateEx("spawned_weapon")
		
			local wepclass = self:GetNWString("weaponclass")
			weapon:SetNWInt("weaponclass",wepclass)
			--table.insert(self.Guns, wepclass)
			weapon:SetModel(self.WeaponModel)
			self:SetNWInt("ContentsRemain",self.count)
			self:EmitSound( "ambient/alarms/klaxon1.wav" )
			weapon:SetPos(Vector(vPoint.x, vPoint.y, vPoint.z + (i*5)))
			
			weapon:Spawn()
	end
	if( self.Owner:IsValid() ) then
		local ply = self.Owner
		ply:GetTable().maxShipments = ply:GetTable().maxShipments - 1
	end
	self:Remove()
end