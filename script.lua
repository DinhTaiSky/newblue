local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/DinhTaiSky/newblue/refs/heads/main/script.lua"))()

-- Tạo cửa sổ menu
local Window = OrionLib:MakeWindow({
    Name = "Tai",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "TaiMenuConfig",
    BackgroundColor = Color3.fromRGB(0, 0, 0),
    TextColor = Color3.fromRGB(255, 0, 0),
    Size = UDim2.new(0, 400, 0, 400)
})

-- Tạo tab đầu tiên trong menu
local FirstTab = Window:MakeTab({
    Name = "Cay Level",
    Icon = "rbxassetid://6031075938",  -- Icon có thể là hình ảnh của thanh kiếm hoặc bất kỳ thứ gì bạn muốn
    PremiumOnly = true
})

-- Thêm toggle vào tab này
FirstTab:AddToggle({
    Name = "Sample Toggle",
    Default = false,
    Callback = function(Value)
        print("Toggle Value: ", Value)
    end
})
