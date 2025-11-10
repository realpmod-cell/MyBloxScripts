local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local player = Players.LocalPlayer
local placeId = 2753915549  -- PlaceId برای Blox Fruits

-- ساخت GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ServerJoinerGUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Parent = screenGui
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.BorderSizePixel = 0
frame.Position = UDim2.new(0.5, -150, 0.5, -50)
frame.Size = UDim2.new(0, 300, 0, 100)

local title = Instance.new("TextLabel")
title.Parent = frame
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 0, 0, 0)
title.Size = UDim2.new(1, 0, 0, 20)
title.Text = "Server Joiner"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.SourceSansBold

local textBox = Instance.new("TextBox")
textBox.Parent = frame
textBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
textBox.BorderSizePixel = 0
textBox.Position = UDim2.new(0, 10, 0, 25)
textBox.Size = UDim2.new(1, -20, 0, 30)
textBox.PlaceholderText = "کد سرور (JobId) را وارد کنید"
textBox.Text = ""
textBox.TextColor3 = Color3.fromRGB(0, 0, 0)
textBox.TextScaled = true
textBox.Font = Enum.Font.SourceSans

local button = Instance.new("TextButton")
button.Parent = frame
button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
button.BorderSizePixel = 0
button.Position = UDim2.new(0, 10, 0, 60)
button.Size = UDim2.new(1, -20, 0, 30)
button.Text = "Join"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextScaled = true
button.Font = Enum.Font.SourceSansBold

-- عملکرد دکمه
button.MouseButton1Click:Connect(function()
    local jobId = textBox.Text
    if jobId ~= "" then
        pcall(function()
            TeleportService:TeleportToPlaceInstance(placeId, jobId, player)
        end)
        print("تلاش برای جوین به سرور: " .. jobId)
    else
        warn("کد سرور خالی است!")
    end
end)

-- دکمه بستن (اختیاری)
local closeButton = Instance.new("TextButton")
closeButton.Parent = frame
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.BorderSizePixel = 0
closeButton.Position = UDim2.new(1, -25, 0, 0)
closeButton.Size = UDim2.new(0, 20, 0, 20)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextScaled = true
closeButton.Font = Enum.Font.SourceSansBold

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)
