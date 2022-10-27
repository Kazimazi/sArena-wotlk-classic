local addonName, addon = ...
local module = addon:CreateModule("Specs")

module.defaultSettings = {
	x = 40,
	y = -20,
	iconSize = 19,
	borderSize = 32,
}

module.optionsTable = {
	iconSize = {
		order = 1,
		type = "range",
		name = "Icon size",
		min = 10,
		max = 50,
		step = 1,
		bigStep = 2,
		set = module.UpdateSettings,
	},
}

local SPEC_BUFFS = {
	-- WARRIOR
	[56638] = "Arms Warrior", -- Taste for Blood
	[64976] = "Arms Warrior", -- Juggernaut
	[57522] = "Arms Warrior", -- Enrage
	[52437] = "Arms Warrior", -- Sudden Death
	[46857] = "Arms Warrior", -- Trauma
	[56112] = "Furry Warrior", -- Furious Attacks
	[29801] = "Furry Warrior", -- Rampage
	[46916] = "Furry Warrior", -- Slam!
	[50227] = "Protection Warrior", -- Sword and Board
	[50720] = "Protection Warrior", -- Vigilance
	[74347] = "Protection Warrior", -- Silenced - Gag Order
	-- PALADIN
	[20375] = "Retribution Paladin", -- Seal of Command
	[59578] = "Retribution Paladin", -- The Art of War
	[31836] = "Holy Paladin", -- Light's Grace
	[53563] = "Holy Paladin", -- Beacon of Light
	[54149] = "Holy Paladin", -- Infusion of Light
	[63529] = "Protection Paladin", -- Silenced - Shield of the Templar
	-- ROGUE
	[36554] = "Subtlety Rogue", -- Shadowstep
	[44373] = "Subtlety Rogue", -- Shadowstep Speed
	[36563] = "Subtlety Rogue", -- Shadowstep DMG
	[51713] = "Subtlety Rogue", -- Shadow Dance
	[31665] = "Subtlety Rogue", -- Master of Subtlety
	[14278] = "Subtlety Rogue", -- Ghostly Strike
	[51690] = "Combat Rogue", -- Killing Spree
	[13877] = "Combat Rogue", -- Blade Flurry
	[13750] = "Combat Rogue", -- Adrenaline Rush
	[14177] = "Assassination Rogue", -- Cold Blood
	-- PRIEST
	[47788] = "Holy Priest", -- Guardian Spirit
	[52800] = "Discipline Priest", -- Borrowed Time
	[63944] = "Discipline Priest", -- Renewed Hope
	[15473] = "Shadow Priest", -- Shadowform
	[15286] = "Shadow Priest", -- Vampiric Embrace
	-- DEATHKNIGHT
	[49222] = "Unholy DK", -- Bone Shield
	[49016] = "Blood DK", -- Hysteria
	[53138] = "Blood DK", -- Abomination's Might
	[55610] = "Frost DK", -- Imp. Icy Talons
	-- MAGE
	[43039] = "Frost Mage", -- Ice Barrier
	[74396] = "Frost Mage", -- Fingers of Frost
	[57761] = "Frost Mage", -- Fireball!
	[11129] = "Fire Mage", -- Combustion
	[64346] = "Fire Mage", -- Fiery Payback
	[48108] = "Fire Mage", -- Hot Streak
	[54741] = "Fire Mage", -- Firestarter
	[55360] = "Fire Mage", -- Living Bomb
	[31583] = "Arcane Mage", -- Arcane Empowerment
	[44413] = "Arcane Mage", -- Incanter's Absorption
	-- WARLOCK
	[30302] = "Destruction Warlock", -- Nether Protection
	[63244] = "Destruction Warlock", -- Pyroclasm
	[54277] = "Destruction Warlock", -- Backdraft
	[47283] = "Destruction Warlock", -- Empowered Imp
	[34936] = "Destruction Warlock", -- Backlash
	[47193] = "Demonology Warlock", -- Demonic Empowerment
	[64371] = "Affliction Warlock", -- Eradication
	-- SHAMAN
	[57663] = "Elemental Shaman", -- Totem of Wrath
	[65264] = "Elemental Shaman", -- Lava Flows
	[51470] = "Elemental Shaman", -- Elemental Oath
	[52179] = "Elemental Shaman", -- Astral Shift
	[49284] = "Restoration Shaman", -- Earth Shield
	[53390] = "Restoration Shaman", -- Tidal Waves
	[30809] = "Enhancement Shaman", -- Unleashed Rage
	[53817] = "Enhancement Shaman", -- Maelstrom Weapon
	[63685] = "Enhancement Shaman", -- Freeze (Frozen Power)
	-- HUNTER
	[20895] = "Beast Mastery Hunter", -- Spirit Bond
	[34471] = "Beast Mastery Hunter", -- The Beast Within
	[75447] = "Beast Mastery Hunter", -- Ferocious Inspiration
	[19506] = "Marksmanship Hunter", -- Trueshot Aura NOTE: Don't think it works
	[31519] = "Marksmanship Hunter", -- Trueshot Aura
	[64420] = "Survival Hunter", -- Sniper Training
	-- DRUID
	[24932] = "Feral Druid", -- Leader of the Pack
	[16975] = "Feral Druid", -- Predatory Strikes
	[50334] = "Feral Druid", -- Berserk
	[24907] = "Balance Druid", -- Moonkin Aura
	[24858] = "Balance Druid", -- Moonkin Form
	[48504] = "Restoration Druid", -- Living Seed
	[45283] = "Restoration Druid", -- Natural Perfection
	[53251] = "Restoration Druid", -- Wild Growth
	[16188] = "Restoration Druid", -- Nature's Swiftness
	[33891] = "Restoration Druid", -- Tree of Life
}

local SPEC_SPELLS = {
	-- WARRIOR
	[47486] = "Arms Warrior", -- Mortal Strike
	[46924] = "Arms Warrior", -- Bladestorm
	[23881] = "Furry Warrior", -- Bloodthirst
	[12809] = "Protection Warrior", -- Concussion Blow
	[47498] = "Protection Warrior", -- Devastate
	[46968] = "Protection Warrior", -- Shockwave
	[50720] = "Protection Warrior", -- Vigilance
	-- PALADIN
	[48827] = "Protection Paladin", -- Avenger's Shield
	[48825] = "Holy Paladin", -- Holy Shock
	[53563] = "Holy Paladin", -- Beacon of Light
	[35395] = "Retribution Paladin", -- Crusader Strike
	[66006] = "Retribution Paladin", -- Divine Storm
	[20066] = "Retribution Paladin", -- Repentance
	-- ROGUE
	[48666] = "Assassination Rogue", -- Mutilate
	[14177] = "Assassination Rogue", -- Cold Blood
	[51690] = "Combat Rogue", -- Killing Spree
	[13877] = "Combat Rogue", -- Blade Flurry
	[13750] = "Combat Rogue", -- Adrenaline Rush
	[36554] = "Subtlety Rogue", -- Shadowstep
	[48660] = "Subtlety Rogue", -- Hemorrhage
	[51713] = "Subtlety Rogue", -- Shadow Dance
	-- PRIEST
	[52985] = "Discipline Priest", -- Penance
	[10060] = "Discipline Priest", -- Power Infusion
	[33206] = "Discipline Priest", -- Pain Suppression
	[34861] = "Holy Priest", -- Circle of Healing
	[15487] = "Shadow Priest", -- Silence
	[48160] = "Shadow Priest", -- Vampiric Touch
	-- DEATHKNIGHT
	[55262] = "Blood DK", -- Heart Strike
	[49203] = "Frost DK", -- Hungering Cold
	[55268] = "Frost DK", -- Frost Strike
	[51411] = "Frost DK", -- Howling Blast
	[55271] = "Unholy DK", -- Scourge Strike
	-- MAGE
	[44781] = "Arcane Mage", -- Arcane Barrage
	[55360] = "Fire Mage", -- Living Bomb
	[42950] = "Fire Mage", -- Dragon's Breath
	[42945] = "Fire Mage", -- Blast Wave
	[44572] = "Frost Mage", -- Deep Freeze
	-- WARLOCK
	[59164] = "Affliction Warlock", -- Haunt
	[47843] = "Affliction Warlock", -- Unstable Affliction
	[59672] = "Demonology Warlock", -- Metamorphosis
	[47193] = "Demonology Warlock", -- Demonic Empowerment
	[47996] = "Demonology Warlock", -- Intercept Felguard
	[59172] = "Destruction Warlock", -- Chaos Bolt
	[47847] = "Destruction Warlock", -- ShadowFurry Warrior
	-- SHAMAN
	[59159] = "Elemental Shaman", -- Thunderstorm
	[16166] = "Elemental Shaman", -- Elemental Mastery
	[51533] = "Enhancement Shaman", -- Feral Spirit
	[30823] = "Enhancement Shaman", -- Shamanistic Rage
	[17364] = "Enhancement Shaman", -- Stormstrike
	[61301] = "Restoration Shaman", -- Riptide
	[51886] = "Restoration Shaman", -- Cleanse Spirit
	-- HUNTER
	[19577] = "Beast Mastery Hunter", -- Intimidation
	[34490] = "Marksmanship Hunter", -- Silencing Shot
	[53209] = "Marksmanship Hunter", -- Chimera Shot
	[60053] = "Survival Hunter", -- Explosive Shot
	[49012] = "Survival Hunter", -- Wyvern Sting
	-- DRUID
	[53201] = "Balance Druid", -- Starfall
	[61384] = "Balance Druid", -- Typhoon
	[24858] = "Balance Druid", -- Moonkin Form
	[48566] = "Feral Druid", -- Mangle (Cat)
	[48564] = "Feral Druid", -- Mangle (Bear)
	[50334] = "Feral Druid", -- Berserk
	[18562] = "Restoration Druid", -- Swiftmend
	[17116] = "Restoration Druid", -- Nature's Swiftness
	[33891] = "Restoration Druid", -- Tree of Life
	[53251] = "Restoration Druid", -- Wild Growth
}

-- TODO: enum these nuts
local SPEC_TEXTURES = {
	-- TODO: Get better icons... look at wowhead guids.
	["Arms Warrior"] = "Interface\\Icons\\Ability_warrior_bladestorm",
	["Furry Warrior"] = "Interface\\Icons\\Ability_warrior_innerrage",
	["Protection Warrior"] = "Interface\\Icons\\Inv_shield_06",

	["Holy Paladin"] = "Interface\\Icons\\Spell_holy_holybolt",
	["Retribution Paladin"] = "Interface\\Icons\\Spell_holy_auraoflight",
	["Protection Paladin"] = "Interface\\Icons\\Inv_shield_06",

	["Assassination Rogue"] = "Interface\\Icons\\Ability_rogue_eviscerate",
	["Combat Rogue"] = "Interface\\Icons\\Ability_backstab",
	["Subtlety Rogue"] = "Interface\\Icons\\Ability_stealth",

	["Discipline Priest"] = "Interface\\Icons\\Spell_holy_penance",
	["Shadow Priest"] = "Interface\\Icons\\Spell_shadow_shadowform",
	["Holy Priest"] = "Interface\\Icons\\Spell_holy_holybolt",

	["Blood DK"] = "Interface\\Icons\\Spell_deathknight_bloodpresence",
	["Frost DK"] = "Interface\\Icons\\Spell_deathknight_frostpresence",
	["Unholy DK"] = "Interface\\Icons\\Spell_deathknight_unholypresence",

	["Arcane Mage"] = "Interface\\Icons\\Spell_arcane_blast",
	["Fire Mage"] = "Interface\\Icons\\Spell_fire_fireball02",
	["Frost Mage"] = "Interface\\Icons\\Spell_frost_frostbolt02",

	["Affliction Warlock"] = "Interface\\Icons\\Spell_shadow_unstableaffliction_3",
	["Demonology Warlock"] = "Interface\\Icons\\Spell_shadow_demonform",
	["Destruction Warlock"] = "Interface\\Icons\\Spell_shadow_shadowfury",

	["Elemental Shaman"] = "Interface\\Icons\\Spell_shaman_thunderstorm",
	["Enhancement Shaman"] = "Interface\\Icons\\Ability_shaman_stormstrike",
	["Restoration Shaman"] = "Interface\\Icons\\Spell_nature_magicimmunity",

	["Beast Mastery Hunter"] = "Interface\\Icons\\Ability_hunter_beastwithin",
	["Marksmanship Hunter"] = "Interface\\Icons\\Ability_marksmanship",
	["Survival Hunter"] = "Interface\\Icons\\Ability_hunter_swiftstrike",

	["Balance Druid"] = "Interface\\Icons\\Spell_nature_starfall",
	["Feral Druid"] = "Interface\\Icons\\Ability_racial_bearform",
	["Restoration Druid"] = "Interface\\Icons\\Spell_nature_healingtouch",
}

-- FIXME: if someone has aura before game start it is not picked up
function SPECDETECT_UNIT_SPELLCAST_SUCCEEDED(self, ...)
	local _, event, _, sourceGUID, sourceName, sourceFlags, _, guid, destName, destFlags, _, spellId, spellName, _, auraType = CombatLogGetCurrentEventInfo()

	if UnitGUID(self.unit) ~= sourceGUID then return end
	if event ~= "SPELL_CAST_SUCCESS" then return end
	-- if we aleady have spec don't check anymore
	if self.spec ~= nil then return end

	local arenaFrame = self:GetParent()
	local spec = arenaFrame.SP

	local maybeTexture = SPEC_SPELLS[spellId] or SPEC_BUFFS[spellId]

	if maybeTexture then
		spec.Icon:SetTexture(SPEC_TEXTURES[maybeTexture])
		spec:Show()
	end
end

function module:OnEvent(event, ...)
	for i = 1, MAX_ARENA_ENEMIES do
		local SP = nil
		local specBorder = nil
		local arenaFrame = _G["ArenaEnemyFrame" .. i]

		if (arenaFrame["SP"] == nil) then
			SP = CreateFrame("Frame", nil, arenaFrame, "sArenaIconTemplate")
			SP:Hide() -- by default we hide it

			SP.unit = arenaFrame.unit
			SP:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			SP:SetScript("OnEvent", function(self, event, ...) return self[event](self, ...) end)
			SP.COMBAT_LOG_EVENT_UNFILTERED = SPECDETECT_UNIT_SPELLCAST_SUCCEEDED

			SP.mask = SP:CreateMaskTexture()
			SP.mask:SetAllPoints(SP.Icon)
			SP.mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE") -- TODO: what are those params?
			SP.Icon:AddMaskTexture(SP.mask)

			specBorder = CreateFrame("Frame", nil, SP)
			specBorder:SetSize(64, 64)
			specBorder:SetPoint("CENTER")
			specBorder.tex = specBorder:CreateTexture()
			specBorder.tex:SetAllPoints(specBorder)
			specBorder.tex:SetTexture("Interface/CHARACTERFRAME/TotemBorder")

			specBorder.mask = specBorder:CreateMaskTexture()
			specBorder.mask:SetAllPoints(specBorder.tex)
			specBorder.mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE",
				"CLAMPTOBLACKADDITIVE")
			specBorder.tex:AddMaskTexture(specBorder.mask)

			SP.border = specBorder
			arenaFrame.SP = SP
		else
			SP = arenaFrame.SP
			specBorder = SP.border
		end

		if event == "ADDON_LOADED" then
			SP:SetMovable(true)
			addon:SetupDrag(self, true, SP)

			SP:SetFrameLevel(100)
		elseif event == "TEST_MODE" then
			if addon.testMode then
				SP:EnableMouse(true)
				SP.spec = "Assassination Rogue"
				SP.Icon:SetTexture(SPEC_TEXTURES[SP.spec])
				SP:Show()
			else
				SP:EnableMouse(false)
				SP.spec = nil
				SP.Icon:SetTexture(nil)
				SP:Hide()
			end
		elseif event == "UPDATE_SETTINGS" then
			SP:ClearAllPoints()
			SP:SetPoint("CENTER", self.db.x, self.db.y)
			SP:SetSize(self.db.iconSize, self.db.iconSize)
			specBorder:SetSize(self.db.iconSize * (8 / 5), self.db.iconSize * (8 / 5))
		end
	end

	if event == "ADDON_LOADED" then
		self:OnEvent("UPDATE_SETTINGS")
	end
end
