-- GitHub-ready Gumball menu for Roblox Rivals
-- This file is meant to be uploaded to GitHub and loaded through a raw URL.

local REQUIRED_GAME = 'rivals'

if not game or not game:GetService then
    return
end

local gameName = tostring(game.Name or ''):lower()
local placeName = tostring(game.PlaceName or ''):lower()

if not (gameName:find(REQUIRED_GAME, 1, true) or placeName:find(REQUIRED_GAME, 1, true)) then
    return
end

local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'Gumball',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2,
})

local Tabs = {
    Main = Window:AddTab('Main'),
    World = Window:AddTab('World'),
    ESP = Window:AddTab('ESP'),
    Visuals = Window:AddTab('Visuals'),
    Character = Window:AddTab('Character'),
    Misc = Window:AddTab('Misc'),
    Settings = Window:AddTab('Settings'),
}

local function makePlaceholderTab(tab, section)
    local group = tab:AddLeftGroupbox(section)
    group:AddLabel(section .. ' section')
    group:AddToggle(section .. 'Enabled', {
        Text = 'Enabled',
        Default = false,
    })
end

makePlaceholderTab(Tabs.World, 'World')
makePlaceholderTab(Tabs.ESP, 'ESP')
makePlaceholderTab(Tabs.Visuals, 'Visuals')
makePlaceholderTab(Tabs.Character, 'Character')
makePlaceholderTab(Tabs.Misc, 'Misc')

local MainTabBox = Tabs.Main:AddLeftTabbox()

local AimbotTab = MainTabBox:AddTab('Aimbot')
AimbotTab:AddToggle('AimbotEnabled', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Enable aimbot for the selected target.',
})
AimbotTab:AddSlider('AimFOV', {
    Text = 'FOV',
    Default = 120,
    Min = 0,
    Max = 300,
    Rounding = 0,
    Suffix = '°',
})
AimbotTab:AddSlider('AimSmooth', {
    Text = 'Smooth',
    Default = 15,
    Min = 1,
    Max = 100,
    Rounding = 0,
})
AimbotTab:AddDropdown('AimPart', {
    Text = 'Aim Part',
    Values = { 'Head', 'HumanoidRootPart', 'Torso' },
    Default = 1,
})
AimbotTab:AddKeyPicker('AimKey', {
    Default = 'MouseButton2',
    Text = 'Aim key',
    Mode = 'Toggle',
})
AimbotTab:AddToggle('TeamCheck', {
    Text = 'Team Check',
    Default = true,
})
AimbotTab:AddToggle('VisibleCheck', {
    Text = 'Visible Check',
    Default = true,
})
AimbotTab:AddToggle('Prediction', {
    Text = 'Prediction',
    Default = false,
})
AimbotTab:AddSlider('AimHeight', {
    Text = 'Aim Height',
    Default = 0,
    Min = -20,
    Max = 20,
    Rounding = 0,
})
AimbotTab:AddDropdown('AimPriority', {
    Text = 'Priority',
    Values = { 'Nearest', 'Lowest Health', 'Closest On Screen' },
    Default = 1,
})

local SilentAimTab = MainTabBox:AddTab('Silent Aim')
SilentAimTab:AddToggle('SilentAimEnabled', {
    Text = 'Enabled',
    Default = false,
    Tooltip = 'Camera-based silent aim without visible snapping.',
})
SilentAimTab:AddSlider('SilentAimFOV', {
    Text = 'FOV',
    Default = 120,
    Min = 0,
    Max = 300,
    Rounding = 0,
    Suffix = '°',
})
SilentAimTab:AddSlider('SilentAimSmooth', {
    Text = 'Smoothness',
    Default = 20,
    Min = 1,
    Max = 100,
    Rounding = 0,
})
SilentAimTab:AddDropdown('SilentAimPart', {
    Text = 'Target Part',
    Values = { 'Head', 'HumanoidRootPart', 'Torso' },
    Default = 1,
})
SilentAimTab:AddToggle('SilentAimVisibleCheck', {
    Text = 'Visible Check',
    Default = true,
})
SilentAimTab:AddToggle('SilentAimTeamCheck', {
    Text = 'Team Check',
    Default = true,
})
SilentAimTab:AddToggle('SilentAimUsePrediction', {
    Text = 'Prediction',
    Default = false,
})
SilentAimTab:AddKeyPicker('SilentAimKey', {
    Default = 'MouseButton2',
    Text = 'Silent aim key',
    Mode = 'Toggle',
})

local RagebotTab = MainTabBox:AddTab('Ragebot')
RagebotTab:AddToggle('RagebotEnabled', {
    Text = 'Enabled',
    Default = false,
})
RagebotTab:AddSlider('RagebotFOV', {
    Text = 'FOV',
    Default = 180,
    Min = 0,
    Max = 360,
    Rounding = 0,
    Suffix = '°',
})
RagebotTab:AddDropdown('RagebotTargetPart', {
    Text = 'Target Part',
    Values = { 'Head', 'Torso', 'HumanoidRootPart' },
    Default = 1,
})
RagebotTab:AddToggle('RagebotSnap', {
    Text = 'Snap',
    Default = true,
})
RagebotTab:AddToggle('RagebotWallCheck', {
    Text = 'Wall Check',
    Default = true,
})
RagebotTab:AddToggle('RagebotTeamCheck', {
    Text = 'Team Check',
    Default = true,
})
RagebotTab:AddSlider('RagebotPriority', {
    Text = 'Priority',
    Default = 1,
    Min = 1,
    Max = 3,
    Rounding = 0,
})

local MenuGroup = Tabs.Settings:AddLeftGroupbox('Menu')
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', {
    Default = 'End',
    NoUI = true,
    Text = 'Menu bind',
})
MenuGroup:AddSlider('MenuTransparency', {
    Text = 'Menu Transparency',
    Default = 100,
    Min = 0,
    Max = 100,
    Suffix = '%',
    Rounding = 0,
})
MenuGroup:AddDropdown('MenuMode', {
    Text = 'Menu Mode',
    Values = { 'Toggle', 'Hold' },
    Default = 1,
})
MenuGroup:AddDropdown('ThemeList', {
    Text = 'Theme list',
    Values = { 'Default', 'Abyss', 'Midnight', 'Ocean', 'Sunset' },
    Default = 1,
})
MenuGroup:AddButton({
    Text = 'Set Default',
    Func = function() end,
})
MenuGroup:AddButton({
    Text = 'Refresh',
    Func = function() end,
})

local ConfigGroup = Tabs.Settings:AddRightGroupbox('Configuration')
ConfigGroup:AddInput('ConfigName', {
    Text = 'Config name',
    Default = 'gumball',
    Placeholder = 'config',
})
ConfigGroup:AddDropdown('ConfigList', {
    Text = 'Config list',
    Values = { 'default', 'assault', 'test' },
    Default = 1,
})
ConfigGroup:AddButton({
    Text = 'Create config',
    Func = function() end,
})
ConfigGroup:AddButton({
    Text = 'Load config',
    Func = function() end,
})
ConfigGroup:AddButton({
    Text = 'Save config',
    Func = function() end,
})
ConfigGroup:AddButton({
    Text = 'Delete config',
    Func = function() end,
})

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('Gumball')
SaveManager:SetFolder('Gumball')
SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)

if Library and Library.SetWatermarkVisibility then
    Library:SetWatermarkVisibility(true)
    Library:SetWatermark('Gumball | ready')
end
