local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local ok, Library = pcall(function()
    return loadstring(game:HttpGet(repo .. 'Library.lua'))()
end)

if not ok or not Library then
    warn('LinoriaLib failed to load')
    return
end

local ok2, ThemeManager = pcall(function()
    return loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
end)

local ok3, SaveManager = pcall(function()
    return loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
end)

if not ok2 or not ThemeManager then
    ThemeManager = nil
end

if not ok3 or not SaveManager then
    SaveManager = nil
end

if not game or not game:GetService then
    return
end

local REQUIRED_GAME = 'rivals'
local gameName = tostring(game.Name or ''):lower()
local placeName = tostring(game.PlaceName or ''):lower()

if not (gameName:find(REQUIRED_GAME, 1, true) or placeName:find(REQUIRED_GAME, 1, true)) then
    return
end

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
AimbotTab:AddToggle('TeamCheck', { Text = 'Team Check', Default = true })
AimbotTab:AddToggle('VisibleCheck', { Text = 'Visible Check', Default = true })
AimbotTab:AddToggle('Prediction', { Text = 'Prediction', Default = false })

local SilentAimTab = MainTabBox:AddTab('Silent Aim')
SilentAimTab:AddToggle('SilentAimEnabled', { Text = 'Enabled', Default = false })
SilentAimTab:AddSlider('SilentAimFOV', { Text = 'FOV', Default = 120, Min = 0, Max = 300, Rounding = 0, Suffix = '°' })
SilentAimTab:AddSlider('SilentAimSmooth', { Text = 'Smoothness', Default = 20, Min = 1, Max = 100, Rounding = 0 })
SilentAimTab:AddDropdown('SilentAimPart', { Text = 'Target Part', Values = { 'Head', 'HumanoidRootPart', 'Torso' }, Default = 1 })
SilentAimTab:AddToggle('SilentAimVisibleCheck', { Text = 'Visible Check', Default = true })

local RagebotTab = MainTabBox:AddTab('Ragebot')
RagebotTab:AddToggle('RagebotEnabled', { Text = 'Enabled', Default = false })
RagebotTab:AddSlider('RagebotFOV', { Text = 'FOV', Default = 180, Min = 0, Max = 360, Rounding = 0, Suffix = '°' })
RagebotTab:AddDropdown('RagebotTargetPart', { Text = 'Target Part', Values = { 'Head', 'Torso', 'HumanoidRootPart' }, Default = 1 })
RagebotTab:AddToggle('RagebotSnap', { Text = 'Snap', Default = true })

local MenuGroup = Tabs.Settings:AddLeftGroupbox('Menu')
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', {
    Default = 'End',
    NoUI = true,
    Text = 'Menu bind',
})
MenuGroup:AddSlider('MenuTransparency', { Text = 'Menu Transparency', Default = 100, Min = 0, Max = 100, Suffix = '%', Rounding = 0 })
MenuGroup:AddDropdown('MenuMode', { Text = 'Menu Mode', Values = { 'Toggle', 'Hold' }, Default = 1 })

if ThemeManager then
    ThemeManager:SetLibrary(Library)
    ThemeManager:SetFolder('Gumball')
    ThemeManager:ApplyToTab(Tabs.Settings)
end

if SaveManager then
    SaveManager:SetLibrary(Library)
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
    SaveManager:SetFolder('Gumball')
    SaveManager:BuildConfigSection(Tabs.Settings)
end

if Library and Library.SetWatermarkVisibility then
    Library:SetWatermarkVisibility(true)
    Library:SetWatermark('Gumball | ready')
end
