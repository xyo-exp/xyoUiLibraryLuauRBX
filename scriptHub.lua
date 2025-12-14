--// Exploit UI Library PRO - Mobile
--// Premium Dark | Bubble Minimize | Config Save
--// Android Executors Friendly

local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

getgenv().ExploitConfig = getgenv().ExploitConfig or {}

local UILib = {}
UILib.__index = UILib

--// Colors (Premium Dark)
local COLORS = {
    BG = Color3.fromRGB(18,18,20),
    BG2 = Color3.fromRGB(26,26,30),
    ACCENT = Color3.fromRGB(90,140,255),
    BTN = Color3.fromRGB(35,35,40),
    ON = Color3.fromRGB(70,120,255),
    TEXT = Color3.fromRGB(230,230,235),
    SUB = Color3.fromRGB(150,150,160)
}

--------------------------------------------------

function UILib:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ExploitUILibPRO"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = LP.PlayerGui

    --// Main Frame
    local Main = Instance.new("Frame")
    Main.Size = UDim2.fromScale(0.22, 0.65)
    Main.Position = UDim2.fromScale(0.03, 0.17)
    Main.BackgroundColor3 = COLORS.BG
    Main.BorderSizePixel = 0
    Main.Parent = ScreenGui
    Main.Active = true

    Instance.new("UICorner", Main).CornerRadius = UDim.new(0,16)

    --// Title Bar
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1,0,0,38)
    Title.BackgroundColor3 = COLORS.BG2
    Title.Text = title or "Exploit"
    Title.TextColor3 = COLORS.TEXT
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14
    Title.Parent = Main
    Instance.new("UICorner", Title).CornerRadius = UDim.new(0,16)

    --// Minimize Button
    local Min = Instance.new("TextButton")
    Min.Size = UDim2.new(0,32,0,32)
    Min.Position = UDim2.new(1,-36,0,3)
    Min.Text = "–"
    Min.TextSize = 22
    Min.Font = Enum.Font.GothamBold
    Min.TextColor3 = COLORS.TEXT
    Min.BackgroundTransparency = 1
    Min.Parent = Title

    --// Content
    local Holder = Instance.new("ScrollingFrame")
    Holder.Position = UDim2.new(0,0,0,40)
    Holder.Size = UDim2.new(1,0,1,-40)
    Holder.CanvasSize = UDim2.new(0,0,0,0)
    Holder.ScrollBarImageTransparency = 0.4
    Holder.Parent = Main

    local List = Instance.new("UIListLayout", Holder)
    List.Padding = UDim.new(0,10)

    List:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Holder.CanvasSize = UDim2.new(0,0,0,List.AbsoluteContentSize.Y + 20)
    end)

    --// Drag (Touch)
    local dragging, dragStart, startPos
    Title.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = i.Position
            startPos = Main.Position
        end
    end)

    UIS.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.Touch then
            local d = i.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)

    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)

    --// Bubble
    local Bubble = Instance.new("TextButton")
    Bubble.Size = UDim2.fromOffset(55,55)
    Bubble.Position = UDim2.fromScale(0.02,0.45)
    Bubble.Text = "⚡"
    Bubble.TextSize = 24
    Bubble.Font = Enum.Font.GothamBold
    Bubble.BackgroundColor3 = COLORS.ACCENT
    Bubble.TextColor3 = Color3.new(1,1,1)
    Bubble.Visible = false
    Bubble.Parent = ScreenGui
    Instance.new("UICorner", Bubble).CornerRadius = UDim.new(1,0)

    Min.MouseButton1Click:Connect(function()
        Main.Visible = false
        Bubble.Visible = true
    end)

    Bubble.MouseButton1Click:Connect(function()
        Bubble.Visible = false
        Main.Visible = true
    end)

    --------------------------------------------------

    local Window = {}

    function Window:CreateSection(name)
        local Sec = Instance.new("Frame")
        Sec.Size = UDim2.new(1,-16,0,40)
        Sec.BackgroundColor3 = COLORS.BG2
        Sec.Parent = Holder
        Instance.new("UICorner", Sec).CornerRadius = UDim.new(0,14)

        local T = Instance.new("TextLabel")
        T.Size = UDim2.new(1,0,0,30)
        T.Text = name
        T.TextColor3 = COLORS.TEXT
        T.Font = Enum.Font.GothamBold
        T.TextSize = 13
        T.BackgroundTransparency = 1
        T.Parent = Sec

        local Content = Instance.new("Frame")
        Content.Position = UDim2.new(0,0,0,30)
        Content.Size = UDim2.new(1,0,0,0)
        Content.BackgroundTransparency = 1
        Content.Parent = Sec

        local L = Instance.new("UIListLayout", Content)
        L.Padding = UDim.new(0,8)

        L:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Content.Size = UDim2.new(1,0,0,L.AbsoluteContentSize.Y)
            Sec.Size = UDim2.new(1,-16,0,L.AbsoluteContentSize.Y + 34)
        end)

        local API = {}

        -- BUTTON
        function API:AddButton(txt, cb)
            local B = Instance.new("TextButton")
            B.Size = UDim2.new(1,-14,0,40)
            B.Text = txt
            B.Font = Enum.Font.GothamBold
            B.TextSize = 13
            B.TextColor3 = COLORS.TEXT
            B.BackgroundColor3 = COLORS.BTN
            B.Parent = Content
            Instance.new("UICorner", B).CornerRadius = UDim.new(0,12)
            B.MouseButton1Click:Connect(function() if cb then cb() end end)
        end

        -- TOGGLE (SAVED)
        function API:AddToggle(txt, key, def, cb)
            local v = getgenv().ExploitConfig[key] 
            if v == nil then v = def end

            local B = Instance.new("TextButton")
            B.Size = UDim2.new(1,-14,0,40)
            B.Text = txt.." : "..(v and "ON" or "OFF")
            B.Font = Enum.Font.GothamBold
            B.TextSize = 13
            B.TextColor3 = COLORS.TEXT
            B.BackgroundColor3 = v and COLORS.ON or COLORS.BTN
            B.Parent = Content
            Instance.new("UICorner", B).CornerRadius = UDim.new(0,12)

            B.MouseButton1Click:Connect(function()
                v = not v
                getgenv().ExploitConfig[key] = v
                B.Text = txt.." : "..(v and "ON" or "OFF")
                B.BackgroundColor3 = v and COLORS.ON or COLORS.BTN
                if cb then cb(v) end
            end)

            if cb then cb(v) end
        end

        -- SLIDER
        function API:AddSlider(txt, key, min, max, def, cb)
            local val = getgenv().ExploitConfig[key] or def

            local F = Instance.new("Frame")
            F.Size = UDim2.new(1,-14,0,55)
            F.BackgroundColor3 = COLORS.BTN
            F.Parent = Content
            Instance.new("UICorner", F).CornerRadius = UDim.new(0,12)

            local Lb = Instance.new("TextLabel")
            Lb.Size = UDim2.new(1,0,0,22)
            Lb.Text = txt.." : "..val
            Lb.TextSize = 12
            Lb.TextColor3 = COLORS.TEXT
            Lb.BackgroundTransparency = 1
            Lb.Parent = F

            local Bar = Instance.new("Frame")
            Bar.Size = UDim2.new(0.9,0,0,6)
            Bar.Position = UDim2.new(0.05,0,0,32)
            Bar.BackgroundColor3 = COLORS.BG2
            Bar.Parent = F
            Instance.new("UICorner", Bar).CornerRadius = UDim.new(1,0)

            local Fill = Instance.new("Frame")
            Fill.Size = UDim2.new((val-min)/(max-min),0,1,0)
            Fill.BackgroundColor3 = COLORS.ACCENT
            Fill.Parent = Bar
            Instance.new("UICorner", Fill).CornerRadius = UDim.new(1,0)

            Bar.InputBegan:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.Touch then
                    local x = math.clamp((i.Position.X - Bar.AbsolutePosition.X)/Bar.AbsoluteSize.X,0,1)
                    val = math.floor(min + (max-min)*x)
                    getgenv().ExploitConfig[key] = val
                    Fill.Size = UDim2.new(x,0,1,0)
                    Lb.Text = txt.." : "..val
                    if cb then cb(val) end
                end
            end)
        end

        -- DROPDOWN
        function API:AddDropdown(txt, key, options, cb)
            local cur = getgenv().ExploitConfig[key] or options[1]

            local B = Instance.new("TextButton")
            B.Size = UDim2.new(1,-14,0,40)
            B.Text = txt..": "..cur
            B.Font = Enum.Font.GothamBold
            B.TextSize = 12
            B.TextColor3 = COLORS.TEXT
            B.BackgroundColor3 = COLORS.BTN
            B.Parent = Content
            Instance.new("UICorner", B).CornerRadius = UDim.new(0,12)

            B.MouseButton1Click:Connect(function()
                local idx = table.find(options, cur) or 1
                idx = idx % #options + 1
                cur = options[idx]
                getgenv().ExploitConfig[key] = cur
                B.Text = txt..": "..cur
                if cb then cb(cur) end
            end)

            if cb then cb(cur) end
        end

        return API
    end

    return Window
end

return UILib
