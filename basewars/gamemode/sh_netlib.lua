
if SERVER then
	util.AddNetworkString("setNetBool")
	util.AddNetworkString("setNetString")
	util.AddNetworkString("setNetNumber")
end
function SetNetBool(entIndex,name,value)
	//Set the values caller-side first, then send those to the client..
	ServerLog("sh_netlib.lua: Attempting to SetNetBool("..tostring(entIndex)..","..tostring(name)..","..tostring(value)..")")
	if(isentity(entIndex)) then
		entIndex = entIndex:EntIndex()
	else
		if(tonumber(entIndex) == nil) then return end
	end
	local ent = ents.GetByIndex(entIndex)
	if(ent != NULL and ent != nil) then
		ent[name] = value
	end
	net.Start("setNetBool")
	net.WriteInt(entIndex)// code by lrg
	net.WriteString(name)
	net.WriteBool(value)
	if SERVER then
		net.Broadcast()
	else
		net.SendToServer()
	end
end
function SetNetString(entIndex,name,value)
	ServerLog("sh_netlib.lua: Attempting to SetNetString("..tostring(entIndex)..","..tostring(name)..","..tostring(value)..")")
	if(isentity(entIndex)) then
		entIndex = entIndex:EntIndex()
	else
		if(tonumber(entIndex) == nil) then return end
	end
	local ent = ents.GetByIndex(entIndex)
	if (ent != NULL and ent != nil) then
		ent[name] = value
	end
	net.Start("setNetString")
	net.WriteInt(entIndex)
	net.WriteString(name)
	net.WriteString(value)
	if SERVER then
		net.Broadcast()
	else
		net.SendToServer()
	end
end
function SetNetNumber(entIndex,name,value)
	ServerLog("sh_netlib.lua: Attempting to SetNetNumber("..tostring(entIndex)..","..tostring(name)..","..tostring(value)..")")
	if(isentity(entIndex)) then
		entIndex = entIndex:EntIndex()
	else
		if(tonumber(entIndex) == nil) then return end
	end
	local ent = ents.GetByIndex(entIndex)
	if (ent != NULL and ent != nil) then
		ent[name] = value
	end
	net.Start("setNetNumber")
	net.WriteInt(entIndex)
	net.WriteString(name)
	net.WriteFloat(value)
	if SERVER then
		net.Broadcast()
	else
		net.SendToServer()
	end
end// code by lrg
function GetNetVar(entIndex,name)
	ServerLog("sh_netlib.lua: Attempting to Fetch Network Variable. GetNetVar("..tostring(entIndex)..","..tostring(name)..")")
	if(isentity(entIndex)) then
		entIndex = entIndex:EntIndex()
	else
		if(tonumber(entIndex) == nil) then return end
	end
	local ent = ents.GetByIndex(entIndex)
	if (ent != NULL and ent != nil) then
		return ent[name]
	end
	return nil
end
//The server is the dominant sender, as all it's data is reliable. Therefore, only clients have the receiving functions, and only the server has the sending functions.
if CLIENT then
	function MsgNetLength(length)
		ClientMsg(nil,"Received Network Data, length is " .. length .. " bytes.\n")
	end
	function ReceiveNetBool(length)
		MsgNetLength(length)
		local entIndex = net.ReadInt()
		local name = net.ReadString()
		local value = net.ReadBool()
		local ent = ents.GetByIndex(entIndex)
		if(ent != NULL and ent != nil) then
			ClientMsg(nil,"Setting ent["..entIndex.."]["..name.."] to " .. value .. "\n")
			ent[name] = value
		end
	end
	function ReceiveNetString(length)
		MsgNetLength(length)
		local entIndex = net.ReadInt()
		local name = net.ReadString()
		local value = net.ReadString()
		local ent = ents.GetByIndex(entIndex)
		if(ent != NULL and ent != nil) then
			ClientMsg(nil,"Setting ent["..entIndex.."]["..name.."] to " .. value .. "\n")
			ent[name] = value
		end// code by lrg
	end
	function ReceiveNetNumber(length)
		MsgNetLength(length)
		local entIndex = net.ReadInt()
		local name = net.ReadString()
		local value = net.ReadFloat()
		local ent = ents.GetByIndex(entIndex)
		if(ent != NULL and ent != nil) then
			ClientMsg(nil,"Setting ent["..entIndex.."]["..name.."] to " .. value .. "\n")
			ent[name] = value
		// code by lrg
	end
	net.Receive("sendNetBool",ReceiveNetBool)
	net.Receive("sendNetString",ReceiveNetString)
	net.Receive("sendNetNumber",ReceiveNetNumber)
end
end