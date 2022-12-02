local addonName, shareTable = ...

local L = LibStub('AceLocale-3.0'):NewLocale(addonName, "enUS", true)
if not L then return end

L["Display string"] = true
L["Left Pane"] = true
L["Right Pane"] = true
L["Position"] = true
L["AnchorFrame"] = true
L["Set AnchorFrame"] = true
L["AnchorFrame Anchor"] = true
L["Pane Anchor"] = true
L["x Offset"] = true
L["y Offset"] = true

L["Usage"] =
[[Keywords - All stats are % with some exceptions, Case insensitive
[GS]=[GearScore]  [ILVL]=[ItemLevel]
[Reduction] [ReductionBoss] |cffccccccReduction from Armor(Same / 83)|r
[Damage] |cffccccccDamage Mod %|r  [CritAvoid] |cffccccccCrit Avoidance|r
[TrueAvoid] |cffccccccMiss+Parry+Dodge|r  [TotalAvoid] |cffccccccM+D+P+Block|r [BV]=[BlockValue]
[ArmorPen] |cffcccccc%|r [ArmorPenR] |cffccccccRating(Not %)|r
|cffccccccFor Melee|r  [MHit] [MCrit] [MHaste]
|cffccccccFor Ranged|r [RHit] [RCrit] [RHaste]
|cffccccccFor Spell|r  [SHit] [SHaste] [Heal] [SpellPen]
|cffffe57f[Holy] [HolyCrit]|r    |cffff7f00[Fire] [FireCrit]|r      |cff4cff4c[Nature] [NatureCrit]|r
|cff7fffff[Frost] [FrostCrit]|r  |cff7f7fff[Shadow] [ShadowCrit]|r  |cffff7fff[Arcane] [ArcaneCrit]|r
[Speed] |cffccccccMovement Speed|r]]
L["RDC1" ] = "REDUCTION"
L["RDC2" ] = "REDUCTIONBOSS"
L["DMGM" ] = "DAMAGE"
L["CRIAV"] = "CRITAVOID"
L["TRUEA"] = "TRUEAVOID"
L["AVOID"] = "TOTALAVOID"
L["BV"   ] = "BLOCKVALUE"
L["MHIT" ] = "MELEEHIT"     -- 
L["MCRI" ] = "MCRIT"
L["MHAS" ] = "MHASTE"
L["APEN" ] = "ARMORPEN"
L["APENR"] = "ARMORPENR"
L["RHIT" ] = "RANGEDHIT"    -- 
L["RCRI" ] = "RCRIT"
L["RHAS" ] = "RHASTE"
L["SPHO" ] = "HOLY"
L["SPFI" ] = "FIRE"
L["SPNA" ] = "NATURE"
L["SPFR" ] = "FROST"
L["SPSH" ] = "SHADOW"
L["SPAR" ] = "ARCANE"
L["SCHO" ] = "HOLYCRIT"
L["SCFI" ] = "FIRECRIT"
L["SCNA" ] = "NATURECRIT"
L["SCFR" ] = "FROSTCRIT"
L["SCSH" ] = "SHADOWCRIT"
L["SCAR" ] = "ARCANECRIT"
L["SHEAL"] = "HEAL"
L["SHIT" ] = "SPELLHIT"     -- 
L["SHAS "] = "SHASTE"
L["SPEN" ] = "SPELLPEN"
L["SPEED"] = "MOVESPEED"    -- 
L["ILVL" ] = "ITEMLEVEL"
L["GS"   ] = "GEARSCORE"
shareTable.enUS = {
}

L["DEFAULT_L_STRING_WARRIOR"] =
[[Pen [ArmorPen]%
Hit [MHit]%
Has [MHaste]%

Avoid [TrueAvoid]%
Total [TotalAvoid]% [BV]
-Crit [CritAvoid]%]]
L["DEFAULT_L_STRING_HUNTER"] = 
[[ArmorPen [ArmorPen]%
Hit [RHit]%
Haste [RHaste]%

-Crit [CritAvoid]%]]
L["DEFAULT_L_STRING_SHAMAN"] = 
[[ArmorPen [ArmorPen]%
Nat [Nature] [NatureCrit]%
Hit [MHit]% [SHit]%
Haste [MHaste]% [SHaste]%

-Crit [CritAvoid]%]]
L["DEFAULT_L_STRING_DEATHKNIGHT"] = 
[[Hit [MHit]% [SHit]%
Haste [MHaste]%

TrueAvoid [TrueAvoid]%
-Crit [CritAvoid]%]]
L["DEFAULT_L_STRING_ROGUE"] = 
[[ArmorPen [ArmorPen]%
Hit [MHit]%
Haste [MHaste]%

-Crit [CritAvoid]%]]
L["DEFAULT_L_STRING_MAGE"] = 
[[Arc [Arcane] [ArcaneCrit]%
Fro [Frost] [FrostCrit]%
Hit [SHit]%
Has [SHaste]%

-Crit [CritAvoid]%]]
L["DEFAULT_L_STRING_DRUID"] = 
[[ArmorPen [ArmorPen]%
Nat [Nature] [NatureCrit]%
Hit [MHit]% [SHit]%
Haste [MHaste]% [SHaste]%

-Crit [CritAvoid]%]]
L["DEFAULT_L_STRING_PALADIN"] = 
[[Hol [Holy] [HolyCrit]%
Hit [MHit]% [SHit]%

Avoid [TrueAvoid]%
Total [TotalAvoid]%
-Crit [CritAvoid]%]]
L["DEFAULT_L_STRING_PRIEST"] = 
[[Sha [Shadow] [ShadowCrit]%
Heal [Heal]
Hit  [SHit]%
Has [SHaste]%

-Crit [CritAvoid]%]]
L["DEFAULT_L_STRING_WARLOCK"] = 
[[Sha [Shadow] [ShadowCrit]%
Hit [SHit]%
Has [SHaste]%

-Crit [CritAvoid]%]]
L["DEFAULT_R_STRING"] = 
[[[ILVL]
[GS]
[Speed]%]]