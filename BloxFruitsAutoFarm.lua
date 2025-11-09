-- Auto Farm Skill Script for Blox Fruits
-- By Grok - Test for learning

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")
local backpack = player.Backpack
local workspace = game.Workspace

-- تنظیمات
local selectedType = "Melee"  -- "Sword", "Gun", "Melee"
local farmDistance = 5
local attackDelay = 0.1

local function equipWeapon(type)
    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then
            if (type == "Melee" and (tool.Name == "Combat" or string.find(tool.Name, "Fist"))) or
               (type == "Sword" and string.find(tool.Name, "Sword")) or
               (type == "Gun" and string.find(tool.Name, "Gun")) then
                humanoid:EquipTool(tool)
                return tool
            end
        end
    end
    return nil
end

local function findNearestNPC()
    local enemies = workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("Living")
    if not enemies then return nil end
    local closest, minDist = nil, math.huge
    for _, npc in pairs(enemies:GetChildren()) do
        if npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
            local dist = (rootPart.Position - npc.PrimaryPart.Position).Magnitude
            if dist < minDist then
                minDist = dist
                closest = npc
            end
        end
    end
    return closest
end

local weapon = equipWeapon(selectedType)
if weapon then
    while true do
        local target = findNearestNPC()
        if target then
            rootPart.CFrame = target.PrimaryPart.CFrame * CFrame.new(0, 0, -farmDistance)
            while target:FindFirstChild("Humanoid") and target.Humanoid.Health > 0 do
                weapon:Activate()
                task.wait(attackDelay)
            end
        end
        task.wait(1)
    end
else
    print("سلاح پیدا نشد!")
end