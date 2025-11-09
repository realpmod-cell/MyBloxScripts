-- Auto Farm Blox Fruits GUI (Based on Redz Hub Deobf)
-- By Grok (2025) - Simple & Keyless

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "Auto Farm Blox Fruits",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "AutoFarmBF"
})

local Tab = Window:MakeTab({
    Name = "Farm",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local AutoFarmToggle = Tab:AddToggle({
    Name = "Auto Farm Level (Quests & Mobs)",
    Default = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        if Value then
            spawn(function()
                autoFarmLoop()
            end)
        end
    end    
})

local NoClipToggle = Tab:AddToggle({
    Name = "No-Clip (Walk Through Walls)",
    Default = false,
    Callback = function(Value)
        _G.NoClip = Value
        spawn(function()
            noClipLoop()
        end)
    end    
})

-- Main Start Button (وسط GUI)
local StartButton = Tab:AddButton({
    Name = "🚀 START AUTO FARM",
    Callback = function()
        _G.AutoFarm = true
        OrionLib:MakeNotification({
            Name = "Auto Farm Started!",
            Content = "Farming quests & mobs in Blox Fruits. Stop anytime.",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
        spawn(function()
            autoFarmLoop()
        end)
    end
})

local StopButton = Tab:AddButton({
    Name = "⏹️ STOP AUTO FARM",
    Callback = function()
        _G.AutoFarm = false
        OrionLib:MakeNotification({
            Name = "Auto Farm Stopped!",
            Content = "Farm paused. Enjoy!",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
    end
})

-- Auto Farm Logic (Deobf-inspired from Redz Hub)
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Quest Positions (Sea 1 Example - Expand for full seas)
local Quests = {
    Starter = CFrame.new(-324.48980712890625, 73.91703033447266, 268.2342529296875),  -- Bandit Quest
    Marine = CFrame.new(44.60595703125, 7.8696441650390625, 45.0517578125)  -- Marine Fortress
}

function teleportTo(pos)
    if _G.MetodeTeleport == "Tween" then
        local tween = TweenService:Create(player.Character.HumanoidRootPart, TweenInfo.new(1), {CFrame = pos})
        tween:Play()
        tween.Completed:Wait()
    else
        player.Character.HumanoidRootPart.CFrame = pos
    end
end

function getNearestQuest()
    -- Simple logic: Teleport to first quest
    return Quests.Starter  -- Add detection for current sea/level
end

function acceptQuest()
    -- Fire proximity prompt for quest NPC
    local npc = workspace.NPCs:FindFirstChild("BanditQuestGiver")  -- Adjust name
    if npc then
        fireproximityprompt(npc.ProximityPrompt)
    end
end

function killMobs()
    for _, mob in pairs(workspace.Enemies:GetChildren()) do
        if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
            -- Fast attack
            player.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
            game:GetService("VirtualUser"):ClickButton1(Vector2.new())
            wait(0.1)
        end
    end
end

function autoFarmLoop()
    while _G.AutoFarm do
        local questPos = getNearestQuest()
        teleportTo(questPos)
        acceptQuest()
        killMobs()  -- Kill 5-10 mobs per loop
        wait(5)     -- Adjust speed
        -- Collect fruits/beli if near
        if game.Workspace:FindFirstChild("DevilFruit") then
            teleportTo(game.Workspace.DevilFruit.Handle.CFrame)
        end
    end
end

function noClipLoop()
    while _G.NoClip do
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
        RunService.Heartbeat:Wait()
    end
end

OrionLib:Init()
