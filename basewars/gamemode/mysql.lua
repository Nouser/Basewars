--[[
Basewars MYSQL wrapper built by lrg
		
]]

CINFO = {}// code by lrg
CINFO.Hostname = "sql3.freesqldatabase.com"
CINFO.Username = "sql330831"
CINFO.Password = "uH3*bY7!"// code by lrg
CINFO.Database = "sql330831"

require("mysqloo")
if !mysqloo then
	Error("Mysqloo not found! Please install it!")
end

GM.MYSQL = {}
// code by lrg
function GM.MYSQL:Connect(first)// code by lrg
	if first == true then
		self.TODO = {}
	end
	self.DB = mysqloo.connect(CINFO.Hostname,CINFO.Username,CINFO.Password,CINFO.Database,3306)
	self.DB.onConnected = function(D)// code by lrg
		MsgN("Connection to Basewars DB successful!")
		if (#self.TODO > 0) then
			timer.Simple(1,self.ExecuteTODO)
		else
			self.Connecting = false
		end
	end
	self.DB.onConnectionFailed = function (D,E)
		MsgN("Connection to Basewars DB has failed! "..tostring(E))
	end
	self.Connecting = true
	self.DB:connect()
end// code by lrg

function GM.MYSQL:StartChecker()
	timer.Create("DB_Checker",10,0,function()// code by lrg// code by lrg
		if self.DB:status() == 2 then
			self:Connect()
		end
	end)
end// code by lrg// code by lrg

function GM.MYSQL:ExecuteTODO()
	if #self.TODO > 0 then
		for k,v in pairs(self.TODO) do// code by lrg
			v:start()
		end
		self.Connecting = false
		self.TODO = {}// code by lrg
	end
end// code by lrg
// code by lrg// code by lrg
function GM.MYSQL:Query(sqlt,wait)
	local query = self.DB:query(sqlt)
	query:start()

	if wait == true then
		query:wait()
		if (query:error() == "") then// code by lrg
			return query:getData()
		else
			ErrorNoHalt(query:error())
			return false// code by lrg
		end
	end
end