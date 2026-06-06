RegisterNetEvent('lol-weddings:server:getPlannerData', function()
    local src = source
    local Player = GetPlayerBySource(src)
    if not Player then return end
    local cid = Player.PlayerData.citizenid
    local marriage = MySQL.single.await([[SELECT * FROM marriages WHERE citizenid1 = ? OR citizenid2 = ? ORDER BY id DESC LIMIT 1]], { cid, cid })
    local plan = MySQL.single.await([[SELECT * FROM wedding_plans WHERE owner = ? ORDER BY id DESC LIMIT 1]], { cid })
    local account = MySQL.single.await([[SELECT * FROM shared_accounts WHERE citizenid1 = ? OR citizenid2 = ? LIMIT 1]], { cid, cid })
    TriggerClientEvent('lol-weddings:client:openPlanner', src, { player = Player.PlayerData.charinfo, venues = Config.Venues, marriage = marriage, plan = plan, account = account })
end)

RegisterNetEvent('lol-weddings:server:createWeddingPlan', function(data)
    local src = source
    local Player = GetPlayerBySource(src)
    if not Player then return end
    data = data or {}
    MySQL.insert.await([[INSERT INTO wedding_plans (owner, venue, budget, guests, wedding_date, theme, created_at) VALUES (?, ?, ?, ?, ?, ?, NOW())]], {
        Player.PlayerData.citizenid, data.venue or 'undecided', tonumber(data.budget) or 0, json.encode(data.guests or {}), data.weddingDate or 'TBD', data.theme or 'Luxury Gold'
    })
    TriggerClientEvent('QBCore:Notify', src, 'Wedding plan saved.', 'success')
end)

RegisterNetEvent('lol-weddings:server:bookVenue', function(venueId)
    local src = source
    local Player = GetPlayerBySource(src)
    if not Player then return end
    local selected = nil
    for _, venue in pairs(Config.Venues) do if venue.id == venueId then selected = venue end end
    if not selected then TriggerClientEvent('QBCore:Notify', src, 'Invalid venue.', 'error') return end
    if GetMoney(src, 'bank') < selected.price then TriggerClientEvent('QBCore:Notify', src, 'Not enough money to book this venue.', 'error') return end
    RemoveMoney(src, 'bank', selected.price, 'wedding-venue-booking')
    MySQL.insert.await([[INSERT INTO wedding_bookings (owner, venue_id, venue_name, price, status, created_at) VALUES (?, ?, ?, ?, 'booked', NOW())]], { Player.PlayerData.citizenid, selected.id, selected.name, selected.price })
    if selected.id == 'aura_wedding' then TriggerEvent('lol-weddings:server:auraVenueBooked') end
    TriggerClientEvent('QBCore:Notify', src, 'Venue booked: ' .. selected.name, 'success')
end)

RegisterNetEvent('lol-weddings:server:inviteGuest', function(targetId)
    local src = source
    local Player = GetPlayerBySource(src)
    local Target = GetPlayerBySource(targetId)
    if not Player or not Target then TriggerClientEvent('QBCore:Notify', src, 'Guest not found.', 'error') return end
    MySQL.insert.await([[INSERT INTO wedding_guests (owner, guest_citizenid, guest_name, rsvp, created_at) VALUES (?, ?, ?, 'pending', NOW())]], {
        Player.PlayerData.citizenid, Target.PlayerData.citizenid, Target.PlayerData.charinfo.firstname .. ' ' .. Target.PlayerData.charinfo.lastname
    })
    AddItem(targetId, 'wedding_invitation', 1)
    TriggerClientEvent('QBCore:Notify', src, 'Invitation sent.', 'success')
    TriggerClientEvent('QBCore:Notify', targetId, 'You received a wedding invitation.', 'primary')
end)
