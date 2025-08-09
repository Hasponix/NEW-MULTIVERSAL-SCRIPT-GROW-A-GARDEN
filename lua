-- 🐾 Pet Enlarger GUI (Proportional Scaling - No Shape Loss + Draggable)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- 📌 Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "PetEnlargerGUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- 📦 Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 100)
frame.Position = UDim2.new(0.5, -125, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true -- Needed for dragging
frame.Draggable = true -- Simple drag toggle
frame.Parent = gui

-- Corner radius
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "🐾 Pet Enlarger"
title.Font = Enum.Font.FredokaOne
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Parent = frame

-- Button
local enlargeBtn = Instance.new("TextButton")
enlargeBtn.Size = UDim2.new(0.8, 0, 0, 40)
enlargeBtn.Position = UDim2.new(0.1, 0, 0.45, 0)
enlargeBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 60)
enlargeBtn.Text = "Enlarge Pet x20"
enlargeBtn.Font = Enum.Font.FredokaOne
enlargeBtn.TextSize = 18
enlargeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
enlargeBtn.Parent = frame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = enlargeBtn

-- Hover effect
enlargeBtn.MouseEnter:Connect(function()
    TweenService:Create(enlargeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 160, 80)}):Play()
end)
enlargeBtn.MouseLeave:Connect(function()
    TweenService:Create(enlargeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 120, 60)}):Play()
end)

-- 📏 Perfect proportional enlargement function
local function enlargePet(petTool)
    if petTool:IsA("Model") then
        petTool:ScaleTo(20)
    elseif petTool:IsA("Tool") then
        for _, obj in ipairs(petTool:GetChildren()) do
            if obj:IsA("Model") then
                obj:ScaleTo(20)
            elseif obj:IsA("BasePart") then
                local mesh = obj:FindFirstChildOfClass("SpecialMesh")
                if mesh then
                    mesh.Scale = mesh.Scale * 20
                else
                    obj.Size = obj.Size * 20
                end
            end
        end
    end
end

-- 🖱 Button click event
enlargeBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if not char then return end
    local tool = char:FindFirstChildOfClass("Tool") or player.Backpack:FindFirstChildOfClass("Tool")
    if tool then
        enlargePet(tool)
    else
        warn("⚠ No pet/tool equipped to enlarge!")
    end
end)
