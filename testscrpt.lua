local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer
local placeId = 2753915549

-- تنظیمات تلگرام (Token آپدیت شد!)
local BOT_TOKEN = "8269110400:AAHpabkt1P7O_BEh1Ku0mMjDjOwy03LIGAs"
local CHAT_ID = "@your_channel_username"  -- عوض کن با username کانالت (با @) یا chat ID عددی

-- ارسال به تلگرام (هر فاز)
local function sendToTelegram(phase, jobId, textureId)
    local time = os.date("%Y-%m-%d %H:%M:%S")
    local message = "🌙 **فاز ماه:** `" .. phase .. "`\n🆔 **JobId:** `" .. jobId .. "`\n🆔 **MoonTextureID:** `" .. (textureId or "N/A") .. "`\n⏰ **زمان:** " .. time .. "\n🔗 **Join:** roblox.com/games/" .. placeId .. "/?placeId=" .. placeId .. "&gameInstance=" .. jobId
    local url = "https://api.telegram.org/bot" .. BOT_TOKEN .. "/sendMessage"
    local data = {chat_id = CHAT_ID, text = message, parse_mode = "Markdown", disable_web_page_preview = true}
    pcall(function()
        HttpService:PostAsync(url, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
    end)
    print("ارسال شد: " .. phase .. " | JobId: " .. jobId)
end

-- دریافت فاز ماه از Sky.MoonTextureID (اصلی)
local function getMoonPhase()
    local sky = Lighting:FindFirstChildOfClass("Sky")
    if sky and sky.MoonTextureID then
        local id = tostring(sky.MoonTextureID)
        local phase = "Unknown Phase (ID: " .. id .. ")"  -- همه IDها رو نشون می‌ده
        
        -- Map شناخته‌شده (از تست‌ها - آپدیت کن اگه ID جدید دیدی)
        local moonMap = {
            ["rbxassetid://11642078616"] = "🌕 Full Moon",
            ["rbxassetid://11642076146"] = "🌑 New Moon",
            ["rbxassetid://11642076919"] = "🌒 Waxing Crescent",
            ["rbxassetid://11642077428"] = "🌓 First Quarter",
            ["rbxassetid://11642078035"] = "🌔 Waxing Gibbous",
            ["rbxassetid://11642079253"] = "🌖 Waning Gibbous",
            ["rbxassetid://11642079813"] = "🌗 Last Quarter",
            ["rbxassetid://11642080368"] = "🌘 Waning Crescent",
        }
        phase = moonMap[id] or phase
        
        return phase, id
    end
    return "Sky Not Loaded", nil
end

-- hop به سرور جدید
local function hopToNewServer()
    local currentJobId = game.JobId
    local url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"
    local success, response = pcall(HttpService.GetAsync, HttpService, url)
    if success then
        local data = HttpService:JSONDecode(response)
        local servers = data.data or {}
        for _, server in ipairs(servers) do
            if server.id ~= currentJobId and server.playing > 0 and server.playing < server.maxPlayers * 0.8 then
                pcall(TeleportService.TeleportToPlaceInstance, TeleportService, placeId, server.id, player)
                print("Hop به: " .. server.id)
                return true
            end
        end
    end
    warn("سرور جدید پیدا نشد!")
    return false
end

-- حلقه اصلی
spawn(function()
    -- صبر تا لود Sky (حداکثر 60 ثانیه)
    local startTime = tick()
    repeat
        wait(3)
        print("انتظار برای Sky...")
    until Lighting:FindFirstChildOfClass("Sky") or (tick() - startTime > 60)
    
    while true do
        local phase, textureId = getMoonPhase()
        local jobId = game.JobId
        
        -- ارسال **هر فاز** به تلگرام
        sendToTelegram(phase, jobId, textureId)
        
        -- Highlight Full Moon
        if string.find(phase:lower(), "full") then
            print("🚨 FULL MOON پیدا شد! JobId: " .. jobId)
        end
        
        wait(15)  -- هر 15 ثانیه
        hopToNewServer()
    end
end)

print("🚀 Moon Checker + Hopper شروع شد! همه فازها به تلگرام: " .. CHAT_ID)
