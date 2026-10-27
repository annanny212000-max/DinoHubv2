
-- 🦖 DINO HUB | English Version
-- Roblox Studio > StarterPlayer > StarterPlayerScripts > LocalScript

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local GREEN = Color3.fromRGB(70, 255, 45)
local DARK = Color3.fromRGB(10, 17, 20)
local PANEL = Color3.fromRGB(20, 29, 35)
local WHITE = Color3.fromRGB(245, 250, 245)

-- Create ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "DinoHub"
gui.ResetOnSpawn = false
gui.DisplayOrder = 100
gui.Parent = playerGui

local function round(object, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 10)
    corner.Parent = object
end

local function outline(object, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = thickness or 1
    stroke.Parent = object
end

-- Floating open button
local openButton = Instance.new("TextButton")
openButton.Name = "OpenMenu"
openButton.Size = UDim2.fromOffset(90, 75)
openButton.Position = UDim2.new(0, 14, 0.5, -38)
openButton.BackgroundColor3 = DARK
openButton.Text = "DINO\nHUB"
openButton.TextColor3 = WHITE
openButton.TextSize = 17
openButton.Font = Enum.Font.GothamBold
openButton.Parent = gui
round(openButton, 14)
outline(openButton, GREEN, 2)

-- Main window
local frame = Instance.new("Frame")
frame.Name = "MainWindow"
frame.Size = UDim2.new(0.88, 0, 0, 390)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.BackgroundColor3 = DARK
frame.BorderSizePixel = 0
frame.Parent = gui
round(frame, 15)
outline(frame, GREEN, 2)

local sizeLimit = Instance.new("UISizeConstraint")
sizeLimit.MaxSize = Vector2.new(440, 520)
sizeLimit.MinSize = Vector2.new(280, 330)
sizeLimit.Parent = frame

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, -12, 0, 58)
header.Position = UDim2.fromOffset(6, 5)
header.BackgroundColor3 = PANEL
header.Parent = frame
round(header, 10)

local logo = Instance.new("TextLabel")
logo.Size = UDim2.fromOffset(52, 52)
logo.Position = UDim2.fromOffset(5, 2)
logo.BackgroundTransparency = 1
logo.Text = "D"
logo.TextColor3 = GREEN
logo.TextSize = 36
logo.Font = Enum.Font.GothamBold
logo.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -100, 0, 32)
title.Position = UDim2.fromOffset(60, 3)
title.BackgroundTransparency = 1
title.Text = "DINO HUB"
title.TextColor3 = GREEN
title.TextSize = 23
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -70, 0, 20)
subtitle.Position = UDim2.fromOffset(62, 32)
subtitle.BackgroundTransparency = 1
subtitle.Text = "DINO HUB • Game Control"
subtitle.TextColor3 = WHITE
subtitle.TextSize = 11
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = header

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.fromOffset(35, 35)
closeButton.Position = UDim2.new(1, -42, 0, 10)
closeButton.BackgroundColor3 = Color3.fromRGB(90, 35, 35)
closeButton.Text = "X"
closeButton.TextColor3 = WHITE
closeButton.TextSize = 18
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = header
round(closeButton, 8)

-- Tabs
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, -20, 0, 40)
tabBar.Position = UDim2.fromOffset(10, 70)
tabBar.BackgroundTransparency = 1
tabBar.Parent = frame

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabLayout.Padding = UDim.new(0, 5)
tabLayout.Parent = tabBar

-- Content area
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -20, 1, -155)
content.Position = UDim2.fromOffset(10, 116)
content.BackgroundColor3 = PANEL
content.Parent = frame
round(content, 10)

local pages = {}
local tabs = {}

local function makePage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name
    page.Size = UDim2.new(1, -12, 1, -12)
    page.Position = UDim2.fromOffset(6, 6)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.Visible = false
    page.Parent = content

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page

    pages[name] = page

    local tab = Instance.new("TextButton")
    tab.Size = UDim2.new(0.333, -5, 1, 0)
    tab.BackgroundColor3 = Color3.fromRGB(35, 43, 48)
    tab.Text = name
    tab.TextColor3 = WHITE
    tab.TextSize = 13
    tab.Font = Enum.Font.GothamBold
    tab.Parent = tabBar
    round(tab, 8)

    tabs[name] = tab
    return page
end

local function showPage(name)
    for pageName, page in pairs(pages) do
        page.Visible = pageName == name
        tabs[pageName].BackgroundColor3 =
            pageName == name
            and Color3.fromRGB(20, 100, 35)
            or Color3.fromRGB(35, 43, 48)
    end
end

local function addLabel(page, text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -4, 0, 35)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = WHITE
    label.TextSize = 14
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = page
    return label
end

local function addButton(page, text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -4, 0, 43)
    button.BackgroundColor3 = Color3.fromRGB(34, 48, 53)
    button.Text = text
    button.TextColor3 = WHITE
    button.TextSize = 14
    button.Font = Enum.Font.Gotham
    button.Parent = page
    round(button, 9)
    outline(button, Color3.fromRGB(35, 130, 45), 1)
    button.Activated:Connect(callback)
    return button
end

-- Create three tabs
local home = makePage("Home")
local playersPage = makePage("Players")
local settings = makePage("Settings")

for name, tab in pairs(tabs) do
    tab.Activated:Connect(function()
        showPage(name)
    end)
end

-- Home tab
addLabel(home, "Welcome to DINO HUB!")
addButton(home, "Hide Menu", function()
    frame.Visible = false
    openButton.Visible = true
end)
addLabel(home, "Select a tab above to get started.")

-- Players tab
local speed = 16

addButton(playersPage, "Increase Speed (+14)", function()
    speed = speed >= 100 and 16 or speed + 14

    local character = player.Character
    local humanoid = character
        and character:FindFirstChildOfClass("Humanoid")

    if humanoid then
        humanoid.WalkSpeed = speed
    end
end)

addButton(playersPage, "Reset Normal Speed", function()
    speed = 16

    local character = player.Character
    local humanoid = character
        and character:FindFirstChildOfClass("Humanoid")

    if humanoid then
        humanoid.WalkSpeed = 16
    end
end)

local afk = false
local afkButton

afkButton = addButton(
    playersPage,
    "AFK Status: OFF",
    function()
        afk = not afk
        afkButton.Text = afk
            and "AFK Status: ON"
            or "AFK Status: OFF"
    end
)

addLabel(playersPage, "AFK is a status indicator only.")

local autoThrow = false
local throwButton

throwButton = addButton(
    playersPage,
    "Auto Throw: OFF",
    function()
        autoThrow = not autoThrow
        throwButton.Text = autoThrow
            and "Auto Throw: ON"
            or "Auto Throw: OFF"
    end
)

addLabel(playersPage, "Auto Throw is a visual toggle only.")

-- Settings tab
local oldClock = Lighting.ClockTime
local oldBrightness = Lighting.Brightness
local night = false
local nightButton

nightButton = addButton(
    settings,
    "Night Mode: OFF",
    function()
        night = not night

        if night then
            Lighting.ClockTime = 0
            Lighting.Brightness = 0.5
        else
            Lighting.ClockTime = oldClock
            Lighting.Brightness = oldBrightness
        end

        nightButton.Text = night
            and "Night Mode: ON"
            or "Night Mode: OFF"
    end
)

addButton(settings, "Close Menu", function()
    frame.Visible = false
    openButton.Visible = true
end)

addLabel(settings, "Theme: Neon Black & Green")
addLabel(settings, "Drag the header to move the menu.")

-- Open and close menu
closeButton.Activated:Connect(function()
    frame.Visible = false
    openButton.Visible = true
end)

openButton.Activated:Connect(function()
    frame.Visible = true
    openButton.Visible = false
end)

-- Drag support for mouse and touch
local function makeDraggable(object, handle)
    local dragging = false
    local startInputPosition
    local startObjectPosition
    local activeTouch

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then

            dragging = true
            startInputPosition = input.Position
            startObjectPosition = object.Position

            if input.UserInputType == Enum.UserInputType.Touch then
                activeTouch = input
            else
                activeTouch = nil
            end

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    activeTouch = nil
                end
            end)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if not dragging then
            return
        end

        if activeTouch then
            if input ~= activeTouch then
                return
            end
        elseif input.UserInputType ~= Enum.UserInputType.MouseMovement then
            return
        end

        local delta = input.Position - startInputPosition

        object.Position = UDim2.new(
            startObjectPosition.X.Scale,
            startObjectPosition.X.Offset + delta.X,
            startObjectPosition.Y.Scale,
            startObjectPosition.Y.Offset + delta.Y
        )
    end)
end

makeDraggable(frame, header)
makeDraggable(openButton, openButton)

-- Initial state
showPage("Home")
openButton.Visible = false

print("DINO HUB loaded successfully!")
