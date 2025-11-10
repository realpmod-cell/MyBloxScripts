-- خدمات
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- تنظیمات تلگرام
local BOT_TOKEN = "8269110400:AAHpabkt1P7O_BEh1Ku0mMjDjOwy03LIGAs"
local CHAT_ID = "@testbloxscript"  -- یا عددی: -100xxxxxxxxxx

-- ساخت GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TelegramTester"
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 550, 0, 380)
frame.Position = UDim2.new(0.5, -275, 0.5, -190)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "🌙 تست تلگرام + لاگ"
title.TextColor3 = Color3.fromRGB(173, 216, 230)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.Parent = frame

-- Scrolling Log
local scrolling = Instance.new("ScrollingFrame")
scrolling.Size = UDim2.new(1, -20, 1, -100)
scrolling.Position = UDim2.new(0, 10, 0, 50)
scrolling.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
scrolling.BorderSizePixel = 1
scrolling.BorderColor3 = Color3.fromRGB(80, 80, 120)
scrolling.ScrollBarThickness = 8
scrolling.Parent = frame

local logText = Instance.new("TextLabel")
logText.Size = UDim2.new(1, -10, 0, 1000)
logText.Position = UDim2.new(0, 5, 0, 0)
logText.BackgroundTransparency = 1
logText.Text = "لاگ آماده است...\n"
logText.TextColor3 = Color3.fromRGB(0, 255, 150)
logText.Font = Enum.Font.Code
logText.TextXAlignment = Enum.TextXAlignment.Left
logText.TextYAlignment = Enum.TextYAlignment.Top
logText.TextScaled = false
logText.Parent = scrolling

-- تابع اضافه کردن لاگ
local function addLog(text)
    print(text)  -- Exploit Console
    logText.Text = logText.Text .. text .. "\n"
    scrolling.CanvasSize = UDim2.new(0, 0, 0, logText.TextBounds.Y + 20)
    scrolling.CanvasPosition = Vector2.new(0, scrolling.CanvasSize.Y.Offset)
end

-- دکمه‌ها
local btnY = 0
local function createButton(text, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 100, 0, 35)
    btn.Position = UDim2.new(0, 15 + (btnY * 115), 1, -45)
    btn.Text = text
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    btnY = btnY + 1
end

-- دکمه: تست تلگرام
createButton("تست تلگرام", Color3.fromRGB(0, 170, 255), function()
    addLog("--- شروع تست تلگرام ---")
    addLog("CHAT_ID: " .. CHAT_ID)
    
    local data = {
        chat_id = CHAT_ID,
        text = "تست از GUI!\nJobId: `" .. (game.JobId or "N/A") .. "`\nزمان: " .. os.date("%H:%M:%S"),
        parse_mode = "Markdown"
    }
    
    addLog("ارسال داده: " .. HttpService:JSONEncode(data))
    
    local success, resp = pcall(function()
        return HttpService:PostAsync(
            "https://api.telegram.org/bot" .. BOT_TOKEN .. "/sendMessage",
            HttpService:JSONEncode(data),
            Enum.HttpContentType.ApplicationJson
        )
    end)
    
    if success then
        addLog("پاسخ خام: " .. resp)
        local ok, decoded = pcall(HttpService.JSONDecode, HttpService, resp)
        if ok and decoded.ok then
            addLog("موفقیت! پیام ارسال شد.")
        else
            addLog("خطای تلگرام: " .. (decoded and decoded.description or "N/A"))
        end
    else
        addLog("خطای HTTP: " .. tostring(resp))
    end
end)

-- دکمه: کپی لاگ
createButton("کپی لاگ", Color3.fromRGB(0, 200, 100), function()
    setclipboard(logText.Text)
    addLog("لاگ کپی شد! (Clipboard)")
end)

-- دکمه: پاک کردن
createButton("پاک کن", Color3.fromRGB(220, 100, 50), function()
    logText.Text = "لاگ پاک شد.\n"
    addLog("لاگ پاک شد.")
end)

-- دکمه: بستن
createButton("بستن", Color3.fromRGB(220, 50, 50), function()
    screenGui:Destroy()
end)

-- شروع
addLog("GUI لود شد. دکمه 'تست تلگرام' رو بزن.")
addLog("اگه پیام نیومد، CHAT_ID رو عددی کن (از getUpdates).")
