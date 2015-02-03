// LL Things to do:

// Concerning Donations
// So there will be 2 Main groups: Founder and VIP (Donator)
// The groups will be then split apart for funzies look below, its just to give special people special things.


FoundersMain = { // Gets like /magicllama and stuff...
"STEAM_0:1:56868983" // Drex
}

_R = debug.getregistry()

Founders = { }

table.Add(Founders, FoundersMain)

Donor = {

"STEAM_0:1:56868983" // Drex
}

Donor02 = {

"STEAM_0:1:56868983" // Drex
}

Donor03 = {

"STEAM_0:1:56868983" // Drex
}

VIP = { }

table.Add(VIP, Donor)
table.Add(VIP, Donor01)
table.Add(VIP, Donor02)
table.Add(VIP, Donor03)

/*
STAFF = { }

table.Add(STAFF, JrMod)
table.Add(STAFF, Mod)
table.Add(STAFF, SuperMod)
table.Add(STAFF, JrAdmin)
table.Add(STAFF, Admin)
table.Add(STAFF, SuperAdmin)
*/

function _R.Player:IsDonor(arg)
	return self.DonorStatus == arg
end

function GetDonorStatus(ply)
	if table.HasValue( Founders, ply:SteamID() ) then
		ply:SetNWString("Status","Founder")
			if table.HasValue( FoundersMain, ply:SteamID() ) then
				ply:SetNWString("SubStatus","Owner")
			end
		return
	end
/*	
	if table.HasValue( STAFF, ply:SteamID() ) then
		ply:SetNWString("Status","Staff")
			if table.HasValue( JrMod, ply:SteamID() ) then
				ply:SetNWString("SubStatus","Jr Mod")
			end
			if table.HasValue( Mod, ply:SteamID() ) then
				ply:SetNWString("SubStatus","Mod")
			end
			if table.HasValue( SuperMod, ply:SteamID() ) then
				ply:SetNWString("SubStatus","Super Mod")
			end			
			if table.HasValue( JrAdmin, ply:SteamID() ) then
				ply:SetNWString("SubStatus","Jr Admin")
			end		
			if table.HasValue( Admin, ply:SteamID() ) then
				ply:SetNWString("SubStatus","Admin")
			end		
			if table.HasValue( SuperAdmin, ply:SteamID() ) then
				ply:SetNWString("SubStatus","Super Admin")
			end		
		return
	end
*/	
	if table.HasValue( VIP, ply:SteamID() ) then
		ply:SetNWString("Status","VIP")
			if table.HasValue( Donor, ply:SteamID() ) then
				ply:SetNWString("SubStatus","VIP")
			end		
			if table.HasValue( Donor02, ply:SteamID() ) then
				ply:SetNWString("SubStatus","VIP+")
			end
			if table.HasValue( Donor03, ply:SteamID() ) then
				ply:SetNWString("SubStatus","VIP++")
			end			
/*
			if table.HasValue( Dev, ply:SteamID() ) then
				ply:SetNWString("SubStatus","Dev")
			end
			if table.HasValue( Famous, ply:SteamID() ) then
				ply:SetNWString("SubStatus","Famous")
			end
			if table.HasValue( VERY_VIP, ply:SteamID() ) then
				ply:SetNWString("SubStatus","+VIP")
			end
			if table.HasValue( VIPMain, ply:SteamID() ) then
				ply:SetNWString("SubStatus","VIP")
			end
			if table.HasValue( Dev, ply:SteamID() ) then
				ply:SetNWString("SubStatus","Dev")
			end
			if table.HasValue( Famous, ply:SteamID() ) then
				ply:SetNWString("SubStatus","Famous")
			end
			if table.HasValue( VERY_VIP, ply:SteamID() ) then
				ply:SetNWString("SubStatus","+VIP")
			end
*/			
		return
	end
	ply:SetNWString("Status","Guest")
	ply:SetNWString("SubStatus","Guest")
end
hook.Add( "PlayerInitialSpawn", "GetDonorStatusHook", GetDonorStatus )