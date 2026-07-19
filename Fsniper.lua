--[[
    RANARTH THEME - FLING SNIPER (SUB-PANEL ONLY)
    Cleaned, Deobfuscated, and Themed by AI
]]

local plrs = game:GetService("Players")
local runs = game:GetService("RunService")
local tweens = game:GetService("TweenService")
local uis = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

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
if getgenv().RanarthFlingRender then getgenv().RanarthFlingRender:Disconnect() end
pcall(function()
    for _, v in pairs(guiParent:GetChildren()) do
        if string.find(v.Name, "Ranarth_Fling_GUI") then v:Destroy() end
    end
end)

-- ==========================================
-- 🖥️ GUI CREATION (TUTORIAL SUB-PANEL STYLE)
-- ==========================================
local gui = Instance.new("ScreenGui")
gui.Name = "Ranarth_Fling_GUI"
gui.Parent = guiParent
gui.ResetOnSpawn = false

-- Main Frame (Sub-Panel)
local tutFrame = Instance.new("Frame", gui)
tutFrame.Size = UDim2.new(0, 260, 0, 320)
tutFrame.Position = UDim2.new(0.5, -130, 0.5, -160)
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
tutTitle.Text = "FLING SNIPER"
tutTitle.Size = UDim2.new(1, -65, 1, 0)
tutTitle.Position = UDim2.new(0, 10, 0, 0)
tutTitle.BackgroundTransparency = 1
tutTitle.TextColor3 = Color3.new(1, 1, 1)
tutTitle.Font = Enum.Font.GothamBold
tutTitle.TextSize = 10
tutTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Controls Layout
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
        tweens:Create(tutFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 260, 0, 30)}):Play()
    else
        tweens:Create(tutFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 260, 0, 320)}):Play()
    end
end)

create_header_btn("X", Color3.fromRGB(255, 80, 80), function()
    if getgenv().RanarthFlingRender then getgenv().RanarthFlingRender:Disconnect() end
    gui:Destroy()
end)

-- Player List Frame
local tutScroll = Instance.new("ScrollingFrame", tutFrame)
tutScroll.Size = UDim2.new(1, -10, 1, -40)
tutScroll.Position = UDim2.new(0, 5, 0, 35)
tutScroll.BackgroundTransparency = 1
tutScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
tutScroll.ScrollBarThickness = 2

local layout = Instance.new("UIListLayout", tutScroll)
layout.Padding = UDim.new(0, 5)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local ESPFolder = Instance.new("Folder", gui)
ESPFolder.Name = "ESPFolder"

-- ==========================================
-- 🔄 ANIMATION & DRAGGING LOGIC
-- ==========================================
getgenv().RanarthFlingRender = runs.RenderStepped:Connect(function()
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
-- ⚙️ FLING SNIPER LOGIC
-- ==========================================
local function FlingTarget(targetPlayer, button)
    local myChar = lp.Character
    local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")
    local myRoot = myHum and myHum.RootPart

    local targetChar = targetPlayer.Character
    local targetHum = targetChar and targetChar:FindFirstChildOfClass("Humanoid")
    local targetRoot = targetHum and targetHum.RootPart
    local targetHead = targetChar and targetChar:FindFirstChild("Head")

    if not (myChar and myRoot and targetChar and targetRoot and targetHead) then return end

    if targetHum.Sit then
        button.TextColor3 = Color3.fromRGB(255, 255, 0)
        StarterGui:SetCore("SendNotification", {
            Text = "Target is sitting, waiting for them to stand up...",
            Title = "Ranarth Fling",
            Duration = 5
        })
        return
    end

    local BoxHandleAdornment = Instance.new("BoxHandleAdornment")
    BoxHandleAdornment.Size = Vector3.new(4, 6, 4)
    BoxHandleAdornment.Color3 = Color3.fromRGB(100, 150, 255)
    BoxHandleAdornment.Transparency = 0.5
    BoxHandleAdornment.Adornee = targetRoot
    BoxHandleAdornment.AlwaysOnTop = true
    BoxHandleAdornment.ZIndex = 10
    BoxHandleAdornment.Parent = ESPFolder

    local heartbeatConn
    heartbeatConn = runs.Heartbeat:Connect(function()
        if not plrs:FindFirstChild(targetPlayer.Name) then
            if BoxHandleAdornment then BoxHandleAdornment:Destroy() end
            if heartbeatConn then heartbeatConn:Disconnect() end
        end
    end)

    workspace.CurrentCamera.CameraSubject = targetHead
    
    local oldPos = myRoot.CFrame
    local oldFPDH = workspace.FallenPartsDestroyHeight
    workspace.FallenPartsDestroyHeight = 0/0 

    local EpixVel = Instance.new("BodyVelocity")
    EpixVel.Name = "EpixVel"
    EpixVel.Parent = myRoot
    EpixVel.Velocity = Vector3.new(9e8, 9e8, 9e8)
    EpixVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

    myHum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

    local timeout = tick() + 2
    while tick() < timeout do
        if not targetChar or not targetRoot or targetHum.Sit or myHum.Health <= 0 then break end

        local targetVel = targetRoot.Velocity.Magnitude
        local walkSpeed = targetHum.WalkSpeed

        if (targetRoot.Position - targetHead.Position).Magnitude > 5 then
            if targetHead.Velocity.Magnitude >= 50 then
                myRoot.CFrame = CFrame.new(targetHead.Position) * CFrame.new(0, 1.5, walkSpeed) * CFrame.Angles(math.pi/2, 0, 0)
            end
        else
            myRoot.CFrame = CFrame.new(targetHead.Position) * CFrame.new(0, 1.5, targetVel / 1.25) * CFrame.Angles(math.pi/2, 0, 0)
        end
        
        myRoot.Velocity = Vector3.new(9e7, 9e8, 9e7)
        myRoot.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
        task.wait()
        
        myRoot.CFrame = CFrame.new(targetHead.Position) * CFrame.new(0, -1.5, -walkSpeed) * CFrame.Angles(0, 0, 0)
        task.wait()
    end

    EpixVel:Destroy()
    myHum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
    workspace.CurrentCamera.CameraSubject = myHum
    
    myRoot.CFrame = oldPos * CFrame.new(0, 0.5, 0)
    myHum:ChangeState(Enum.HumanoidStateType.GettingUp)
    
    for _, part in pairs(myChar:GetChildren()) do
        if part:IsA("BasePart") then
            part.Velocity = Vector3.new(0, 0, 0)
            part.RotVelocity = Vector3.new(0, 0, 0)
        end
    end

    workspace.FallenPartsDestroyHeight = oldFPDH
    button.TextColor3 = Color3.fromRGB(200, 210, 255)
    
    if BoxHandleAdornment then BoxHandleAdornment:Destroy() end
    if heartbeatConn then heartbeatConn:Disconnect() end
end

-- ==========================================
-- 👥 PLAYER LIST SETUP
-- ==========================================
local function CreatePlayerButton(player)
    if player == lp then return end

    local btn = Instance.new("TextButton", tutScroll)
    btn.Name = player.Name
    btn.Text = player.Name
    btn.Size = UDim2.new(1, -6, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(22, 26, 44)
    btn.TextColor3 = Color3.fromRGB(200, 210, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    btn.AutoButtonColor = false
    
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    animStroke(btn, 1.2) 

    btn.MouseEnter:Connect(function() 
        tweens:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(35, 40, 55)}):Play() 
    end)
    btn.MouseLeave:Connect(function() 
        tweens:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(22, 26, 44)}):Play() 
    end)

    btn.MouseButton1Click:Connect(function()
        FlingTarget(player, btn)
    end)

    tutScroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
end

plrs.PlayerAdded:Connect(CreatePlayerButton)
plrs.PlayerRemoving:Connect(function(player)
    local btn = tutScroll:FindFirstChild(player.Name)
    if btn then
        btn:Destroy()
        tutScroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end
end)

for _, player in pairs(plrs:GetPlayers()) do
    CreatePlayerButton(player)
end
