local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer
local placeId = 2753915549

-- مسیر دسکتاپ (NL)
local DESKTOP_PATH = "C:\\Users\\" .. os.getenv("Dani") .. "\\Desktop\\MoonChecker.txt"

-- تابع ذخیره در فایل
local function saveToFile(phase, jobId)
    local text = "NL Server | " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n"
    text = text .. "فاز ماه: " .. phase .. "\n"
    text = text .. "JobId: " .. jobId .. "\n"
    text = text .. "Join: roblox.com/games/" .. placeId .. "/?gameInstanceId=" .. jobId .. "\n"
    text = text .. "----------------------------------------\n"
    
    -- اضافه کردن به فایل (append)
    writefile(DESKTOP_PATH, readfile(DESKTOP_PATH or "") .. text)
end

-- تابع فاز ماه
local function getPhase()
    local h = tonumber(Lighting.TimeOfDay:match("^(%d+)")) or 0
    local i = math.floor(h / 3) % 8 + 1
    local phases = {"New Moon", "Waxing Crescent", "First Quarter", "Waxing Gibbous", "Full Moon", "Waning Gibbous", "Last Quarter", "Waning Crescent"}
    return phases[i]
end

-- تابع hop
local function hop()
    spawn(function()
        pcall(function()
            local r = HttpService:GetAsync("https://games.roblox.com/v1/games/"..placeId.."/servers/Public?limit=100")
            local d = HttpService:JSONDecode(r)
            for _, s in ipairs(d.data or {}) do
                if s.id ~= game.JobId and s.playing > 0 then
                    TeleportService:TeleportToPlaceInstance(placeId, s.id, player)
                    break
                end
            end
        end)
    end)
end

-- شروع
spawn(function()
    repeat wait(1) until player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    
    -- پاک کردن فایل قدیمی (اختیاری)
    if isfile(DESKTOP_PATH) then delfile(DESKTOP_PATH) end
    
    -- عنوان فایل
    writefile(DESKTOP_PATH, "Moon Checker NL | Volcano\nشروع: " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n\n")
    
    while true do
        local phase = getPhase()
        local jobId = game.JobId
        saveToFile(phase, jobId)
        print("ذخیره شد: " .. phase .. " | " .. jobId)
        wait(15)
        hop()
    end
end)

print("Moon Checker NL فعال شد! فایل روی دسکتاپ: MoonChecker.txt")
