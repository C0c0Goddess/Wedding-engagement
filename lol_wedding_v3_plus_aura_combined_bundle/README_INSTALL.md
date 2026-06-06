# LOL Wedding V3 + Aura Venue Combined Bundle

This ZIP contains two resources:

1. lol_wedding_system_v3_complete
   - The full wedding gameplay script.

2. lol_wedding_v3_aura_full_resource
   - The Aura wedding venue/map stream resource.
   - Aura venue assets are credited to the original Aura Wedding resource creator.

## Install

Put both folders into:

resources/[custom]/

Then add to server.cfg:

ensure oxmysql
ensure ox_lib
ensure qb-core
ensure ox_inventory
ensure qb-menu
ensure lol_wedding_v3_aura_full_resource
ensure lol_wedding_system_v3_complete

## SQL

Import:

lol_wedding_system_v3_complete/sql/install.sql

## Items

If using ox_inventory:
Copy entries from:
lol_wedding_system_v3_complete/shared/ox_inventory_items.lua

If using qb-inventory:
Copy entries from:
lol_wedding_system_v3_complete/shared/items.lua

## Aura Venue

The Aura venue is already added to Config.Venues in the wedding system.

Coordinates are placeholders:
vector3(0.0, 0.0, 72.0)

Use:
/saveauracoords

Then update:
lol_wedding_v3_aura_full_resource/shared/aura_config.lua
and
lol_wedding_system_v3_complete/shared/config.lua

## Credit Notice

Do not remove the Aura creator credit from:
lol_wedding_v3_aura_full_resource/CREDITS.md
lol_wedding_v3_aura_full_resource/README.md
