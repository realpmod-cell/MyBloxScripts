local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local BOT_TOKEN = "8269110400:AAHpabkt1P7O_BEh1Ku0mMjDjOwy03LIGAs"
local CHAT_ID = "-1003421042506"

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 500, 0, 350)
frame.Position = UDim2.new(0.5, -250, 0.5, -175)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,35)
title.Text = "Volcano Telegram Test"
title.TextColor3 = Color3.fromRGB(0, 200, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Parent = frame

local logBox = Instance.new("TextBox")
logBox.Size = UDim2.new(1,-20,1,-80)
logBox.Position = UDim2.new(0,10,0,45)
logBox.BackgroundColor3 = Color3.fromRGB(10,10,20)
logBox.TextColor3 = Color3.fromRGB(0,255,150)
logBox.Font = Enum.Font.Code
logBox.MultiLine = true
logBox.Text = "لاگ آماده...\n"
logBox.TextXAlignment = Enum.TextXAlignment.Left
logBox.Parent = frame

local function log(t)
    logBox.Text = logBox.Text .. t .. "\n"
end

-- دکمه تست
local testBtn = Instance.new("TextButton")
testBtn.Size = UDim2.new(0,120,0,35)
testBtn.Position = UDim2.new(0,10,1,-45)
testBtn.Text = "تست تلگرام"
testBtn.BackgroundColor3 = Color3.fromRGB(0,170,255)
testBtn.Parent = frame
Instance.new("UICorner", testBtn).CornerRadius = UDim.new(0,8)

testBtn.MouseButton1Click:Connect(function()
    log("--- شروع تست Volcano ---")
    log("HTTP Enabled: " .. tostring(HttpService.HttpEnabled))
    
    local data = {
        chat_id = CHAT_ID,
        text = "Volcano کار کرد!\nJobId: `"..game.JobId.."`\nزمان: "..os.date("%H:%M:%S"),
        parse_mode = "Markdown"
    }
    
    log("ارسال داده...")
    
    spawn(function()
        local success, result = pcall(function()
            return HttpService:PostAsync(
                "https://api.telegram.org/bot"..BOT_TOKEN.."/sendMessage",
                HttpService:JSONEncode(data),
                Enum.HttpContentType.ApplicationJson
            )
        end)
        
        if success then
            local resp = HttpService:JSONDecode(result)
            if resp.ok then
                log("موفقیت! پیام در کانال test ارسال شد.")
            else
                log("خطای تلگرام: "..(resp.description or "N/A"))
            end
        else
            log("خطا: "..tostring(result))
        end
    end)
end)

-- دکمه بستن
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,80,0,35)
closeBtn.Position = UDim2.new(1,-90,1,-45)
closeBtn.Text = "بستن"
closeBtn.BackgroundColor3 = Color3.fromRGB(220,50,50)
closeBtn.Parent = frame
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

log("GUI لود شد!")
log("دکمه 'تست تلگرام' رو بزن!")
