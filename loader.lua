-- Minimal, stable Gumball menu loader.
-- This version removes risky config/theme logic and only creates the menu when LinoriaLib loads cleanly.

if not game or not game:GetService then
    return
end

local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local ok, Library = pcall(function()
    return loadstring(game:HttpGet(repo .. 'Library.lua'))()
end)

if not ok or not Library then
    warn('LinoriaLib failed to load. Check your executor and internet access.')
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
    Settings = Window:AddTab('Settings'),
}

local MainGroup = Tabs.Main:AddLeftGroupbox('Gumball')
MainGroup:AddLabel('Menu loaded successfully.')
MainGroup:AddButton({
    Text = 'Test button',
    Func = function()
        print('Gumball is working.')
    end,
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
MenuGroup:AddDropdown('ThemeList', {
    Text = 'Theme list',
    Values = { 'Default', 'Abyss', 'Midnight', 'Ocean', 'Sunset' },
    Default = 1,
})
MenuGroup:AddButton({
    Text = 'Refresh',
    Func = function() end,
})

if Library and Library.SetWatermarkVisibility then
    Library:SetWatermarkVisibility(true)
    Library:SetWatermark('Gumball | ready')
end

