-- Blox Fruits SKILL SPAM + GUI (2025 PERFECT)
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- God Mode
local function godMode()
    local char = player.Character or player.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    hum.MaxHealth = math.huge
    hum.Health = math.huge
end
godMode()
player.CharacterAdded:Connect(godMode)

-- GUI اصلی
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BloxFruitsSpamGUI"
ScreenGui.Parent = playerGui
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 250)
Frame.Position = UDim2.new(0.5, -150, 0.5, -125)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = Frame

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🔥 Blox Fruits SPAM"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = Frame

-- Toggle Button
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0.9, 0, 0, 45)
ToggleBtn.Position = UDim2.new(0.05, 0, 0, 60)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
ToggleBtn.Text = "▶️ START SPAM"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextScaled = true
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Parent = Frame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 10)
ToggleCorner.Parent = ToggleBtn

-- Type Selector
local TypeLabel = Instance.new("TextLabel")
TypeLabel.Size = UDim2.new(0.9, 0, 0, 30)
TypeLabel.Position = UDim2.new(0.05, 0, 0, 120)
TypeLabel.BackgroundTransparency = 1
TypeLabel.Text = "⚔️ نوع: Melee"
TypeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
TypeLabel.TextScaled = true
TypeLabel.Font = Enum.Font.Gotham
TypeLabel.Parent = Frame

local MeleeBtn = Instance.new("TextButton")
MeleeBtn.Size = UDim2.new(0.43, 0, 0, 35)
MeleeBtn.Position = UDim2.new(0.05, 0, 0, 160)
MeleeBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
MeleeBtn.Text = "👊 Melee"
MeleeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MeleeBtn.TextScaled = true
MeleeBtn.Font = Enum.Font.Gotham
MeleeBtn.Parent = Frame

local GunBtn = Instance.new("TextButton")
GunBtn.Size = UDim2.new(0.43, 0, 0, 35)
GunBtn.Position = UDim2.new(0.52, 0, 0, 160)
GunBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
GunBtn.Text = "🔫 Gun"
GunBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GunBtn.TextScaled = true
GunBtn.Font = Enum.Font.Gotham
GunBtn.Parent = Frame

-- Status
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(0.9, 0, 0, 30)
Status.Position = UDim2.new(0.05, 0, 0, 205)
Status.BackgroundTransparency = 1
Status.Text = "⏹️ خاموش"
Status.TextColor3 = Color3.fromRGB(255, 100, 100)
Status.TextScaled = true
Status.Font = Enum.Font.GothamSemibold
Status.Parent = Frame

-- Corners
for _, btn in pairs({MeleeBtn, GunBtn}) do
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
end

-- متغیرها
local spamActive = false
local currentType = "Melee"

-- SPAM Function
local function startSpam(type)
    spawn(function()
        while spamActive do
            -- M1 Attack
            pcall(function()
                VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,1)
                task.wait(0.01)
                VirtualInputManager:SendMouseButtonEvent(0,0,0,false,game,1)
            end)
            
            -- Z X C Keys
            for _, key in pairs({"Z", "X", "C"}) do
                pcall(function()
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode[key], false, game)
                    task.wait(0.03)
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode[key], false, game)
                end)
                task.wait(0.08)
            end
            
            task.wait(0.1)
        end
    end)
end

-- Toggle
ToggleBtn.MouseButton1Click:Connect(function()
    spamActive = not spamActive
    if spamActive then
        ToggleBtn.Text = "⏸️ STOP"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
        Status.Text = "▶️ فعال: " .. currentType
        Status.TextColor3 = Color3.fromRGB(0, 255, 0)
        startSpam(currentType)
        StarterGui:SetCore("SendNotification", {
            Title="✅"; Text=currentType.." SPAM شروع شد! M1+Z+X+C"; Duration=5
        })
    else
        ToggleBtn.Text = "▶️ START"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        Status.Text = "⏹️ خاموش"
        Status.TextColor3 = Color3.fromRGB(255, 100, 100)
        StarterGui:SetCore("SendNotification", {Title="⏹️"; Text="SPAM متوقف شد"; Duration=3})
    end
end)

-- Type Change
MeleeBtn.MouseButton1Click:Connect(function()
    currentType = "Melee"
    TypeLabel.Text = "⚔️ نوع: Melee"
    MeleeBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    GunBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
end)

GunBtn.MouseButton1Click:Connect(function()
    currentType = "Gun"
    TypeLabel.Text = "⚔️ نوع: Gun"
    GunBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    MeleeBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
end)

-- Drag GUI
local dragging = false
Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
    end
end)
Frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        Frame.Position = UDim2.new(0, Frame.Position.X.Offset + input.Delta.X, 0, Frame.Position.Y.Offset + input.Delta.Y)
    end
end)

StarterGui:SetCore("SendNotification", {
    Title="🎮"; Text="GUI لود شد! Melee/Gun انتخاب کن + START بزن"; Duration=8
})
