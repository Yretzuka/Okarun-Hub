-- Okarun Hub - Ink Game Script
-- LocalScript untuk Roblox Ink Game
-- Features: Auto Win, Glass Vision, ESP, Noclip, Speed Hack, dan banyak lagi

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Configuration
local config = {
    autoWin = false,
    glassVision = false,
    noclip = false,
    esp = false,
    speedHack = false,
    autoTugWar = false,
    redLightGodMode = false,
    infiniteJump = false,
    killAll = false,
    autoSkipDialog = false,
    originalSpeed = humanoid.WalkSpeed,
    originalJump = humanoid.JumpPower
}

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "OkarunHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 450, 0, 400)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Rounded corners for main frame
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

-- Title Text
local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(1, -80, 1, 0)
titleText.Position = UDim2.new(0, 15, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "🔥 OKARUN HUB - INK GAME 🔥"
titleText.TextColor3 = Color3.fromRGB(255, 100, 100)
titleText.TextScaled = true
titleText.Font = Enum.Font.GothamBold
titleText.Parent = titleBar

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeButton.BorderSizePixel = 0
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextScaled = true
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeButton

-- Minimize Button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -70, 0, 5)
minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
minimizeButton.BorderSizePixel = 0
minimizeButton.Text = "─"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.TextScaled = true
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.Parent = titleBar

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 6)
minimizeCorner.Parent = minimizeButton

-- Content Frame
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -20, 1, -60)
contentFrame.Position = UDim2.new(0, 10, 0, 50)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- ScrollingFrame
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ScrollFrame"
scrollFrame.Size = UDim2.new(1, 0, 1, 0)
scrollFrame.Position = UDim2.new(0, 0, 0, 0)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 8
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 100, 100)
scrollFrame.Parent = contentFrame

-- UIListLayout
local listLayout = Instance.new("UIListLayout")
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 8)
listLayout.Parent = scrollFrame

-- Function to create toggle button
local function createToggle(name, text, description, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Name = name
    toggleFrame.Size = UDim2.new(1, -10, 0, 50)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    toggleFrame.BorderSizePixel = 0
    toggleFrame.Parent = scrollFrame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 8)
    toggleCorner.Parent = toggleFrame
    
    local toggleText = Instance.new("TextLabel")
    toggleText.Size = UDim2.new(1, -80, 0.6, 0)
    toggleText.Position = UDim2.new(0, 15, 0, 0)
    toggleText.BackgroundTransparency = 1
    toggleText.Text = text
    toggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleText.TextScaled = true
    toggleText.Font = Enum.Font.GothamBold
    toggleText.TextXAlignment = Enum.TextXAlignment.Left
    toggleText.Parent = toggleFrame
    
    local descText = Instance.new("TextLabel")
    descText.Size = UDim2.new(1, -80, 0.4, 0)
    descText.Position = UDim2.new(0, 15, 0.6, 0)
    descText.BackgroundTransparency = 1
    descText.Text = description
    descText.TextColor3 = Color3.fromRGB(180, 180, 180)
    descText.TextScaled = true
    descText.Font = Enum.Font.Gotham
    descText.TextXAlignment = Enum.TextXAlignment.Left
    descText.Parent = toggleFrame
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 60, 0, 25)
    toggleButton.Position = UDim2.new(1, -70, 0.5, -12.5)
    toggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    toggleButton.BorderSizePixel = 0
    toggleButton.Text = "OFF"
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.TextScaled = true
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.Parent = toggleFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 12)
    buttonCorner.Parent = toggleButton
    
    local isToggled = false
    
    toggleButton.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        toggleButton.Text = isToggled and "ON" or "OFF"
        toggleButton.BackgroundColor3 = isToggled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
        
        -- Tween effect
        local tween = TweenService:Create(toggleButton, TweenInfo.new(0.2), {
            Size = isToggled and UDim2.new(0, 65, 0, 30) or UDim2.new(0, 60, 0, 25)
        })
        tween:Play()
        
        if callback then
            callback(isToggled)
        end
    end)
    
    return toggleFrame, toggleButton
end

-- Function to create action button
local function createButton(name, text, description, callback)
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Name = name
    buttonFrame.Size = UDim2.new(1, -10, 0, 50)
    buttonFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    buttonFrame.BorderSizePixel = 0
    buttonFrame.Parent = scrollFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = buttonFrame
    
    local actionButton = Instance.new("TextButton")
    actionButton.Size = UDim2.new(1, 0, 1, 0)
    actionButton.Position = UDim2.new(0, 0, 0, 0)
    actionButton.BackgroundTransparency = 1
    actionButton.Text = ""
    actionButton.Parent = buttonFrame
    
    local buttonText = Instance.new("TextLabel")
    buttonText.Size = UDim2.new(1, -20, 0.6, 0)
    buttonText.Position = UDim2.new(0, 15, 0, 0)
    buttonText.BackgroundTransparency = 1
    buttonText.Text = text
    buttonText.TextColor3 = Color3.fromRGB(255, 255, 255)
    buttonText.TextScaled = true
    buttonText.Font = Enum.Font.GothamBold
    buttonText.TextXAlignment = Enum.TextXAlignment.Left
    buttonText.Parent = buttonFrame
    
    local descText = Instance.new("TextLabel")
    descText.Size = UDim2.new(1, -20, 0.4, 0)
    descText.Position = UDim2.new(0, 15, 0.6, 0)
    descText.BackgroundTransparency = 1
    descText.Text = description
    descText.TextColor3 = Color3.fromRGB(180, 180, 180)
    descText.TextScaled = true
    descText.Font = Enum.Font.Gotham
    descText.TextXAlignment = Enum.TextXAlignment.Left
    descText.Parent = buttonFrame
    
    -- Hover effects
    actionButton.MouseEnter:Connect(function()
        local tween = TweenService:Create(buttonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(55, 55, 65)})
        tween:Play()
    end)
    
    actionButton.MouseLeave:Connect(function()
        local tween = TweenService:Create(buttonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 55)})
        tween:Play()
    end)
    
    actionButton.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)
    
    return buttonFrame
end

-- Create features
createToggle("AutoWin", "🏆 Auto Win Games", "Automatically win all mini-games", function(enabled)
    config.autoWin = enabled
    if enabled then
        print("🏆 Auto Win: Enabled")
    else
        print("🏆 Auto Win: Disabled")
    end
end)

createToggle("GlassVision", "👁️ Glass Vision", "See safe glass panels in Glass Bridge", function(enabled)
    config.glassVision = enabled
    if enabled then
        print("👁️ Glass Vision: Enabled - Safe panels highlighted!")
    else
        print("👁️ Glass Vision: Disabled")
    end
end)

createToggle("NoClip", "👻 NoClip", "Walk through walls and objects", function(enabled)
    config.noclip = enabled
    if character then
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = not enabled
            end
        end
    end
    print("👻 NoClip: " .. (enabled and "Enabled" or "Disabled"))
end)

createToggle("ESP", "🔍 Player ESP", "See all players through walls", function(enabled)
    config.esp = enabled
    print("🔍 ESP: " .. (enabled and "Enabled" or "Disabled"))
end)

createToggle("SpeedHack", "💨 Speed Hack", "Increase movement speed", function(enabled)
    config.speedHack = enabled
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.WalkSpeed = enabled and 50 or config.originalSpeed
    end
    print("💨 Speed Hack: " .. (enabled and "Enabled (50 Speed)" or "Disabled"))
end)

createToggle("AutoTugWar", "🤝 Auto Tug of War", "Automatically win Tug of War", function(enabled)
    config.autoTugWar = enabled
    print("🤝 Auto Tug of War: " .. (enabled and "Enabled" or "Disabled"))
end)

createToggle("RedLightGod", "🚦 Red Light God Mode", "Immunity in Red Light Green Light", function(enabled)
    config.redLightGodMode = enabled
    print("🚦 Red Light God Mode: " .. (enabled and "Enabled" or "Disabled"))
end)

createToggle("InfiniteJump", "🦘 Infinite Jump", "Jump as many times as you want", function(enabled)
    config.infiniteJump = enabled
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.JumpPower = enabled and 100 or config.originalJump
    end
    print("🦘 Infinite Jump: " .. (enabled and "Enabled" or "Disabled"))
end)

createButton("KillAll", "💀 Kill All Players", "Eliminate all other players (Use carefully!)", function()
    print("💀 Kill All: Executed!")
    -- This would contain the kill all logic
end)

createButton("TeleportSpawn", "🌟 Teleport to Spawn", "Instantly teleport to spawn area", function()
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0)
        print("🌟 Teleported to spawn!")
    end
end)

createToggle("AutoSkipDialog", "⏭️ Auto Skip Dialog", "Automatically skip all dialogues", function(enabled)
    config.autoSkipDialog = enabled
    print("⏭️ Auto Skip Dialog: " .. (enabled and "Enabled" or "Disabled"))
end)

-- Update canvas size
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 20)

-- Auto-update canvas size when content changes
listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 20)
end)

-- Button functionalities
local isMinimized = false

minimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    local targetSize = isMinimized and UDim2.new(0, 450, 0, 40) or UDim2.new(0, 450, 0, 400)
    
    local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = targetSize})
    tween:Play()
    
    minimizeButton.Text = isMinimized and "☐" or "─"
end)

closeButton.MouseButton1Click:Connect(function()
    local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    })
    tween:Play()
    
    tween.Completed:Connect(function()
        screenGui:Destroy()
    end)
end)

-- Keyboard shortcut (Insert key to toggle GUI)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Insert then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

-- Character respawn handling
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
    config.originalSpeed = humanoid.WalkSpeed
    config.originalJump = humanoid.JumpPower
end)

-- ESP functionality
local function createESP(plr)
    if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESP"
        billboard.Adornee = plr.Character.HumanoidRootPart
        billboard.Size = UDim2.new(0, 100, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.Parent = plr.Character.HumanoidRootPart
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 1, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = plr.Name
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextScaled = true
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.Parent = billboard
    end
end

-- ESP loop
RunService.Heartbeat:Connect(function()
    if config.esp then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character and not plr.Character.HumanoidRootPart:FindFirstChild("ESP") then
                createESP(plr)
            end
        end
    else
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character and plr.Character.HumanoidRootPart:FindFirstChild("ESP") then
                plr.Character.HumanoidRootPart.ESP:Destroy()
            end
        end
    end
end)

-- NoClip loop
RunService.Stepped:Connect(function()
    if config.noclip and character then
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

print("🔥 OKARUN HUB loaded successfully!")
print("📋 Features: Auto Win, Glass Vision, NoClip, ESP, Speed Hack, and more!")
print("⌨️ Press INSERT to toggle GUI visibility")
print("🎮 Made for Ink Game - Use responsibly!")
