local OrionLib = 

-- Tạo cửa sổ menu
local Window = OrionLib:MakeWindow({
    Name = "Blox Fruits Menu",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "BloxFruitsCFG"
})

-- Tạo tab Auto Farm
local AutoFarmTab = Window:MakeTab({
    Name = "Auto Farm",
    Icon = "rbxassetid://6031075938", -- icon thanh kiếm
    PremiumOnly = false
})

-- Auto Farm toggle
AutoFarmTab:AddToggle({
    Name = "Auto Farm",
    Default = false,
    Callback = function(Value)
        getgenv().AutoFarm = Value
        while getgenv().AutoFarm do
            -- Đây là vị trí bạn thêm mã farm thật
            print("Auto Farming...")
            wait(1)
        end
    end
})

-- Auto Quest toggle
AutoFarmTab:AddToggle({
    Name = "Auto Quest",
    Default = false,
    Callback = function(Value)
        getgenv().AutoQuest = Value
        while getgenv().AutoQuest do
            print("Auto Questing...")
            wait(1)
        end
    end
})

-- Auto Stats toggle
AutoFarmTab:AddToggle({
    Name = "Auto Stats",
    Default = false,
    Callback = function(Value)
        getgenv().AutoStats = Value
        while getgenv().AutoStats do
            print("Auto Adding Stats...")
            wait(1)
        end
    end
})
