-- Blox Fruits Auto Farm - Fixed & Safe (2025)
-- فقط این کد رو اجرا کن، بقیه رو پاک کن!

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid", 5)
local root = char:WaitForChild("HumanoidRootPart", 5)
local backpack = player:WaitForChild("Backpack")

-- تنظیمات (اینجا نوع رو عوض کن!)
local SELECTED_TYPE = "Melee"  -- <<< "Melee" / "Sword" / "Gun"
local FARM_DISTANCE = 5
local ATTACK_DELAY = 0.1

-- تابع تجهیز سلاح
local function equipTool()
    if not backpack then return nil end
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
    StarterGui:SetCore("SendNotification", {Title="خطا"; Text="سلاح "..SELECTED_TYPE.." پیدا نشد!"; Duration=4})
    return nil
end

-- پیدا کردن NPC
local function findNPC()
    local enemiesFolder = Workspace:FindFirstChild("Enemies") or Workspace:FindFirstChild("Living")
    if not enemiesFolder then return nil end

    local closest, minDist = nil, 100
    for _, npc in pairs(enemiesFolder:GetChildren()) do
        if npc:FindFirstChild("Humanoid") and npc:FindFirstChild("HumanoidRootPart") then
            if npc.Humanoid.Health > 0 then
                local dist = (root.Position - npc.HumanoidRootPart.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    closest = npc
                end
            end
        end
    end
    return closest
end

-- شروع فارم
local tool = equipTool()
if tool and hum and root then
    spawn(function()
        while task.wait(ATTACK_DELAY) do
            if hum.Health <= 0 then break end
            local target = findNPC()
            if target and target:FindFirstChild("HumanoidRootPart") then
                root.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 0, -FARM_DISTANCE)
                while target.Humanoid.Health > 0 and hum.Health > 0 do
                    pcall(function() tool:Activate() end) -- جلوگیری از crash
                    task.wait(ATTACK_DELAY)
                end
            end
        end
    end)
    StarterGui:SetCore("SendNotification", {Title="فعال شد!"; Text=SELECTED_TYPE.." فارم شروع شد"; Duration=5})
else
    StarterGui:SetCore("SendNotification", {Title="خطا"; Text="کاراکتر یا سلاح لود نشد!"; Duration=5})
end
