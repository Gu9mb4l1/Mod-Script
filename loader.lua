-- Gumball menu
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
    main = Window:AddTab('main'),
    world = Window:AddTab('world'),
    esp = Window:AddTab('esp'),
    visuals = Window:AddTab('visuals'),
    character = Window:AddTab('character'),
    misc = Window:AddTab('misc'),
    setting = Window:AddTab('setting'),
}

for name, tab in pairs(Tabs) do
    if name ~= 'setting' then
        local group = tab:AddLeftGroupbox(name .. ' options')
        group:AddToggle(name .. 'Toggle', { Text = 'Enabled', Default = false })
        group:AddSlider(name .. 'Slider', { Text = 'Value', Default = 50, Min = 0, Max = 100, Rounding = 0 })
    end
end

local MenuGroup = Tabs.setting:AddLeftGroupbox('Menu')
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', {
    Default = 'End',
    NoUI = true,
    Text = 'Menu bind'
})
MenuGroup:AddToggle('KeybindMenu', { Text = 'Keybind Menu', Default = true })
MenuGroup:AddSlider('MenuTransparency', { Text = 'Menu Transparency', Default = 100, Min = 0, Max = 100, Suffix = '%', Rounding = 0 })
MenuGroup:AddDropdown('MenuMode', { Text = 'Menu Mode', Values = { 'Toggled', 'Hold' }, Default = 1 })
MenuGroup:AddDivider()
MenuGroup:AddLabel('Themes')
MenuGroup:AddDropdown('ThemeList', { Text = 'Theme list', Values = { 'Default', 'Abyss', 'Midnight', 'Ocean', 'Sunset' }, Default = 1 })

local NotificationsGroup = Tabs.setting:AddLeftGroupbox('Notifications')
NotificationsGroup:AddToggle('Notifications', { Text = 'Notifications', Default = true })
NotificationsGroup:AddToggle('NotificationSounds', { Text = 'Notification sounds', Default = false })
NotificationsGroup:AddToggle('ShowErrors', { Text = 'Show errors', Default = true })

local ConfigGroup = Tabs.setting:AddRightGroupbox('Configuration')
ConfigGroup:AddInput('ConfigName', { Text = 'Config name', Default = 'gumball', Placeholder = 'config' })
ConfigGroup:AddDropdown('ConfigList', { Text = 'Config list', Values = { 'default', 'assault', 'test' }, Default = 1 })
ConfigGroup:AddButton({ Text = 'Create config', Func = function() end })
ConfigGroup:AddButton({ Text = 'Load config', Func = function() end })
ConfigGroup:AddButton({ Text = 'Save config', Func = function() end })
ConfigGroup:AddButton({ Text = 'Delete config', Func = function() end })

Library.ToggleKeybind = Options.MenuKeybind
