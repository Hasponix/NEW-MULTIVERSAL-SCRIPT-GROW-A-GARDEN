local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- 🐾 Extra functions for visual pet level update
local function updatePetVisual(tool, newWeight, newAge)
    local handle = tool:FindFirstChild("Handle") or tool:FindFirstChildWhichIsA("Part")
    if handle then
        local billboard = handle:FindFirstChildWhichIsA("BillboardGui", true)
        if billboard then
            local label = billboard:FindFirstChildWhichIsA("TextLabel", true)
            if label then
                label.Text = string.format("Age %d | %.2f KG", newAge, newWeight)
            end
        end
    end
end

local function animateAgeIncrease(tool, startAge, targetAge, weight)
    local current = startAge
    while current < targetAge do
        current += 1
        tool.Name = string.gsub(tool.Name, "%[Age %d+%]", "[Age " .. current .. "]")
        updatePetVisual(tool, weight, current)
        task.wait(0.05)
    end
end

-- GUI Setup
local playerGui = player:WaitForChild("PlayerGui", 15)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GardenGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 100) -- adjusted for credit
mainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true -- make UI draggable

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.3, 0)
title.BackgroundTransparency = 1
title.Text = "Grow A Garden Age Lvl Instant"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.Parent = mainFrame

local updateButton = Instance.new("TextButton")
updateButton.Size = UDim2.new(1, -20, 0.4, 0)
updateButton.Position = UDim2.new(0, 10, 0.35, 0)
updateButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
updateButton.Text = "Level Up 50 instantly"
updateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
updateButton.Font = Enum.Font.GothamBold
updateButton.TextSize = 14
updateButton.Parent = mainFrame

-- Credit Label
local credit = Instance.new("TextLabel")
credit.Size = UDim2.new(1, 0, 0.2, 0)
credit.Position = UDim2.new(0, 0, 0.8, 0)
credit.BackgroundTransparency = 1
credit.Text = "Made by Xensei Pogi"
credit.TextColor3 = Color3.fromRGB(180, 180, 180)
credit.Font = Enum.Font.Gotham
credit.TextSize = 12
credit.Parent = mainFrame

-- Button Logic
updateButton.MouseButton1Click:Connect(function()
    local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
    if not tool then
        warn("No pet equipped!")
        return
    end

    local currentAge = tonumber(string.match(tool.Name, "%[Age (%d+)%]")) or 0
    local newAge = currentAge + 50
    local newWeight = math.random(5, 15) -- Random weight example

    local newName = string.gsub(tool.Name, "%[Age %d+%]", "[Age " .. newAge .. "]")
    tool.Name = newName

    updatePetVisual(tool, newWeight, newAge)
    animateAgeIncrease(tool, currentAge, newAge, newWeight)
end)
