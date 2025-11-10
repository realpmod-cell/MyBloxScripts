local HttpService = game:GetService("HttpService")

local BOT_TOKEN = "8269110400:AAHpabkt1P7O_BEh1Ku0mMjDjOwy03LIGAs"
local CHAT_ID = "@testbloxscript"  -- تست با @ - اگه کار نکرد، عددی بذار

local jobId = game.JobId or "N/A"
local url = "https://api.telegram.org/bot" .. BOT_TOKEN .. "/sendMessage"
local data = {
    chat_id = CHAT_ID,
    text = "🧪 **TEST از Roblox!**\nJobId: `" .. jobId .. "`\nزمان: " .. os.date("%H:%M:%S"),
    parse_mode = "Markdown"
}

print("🔍 LOG 1: URL = " .. url)
print("🔍 LOG 2: CHAT_ID = " .. CHAT_ID)
print("🔍 LOG 3: JSON Data = " .. HttpService:JSONEncode(data))

local success, response = pcall(function()
    return HttpService:PostAsync(url, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
end)

print("🔍 LOG 4: pcall success = " .. tostring(success))

if success then
    print("🔍 LOG 5: Response Raw = " .. response)
    
    local decodeSuccess, decoded = pcall(function()
        return HttpService:JSONDecode(response)
    end)
    
    if decodeSuccess then
        print("🔍 LOG 6: Decoded = " .. HttpService:JSONEncode(decoded))
        print("🔍 LOG 7: ok = " .. tostring(decoded.ok))
        if decoded.ok then
            print("✅ **TEST موفقیت‌آمیز!** پیام ارسال شد.")
        else
            print("❌ Telegram Error:")
            print("   - description: " .. (decoded.description or "N/A"))
            print("   - error_code: " .. (decoded.error_code or "N/A"))
            print("   - parameters: " .. (HttpService:JSONEncode(decoded.parameters or {}) or "N/A"))
        end
    else
        print("❌ JSON Decode Error: " .. tostring(decoded))
    end
else
    print("❌ pcall Error: " .. tostring(response))
end
