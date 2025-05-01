local Window = Rayfield:CreateWindow({
   Name = "Blox Fruits Script Menu",
   LoadingTitle = "Blox Fruits Hub",
   LoadingSubtitle = "Auto Farm & More",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "BloxFruitsUI",
      FileName = "Config"
   }
})

-- Tab Auto Farm
local AutoFarmTab = Window:CreateTab("Auto Farm", 4483362458)

-- Danh sách nhóm vũ khí
local WeaponGroups = {
    Melee = {"Combat", "Dragon Talon", "Electric Claw", "God Human", "Sanguine Art"},
    Sword = {"Dark Blade", "Shisui", "Wando", "Oden’s Sword", "True Triple Katana"},
    Gun   = {"Kabucha", "Serpent Bow", "Bazooka", "Slingshot"},
}

-- Chọn loại vũ khí
AutoFarmTab:CreateDropdown({
   Name = "Chọn Loại Vũ Khí",
   Options = {"Melee", "Sword", "Gun"},
   CurrentOption = "Melee",
   Callback = function(option)
       _G.SelectedWeaponGroup = option
   end,
})

-- Toggle Auto Farm
AutoFarmTab:CreateToggle({
   Name = "Auto Farm Mobs",
   CurrentValue = false,
   Callback = function(Value)
       _G.AutoFarm = Value

       -- Hàm tìm quái gần nhất
       local function GetNearestEnemy()
           local closest = nil
           local shortest = math.huge
           for _, v in pairs(workspace.Enemies:GetChildren()) do
               if v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                   local dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                   if dist < shortest then
                       shortest = dist
                       closest = v
                   end
               end
           end
           return closest
       end

       -- Hàm tự chọn vũ khí từ nhóm
       local function GetWeaponFromGroup()
           local backpack = game.Players.LocalPlayer.Backpack
           local group = _G.SelectedWeaponGroup or "Melee"
           local list = WeaponGroups[group] or {}

           for _, weaponName in pairs(list) do
               if backpack:FindFirstChild(weaponName) then
                   return weaponName
               end
           end
           return nil
       end

       -- Hàm trang bị và trả tool
       local function EquipWeaponAuto()
           local weaponName = GetWeaponFromGroup()
           if not weaponName then return nil end

           local player = game.Players.LocalPlayer
           local char = player.Character
           local backpack = player.Backpack

           if backpack:FindFirstChild(weaponName) then
               local tool = backpack[weaponName]
               char.Humanoid:EquipTool(tool)
               return tool
           elseif char:FindFirstChild(weaponName) then
               return char[weaponName]
           end
           return nil
       end

       -- Vòng lặp farm
       task.spawn(function()
           while _G.AutoFarm do
               task.wait(0.2)

               local enemy = GetNearestEnemy()
               if enemy then
                   local char = game.Players.LocalPlayer.Character
                   if char and char:FindFirstChild("HumanoidRootPart") then
                       -- Dịch chuyển lên đầu quái
                       char.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)

                       -- Trang bị và đánh
                       local tool = EquipWeaponAuto()
                       if tool then
                           tool:Activate()
                       end
                   end
               end
           end
       end)
   end,
})
local StatsTab = Window:CreateTab("Auto Stats", 4483362458)

local StatsList = {"Melee", "Defense", "Sword", "Gun", "Blox Fruit"}
_G.AutoStatEnabled = false
_G.AutoStatType = "Melee"
_G.AutoStatAmount = 1

-- Chọn loại chỉ số
StatsTab:CreateDropdown({
   Name = "Chọn chỉ số muốn tăng",
   Options = StatsList,
   CurrentOption = "Melee",
   Callback = function(option)
       _G.AutoStatType = option
   end,
})

-- Chọn số điểm tăng mỗi lần
StatsTab:CreateInput({
   Name = "Số điểm tăng mỗi lần (mặc định 1)",
   PlaceholderText = "Nhập số (ví dụ: 3)",
   RemoveTextAfterFocusLost = false,
   Callback = function(input)
       local num = tonumber(input)
       if num then _G.AutoStatAmount = num end
   end,
})

-- Toggle bật/tắt
StatsTab:CreateToggle({
   Name = "Bật Auto Stats",
   CurrentValue = false,
   Callback = function(state)
       _G.AutoStatEnabled = state

       task.spawn(function()
           while _G.AutoStatEnabled do
               pcall(function()
                   game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", _G.AutoStatType, _G.AutoStatAmount)
               end)
               task.wait(1)
           end
       end)
   end,
})
