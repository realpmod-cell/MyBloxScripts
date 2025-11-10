local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer
local placeId = 2753915549

-- تنظیمات تلگرام (آپدیت شد!)
local BOT_TOKEN = "8269110400:AAHpabkt1P7O_BEh1Ku0mMjDjOwy03LIGAs"
local CHAT_ID = "@testbloxscript"  -- کانال تست

-- ارسال به تلگرام
local function sendToTelegram(phase, jobId, timeStr)
    local message = "🌙 **فاز ماه:** `" .. phase .. "`\n🆔 **JobId:** `" .. jobId .. "`\n⏰ **زمان:** " .. timeStr .. "\n🔗 **Join:** https://roblox.com/games/" .. placeId .. "/?gameInstanceId=" .. jobId
    local url = "https://api.telegram.org/bot" .. BOT_TOKEN .. "/sendMessage"
    pcall(function()
        HttpService:PostAsync(url, HttpService:JSONEncode({
            chat_id = CHAT_ID,
            text = message,
            parse_mode = "Markdown",
            disable_web_page_preview = true
        }), Enum.HttpContentType.ApplicationJson)
    end)
end

-- محاسبه فاز ماه از TimeOfDay
local function getMoonPhase()
    local timeOfDay = Lighting.TimeOfDay  -- "12:34:56"
    local hours = tonumber(timeOfDay:match("^(%d+)"))
    if not hours then return "Unknown" end

    local phaseIndex = math.floor(hours / 3) % 8
    local phases = {
        [0] = "🌑 New Moon",
        [1] = "🌒 Waxing Crescent",
        [2] = "🌓 First Quarter",
        [3] = "🌔 Waxing Gibbous",
        [4] = "🌕 Full Moon",
        [5] = "🌖 Waning Gibbous",
        [6] = "🌗 Last Quarter",
        [7] = "🌘 Waning Crescent"
    }
    return phases[phaseIndex] or "Unknown"
end

-- hop به سرور جدید
local function hopToNewServer()
    local currentJobId = game.JobId
    local url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"
    local success, response = pcall(HttpService.GetAsync, HttpService, url)
    if not success then return false end

    local data = HttpService:JSONDecode(response)
    for _, server in ipairs(data.data or {}) do
        if server.id ~= currentJobId and server.playing > 0 and server.playing < server.maxPlayers then
            pcall(TeleportService.TeleportToPlaceInstance, TeleportService, placeId, server.id, player)
            return true
        end
    end
    return false
end

-- حلقه اصلی (بدون خطای Humanoid!)
spawn(function()
    -- صبر تا لود شدن HumanoidRootPart (همیشه هست)
    repeat
        wait(1)
        print("در انتظار لود شدن شخصیت...")
    until player.Character and player.Character:FindFirstChild("HumanoidRootPart")

    print("شخصیت لود شد. شروع چک ماه...")

    while true do
        local phase = getMoonPhase()
        local jobId = game.JobId
        local timeStr = os.date("%Y-%m-%d %H:%M:%S")

        -- ارسال هر فاز
        sendToTelegram(phase, jobId, timeStr)

        if phase:find("Full Moon") then
            print("FULL MOON! JobId: " .. jobId)
        end

        wait(15)
        hopToNewServer()
    end
end)

print("Moon Checker + Hopper با @testbloxscript فعال شد!")
