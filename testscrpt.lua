local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local BOT_TOKEN = "8269110400:AAHpabkt1P7O_BEh1Ku0mMjDjOwy03LIGAs"
local CHAT_ID = "-1003421042506"

-- دستی JSON ساختن (Volcano JSONEncode باگ داره)
local function urlEncode(str)
    str = string.gsub(str, "\n", "%0A")
    str = string.gsub(str, " ", "%20")
    str = string.gsub(str, "`", "%60")
    return str
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 520, 0, 380)
frame.Position = UDim2.new(0.5, -260, 0.5, -190)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.Text = "Volcano NL Test"
title.TextColor3 = Color3.fromRGB(0, 220, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Parent = frame

local logBox = Instance.new("TextBox")
logBox.Size = UDim2.new(1,-20,1,-90)
logBox.Position = UDim2.new(0,10,0,50)
logBox.BackgroundColor3 = Color3.fromRGB(5,5,15)
logBox.TextColor3 = Color3.fromRGB(0,255,100)
logBox.Font = Enum.Font.Code
logBox.MultiLine = true
logBox.Text = "NL Server | Volcano\n"
logBox.TextXAlignment = Enum.TextXAlignment.Left
logBox.Parent = frame

local function log(t)
    logBox.Text = logBox.Text .. t .. "\n"
    logBox.CanvasPosition = Vector2.new(0, #logBox.Text * 10)
end

-- دکمه تست
local testBtn = Instance.new("TextButton")
testBtn.Size = UDim2.new(0,140,0,40)
testBtn.Position = UDim2.new(0,10,1,-50)
testBtn.Text = "تست NL"
testBtn.BackgroundColor3 = Color3.fromRGB(0,180,255)
testBtn.Parent = frame
Instance.new("UICorner", testBtn).CornerRadius = UDim.new(0,8)

testBtn.MouseButton1Click:Connect(function()
    log("--- تست NL شروع ---")
    log("زمان: " .. os.date("%H:%M:%S"))
    
    local text = "NL Server تست!\nJobId: `" .. game.JobId .. "`\nVolcano + NL"
    local encodedText = urlEncode(text)
    
    local url = "https://api.telegram.org/bot" .. BOT_TOKEN .. "/sendMessage?chat_id=" .. CHAT_ID .. "&text=" .. encodedText .. "&parse_mode=Markdown&disable_web_page_preview=true"
    
    log("URL: " .. string.sub(url, 1, 100) .. "...")
    
    local success, result = pcall(function()
        return HttpService:GetAsync(url)  -- GetAsync برای query string
    end)
    
    if success then
        log("پاسخ خام: " .. string.sub(result, 1, 200))
        if string.find(result, "\"ok\":true") then
            log("پیام در کانال test ارسال شد!")
        else
            log("خطا: " .. result)
        end
    else
        log("خطا در GetAsync: " .. tostring(result))
    end
end)

-- دکمه بستن
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,80,0,40)
closeBtn.Position = UDim2.new(1,-90,1,-50)
closeBtn.Text = "بستن"
closeBtn.BackgroundColor3 = Color3.fromRGB(220,50,50)
closeBtn.Parent = frame
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

log("GUI NL لود شد!")
log("دکمه 'تست NL' رو بزن!")
