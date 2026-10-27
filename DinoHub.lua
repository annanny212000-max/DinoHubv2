
local P = game:GetService("Players").LocalPlayer
local L = game:GetService("Lighting")
local U = game:GetService("UserInputService")
local G = Instance.new("ScreenGui", P:WaitForChild("PlayerGui"))
G.Name = "DinoHub"
G.ResetOnSpawn = false

local green = Color3.fromRGB(70,255,45)
local frame = Instance.new("Frame", G)
frame.Size = UDim2.fromOffset(300,330)
frame.Position = UDim2.new(.5,-150,.5,-165)
frame.BackgroundColor3 = Color3.fromRGB(10,17,20)
Instance.new("UICorner",frame).CornerRadius = UDim.new(0,14)
local stroke = Instance.new("UIStroke",frame)
stroke.Color = green
stroke.Thickness = 2

local function button(parent,text,y,fn)
    local b = Instance.new("TextButton",parent)
    b.Size = UDim2.new(1,-20,0,38)
    b.Position = UDim2.fromOffset(10,y)
    b.Text = text
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(25,38,35)
    b.TextSize = 14
    Instance.new("UICorner",b).CornerRadius = UDim.new(0,8)
    b.Activated:Connect(fn)
    return b
end

local function logo(parent,size,pos)
    local i = Instance.new("ImageLabel",parent)
    i.Size = size
    i.Position = pos
    i.BackgroundTransparency = 1
    i.ScaleType = Enum.ScaleType.Fit
    i.Image = "rbxassetid://YOUR_IMAGE_ID"
    return i
end

local header = Instance.new("TextLabel",frame)
header.Size = UDim2.new(1,-50,0,55)
header.Position = UDim2.fromOffset(48,0)
header.BackgroundTransparency = 1
header.Text = "DINO HUB"
header.TextColor3 = green
header.TextSize = 24
header.Font = Enum.Font.GothamBold

logo(frame,UDim2.fromOffset(42,42),UDim2.fromOffset(5,5))

local speed = 16
button(frame,"เพิ่มความเร็ว",65,function()
    speed = speed >= 100 and 16 or speed + 14
    local h = P.Character and P.Character:FindFirstChildOfClass("Humanoid")
    if h then h.WalkSpeed = speed end
end)

button(frame,"คืนความเร็วปกติ",109,function()
    speed = 16
    local h = P.Character and P.Character:FindFirstChildOfClass("Humanoid")
    if h then h.WalkSpeed = 16 end
end)

local oldClock,oldBrightness = L.ClockTime,L.Brightness
local night = false
local nb = button(frame,"โหมดกลางคืน: ปิด",153,function()
    night = not night
    L.ClockTime = night and 0 or oldClock
    L.Brightness = night and .5 or oldBrightness
    nb.Text = "โหมดกลางคืน: "..(night and "เปิด" or "ปิด")
end)

local afk = false
local ab = button(frame,"สถานะ AFK: ปิด",197,function()
    afk = not afk
    ab.Text = "สถานะ AFK: "..(afk and "เปิด" or "ปิด")
end)

local throwing = false
local tb = button(frame,"โยนอัตโนมัติ: ปิด",241,function()
    throwing = not throwing
    tb.Text = "โยนอัตโนมัติ: "..(throwing and "เปิด" or "ปิด")
end)

local open = Instance.new("TextButton",G)
open.Size = UDim2.fromOffset(58,58)
open.Position = UDim2.new(0,15,.5,-29)
open.Text = "🦖"
open.TextSize = 30
open.BackgroundColor3 = Color3.fromRGB(10,17,20)
open.TextColor3 = green
Instance.new("UICorner",open).CornerRadius = UDim.new(1,0)
local os = Instance.new("UIStroke",open)
os.Color = green
os.Thickness = 2
logo(open,UDim2.fromScale(1,1),UDim2.fromScale(0,0))

local close = button(frame,"ปิดเมนู",285,function()
    frame.Visible = false
    open.Visible = true
end)

open.Activated:Connect(function()
    frame.Visible = not frame.Visible
    open.Visible = not frame.Visible
end)

local drag, start, origin
header.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1
    or i.UserInputType == Enum.UserInputType.Touch then
        drag = true
        start = i.Position
        origin = frame.Position
    end
end)
U.InputChanged:Connect(function(i)
    if drag and (i.UserInputType == Enum.UserInputType.MouseMovement
    or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position-start
        frame.Position = UDim2.new(origin.X.Scale,origin.X.Offset+d.X,
            origin.Y.Scale,origin.Y.Offset+d.Y)
    end
end)
U.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1
    or i.UserInputType == Enum.UserInputType.Touch then drag = false end
end)

frame.Visible = true
open.Visible = false
