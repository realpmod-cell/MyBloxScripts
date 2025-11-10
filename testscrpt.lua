local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local placeId = 2753915549  -- Blox Fruits PlaceId

-- تنظیمات تلگرام (عوض کن!)
local BOT_TOKEN = "8269110400:AAHpabkt1P7O_BEh1Ku0mMjDjOwy03LIGAs"  -- token رباتت
local CHAT_ID = "@testbloxscript"     -- username کانال با @

-- تابع ارسال به تلگرام
local function sendToTelegram(message)
    local url = "https://api.telegram.org/bot" .. BOT_TOKEN .. "/sendMessage"
    local data = {
        chat_id = CHAT_ID,
        text = message,
        parse_mode = "Markdown"
    }
    pcall(function()
        HttpService:PostAsync(url, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
    end)
end

-- تابع دریافت اطلاعات ماه (Moon Phase)
local moonPhaseCache = nil
local function getMoonPhase()
    local success, result = pcall(function()
        -- روش اصلی: استفاده از remoteهای بازی (ممکنه بسته به آپدیت تغییر کنه)
        return ReplicatedStorage.Remotes.CommF_:InvokeServer("CheckMoon") 
            or ReplicatedStorage.Remotes.CommF_:InvokeServer("GetMoonInfo")
            or ReplicatedStorage.Remotes.CommF_:InvokeServer("MoonPhase")
    end)
    
    if success and result then
        -- فرمت معمول: string مثل "Full Moon" یا عدد 0-7
        local phase = tostring(result)
        if type(result) == "number" then
            local phases = {"New Moon", "Waxing Crescent", "First Quarter", "Waxing Gibbous", "Full Moon", "Waning Gibbous", "Last Quarter", "Waning Crescent"}
            phase = phases[result + 1] or "Unknown"
        end
        return phase
    end
    
    -- fallback: اگر remote کار نکرد، از Sky.MoonTextureID استفاده کن
    local sky = game.Lighting:FindFirstChildOfClass("Sky")
    if sky and sky.MoonTextureID then
        local id = sky.MoonTextureID
        if string.find(id, "Full") then return "Full Moon" end
        if string.find(id, "New") then return "New Moon" end
        -- اضافه کردن بقیه فازها بر اساس ID
    end
    
    return "Unknown"
end

-- تابع hop به سرور جدید
local function hopToNewServer()
    local currentJobId = game.JobId
    local url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"
    local success, response = pcall(function()
        return HttpService:GetAsync(url)
    end)
    if success then
        local data = HttpService:JSONDecode(response)
        local servers = data.data or {}
        local newJobId = nil
        for _, server in ipairs(servers) do
            if server.id ~= currentJobId and server.playing > 0 and server.playing < server.maxPlayers then
                newJobId = server.id
                break
            end
        end
        if newJobId then
            pcall(function()
                TeleportService:TeleportToPlaceInstance(placeId, newJobId, player)
            end)
            print("Hop به سرور جدید: " .. newJobId)
        else
            warn("سرور مناسبی پیدا نشد!")
        end
    end
end

-- حلقه اصلی
spawn(function()
    while true do
        local currentPhase = getMoonPhase()
        local jobId = game.JobId
        local message = "🌙 **Moon Phase در سرور:** `" .. currentPhase .. "`\n🆔 **JobId:** `" .. jobId .. "`\n⏰ **زمان:** " .. os.date("%Y-%m-%d %H:%M:%S")
        
        -- فقط وقتی Full Moon یا تغییر فاز باشه بفرست
        if currentPhase == "Full Moon" or (moonPhaseCache and moonPhaseCache ~= currentPhase) then
            sendToTelegram(message .. "\n🚨 **هشدار: تغییر فاز ماه یا Full Moon!**")
            print("ارسال به تلگرام: " .. currentPhase)
        end
        
        moonPhaseCache = currentPhase  -- کش کردن فاز قبلی
        
        print(message)
        
        wait(15)  -- هر 15 ثانیه چک کن
        hopToNewServer()  -- hop به سرور بعدی
    end
end)

print("Auto Moon Checker + Hopper شروع شد! کانال: " .. CHAT_ID)
