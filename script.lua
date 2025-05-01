-- Tạo GUI
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

-- Tạo Frame chứa các nút
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 250)
frame.Position = UDim2.new(0.5, -150, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BackgroundTransparency = 0.7
frame.BorderSizePixel = 0
frame.Parent = screenGui

-- Tạo một đường viền để làm đẹp
local border = Instance.new("UIStroke")
border.Parent = frame
border.Thickness = 2
border.Color = Color3.fromRGB(255, 255, 255)
border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Tạo tiêu đề cho menu
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "Blox Fruits Menu"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.TextStrokeTransparency = 0.8
title.TextAlign = Enum.TextAlign.Center
title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
title.BackgroundTransparency = 0.7
title.Parent = frame

-- Tạo các nút với chức năng bật/tắt
local function createButton(text, position, toggleFunction)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 250, 0, 50)
    button.Position = position
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.TextSize = 16
    button.Parent = frame
    button.MouseButton1Click:Connect(toggleFunction)
    -- Tạo hiệu ứng hover
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)
    return button
end

-- Biến để kiểm tra trạng thái các chức năng
local flying = false
local speed = 100
local flyButton, speedButton, resetButton

-- Chức năng bay
local function toggleFly()
    flying = not flying
    if flying then
        flyButton.Text = "Tắt Bay"
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Velocity = Vector3.new(0, 50, 0) -- Tạo lực bay lên
        bodyVelocity.Parent = player.Character:WaitForChild("HumanoidRootPart")
    else
        flyButton.Text = "Bật Bay"
        if player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("BodyVelocity") then
            player.Character.HumanoidRootPart.BodyVelocity:Destroy()
        end
    end
end

-- Chức năng tốc độ
local function toggleSpeed()
    if speed == 100 then
        speed = 200
        player.Character.Humanoid.WalkSpeed = speed
        speedButton.Text = "Tắt Tốc Độ Cao"
    else
        speed = 100
        player.Character.Humanoid.WalkSpeed = speed
        speedButton.Text = "Bật Tốc Độ Cao"
    end
end

-- Chức năng reset
local function resetCharacter()
    player.Character:BreakJoints() -- Reset nhân vật
end

-- Tạo các nút
flyButton = createButton("Bật Bay", UDim2.new(0, 25, 0, 50), toggleFly)
speedButton = createButton("Bật Tốc Độ Cao", UDim2.new(0, 25, 0, 110), toggleSpeed)
resetButton = createButton("Reset Nhân Vật", UDim2.new(0, 25, 0, 170), resetCharacter)
