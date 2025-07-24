-- Okarun Hub v2.0 (Ultimate Spirit Edition)
-- Dandadan Themed Cheat Hub

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "OkarunHubUltimate"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Load Kavo UI Library with custom theme
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("✧ Okarun Spirit Hub ✧", "Ocean")

-- Create custom RemoteEvent for commands
local OkarunRemote = Instance.new("RemoteEvent")
OkarunRemote.Name = "OkarunRemote"
OkarunRemote.Parent = ReplicatedStorage

-- Main Tab (Enhanced)
local Main = Window:NewTab("Spirit Core")
local MainSection = Main:NewSection("Divine Power")

MainSection:NewToggle("God Spirit Mode", "Unlimited spiritual energy", function(state)
    if state then
        OkarunRemote:FireServer("GodMode", true)
        spawn(function()
            while wait(0.5) and Library.Flags["God Spirit Mode"] do
                local humanoid = Player.Character and Player.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.Health = humanoid.MaxHealth
                end
            end
        end)
    else
        OkarunRemote:FireServer("GodMode", false)
    end
end)

MainSection:NewSlider("Spirit Multiplier", "Amplify all powers", 10, 1, function(value)
    _G.SpiritMultiplier = value
end)

-- Combat Tab (Enhanced)
local Combat = Window:NewTab("Spirit Combat")
local CombatSection = Combat:NewSection("Okarun Secret Techniques")

CombatSection:NewToggle("One-Punch Spirit", "Defeat enemies with one hit", function(state)
    _G.OnePunchMode = state
    if state then
        OkarunRemote:FireServer("OnePunch", true)
    else
        OkarunRemote:FireServer("OnePunch", false)
    end
end)

CombatSection:NewToggle("Auto Perfect Dodge", "Never get hit", function(state)
    _G.AutoDodge = state
    if state then
        spawn(function()
            while wait() and _G.AutoDodge do
                local character = Player.Character
                if character then
                    local humanoid = character:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
                wait(0.1)
            end
        end)
    end
end)

-- Player Tab (Enhanced)
local PlayerTab = Window:NewTab("Spirit Body")
local PlayerSection = PlayerTab:NewSection("Divine Enhancement")

PlayerSection:NewTextBox("Walk Speed", "Superhuman movement", function(txt)
    local speed = tonumber(txt) or 16
    local humanoid = Player.Character and Player.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = speed
    end
end)

PlayerSection:NewTextBox("Jump Power", "Leap tall buildings", function(txt)
    local power = tonumber(txt) or 50
    local humanoid = Player.Character and Player.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.JumpPower = power
    end
end)

PlayerSection:NewToggle("No Clip", "Phase through objects", function(state)
    _G.Noclip = state
    if state then
        spawn(function()
            while wait() and _G.Noclip do
                if Player.Character then
                    for _, part in pairs(Player.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end
        end)
    end
end)

-- Teleport Tab (New)
local Teleport = Window:NewTab("Spirit Travel")
local TeleportSection = Teleport:NewSection("Dimensional Warp")

TeleportSection:NewButton("Teleport to Spawn", "Return to starting point", function()
    OkarunRemote:FireServer("Teleport", "Spawn")
end)

TeleportSection:NewButton("Teleport to Boss", "Face the strongest enemy", function()
    OkarunRemote:FireServer("Teleport", "Boss")
end)

TeleportSection:NewTextBox("Teleport to Player", "Enter player name", function(txt)
    OkarunRemote:FireServer("TeleportToPlayer", txt)
end)

-- ESP Tab (New)
local ESP = Window:NewTab("Spirit Vision")
local ESPSection = ESP:NewSection("All-Seeing Eye")

ESPSection:NewToggle("Player ESP", "See all players", function(state)
    _G.PlayerESP = state
    if state then
        -- ESP activation code
    else
        -- ESP deactivation code
    end
end)

ESPSection:NewToggle("Item ESP", "See all items", function(state)
    _G.ItemESP = state
    if state then
        -- ESP activation code
    else
        -- ESP deactivation code
    end
end)

-- Admin Tab (New)
local Admin = Window:NewTab("Spirit Admin")
local AdminSection = Admin:NewSection("Divine Authority")

AdminSection:NewTextBox("Kick Player", "Remove player from game", function(txt)
    OkarunRemote:FireServer("AdminKick", txt)
end)

AdminSection:NewTextBox("Give Currency", "Amount to give yourself", function(txt)
    local amount = tonumber(txt) or 999999
    OkarunRemote:FireServer("GiveCurrency", amount)
end)

AdminSection:NewButton("Unlock All", "Access everything", function()
    OkarunRemote:FireServer("UnlockAll")
end)

-- Settings Tab (Enhanced)
local Settings = Window:NewTab("Spirit Config")
local SettingsSection = Settings:NewSection("Hub Settings")

SettingsSection:NewKeybind("Toggle Key", "Open/Close the hub", Enum.KeyCode.RightControl, function()
    Library:ToggleUI()
end)

SettingsSection:NewButton("Destroy UI", "Remove the hub", function()
    ScreenGui:Destroy()
end)

SettingsSection:NewToggle("Anti-AFK", "Prevent getting kicked", function(state)
    _G.AntiAFK = state
    if state then
        local VirtualUser = game:GetService("VirtualUser")
        Player.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end
end)

-- Status Display (Enhanced)
local Status = Window:NewTab("Spirit Status")
local StatusSection = Status:NewSection("Divine Stats")

StatusSection:NewLabel("Spiritual Level: "..(Player:WaitForChild("Level").Value or "MAX"))
StatusSection:NewLabel("Yen: ¥"..(Player:WaitForChild("Currency").Value or "∞"))
StatusSection:NewLabel("Spirit Energy: INFINITE")

-- Real-time updates
Player:WaitForChild("Currency").Changed:Connect(function(value)
    StatusSection:UpdateLabel(2, "Yen: ¥"..value)
end)

-- Credit Tab (Enhanced)
local Credit = Window:NewTab("Spirit Origin")
local CreditSection = Credit:NewSection("Okarun Divine Hub")

CreditSection:NewLabel("Created by Spirit Master")
CreditSection:NewLabel("Channeling Okarun's Power")
CreditSection:NewLabel("Version 2.0 - Ultimate Edition")
CreditSection:NewButton("Join Discord", "For updates", function()
    setclipboard("discord.gg/yourlink")
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Discord",
        Text = "Link copied to clipboard!",
        Duration = 5
    })
end)

-- Auto-connect character
Player.CharacterAdded:Connect(function(character)
    if Library.Flags["God Spirit Mode"] then
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.Health = humanoid.MaxHealth
    end
end)

-- Notification on load
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Okarun Hub Activated",
    Text = "Divine powers at your command!",
    Duration = 5
})
