include( "vars.lua" )

local buytable = {}

buytable["Ammo"] = {}
buytable["Ammo"].Names = {"Ammo", "40MM Ammo"}
buytable["Ammo"].Cost = {CfgVars["ammocost"], CfgVars["ammo40MMcost"]}
buytable["Ammo"].Data = {"currentammo", "grenadeammo"}
buytable["Ammo"].Cmd = "buyammo"
buytable["Ammo"].Model = {"models/items/ammopack_large.mdl", "models/items/ammocrate_grenade"}
buytable["I. Base - General"] = {}
buytable["I. Base - General"].Names = {
"Floor Turret",
"Sentry Gun",
"Spawn Point",
"Ammo Dispenser",
"Health Dispenser",
"Armor Dispenser",
"Radar Tower",
"Drug Refinery",
"Gun Factory",
"Solar Generator",
"Generator",
"Super Generator",
"Nuclear Generator",
"Money Vault",
"Supply Table",
"Gun Vault",
"Drug Vault"
}
buytable["I. Base - General"].Cost = {
CfgVars["floorturretcost"],
CfgVars["turretcost"],
CfgVars["spawncost"],
CfgVars["dispensercost"],
CfgVars["healthdispensercost"],
CfgVars["armordispensercost"],
CfgVars["radartowercost"],
CfgVars["drugfactorycost"],
CfgVars["gunfactorycost"],
CfgVars["solargeneratorcost"],
CfgVars["generatorcost"],
CfgVars["supergeneratorcost"],
CfgVars["nucleargeneratorcost"],
CfgVars["moneyvaultcost"],
CfgVars["supplytablecost"],
CfgVars["gunvaultcost"],
CfgVars["drugvaultcost"]
}
buytable["I. Base - General"].Data = {
"floor",
"sentry",
"spawn",
"dispenser",
"healthdispenser",
"armordispenser",
"radar",
"refinery",
"factory",
"solargenerator",
"generator",
"supergenerator",
"nucleargenerator",
"moneyvault",
"supplycabinet",
"gunvault",
"pillbox"
}
buytable["I. Base - General"].Cmd = "buystruct"
buytable["I. Base - General"].Model = {
"models/combine_turrets/floor_turret.mdl",
"models/props_c17/TrapPropeller_Engine.mdl",
"models/props_trainstation/trainstation_clock001.mdl",
"models/props_lab/reciever_cart.mdl",
"models/props_combine/health_charger001.mdl",
"models/props_combine/suit_charger001.mdl",
"models/props_rooftop/roof_dish001.mdl",
"models/props_c17/furniturestove001a.mdl",
"models/props/de_prodigy/transformer.mdl",
"models/lmaollama/solarpanel-3.mdl",
"models/props_vehicles/generatortrailer01.mdl",
"models/props_mining/diesel_generator.mdl",
"models/magnusson_teleporter.mdl",
"models/props_lab/powerbox01a.mdl",
"models/props/cs_militia/table_shed.mdl",
"models/props/cs_militia/footlocker01_closed.mdl",
"models/props_c17/furniturefridge001a.mdl"
}

buytable["II. Base - Profitables"] = {}
buytable["II. Base - Profitables"].Names = {
"Weed Plant",
"Still",
"Drug Lab",
"Meth Lab",
"Stable Meth Lab",
"Bronze Printer",
"Silver Printer",
"Rhenium Printer",
"Iridium Printer",
"Palladium Printer",
"Gold Printer",
"Platinum Printer",
"Rhodium Printer",
"Money Factory",
"Golden Money Silo",
"Nuclear Money Factory",
"Nova Money Printer"
}
buytable["II. Base - Profitables"].Cost = {
CfgVars["weedcost"],
CfgVars["stillcost"],
CfgVars["druglabcost"],
CfgVars["methlabcost"],
CfgVars["stablemethlab"],
CfgVars["bronzeprintercost"],
CfgVars["silverprintercost"],
CfgVars["rheniumprintercost"],
CfgVars["iridiumprintercost"],
CfgVars["palladiumprintercost"],
CfgVars["goldprintercost"],
CfgVars["platinumprintercost"],
CfgVars["rhodiumprintercost"],
CfgVars["moneyfactorycost"],
CfgVars["goldensilocost"],
CfgVars["nuclearfactorycost"],
CfgVars["novaprintercost"]
}
buytable["II. Base - Profitables"].Data = {
"plant",
"still",
"druglab",
"methlab",
"stablemethlab",
"bronzeprinter",
"silverprinter",
"rheniumprinter",
"iridiumprinter",
"palladiumprinter",
"goldprinter",
"platinumprinter",
"rhodiumprinter",
"moneyfactory",
"goldensilo",
"nuclearfactory",
"novaprinter"
}
buytable["II. Base - Profitables"].Cmd = "buystruct"
buytable["II. Base - Profitables"].Model = {
"models/props/cs_office/plant01.mdl",
"models/props/de_inferno/wine_barrel.mdl",
"models/props_combine/combine_mine01.mdl",
"models/props/de_train/processor_nobase.mdl",
"models/props/de_train/processor.mdl",
"models/props_lab/reciever01b.mdl",
"models/props_lab/reciever01a.mdl",
"models/props_c17/consolebox03a.mdl",
"models/props_c17/consolebox05a.mdl",
"models/props_c17/consolebox01a.mdl",
"models/props_c17/consolebox01a.mdl",
"models/props_c17/consolebox01a.mdl",
"models/props_c17/consolebox01a.mdl",
"models/props_lab/servers.mdl",
"models/props_wasteland/laundry_washer003.mdl",
"models/props_lab/servers.mdl",
"models/props_wasteland/laundry_washer001a.mdl"
}

buytable["III. Base - Donor Profitables"] = {}
buytable["III. Base - Donor Profitables"].Names = {
"Tuned Silver Printer",
"Tuned Iridium Printer",
"Tuned Gold Printer",
"Tuned Rhodium Printer",
"Tuned Golden Silo",
"Quantum Money Factory"
}
buytable["III. Base - Donor Profitables"].Cost = {
CfgVars["tunedsilvercost"],
CfgVars["tunediridiumcost"],
CfgVars["tunedgoldcost"],
CfgVars["tunedrhodiumcost"],
CfgVars["tunedgoldencost"],
CfgVars["quantumfactorycost"]
}
buytable["III. Base - Donor Profitables"].Data = {
"tunedsilver",
"tunediridium",
"tunedgold",
"tunedrhodium",
"tunedgolden",
"quantumfactory"
}
buytable["III. Base - Donor Profitables"].Cmd = "buystruct"
buytable["III. Base - Donor Profitables"].Model = {
"models/props_lab/reciever01b.mdl",
"models/props_lab/reciever01a.mdl",
"models/props_c17/consolebox03a.mdl",
"models/props_c17/consolebox05a.mdl",
"models/props_wasteland/laundry_washer003.mdl",
"models/props_wasteland/laundry_washer001a.mdl"
}

buytable["IV. Equipment and Tools"] = {}
buytable["IV. Equipment and Tools"].Names = {"Health Kit","Armor","Helmet","Snipe Shield","Scan Blocker","Defusal Kit","Blowtorch"}
buytable["IV. Equipment and Tools"].Cost = {CfgVars["healthcost"],CfgVars["armorcost"],CfgVars["helmetcost"],CfgVars["shieldcost"],CfgVars["scanblockcost"],CfgVars["defusekitcost"],CfgVars["blowtorchcost"]}
buytable["IV. Equipment and Tools"].Data = {"health","armor","helmet","shield","scanner","toolkit","welder"}
buytable["IV. Equipment and Tools"].Cmd = "buyspecial"
buytable["IV. Equipment and Tools"].Model = {"models/items/healthkit.mdl","models/pcv_hax.mdl","models/pasgt_no_glass_hax.mdl","models/items/car_battery01.mdl","models/props_lab/monitor01b.mdl","models/weapons/w_defuser.mdl","models/weapons/w_IRifle.mdl"}

buytable["V. Weapons"] = {}
buytable["V. Weapons"].Names = {
								"Knife",
								"Glock",
								"USP",
								"P228",
								"Deagle",
								"Dual Deagles",									
								"Five Seven",
								"Dual Elites",
								"Magnum",								
								"Shotgun",
								"Auto Shotgun",
								"Mac10",
								"Dual Mac10s",								
								"TMP",
								"MP5",
								"MP7",								
								"UMP45",
								"P90",
								"Kriss",
								"Bizon",
								"AR-57",								
								"Galil",
								"FAMAS",
								"AK47",
								"M4A1",
								"SG552",
								"AUG",
								"G36C",
								"AS VAL",
								"FN 2000T",
								"FN Scar",
								
								"SG550",
								"Sniper",
								"Auto Sniper"
								}
buytable["V. Weapons"].Cost = {
								CfgVars["knifecost"],
								CfgVars["glockcost"],
								CfgVars["uspcost"],
								CfgVars["p228cost"],
								CfgVars["deaglecost"],
								CfgVars["dualdeaglescost"],								
								CfgVars["fivesevencost"],
								CfgVars["elitescost"],
								CfgVars["magnumcost"],								
								CfgVars["shotguncost"],
								CfgVars["autoshotguncost"],
								CfgVars["mac10cost"],
								CfgVars["dualmac10scost"],								
								CfgVars["tmpcost"],
								CfgVars["mp5cost"],
								CfgVars["mp7cost"],								
								CfgVars["umpcost"],
								CfgVars["p90cost"],
								CfgVars["krisscost"],
								CfgVars["bizoncost"],
								CfgVars["ar57cost"],								
								CfgVars["galilcost"],
								CfgVars["famascost"],
								CfgVars["ak47cost"],
								CfgVars["m4a1cost"],
								CfgVars["sg552cost"],
								CfgVars["augcost"],
								CfgVars["g36ccost"],
								CfgVars["asvalcost"],
								CfgVars["f2000cost"],
								CfgVars["scarcost"],
								
								CfgVars["sg550cost"],
								CfgVars["snipercost"],
								CfgVars["autosnipercost"]
								}
buytable["V. Weapons"].Data = {
								"knife",
								"glock",
								"usp",
								"p228",
								"deagle",
								"dualdeagles",								
								"fiveseven",
								"elites",
								"magnum",								
								"shotgun",
								"autoshotgun",
								"mac10",
								"dualmac10s",								
								"tmp",
								"mp5",
								"mp7",								
								"ump45",
								"p90",
								"kriss",
								"bizon",
								"ar57",								
								"galil",
								"famas",
								"ak47",
								"m4a1",
								"sg552",
								"aug",
								"g36c",
								"asval",
								"f2000",
								"scar",
							
								"sg550",
								"sniper",
								"autosniper"
								}
buytable["V. Weapons"].Cmd = "buyshipment"
buytable["V. Weapons"].CmdTwo = "buyweapon"
buytable["V. Weapons"].Model = {
								"models/weapons/w_knife_t.mdl",
								"models/weapons/w_pist_glock18.mdl",
								"models/weapons/w_pist_usp.mdl",
								"models/weapons/w_pist_p228.mdl",
								"models/weapons/w_pist_deagle.mdl",
								"models/weapons/w_pist_deags.mdl",
								"models/weapons/w_pist_fiveseven.mdl",
								"models/weapons/w_pist_elite.mdl",
								"models/weapons/w_pist_swp627.mdl",
								"models/weapons/w_shot_m3super90.mdl",
								"models/weapons/w_shot_xm1014.mdl",
								"models/weapons/w_smg_mac10.mdl",
								"models/weapons/w_smg_mac10.mdl",								
								"models/weapons/w_smg_tmp.mdl",
								"models/weapons/w_smg_mp5.mdl",
								"models/weapons/w_smg_mp7.mdl",
								"models/weapons/w_smg_ump45.mdl",
								"models/weapons/w_smg_p90.mdl",
								"models/weapons/w_smg_kriss.mdl",
								"models/weapons/w_smg_biz.mdl",
								"models/weapons/w_smg_a57.mdl",
								"models/weapons/w_rif_galil.mdl",
								"models/weapons/w_rif_famas.mdl",
								"models/weapons/w_rif_ak47.mdl",
								"models/weapons/w_rif_m4cu.mdl",
								"models/weapons/w_rif_sg552.mdl",
								"models/weapons/w_rif_aug.mdl",
								"models/weapons/w_rif_g36c.mdl",
								"models/weapons/w_rif_asval.mdl",
								"models/weapons/w_rif_f20.mdl",
								"models/weapons/w_rif_scarh.mdl",
							
								"models/weapons/w_snip_sg550.mdl",
								"models/weapons/w_snip_awp.mdl",
								"models/weapons/w_snip_g3sg1.mdl"
								}
								
buytable["VI. Weapons - Attachments"] = {}
buytable["VI. Weapons - Attachments"].Names = {
"Laser Sight",
"Kobra",
"Reflex Sight",
"Rifle Reflex Sight",
"EoTech Sight",
"Aimpoint",
"ACOG Scope",
"Ballistic Scope",
"Bipod",
"M203",
"C-Magazine"
}
buytable["VI. Weapons - Attachments"].Cost = {
CfgVars["lasersightcost"],
CfgVars["kobracost"],
CfgVars["reflexsightcost"],
CfgVars["riflereflexcost"],
CfgVars["eotechcost"],
CfgVars["aimpointcost"],
CfgVars["acogscopecost"],
CfgVars["ballisticcost"],
CfgVars["bipodcost"],
CfgVars["m203cost"],
CfgVars["cmagazinecost"]
}
buytable["VI. Weapons - Attachments"].Data = {
"lasersight",
"kobra",
"reflexsight",
"riflereflex",
"eotech",
"aimpoint",
"acogscope",
"ballistic",
"bipod",
"m203",
"cmagazine"
}
buytable["VI. Weapons - Attachments"].Cmd = "buyattach"
buytable["VI. Weapons - Attachments"].Model = {
"models/Items/BoxSRounds.mdl",
"models/attachments/cmore.mdl",
"models/wystan/attachments/doctorrds.mdl",
"models/attachments/kascope.mdl",
"models/wystan/attachments/eotech557sight.mdl",
"models/wystan/attachments/aimpoint.mdl",
"models/wystan/attachments/acog.mdl",
"models/bunneh/scope01.mdl",
"models/wystan/attachments/bipod.mdl",
"models/wystan/attachments/m203.mdl",
"models/wystan/cmag.mdl"
}																
								
buytable["VII. Weapons - Miscellaneous"] = {}
buytable["VII. Weapons - Miscellaneous"].Names = {
										"Pipe Bomb",
										"Frag Grenade",
										"Stun Grenade",
										"Gas Grenade",
										"Sticky Grenade",
										"Door Charge",
										"C4 Explosive",
										"Jihad Bomb",
										"Big Bomb"}
buytable["VII. Weapons - Miscellaneous"].Cost = {
										CfgVars["pipebombcost"],
										CfgVars["grenadecost"],
										CfgVars["flashbangcost"],
										CfgVars["gasgrenadecost"],
										CfgVars["stickygrenadecost"],
										CfgVars["doorchargecost"],
										CfgVars["c4cost"],
										CfgVars["jihadcost"],
										CfgVars["bigbombcost"]}
buytable["VII. Weapons - Miscellaneous"].Data = {
										"pipebomb",
										"grenade",
										"stun",
										"gas",
										"sticky",
										"doorcharge",
										"c4",
										"jihad",
										"bigbomb"}
buytable["VII. Weapons - Miscellaneous"].Cmd = "buymisc"
buytable["VII. Weapons - Miscellaneous"].Model = {
										"models/props_lab/pipesystem03b.mdl",
										"models/weapons/w_eq_fraggrenade_thrown.mdl",
										"models/weapons/w_eq_flashbang_thrown.mdl",
										"models/weapons/w_eq_smokegrenade_thrown.mdl",
										"models/weapons/w_magnade.mdl",
										"models/weapons/w_slam.mdl",
										"models/weapons/w_c4_planted.mdl",
										"models/player/t_phoenix.mdl",
										"models/lmaollama/bigbomb.mdl"}

buytable["VIII. Drugs"] = {}
buytable["VIII. Drugs"].Names = {"Regeneration","Pain Killers","Antidote","Reflect","Adrenaline","Steroids","Double Jump","Leech","Amplifier","Armor Piercer","Magicbullet","Shockwave","Knockback","Doubletap","Focus"}
buytable["VIII. Drugs"].Cost = {CfgVars["regencost"],CfgVars["painkillercost"],CfgVars["antidotecost"],CfgVars["reflectcost"],CfgVars["adrenalinecost"],CfgVars["steroidcost"],CfgVars["doublejumpcost"],CfgVars["leechcost"],CfgVars["ampcost"],CfgVars["armorpiercercost"],CfgVars["magicbulletcost"],CfgVars["shockwavecost"],CfgVars["knockbackcost"],CfgVars["doubletapcost"],CfgVars["focuscost"]}
buytable["VIII. Drugs"].Data = {"regen","painkiller","antidote","reflect","adrenaline","steroid","doublejump","leech","amplifier","armorpiercer","magicbullet","shockwave","knockback","doubletap","focus"}
buytable["VIII. Drugs"].Cmd = "buydrug"
buytable["VIII. Drugs"].CmdTwo = "buybatchdrug"
buytable["VIII. Drugs"].Model = {""}


local PANEL = {}

/*---------------------------------------------------------
   Name: init
---------------------------------------------------------*/
function PANEL:Init()	
	self:SetSize( 83, 83 )
	self.Label = vgui.Create ( "DLabel", self )
	self:SetKeepAspect( true )
	self:SetDrawBorder( true )
	self.m_Image:SetPaintedManually( true )
end

local PANEL = {}

/*---------------------------------------------------------
   Name: Init
---------------------------------------------------------*/
function PANEL:Init()
	self.PanelList = vgui.Create( "DPanelList", self )	
		self.PanelList:SetPadding( 4 )
		self.PanelList:SetSpacing( 2 )
		self.PanelList:EnableVerticalScrollbar( true )	
	self:BuildList()
end

/*---------------------------------------------------------
   Name: BuildList
---------------------------------------------------------*/

	local function AddComma(n)
		local sn = tostring(n)
		sn = string.ToTable(sn)
		
		local tab = {}
		for i=0,#sn-1 do
			
			if i%3 == #sn%3 and !(i==0) then
				table.insert(tab, ",")
			end
			table.insert(tab, sn[i+1])
		
		end
		
		return string.Implode("",tab)
	end
	
function PANEL:BuildList()
	self.PanelList:Clear()
	
	local Categorised = {}
	// Build into categories
	for k, v in pairs( buytable ) do
		v.Category = k
		Categorised[ v.Category ] = Categorised[ v.Category ] or {}
		table.insert( Categorised[ v.Category ], v )
	
	end
	
	// Loop through each category
	for CategoryName, v in SortedPairs( Categorised ) do
	
		local Category = vgui.Create( "DCollapsibleCategory", self )
		self.PanelList:AddItem( Category )
		Category:SetExpanded(false)
		Category:SetLabel( CategoryName )
		Category:SetCookieName( "EntitySpawn."..CategoryName )
		
		local Content = vgui.Create( "DPanelList" )
		Category:SetContents( Content )
		Content:EnableHorizontal( true )
		Content:SetDrawBackground( false )
		Content:SetSpacing( 2 )
		Content:SetPadding( 2 )
		Content:SetAutoSize( true )
		
		number=1
		//this is annoying code, i only wrote it to expriment with and then decided to use it and didnt feel like making it pretty.
		for k,v in pairs( buytable[ CategoryName ].Data ) do
				if(CategoryName != "VIII. Drugs") then
					local cmd = buytable[ CategoryName ].Cmd
					local cmdtwo = buytable[ CategoryName ].CmdTwo
					local data = buytable[ CategoryName ].Data[ number ]
					local name = buytable[ CategoryName ].Names[ number ]
					local Icon = vgui.Create( "SpawnIcon", self)
					
					if(buytable[ CategoryName ].Model[ number ] !=nil) then
						Icon:SetModel( buytable[ CategoryName ].Model[ number ] )
					else
						Icon:SetModel( "models/error.mdl" )
					end
					
						if(CategoryName == "V. Weapons") then-- or (CategoryName == "Weapons - HandGuns") then
					Icon:SetToolTip( " Item: " .. buytable[ CategoryName ].Names[ number ] .. "\n  Single Weapon Cost: $" .. AddComma(buytable[ CategoryName ].Cost[ number ] * 2) .. "\n Weapon Shipment Cost: $" .. AddComma(buytable[ CategoryName ].Cost[ number ] * 12.5) )
						else
					Icon:SetToolTip( " Item: " .. buytable[ CategoryName ].Names[ number ] .. "\n Cost: $" .. AddComma(buytable[ CategoryName ].Cost[ number ]) )
						end
						
					Icon.DoClick = function() 
						if(CategoryName == "V. Weapons") then-- or (CategoryName == "Weapons - HandGuns") then
								local menu1 = DermaMenu()
								menu1:AddOption("Buy Single Weapon", function() RunConsoleCommand( cmdtwo, data ) surface.PlaySound( "chaching.mp3" ) end)
								menu1:AddOption("Buy Shipment", function() RunConsoleCommand( cmd, data ) surface.PlaySound( "chaching.mp3" ) end)
								menu1:Open()

						else
							surface.PlaySound( "chaching.mp3" )
							RunConsoleCommand( cmd, data )
						end
					end
					
					local lable  = vgui.Create("DLabel", Icon)
					lable:SetFont( "Default" )
					lable:SetTextColor( color_white )
					lable:SetText(name)
					lable:SetContentAlignment( 5 )
					lable:SetWide( self:GetWide() )
					lable:AlignBottom( -42 )
			
					Content:AddItem( Icon )
					
				else
				
					local cmd = buytable[ CategoryName ].Cmd
					local cmdtwo = buytable[ CategoryName ].CmdTwo
					local data = buytable[ CategoryName ].Data[ number ]
					local name = buytable[ CategoryName ].Names[ number ]
					local Icon = vgui.Create( "SpawnIcon", self)
					Icon:SetModel( "models/combine_apc_destroyed_gib06.mdl" )
					Icon:SetToolTip( " Item: " .. buytable[ CategoryName ].Names[ number ] .. "\n Normal Cost: $" .. AddComma(buytable[ CategoryName ].Cost[ number ]) .. "\n Batch Cost: $" .. AddComma(buytable[ CategoryName ].Cost[ number ]*4) )
					

					
					Icon.DoClick = function() 
								local menu1 = DermaMenu()
								menu1:AddOption("Buy Single Drug", function() RunConsoleCommand( cmd, data ) surface.PlaySound( "chaching.mp3" ) end)
								menu1:AddOption("Buy Batch of Drugs", function() RunConsoleCommand( cmdtwo, data ) surface.PlaySound( "chaching.mp3" ) end)
								menu1:Open()
					end
					
					local drugs = vgui.Create("DLabel", Icon)
					drugs:SetText(drugtable[ data ].symbol)
					drugs:SetFont(drugtable[ data ].font)
					drugs:SetColor(drugtable[ data ].color)
					
					if(drugtable[ data ].font == "DrugFont2") then 
						drugs:SetPos(23, 3)
					else
						drugs:SetPos(23, 25)
					end
					drugs:SizeToContents()
					
					local lable  = vgui.Create("DLabel", Icon)
					lable:SetFont( "DefaultSmall" )
					lable:SetTextColor( drugtable[ data ].color )
					lable:SetText(name)
					lable:SetContentAlignment( 5 )
					lable:SetWide( self:GetWide() )
					lable:AlignBottom( -42 )
	
					Content:AddItem( Icon )
				end
				number = number+1
		end
	end
	self.PanelList:InvalidateLayout()
end

/*---------------------------------------------------------
   Name: PerformLayout
---------------------------------------------------------*/
function PANEL:PerformLayout()
	self.PanelList:StretchToParent( 0, 0, 0, 0 )
end

local CreationSheet = vgui.RegisterTable( PANEL, "Panel" )

local function CreateContentPanel()
	local ctrl = vgui.CreateFromTable( CreationSheet )
	return ctrl
end

/*---------------------------------------------------------
   Name: BunkMenu = this clears the menuns we dont need, but are part of sandbox.
---------------------------------------------------------*/
local function BunkMenu()
	return
end


---	spawnmenu.AddCreationTab( "Base War Buy Menu", CreateContentPanel, "icon16/brick_add.png", 50 )


spawnmenu.AddCreationTab( "Basewars Store", CreateContentPanel, "icon16/coins.png", 1 )