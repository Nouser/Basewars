if( SERVER ) then
 
        AddCSLuaFile( "shared.lua" );
 
end
 
if( CLIENT ) then
 
        SWEP.PrintName 		= "God Stick";
        SWEP.Slot 			= 0;
        SWEP.SlotPos 		= 5;
        SWEP.DrawAmmo 		= false;
        SWEP.DrawCrosshair 	= true;
 
end
 
// Variables that are used on both client and server
 
SWEP.Author				= "Hunts"
SWEP.Instructions		= "Left click to fire, right click to change"
SWEP.Contact			= ""
SWEP.Purpose			= ""
 
SWEP.ViewModelFOV		= 62
SWEP.ViewModelFlip		= false
SWEP.AnimPrefix			= "stunstick"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true
 
SWEP.NextStrike			= 0;
  
SWEP.ViewModel			= Model( "models/weapons/v_stunstick.mdl" );
SWEP.WorldModel			= Model( "models/weapons/w_stunbaton.mdl" );
  
SWEP.Sound				= Sound( "weapons/stunstick/stunstick_swing1.wav" );
SWEP.Sound1				= Sound( "npc/metropolice/vo/moveit.wav" );
SWEP.Sound2				= Sound( "npc/metropolice/vo/movealong.wav" );

SWEP.Primary.ClipSize		= -1			// Size of a clip
SWEP.Primary.DefaultClip	= 0				// Default number of bullets in a clip
SWEP.Primary.Automatic		= false			// Automatic/Semi Auto
SWEP.Primary.Ammo			= ""
 
SWEP.Secondary.ClipSize			= -1		// Size of a clip
SWEP.Secondary.DefaultClip		= 0			// Default number of bullets in a clip
SWEP.Secondary.Automatic		= false		// Automatic/Semi Auto
SWEP.Secondary.Ammo				= ""
 
/*---------------------------------------------------------
   Name: SWEP:Initialize( )
   Desc: Called when the weapon is first loaded
---------------------------------------------------------*/
function SWEP:Initialize()
 
        if( SERVER ) then

				self.Gear = 1;
        
        end
		
		self:SetWeaponHoldType( "melee" );
        
end

local SLAP_SOUNDS = {
	"physics/body/body_medium_impact_hard1.wav",
	"physics/body/body_medium_impact_hard2.wav",
	"physics/body/body_medium_impact_hard3.wav",
	"physics/body/body_medium_impact_hard5.wav",
	"physics/body/body_medium_impact_hard6.wav",
	"physics/body/body_medium_impact_soft5.wav",
	"physics/body/body_medium_impact_soft6.wav",
	"physics/body/body_medium_impact_soft7.wav"
}
 
 
/*---------------------------------------------------------
   Name: SWEP:Precache( )
   Desc: Use this function to precache stuff
---------------------------------------------------------*/
function SWEP:Precache()
end
 
function SWEP:DoFlash( ply )
 
        umsg.Start( "StunStickFlash", ply ); umsg.End();
 
end

local Gears = {};

/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/
  function SWEP:PrimaryAttack()
  
        if( CurTime() < self.NextStrike ) then return; end
		if !self.Owner:IsUserGroup("founder") && !self.Owner:IsUserGroup("superadmin") then
			self.Owner:Kill( "Basewars Staff Only!" );
//			self.Owner:Kill then
			return false;
		end
 
        self.Owner:SetAnimation( PLAYER_ATTACK1 );
		
		local r, g, b, a = self.Owner:GetColor();
		
		if a != 0 then
			self.Weapon:EmitSound( self.Sound );
		end
		
        self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER );
 
        self.NextStrike = ( CurTime() + .3 );

        if( CLIENT ) then return; end
 
        local trace = self.Owner:GetEyeTrace();
        
        local Gear = self.Owner:GetTable().CurGear or 1;
		
		if Gears[Gear][3] and !self.Owner:IsUserGroup("founder") && !self.Owner:IsUserGroup("superadmin") then
			Notify( self, 4, 2, "Basewars Staff Only!" );
			return false;
		end
		
		Gears[Gear][4](self.Owner, trace);
  end
  

  local function AddGear ( Title, Desc, SA, Func )
		table.insert(Gears, {Title, Desc, SA, Func});
  end
  
AddGear("Warn Player", "Aim at a player to warn him.", false,
	function ( Player, Trace )
			if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then
				Trace.Entity:Notify(4, 2, "An admin thinks you're doing something stupid. Stop.");
				Player:Notify(4, 2, "You have been Warned!");
//				Player:PrintMessage(HUD_PRINTTALK, "Player warned.");
			end
	end
);

AddGear("Slap Player", "Aim at a entity to slap it.", false,
	function ( Player, Trace )
				if !Trace.Entity:IsPlayer() then
					local RandomVelocity = Vector( math.random(5000) - 2500, math.random(5000) - 2500, math.random(5000) - (5000 / 4 ) )
					local RandomSound = SLAP_SOUNDS[ math.random(#SLAP_SOUNDS) ]
					
					Trace.Entity:EmitSound( RandomSound )
					Trace.Entity:GetPhysicsObject():SetVelocity( RandomVelocity )
					Player:PrintMessage(HUD_PRINTTALK, "Entity slapped.");
				else
					local RandomVelocity = Vector( math.random(500) - 250, math.random(500) - 250, math.random(500) - (500 / 4 ) )
					local RandomSound = SLAP_SOUNDS[ math.random(#SLAP_SOUNDS) ]
					
					Trace.Entity:EmitSound( RandomSound )
					Trace.Entity:SetVelocity( RandomVelocity )
					Player:PrintMessage(HUD_PRINTTALK, "Player slapped.");
				end
	end
);
  
AddGear("Kill Player", "Aim at a player to slay him.", false,
	function ( Player, Trace )
		if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then
			Trace.Entity:Kill();
			Player:PrintMessage(HUD_PRINTTALK, "Player killed.");
		end
	end
);

AddGear("Kick Player", "Aim at a player to kick him.", false,
	function ( Player, Trace )
			if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then
				Trace.Entity:Kick("Consider this a warning.");
				Player:PrintMessage(HUD_PRINTTALK, "Player kicked.");
			end
	end
);

AddGear("Super Slap Player", "Aim at an entity to super slap it.", true,
	function ( Player, Trace )
			if IsValid(Trace.Entity) then
				if !Trace.Entity:IsPlayer() then
					local RandomVelocity = Vector( math.random(50000) - 25000, math.random(50000) - 25000, math.random(50000) - (50000 / 4 ) )
					local RandomSound = SLAP_SOUNDS[ math.random(#SLAP_SOUNDS) ]
					
					Trace.Entity:EmitSound( RandomSound )
					Trace.Entity:GetPhysicsObject():SetVelocity( RandomVelocity )
					Player:PrintMessage(HUD_PRINTTALK, "Entity super slapped.");
				else
					local RandomVelocity = Vector( math.random(5000) - 2500, math.random(5000) - 2500, math.random(5000) - (5000 / 4 ) )
					local RandomSound = SLAP_SOUNDS[ math.random(#SLAP_SOUNDS) ]
					
					Trace.Entity:EmitSound( RandomSound )
					Trace.Entity:SetVelocity( RandomVelocity )
					Player:PrintMessage(HUD_PRINTTALK, "Player super slapped.");
				end
			end
	end
);

AddGear("Invisibility", "Left click to turn invisible. Left click again to return back to normal.", true,
	function ( Player )
		local r, g, b, a = Player:GetColor();
		
		if a == 255 then
			Player:PrintMessage(HUD_PRINTTALK, "You are now invisible.");
			Player:SetColor(Color(950, 50, 50, 0));
		else
			Player:PrintMessage(HUD_PRINTTALK, "You are no longer invisible.");
			Player:SetColor(Color(255, 255, 255, 255));
		end
	end
);

AddGear("Ignite", "Ignites a player", true,
	function ( Player, Trace )
		if IsValid(Trace.Entity) then
			Trace.Entity:Ignite(60);
		else
			local Fire = ents.Create('ent_fire');
			Fire:SetPos(Trace.HitPos);
			Fire:Spawn();
			
			Player:PrintMessage(HUD_PRINTTALK, "Fire started.");
		end
	end
);
/*
AddGear("Freeze", "Target a player to change his freeze state.", false,
	function ( Player, Trace )
			if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then
				if Trace.Entity.IsFrozens then
					Trace.Entity:Freeze(false);
					Player:PrintMessage(HUD_PRINTTALK, "Player unfrozen.");
					Trace.Entity:PrintMessage(HUD_PRINTTALK, "You have been unfrozen.");
					Trace.Entity.IsFrozens = nil;
				else
					Trace.Entity.IsFrozens = true;
					Trace.Entity:Freeze(true);
					Player:PrintMessage(HUD_PRINTTALK, "Player frozen.");
					Trace.Entity:PrintMessage(HUD_PRINTTALK, "You have been frozen.");
				end
			end
	end
);
*/
AddGear("Teleport", "Teleports you to a targeted location.", true,
	function ( Player, Trace )
		local EndPos = Player:GetEyeTrace().HitPos;
		local CloserToUs = (Player:GetPos() - EndPos):Angle():Forward();
		
		Player:SetPos(EndPos + (CloserToUs * 20));
		Player:PrintMessage(HUD_PRINTTALK, "Teleported.");
	end
);

AddGear("God Mode", "Left click to enable/disable god mode.", true,
	function ( Player, Trace )
		if Player.IsGod then
			Player.IsGod = false;
			Player:PrintMessage(HUD_PRINTTALK, "Godmode disabled");
			Player:GodDisable();
		else
			Player.IsGod = true;
			Player:PrintMessage(HUD_PRINTTALK, "Godmode enabled");
			Player:GodEnable();
		end
	end
);

AddGear("Freeze", "Target a player to change his freeze state.", false,
	function ( Player, Trace )
			if IsValid(Trace.Entity) and Trace.Entity:IsPlayer() then
				if Trace.Entity.IsFrozens then
					Trace.Entity:Freeze(false);
					Player:PrintMessage(HUD_PRINTTALK, "Player unfrozen.");
					Trace.Entity:PrintMessage(HUD_PRINTTALK, "You have been unfrozen.");
					Trace.Entity.IsFrozens = nil;
				else
					Trace.Entity.IsFrozens = true;
					Trace.Entity:Freeze(true);
					Player:PrintMessage(HUD_PRINTTALK, "Player frozen.");
					Trace.Entity:PrintMessage(HUD_PRINTTALK, "You have been frozen.");
				end
			end
	end
);

AddGear("Remover", "Aim at any object to remove it.", true,
	function ( Player, Trace )
			if IsValid(Trace.Entity) then
				if Trace.Entity:IsVehicle() and IsValid(Trace.Entity:GetDriver()) then
					Trace.Entity:GetDriver():ExitVehicle();
				end
				
				if Trace.Entity:IsPlayer() then
					Trace.Entity:Kill();
				else
					Trace.Entity:Remove();
				end
			end
	end
);

function SWEP:Think ( )
	if self.Floater then
			local trace = {}
			trace.start = self.Floater:GetPos()
			trace.endpos = trace.start - Vector(0, 0, 100000);
			trace.filter = { self.Floater }
			local tr = util.TraceLine( trace )
		
		local altitude = tr.HitPos:Distance(trace.start);
		
		local ent = self.Spazzer;
		local vec;
		
		if self.FloatSmart then
			local trace = {}
			trace.start = self.Owner:GetShootPos()
			trace.endpos = trace.start + (self.Owner:GetAimVector() * 400)
			trace.filter = { self.Owner, self.Weapon }
			local tr = util.TraceLine( trace )
			
			vec = trace.endpos - self.Floater:GetPos();
		else
			vec = Vector(0, 0, 0);
		end
		
		if altitude < 150 then
			if vec == Vector(0, 0, 0) then
				vec = Vector(0, 0, 25);
			else
				vec = vec + Vector(0, 0, 100);
			end
		end
		
		vec:Normalize()
		
		if self.Floater:IsPlayer() then
			local speed = self.Floater:GetVelocity()
			self.Floater:SetVelocity( (vec * 1) + speed)
		else
			local speed = self.Floater:GetPhysicsObject():GetVelocity()
			self.Floater:GetPhysicsObject():SetVelocity( (vec * math.Clamp((self.Floater:GetPhysicsObject():GetMass() / 20), 10, 20)) + speed)
		end

	end
end

 // Draw the Crosshair
 local chRotate = 0;
 function SWEP:DrawHUD( )
 if (!CLIENT) then return; end
	 local godstickCrosshair = surface.GetTextureID("perp2/crosshairs/godstick_crosshairv4");
	 local trace = self.Owner:GetEyeTrace();
	 local x = (ScrW()/2);
	 local y = (ScrH()/2);
					
		if IsValid(trace.Entity) then
			draw.WordBox( 8, (x-100), 10, "Target: " .. tostring(trace.Entity), "Scoreboard", Color(50,50,75,100), Color(255,0,0,255) );
			surface.SetDrawColor(255, 0, 0, 255);
			chRotate = chRotate + 8;
		else
			draw.WordBox( 8, (x-100), 10, "Target: " .. tostring(trace.Entity), "Scoreboard", Color(50,50,75,100), Color(255,255,255,255) );
			surface.SetDrawColor(255, 255, 255, 255);
			chRotate = chRotate + 3;
		end
		
		surface.SetTexture(godstickCrosshair);
		surface.DrawTexturedRectRotated(x, y, 64, 64, 0 + chRotate);
		
		
 end
 
 function MonitorWeaponVis ( )
	for k, v in pairs(player.GetAll()) do
		if v:IsAdmin() and IsValid(v:GetActiveWeapon()) then
			local pr, pg, pb, pa = v:GetColor();
			local wr, wg, wb, wa = v:GetActiveWeapon():GetColor();
			
			if pa == 0 and wa == 255 then
				v:GetActiveWeapon():SetColor(Color(wr, wg, wb, 0));
			elseif pa == 255 and wa == 0 then
				v:GetActiveWeapon():SetColor(Color(wr, wg, wb, 255));
			end
		end
		
		/*
		if v:InVehicle() and v:GetVehicle().CanFly then
			local t, r, a = v:GetVehicle();
			
			if IsValid(t) then
				local p = t:GetPhysicsObject();
				a = t:GetAngles();
				r = 180 * ((a.r-180) > 0 && 1 or -1) - (a.r - 180);
				p:AddAngleVelocity(p:GetAngleVelocity() * -1 + Angle(a.p * -1, 0, r));
			end
		end
		*/
	end
 end
 hook.Add('Think', 'MonitorWeaponVis', MonitorWeaponVis);
 
 function MonitorKeysForFlymobile ( Player, Key )
	if Player:InVehicle() and Player:GetVehicle().CanFly then
		local Force;
		
		if Key == IN_ATTACK then
			Force = Player:GetVehicle():GetUp() * 450000;
		elseif Key == IN_ATTACK2 then
			Force = Player:GetVehicle():GetForward() * 100000;
		end
		
		if Force then
			Player:GetVehicle():GetPhysicsObject():ApplyForceCenter(Force);
		end
	end
 end
 hook.Add('KeyPress', 'MonitorKeysForFlymobile', MonitorKeysForFlymobile);
 
 if SERVER then
	  function GodSG ( Player, Cmd, Args )
			Player:GetTable().CurGear = tonumber(Args[1]);
	  end
	  concommand.Add('god_sg', GodSG);
 end
 
 timer.Simple(.5, function () GAMEMODE.StickText = Gears[1][1] .. ' - ' .. Gears[1][2] end);
 
  /*---------------------------------------------------------
   Name: SWEP:SecondaryAttack( )
   Desc: +attack2 has been pressed
  ---------------------------------------------------------*/
  function SWEP:SecondaryAttack()	
		if SERVER then return false; end
		
		local MENU = DermaMenu()
		
		for k, v in pairs(Gears) do
			local Title = v[1];
			
---			if v[3] then
---				Title = "[SA] " .. Title;
---			end
			
			MENU:AddOption(Title, 	function()
										RunConsoleCommand('god_sg', k) 
										LocalPlayer():PrintMessage(HUD_PRINTTALK, v[2]);
										GAMEMODE.StickText = v[1] .. ' - ' .. v[2];
									end )
		end
		
		MENU:Open( 100, 100 )	
		timer.Simple( 0, gui.SetMousePos, 110, 110 )
	
  end 
/*  
 function TryRevive ()
	//if !LocalPlayer():IsSuperAdmin() then return false; end
	
	local EyeTrace = LocalPlayer():GetEyeTrace();
	
 			for k, v in pairs(player.GetAll()) do
				if !v:Alive() then
					for _, ent in pairs(ents.FindInSphere(EyeTrace.HitPos, 5)) do						
						if ent == v:GetRagdollEntity() then
							RunConsoleCommand('perp_m_h', v:UniqueID());
							LocalPlayer():PrintMessage(HUD_PRINTTALK, "Player revived.");
							return;
						end
					end
				end
			end
 end
 usermessage.Hook('god_try_revive', TryRevive);
 */