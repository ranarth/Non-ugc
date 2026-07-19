--[[
    RANARTH THEME - SUPER RING (SUB-PANEL ONLY)
    Cleaned, Deobfuscated, and Themed by AI
]]

local plrs = game:GetService("Players")
local runs = game:GetService("RunService")
local tweens = game:GetService("TweenService")
local uis = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local workspace = game:GetService("Workspace")

local lp = plrs.LocalPlayer
if not lp then
    plrs:GetPropertyChangedSignal("LocalPlayer"):Wait()
    lp = plrs.LocalPlayer
end

-- ==========================================
-- 🎨 RANARTH ANIMATED STROKE SETUP
-- ==========================================
local allGrads = {}
local RANARTH_STROKE_CS = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 44, 75)),
    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(100, 150, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(220, 255, 255)),
    ColorSequenceKeypoint.new(0.7, Color3.fromRGB(100, 150, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 44, 75)),
})

local function animStroke(parent, thick)
    local s = Instance.new("UIStroke")
    s.Thickness = thick or 1
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Color = Color3.new(1, 1, 1)
    s.Parent = parent
    
    local g = Instance.new("UIGradient")
    g.Color = RANARTH_STROKE_CS
    g.Rotation = 45
    g.Parent = s
    table.insert(allGrads, g)
    return s
end

local guiParent = nil
pcall(function()
    if gethui then guiParent = gethui() else guiParent = game:GetService("CoreGui") end
end)
if not guiParent then guiParent = lp:FindFirstChild("PlayerGui") or lp:WaitForChild("PlayerGui", 5) end

-- Cleanup old GUI
if getgenv().RanarthRingRender then getgenv().RanarthRingRender:Disconnect() end
pcall(function()
    for _, v in pairs(guiParent:GetChildren()) do
        if string.find(v.Name, "Ranarth_Ring_GUI") then v:Destroy() end
    end
end)

-- ==========================================
-- 🖥️ GUI CREATION (TUTORIAL SUB-PANEL STYLE)
-- ==========================================
local gui = Instance.new("ScreenGui")
gui.Name = "Ranarth_Ring_GUI"
gui.Parent = guiParent
gui.ResetOnSpawn = false

-- Main Frame (Sub-Panel)
local tutFrame = Instance.new("Frame", gui)
tutFrame.Size = UDim2.new(0, 240, 0, 140) -- Diperkecil karena isinya lebih sedikit
tutFrame.Position = UDim2.new(0.5, -120, 0.5, -70)
tutFrame.BackgroundColor3 = Color3.fromRGB(10, 11, 16)
tutFrame.BorderSizePixel = 0
tutFrame.Active = true
tutFrame.ClipsDescendants = true
Instance.new("UICorner", tutFrame).CornerRadius = UDim.new(0, 10)
animStroke(tutFrame, 1.5)

-- Top Bar
local tut_top_bar = Instance.new("Frame", tutFrame)
tut_top_bar.Size = UDim2.new(1, 0, 0, 30)
tut_top_bar.BackgroundColor3 = Color3.fromRGB(14, 20, 40)
tut_top_bar.BorderSizePixel = 0
Instance.new("UICorner", tut_top_bar).CornerRadius = UDim.new(0, 10)

-- Fix bottom corners of Top Bar
local tut_top_bar_ext = Instance.new("Frame", tut_top_bar)
tut_top_bar_ext.Size = UDim2.new(1, 0, 0, 5)
tut_top_bar_ext.Position = UDim2.new(0, 0, 1, -5)
tut_top_bar_ext.BackgroundColor3 = Color3.fromRGB(14, 20, 40)
tut_top_bar_ext.BorderSizePixel = 0

-- Title
local tutTitle = Instance.new("TextLabel", tut_top_bar)
tutTitle.Text = "RANARTH RING"
tutTitle.Size = UDim2.new(1, -65, 1, 0)
tutTitle.Position = UDim2.new(0, 10, 0, 0)
tutTitle.BackgroundTransparency = 1
tutTitle.TextColor3 = Color3.new(1, 1, 1)
tutTitle.Font = Enum.Font.GothamBold
tutTitle.TextSize = 10
tutTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Controls Layout (Top Right)
local control_buttons = Instance.new("Frame", tut_top_bar)
control_buttons.Size = UDim2.new(0, 60, 1, 0)
control_buttons.Position = UDim2.new(1, -65, 0, 0)
control_buttons.BackgroundTransparency = 1

local control_layout = Instance.new("UIListLayout", control_buttons)
control_layout.FillDirection = Enum.FillDirection.Horizontal
control_layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
control_layout.VerticalAlignment = Enum.VerticalAlignment.Center
control_layout.Padding = UDim.new(0, 5)

-- Header Button Function
local function create_header_btn(text, color, callback)
    local btn = Instance.new("TextButton", control_buttons)
    btn.Size = UDim2.new(0, 24, 0, 24)
    btn.BackgroundColor3 = Color3.fromRGB(25, 28, 40)
    btn.Text = text
    btn.TextColor3 = color
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    
    btn.MouseEnter:Connect(function() tweens:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(35, 40, 55)}):Play() end)
    btn.MouseLeave:Connect(function() tweens:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(25, 28, 40)}):Play() end)
    btn.MouseButton1Click:Connect(callback)
end

-- Minimize & Close Actions (No Toggle Button)
local isMinimized = false
create_header_btn("-", Color3.fromRGB(200, 200, 200), function()
    isMinimized = not isMinimized
    if isMinimized then
        tweens:Create(tutFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 240, 0, 30)}):Play()
    else
        tweens:Create(tutFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 240, 0, 140)}):Play()
    end
end)

create_header_btn("X", Color3.fromRGB(255, 80, 80), function()
    if getgenv().RanarthRingRender then getgenv().RanarthRingRender:Disconnect() end
    gui:Destroy()
end)

-- Content Frame
local ContentFrame = Instance.new("Frame", tutFrame)
ContentFrame.Size = UDim2.new(1, -20, 1, -40)
ContentFrame.Position = UDim2.new(0, 10, 0, 40)
ContentFrame.BackgroundTransparency = 1

local content_layout = Instance.new("UIListLayout", ContentFrame)
content_layout.SortOrder = Enum.SortOrder.LayoutOrder
content_layout.Padding = UDim.new(0, 8)

-- Base Styling for Buttons
local function StyleButton(btn)
    btn.BackgroundColor3 = Color3.fromRGB(22, 26, 44)
    btn.TextColor3 = Color3.fromRGB(200, 210, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    animStroke(btn, 1.2)
    
    btn.MouseEnter:Connect(function() tweens:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(35, 40, 55)}):Play() end)
    btn.MouseLeave:Connect(function() tweens:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(22, 26, 44)}):Play() end)
end

-- Toggle Ring Button
local ToggleBtn = Instance.new("TextButton", ContentFrame)
ToggleBtn.Size = UDim2.new(1, 0, 0, 35)
ToggleBtn.Text = "▶ ENABLE RING PARTS"
StyleButton(ToggleBtn)

-- Radius Controls Container
local RadiusContainer = Instance.new("Frame", ContentFrame)
RadiusContainer.Size = UDim2.new(1, 0, 0, 35)
RadiusContainer.BackgroundTransparency = 1

-- Decrease Radius Button
local DecRadiusBtn = Instance.new("TextButton", RadiusContainer)
DecRadiusBtn.Size = UDim2.new(0.2, 0, 1, 0)
DecRadiusBtn.Position = UDim2.new(0, 0, 0, 0)
DecRadiusBtn.Text = "<"
StyleButton(DecRadiusBtn)

-- Increase Radius Button
local IncRadiusBtn = Instance.new("TextButton", RadiusContainer)
IncRadiusBtn.Size = UDim2.new(0.2, 0, 1, 0)
IncRadiusBtn.Position = UDim2.new(0.8, 0, 0, 0)
IncRadiusBtn.Text = ">"
StyleButton(IncRadiusBtn)

-- Radius Display Label
local RadiusLabel = Instance.new("TextLabel", RadiusContainer)
RadiusLabel.Size = UDim2.new(0.55, 0, 1, 0)
RadiusLabel.Position = UDim2.new(0.225, 0, 0, 0)
RadiusLabel.BackgroundColor3 = Color3.fromRGB(22, 26, 44)
RadiusLabel.TextColor3 = Color3.fromRGB(200, 210, 255)
RadiusLabel.Font = Enum.Font.GothamBold
RadiusLabel.TextSize = 11
RadiusLabel.Text = "Radius: 50"
Instance.new("UICorner", RadiusLabel).CornerRadius = UDim.new(0, 6)
animStroke(RadiusLabel, 1.2)

-- ==========================================
-- 🔄 ANIMATION & DRAGGING LOGIC
-- ==========================================
getgenv().RanarthRingRender = runs.RenderStepped:Connect(function()
    local off = Vector2.new(math.sin(tick() * 2.8), 0)
    for _, g in ipairs(allGrads) do 
        if g and g.Parent then 
            g.Rotation = (g.Rotation + 2) % 360
            g.Offset = off 
        end 
    end
end)

local tDrag, tDragStart, tStartPos
tut_top_bar.InputBegan:Connect(function(input) 
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
        tDrag = true
        tDragStart = input.Position
        tStartPos = tutFrame.Position 
    end 
end)
uis.InputChanged:Connect(function(input) 
    if tDrag and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then 
        local delta = input.Position - tDragStart
        tutFrame.Position = UDim2.new(tStartPos.X.Scale, tStartPos.X.Offset + delta.X, tStartPos.Y.Scale, tStartPos.Y.Offset + delta.Y) 
    end 
end)
tut_top_bar.InputEnded:Connect(function(input) 
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
        tDrag = false 
    end 
end)

-- ==========================================
-- ⚙️ RING PARTS LOGIC
-- ==========================================
if not getgenv().Network then
    getgenv().Network = {
        BaseParts = {},
        Velocity = Vector3.new(14.46262424, 14.46262424, 14.46262424)
    }
    Network.RetainPart = function(Part)
        if typeof(Part) == "Instance" and Part:IsA("BasePart") and Part:IsDescendantOf(workspace) then
            table.insert(Network.BaseParts, Part)
            Part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
            Part.CanCollide = false
        end
    end
    local function EnablePartControl()
        lp.ReplicationFocus = workspace
        runs.Heartbeat:Connect(function()
            pcall(function() sethiddenproperty(lp, "SimulationRadius", math.huge) end)
            for _, Part in pairs(Network.BaseParts) do
                if Part:IsDescendantOf(workspace) then
                    Part.Velocity = Network.Velocity
                end
            end
        end)
    end
    EnablePartControl()
end

local radius = 50
local height = 100
local rotationSpeed = 1
local attractionStrength = 1000
local ringPartsEnabled = false

local function RetainPart(Part)
    if Part:IsA("BasePart") and not Part.Anchored and Part:IsDescendantOf(workspace) then
        if Part.Parent == lp.Character or Part:IsDescendantOf(lp.Character) then
            return false
        end
        Part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
        Part.CanCollide = false
        return true
    end
    return false
end

local parts = {}
local function addPart(part)
    if RetainPart(part) then
        if not table.find(parts, part) then
            table.insert(parts, part)
        end
    end
end

local function removePart(part)
    local index = table.find(parts, part)
    if index then
        table.remove(parts, index)
    end
end

for _, part in pairs(workspace:GetDescendants()) do
    addPart(part)
end

workspace.DescendantAdded:Connect(addPart)
workspace.DescendantRemoving:Connect(removePart)

runs.Heartbeat:Connect(function()
    if not ringPartsEnabled then return end
    
    local humanoidRootPart = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        local tornadoCenter = humanoidRootPart.Position
        for _, part in pairs(parts) do
            if part.Parent and not part.Anchored then
                local pos = part.Position
                local distance = (Vector3.new(pos.X, tornadoCenter.Y, pos.Z) - tornadoCenter).Magnitude
                local angle = math.atan2(pos.Z - tornadoCenter.Z, pos.X - tornadoCenter.X)
                local newAngle = angle + math.rad(rotationSpeed)
                local targetPos = Vector3.new(
                    tornadoCenter.X + math.cos(newAngle) * math.min(radius, distance),
                    tornadoCenter.Y + (height * (math.abs(math.sin((pos.Y - tornadoCenter.Y) / height)))),
                    tornadoCenter.Z + math.sin(newAngle) * math.min(radius, distance)
                )
                local directionToTarget = (targetPos - part.Position).unit
                part.Velocity = directionToTarget * attractionStrength
            end
        end
    end
end)

-- Buttons Functionality
ToggleBtn.MouseButton1Click:Connect(function()
    ringPartsEnabled = not ringPartsEnabled
    if ringPartsEnabled then
        ToggleBtn.Text = "DISABLE RING PARTS"
        ToggleBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    else
        ToggleBtn.Text = "ENABLE RING PARTS"
        ToggleBtn.TextColor3 = Color3.fromRGB(200, 210, 255)
    end
end)

DecRadiusBtn.MouseButton1Click:Connect(function()
    radius = math.max(1, radius - 2)
    RadiusLabel.Text = "Radius: " .. radius
end)

IncRadiusBtn.MouseButton1Click:Connect(function()
    radius = math.min(1000, radius + 2)
    RadiusLabel.Text = "Radius: " .. radius
end)

-- Notification
StarterGui:SetCore("SendNotification", {
    Title = "Ranarth Ring",
    Text = "Script Loaded - Ready to Use!",
    Duration = 5
})
