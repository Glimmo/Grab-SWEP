
if SERVER then
    -- ADD NEW BLACKLIST ITEM
    concommand.Add( "grab_addblacklist", function( ply, cmd, args, str )
        if ply:IsPlayer() then return end

        local newThing = string.gsub(string.lower(tostring(str)), "%s", "")
        if file.Exists("grabber_blacklist.json","DATA") then
            local blacklistFile = file.Read("grabber_blacklist.json","DATA")
            local listJtoT = util.JSONToTable(blacklistFile)
            local tabUpdate = {[newThing] = true}
            table.Merge(listJtoT,tabUpdate)
            print(table.ToString(listJtoT,"Grabber Blacklisted Entities",true))
            local listTtoJ = util.TableToJSON(listJtoT)
            file.Write("grabber_blacklist.json",listTtoJ)
        else
            local freshList = {[newThing] = true}
            local freshJSON = util.TableToJSON(freshList)
            print(table.ToString(freshList,"Grabber Blacklisted Entities",true))
            file.Write("grabber_blacklist.json",freshJSON)
        end
    end )

    -- REMOVE BLACKLIST ITEM
    concommand.Add( "grab_removeblacklist", function( ply, cmd, args, str )
        if ply:IsPlayer() then return end

        local newThing = string.gsub(string.lower(tostring(str)), "%s", "")
        if file.Exists("grabber_blacklist.json","DATA") then
            local blacklistFile = file.Read("grabber_blacklist.json","DATA")
            local listJtoT = util.JSONToTable(blacklistFile)
            if listJtoT[newThing] then
                listJtoT[newThing] = nil
            end
            print(table.ToString(listJtoT,"Grabber Blacklisted Entities",true))
            local listTtoJ = util.TableToJSON(listJtoT)
            file.Write("grabber_blacklist.json",listTtoJ)
        else
            local freshList = {newThing}
            local freshJSON = util.TableToJSON(freshList)
            print(table.ToString(freshList,"Grabber Blacklisted Entities",true))
            file.Write("grabber_blacklist.json",freshJSON)
        end
    end )
end