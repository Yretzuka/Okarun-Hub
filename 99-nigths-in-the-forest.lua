-- Astro Hub v2.2 (99 Nights in the Forest) - PROPER REVIVE FIX
-- Fixed God Mode & Auto Revive with Bandages/Medkits
-- Updated: 2025-08-06

loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Get the correct remotes
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local DamageRemote = Remotes:WaitForChild("Damage") or Remotes:WaitForChild("DealDamage")
local UseItemRemote = Remotes:WaitForChild("UseItem") or Remotes:WaitForChild("ApplyItem")

-- Toggle values
_G = {
    AUTO_CAMPFIRE = false,
    KILL_AURA = false,
    SAVE_KID = false,
    AUTO_REVIVE = false,
    GOD_MODE = false,
    AUTO_EAT = false,
    GOD_MODE_CONNECTION = nil,
    REVIVE_ITEM = "Bandage" -- Change to "Medkit" if preferred
}

-- UI Setup
local Window = Rayfield:CreateWindow({
    Name = "Astro Hub v2.2 | 99 Nights in the Forest",
    LoadingTitle = "Astro Hub",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "AstroHub",
        FileName = "AstroConfig"
    },
    KeySystem = false,
})

-- Main Tab
local MainTab = Window:CreateTab("Main Features", 4483362458)

-- ... (other features remain the same) ...

MainTab:CreateToggle({
    Name = "God Mode (True Invincibility)",
    CurrentValue = false,
    Callback = function(Value)
        _G.GOD_MODE = Value
        if Value then
            -- Create damage interception
            if not _G.GOD_MODE_CONNECTION then
                _G.GOD_MODE_CONNECTION = Humanoid.HealthChanged:Connect(function()
                    if _G.GOD_MODE and Humanoid.Health < Humanoid.MaxHealth then
                        Humanoid.Health = Humanoid.MaxHealth
                    end
                end)
            end
            
            -- Set initial health
            Humanoid.Health = Humanoid.MaxHealth
        elseif _G.GOD_MODE_CONNECTION then
            -- Clean up connection
            _G.GOD_MODE_CONNECTION:Disconnect()
            _G.GOD_MODE_CONNECTION = nil
        end
    end,
})

MainTab:CreateToggle({
    Name = "Auto Revive with ".._G.REVIVE_ITEM,
    CurrentValue = false,
    Callback = function(Value)
        _G.AUTO_REVIVE = Value
    end,
})

-- Dropdown to select revive item
MainTab:CreateDropdown({
    Name = "Revive Item",
    Options = {"Bandage", "Medkit"},
    CurrentOption = _G.REVIVE_ITEM,
    Callback = function(Option)
        _G.REVIVE_ITEM = Option
    end,
})

-- Feature Loops

-- True God Mode with damage prevention
task.spawn(function()
    while task.wait(0.1) do
        if _G.GOD_MODE and Character and Humanoid then
            -- Maintain max health
            if Humanoid.Health < Humanoid.MaxHealth then
                Humanoid.Health = Humanoid.MaxHealth
            end
            
            -- Prevent death states
            if Humanoid:GetState() == Enum.HumanoidStateType.Dead then
                Humanoid:ChangeState(Enum.HumanoidStateType.Running)
            end
        end
    end
end)

-- Proper Auto Revive with Bandages/Medkits
task.spawn(function()
    while task.wait(3) do
        if _G.AUTO_REVIVE and UseItemRemote then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local char = player.Character
                    if char then
                        local hum = char:FindFirstChild("Humanoid")
                        if hum and hum.Health <= 0 then
                            pcall(function()
                                -- Approach the player first
                                local root = Character:FindFirstChild("HumanoidRootPart")
                                local targetRoot = char:FindFirstChild("HumanoidRootPart")
                                
                                if root and targetRoot then
                                    -- Move closer if needed
                                    if (root.Position - targetRoot.Position).Magnitude > 10 then
                                        Character:SetPrimaryPartCFrame(CFrame.new(targetRoot.Position + Vector3.new(0, 3, 0)))
                                        task.wait(0.5)
                                    end
                                    
                                    -- Use revive item on the player
                                    UseItemRemote:FireServer(_G.REVIVE_ITEM, player)
                                end
                            end)
                        end
                    end
                end
            end
        end
    end
end)

-- Character reinitialization
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
    
    -- Reapply God Mode connection
    if _G.GOD_MODE then
        if _G.GOD_MODE_CONNECTION then
            _G.GOD_MODE_CONNECTION:Disconnect()
        end
        
        _G.GOD_MODE_CONNECTION = Humanoid.HealthChanged:Connect(function()
            if _G.GOD_MODE then
                Humanoid.Health = Humanoid.MaxHealth
            end
        end)
    end
end)

print("[Astro Hub v2.2] Loaded with PROPER Revive System and God Mode!")
