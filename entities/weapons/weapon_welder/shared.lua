if(SERVER) then
        AddCSLuaFile( "cl_init.lua" )
        AddCSLuaFile( "shared.lua" )
end
 
if( CLIENT ) then
 
        SWEP.PrintName = "Blowtorch";
        SWEP.Slot = 5;
        SWEP.SlotPos = 8;
        SWEP.DrawAmmo = false;
        SWEP.DrawCrosshair = false;
 
end
 
// Variables that are used on both client and server
 
SWEP.Author                     = "HLTV Proxy"
SWEP.Instructions       = "Blowtorch: Hold left click on a prop to eventually remove it."
SWEP.Contact            = ""
SWEP.Purpose            = ""
 
SWEP.ViewModelFOV       = 73
SWEP.ViewModelFlip      = false
SWEP.ViewModel = Model( "models/weapons/v_IRifle.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_IRifle.mdl" )
 
SWEP.Spawnable                  = false
SWEP.AdminSpawnable             = true
 
SWEP.Sound = Sound( "physics/wood/wood_box_impact_hard3.wav" );
 
SWEP.Primary.ClipSize           = -1                                    // Size of a clip
SWEP.Primary.DefaultClip        = 0                             // Default number of bullets in a clip
SWEP.Primary.Automatic          = true                          // Automatic/Semi Auto
SWEP.Primary.Ammo                       = ""
 
SWEP.Secondary.ClipSize         = -1                            // Size of a clip
SWEP.Secondary.DefaultClip      = 0                             // Default number of bullets in a clip
SWEP.Secondary.Automatic        = true                  // Automatic/Semi Auto
SWEP.Secondary.Ammo                     = ""
 
 
 
/*---------------------------------------------------------
   Name: SWEP:Initialize( )
   Desc: Called when the weapon is first loaded
---------------------------------------------------------*/
function SWEP:Initialize()
 
        if( SERVER ) then
                // make it an ar2 model, but hold it as a pistol so that people know its the welder.
                self:SetWeaponHoldType( "pistol" );
       
        end
        util.PrecacheSound("physics/metal/metal_box_impact_soft2.wav")
        util.PrecacheSound("ambient/energy/spark1.wav")
        util.PrecacheSound("ambient/energy/spark2.wav")
        util.PrecacheSound("ambient/energy/spark3.wav")
        util.PrecacheSound("ambient/energy/spark4.wav")
end
 
 
/*---------------------------------------------------------
   Name: SWEP:Precache( )
   Desc: Use this function to precache stuff
---------------------------------------------------------*/
function SWEP:Precache()
end
 
 
/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/
 
function SWEP:PrimaryAttack()
self.Weapon:SetNextPrimaryFire(CurTime() + .075)
       
        local trace = self.Owner:GetEyeTrace()
        local snd = math.random(1,4)
		local trArray = {}
		local tr = {}
                tr.start = trace.HitPos
                tr.endpos = trace.HitPos + (self:GetOwner():GetAimVector() * 128)
                tr.filter = { self:GetOwner(), trace.Entity }
        local trtwo = util.TraceLine( tr )
		
		local trx = {}
                trx.start = trtwo.HitPos
                trx.endpos = trtwo.HitPos + (self:GetOwner():GetAimVector() * 128.0)
                trx.filter = { self:GetOwner(), trace.Entity, trtwo.Entity }
        local trthree = util.TraceLine( trx )
		
		        local try = {}
                try.start = trthree.HitPos
                try.endpos = trthree.HitPos + (self:GetOwner():GetAimVector() * 128.0)
                try.filter = { self:GetOwner(), trace.Entity, trtwo.Entity, trthree.Entity }
        local trfour = util.TraceLine( try )
		
		        local trz = {}
                trz.start = trfour.HitPos
                trz.endpos = trfour.HitPos + (self:GetOwner():GetAimVector() * 128.0)
                trz.filter = { self:GetOwner(), trace.Entity, trtwo.Entity, trthree.Entity, trfour.Entity }
        local trfive = util.TraceLine( trz )
		
		trArray[1] = trace
		trArray[2] = trtwo
		trArray[3] = trthree
		trArray[4] = trfour
		trArray[5] = trfive
		
		for k,v in pairs(trArray) do
			if(!v.Hit) then
				continue
			end
			if(v.HitPos:Distance(self.Owner:GetShootPos()) <= (128*k) and (v.Entity:GetClass()=="prop_ragdoll" || v.Entity:GetClass()=="prop_physics_multiplayer" || v.Entity:GetClass()=="prop_physics_respawnable" || v.Entity:GetClass()=="prop_physics" || v.Entity:GetClass()=="phys_magnet" || v.Entity:GetClass()=="gmod_spawner" || v.Entity:GetClass()=="gmod_wheel" || v.Entity:GetClass()=="gmod_thruster" || v.Entity:GetClass()=="gmod_button" || v.Entity:GetClass()=="sent_keypad" || v.Entity:GetClass()=="gmod_light")and v.Entity:IsValid()) then
				if(k == 1) then
					local effectdata = EffectData()
						effectdata:SetOrigin(v.HitPos)
                        effectdata:SetMagnitude( 1 )
                        effectdata:SetScale( 2 )
                        effectdata:SetRadius( 2 )
					util.Effect( "Sparks", effectdata )
					self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
					self.Owner:SetAnimation(PLAYER_ATTACK1)
					self.Weapon:EmitSound("ambient/energy/spark"..snd..".wav")
				end
				
				if SERVER then
					//local eOwner = player.GetByUniqueID(v.Entity:GetVar("PropProtection"))
					--timer.Destroy(tostring(v.Entity) .. "unweldamage")
					--timer.Create(tostring(v.Entity) .. "unweldamage",10,1,function()
					--	WeldControl(v.Entity, player.GetByUniqueID(v.Entity:GetVar("PropProtection")),tostring(v.Entity))
					--end)
					
					if(v.Entity:GetNWInt("welddamage") == nil || v.Entity:GetNWInt("welddamage") <= 0 || v.Entity:GetNWInt("welddamage") == 255) then
						v.Entity:SetNWInt("welddamage", 254)
						if SERVER then
							//self:GetOwner():PrintMessage(HUD_PRINTTALK,"Debug Message weapon_welder, initiate shitwelding = true!")
							if(player.GetByUniqueID(v.Entity:GetVar("PropProtection")) != false ) then
								local entowner = player.GetByUniqueID(v.Entity:GetVar("PropProtection"))
								--entowner:GetTable().shitweldcount = entowner:GetTable().shitweldcount + 1
								--AddNewSWEntry(entowner,tostring(v.Entity))
								--entowner:SetNWBool("shitwelding", true)
								Notify(entowner, 1, 3, "Someone is destroying one of your props with a blowtorch!")
								entowner:PrintMessage(HUD_PRINTTALK,"Someone is destroying one of your props with a blowtorch!")
							end
						end
					else if(v.Entity:GetNWInt("welddamage") > 1) then
						v.Entity:SetNWInt("welddamage", v.Entity:GetNWInt("welddamage") - 1)
						
						if SERVER then
							if(trace.Entity:GetNWInt("welddamage")==130) then
								if(v.Entity:CPPIGetOwner()==true) then
									local entowner = player.GetByUniqueID(v.Entity:GetVar("PropProtection"))
									Notify(entowner, 1, 3, "Someone has nearly finished destroying one of your props using a blowtorch!")
									entowner:PrintMessage(HUD_PRINTTALK,"Someone has nearly finished destroying one of your props with a blowtorch!")
								end
							end
						end
					else
					    local effectdata = EffectData()
                            effectdata:SetStart( v.Entity:GetPos() )
                            effectdata:SetOrigin( v.Entity:GetPos() )
                            effectdata:SetScale( 1 )
                        util.Effect( "Explosion", effectdata )
						if SERVER then
							if(player.GetByUniqueID(trace.Entity:GetVar("PropProtection")) != false) then
								local entowner = player.GetByUniqueID(v.Entity:GetVar("PropProtection"))
								Notify(entowner, 1, 3, "Someone has destroyed one of your props using a blowtorch!")
								entowner:PrintMessage(HUD_PRINTTALK,"Someone has destroyed one of your props using a blowtorch!")
								//entowner:PrintMessage(HUD_PRINTTALK,"weapon_welder Debug Message, Prop has been destroyed!")
								v.Entity:Remove()
								--WeldControl(v.Entity,entowner,tostring(v.Entity))
							end
						end
						

                        if SERVER then
							//entowner:PrintMessage(HUD_PRINTTALK,"weapon_welder Debug Message, remove prop!")
                        end
					end
				end
			end
		end
	end       
end
 /*
 								local entowner = player.GetByUniqueID(v.Entity:GetVar("PropProtection"))
								entowner:PrintMessage(HUD_PRINTTALK,"weapon_welder Debug Message, your prop got destroyed so shitweldcount++, shitwelding = true")
								entowner:SetNWBool("shitwelding",true)
								entowner:GetTable().shitweldcount = entowner:GetTable().shitweldcount + 1
								AddNewSWEntry(entowner,tostring(v.Entity))
                                timer.Destroy(tostring(v.Entity) .. "unweldamage")
                                // stick the thumb 30 seconds deeper into their ass and keep them from spawning anything on a successful weld attempt
                                timer.Create(tostring(v.Entity) .. "unweldamage", 15, 1, function()
									WeldControl( v.Entity, player.GetByUniqueID(v.Entity:GetVar("PropProtection")),tostring(v.Entity))
								end)
                                //WeldControl(trace.Entity, player.GetByUniqueID(trace.Entity:GetVar("PropProtection")))
                                timer.Destroy(tostring(v.Entity) .. "undamagecolor")*/
 
// secondary attack - repair shit.
// temporarily disabled to prevent "cant spawn shit ever again" glitch
 
function SWEP:SecondaryAttack()
        /*
        self.Weapon:SetNextSecondaryFire(CurTime() + .125)
       
        local trace = self.Owner:GetEyeTrace()
        local snd = math.random(1,6)
        // some of the spark sounds are annoying.
        if (snd==5 || snd==6) then snd=4 end
        // filter what class it is, so that retards cannot delete crazy shit such as important map parts, jeeps, doors, etc.
        if (trace.HitPos:Distance(self.Owner:GetShootPos()) <= 75 and (trace.Entity:GetClass()=="prop_physics" || trace.Entity:GetClass()=="phys_magnet" || trace.Entity:GetClass()=="gmod_spawner" || trace.Entity:GetClass()=="gmod_wheel" || trace.Entity:GetClass()=="gmod_thruster" || trace.Entity:GetClass()=="gmod_button")and trace.Entity:IsValid()) then
                local effectdata = EffectData()
                        effectdata:SetOrigin(trace.HitPos)
                        effectdata:SetMagnitude( 1 )
                        effectdata:SetScale( 2 )
                        effectdata:SetRadius( 2 )
                util.Effect( "Sparks", effectdata )
                self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
                self.Owner:SetAnimation( PLAYER_ATTACK1 )
               
                // self.Weapon:EmitSound("physics/metal/metal_box_impact_soft2.wav")
                self.Weapon:EmitSound("ambient/energy/spark" .. snd .. ".wav")
                if(trace.Entity:GetNWInt("welddamage") != nil && trace.Entity:GetNWInt("welddamage") > 0 && trace.Entity:GetNWInt("welddamage") < 255) then
                        trace.Entity:SetNWInt("welddamage", trace.Entity:GetNWInt("welddamage") + 1)
                end
        else
                self.Weapon:EmitSound("ambient/energy/spark" .. snd.. ".wav")
                self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
                self.Owner:SetAnimation( PLAYER_ATTACK1 )
        end
        */
end
 
// this isnt needed anymore, since there is a hook to make it not drop.
function SWEP:Equip()
        if SERVER then
                if (self.WasEquipped==1) then self.Weapon:Remove() end
                self.WasEquipped=1
        end
end
 
function SWEP:ShouldDropOnDie()
        return false
end