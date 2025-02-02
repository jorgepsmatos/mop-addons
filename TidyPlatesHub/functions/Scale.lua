

local AddonName, HubData = ...;
local LocalVars = TidyPlatesHubDefaults


------------------------------------------------------------------------------
-- References
------------------------------------------------------------------------------
local InCombatLockdown = InCombatLockdown
local GetAggroCondition = TidyPlatesWidgets.GetThreatCondition
local IsTankedByAnotherTank = HubData.Functions.IsTankedByAnotherTank
local IsTankingAuraActive = HubData.Functions.IsTankingAuraActive
local IsHealer = TidyPlatesUtility.IsHealer
local UnitFilter = TidyPlatesHubFunctions.UnitFilter
local IsAuraShown = TidyPlatesWidgets.IsAuraShown

------------------------------------------------------------------------------
-- Scale
------------------------------------------------------------------------------

-- By Low Health
local function ScaleFunctionByLowHealth(unit)
	if unit.health/unit.healthmax < LocalVars.LowHealthThreshold then return LocalVars.ScaleSpotlight end
end

-- By Elite
local function ScaleFunctionByElite(unit)
	if unit.isElite then return LocalVars.ScaleSpotlight end
end

-- By Target
local function ScaleFunctionByTarget(unit)
	if unit.isTarget then return LocalVars.ScaleSpotlight end
end

-- By Threat (High) DPS Mode
local function ScaleFunctionByThreatHigh(unit)
	if InCombatLockdown() and unit.reaction ~= "FRIENDLY" then
		if unit.type == "NPC" and unit.threatValue > 1 and unit.health > 2 then return LocalVars.ScaleSpotlight end
	elseif LocalVars.ColorShowPartyAggro and unit.reaction == "FRIENDLY" then
		if GetAggroCondition(unit.rawName) then return LocalVars.ScaleSpotlight end
	end
end

-- By Threat (Low) Tank Mode
local function ScaleFunctionByThreatLow(unit)
	if InCombatLockdown() and unit.reaction ~= "FRIENDLY" then
		if  IsTankedByAnotherTank(unit) then return end
		if unit.type == "NPC" and unit.health > 2 and unit.threatValue < 2 then return LocalVars.ScaleSpotlight end
	elseif LocalVars.ColorShowPartyAggro and unit.reaction == "FRIENDLY" then
		if GetAggroCondition(unit.rawName) then return LocalVars.ScaleSpotlight end
	end
end

-- By Debuff Widget
local function ScaleFunctionByActiveDebuffs(unit, frame)
	local widget = unit.frame.widgets.DebuffWidget
	--local widget = TidyPlatesWidgets.GetAuraWidgetByGUID(unit.guid)
	if IsAuraShown(widget) then return LocalVars.ScaleSpotlight end
end

-- By Enemy
local function ScaleFunctionByEnemy(unit)
	if unit.reaction ~= "FRIENDLY" then return LocalVars.ScaleSpotlight end
end

-- By NPC
local function ScaleFunctionByNPC(unit)
	if unit.type == "NPC" then return LocalVars.ScaleSpotlight end
end

-- By Raid Icon
local function ScaleFunctionByRaidIcon(unit)
	if unit.isMarked then return LocalVars.ScaleSpotlight end
end

-- By Enemy Healer
local function ScaleFunctionByEnemyHealer(unit)
	if unit.reaction == "HOSTILE" and unit.type == "PLAYER" then
		--if TidyPlatesCache and TidyPlatesCache.HealerListByName[unit.rawName] then
		if IsHealer(unit.rawName) then
			return LocalVars.ScaleSpotlight
		end
	end
end

-- By Boss
local function ScaleFunctionByBoss(unit)
	if unit.isBoss and unit.isElite then return LocalVars.ScaleSpotlight end
end

-- By Threat (Auto Detect)
local function ScaleFunctionByThreat(unit)
		if (LocalVars.ThreatMode == THREATMODE_AUTO and IsTankingAuraActive())
			or LocalVars.ThreatMode == THREATMODE_TANK then
				return ScaleFunctionByThreatLow(unit)	-- tank mode
		else return ScaleFunctionByThreatHigh(unit) end

end

-- Function List
--local ScaleFunctionsDamage = { DummyFunction, ScaleFunctionByElite, ScaleFunctionByTarget, ScaleFunctionByThreatHigh, ScaleFunctionByActiveDebuffs, ScaleFunctionByEnemy,ScaleFunctionByNPC, ScaleFunctionByRaidIcon, ScaleFunctionByEnemyHealer, ScaleFunctionByThreatAutoDetect}

--local ScaleFunctionsTank = { DummyFunction, ScaleFunctionByElite, ScaleFunctionByTarget, ScaleFunctionByThreatLow, ScaleFunctionByActiveDebuffs, ScaleFunctionByEnemy, ScaleFunctionByNPC, ScaleFunctionByRaidIcon, ScaleFunctionByThreatAutoDetect}

local ScaleFunctionsUniversal = { DummyFunction, ScaleFunctionByElite, ScaleFunctionByThreat,
		ScaleFunctionByEnemy,ScaleFunctionByNPC, ScaleFunctionByRaidIcon,
		ScaleFunctionByEnemyHealer, ScaleFunctionByLowHealth, ScaleFunctionByBoss}


-- Scale Functions Listed by Role order: Damage, Tank, Heal
-- local ScaleFunctions = {ScaleFunctionsDamage, ScaleFunctionsTank}

local function ScaleDelegate(...)
	local unit = ...
	local scale

	if LocalVars.UnitSpotlightScaleEnable and LocalVars.UnitSpotlightLookup[unit.name] then
		return LocalVars.UnitSpotlightScale
	end

	if LocalVars.ScaleTargetSpotlight and unit.isTarget then scale = LocalVars.ScaleSpotlight
	elseif LocalVars.ScaleIgnoreNonEliteUnits and (not unit.isElite) then
	elseif LocalVars.ScaleIgnoreNeutralUnits and unit.reaction == "NEUTRAL" then
	elseif LocalVars.ScaleIgnoreInactive and not ( (unit.health < unit.healthmax) or (unit.isInCombat or unit.threatValue > 0) or (unit.isCasting == true) ) then
	elseif LocalVars.ScaleCastingSpotlight and unit.reaction == "HOSTILE" and unit.isCasting then scale = LocalVars.ScaleSpotlight
	elseif LocalVars.ScaleMiniMobs and unit.isMini then
		scale = MiniMobScale
	else
		-- Filter
		if (LocalVars.FilterScaleLock or (not unit.isTarget)) and UnitFilter(unit) then scale = LocalVars.ScaleFiltered
		else
			local func = ScaleFunctionsUniversal[LocalVars.ScaleSpotlightMode] or DummyFunction
			scale = func(...)
		end
	end

	return scale or LocalVars.ScaleStandard
end

------------------------------------------------------------------------------
-- Local Variable
------------------------------------------------------------------------------

local function OnVariableChange(vars)
	LocalVars = vars
	if ScaleFunctionsUniversal[LocalVars.ScaleSpotlightMode] == ScaleFunctionByThreat then
		SetCVar("threatWarning", 3)
	end

end
HubData.RegisterCallback(OnVariableChange)


------------------------------------------------------------------------------
-- Add References
------------------------------------------------------------------------------
TidyPlatesHubFunctions.SetScale = ScaleDelegate

