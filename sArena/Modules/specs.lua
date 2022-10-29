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

-- FIXME: some of the spellIds are incorrect, should use spellNames instead
local SPEC_AURAS = {
	-- WARRIOR
	["Taste for Blood"] = "Arms Warrior", -- Taste for Blood
	["Juggernaut"] = "Arms Warrior",
	["Enrage"] = "Arms Warrior", -- Enrage
	["Sudden Death"] = "Arms Warrior", -- Sudden Death
	["Trauma"] = "Arms Warrior", -- Trauma
	["Furious Attack"] = "Furry Warrior", -- Furious Attacks
	["Rampage"] = "Furry Warrior", -- Rampage
	["Slam!"] = "Furry Warrior", -- Slam!
	["Sword and Board"] = "Protection Warrior", -- Sword and Board
	["Vigilance"] = "Protection Warrior", -- Vigilance
	["Silenced - Gag Order"] = "Protection Warrior", -- Silenced - Gag Order
	-- PALADIN
	["Seal of Command"] = "Retribution Paladin", -- Seal of Command
	["The Art of War"] = "Retribution Paladin", -- The Art of War
	["Light's Grace"] = "Holy Paladin", -- Light's Grace
	["Beacon of Light"] = "Holy Paladin", -- Beacon of Light
	["Infusion of Light"] = "Holy Paladin", -- Infusion of Light
	["Silenced - Shield of the Templar"] = "Protection Paladin", -- Silenced - Shield of the Templar
	-- ROGUE
	["Shadowstep"] = "Subtlety Rogue", -- Shadowstep
	[44373] = "Subtlety Rogue", -- Shadowstep Speed
	[36563] = "Subtlety Rogue", -- Shadowstep DMG
	["Shadow Dance"] = "Subtlety Rogue", -- Shadow Dance
	["Master of Subtlety"] = "Subtlety Rogue", -- Master of Subtlety
	["Ghostly Strike"] = "Subtlety Rogue",
	["Killing Spree"] = "Combat Rogue",
	["Blade Flurry"] = "Combat Rogue",
	["Adrenaline Rush"] = "Combat Rogue",
	["Cold Blood"] = "Assassination Rogue",
	["Overkill"] = "Assassination Rogue",
	-- PRIEST
	["Guardian Spirit"] = "Holy Priest", -- Guardian Spirit
	["Borrowed Time"] = "Discipline Priest", -- Borrowed Time
	["Renewed Hope"] = "Discipline Priest", -- Renewed Hope
	["Shadowform"] = "Shadow Priest", -- Shadowform
	["Vampiric Embrace"] = "Shadow Priest", -- Vampiric Embrace
	-- DEATHKNIGHT
	["Bone Shield"] = "Unholy DK", -- Bone Shield
	["Hysteria"] = "Blood DK", -- Hysteria
	["Abomination's Might"] = "Blood DK", -- Abomination's Might
	["Improved Icy Talons"] = "Frost DK", -- Imp. Icy Talons
	-- MAGE
	["Ice Barrier"] = "Frost Mage", -- Ice Barrier
	["Fingers of Frost"] = "Frost Mage", -- Fingers of Frost
	["Fireball!"] = "Frost Mage", -- Fireball!
	["Combustion"] = "Fire Mage", -- Combustion
	["Fiery Payback"] = "Fire Mage", -- Fiery Payback
	["Hot Streak"] = "Fire Mage", -- Hot Streak
	["Firestarter"] = "Fire Mage", -- Firestarter
	["Living Bomb"] = "Fire Mage", -- Living Bomb
	["Arcane Empowerment"] = "Arcane Mage", -- Arcane Empowerment
	["Incanter's Absorption"] = "Arcane Mage", -- Incanter's Absorption
	-- WARLOCK
	["Nether Protection"] = "Destruction Warlock", -- Nether Protection
	["Pyroclasm"] = "Destruction Warlock", -- Pyroclasm
	["Backdraft"] = "Destruction Warlock", -- Backdraft
	["Empowered Imp"] = "Destruction Warlock", -- Empowered Imp
	["Backlash"] = "Destruction Warlock", -- Backlash
	["Demonic Empowerment"] = "Demonology Warlock", -- Demonic Empowerment
	["Eradication"] = "Affliction Warlock", -- Eradication
	-- SHAMAN
	["Totem of Wrath"] = "Elemental Shaman", -- Totem of Wrath
	["Lava Flows"] = "Elemental Shaman", -- Lava Flows
	["Elemental Oath"] = "Elemental Shaman",
	["Astral Shift"] = "Elemental Shaman", -- Astral Shift
	["Earth Shield"] = "Restoration Shaman", -- Earth Shield
	["Tidal Waves"] = "Restoration Shaman", -- Tidal Waves
	["Unleashed Rage"] = "Enhancement Shaman", -- Unleashed Rage
	["Maelstrom Weapon"] = "Enhancement Shaman", -- Maelstrom Weapon
	[63685] = "Enhancement Shaman", -- Freeze (Frozen Power)
	-- HUNTER
	["Spirit Bond"] = "Beast Mastery Hunter", -- Spirit Bond
	["The Beast Within"] = "Beast Mastery Hunter", -- The Beast Within
	["Ferocious Inspiration"] = "Beast Mastery Hunter", -- Ferocious Inspiration
	["Trueshot Aura"] = "Marksmanship Hunter", -- Trueshot Aura
	["Sniper Training"] = "Survival Hunter", -- Sniper Training
	-- DRUID
	["Leader of the Pack"] = "Feral Druid", -- Leader of the Pack
	["Predatory Strikes"] = "Feral Druid", -- Predatory Strikes
	["Berserk"] = "Feral Druid", -- Berserk
	["Moonkin Aura"] = "Balance Druid", -- Moonkin Aura
	["Moonkin Form"] = "Balance Druid", -- Moonkin Form
	["Living Seed"] = "Restoration Druid", -- Living Seed
	["Natural Perfection"] = "Restoration Druid", -- Natural Perfection
	["Wild Growth"] = "Restoration Druid", -- Wild Growth
	[16188] = "Restoration Druid", -- Nature's Swiftness
	["Tree of Life"] = "Restoration Druid", -- Tree of Life
}

local SPEC_SPELLS = {
	-- WARRIOR
	["Mortal Strike"] = "Arms Warrior", -- Mortal Strike
	["Bladestorm"] = "Arms Warrior", -- Bladestorm
	["Bloodthirst"] = "Furry Warrior", -- Bloodthirst
	["Concussion Blow"] = "Protection Warrior", -- Concussion Blow
	["Devastate"] = "Protection Warrior", -- Devastate
	["Shockwave"] = "Protection Warrior", -- Shockwave
	["Vigilance"] = "Protection Warrior", -- Vigilance
	-- PALADIN
	["Avenger's Shield"] = "Protection Paladin", -- Avenger's Shield
	["Holy Shock"] = "Holy Paladin", -- Holy Shock
	["Beacon of Light"] = "Holy Paladin", -- Beacon of Light
	["Crusader Strike"] = "Retribution Paladin", -- Crusader Strike
	["Divine Storm"] = "Retribution Paladin", -- Divine Storm
	["Repentance"] = "Retribution Paladin", -- Repentance
	-- ROGUE
	["Mutilate"] = "Assassination Rogue", -- Mutilate
	["Cold Blood"] = "Assassination Rogue", -- Cold Blood
	["Killing Spree"] = "Combat Rogue", -- Killing Spree
	["Blade Flurry"] = "Combat Rogue", -- Blade Flurry
	["Adrenaline Rush"] = "Combat Rogue", -- Adrenaline Rush
	["Shadowstep"] = "Subtlety Rogue", -- Shadowstep
	["Hemorrhage"] = "Subtlety Rogue", -- Hemorrhage
	["Shadow Dance"] = "Subtlety Rogue", -- Shadow Dance
	-- PRIEST
	["Penance"] = "Discipline Priest", -- Penance
	["Power Infusion"] = "Discipline Priest", -- Power Infusion
	["Pain Suppression"] = "Discipline Priest", -- Pain Suppression
	["Circle of Healing"] = "Holy Priest", -- Circle of Healing
	["Silence"] = "Shadow Priest", -- Silence
	["Vampiric Touch"] = "Shadow Priest", -- Vampiric Touch
	-- DEATHKNIGHT
	["Heart Strike"] = "Blood DK", -- Heart Strike
	["Hungering Cold"] = "Frost DK", -- Hungering Cold
	["Frost Strike"] = "Frost DK", -- Frost Strike
	["Howling Blast"] = "Frost DK", -- Howling Blast
	["Scourge Strike"] = "Unholy DK", -- Scourge Strike
	-- MAGE
	["Arcane Barrage"] = "Arcane Mage", -- Arcane Barrage
	["Living Bomb"] = "Fire Mage", -- Living Bomb
	["Dragon's Breath"] = "Fire Mage", -- Dragon's Breath
	["Blast Wave"] = "Fire Mage", -- Blast Wave
	["Deep Freeze"] = "Frost Mage", -- Deep Freeze
	-- WARLOCK
	["Haunt"] = "Affliction Warlock", -- Haunt
	["Unstable Affliction"] = "Affliction Warlock", -- Unstable Affliction
	["Metamorphosis"] = "Demonology Warlock", -- Metamorphosis
	["Demonic Empowerment"] = "Demonology Warlock", -- Demonic Empowerment
	["Intercept Felguard"] = "Demonology Warlock", -- Intercept Felguard
	["Chaos Bolt"] = "Destruction Warlock", -- Chaos Bolt
	["Shadowfurry"] = "Destruction Warlock",
	-- SHAMAN
	["Thunderstorm"] = "Elemental Shaman", -- Thunderstorm
	["Elemental Mastery"] = "Elemental Shaman", -- Elemental Mastery
	["Feral Spirit"] = "Enhancement Shaman", -- Feral Spirit
	["Shamanistic Rage"] = "Enhancement Shaman", -- Shamanistic Rage
	["Stormstrike"] = "Enhancement Shaman", -- Stormstrike
	["Riptide"] = "Restoration Shaman", -- Riptide
	["Cleanse Spirit"] = "Restoration Shaman", -- Cleanse Spirit
	-- HUNTER
	["Intimidation"] = "Beast Mastery Hunter", -- Intimidation
	["Silencing Shot"] = "Marksmanship Hunter", -- Silencing Shot
	["Chimera Shot"] = "Marksmanship Hunter", -- Chimera Shot
	["Explosive Shot"] = "Survival Hunter", -- Explosive Shot
	["Wyvern Sting"] = "Survival Hunter", -- Wyvern Sting
	-- DRUID
	["Starfall"] = "Balance Druid", -- Starfall
	["Typhoon"] = "Balance Druid", -- Typhoon
	["Moonkin Form"] = "Balance Druid", -- Moonkin Form
	["Mangle (Cat)"] = "Feral Druid", -- Mangle (Cat)
	["Mangle (Bear)"] = "Feral Druid", -- Mangle (Bear)
	["Berserk"] = "Feral Druid", -- Berserk
	["Swiftmend"] = "Restoration Druid", -- Swiftmend
	[17116] = "Restoration Druid", -- Nature's Swiftness
	["Tree of Life"] = "Restoration Druid", -- Tree of Life
	["Wild Growth"] = "Restoration Druid", -- Wild Growth
}

-- TODO: enum these nuts
local SPEC_TEXTURES = {
	-- TODO: Get better icons... look at wowhead guids.
	-- TODO: / is fine for path
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

-----------------------------------
-- MAKE SURE IT WORKS IN BGs TOO --
-----------------------------------
-- IMPR: if I detect Leader of the Pack, then I could make mystery frame for feral even in stealth, and assign spec
-- would be best to have mystery spec for everything and every time

local function revealSpec(self, spec)
	-- self == arenaFrame.SP
	self.spec = spec
	self.Icon:SetTexture(SPEC_TEXTURES[self.spec])
	self:Show()
end

function SPECDETECT_UNIT_SPELLCAST_SUCCEEDED(self, ...)
	local _, subevent, _, sourceGUID, sourceName, sourceFlags, _, guid, destName, destFlags, _, spellId, spellName, _, auraType = CombatLogGetCurrentEventInfo()

	if UnitGUID(self.unit) ~= sourceGUID then return end
	if self.spec ~= nil then return end

	if subevent == "SPELL_AURA_APPLIED" or subevent == "SPELL_AURA_REMOVED" then
		local maybeSpec = SPEC_AURAS[spellId] or SPEC_AURAS[spellName]
		if maybeSpec then
			print("Spec detected, event: ", subevent, ", spell: ", spellName, ", unit: ", self.unit)
			revealSpec(self, maybeSpec)
		end
	elseif subevent == "SPELL_CAST_START" or subevent == "SPELL_CAST_SUCCESS" then
		local maybeSpec = SPEC_SPELLS[spellId] or SPEC_SPELLS[spellName]
		if maybeSpec then
			print("Spec detected, event: ", subevent, ", spell: ", spellName, ", unit: ", self.unit)
			revealSpec(self, maybeSpec)
		end
	end
end

function FIRST_DETECT_UNIT(self, ...)
	local _, updateReason = ...

	-- Proceed if:
	-- we just spot the person.
	if updateReason ~= "seen" then return end
	-- we haven't found spec defining aura on him.
	if self.wasSpecRevealedOnFirstDetect then return end

	local unit = self.unit
	-- spec is not set set already.
	if self.spec ~= nil then return end

	-- scan all buffs
	for n = 1, 30 do
		local spellName, _, _, _, _, _, source, _, _, spellId = UnitAura(unit, n, "HELPFUL")

		local maybeSpec = SPEC_AURAS[spellId] or SPEC_AURAS[spellName]

		-- FIXME: still doesn't detect Elemental Oath I think
		if maybeSpec and source then
			local unitPet = string.gsub(unit, "%d$", "pet%1")
			-- print("matching spell, ", spellName, " on unit: ", self.unit)
			if UnitIsUnit(unit, source) or UnitIsUnit(unitPet, source) then
				print("FIRST_DETECT_UNIT Spec detected aura: ", spellName, ", unit: ", self.unit)
				-- TODO: maybe unregister event?
				-- self:UnregisterEvent()
				revealSpec(self, maybeSpec)
				self.wasSpecRevealedOnFirstDetect = true
				return
			end
		end
	end
end

function module:OnEvent(event, ...)
	for i = 1, MAX_ARENA_ENEMIES do
		local SP = nil
		local specBorder = nil
		local arenaFrame = _G["ArenaEnemyFrame" .. i]

		if (arenaFrame["SP"] == nil) then
			SP = CreateFrame("Frame", nil, arenaFrame, "sArenaIconTemplate")

			SP.unit = arenaFrame.unit

			SP:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			SP:RegisterEvent("ARENA_OPPONENT_UPDATE")
			SP:SetScript("OnEvent", function(self, event, ...) return self[event](self, ...) end)

			-- TODO: so what's the order they trigger in?
			-- first I wanna check for CLUE ARENA_OPPONENT_UPDATE if needed
			SP.COMBAT_LOG_EVENT_UNFILTERED = SPECDETECT_UNIT_SPELLCAST_SUCCEEDED
			SP.ARENA_OPPONENT_UPDATE = FIRST_DETECT_UNIT

			SP.mask = SP:CreateMaskTexture()
			SP.mask:SetAllPoints(SP.Icon)
			SP.mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask") -- TODO: what are those params?
			SP.Icon:AddMaskTexture(SP.mask)

			specBorder = CreateFrame("Frame", nil, SP)
			specBorder:SetSize(64, 64)
			specBorder:SetPoint("CENTER")
			specBorder.tex = specBorder:CreateTexture()
			specBorder.tex:SetAllPoints(specBorder)
			specBorder.tex:SetTexture("Interface/CHARACTERFRAME/TotemBorder")

			specBorder.mask = specBorder:CreateMaskTexture()
			specBorder.mask:SetAllPoints(specBorder.tex)
			specBorder.mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask")
			specBorder.tex:AddMaskTexture(specBorder.mask)

			SP.border = specBorder
			arenaFrame.SP = SP
		else
			SP = arenaFrame.SP
			specBorder = SP.border
		end

		SP.spec = nil
		SP.wasSpecRevealedOnFirstDetect = false -- nice name lmao

		if event == "ADDON_LOADED" then
			SP:SetMovable(true)
			addon:SetupDrag(self, true, SP)

			SP:SetFrameLevel(100) -- Not sure about this, I just wanted it to have higher strata then trinket cd
		elseif event == "PLAYER_ENTERING_WORLD" then
			SP:Hide()
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
