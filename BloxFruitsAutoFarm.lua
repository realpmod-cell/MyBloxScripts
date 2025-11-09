-- ULTRA SPAM (Key Press + Click) - 100% WORKS
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- بی‌نهایت اسپم کلیدها
spawn(function()
    while true do
        -- M1
        VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,1)
        task.wait(0.01)
        VirtualInputManager:SendMouseButtonEvent(0,0,0,false,game,1)
        
        -- Z
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
        task.wait(0.05)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
        
        -- X  
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.X, false, game)
        task.wait(0.05)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.X, false, game)
        
        -- C
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.C, false, game)
        task.wait(0.05)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.C, false, game)
        
        task.wait(0.1)
    end
end)

StarterGui:SetCore("SendNotification", {Title="💥"; Text="KEY SPAM ON! Z X C M1"; Duration=20})
