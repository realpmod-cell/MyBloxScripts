local HttpService = game:GetService("HttpService")

local BOT_TOKEN = "8269110400:AAHpabkt1P7O_BEh1Ku0mMjDjOwy03LIGAs"
local CHAT_ID = "@testbloxscript"  -- یا ID عددی مثل -1001234567890 رو بذار

local url = "https://api.telegram.org/bot" .. BOT_TOKEN .. "/sendMessage"
local data = {
    chat_id = CHAT_ID,
    text = "🧪 تست از Roblox! اگه این پیام اومد، اسکریپت کار می‌کنه. JobId: " .. game.JobId,
    parse_mode = "Markdown"
}

local success = pcall(function()
    HttpService:PostAsync(url, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
end)

if success then
    print("تست ارسال شد! چک کن تلگرام.")
else
    warn("خطا در ارسال! CHAT_ID یا bot رو چک کن.")
end
