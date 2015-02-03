--Created by the Maw
--Conditions to use. Give credit to Maw ALWAYS!
--Please no not remove the chat notification!!!!!!

local meta = FindMetaTable("Player")

if (SERVER) then
        util.AddNetworkString("STREAM")
        util.AddNetworkString("ENDSTREAM")
		
        concommand.Add("StreamURL",function(pl,com,args)
                if (!IsValid(pl)) then return end
                pl:StreamSong(table.concat(args," "))
        end)
		
        concommand.Add("EndStream",function(pl,com,args)
                if (!IsValid(pl)) then return end
                pl:EndStream()
        end)  

        function meta:StreamSong(URL)

				if self:IsUserGroup("donor03") then
				self.URL = URL
                net.Start("STREAM")
                        net.WriteEntity(self)
                        net.WriteString(URL)
                net.Broadcast()
				elseif self:IsUserGroup("junior admin") then
				self.URL = URL
                net.Start("STREAM")
                        net.WriteEntity(self)
                        net.WriteString(URL)
                net.Broadcast()
				elseif self:IsUserGroup("admin") then
				self.URL = URL
                net.Start("STREAM")
                        net.WriteEntity(self)
                        net.WriteString(URL)
                net.Broadcast()
				elseif self:IsUserGroup("developer") then
				self.URL = URL
                net.Start("STREAM")
                        net.WriteEntity(self)
                        net.WriteString(URL)
                net.Broadcast()
				elseif self:IsUserGroup("community manager") then
				self.URL = URL
                net.Start("STREAM")
                        net.WriteEntity(self)
                        net.WriteString(URL)
                net.Broadcast()
				elseif self:IsUserGroup("founder") then
				self.URL = URL
                net.Start("STREAM")
                        net.WriteEntity(self)
                        net.WriteString(URL)
                net.Broadcast()
				end
		end
        
        function meta:EndStream()
                self.URL = nil  
                net.Start("ENDSTREAM")
                        net.WriteEntity(self)
                net.Broadcast()
        end

        function meta:UpdateStream(v)
                if (v.URL) then
					net.Start("STREAM")
                                net.WriteEntity(v)
                                net.WriteString(v.URL)
                        net.Send(self)
                end
        end
else
        local Emitter   = ParticleEmitter( Vector(0,0,0) )
        local Up        = Vector(0,0,20)
        local Retries   = 0
        local Streams   = {}

        function TryURL(url,pl)
                if (!IsValid(pl)) then return end
                local ID = pl:EntIndex()
                if (Streams[ID]) then Streams[ID]:Stop() Streams[ID] = nil end
                if (Retries < 4) then
                        sound.PlayURL( url, "3d mono noplay", function( chan )
                                if (!chan) then TryURL(url,pl) Retries = Retries+1
                                elseif (IsValid(pl)) then Streams[ID] = chan chan:Play() Retries = 0 end
                        end)
                else
                        Retries = 0
                        Msg("Couldn't play "..url.." \n")
                end
        end

        net.Receive("STREAM",function()
                local pl = net.ReadEntity()
                local URL = net.ReadString()
                if (!IsValid(pl)) then return end
					// LocalPlayer():ChatPrint(pl:Nick().." is streaming!")
					// LocalPlayer():ChatPrint("You are now streaming")
                TryURL(URL,pl)
        end)

        net.Receive("ENDSTREAM",function()
                local pl = net.ReadEntity()
                if (!IsValid(pl)) then return end
					// LocalPlayer():ChatPrint(pl:Nick().." stopped streaming!")
                local ID = pl:EntIndex()
                if (Streams[ID]) then Streams[ID]:Stop() Streams[ID] = nil end
        end)

		hook.Add("Think","Streamer",function()
			for k,st in pairs(Streams) do
				if (!st) then table.remove(Streams,k)
			else
				local v = player.GetByID(k)
				if (!IsValid(v)) then 
					st:Stop() 
					table.remove(Streams,k)
				else
					local Pos = v:GetPos()
					if (!v.PTime or v.PTime < CurTime()) then
					local pstr = "particles/flamelet1"
						local particle = Emitter:Add( pstr, Pos + VectorRand()*15)
						particle:SetDieTime( 2 )
						particle:SetVelocity( Up )
						particle:SetStartAlpha( 250 )
						particle:SetEndAlpha( 0 )
						particle:SetStartSize( 25 )
						particle:SetEndSize( 50 )
						particle:SetColor( math.random( 0, 250 ), math.random( 0, 250 ), math.random( 0, 250 ) )	
						v.PTime = CurTime()+0.04
					end
					st:SetPos(Pos)
				end
			end
		end
	end)
end