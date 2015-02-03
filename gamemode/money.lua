

local Format	=	Format
local SQLStr	=	SQLStr

local meta = FindMetaTable( "Player" )



function UpdateMoney( self, value )
	
	umsg.Start( "MoneyChange", self )
		
		umsg.String( "0" )
		umsg.String( tostring(value) )
		
	umsg.End( )
end

function SetMoney( self )
	local id
	
	id = self:SteamID()
	
	if ( tonumber( self.Money ) ~= nil ) then
		local str = Format( "UPDATE bw_money SET Money = %s WHERE SteamID = '%s'", self.Money, id) 
		
		GAMEMODE.MYSQL:Query(str)
	end
end

function GetMoney( pl )
	local id, money

	id = pl:SteamID()

local str = Format("SELECT Money FROM bw_money WHERE SteamID = '%s'",id)

	money = GAMEMODE.MYSQL:Query(str,true)

	if !money[1] then
		local str = Format("INSERT INTO bw_money (SteamID,Money) VALUES ('%s',10000)",id)
		GAMEMODE.MYSQL:Query(str)
		pl.Money = 10000
	else
		pl.Money = money[1].Money
	end
	
	UpdateMoney( pl, pl.Money )
	return pl.Money
end

setMoney = SetMoney
getMoney = GetMoney
