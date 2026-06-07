CreateThread(function()
    while true do
        local sleep = 1000
        local coords = GetEntityCoords(PlayerPedId())
        for _, venue in pairs(Config.Venues) do
            local dist = #(coords - venue.coords)
            if dist < 25.0 then
                sleep = 0
                DrawMarker(2, venue.coords.x, venue.coords.y, venue.coords.z + 0.2, 0,0,0,0,0,0,0.25,0.25,0.25, 245,210,122,150, false,true,2,false,nil,nil,false)
            end
        end
        Wait(sleep)
    end
end)
