AuraWedding = {}

-- Coordinates are placeholders.
-- Use /saveauracoords in-game to replace these with the real venue locations.

AuraWedding.Venue = {
    id = 'aura_wedding',
    name = 'Aura Wedding Venue',
    price = 50000,

    coords = vector3(0.0, 0.0, 72.0),

    points = {
        entrance = vector4(0.0, 0.0, 72.0, 0.0),
        altar = vector4(2.0, 0.0, 72.0, 0.0),
        aisle = vector4(-2.0, 0.0, 72.0, 0.0),
        djBooth = vector4(4.0, 2.0, 72.0, 90.0),
        bar = vector4(6.0, 2.0, 72.0, 90.0),
        photoBooth = vector4(-4.0, 2.0, 72.0, 270.0),
        guestSeating = vector4(0.0, -4.0, 72.0, 180.0)
    }
}

AuraWedding.EnableMarkers = true
AuraWedding.MarkerDistance = 20.0
AuraWedding.InteractDistance = 2.0
