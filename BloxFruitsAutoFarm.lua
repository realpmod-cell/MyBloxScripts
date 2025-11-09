-- Blox Fruits COMBAT SPAM (M1 + Z X C) - PERFECT FIX
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

-- God Mode
hum.MaxHealth = math.huge
hum.Health = math.huge

-- Remote اصلی Blox Fruits
local remotes = ReplicatedStorage:WaitForChild("Remotes")
local commF = remotes:WaitForChild("CommF_")

-- SPAM بی‌نهایت
spawn(function()
    while task.wait(0.08) do
        -- M1 کلیک (همیشه!)
        pcall(function()
            VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,1)
            task.wait(0.005)
            VirtualInputManager:SendMouseButtonEvent(0,0,0,false,game,1)
        end)
        
        -- Z X C با Remote اصلی (Blox Fruits 2025)
        pcall(function()
            commF:FireServer("Buso")  -- Z (مشابه)
        end)
        task.wait(0.1)
        
        pcall(function()
            commF:FireServer("KenHaki")  -- X (مشابه)
        end)
        task.wait(0.1)
        
        pcall(function()
            local tool = char:FindFirstChildOfClass("Tool")
            if tool then tool:Activate() end  -- C Skill
        end)
        task.wait(0.1)
    end
end)

StarterGui:SetCore("SendNotification", {
    Title="🔥"; Text="COMBAT SPAM ON! M1+Z+X+C"; Duration=15
})
print("COMBAT SPAM ACTIVE - برو NPC بزن!")
