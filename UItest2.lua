--// Storytime Hub by Granny 🌻
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Create the ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "StorytimeHub"
screenGui.Parent = PlayerGui
screenGui.Enabled = false -- Hidden until H pressed

-- Main Frame (Once upon a GUI...)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 180, 120) -- Marmalade
mainFrame.BackgroundTransparency = 0.1
mainFrame.Visible = false
mainFrame.Parent = screenGui
mainFrame.ClipsDescendants = true

-- UI corner for smooth edges
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = mainFrame

-- Title
local titleLabel = Instance.new("TextLabel")
titleLabel.Text = "Once upon a GUI..."
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 28
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.BackgroundTransparency = 1
titleLabel.Parent = mainFrame

-- Sidebar
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 150, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(150, 80, 200) -- Twilight Purple
sidebar.Parent = mainFrame

local sidebarCorner = Instance.new("UICorner")
sidebarCorner.CornerRadius = UDim.new(0, 15)
sidebarCorner.Parent = sidebar

-- Function to make cozy buttons
local function createButton(text)
    local btn = Instance.new("TextButton")
    btn.Text = text
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 20
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(200, 120, 80)
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, 0)

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn

    -- Hover animation
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 160, 100)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(200, 120, 80)}):Play()
    end)

    return btn
end

-- Add buttons
local toolsBtn = createButton("Tools")
toolsBtn.Position = UDim2.new(0, 10, 0, 60)
toolsBtn.Parent = sidebar

local settingsBtn = createButton("Settings")
settingsBtn.Position = UDim2.new(0, 10, 0, 110)
settingsBtn.Parent = sidebar

local goodiesBtn = createButton("Goodies")
goodiesBtn.Position = UDim2.new(0, 10, 0, 160)
goodiesBtn.Parent = sidebar

-- VIP Crown Button
local vipBtn = createButton("👑 VIP Crown")
vipBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0) -- Gold
vipBtn.Position = UDim2.new(0, 10, 0, 210)
vipBtn.Parent = sidebar

-- Sparkle effect on click
vipBtn.MouseButton1Click:Connect(function()
    local particle = Instance.new("ParticleEmitter")
    particle.Texture = "rbxassetid://241876772" -- Sparkle texture
    particle.Lifetime = NumberRange.new(1)
    particle.Rate = 20
    particle.Speed = NumberRange.new(1, 2)
    particle.Parent = vipBtn
    task.delay(1.5, function() particle:Destroy() end)
end)

-- Slide transition for showing/hiding
local function toggleHub()
    if mainFrame.Visible then
        TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Position = UDim2.new(1, 0, 0.5, -150)}):Play()
        task.wait(0.4)
        mainFrame.Visible = false
        screenGui.Enabled = false
    else
        screenGui.Enabled = true
        mainFrame.Position = UDim2.new(1, 0, 0.5, -150)
        mainFrame.Visible = true
        TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Position = UDim2.new(0.5, -250, 0.5, -150)}):Play()
    end
end

-- H key listener
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.H then
        toggleHub()
    end
end)

-- Save settings example
settingsBtn.MouseButton1Click:Connect(function()
    player:SetAttribute("StorytimeSetting", true)
end)
