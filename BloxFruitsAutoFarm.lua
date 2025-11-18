-- Blox Fruits Join Script with Custom GUI
-- Theme: Black and Purple
-- Assumes you have uploaded background image and font to GitHub or Roblox assets
-- Replace 'BACKGROUND_IMAGE_URL' with your GitHub raw link to the background image (e.g., https://raw.githubusercontent.com/yourusername/repo/main/background.png)
-- For custom font, Roblox requires font assets; upload your font file to Roblox and get the asset ID, replace 'CUSTOM_FONT_ID' with rbxassetid://YOUR_FONT_ID

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

-- Load a simple UI library (using Kavo UI for ease, you can change to others like Rayfield)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Blox Fruits Join GUI", "DarkTheme") -- DarkTheme for black base

-- Customize theme to black and purple
Window.Theme = {
    Main = Color3.fromRGB(30, 30, 30), -- Blackish
    Second = Color3.fromRGB(128, 0, 128), -- Purple
    Text = Color3.fromRGB(255, 255, 255), -- White text
    Element = Color3.fromRGB(50, 50, 50), -- Dark gray
    Slider = Color3.fromRGB(128, 0, 128), -- Purple slider
    Toggle = Color3.fromRGB(128, 0, 128), -- Purple toggle
}

-- Main Section
local Tab = Window:NewTab("Join Server")
local Section = Tab:NewSection("Enter Job ID")

-- Background Image (assuming you have an image URL or asset)
local Background = Instance.new("ImageLabel")
Background.Image = "rbxassetid://0" -- Replace with rbxassetid://YOUR_BACKGROUND_ASSET_ID or HttpGet if allowed
-- If using GitHub image, Roblox may not directly support external URLs for images in UI, upload to Roblox and get asset ID
Background.Size = UDim2.new(1, 0, 1, 0)
Background.Position = UDim2.new(0, 0, 0, 0)
Background.BackgroundTransparency = 1
Background.ZIndex = -1 -- Behind other elements
Background.Parent = Window.Holder -- Adjust based on library structure, may need to parent to the main frame

-- Custom Font (Roblox supports custom fonts via asset IDs)
local CustomFont = Font.new("rbxassetid://CUSTOM_FONT_ID") -- Replace with your font asset ID

-- Job ID Input Field
local JobIdInput
Section:NewTextBox("Job ID", "Enter the server Job ID", function(input)
    JobIdInput = input
end)
-- Apply custom font if possible (Kavo may not support directly, adjust accordingly)
-- For simplicity, assume library uses default; for advanced, use Drawing or custom UI

-- Join Button
Section:NewButton("Join", "Join the server with the entered Job ID", function()
    if JobIdInput and JobIdInput ~= "" then
        local success, err = pcall(function()
            TeleportService:TeleportToPlaceInstance(game.PlaceId, JobIdInput, Players.LocalPlayer)
        end)
        if not success then
            warn("Failed to join: " .. err)
        end
    else
        warn("Please enter a valid Job ID")
    end
end)

-- Note: For background and font, upload to Roblox:
-- 1. Go to Roblox Create, upload image/font.
-- 2. Get the asset ID from the URL (e.g., https://www.roblox.com/library/ASSET_ID)
-- 3. Replace above.

-- If using external GitHub for image, you might need to preload or use other methods, but Roblox security may block.
-- For font files on GitHub, same issue; must be Roblox font asset.
