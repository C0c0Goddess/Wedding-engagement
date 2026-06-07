Config = Config or {}

Config.Framework = 'qb'
Config.Inventory = 'ak47' -- ox, qb, or ak47Config.Debug = false

Config.Commands = {
    WeddingPlanner = 'weddingplanner',
    Propose = 'propose',
    Marry = 'marry',
    Divorce = 'divorce',
    MarriageStatus = 'marriagestatus',
    CreateLicense = 'marriagelicense',
    NameChange = 'changemarriedname',
    WeddingAdmin = 'weddingadmin',
    StartCeremony = 'startceremony',
    SharedAccount = 'coupleaccount'
}

Config.Admin = { Permission = 'admin' }

Config.RingShop = {
    coords = vector3(-628.88, -236.77, 38.06),
    markerDistance = 12.0,
    interactDistance = 2.0,
    items = {
        { item = 'diamond_ring_silver', label = 'Silver Diamond Engagement Ring', price = 7500 },
        { item = 'diamond_ring_gold', label = 'Gold Diamond Engagement Ring', price = 12500 },
        { item = 'diamond_ring_rose', label = 'Rose Gold Diamond Engagement Ring', price = 15000 },
        { item = 'wedding_band_diamond', label = 'Diamond Wedding Band', price = 10000 },
        { item = 'marriage_license', label = 'Blank Marriage License', price = 2500 }
    }
}

Config.Proposal = {
    AcceptDistance = 5.0,
    RequiredRing = 'diamond_ring_gold',
    RemoveRingOnProposal = false,
    EngagementStatus = 'engaged'
}

Config.MarriedNameTag = {
    Enabled = true,
    DrawDistance = 12.0,
    TextScale = 0.35,
    ZOffset = 1.15,
    Color = { r = 255, g = 215, b = 125, a = 255 }
}

Config.Prices = {
    MarriageLicense = 2500,
    NameChange = 1000,
    Divorce = 5000,
    SharedAccountOpen = 2500
}

Config.Venues = {
    { id = 'courthouse', name = 'Courthouse Ceremony', price = 5000, coords = vector3(-545.2, -204.1, 38.2) },
    { id = 'beach', name = 'Beach Ceremony', price = 15000, coords = vector3(-1602.2, -1069.7, 13.0) },
    { id = 'vinewood', name = 'Vinewood Hills', price = 25000, coords = vector3(-755.5, 816.6, 213.0) },
    { id = 'rooftop', name = 'Luxury Rooftop', price = 40000, coords = vector3(-75.1, -818.9, 326.2) },

    -- Aura Wedding Venue from the uploaded original Aura wedding resource.
    -- Update coords after using /saveauracoords in the Aura resource.
    { id = 'aura_wedding', name = 'Aura Wedding Venue', price = 50000, coords = vector3(0.0, 0.0, 72.0) }
}

Config.Ceremony = {
    RequireMarriedLicense = false,
    Duration = 12000
}

Config.Discord = {
    Enabled = false,
    Webhook = 'YOUR_WEBHOOK_HERE'
}


-- AK47 Inventory Compatibility
-- These function names match the most common AK47 inventory export style.
-- If your AK47 inventory resource uses different exports, edit server/utils.lua.
Config.AK47Inventory = {
    Resource = 'ak47_inventory'
}

-- Proposal Emote Settings
Config.ProposalEmote = {
    Enabled = true,
    Duration = 6500,
    ProposerAnimDict = 'amb@medic@standing@kneel@base',
    ProposerAnim = 'base',
    PartnerAnimDict = 'anim@heists@ornate_bank@hostages@hit',
    PartnerAnim = 'hit_react_die_loop_ped_a',
    FacePartner = true,
    FreezeDuringProposal = true
}
