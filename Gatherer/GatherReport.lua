--[[
	Gatherer Addon for World of Warcraft(tm).
	Version: 4.4.1 (<%codename%>)
	Revision: $Id: GatherReport.lua 1031 2012-09-28 04:54:31Z Esamynn $

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

	Note:
		This AddOn's source code is specifically designed to work with
		World of Warcraft's interpreted AddOn system.
		You have an implicit licence to use this AddOn with these facilities
		since that is it's designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat

	Reporting and data management subsystem
--]]
Gatherer_RegisterRevision("$URL: http://svn.norganna.org/gatherer/tags/REL_4.4.1/Gatherer/GatherReport.lua $", "$Rev: 1031 $")

local THROTTLE_COUNT = 10
local THROTTLE_RATE = .25

-- indicies
local ZONE      = 1
local ID        = 2
local INDEX     = 3
local POSX      = 4
local POSY      = 5
local COUNT     = 6
local HARVESTED = 7
local INSPECTED = 8
local SOURCE    = 9
local GTYPE     = 10
local INDOORS   = 11

local _tr = Gatherer.Locale.Tr
local _trC = Gatherer.Locale.TrClient
local _trL = Gatherer.Locale.TrLocale

Gatherer.Report = {}
local private = {}
local public = Gatherer.Report

-- reference to the Astrolabe mapping library
local Astrolabe = DongleStub(Gatherer.AstrolabeVersion)

local REPORT_LINES = 30

private.frame = CreateFrame("Frame", "GathererReportFrame", UIParent)
local frame = private.frame
public.Frame = frame

function public.Show()
	Gatherer.Config.HideOptions()
	frame:Show()
	local oTop, oLeft = frame:GetTop(), frame:GetLeft()
	frame:SetClampedToScreen(true)
	local nTop, nLeft = frame:GetTop(), frame:GetLeft()
	if (oTop ~= nTop or oLeft ~= nLeft) then
		frame:ClearAllPoints()
		frame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", nLeft, nTop)
	end
	frame:SetClampedToScreen(false)
end

function public.Hide()
	frame:Hide()
end

function public.Toggle()
	if (frame:IsShown()) then
		public.Hide()
	else
		public.Show()
	end
end

function public.IsOpen()
	if (frame:IsVisible()) then return true end
	return false
end

private.needsUpdate = false
function public.NeedsUpdate(delay)
	if not delay then delay = 0.1 end
	private.needsUpdate = delay
end


frame:Hide()
local top = Gatherer.Config.GetSetting("report.top")
local left = Gatherer.Config.GetSetting("report.left")
if (top and left) then
	frame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", top,left)
else
	frame:SetPoint("CENTER", "UIParent", "CENTER")
end
frame:SetWidth(900)
frame:SetHeight(600)
frame:SetFrameStrata("DIALOG")
frame:SetToplevel(true)
frame:SetMovable(true)
frame:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 32, edgeSize = 16,
		insets = { left = 5, right = 5, top = 5, bottom = 5 }
	})
frame:SetBackdropColor(0,0,0, 0.95)
frame:SetScript("OnShow", function() public.NeedsUpdate() end)
table.insert(UISpecialFrames, "GathererReportFrame") -- make frames Esc Sensitive by default

frame.Updater = CreateFrame("Button", "", UIParent)
frame.Updater:SetScript("OnUpdate", function(self, delay) private.UpdateHandler(delay) end)

frame.Drag = CreateFrame("Button", "", frame)
frame.Drag:SetPoint("TOPLEFT", frame, "TOPLEFT", 10,-5)
frame.Drag:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -10,-5)
frame.Drag:SetHeight(22)
frame.Drag:SetNormalTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar")
frame.Drag:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar")
frame.Drag:SetScript("OnMouseDown", function() frame:StartMoving() end)
frame.Drag:SetScript("OnMouseUp", function() frame:StopMovingOrSizing() Gatherer.Config.SetSetting("report.left", frame:GetLeft()) Gatherer.Config.SetSetting("report.top", frame:GetTop()) end)
frame.Drag:SetText(_tr("REPORT_TITLE"))
frame.Drag:SetNormalFontObject("GameFontHighlightHuge")

frame.Done = CreateFrame("Button", "", frame, "OptionsButtonTemplate")
frame.Done:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 10)
frame.Done:SetScript("OnClick", function() public.Hide() end)
frame.Done:SetText(_tr("DONE"))

frame.Config = CreateFrame("Button", "", frame, "OptionsButtonTemplate")
frame.Config:SetPoint("BOTTOMLEFT", frame, "BOTTOM", 0, 10)
frame.Config:SetScript("OnClick", function() public.Hide() Gatherer.Config.Show() end)
frame.Config:SetText(_tr("LABEL_CONFIG"))
local buttonWidth = frame.Config:GetFontString():GetWidth() + 15
if ( buttonWidth > 160 ) then buttonWidth = 160 end
if ( buttonWidth < 90 ) then buttonWidth = 90 end
frame.Config:SetWidth(buttonWidth)

--Show Node Density search frame
frame.NodeSearch = CreateFrame("Button", nil, frame, "OptionsButtonTemplate")
frame.NodeSearch:SetPoint("BOTTOMRIGHT", frame, "BOTTOM", 0, 10)
frame.NodeSearch:SetScript("OnClick", function() frame:Hide() Gatherer.NodeSearch.Show() end)
frame.NodeSearch:SetText(_tr("LABEL_DENSITY_REPORT"))
buttonWidth = frame.NodeSearch:GetFontString():GetWidth() + 15
if ( buttonWidth > 160 ) then buttonWidth = 160 end
if ( buttonWidth < 90 ) then buttonWidth = 90 end
frame.NodeSearch:SetWidth(buttonWidth)

frame.SearchBox = CreateFrame("EditBox", "", frame)
frame.SearchBox:SetPoint("TOP", frame.Drag, "BOTTOM", 0, -5)
frame.SearchBox:SetPoint("LEFT", frame, "LEFT", 10, 0)
frame.SearchBox:SetPoint("RIGHT", frame, "RIGHT", -10, 0)
frame.SearchBox:SetAutoFocus(false)
frame.SearchBox:SetMultiLine(false)
frame.SearchBox:SetHeight(26)
frame.SearchBox:SetTextInsets(6,6,6,6)
frame.SearchBox:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 32, edgeSize = 16,
		insets = { left = 5, right = 5, top = 5, bottom = 5 }
	})
frame.SearchBox:SetBackdropColor(0,0,0, 0.95)
frame.SearchBox:SetFontObject("GameFontHighlight")
frame.SearchBox:SetScript("OnTextChanged", function() public.NeedsUpdate(0.5) end)
frame.SearchBox:SetScript("OnEscapePressed", public.Hide)
frame.SearchBox:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)

function private.AddText(obj, name, displayName, x, ftype)
	if (not ftype) then ftype = "GameFontHighlight" end
	if (obj.lastName) then
		local lastobj = obj[obj.lastName]
		lastobj:SetWidth(x-lastobj.left)
	end
	obj[name] = obj:CreateFontString("", "OVERLAY", ftype)
	obj[name]:SetHeight(13)
	obj[name]:SetPoint("TOPLEFT", obj, "TOPLEFT", x,0)
	obj[name]:SetJustifyH("LEFT")
	obj[name]:Show()
	obj[name].left = x
	if (ftype ~= "GameFontHighlight") then obj[name]:SetText(displayName and displayName or name)
	else obj[name]:SetText("") end
	obj.lastName = name
end

local blank = frame:CreateTexture("")
blank:SetTexture(0,0,0,0)

function private.AddTexts(obj, ftype, icon)
	if (icon) then
		private.AddText(obj, "Type", nil, 15, ftype)
		obj.Type.Icon = obj:CreateTexture("", "OVERLAY")
		obj.Type.Icon:SetPoint("TOPLEFT", obj, "TOPLEFT")
		obj.Type.Icon:SetWidth(13)
		obj.Type.Icon:SetHeight(13)
		obj.Type.Icon:SetTexture(blank)

		obj.Highlight = CreateFrame("CheckButton", "", obj)
		obj.Highlight:SetFrameLevel(obj:GetFrameLevel() - 1)
		obj.Highlight:SetPoint("TOPLEFT", 0, -1)
		obj.Highlight:SetPoint("BOTTOMRIGHT")
		obj.Highlight:SetCheckedTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar")
		obj.Highlight:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar")
		obj.Highlight:SetNormalTexture(blank)
		obj.Highlight:SetScript("OnClick", function (me)
			local pos = me.parent.pos
			if (pos) then
				local resultsData = private.results.data[pos]
				local z,n,i,x,y,s,g,indoor = resultsData[ZONE], resultsData[ID], resultsData[INDEX], resultsData[POSX], resultsData[POSY], resultsData[SOURCE], resultsData[GTYPE], resultsData[INDOORS]
				local sig = strjoin(":", z,n,i,g,tostring(indoor))
				if (private.results.mark[sig]) then
					private.results.mark[sig] = nil
				else
					private.results.mark[sig] = strjoin(":", x,y)
				end
				private.UpdateResults()
			end
		end)
		obj.Highlight:Hide()
		obj.Highlight.parent = obj
	else
		private.AddText(obj, "Type", _tr("REPORT_COLUMN_HEADER_TYPE"), 0, ftype)
	end
	private.AddText(obj, "Region", _tr("REPORT_COLUMN_HEADER_REGION"), 240, ftype)
	private.AddText(obj, "X", _tr("REPORT_COLUMN_HEADER_X"), 420, ftype)
	private.AddText(obj, "Y", _tr("REPORT_COLUMN_HEADER_Y"), 460, ftype)
	private.AddText(obj, "Dist", _tr("REPORT_COLUMN_HEADER_DIST"), 500, ftype)
	private.AddText(obj, "Source", _tr("REPORT_COLUMN_HEADER_SOURCE"), 560, ftype)
	obj.Source:SetWidth(150)
	obj:Show()
end

frame.Results = CreateFrame("Frame", "", frame)
frame.Results:SetPoint("TOPLEFT", frame.SearchBox, "BOTTOMLEFT", 0, -25)
frame.Results:SetPoint("BOTTOM", frame.Done, "TOP", 0, 5)
frame.Results:SetWidth(740)
frame.Results:SetBackdrop({
	bgFile = "Interface/Tooltips/UI-Tooltip-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = true, tileSize = 32, edgeSize = 16,
	insets = { left = 5, right = 5, top = 5, bottom = 5 }
})
frame.Results:SetBackdropColor(0,0,0, 0.65)


frame.Results.Scroll = CreateFrame("ScrollFrame", "GathererResultsScroll", frame.Results, "FauxScrollFrameTemplate")
frame.Results.Scroll:SetPoint("TOPLEFT", frame.Results, "TOPLEFT", 0, -5)
frame.Results.Scroll:SetPoint("BOTTOMRIGHT", frame.Results, "BOTTOMRIGHT", -27, 5)
do
	local function ScrollUpdate()
		private.UpdateResults()
	end
	frame.Results.Scroll:SetScript("OnVerticalScroll", function ( self, offset )
		FauxScrollFrame_OnVerticalScroll(self, offset, 16, ScrollUpdate)
	end)
	frame.Results.Scroll:SetScript("OnShow", ScrollUpdate)
end

frame.Results.Header = CreateFrame("Frame", "", frame)
frame.Results.Header:SetPoint("TOPLEFT", frame.Results, "TOPLEFT", 10, -5)
frame.Results.Header:SetPoint("RIGHT", frame.Results, "RIGHT")
frame.Results.Header:SetHeight(18)
private.AddTexts(frame.Results.Header, "GameFontNormalLarge")

for i=1, REPORT_LINES do
	local result = CreateFrame("Frame", "", frame)
	frame.Results[i] = result
	if (i>1) then
		result:SetPoint("TOPLEFT", frame.Results[i-1], "BOTTOMLEFT")
	else
		result:SetPoint("TOPLEFT", frame.Results.Header, "BOTTOMLEFT")
	end
	result:SetPoint("RIGHT", frame.Results.Scroll, "RIGHT", -24)
	result:SetHeight(15)
	result:Show()
	private.AddTexts(result, nil, true)
end

frame.Actions = CreateFrame("Frame", "", frame)
frame.Actions:SetPoint("TOPLEFT", frame.Results, "TOPRIGHT", 5, 0)
frame.Actions:SetPoint("BOTTOM", frame.Results, "BOTTOM")
frame.Actions:SetPoint("RIGHT", frame, "RIGHT", -10, 0)

frame.Actions.SelectAll = CreateFrame("Button", "", frame.Actions, "OptionsButtonTemplate")
frame.Actions.SelectAll:SetPoint("TOPLEFT", frame.Actions, "TOPLEFT")
frame.Actions.SelectAll:SetPoint("RIGHT", frame.Actions, "RIGHT")
frame.Actions.SelectAll:SetText(_tr("REPORT_MARK_THESE"))
frame.Actions.SelectAll:SetScript("OnClick", function (me)
	for pos = 1, private.results.size do
		local resultsData = private.results.data[pos]
		local z,n,i,x,y,s,g,indoor = resultsData[ZONE], resultsData[ID], resultsData[INDEX], resultsData[POSX], resultsData[POSY], resultsData[SOURCE], resultsData[GTYPE], resultsData[INDOORS]
		local sig = strjoin(":", z,n,i,g,tostring(indoor))
		private.results.mark[sig] = strjoin(":", x,y)
	end
	private.UpdateResults()
end)

frame.Actions.SelectNone = CreateFrame("Button", "", frame.Actions, "OptionsButtonTemplate")
frame.Actions.SelectNone:SetPoint("TOPLEFT", frame.Actions.SelectAll, "BOTTOMLEFT")
frame.Actions.SelectNone:SetPoint("RIGHT", frame.Actions, "RIGHT")
frame.Actions.SelectNone:SetText(_tr("REPORT_UNMARK_THESE"))
frame.Actions.SelectNone:SetScript("OnClick", function (me)
	for pos = 1, private.results.size do
		local resultsData = private.results.data[pos]
		local z,n,i,x,y,s,g,indoor = resultsData[ZONE], resultsData[ID], resultsData[INDEX], resultsData[POSX], resultsData[POSY], resultsData[SOURCE], resultsData[GTYPE], resultsData[INDOORS]
		local sig = strjoin(":", z,n,i,g,tostring(indoor))
		private.results.mark[sig] = nil
	end
	private.UpdateResults()
end)

frame.Actions.SelectClear = CreateFrame("Button", "", frame.Actions, "OptionsButtonTemplate")
frame.Actions.SelectClear:SetPoint("TOPLEFT", frame.Actions.SelectNone, "BOTTOMLEFT", 0, -10)
frame.Actions.SelectClear:SetPoint("RIGHT", frame.Actions, "RIGHT")
frame.Actions.SelectClear:SetText(_tr("REPORT_UNMARK_ALL"))
frame.Actions.SelectClear:SetScript("OnClick", function (me)
	for sig, data in pairs(private.results.mark) do
		private.results.mark[sig] = nil
	end
	private.UpdateResults()
end)


frame.Actions.SelectCount = frame.Actions:CreateFontString("", "OVERLAY", "GameFontHighlight")
frame.Actions.SelectCount:SetPoint("TOPLEFT", frame.Actions.SelectClear, "BOTTOMLEFT", 0, 0)
frame.Actions.SelectCount:SetPoint("RIGHT", frame.Actions, "RIGHT")
frame.Actions.SelectCount:SetHeight(16)
frame.Actions.SelectCount:SetText(_tr("REPORT_MARKED_NODES_COUNT", 0))

frame.Actions.SendEdit = CreateFrame("EditBox", "", frame)
frame.Actions.SendEdit:SetPoint("TOPLEFT", frame.Actions.SelectCount, "BOTTOMLEFT", 0, -10)
frame.Actions.SendEdit:SetPoint("RIGHT", frame.Actions, "RIGHT")
frame.Actions.SendEdit.Uninitialized = true
frame.Actions.SendEdit:SetText(_tr("PLAYER"))
frame.Actions.SendEdit:SetTextColor(0.5, 0.5, 0.5)
frame.Actions.SendEdit:SetAutoFocus(false)
frame.Actions.SendEdit:SetMultiLine(false)
frame.Actions.SendEdit:SetHeight(26)
frame.Actions.SendEdit:SetTextInsets(6,6,6,6)
frame.Actions.SendEdit:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true, tileSize = 32, edgeSize = 16,
		insets = { left = 5, right = 5, top = 5, bottom = 5 }
	})
frame.Actions.SendEdit:SetBackdropColor(0,0,0, 0.95)
frame.Actions.SendEdit:SetFontObject("GameFontHighlight")
frame.Actions.SendEdit:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
frame.Actions.SendEdit:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
frame.Actions.SendEdit:SetScript("OnEditFocusGained", function(self)
	if (self.Uninitialized) then
		self:SetTextColor(1,1,1)
		self:SetText("")
		self.Uninitialized = false
	end
end)

StaticPopupDialogs["GATHERER_REPORT_TRANSMIT"] = {
	text = _trL("MASS_SHARING_GATHERER_REPORT_TRANSMIT"),
	button1 = _trL("YES"),
	button2 = _trL("NO"),
	OnAccept = function()
		local dialog = StaticPopupDialogs["GATHERER_REPORT_TRANSMIT"]
		Gatherer.Report.ConfirmNodeTransmit(dialog.who, dialog.howmany)
	end,
	timeout = 0,
	whileDead = 1,
	exclusive = 1,
	showAlert = 1,
	hideOnEscape = 1
};

function public.ConfirmNodeTransmit(who, howmany)
	howmany = tonumber(howmany) or 0
	if (who and howmany > 0) then
		SendAddonMessage("Gatherer", ("SENDNODES:OFFER:%d"):format(howmany), "WHISPER", who)
		private.sendingTo = who:lower()
	end
end

frame.Actions.SendSelected = CreateFrame("Button", "", frame.Actions, "OptionsButtonTemplate")
frame.Actions.SendSelected:SetPoint("TOPLEFT", frame.Actions.SendEdit, "BOTTOMLEFT", 0, 3)
frame.Actions.SendSelected:SetPoint("RIGHT", frame.Actions, "RIGHT")
frame.Actions.SendSelected:SetText(_tr("REPORT_SEND_MARKED"))
frame.Actions.SendSelected:SetScript("OnClick", function (me)
	local who = frame.Actions.SendEdit:GetText()
	if (who and who ~= "" and not frame.Actions.SendEdit.Uninitialized) then
		StaticPopupDialogs["GATHERER_REPORT_TRANSMIT"].howmany = me.count
		StaticPopupDialogs["GATHERER_REPORT_TRANSMIT"].who = who
		StaticPopup_Show("GATHERER_REPORT_TRANSMIT", me.count, who)
	end
end)
frame.Actions.SendSelected:Disable()

local tip = {}
local function setStatus(status, noTip)
	frame.Actions.SendStatus:SetText(status)
	if (noTip == true) then return end
	while #tip > 25 do table.remove(tip, 1) end
	table.insert(tip, status)
	frame.Actions.MarkTip:SetText(strjoin("\n", unpack(tip)))
end
frame.Actions.SendStatus = frame.Actions:CreateFontString("", "OVERLAY", "GameFontHighlight")
frame.Actions.SendStatus:SetPoint("TOPLEFT", frame.Actions.SendSelected, "BOTTOMLEFT", 0, 2)
frame.Actions.SendStatus:SetPoint("RIGHT", frame.Actions, "RIGHT")
frame.Actions.SendStatus:SetHeight(16)
frame.Actions.SendStatus:SetTextColor(0.3, 0.5, 1.0)
frame.Actions.SendStatus:SetText("")


StaticPopupDialogs["GATHERER_REPORT_DELETE"] = {
	text = _trL("REPORT_DELETE_CONFIRMATION"),
	button1 = _trL("YES"),
	button2 = _trL("NO"),
	OnAccept = function()
		Gatherer.Report.ConfirmNodeDeletes();
	end,
	timeout = 0,
	whileDead = 1,
	exclusive = 1,
	showAlert = 1,
	hideOnEscape = 1
};


function public.ConfirmNodeDeletes()
	local deleteList = {}
	for sig, data in pairs(private.results.mark) do
		local z,n,i,g,indoor = strsplit(":", sig)
		local x,y = strsplit(":", data)
		z=tonumber(z) or z; n=tonumber(n)or n; i=tonumber(i); x=tonumber(x); y=tonumber(y); indoor=(indoor=="true") and true or false
		local px, py = Gatherer.Storage.GetNodeInfo(z,g,i)
		if (px and py and math.abs(x-px)<0.001 and math.abs(y-py)<0.001) then
			-- This node is in the correct location
			table.insert(deleteList, { z,n,g,i })
		end
	end

	table.sort(deleteList, function(a,b)
		return a[4] > b[4]
	end)

	for i = 1, #deleteList do
		Gatherer.Storage.RemoveGatherFromNode(unpack(deleteList[i]))
	end
end

frame.Actions.DeleteSelected = CreateFrame("Button", "", frame.Actions, "OptionsButtonTemplate")
frame.Actions.DeleteSelected:SetPoint("TOPLEFT", frame.Actions.SendSelected, "BOTTOMLEFT", 0, -14)
frame.Actions.DeleteSelected:SetPoint("RIGHT", frame.Actions, "RIGHT")
frame.Actions.DeleteSelected:SetText(_tr("REPORT_DELETE_MARKED"))
frame.Actions.DeleteSelected:SetScript("OnClick", function (me)
	StaticPopup_Show("GATHERER_REPORT_DELETE", me.count)
end)
frame.Actions.DeleteSelected:Disable()

frame.Actions.MarkTip = frame.Actions:CreateFontString("", "OVERLAY", "GameFontNormalSmall")
frame.Actions.MarkTip:SetPoint("TOPLEFT", frame.Actions.DeleteSelected, "BOTTOMLEFT", 0, -20)
frame.Actions.MarkTip:SetPoint("RIGHT", frame.Actions)
frame.Actions.MarkTip:SetPoint("BOTTOM", frame.Actions)
frame.Actions.MarkTip:SetJustifyV("TOP")
frame.Actions.MarkTip:SetJustifyH("LEFT")
frame.Actions.MarkTip:SetText(_tr("REPORT_MARKING_NOTE"));

private.LastButton = nil
private.SearchButtons = {}
function public.AddButton(buttonName, filter)
	if (private.SearchButtons[buttonName]) then
		private.SearchButtons[buttonName].filter = filter
	end
	local button = CreateFrame("CheckButton", "Gatherer_ReportFilterCheckbox_"..buttonName, frame, "OptionsCheckButtonTemplate")
	if (private.LastButton) then
		button:SetPoint("LEFT", _G[private.LastButton:GetName().."Text"], "RIGHT", 5, 0)
	else
		button:SetPoint("TOPLEFT", frame.SearchBox, "BOTTOMLEFT", 0,  0)
	end
	local text = _G[button:GetName().."Text"]
	text:SetText(buttonName)
	button:SetScript("PostClick", private.SearchButtonClickHandler)
	button:SetHitRectInsets(0, -text:GetWidth(), 0, 0)

	button.filter = filter
	button:SetChecked(1)
	button.active = true

	private.SearchButtons[buttonName] = button
	private.LastButton = button
end

local function empty() return false end

private.results = {
	size = 0,
	data = {},
	mark = {}
}

function private.UpdateResults()
	local offset, pos, result
	offset = 0
	if private.results.size < REPORT_LINES then
		frame.Results.Scroll:Hide()
	else
		frame.Results.Scroll:Show()
		FauxScrollFrame_Update(frame.Results.Scroll, private.results.size, REPORT_LINES, 16)
		offset = FauxScrollFrame_GetOffset(frame.Results.Scroll)
	end
	for line = 1, REPORT_LINES do
		local result = frame.Results[line]
		pos = offset + line
		if (pos > private.results.size) then
			result.Type:SetText("")
			result.Region:SetText("")
			result.X:SetText("")
			result.Y:SetText("")
			result.Dist:SetText("")
			result.Source:SetText("")
			result.Type.Icon:SetTexture(blank)
			result.Highlight:SetChecked(false)
			result.Highlight:Hide()
		else
			local resultsData = private.results.data[pos]
			local z,n,i,x,y,s,g,indoor = resultsData[ZONE], resultsData[ID], resultsData[INDEX], resultsData[POSX], resultsData[POSY], resultsData[SOURCE], resultsData[GTYPE], resultsData[INDOORS]
			local mapID, mapFloor = Gatherer.ZoneTokens.GetZoneMapIDAndFloor(z)
			local d = Astrolabe:ComputeDistance(mapID, mapFloor,x,y, Astrolabe:GetCurrentPlayerPosition())
			local t = Gatherer.Util.GetGatherTexture(n)
			result.Type:SetText(Gatherer.Util.GetNodeName(n))
			result.Region:SetText(Gatherer.ZoneTokens.ZoneNames[z])
			result.X:SetText(string.format("%0.01f", x*100))
			result.Y:SetText(string.format("%0.01f", y*100))
			result.Dist:SetText(d and string.format("%d", d) or "∞")
			result.Source:SetText(s)
			result.Type.Icon:SetTexture(t)
			if (private.results.mark[strjoin(":", z,n,i,g,tostring(indoor))]) then
				result.Highlight:SetChecked(true)
			else
				result.Highlight:SetChecked(false)
			end
			result.Highlight:Show()
			result.pos = pos
		end
	end

	local markcount = 0
	for sig,loc in pairs(private.results.mark) do
		local z,n,i,g,indoor = strsplit(":", sig)
		local x,y = strsplit(":", loc)
		z=tonumber(z) or z; n=tonumber(n)or n; i=tonumber(i); x=tonumber(x); y=tonumber(y); indoor=(indoor=="true") and true or false
		local px, py = Gatherer.Storage.GetNodeInfo(z, g, i)
		if (px and py and math.abs(x-px)<0.001 and math.abs(y-py)<0.001) then
			markcount = markcount + 1
		else
			private.results.mark[sig] = nil
		end
	end
	
	if (markcount > 0) then
		frame.Actions.SendSelected:Enable()
		frame.Actions.DeleteSelected:Enable()
	else
		frame.Actions.SendSelected:Disable()
		frame.Actions.DeleteSelected:Disable()
	end
	frame.Actions.SendSelected.count = markcount
	frame.Actions.DeleteSelected.count = markcount
		
	frame.Actions.SelectCount:SetText(_tr("REPORT_MARKED_NODES_COUNT", markcount))
end

function GathererResultsScroll()
	private.UpdateResults()
end

local function filter(searchString, ...)
	local show = false
	local f, s, var = string.gmatch(searchString, "%S+")
	while true do
		local match = f(s, var)
		var = match
		if ( var == nil ) then
			break
		end
		
		local firstChar = match:sub(1, 1)
		local mustMatch, mustNotMatch = false, false
		if ( firstChar == '+' ) then
			mustMatch = true
			match = match:sub(2)
		elseif ( firstChar == '-' ) then
			mustNotMatch = true
			match = match:sub(2)
		end
		
		if ( match:sub(1, 1) == '"' ) then
			local nextToken = f(s, var)
			while ( nextToken ) do
				match = match .. " " .. nextToken
				if ( nextToken:sub(-1) == '"' ) then
					break
				end
				nextToken = f(s, var)
			end
			match = match:sub(2, #match - 1)
		end
		
		local tokenShow = false
		for filterName, button in pairs(private.SearchButtons) do
			if ( button.active and button.filter(match, ...) ) then
				if ( mustNotMatch ) then
					return false
				end
				show = true
				tokenShow = true
				break
			end
		end
		if ( mustMatch and not tokenShow ) then
			return false
		end
	end
	return show
end

function public.UpdateDisplay()
	local parameter = frame.SearchBox:GetText() or ""
	
	private.results.size = 0
	local storage = Gatherer.Storage
	for i, zone in storage.GetAreaIndices() do
		for _, gType in pairs(Gatherer.Constants.SupportedGatherTypes) do
			for index, posX, posY, inspected, indoors in storage.ZoneGatherNodes(zone, gType) do
				for _, id, count, harvested, source in storage.GetNodeGatherNames(zone, gType, index) do
					if (source == "REQUIRE") then source = _tr("NOTE_UNSKILLED")
					elseif (source == "IMPORTED") then source = _tr("NOTE_IMPORTED")
					elseif (not source) then source = ""
					end
					
					if ( (parameter == "") or filter(parameter, zone, id, index, posX, posY, count, harvested, inspected, source, gType) ) then
						local size = private.results.size + 1
						if not private.results.data[size] then private.results.data[size] = {[1]=1,[2]=2,[3]=3,[4]=4,[5]=5,[6]=6,[7]=7,[8]=8,[9]=9,[10]=10,[11]=11} end
						local data = private.results.data[size]
						data[ZONE]  = zone
						data[ID]  = id
						data[INDEX]  = index
						data[POSX]  = posX
						data[POSY]  = posY
						data[COUNT]  = count
						data[HARVESTED]  = harvested
						data[INSPECTED]  = inspected
						data[SOURCE] = source
						data[GTYPE] = gType
						data[INDOORS] = indoors
						private.results.size = size
					end
				end
			end
		end
	end
	private.needsUpdate = false
	private.UpdateResults()
end

function private.SearchButtonClickHandler(button)
	if ( button:GetChecked() ) then
		button.active = true
	else
		button.active = false
	end
	public.NeedsUpdate()
end

local checkUpdate = 0
function private.UpdateHandler(delay)
	if frame:IsVisible() and private.needsUpdate then
		private.needsUpdate = private.needsUpdate - delay
		if private.needsUpdate < 0 then
			private.needsUpdate = false
			public.UpdateDisplay()
		end
	end
	checkUpdate = checkUpdate + delay
	if (checkUpdate > THROTTLE_RATE) then
		private.SendNodes()
		checkUpdate = 0
	end
end

private.queue = {}
function public.SendFeedback(who, action, result)
	if not who then return end

	if (private.sendingTo and who:lower() == private.sendingTo) then
		if (action == "PROMPT") then
			setStatus(_tr("MASS_SHARING_ASKING"))
		elseif (action == "ACCEPT") then
			setStatus(_tr("MASS_SHARING_SENDING"))
			local list = {}
			for sig, data in pairs(private.results.mark) do
				table.insert(list, sig..":"..data)
			end
			table.insert(private.queue, { to = who, list = list, pos = 1 })
		elseif (action == "REJECT") then
			setStatus(_tr("MASS_SHARING_REJECT"))
		elseif (action == "TIMEOUT") then
			setStatus(_tr("MASS_SHARING_TIMEOUT"))
		elseif (action == "BUSY") then
			setStatus(_tr("MASS_SHARING_BUSY"))
		elseif (action == "CLOSED") then
			setStatus(_tr("MASS_SHARING_CLOSED"))
		elseif (action == "COMPLETE") then
			setStatus(_tr("MASS_SHARING_COMPLETE"))
		elseif (action == "CONTINUE") then
			if (private.queue and private.queue[1] and private.queue[1].paused) then
				private.queue[1].paused = nil
			end
		end
	end
	if (private.recvFrom and who:lower() == private.recvFrom:lower()) then
		if (action == "RECV") then
			setStatus(_tr("MASS_SHARING_RECEIVED_COUNT", private.recvCount), true)
			private.recvCount = private.recvCount + 1
		elseif (action == "DONE") then
			setStatus(_tr("MASS_SHARING_DONE", private.recvCount))
			private.recvFrom = nil
			private.recvCount = 0
		elseif (action == "ABORTED") then
			setStatus(_tr("MASS_SHARING_ABORTED", private.recvCount))
			private.recvFrom = nil
			private.recvCount = 0
		end
		private.UpdateResults()
	end
	if (action == "ACCEPTED") then
		setStatus(_tr("MASS_SHARING_ACCEPTED"))
		private.recvFrom = who
		private.recvCount = 0
	end
end


function private.SendNodes()
	if (private.queue and private.queue[1]) then
		local q = private.queue[1]
		local who = q.to
		if (q.paused) then 
			if (time() - q.paused > 30) then
				table.remove(private.queue, 1)
				SendAddonMessage("Gatherer", "SENDNODES:ABORTED", "WHISPER", who)
				setStatus(_tr("MASS_SHARING_ABORT"))
			end
			return
		end
		local size = #(q.list)
		local start = q.pos
		local limit = math.min(size,start+THROTTLE_COUNT)
		for pos=start, limit do
			local z,n,i,g,indoor,x,y = strsplit(":", q.list[pos])
			z=tonumber(z) or z; n=tonumber(n)or n; i=tonumber(i); x=tonumber(x); y=tonumber(y); indoor=(indoor=="true") and true or false
			local t = Gatherer.ZoneTokens.GetZoneToken(z)
			local px, py = Gatherer.Storage.GetNodeInfo(z,g,i)
			if (px and py and math.abs(x-px)<0.001 and math.abs(y-py)<0.001) then
				-- This node is in the correct location
				Gatherer.Comm.SendMsg("WHISPER", who, n, g, indoor, z, x, y)
			end
			setStatus(_tr("MASS_SHARING_SENT", pos-1), true)
			q.pos = pos
		end
		if (limit == size) then
			table.remove(private.queue, 1)
			SendAddonMessage("Gatherer", "SENDNODES:DONE", "WHISPER", who)
		else
			SendAddonMessage("Gatherer", "SENDNODES:PAUSE", "WHISPER", who)
			q.paused = time()
		end
	end
end
