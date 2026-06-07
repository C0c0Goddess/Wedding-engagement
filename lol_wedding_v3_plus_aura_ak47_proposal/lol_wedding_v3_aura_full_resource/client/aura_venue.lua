local QBCore = exports['qb-core']:GetCoreObject()

local function DrawText3D(x, y, z, text)
    local onScreen, screenX, screenY = World3dToScreen2d(x, y, z)
    if not onScreen then return end
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 215, 125, 255)
    SetTextOutline()
    SetTextCentre(true)
    SetTextEntry('STRING')
    AddTextComponentString(text)
    DrawText(screenX, screenY)
end

RegisterCommand('aurawedding', function()
    local ped = PlayerPedId()
    local p = AuraWedding.Venue.points.entrance
    SetEntityCoords(ped, p.x, p.y, p.z, false, false, false, true)
    SetEntityHeading(ped, p.w)
    QBCore.Functions.Notify('Teleported to Aura Wedding Venue placeholder coords.', 'primary')
end, false)

RegisterCommand('auraaltar', function()
    local ped = PlayerPedId()
    local p = AuraWedding.Venue.points.altar
    SetEntityCoords(ped, p.x, p.y, p.z, false, false, false, true)
    SetEntityHeading(ped, p.w)
end, false)

RegisterCommand('saveauracoords', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    print(('Aura Coord: vector4(%.2f, %.2f, %.2f, %.2f)'):format(coords.x, coords.y, coords.z, heading))
    QBCore.Functions.Notify('Coords printed in F8 console.', 'success')
end, false)

RegisterCommand('aurapoints', function()
    local coords = GetEntityCoords(PlayerPedId())
    print(('Current coords: vector3(%.2f, %.2f, %.2f)'):format(coords.x, coords.y, coords.z))
    for pointName, point in pairs(AuraWedding.Venue.points) do print(pointName, point) end
    QBCore.Functions.Notify('Aura points printed in F8 console.', 'primary')
end, false)

CreateThread(function()
    while true do
        local sleep = 1000
        if AuraWedding.EnableMarkers then
            local coords = GetEntityCoords(PlayerPedId())
            for pointName, point in pairs(AuraWedding.Venue.points) do
                local pCoords = vector3(point.x, point.y, point.z)
                local dist = #(coords - pCoords)
                if dist <= AuraWedding.MarkerDistance then
                    sleep = 0
                    DrawMarker(2, point.x, point.y, point.z + 0.25, 0.0,0.0,0.0,0.0,0.0,0.0,0.25,0.25,0.25,245,210,122,160,false,true,2,false,nil,nil,false)
                    if dist <= AuraWedding.InteractDistance then
                        DrawText3D(point.x, point.y, point.z + 0.45, 'Aura: ' .. pointName)
                        if IsControlJustReleased(0, 38) then TriggerEvent('lol-weddings:client:auraPointInteract', pointName) end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

RegisterNetEvent('lol-weddings:client:auraPointInteract', function(pointName)
    if pointName == 'altar' then
        QBCore.Functions.Notify('Use /startceremony [player id] to begin the ceremony.', 'primary')
    elseif pointName == 'djBooth' then
        QBCore.Functions.Notify('DJ booth placeholder. Connect your music script here.', 'primary')
    elseif pointName == 'bar' then
        QBCore.Functions.Notify('Bar placeholder. Connect your bar script here.', 'primary')
    elseif pointName == 'photoBooth' then
        QBCore.Functions.Notify('Photo booth placeholder. Connect screenshot-basic here.', 'primary')
    else
        QBCore.Functions.Notify('Aura Wedding point: ' .. pointName, 'primary')
    end
end)
