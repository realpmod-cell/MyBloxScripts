-- Blox Fruits Auto Farm + M1 SPAM - 2025 Fixed
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid", 10)
local root = char:WaitForChild("HumanoidRootPart", 10)
local backpack = player:WaitForChild("Backpack")

-- تنظیمات
local SELECTED_TYPE = "Melee"  -- "Melee" / "Sword" / "Gun"
local FARM_DISTANCE = 4
local M1_DELAY = 0.05  -- سرعت M1

-- تابع M1 اسپم (برای همه سلاح‌ها!)
local function spamM1()
    spawn(function()
        while task.wait(M1_DELAY) do
            -- روش ۱: VirtualInput (بهترین برای Melee)
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
            task.wait(0.01)
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
            
            -- روش ۲: Tool Activate (برای Sword/Gun)
            local tool = hum:FindFirstChildOfClass("Tool")
            if tool then pcall(function() tool:Activate() end) end
        end
    end)
end

-- تجهیز سلاح
local function equipTool()
    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then
            local name = tool.Name:lower()
            if (SELECTED_TYPE == "Melee" and (name == "combat" or name:find("fist"))) or
               (SELECTED_TYPE == "Sword" and name:find("sword")) or
               (SELECTED_TYPE == "Gun" and name:find("gun")) then
                hum:EquipTool(tool)
                return tool
            end
        end
    end
    StarterGui:SetCore("SendNotification", {Title="❌"; Text="سلاح "..SELECTED_TYPE.." پیدا نشد!"; Duration=5})
    return nil
end

-- پیدا کردن NPC
local function findNPC()
    local enemiesFolder = Workspace:FindFirstChild("Enemies") or Workspace:FindFirstChild("Living")
    if not enemiesFolder then return nil end

    local closest, minDist = nil, 50
    for _, npc in pairs(enemiesFolder:GetChildren()) do
        local humanoid = npc:FindFirstChild("Humanoid")
        local rootpart = npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChild("PrimaryPart")
        if humanoid and rootpart and humanoid.Health > 0 then
            local dist = (root.Position - rootpart.Position).Magnitude
            if dist < minDist then
                minDist = dist
                closest = npc
            end
        end
    end
    return closest
end

-- شروع فارم
local tool = equipTool()
if tool and hum.Health > 0 then
    StarterGui:SetCore("SendNotification", {Title="✅"; Text=SELECTED_TYPE.." M1 Farm شروع شد!"; Duration=5})
    
    -- M1 اسپم شروع کن
    spamM1()
    
    -- لوپ اصلی
    spawn(function()
        while task.wait(0.1) do
            if hum.Health <= 0 then break end
            local target = findNPC()
            if target then
                local targetRoot = target:FindFirstChild("HumanoidRootPart") or target.PrimaryPart
                if targetRoot then
                    root.CFrame = targetRoot.CFrame * CFrame.new(0, 0, -FARM_DISTANCE)
                end
            else
                task.wait(1)  -- NPC پیدا نشد، صبر کن
            end
        end
    end)
else
    StarterGui:SetCore("SendNotification", {Title="❌"; Text="ابتدا سلاح بگیر و NPC نزدیک شو!"; Duration=5})
end
