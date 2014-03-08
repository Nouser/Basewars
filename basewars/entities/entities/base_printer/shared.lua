 	
ENT.Type 		= "anim"
ENT.Base 		= "base_structure"

ENT.PrintName	= "Base Printer"
ENT.Author		= "KuroLight"
ENT.Contact		= ""

ENT.Spawnable		= false
ENT.AdminSpawnable	= false

// used by gamemode for power plant
ENT.Power			= 1 --The amount of power it takes to power this printer up.
ENT.HoverName = "Base Money Printer" --The name on the RoundedBox that you see. More commonly known as "HoverText"
ENT.BackColor = Color(140,120,83,155) --The background color of the box..
ENT.TextColor = Color(255,255,255,255) --The text color of the box.. it's recommended that the background and text color are opposites so you can see the text properly..
ENT.UpOffset = 5 --The amount of offset to apply.. you can find this in cl_init.lua, if their cl_init.lua is commented out for the draw function, set ENT.ShouldDraw to false.
--The offset you find is the number after Ang:Up() * _number
ENT.CamScale = 0.1 -- The scale of the text.. you can find this as the last parameter of Cam.Start3D2D()
ENT.ShouldDraw = true -- Should we draw HoverText?
