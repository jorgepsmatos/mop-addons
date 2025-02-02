--[[--------------------------------------------------------------------
    Copyright (C) 2012 Sidoine De Wispelaere.
    Copyright (C) 2012, 2013, 2014 Johnny C. Lam.
    See the file LICENSE.txt for copying permission.
--]]--------------------------------------------------------------------

-- Keep data about the player action bars (key bindings mostly)
local _, Ovale = ...
local OvaleActionBar = Ovale:NewModule("OvaleActionBar", "AceEvent-3.0")
Ovale.OvaleActionBar = OvaleActionBar

--<private-static-properties>
-- Profiling set-up.
local Profiler = Ovale.Profiler
local profiler = nil
do
	local group = OvaleActionBar:GetName()
	Profiler:RegisterProfilingGroup(group)
	profiler = Profiler:GetProfilingGroup(group)
end

local gsub = string.gsub
local strmatch = string.match
local tonumber = tonumber
local wipe = table.wipe
local API_GetActionInfo = GetActionInfo
local API_GetActionText = GetActionText
local API_GetBindingKey = GetBindingKey
local API_GetBonusBarIndex = GetBonusBarIndex
local API_GetMacroItem = GetMacroItem
local API_GetMacroSpell = GetMacroSpell

local OVALE_ACTIONBAR_DEBUG = "action_bar"
--</private-static-properties>

--<public-static-properties>
-- Maps each action slot (1..120) to the current action: action[slot] = action
OvaleActionBar.action = {}
-- Maps each action slot (1..120) to its current keybind: keybind[slot] = keybind
OvaleActionBar.keybind = {}

-- Maps each spell/macro/item ID to its current action slot.
-- spell[spellId] = slot
OvaleActionBar.spell = {}
-- macro[macroName] = slot
OvaleActionBar.macro = {}
-- item[itemId] = slot
OvaleActionBar.item = {}
--</public-static-properties>

--<private-static-methods>
local function GetKeyBinding(slot)
	--[[
		ACTIONBUTTON1..12			=> primary (1..12, 13..24), bonus (73..120)
		MULTIACTIONBAR1BUTTON1..12	=> bottom left (61..72)
		MULTIACTIONBAR2BUTTON1..12	=> bottom right (49..60)
		MULTIACTIONBAR3BUTTON1..12	=> top right (25..36)
		MULTIACTIONBAR4BUTTON1..12	=> top left (37..48)
	--]]
	local name
	if slot <= 24 or slot > 72 then
		name = "ACTIONBUTTON" .. (((slot - 1)%12) + 1)
	elseif slot <= 36 then
		name = "MULTIACTIONBAR3BUTTON" .. (slot - 24)
	elseif slot <= 48 then
		name = "MULTIACTIONBAR4BUTTON" .. (slot - 36)
	elseif slot <= 60 then
		name = "MULTIACTIONBAR2BUTTON" .. (slot - 48)
	else
		name = "MULTIACTIONBAR1BUTTON" .. (slot - 60)
	end
	local key = name and API_GetBindingKey(name)
	return key
end

local function ParseHyperlink(hyperlink)
	local color, linkType, linkData, text = strmatch(hyperlink, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
	return color, linkType, linkData, text
end
--</private-static-methods>

--<public-static-methods>
function OvaleActionBar:OnEnable()
	self:RegisterEvent("ACTIONBAR_SLOT_CHANGED")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateActionSlots")
	self:RegisterEvent("UPDATE_BINDINGS")
	self:RegisterEvent("UPDATE_BONUS_ACTIONBAR", "UpdateActionSlots")
	self:RegisterMessage("Ovale_StanceChanged", "UpdateActionSlots")
	self:RegisterMessage("Ovale_TalentsChanged", "UpdateActionSlots")
end
	
function OvaleActionBar:OnDisable()
	self:UnregisterEvent("ACTIONBAR_SLOT_CHANGED")
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	self:UnregisterEvent("UPDATE_BINDINGS")
	self:UnregisterEvent("UPDATE_BONUS_ACTIONBAR")
	self:UnregisterMessage("Ovale_StanceChanged")
	self:UnregisterMessage("Ovale_TalentsChanged")
end

function OvaleActionBar:ACTIONBAR_SLOT_CHANGED(event, slot)
	slot = tonumber(slot)
	if slot == 0 then
		self:UpdateActionSlots(event)
	elseif slot then
		self:UpdateActionSlot(slot)
	end
end

function OvaleActionBar:UPDATE_BINDINGS(event)
	Ovale:DebugPrintf(OVALE_ACTIONBAR_DEBUG, "%s: Updating key bindings.", event)
	self:UpdateKeyBindings()
end

function OvaleActionBar:UpdateActionSlots(event)
	profiler.Start("OvaleActionBar_UpdateActionSlots")
	Ovale:DebugPrintf(OVALE_ACTIONBAR_DEBUG, "%s: Updating all action slot mappings.", event)
	wipe(self.action)
	wipe(self.item)
	wipe(self.macro)
	wipe(self.spell)

	local start = 1
	local bonus = tonumber(API_GetBonusBarIndex()) * 12
	if bonus > 0 then
		start = 13
		for slot = bonus - 11, bonus do
			self:UpdateActionSlot(slot)
		end
	end
	for slot = start, 72 do
		self:UpdateActionSlot(slot)
	end
	profiler.Stop("OvaleActionBar_UpdateActionSlots")
end

function OvaleActionBar:UpdateActionSlot(slot)
	profiler.Start("OvaleActionBar_UpdateActionSlot")
	-- Clear old slot and associated actions.
	local action = self.action[slot]
	if self.spell[action] == slot then
		self.spell[action] = nil
	elseif self.item[action] == slot then
		self.item[action] = nil
	elseif self.macro[action] == slot then
		self.macro[action] = nil
	end
	self.action[slot] = nil

	-- Map the current action in the slot.
	local actionType, id, subType = API_GetActionInfo(slot)
	if actionType == "spell" then
		id = tonumber(id)
		if id then
			if not self.spell[id] or slot < self.spell[id] then
				self.spell[id] = slot
			end
			self.action[slot] = id
		end
	elseif actionType == "item" then
		id = tonumber(id)
		if id then
			if not self.item[id] or slot < self.item[id] then
				self.item[id] = slot
			end
			self.action[slot] = id
		end
	elseif actionType == "macro" then
		id = tonumber(id)
		if id then
			local actionText = API_GetActionText(slot)
			if actionText then
				if not self.macro[actionText] or slot < self.macro[actionText] then
					self.macro[actionText] = slot
				end
				local _, _, spellId = API_GetMacroSpell(id)
				if spellId then
					if not self.spell[spellId] or slot < self.spell[spellId] then
						self.spell[spellId] = slot
					end
					self.action[slot] = spellId
				else
					local _, hyperlink = API_GetMacroItem(id)
					if hyperlink then
						local _, _, linkData = ParseHyperlink(hyperlink)
						local itemId = gsub(linkData, ":.*", "")
						itemId = tonumber(itemId)
						if itemId then
							if not self.item[itemId] or slot < self.item[itemId] then
								self.item[itemId] = slot
							end
							self.action[slot] = itemId
						end
					end
				end
				if not self.action[slot] then
					self.action[slot] = actionText
				end
			end
		end
	end
	Ovale:DebugPrintf(OVALE_ACTIONBAR_DEBUG, "Mapping button %s to %s", slot, self.action[slot])

	-- Update the keybind for the slot.
	self.keybind[slot] = GetKeyBinding(slot)
	profiler.Stop("OvaleActionBar_UpdateActionSlot")
end

function OvaleActionBar:UpdateKeyBindings()
	profiler.Start("OvaleActionBar_UpdateKeyBindings")
	for slot = 1, 120 do
		self.keybind[slot] = GetKeyBinding(slot)
	end
	profiler.Stop("OvaleActionBar_UpdateKeyBindings")
end

-- Get the action slot that matches a spell ID.
function OvaleActionBar:GetForSpell(spellId)
	return self.spell[spellId]
end

-- Get the action slot that matches a macro name.
function OvaleActionBar:GetForMacro(macroName)
	return self.macro[macroName]
end

-- Get the action slot that matches an item ID.
function OvaleActionBar:GetForItem(itemId)
	return self.item[itemId]
end

-- Get the keybinding for an action slot.
function OvaleActionBar:GetBinding(slot)
	return self.keybind[slot]
end
--</public-static-methods>
