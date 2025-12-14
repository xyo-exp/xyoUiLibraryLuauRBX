--// Exploit UI Library - Mobile
--// By Nem's (Custom)
--// Executor Safe

local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

local ExploitUI = {}
ExploitUI.__index = ExploitUI

--// Create GUI
function ExploitUI:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ExploitUILib"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = LP:WaitForChild("PlayerGui")

    local Main = Instance.new("Frame")
    Main.Size = UDim2.fromScale(0.85, 0.25)
    Main.Position = UDim2.fromScale(0.075, 0.35)
    Main.BackgroundColor3 = Color3.fromRGB(20,20,20)
    Main.BorderSizePixel = 0
    Main.Parent = ScreenGui
    Main.Active = true

    local UICorner = Instance.new("UICorner", Main)
    UICorner.CornerRadius = UDim.new(0, 16)

    --// Title Bar
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1,0,0,40)
    Title.BackgroundColor3 = Color3.fromRGB(30,30,30)
    Title.Text = title or "Exploit UI"
    Title.TextColor3 = Color3.new(1,1,1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.Parent = Main

    Instance.new("UICorner", Title).CornerRadius = UDim.new(0,16)

    --// Drag (Mobile)
    local dragging, dragInput, dragStart, startPos
    Title.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
        end
    end)

    Title.InputEnded:Connect(function()
        dragging = false
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    --// Section Holder
    local Holder = Instance.new("ScrollingFrame")
    Holder.Size = UDim2.new(1,0,1,-45)
    Holder.Position = UDim2.new(0,0,0,45)
    Holder.CanvasSize = UDim2.new(0,0,0,0)
    Holder.ScrollBarImageTransparency = 0.3
    Holder.Parent = Main

    local UIList = Instance.new("UIListLayout", Holder)
    UIList.Padding = UDim.new(0,10)

    UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Holder.CanvasSize = UDim2.new(0,0,0,UIList.AbsoluteContentSize.Y + 20)
    end)

    local Window = {}

    --// Create Section
    function Window:CreateSection(name)
        local Section = Instance.new("Frame")
        Section.Size = UDim2.new(1,-20,0,40)
        Section.BackgroundColor3 = Color3.fromRGB(25,25,25)
        Section.Parent = Holder

        Instance.new("UICorner", Section).CornerRadius = UDim.new(0,14)

        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(1,0,0,35)
        Title.Text = name
        Title.BackgroundTransparency = 1
        Title.TextColor3 = Color3.new(1,1,1)
        Title.Font = Enum.Font.GothamBold
        Title.TextSize = 16
        Title.Parent = Section

        local Content = Instance.new("Frame")
        Content.Position = UDim2.new(0,0,0,35)
        Content.Size = UDim2.new(1,0,0,0)
        Content.BackgroundTransparency = 1
        Content.Parent = Section

        local Layout = Instance.new("UIListLayout", Content)
        Layout.Padding = UDim.new(0,8)

        Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Content.Size = UDim2.new(1,0,0,Layout.AbsoluteContentSize.Y)
            Section.Size = UDim2.new(1,-20,0,Layout.AbsoluteContentSize.Y + 40)
        end)

        local SectionAPI = {}

        --// Button
        function SectionAPI:AddButton(text, callback)
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1,-20,0,45)
            Btn.Text = text
            Btn.Font = Enum.Font.GothamBold
            Btn.TextSize = 15
            Btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
            Btn.TextColor3 = Color3.new(1,1,1)
            Btn.Parent = Content
            Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,12)

            Btn.MouseButton1Click:Connect(function()
                if callback then callback() end
            end)
        end

        --// Toggle
        function SectionAPI:AddToggle(text, default, callback)
            local Toggle = false

            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1,-20,0,45)
            Btn.Text = text .. " : OFF"
            Btn.Font = Enum.Font.GothamBold
            Btn.TextSize = 15
            Btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
            Btn.TextColor3 = Color3.new(1,1,1)
            Btn.Parent = Content
            Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,12)

            if default then
                Toggle = true
                Btn.Text = text .. " : ON"
                Btn.BackgroundColor3 = Color3.fromRGB(60,120,60)
            end

            Btn.MouseButton1Click:Connect(function()
                Toggle = not Toggle
                Btn.Text = text .. (Toggle and " : ON" or " : OFF")
                Btn.BackgroundColor3 = Toggle and Color3.fromRGB(60,120,60) or Color3.fromRGB(40,40,40)
                if callback then callback(Toggle) end
            end)
        end

        return SectionAPI
    end

    return Window
end

return ExploitUI
