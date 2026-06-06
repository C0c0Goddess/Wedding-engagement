# Loyalty Ova Love Wedding System V3 Complete

## Included
- Auto-popup fixed wedding planner UI
- Luxury tablet planner
- Ring shop
- Diamond ring items
- Proposal system
- Accept/decline proposal popup
- Engagement tracking
- Marriage command
- Divorce command
- Marriage status command
- Marriage license system
- Married name change
- Mr./Mrs. Lastname name tags
- Venue booking
- Guest invitations
- Wedding invitation item
- Wedding plan saving
- Shared couple account
- Deposits and withdrawals
- Ceremony animation placeholder
- Admin command
- Discord logging support
- Complete SQL install
- QBCore support
- ox_inventory support

## Install
1. Put folder in:
resources/[custom]/lol_wedding_system_v3_complete

2. Import:
sql/install.sql

3. Add items:
- qb-inventory: copy shared/items.lua entries into qb-core/shared/items.lua
- ox_inventory: copy shared/ox_inventory_items.lua into ox_inventory/data/items.lua

4. Add to server.cfg:

ensure oxmysql
ensure ox_lib
ensure qb-core
ensure ox_inventory
ensure qb-menu
ensure lol_wedding_system_v3_complete

## Commands
/weddingplanner
/propose [player id]
/marry [player id]
/divorce
/marriagestatus
/marriagelicense [player id]
/changemarriedname [lastname]
/startceremony [player id]
/coupleaccount
/weddingadmin

## UI Fix
The NUI starts hidden and only opens with /weddingplanner or the server event:
lol-weddings:client:openPlanner
