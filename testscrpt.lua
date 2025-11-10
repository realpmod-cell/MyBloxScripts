local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer
local placeId = 2753915549

-- تابع نمایش در Console Volcano
local function logToConsole(phase, jobId)
    local text = "NL Server | " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n"
    text = text .. "فاز ماه: " .. phase .. "\n"
    text = text .. "JobId: " .. jobId .. "\n"
    text = text .. "Join: roblox.com/games/" .. placeId .. "/?gameInstanceId=" .. jobId .. "\n"
    text = text .. "----------------------------------------"
    
    print("\n" .. text .. "\n")  -- در Console Volcano
end

-- فاز ماه
local function getPhase()
    local h = tonumber(Lighting.TimeOfDay:match("^(%d+)")) or 0
    local i = math.floor(h / 3) % 8 + 1
    local phases = {"New Moon", "Waxing Crescent", "First Quarter", "Waxing Gibbous", "Full Moon", "Waning Gibbous", "Last Quarter", "Waning Crescent"}
    return phases[i]
end

-- Hop
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
    
    print("Moon Checker NL | Volcano شروع شد!")
    print("هر 15 ثانیه در Console نمایش داده می‌شود.")
    
    while true do
        local phase = getPhase()
        local jobId = game.JobId
        logToConsole(phase, jobId)
        wait(15)
        hop()
    end
end)
