## **GUI فیکس‌شده: "در حال ساخت توسط شنکوص" اضافه شد!** 🔥

```lua
-- Blox Fruits PERFECT SPAM + TELEPORT + SKILL SELECTOR (شنکوص)
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
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

-- متغیرها
local spamActive = false
local selectedSkills = {"Z", "X", "C"}
local TELEPORT_DISTANCE = 3

-- پیدا کردن NPC
local function findNearestNPC()
    local enemies = Workspace:FindFirstChild("Enemies") or Workspace:FindFirstChild("Living")
    if not enemies then return nil end
    
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    local root = char.HumanoidRootPart
    
    local closest, minDist = nil, 50
    for _, npc in pairs(enemies:GetChildren()) do
        local hum = npc:FindFirstChild("Humanoid")
        local rootpart = npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart
        if hum and rootpart and hum.Health > 0 then
            local dist = (root.Position - rootpart.Position).Magnitude
            if dist < minDist then
                minDist = dist
                closest = npc
            end
        end
    end
    return closest
end

-- تلپورت
local function teleportToNPC()
    local target = findNearestNPC()
    if target and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local targetRoot = target.HumanoidRootPart or target.PrimaryPart
        player.Character.HumanoidRootPart.CFrame = targetRoot.CFrame * CFrame.new(0, 0, -TELEPORT_DISTANCE)
        return true
    end
    return false
end

-- SPAM
local spamConnection
local function startSpam()
    if spamConnection then spamConnection:Disconnect() end
    
    spamConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not spamActive then return end
        
        local char = player.Character
        if not char or not char:FindFirstChild("Humanoid") then return end
        
        -- M1 بی‌وقفه
        pcall(function()
            VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,1)
            task.wait(0.001)
            VirtualInputManager:SendMouseButtonEvent(0,0,0,false,game,1)
        end)
        
        -- اسکیل‌ها
        for _, skill in pairs(selectedSkills) do
            pcall(function()
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode[skill], false, game)
                task.wait(0.02)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode[skill], false, game)
            end)
            task.wait(0.1)
        end
    end)
end

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BloxFruitsUltimate"
ScreenGui.Parent = playerGui
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 350, 0, 340)  -- بزرگ‌تر برای متن جدید
Frame.Position = UDim2.new(0.5, -175, 0.5, -170)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = Frame

-- 👆 "در حال ساخت توسط شنکوص" 👆 (بالای GUI)
local CreatorLabel = Instance.new("TextLabel")
CreatorLabel.Size = UDim2.new(1, 0, 0, 30)
CreatorLabel.Position = UDim2.new(0, 0, 0, 5)
CreatorLabel.BackgroundTransparency = 1
CreatorLabel.Text = "در حال ساخت توسط شنکوص"
CreatorLabel.TextColor3 = Color3.fromRGB(255, 215, 0)  -- طلایی
CreatorLabel.TextScaled = true
CreatorLabel.Font = Enum.Font.GothamBold
CreatorLabel.Parent = Frame

-- Title (پایین Creator)
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "🚀 Blox Fruits ULTIMATE SPAM"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = Frame

-- Toggle
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0.9, 0, 0, 50)
ToggleBtn.Position = UDim2.new(0.05, 0, 0, 80)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
ToggleBtn.Text = "▶️ START SPAM + TELEPORT"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextScaled = true
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Parent = Frame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 12)
ToggleCorner.Parent = ToggleBtn

-- Skills
local SkillsLabel = Instance.new("TextLabel")
SkillsLabel.Size = UDim2.new(0.9, 0, 0, 30)
SkillsLabel.Position = UDim2.new(0.05, 0, 0, 140)
SkillsLabel.BackgroundTransparency = 1
SkillsLabel.Text = "🎯 اسکیل‌ها:"
SkillsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SkillsLabel.TextScaled = true
SkillsLabel.Font = Enum.Font.GothamSemibold
SkillsLabel.Parent = Frame

local ZBtn = Instance.new("TextButton")
ZBtn.Size = UDim2.new(0.28, 0, 0, 35)
ZBtn.Position = UDim2.new(0.05, 0, 0, 180)
ZBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
ZBtn.Text = "Z"
ZBtn.TextScaled = true
ZBtn.Parent = Frame

local XBtn = Instance.new("TextButton")
XBtn.Size = UDim2.new(0.28, 0, 0, 35)
XBtn.Position = UDim2.new(0.36, 0, 0, 180)
XBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
XBtn.Text = "X"
XBtn.TextScaled = true
XBtn.Parent = Frame

local CBtn = Instance.new("TextButton")
CBtn.Size = UDim2.new(0.28, 0, 0, 35)
CBtn.Position = UDim2.new(0.67, 0, 0, 180)
CBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
CBtn.Text = "C"
CBtn.TextScaled = true
CBtn.Parent = Frame

local AllBtn = Instance.new("TextButton")
AllBtn.Size = UDim2.new(0.9, 0, 0, 35)
AllBtn.Position = UDim2.new(0.05, 0, 0, 225)
AllBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
AllBtn.Text = "🔥 همه اسکیل‌ها"
AllBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AllBtn.TextScaled = true
AllBtn.Font = Enum.Font.GothamBold
AllBtn.Parent = Frame

-- Status
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(0.9, 0, 0, 30)
Status.Position = UDim2.new(0.05, 0, 0, 275)
Status.BackgroundTransparency = 1
Status.Text = "⏹️ خاموش | NPC: هیچ"
Status.TextColor3 = Color3.fromRGB(255, 100, 100)
Status.TextScaled = true
Status.Font = Enum.Font.Gotham
Status.Parent = Frame

-- Corners
for _, obj in pairs({ZBtn, XBtn, CBtn, AllBtn, ToggleBtn}) do
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = obj
end

-- Toggle Logic
ToggleBtn.MouseButton1Click:Connect(function()
    spamActive = not spamActive
    if spamActive then
        ToggleBtn.Text = "⏸️ STOP"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        Status.TextColor3 = Color3.fromRGB(0, 255, 0)
        startSpam()
        StarterGui:SetCore("SendNotification", {Title="✅"; Text="SPAM + TELEPORT فعال!"; Duration=5})
    else
        ToggleBtn.Text = "▶️ START SPAM + TELEPORT"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        Status.TextColor3 = Color3.fromRGB(255, 100, 100)
        if spamConnection then spamConnection:Disconnect() end
    end
end)

-- Skill Buttons
local function toggleSkill(btn, skill)
    btn.MouseButton1Click:Connect(function()
        local index = table.find(selectedSkills, skill)
        if index then
            table.remove(selectedSkills, index)
            btn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        else
            table.insert(selectedSkills, skill)
            btn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        end
        Status.Text = "⏹️ خاموش | اسکیل‌ها: " .. table.concat(selectedSkills, ", ")
    end)
end
toggleSkill(ZBtn, "Z")
toggleSkill(XBtn, "X")
toggleSkill(CBtn, "C")

AllBtn.MouseButton1Click:Connect(function()
    selectedSkills = {"Z", "X", "C"}
    ZBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    XBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    CBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    Status.Text = "⏹️ خاموش | اسکیل‌ها: Z, X, C"
end)

-- Auto Teleport + Status Update
spawn(function()
    while true do
        if spamActive then
            teleportToNPC()
            local target = findNearestNPC()
            if target then
                Status.Text = "▶️ فعال | NPC: " .. target.Name .. " | اسکیل: " .. table.concat(selectedSkills, ", ")
            else
                Status.Text = "▶️ فعال | NPC: جستجو... | اسکیل: " .. table.concat(selectedSkills, ", ")
            end
        end
        task.wait(0.5)
    end
end)

-- Drag
local dragging, dragStart, startPos
Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
    end
end)
Frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

StarterGui:SetCore("SendNotification", {Title="👑 شنکوص"; Text="GUI آماده! اسکیل انتخاب کن + START"; Duration=8})
```

---

## **تغییرات:**
- **بالای GUI**: `"در حال ساخت توسط شنکوص"` (طلایی + Bold)
- **اندازه Frame**: بزرگ‌تر شد (340px ارتفاع)
- **همه فیکس‌ها**: تلپورت 3 متری + M1 بی‌وقفه + انتخاب اسکیل

**اجرا:**
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/realpmod-cell/MyBloxScripts/main/BloxFruitsAutoFarm.lua"))()
```

**حالا GUI با اسم توئه!** 👑🚀
