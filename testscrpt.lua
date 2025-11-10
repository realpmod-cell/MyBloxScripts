-- خدمات
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- تنظیمات
local BOT_TOKEN = "8269110400:AAHpabkt1P7O_BEh1Ku0mMjDjOwy03LIGAs"
local CHAT_ID = "@testbloxscript"  -- یا عددی مثل -1003421042506

-- ساخت GUI برای نمایش لاگ
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TelegramLogGUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 500, 0, 300)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(100, 100, 255)
frame.Parent = screenGui

local scrolling = Instance.new("ScrollingFrame")
scrolling.Size = UDim2.new(1, -10, 1, -40)
scrolling.Position = UDim2.new(0, 5, 0, 35)
scrolling.BackgroundTransparency = 1
scrolling.ScrollBarThickness = 8
scrolling.Parent = frame

local logLabel = Instance.new("TextLabel")
logLabel.Size = UDim2.new(1, 0, 0, 1000)
logLabel.Position = UDim2.new(0, 0, 0, 0)
logLabel.BackgroundTransparency = 1
logLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
logLabel.Text = "لاگ‌ها در حال بارگذاری...\n"
logLabel.TextScaled = false
logLabel.Font = Enum.Font.Code
logLabel.TextXAlignment = Enum.TextXAlignment.Left
logLabel.TextYAlignment = Enum.TextYAlignment.Top
logLabel.Parent = scrolling

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Telegram Test Log"
title.TextColor3 = Color3.fromRGB(173, 216, 230)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- تابع اضافه کردن لاگ (هم کنسول، هم GUI)
local function addLog(text)
    print(text)  -- Exploit Console
    logLabel.Text = logLabel.Text .. text .. "\n"
    scrolling.CanvasSize = UDim2.new(0, 0, 0, logLabel.TextBounds.Y)
    scrolling.CanvasPosition = Vector2.new(0, scrolling.CanvasSize.Y.Offset)
end

-- شروع تست
addLog("شروع تست تلگرام...")
addLog("URL: https://api.telegram.org/bot" .. BOT_TOKEN .. "/sendMessage")
addLog("CHAT_ID: " .. CHAT_ID)

local jobId = game.JobId or "N/A"
local data = {
    chat_id = CHAT_ID,
    text = "TEST از GUI!\nJobId: `" .. jobId .. "`\nزمان: " .. os.date("%H:%M:%S"),
    parse_mode = "Markdown"
}

addLog("JSON Data: " .. HttpService:JSONEncode(data))

local success, response = pcall(function()
    return HttpService:PostAsync(
        "https://api.telegram.org/bot" .. BOT_TOKEN .. "/sendMessage",
        HttpService:JSONEncode(data),
        Enum.HttpContentType.ApplicationJson
    )
end)

addLog("pcall success: " .. tostring(success))

if success then
    addLog("Response Raw: " .. response)
    
    local decodeOk, decoded = pcall(HttpService.JSONDecode, HttpService, response)
    if decodeOk then
        addLog("ok: " .. tostring(decoded.ok))
        if decoded.ok then
            addLog("موفقیت! پیام ارسال شد.")
        else
            addLog("خطای تلگرام:")
            addLog("  description: " .. (decoded.description or "N/A"))
            addLog("  error_code: " .. (decoded.error_code or "N/A"))
        end
    else
        addLog("خطا در JSON Decode: " .. tostring(decoded))
    end
else
    addLog("خطای HTTP: " .. tostring(response))
end

addLog("تست تمام شد. GUI رو ببند یا F9 رو چک کن.")
