local MarriageTags = {}

CreateThread(function()
    while true do
        Wait(2500)
        if Config.MarriedNameTag.Enabled then
            local nearby = {}
            for _, player in pairs(GetActivePlayers()) do nearby[#nearby + 1] = GetPlayerServerId(player) end
            TriggerServerEvent('lol-weddings:server:requestMarriageTags', nearby)
        end
    end
end)

RegisterNetEvent('lol-weddings:client:receiveMarriageTags', function(tags)
    MarriageTags = tags or {}
end)

CreateThread(function()
    while true do
        Wait(0)
        if Config.MarriedNameTag.Enabled then
            local myCoords = GetEntityCoords(PlayerPedId())
            for _, player in pairs(GetActivePlayers()) do
                local ped = GetPlayerPed(player)
                local serverId = GetPlayerServerId(player)
                local tag = MarriageTags[tostring(serverId)]
                if tag and DoesEntityExist(ped) then
                    local coords = GetEntityCoords(ped)
                    if #(myCoords - coords) <= Config.MarriedNameTag.DrawDistance then
                        DrawWeddingTag(coords.x, coords.y, coords.z + Config.MarriedNameTag.ZOffset, tag)
                    end
                end
            end
        end
    end
end)

function DrawWeddingTag(x, y, z, text)
    local onScreen, screenX, screenY = World3dToScreen2d(x, y, z)
    if not onScreen then return end
    local c = Config.MarriedNameTag.Color
    SetTextScale(Config.MarriedNameTag.TextScale, Config.MarriedNameTag.TextScale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(c.r, c.g, c.b, c.a)
    SetTextOutline()
    SetTextCentre(true)
    SetTextEntry('STRING')
    AddTextComponentString(text)
    DrawText(screenX, screenY)
end
