-- Blox Fruits Auto Skills ONLY (M1 + Z X C SPAM) - 2025
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

-- God Mode (اختیاری)
hum.MaxHealth = math.huge
hum.Health = math.huge

-- SPAM Z X C + M1
spawn(function()
    while task.wait(0.1) do
        -- M1 کلیک (همیشه!)
        pcall(function()
            VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,1)
            task.wait(0.01)
            VirtualInputManager:SendMouseButtonEvent(0,0,0,false,game,1)
        end)
        
        -- Z X C Remote (همه Fighting Styles)
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        if remotes then
            local commF = remotes:FindFirstChild("CommF_")
            if commF then
                commF:FireServer("Z")  -- Z Skill
                task.wait(0.05)
                commF:FireServer("X")  -- X Skill  
                task.wait(0.05)
                commF:FireServer("C")  -- C Skill
                task.wait(0.05)
            end
        end
    end
end)

StarterGui:SetCore("SendNotification", {
    Title="✅"; Text="M1 + Z X C SPAM شروع شد! (Infinite)"; Duration=10
})
