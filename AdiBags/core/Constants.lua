--[[
AdiBags - Adirelle's bag addon.
Copyright 2010-2012 Adirelle (adirelle@gmail.com)
All rights reserved.
--]]

local addonName, addon = ...
local L = addon.L

--<GLOBALS
local _G = _G
local BACKPACK_CONTAINER = _G.BACKPACK_CONTAINER
local BANK_CONTAINER = _G.BANK_CONTAINER
local NUM_BAG_SLOTS = _G.NUM_BAG_SLOTS
local NUM_BANKBAGSLOTS = _G.NUM_BANKBAGSLOTS
local pairs = _G.pairs
--GLOBALS>

-- Backpack and bags
local BAGS = { [BACKPACK_CONTAINER] = BACKPACK_CONTAINER }
for i = 1, NUM_BAG_SLOTS do BAGS[i] = i end

-- Bank bags
local BANK = { [BANK_CONTAINER] = BANK_CONTAINER }
for i = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do BANK[i] = i end

-- All bags
local ALL = {}
for id in pairs(BAGS) do ALL[id] = id end
for id in pairs(BANK) do ALL[id] = id end

addon.BAG_IDS = { BAGS = BAGS, BANK = BANK, ALL = ALL }

addon.FAMILY_TAGS = {
--@noloc[[
	[0x00001] = L["QUIVER_TAG"], -- Quiver
	[0x00002] = L["AMMO_TAG"], -- Ammo Pouch
	[0x00004] = L["SOUL_BAG_TAG"], -- Soul Bag
	[0x00008] = L["LEATHERWORKING_BAG_TAG"], -- Leatherworking Bag
	[0x00010] = L["INSCRIPTION_BAG_TAG"], -- Inscription Bag
	[0x00020] = L["HERB_BAG_TAG"], -- Herb Bag
	[0x00040] = L["ENCHANTING_BAG_TAG"] , -- Enchanting Bag
	[0x00080] = L["ENGINEERING_BAG_TAG"], -- Engineering Bag
	[0x00100] = L["KEYRING_TAG"], -- Keyring
	[0x00200] = L["GEM_BAG_TAG"], -- Gem Bag
	[0x00400] = L["MINING_BAG_TAG"], -- Mining Bag
	[0x08000] = L["TACKLE_BOX_TAG"], -- Tackle Box
	[0x10000] = L["COOKING_BAR_TAG"], -- Refrigerator
--@noloc]]
}

addon.FAMILY_ICONS = {
	[0x00001] = [[Interface\Icons\INV_Misc_Ammo_Arrow_01]], -- Quiver
	[0x00002] = [[Interface\Icons\INV_Misc_Ammo_Bullet_05]], -- Ammo Pouch
	[0x00004] = [[Interface\Icons\INV_Misc_Gem_Amethyst_02]], -- Soul Bag
	[0x00008] = [[Interface\Icons\Trade_LeatherWorking]], -- Leatherworking Bag
	[0x00010] = [[Interface\Icons\INV_Inscription_Tradeskill01]], -- Inscription Bag
	[0x00020] = [[Interface\Icons\Trade_Herbalism]], -- Herb Bag
	[0x00040] = [[Interface\Icons\Trade_Engraving]], -- Enchanting Bag
	[0x00080] = [[Interface\Icons\Trade_Engineering]], -- Engineering Bag
	[0x00100] = [[Interface\Icons\INV_Misc_Key_14]], -- Keyring
	[0x00200] = [[Interface\Icons\INV_Misc_Gem_BloodGem_01]], -- Gem Bag
	[0x00400] = [[Interface\Icons\Trade_Mining]], -- Mining Bag
	[0x08000] = [[Interface\Icons\Trade_Fishing]], -- Tackle Box
	[0x10000] = [[Interface\Icons\INV_Misc_Bag_Cooking]], -- Refrigerator
}

addon.ITEM_SIZE = 37
addon.ITEM_SPACING = 4
addon.SECTION_SPACING = addon.ITEM_SIZE / 3 + addon.ITEM_SPACING
addon.BAG_INSET = 8
addon.TOP_PADDING = 32
addon.HEADER_SIZE = 14 + addon.ITEM_SPACING

addon.BACKDROP = {
	bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
	tile = false,
	edgeSize = 16,
	insets = { left = 3, right = 3, top = 3, bottom = 3 },
}

addon.DEFAULT_SETTINGS = {
	profile = {
		enabled = true,
		bags = {
			["*"] = true,
		},
		positionMode = "anchored",
		positions = {
			anchor = { point = "BOTTOMRIGHT", xOffset = -32, yOffset = 200 },
			Backpack = { point = "BOTTOMRIGHT", xOffset = -32, yOffset = 200 },
			Bank = { point = "TOPLEFT", xOffset = 32, yOffset = -104 },
		},
		scale = 0.8,
		rowWidth = { ['*'] = 9 },
		maxHeight = 0.60,
		maxWidth = 0.40,
		laxOrdering = 0,
		qualityHighlight = true,
		qualityOpacity = 1.0,
		dimJunk = true,
		questIndicator = true,
		showBagType = true,
		filters = { ['*'] = true },
		filterPriorities = {},
		sortingOrder = 'default',
		modules = { ['*'] = true },
		virtualStacks = {
			['*'] = false,
			freeSpace = true,
			notWhenTrading = 1,
		},
		automaticLayout = 0,
		skin = {
			background = "Blizzard Tooltip",
			border = "Blizzard Tooltip",
			borderWidth = 16,
			insets = 3,
			BackpackColor = { 0, 0, 0, 1 },
			BankColor = { 0, 0, 0.5, 1 },
		},
		rightClickConfig = true,
		autoOpen = true,
		hideAnchor = false,
	},
	char = {
		collapsedSections = {
			['*'] = false,
		},
	},
	global = {
		muteBugGrabber = false,
	},
}

