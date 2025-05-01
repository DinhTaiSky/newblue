-- Tạo menu với hình ảnh và avatar đẹp
local Window = Rayfield:CreateWindow({
   Name = "Blox Fruits Script Menu",
   LoadingTitle = "Blox Fruits Hub",
   LoadingSubtitle = "Auto Farm & More",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "BloxFruitsUI",
      FileName = "Config"
   },
   Image = "https://images.search.yahoo.com/search/images;_ylt=AwrgwHwLaBNoQI4DBgRXNyoA;_ylu=Y29sbwNncTEEcG9zAzEEdnRpZAMEc2VjA3Nj?type=E210US91215G0&p=avatar+ff&fr=mcafee&th=474&tw=474&imgurl=https%3A%2F%2Fantimatter.vn%2Fwp-content%2Fuploads%2F2023%2F02%2Fhinh-anh-avatar-ff.jpg&rurl=https%3A%2F%2Fantimatter.vn%2Fhinh-anh-avatar-ff%2F&size=259KB&name=5000%2B+H%C3%ACnh+%E1%BA%A2nh+Avatar+FF+%C4%90%E1%BA%B9p%2C+Ch%E1%BA%A5t%2C+Ng%E1%BA%A7u+Qu%C3%AAn+C%E1%BA%A3+S%E1%BA%A7u&oid=3&h=987&w=987&turl=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.54H5rMVKQbOhtjLaUzvLKgHaHa%26pid%3DApi&tt=5000%2B+H%C3%ACnh+%E1%BA%A2nh+Avatar+FF+%C4%90%E1%BA%B9p%2C+Ch%E1%BA%A5t%2C+Ng%E1%BA%A7u+Qu%C3%AAn+C%E1%BA%A3+S%E1%BA%A7u&sigr=yqHqEw0_bHvo&sigit=B_RvpTCdqrHV&sigi=1sFiqihVUTUz&sign=jObE5JtIIuHI&sigt=jObE5JtIIuHI",  -- Thay URL hình ảnh của bạn vào đây
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

-- Tab Auto Stats
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

-- Tab Auto Raid
local AutoRaidTab = Window:CreateTab("Auto Raid", 4483362458)

-- Danh sách đảo
local Islands = {
    "Island1", "Island2", "Island3", "Island4", "Island5"  -- Thay thế với tên đảo thực tế
}

-- Chọn loại vũ khí
AutoRaidTab:CreateDropdown({
   Name = "Chọn Loại Vũ Khí",
   Options = {"Melee", "Sword", "Gun"},
   CurrentOption = "Melee",
   Callback = function(option)
       _G.SelectedWeaponGroup = option
   end,
})

-- Toggle Auto Raid
AutoRaidTab:CreateToggle({
   Name = "Bắt Đầu Auto Raid",
   CurrentValue = false,
   Callback = function(Value)
       _G.AutoRaid = Value

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

       -- Hàm farm quái
       local function FarmEnemiesOnIsland(islandName)
           local island = workspace:FindFirstChild(islandName)
           if not island then return end

           -- Di chuyển đến đảo
           game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = island.CFrame

           -- Farm quái trong khi không có boss
           while _G.AutoRaid and island:FindFirstChild("Enemies") do
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
               task.wait(0.5)
           end
       end

       -- Hàm tìm boss trên đảo
       local function GetBoss(islandName)
           local island = workspace:FindFirstChild(islandName)
           if island then
               for _, boss in pairs(island:GetChildren()) do
                   if boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                       return boss
                   end
               end
           end
           return nil
       end

       -- Hàm farm boss
       local function FarmBossOnIsland(islandName)
           local boss = GetBoss(islandName)
           if boss then
               local char = game.Players.LocalPlayer.Character
               if char and char:FindFirstChild("HumanoidRootPart") then
                   -- Dịch chuyển lên boss
                   char.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)

                   -- Trang bị và đánh
                   local tool = EquipWeaponAuto()
                   if tool then
                       tool:Activate()
                   end
               end
           end
       end

       -- Vòng lặp farm raid
       task.spawn(function()
           for _, islandName in ipairs(Islands) do
               if not _G.AutoRaid then break end

               -- Farm quái trên đảo
               FarmEnemiesOnIsland(islandName)

               -- Farm boss trên đảo
               FarmBossOnIsland(islandName)

               -- Chờ một chút trước khi chuyển sang đảo tiếp theo
               task.wait(3)
           end
       end)
   end,
})
