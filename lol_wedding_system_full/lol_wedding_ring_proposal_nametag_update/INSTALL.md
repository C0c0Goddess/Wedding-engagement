# LOL Wedding Ring / Proposal / Name Tag Update

## Adds
- Physical diamond ring items
- Silver, gold, rose gold engagement rings
- Diamond wedding band
- /propose [player id]
- Accept or decline proposal popup
- Mr./Mrs. Lastname floating name tag above married players
- NUI no longer opens automatically on server start
- UI opens only with /weddingplanner

## Install
1. Drop these files into your existing wedding resource.
2. Replace your old web folder with this web folder.
3. Import sql/update_marriages.sql.
4. Add the ring items into qb-core/shared/items.lua or ox_inventory/data/items.lua.
5. Restart the resource.

## Required Ring
Default required proposal item:
diamond_ring_gold

Change it in:
shared/config.lua

## Important
The name tag only shows if the marriage row status is:
married

Engaged couples are saved as:
engaged
