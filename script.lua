if IY_LOADED and not _G.IY_DEBUG == true then
    return
end

pcall(function() getgenv().IY_LOADED = true end)

local cloneref = cloneref or function(o) return o end
COREGUI = cloneref(game:GetService("CoreGui"))

if not game:IsLoaded() then
    local notLoaded = Instance.new("Message")
    notLoaded.Parent = COREGUI
    notLoaded.Text = "Tai is waiting for the game to load"
    game.Loaded:Wait()
    notLoaded:Destroy()
end

-- Tạo GUI
local ScaledHolder = Instance.new("Frame")
ScaledHolder.Name = "TaiMenu"
ScaledHolder.Size = UDim2.new(0, 400, 0, 250)
ScaledHolder.Position = UDim2.new(0.5, -200, 0.5, -125)
ScaledHolder.AnchorPoint = Vector2.new(0.5, 0.5)
ScaledHolder.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ScaledHolder.BorderSizePixel = 0
ScaledHolder.Parent = COREGUI

-- Thêm scale
local Scale = Instance.new("UIScale", ScaledHolder)
Scale.Scale = 1

-- Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Text = "Tai"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 26
Title.Parent = ScaledHolder

-- Cmdbar
local Cmdbar = Instance.new("TextBox")
Cmdbar.Name = "Cmdbar"
Cmdbar.PlaceholderText = "Gõ lệnh vào đây..."
Cmdbar.Size = UDim2.new(1, -20, 0, 30)
Cmdbar.Position = UDim2.new(0, 10, 0, 50)
Cmdbar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Cmdbar.TextColor3 = Color3.fromRGB(255, 0, 0)
Cmdbar.ClearTextOnFocus = false
Cmdbar.Font = Enum.Font.SourceSans
Cmdbar.TextSize = 20
Cmdbar.TextXAlignment = Enum.TextXAlignment.Left
Cmdbar.Parent = ScaledHolder

-- Notification
local Notification = Instance.new("TextLabel")
Notification.Name = "Notification"
Notification.Size = UDim2.new(1, -20, 0, 25)
Notification.Position = UDim2.new(0, 10, 1, -35)
Notification.BackgroundTransparency = 1
Notification.Text = "Tải thành công Tai Menu Premeum đg update!"
Notification.TextColor3 = Color3.fromRGB(255, 0, 0)
Notification.Font = Enum.Font.SourceSansItalic
Notification.TextSize = 18
Notification.Parent = ScaledHolder

-- Button thoát
local ExitButton = Instance.new("TextButton")
ExitButton.Text = "X"
ExitButton.Size = UDim2.new(0, 30, 0, 30)
ExitButton.Position = UDim2.new(1, -35, 0, 5)
ExitButton.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
ExitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExitButton.Font = Enum.Font.SourceSansBold
ExitButton.TextSize = 20
ExitButton.Parent = ScaledHolder

ExitButton.MouseButton1Click:Connect(function()
	ScaledHolder:Destroy()
end)

-- Tô màu chữ đỏ cho toàn bộ GUI
local function setTextColorRed(parent)
	for _, child in ipairs(parent:GetDescendants()) do
		if child:IsA("TextLabel") or child:IsA("TextBox") then
			child.TextColor3 = Color3.fromRGB(255, 0, 0)
		end
	end
end

setTextColorRed(ScaledHolder)

