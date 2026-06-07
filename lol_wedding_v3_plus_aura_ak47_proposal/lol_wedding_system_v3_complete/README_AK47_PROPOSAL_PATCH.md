# AK47 Inventory + Proposal Emote Patch

## What Changed

This wedding system now supports:

- `Config.Inventory = 'ak47'`
- AK47 item add/remove/count helpers in `server/utils.lua`
- Forced GTA-style kneeling proposal emote when using `/propose [player id]`
- The proposal accept/decline popup appears after the kneeling animation starts

## Config

Open:

`shared/config.lua`

Inventory is now set to:

```lua
Config.Inventory = 'ak47' -- ox, qb, or ak47
```

AK47 resource name:

```lua
Config.AK47Inventory = {
    Resource = 'ak47_inventory'
}
```

If your AK47 inventory resource folder has a different name, change it there.

## Important

AK47 inventory exports can vary by version. This patch uses the common style:

```lua
exports['ak47_inventory']:AddItem(src, item, amount)
exports['ak47_inventory']:RemoveItem(src, item, amount)
exports['ak47_inventory']:GetItemCount(src, item)
```

If your AK47 inventory uses different export names, edit:

`server/utils.lua`

## Proposal Emote

Config:

```lua
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
```

The proposer kneels. The target faces them and waits for the proposal prompt.
