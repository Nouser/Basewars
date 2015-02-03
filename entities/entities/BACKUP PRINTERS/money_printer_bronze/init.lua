AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.OwnerID = nil
ENT.PayoutString = "bronzeprintercost"
ENT.ModelPath = "models/props_lab/reciever01b.mdl"
ENT.Health = 150
ENT.PrintTime = 30
ENT.InactiveTime = 900
ENT.NotifyTime = 750
ENT.InactiveResupplyTime = 750
ENT.NotifyResupplyTime = 600
ENT.FancyName = "Bronze Money Printer"
ENT.PrintAmounts = {
	{50,80},
	{80,110},
	{190,210},
	{300,330},
	{420,450},
}
function ENT:Initialize()
	self:ParentInitialize(self.Entity)
	function ENT:addPrinterCount()
		self.Owner:GetTable().maxBronzePrinter = self.Owner:GetTable().maxBronzePrinter + 1
	end
	function ENT:decreasePrinterCount()
		self.Owner:GetTable().maxBronzePrinter = eslf.Owner:GetTable().maxBronzePrinter - 1
	end
	function ENT:tableNotNil()
		if(self.Owner:GetTable().maxBronzePrinter == nil) then
			return false
		end
		return true
	end
end