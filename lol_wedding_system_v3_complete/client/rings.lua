local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local dist = #(coords - Config.RingShop.coords)

        if dist < Config.RingShop.markerDistance then
            sleep = 0

            DrawMarker(2, Config.RingShop.coords.x, Config.RingShop.coords.y, Config.RingShop.coords.z,
                0.0, 0.0, 0.0,
                0.0, 0.0, 0.0,
                0.25, 0.25, 0.25,
                245, 210, 122, 180,
                false, true, 2, nil, nil, false)

            if dist < Config.RingShop.interactDistance then
                DrawText3D(Config.RingShop.coords.x, Config.RingShop.coords.y, Config.RingShop.coords.z + 0.25, '[E] Luxury Ring Shop')

                if IsControlJustReleased(0, 38) then
                    OpenRingShop()
                end
            end
        end

        Wait(sleep)
    end
end)

function OpenRingShop()
    local menu = {
        { header = 'Luxury Ring Shop', isMenuHeader = true }
    }

    for _, ring in pairs(Config.RingShop.items) do
        menu[#menu + 1] = {
            header = ring.label,
            txt = '$' .. ring.price,
            params = {
                event = 'lol-weddings:client:buyRing',
                args = ring
            }
        }
    end

    exports['qb-menu']:openMenu(menu)
end

RegisterNetEvent('lol-weddings:client:buyRing', function(data)
    TriggerServerEvent('lol-weddings:server:buyRing', data.item)
end)

function DrawText3D(x, y, z, text)
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
