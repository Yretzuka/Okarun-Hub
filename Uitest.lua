--[[
Astro Hub UI
Tema: Space / Astro
Dibuat untuk Script Hub bergaya Rayfield
Bisa minimize dan reopen via tombol image yang draggable
]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Buat ScreenGui
local astroGui = Instance.new("ScreenGui")
astroGui.Name = "AstroHub"
astroGui.ResetOnSpawn = false
astroGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Frame utama
local main = Instance.new("Frame")
main.Name = "MainFrame"
main.Size = UDim2.new(0, 450, 0, 320)
main.Position = UDim2.new(0.5, -225, 0.5, -160)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = astroGui

-- Topbar
local topbar = Instance.new("Frame")
topbar.Name = "Topbar"
topbar.Size = UDim2.new(1, 0, 0, 30)
topbar.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
topbar.BorderSizePixel = 0
topbar.Parent = main

local title = Instance.new("TextLabel")
title.Text = "🚀 Astro Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, -40, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topbar

-- Tombol minimize
local btnMin = Instance.new("TextButton")
btnMin.Text = "—"
btnMin.Font = Enum.Font.GothamBold
btnMin.TextSize = 18
btnMin.TextColor3 = Color3.new(1, 1, 1)
btnMin.BackgroundTransparency = 1
btnMin.Size = UDim2.new(0, 30, 1, 0)
btnMin.Position = UDim2.new(1, -30, 0, 0)
btnMin.Parent = topbar

-- Tab bar
local tabs = Instance.new("Frame")
tabs.Name = "TabButtons"
tabs.Size = UDim2.new(1, 0, 0, 30)
tabs.Position = UDim2.new(0, 0, 0, 30)
tabs.BackgroundTransparency = 1
tabs.Parent = main

local tabNames = {"🚀 Home", "👨‍🚀 Scripts", "⭐ Settings"}
local content = Instance.new("Frame")
content.Name = "Content"
content.Size = UDim2.new(1, -10, 1, -70)
content.Position = UDim2.new(0, 5, 0, 65)
content.BackgroundTransparency = 1
content.Parent = main

-- Buat tab dan pages
for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton")
    btn.Name = "Tab"..i
    btn.Text = name
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Size = UDim2.new(1/#tabNames, -2, 1, -2)
    btn.Position = UDim2.new((i-1)/#tabNames, 1, 0, 1)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Parent = tabs

    local page = Instance.new("Frame")
    page.Name = "Page"..i
    page.Size = UDim2.new(1,0,1,0)
    page.BackgroundColor3 = Color3.fromRGB(25,25,45)
    page.Visible = (i==1)
    page.Parent = content

    local lbl = Instance.new("TextLabel")
    lbl.Text = "Content for "..name
    lbl.Size = UDim2.new(1,0,1,0)
    lbl.TextColor3 = Color3.new(1,1,1)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 18
    lbl.BackgroundTransparency = 1
    lbl.Parent = page

    btn.MouseButton1Click:Connect(function()
        for _, c in ipairs(content:GetChildren()) do
            c.Visible = false
        end
        page.Visible = true
    end)
end

-- Tombol open setelah minimize
local openBtn = Instance.new("ImageButton")
openBtn.Name = "OpenButton"
openBtn.Image = "rbxassetid://6031068433" -- Ganti dengan asset ID logo
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0, 10, 0.5, -25)
openBtn.BackgroundTransparency = 1
openBtn.Visible = false
openBtn.Active = true
openBtn.Draggable = true
openBtn.Parent = astroGui

-- Minimize logic
btnMin.MouseButton1Click:Connect(function()
    main.Visible = false
    openBtn.Visible = true
end)
openBtn.MouseButton1Click:Connect(function()
    main.Visible = true
    openBtn.Visible = false
end)
