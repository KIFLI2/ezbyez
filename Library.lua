local a = game:GetService("MarketplaceService")
local b = game:GetService("UserInputService")
local c = game:GetService("TweenService")
local d = game:GetService("HttpService")
local e = game:GetService("RunService")
local f = game:GetService("VirtualUser")
local g = game:GetService("CoreGui") or gethui()
local h = game:GetService("Players")
local i = h.LocalPlayer
i.Idled:connect(
    function()
        f:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        wait(1)
        f:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end
)
local j = {
    Themes = {
        DarkerRed = {
            ["Color Hub 1"] = ColorSequence.new(
                {
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(10, 10, 10)),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(20, 20, 20)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(10, 10, 10))
                }
            ),
            ["Color Hub 2"] = Color3.fromRGB(30, 30, 30),
            ["Color Stroke"] = Color3.fromRGB(40, 40, 40),
            ["Color Theme"] = Color3.fromRGB(200, 0, 0),
            ["Color Text"] = Color3.fromRGB(255, 255, 255),
            ["Color Dark Text"] = Color3.fromRGB(150, 150, 150)
        }
    },
    Info = {Version = ""},
    Save = {UISize = {550, 350}, TabSize = 160, Theme = "DarkerRed"},
    Instances = {},
    Elements = {},
    Options = {},
    Flags = {},
    Tabs = {},
    Icons = loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Main/main/Icons.lua"))()
}
local k = workspace.CurrentCamera.ViewportSize
local l = k.Y / 450
local m, n, o, p
do
    o = function(Instance, q)
        table.insert(j.Instances, {Instance = Instance, Type = q})
        return Instance
    end
    n = function(Instance, r)
        if r then
            table.foreach(
                r,
                function(s, t)
                    t.Parent = Instance
                end
            )
        end
        return Instance
    end
    m = function(Instance, u)
        if u then
            table.foreach(
                u,
                function(v, w)
                    Instance[v] = w
                end
            )
        end
        return Instance
    end
    p = function(...)
        local x = {...}
        if type(x) ~= "table" then
            return
        end
        local y = Instance.new(x[1])
        local r = {}
        if type(x[2]) == "table" then
            m(y, x[2])
            n(y, x[3])
            r = x[3] or {}
        elseif typeof(x[2]) == "Instance" then
            y.Parent = x[2]
            m(y, x[3])
            n(y, x[4])
            r = x[4] or {}
        end
        return y
    end
    local function VerifyTheme(z)
        for A, s in pairs(j.Themes) do
            if A == z then
                return true
            end
        end
    end
    local function SaveJson(B, C)
        if writefile then
            local D = d:JSONEncode(C)
            writefile(B, D)
        end
    end
    local function E(F)
        if readfile and isfile and isfile(F) then
            local G = d:JSONDecode(readfile(F))
            if type(G) == "table" then
                if rawget(G, "UISize") then
                    j.Save["UISize"] = G["UISize"]
                end
                if rawget(G, "TabSize") then
                    j.Save["TabSize"] = G["TabSize"]
                end
                if rawget(G, "Theme") and VerifyTheme(G["Theme"]) then
                    j.Save["Theme"] = G["Theme"]
                end
            end
        end
    end
    local H, I = pcall(E, "Speed Hub X V3.lua")
    if not H then
        warn(I)
    end
end
local J = p("ScreenGui", g, {Name = "Speed Hub X Lib V3"}, {p("UIScale", {Scale = l, Name = "Scale"})})
local K = g:FindFirstChild(J.Name)
if K and K ~= J then
    K:Destroy()
end
local function L(Instance, M)
    Instance.InputBegan:Connect(
        function(N)
            if N.UserInputType == Enum.UserInputType.MouseButton1 or N.UserInputType == Enum.UserInputType.Touch then
                while b:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                    task.wait()
                end
            end
            M()
        end
    )
end
local function O(P)
    local Instance = P[1] or P.Instance
    local Q = P[2] or P.Prop
    local R = P[3] or P.NewVal
    local S = P[4] or P.Time or 0.5
    local T = P[5] or P.wait or false
    local TweenInfo = TweenInfo.new(S, Enum.EasingStyle.Quint)
    local U = c:Create(Instance, TweenInfo, {[Q] = R})
    U:Play()
    if T then
        U.Completed:Wait()
    end
    return U
end
local function V(Instance)
    task.spawn(
        function()
            m(Instance, {Active = true, AutoButtonColor = false})
            local W, X, Y
            local function Z(N)
                local _ = N.Position - W
                local a0 = UDim2.new(X.X.Scale, X.X.Offset + _.X / l, X.Y.Scale, X.Y.Offset + _.Y / l)
                O({Instance, "Position", a0, 0.35})
            end
            Instance.MouseButton1Down:Connect(
                function()
                    Y = true
                end
            )
            Instance.InputBegan:Connect(
                function(N)
                    if N.UserInputType == Enum.UserInputType.MouseButton1 or N.UserInputType == Enum.UserInputType.Touch then
                        X = Instance.Position
                        W = N.Position
                        while b:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                            e.Heartbeat:Wait()
                            if Y then
                                Z(N)
                            end
                        end
                        Y = false
                    end
                end
            )
        end
    )
    return Instance
end
local z = j.Themes[j.Save.Theme]
local function a1(a2, a3)
    j.Elements[a2] = a3
end
local function a4(a5, Instance, props, ...)
    local a6 = j.Elements[a5](Instance, props, ...)
    return a6
end
a1(
    "Corner",
    function(a7, a8)
        local a9 = m(p("UICorner", a7, {CornerRadius = a8 or UDim.new(0, 7)}), props)
        return a9
    end
)
a1(
    "Stroke",
    function(a7, props, ...)
        local x = {...}
        local a9 =
            o(
            m(
                p(
                    "UIStroke",
                    a7,
                    {Color = x[1] or z["Color Stroke"], Thickness = x[2] or 1, ApplyStrokeMode = "Border"}
                ),
                props
            ),
            "Stroke"
        )
        return a9
    end
)
a1(
    "Button",
    function(a7, props, ...)
        local x = {...}
        local a9 =
            o(
            m(
                p(
                    "TextButton",
                    a7,
                    {
                        Text = "",
                        Size = UDim2.fromScale(1, 1),
                        BackgroundColor3 = z["Color Hub 2"],
                        AutoButtonColor = false
                    }
                ),
                props
            ),
            "Frame"
        )
        a9.MouseEnter:Connect(
            function()
                a9.BackgroundTransparency = 0.4
            end
        )
        a9.MouseLeave:Connect(
            function()
                a9.BackgroundTransparency = 0
            end
        )
        if x[1] then
            a9.Activated:Connect(x[1])
        end
        return a9
    end
)
a1(
    "Gradient",
    function(a7, props, ...)
        local x = {...}
        local a9 = o(m(p("UIGradient", a7, {Color = z["Color Hub 1"]}), props), "Gradient")
        return a9
    end
)
local function aa(Instance, ab, ac, ad)
    local ae =
        o(
        p(
            "TextLabel",
            {
                Font = Enum.Font.GothamMedium,
                TextColor3 = z["Color Text"],
                Size = UDim2.new(1, -20),
                AutomaticSize = "Y",
                Position = UDim2.new(0, 0, 0.5),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundTransparency = 1,
                TextTruncate = "AtEnd",
                TextSize = 10,
                TextXAlignment = "Left",
                Text = "",
                RichText = true
            }
        ),
        "Text"
    )
    local af =
        o(
        p(
            "TextLabel",
            {
                Font = Enum.Font.Gotham,
                TextColor3 = z["Color Dark Text"],
                Size = UDim2.new(1, -20),
                AutomaticSize = "Y",
                Position = UDim2.new(0, 12, 0, 15),
                BackgroundTransparency = 1,
                TextWrapped = true,
                TextSize = 8,
                TextXAlignment = "Left",
                Text = "",
                RichText = true
            }
        ),
        "DarkText"
    )
    local ag = a4("Button", Instance, {Size = UDim2.new(1, 0, 0, 25), AutomaticSize = "Y", Name = "Option"})
    a4("Corner", ag, UDim.new(0, 6))
    LabelHolder =
        p(
        "Frame",
        ag,
        {
            AutomaticSize = "Y",
            BackgroundTransparency = 1,
            Size = ad,
            Position = UDim2.new(0, 10, 0),
            AnchorPoint = Vector2.new(0, 0)
        },
        {
            p("UIListLayout", {SortOrder = "LayoutOrder", VerticalAlignment = "Center", Padding = UDim.new(0, 2)}),
            p("UIPadding", {PaddingBottom = UDim.new(0, 5), PaddingTop = UDim.new(0, 5)}),
            ae,
            af
        }
    )
    local ah = {}
    function ah:SetTitle(ai)
        if type(ai) == "string" and ai:gsub(" ", ""):len() > 0 then
            ae.Text = ai
        end
    end
    function ah:SetDesc(aj)
        if type(aj) == "string" and aj:gsub(" ", ""):len() > 0 then
            af.Visible = true
            af.Text = aj
            LabelHolder.Position = UDim2.new(0, 10, 0)
            LabelHolder.AnchorPoint = Vector2.new(0, 0)
        else
            af.Visible = false
            af.Text = ""
            LabelHolder.Position = UDim2.new(0, 10, 0.5)
            LabelHolder.AnchorPoint = Vector2.new(0, 0.5)
        end
    end
    ah:SetTitle(ab)
    ah:SetDesc(ac)
    return ag, ah
end
local function ak(Instance)
    if Instance:IsA("Frame") then
        return "BackgroundColor3"
    elseif Instance:IsA("ImageLabel") then
        return "ImageColor3"
    elseif Instance:IsA("TextLabel") then
        return "TextColor3"
    elseif Instance:IsA("ScrollingFrame") then
        return "ScrollBarImageColor3"
    elseif Instance:IsA("UIStroke") then
        return "Color"
    end
    return ""
end
function j:GetIcon(al)
    if al:find("rbxassetid://") or al:len() < 1 then
        return al
    end
    al = al:lower():gsub("lucide", ""):gsub("-", "")
    for a2, am in pairs(j.Icons) do
        a2 = a2:gsub("lucide", ""):gsub("-", "")
        if a2 == al then
            return am
        end
    end
    for a2, am in pairs(j.Icons) do
        a2 = a2:gsub("lucide", ""):gsub("-", "")
        if a2:find(al) then
            return am
        end
    end
    return al
end
function j:SetTheme(an)
    if not VerifyTheme(an) then
        return
    end
    j.Save.Theme = an
    SaveJson("Speed Hub X V3.lua", j.Save)
    z = j.Themes[an]
    table.foreach(
        j.Instances,
        function(s, ao)
            if ao.Type == "Gradient" then
                ao.Instance.Color = z["Color Hub 1"]
            elseif ao.Type == "Frame" then
                ao.Instance.BackgroundColor3 = z["Color Hub 2"]
            elseif ao.Type == "Stroke" then
                ao.Instance[ak(ao.Instance)] = z["Color Stroke"]
            elseif ao.Type == "Theme" then
                ao.Instance[ak(ao.Instance)] = z["Color Theme"]
            elseif ao.Type == "Text" then
                ao.Instance[ak(ao.Instance)] = z["Color Text"]
            elseif ao.Type == "DarkText" then
                ao.Instance[ak(ao.Instance)] = z["Color Dark Text"]
            elseif ao.Type == "ScrollBar" then
                ao.Instance[ak(ao.Instance)] = z["Color Theme"]
            end
        end
    )
end
function j:SetScale(ap)
    ap = k.Y / math.clamp(ap, 300, 2000)
    l, J.Scale.Scale = ap, ap
end
function j:MakeWindow(P)
    local aq = P[1] or P.Name or P.Title or ""
    local ar = P[2] or P.SubTitle or ""
    local as = P[3] or P.SaveFolder or false
    local at = P[4] or P.SaveRejoin or false
    local au = j.Flags
    if as and type(as) == "string" then
        as = string.gsub(as, "/", "|")
    end
    local av = tick()
    local function aw(a2, ax)
        if writefile then
            if as and type(as) == "string" then
                au[a2] = ax
                local ay = d:JSONEncode(au)
                pcall(writefile, as, ay)
            end
        end
    end
    local function az()
        if as and type(as) == "string" then
            if readfile and isfile and isfile(as) then
                local H, aA = pcall(readfile, as)
                if H and type(aA) == "string" then
                    aA = d:JSONDecode(aA)
                    if type(aA) == "table" then
                        au = aA
                    end
                end
            end
        end
    end
    az()
    local aB, aC = unpack(j.Save.UISize)
    local aD =
        o(
        p(
            "ImageButton",
            J,
            {
                Size = UDim2.fromOffset(aB, aC),
                Position = UDim2.new(0.5, -aB / 2, 0.5, -aC / 2),
                BackgroundTransparency = 0.03,
                Name = "Hub"
            }
        ),
        "Main"
    )
    a4("Gradient", aD, {Rotation = 45})
    V(aD)
    local aE = a4("Corner", aD)
    local aF = p("Folder", aD, {Name = "Components"})
    local aG = p("Folder", J, {Name = "Dropdown"})
    local aH = p("Frame", aF, {Size = UDim2.new(1, 0, 0, 28), BackgroundTransparency = 1, Name = "Top Bar"})
    local ab =
        o(
        p(
            "TextLabel",
            aH,
            {
                Position = UDim2.new(0, 15, 0.5),
                AnchorPoint = Vector2.new(0, 0.5),
                AutomaticSize = "XY",
                Text = aq,
                TextXAlignment = "Left",
                TextSize = 12,
                TextColor3 = z["Color Text"],
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                Name = "Title"
            },
            {
                o(
                    p(
                        "TextLabel",
                        {
                            Size = UDim2.fromScale(0, 1),
                            AutomaticSize = "X",
                            AnchorPoint = Vector2.new(0, 1),
                            Position = UDim2.new(1, 5, 0.9),
                            Text = ar,
                            TextColor3 = z["Color Dark Text"],
                            BackgroundTransparency = 1,
                            TextXAlignment = "Left",
                            TextYAlignment = "Bottom",
                            TextSize = 8,
                            Font = Enum.Font.Gotham,
                            Name = "SubTitle"
                        }
                    ),
                    "DarkText"
                )
            }
        ),
        "Text"
    )
    local aI =
        o(
        p(
            "ScrollingFrame",
            aF,
            {
                Size = UDim2.new(0, j.Save.TabSize, 1, -aH.Size.Y.Offset),
                ScrollBarImageColor3 = z["Color Theme"],
                Position = UDim2.new(0, 0, 1, 0),
                AnchorPoint = Vector2.new(0, 1),
                ScrollBarThickness = 1.5,
                BackgroundTransparency = 1,
                ScrollBarImageTransparency = 0.2,
                CanvasSize = UDim2.new(),
                AutomaticCanvasSize = "Y",
                ScrollingDirection = "Y",
                BorderSizePixel = 0,
                Name = "Tab Scroll"
            },
            {
                p(
                    "UIPadding",
                    {
                        PaddingLeft = UDim.new(0, 10),
                        PaddingRight = UDim.new(0, 10),
                        PaddingTop = UDim.new(0, 10),
                        PaddingBottom = UDim.new(0, 10)
                    }
                ),
                p("UIListLayout", {Padding = UDim.new(0, 5)})
            }
        ),
        "ScrollBar"
    )
    local aJ =
        p(
        "Frame",
        aF,
        {
            Size = UDim2.new(1, -aI.Size.X.Offset, 1, -aH.Size.Y.Offset),
            AnchorPoint = Vector2.new(1, 1),
            Position = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            ClipsDescendants = true,
            Name = "Containers"
        }
    )
    local aK, aL =
        V(
            p(
                "ImageButton",
                aD,
                {
                    Size = UDim2.new(0, 35, 0, 35),
                    Position = aD.Size,
                    Active = true,
                    AnchorPoint = Vector2.new(0.8, 0.8),
                    BackgroundTransparency = 1,
                    Name = "Control Hub Size"
                }
            )
        ),
        V(
            p(
                "ImageButton",
                aD,
                {
                    Size = UDim2.new(0, 20, 1, -30),
                    Position = UDim2.new(0, aI.Size.X.Offset, 1, 0),
                    AnchorPoint = Vector2.new(0.5, 1),
                    Active = true,
                    BackgroundTransparency = 1,
                    Name = "Control Tab Size"
                }
            )
        )
    local function aM()
        local aN, aO = aK.Position, aL.Position
        aK.Position = UDim2.fromOffset(math.clamp(aN.X.Offset, 430, 1000), math.clamp(aN.Y.Offset, 200, 500))
        aL.Position = UDim2.new(0, math.clamp(aO.X.Offset, 135, 250), 1, 0)
        aI.Size = UDim2.new(0, aL.Position.X.Offset, 1, -aH.Size.Y.Offset)
        aJ.Size = UDim2.new(1, -aI.Size.X.Offset, 1, -aH.Size.Y.Offset)
        aD.Size = aK.Position
    end
    aK:GetPropertyChangedSignal("Position"):Connect(aM)
    aL:GetPropertyChangedSignal("Position"):Connect(aM)
    L(
        aK,
        function()
            if not Minimized then
                j.Save.UISize = {aD.Size.X.Offset, aD.Size.Y.Offset}
                SaveJson("Speed Hub X V3.lua", j.Save)
            end
        end
    )
    L(
        aL,
        function()
            j.Save.TabSize = aI.Size.X.Offset
            SaveJson("Speed Hub X V3.lua", j.Save)
        end
    )
    local aP = p("Folder", aH, {Name = "Buttons"})
    local aQ =
        p(
        "ImageButton",
        {
            Size = UDim2.new(0, 14, 0, 14),
            Position = UDim2.new(1, -10, 0.5),
            AnchorPoint = Vector2.new(1, 0.5),
            BackgroundTransparency = 1,
            Image = "rbxassetid://10747384394",
            AutoButtonColor = false,
            Name = "Close"
        }
    )
    n(aP, {aQ})
    local aR, aS = {}, false
    function aR:CloseBtn()
        local aT =
            aR:Dialog(
            {Title = "Exit Script", Text = "You Want To Exit Scripts?", Options = {{"Confirm", function()
                            J:Destroy()
                        end}, {"Cancel"}}}
        )
    end
    function aR:Minimize()
        aD.Visible = not aD.Visible
    end
    function aR:AddMinimizeButton(P)
        local aU =
            V(
            p(
                "ImageButton",
                J,
                {
                    Size = UDim2.fromOffset(35, 35),
                    Position = UDim2.fromScale(0.15, 0.15),
                    BackgroundTransparency = 1,
                    BackgroundColor3 = z["Color Hub 2"],
                    AutoButtonColor = false
                }
            )
        )
        local aV, aW
        if P.Corner then
            aW = a4("Corner", aU)
            m(aW, P.Corner)
        end
        if P.Stroke then
            aV = a4("Stroke", aU)
            m(aV, P.Corner)
        end
        m(aU, P.Button)
        aU.Activated:Connect(aR.Minimize)
        return {Stroke = aV, Corner = aW, Button = aU}
    end
    function aR:Set(aX, aY)
        if type(aX) == "string" and type(aY) == "string" then
            ab.Text = aX
            ab.SubTitle.Text = aY
        elseif type(aX) == "string" then
            ab.Text = aX
        end
    end
    function aR:Dialog(P)
        if aD:FindFirstChild("Dialog") then
            return
        end
        local aZ = P[1] or P.Title or ""
        local a_ = P[2] or P.Text or ""
        local b0 = P[3] or P.Options or {}
        local ag =
            p(
            "Frame",
            {
                Active = true,
                Size = UDim2.fromOffset(250 * 1.08, 150 * 1.08),
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5)
            },
            {
                o(
                    p(
                        "TextLabel",
                        {
                            Font = Enum.Font.GothamBold,
                            Size = UDim2.new(1, 0, 0, 20),
                            Text = aZ,
                            TextXAlignment = "Left",
                            TextColor3 = z["Color Text"],
                            TextSize = 15,
                            Position = UDim2.fromOffset(15, 5),
                            BackgroundTransparency = 1
                        }
                    ),
                    "Text"
                ),
                o(
                    p(
                        "TextLabel",
                        {
                            Font = Enum.Font.GothamMedium,
                            Size = UDim2.new(1, -25),
                            AutomaticSize = "Y",
                            Text = a_,
                            TextXAlignment = "Left",
                            TextColor3 = z["Color Dark Text"],
                            TextSize = 12,
                            Position = UDim2.fromOffset(15, 25),
                            BackgroundTransparency = 1,
                            TextWrapped = true
                        }
                    ),
                    "DarkText"
                )
            }
        )
        a4("Gradient", ag, {Rotation = 270})
        a4("Corner", ag)
        local b1 =
            p(
            "Frame",
            ag,
            {
                Size = UDim2.fromScale(1, 0.35),
                Position = UDim2.fromScale(0, 1),
                AnchorPoint = Vector2.new(0, 1),
                BackgroundColor3 = z["Color Hub 2"],
                BackgroundTransparency = 1
            },
            {
                p(
                    "UIListLayout",
                    {
                        Padding = UDim.new(0, 10),
                        VerticalAlignment = "Center",
                        FillDirection = "Horizontal",
                        HorizontalAlignment = "Center"
                    }
                )
            }
        )
        local b2 =
            o(
            p(
                "Frame",
                aD,
                {
                    BackgroundTransparency = 0.6,
                    Active = true,
                    BackgroundColor3 = z["Color Hub 2"],
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundColor3 = z["Color Stroke"],
                    Name = "Dialog"
                }
            ),
            "Stroke"
        )
        aE:Clone().Parent = b2
        ag.Parent = b2
        O({ag, "Size", UDim2.fromOffset(250, 150), 0.2})
        O({ag, "Transparency", 0, 0.15})
        O({b2, "Transparency", 0.3, 0.15})
        local b3, aT = 1, {}
        function aT:Button(P)
            local a2 = P[1] or P.Name or P.Title or ""
            local b4 = P[2] or P.Callback or function()
                end
            b3 = b3 + 1
            local aU = a4("Button", b1)
            a4("Corner", aU)
            m(aU, {Text = a2, Font = Enum.Font.GothamBold, TextColor3 = z["Color Text"], TextSize = 12})
            for s, aU in pairs(b1:GetChildren()) do
                if aU:IsA("TextButton") then
                    aU.Size = UDim2.new(1 / b3, -((b3 - 1) * 20 / b3), 0, 32)
                end
            end
            aU.Activated:Connect(aT.Close)
            aU.Activated:Connect(b4)
        end
        function aT:Close()
            O({ag, "Size", UDim2.fromOffset(250 * 1.08, 150 * 1.08), 0.2})
            O({b2, "Transparency", 1, 0.15})
            O({ag, "Transparency", 1, 0.15, true})
            b2:Destroy()
        end
        table.foreach(
            b0,
            function(s, aU)
                aT:Button(aU)
            end
        )
        return aT
    end
    function aR:SelectTab(b5)
        if type(b5) == "number" then
            j.Tabs[b5].func:Enable()
        else
            for s, b6 in pairs(j.Tabs) do
                if b6.Cont == b5.Cont then
                    b6.func:Enable()
                end
            end
        end
    end
    function aR:MakeTab(b7, P)
        if type(b7) == "table" then
            P = b7
        end
        local b8 = P[1] or P.Title or ""
        local b9 = P[2] or P.Icon or ""
        b9 = j:GetIcon(b9)
        if not b9:find("rbxassetid://") or b9:gsub("rbxassetid://", ""):len() < 6 then
            b9 = false
        end
        local b5 = a4("Button", aI, {Size = UDim2.new(1, 0, 0, 24)})
        a4("Corner", b5)
        local ba =
            o(
            p(
                "TextLabel",
                b5,
                {
                    Size = UDim2.new(1, b9 and -25 or -15, 1),
                    Position = UDim2.fromOffset(b9 and 25 or 15),
                    BackgroundTransparency = 1,
                    Font = Enum.Font.GothamMedium,
                    Text = "| " .. b8,
                    TextColor3 = z["Color Text"],
                    TextSize = 10,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTransparency = aS and 0.3 or 0,
                    TextTruncate = "AtEnd"
                }
            ),
            "Text"
        )
        local bb =
            o(
            p(
                "ImageLabel",
                b5,
                {
                    Position = UDim2.new(0, 8, 0.5),
                    Size = UDim2.new(0, 13, 0, 13),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Image = b9 or "",
                    BackgroundTransparency = 1,
                    ImageTransparency = aS and 0.3 or 0
                }
            ),
            "Text"
        )
        local bc =
            o(
            p(
                "Frame",
                b5,
                {
                    Size = aS and UDim2.new(1, 0, 0, 24) or UDim2.new(1, 0, 0, 24),
                    Position = UDim2.new(0, 1, 0.5),
                    AnchorPoint = Vector2.new(0, 0.5),
                    BackgroundColor3 = z["Color Theme"],
                    BackgroundTransparency = aS and 0.2 or 0
                }
            ),
            "Theme"
        )
        a4("Corner", bc)
        local bd =
            o(
            p(
                "ScrollingFrame",
                aJ,
                {
                    Size = UDim2.new(1, 0, 1, 0),
                    Position = UDim2.new(0, 0, 1),
                    AnchorPoint = Vector2.new(0, 1),
                    ScrollBarThickness = 1.5,
                    BackgroundTransparency = 1,
                    ScrollBarImageTransparency = 0.2,
                    ScrollBarImageColor3 = z["Color Theme"],
                    AutomaticCanvasSize = "Y",
                    ScrollingDirection = "Y",
                    BorderSizePixel = 0,
                    CanvasSize = UDim2.new(),
                    Visible = not aS,
                    Name = "Container"
                },
                {
                    p(
                        "UIPadding",
                        {
                            PaddingLeft = UDim.new(0, 10),
                            PaddingRight = UDim.new(0, 10),
                            PaddingTop = UDim.new(0, 10),
                            PaddingBottom = UDim.new(0, 10)
                        }
                    ),
                    p("UIListLayout", {Padding = UDim.new(0, 5)})
                }
            ),
            "ScrollBar"
        )
        local function be()
            if bd.Visible then
                return
            end
            for s, ag in pairs(aJ:GetChildren()) do
                if ag:IsA("ScrollingFrame") and ag ~= bd then
                    ag.Visible = false
                end
            end
            bd.Size = UDim2.new(1, 0, 1, 150)
            bd.Visible = true
            table.foreach(
                j.Tabs,
                function(s, b6)
                    if b6.Cont ~= bd then
                        b6.func:Disable()
                    end
                end
            )
            O({bd, "Size", UDim2.new(1, 0, 1, 0), 0.3})
            O({ba, "TextTransparency", 0, 0.35})
            O({bb, "ImageTransparency", 0, 0.35})
            O({bc, "Size", UDim2.new(1, 0, 0, 24), 0.35})
            O({bc, "BackgroundTransparency", 0.2, 0.35})
        end
        b5.Activated:Connect(be)
        aS = true
        local b6 = {}
        table.insert(j.Tabs, {TabInfo = {Name = b8, Icon = b9}, func = b6, Cont = bd})
        b6.Cont = bd
        function b6:Disable()
            bd.Visible = false
            O({ba, "TextTransparency", 0.3, 0.35})
            O({bb, "ImageTransparency", 0.3, 0.35})
            O({bc, "Size", UDim2.new(1, 0, 0, 24), 0.35})
            O({bc, "BackgroundTransparency", 1, 0.35})
        end
        function b6:Enable()
            be()
        end
        function b6:Visible(bf)
            if bf == nil then
                bd.Visible = not bd.Visible
                b5.Visible = not b5.Visible
                return
            end
            bd.Visible = bf
            b5.Visible = bf
        end
        function b6:Destroy()
            b5:Destroy()
            bd:Destroy()
        end
        function b6:AddSection(P)
            local bg = type(P) == "string" and P or P[1] or P.Name or P.Title or P.Section
            local bh = p("Frame", bd, {Size = UDim2.new(1, 0, 0, 20), BackgroundTransparency = 1, Name = "Option"})
            local bi =
                o(
                p(
                    "TextLabel",
                    bh,
                    {
                        Font = Enum.Font.GothamBold,
                        Text = bg,
                        TextColor3 = z["Color Text"],
                        Size = UDim2.new(1, -25, 1, 0),
                        Position = UDim2.new(0, 5),
                        BackgroundTransparency = 1,
                        TextTruncate = "AtEnd",
                        TextSize = 14,
                        TextXAlignment = "Left"
                    }
                ),
                "Text"
            )
            local bj = {}
            table.insert(j.Options, {type = "Section", Name = bg, func = bj})
            function bj:Visible(bf)
                if bf == nil then
                    bh.Visible = not bh.Visible
                    return
                end
                bh.Visible = bf
            end
            function bj:Destroy()
                bh:Destroy()
            end
            function bj:Set(bk)
                if type(bk) ~= "string" then
                    return
                end
                bi.Text = bk
            end
            return bj
        end
        function b6:AddParagraph(P)
            local bl = P[1] or P.Title or "Paragraph"
            local bm = P[2] or P.Text or ""
            local ag, bn = aa(bd, bl, bm, UDim2.new(1, -10))
            local bo = {}
            function bo:SetTitle(ao)
                bn:SetTitle(ao)
            end
            function bo:SetDesc(ao)
                bn:SetDesc(ao)
            end
            function bo:Set(aX, aY)
                if type(aX) == "string" and type(aY) == "string" then
                    bn:SetTitle(aX)
                    bn:SetDesc(aY)
                else
                    bn:SetDesc(aX)
                end
            end
            function bo:Visible(bf)
                if bf == nil then
                    ag.Visible = not ag.Visible
                    return
                end
                ag.Visible = bf
            end
            function bo:Destroy()
                ag:Destroy()
            end
            return bo
        end
        function b6:AddButton(P)
            local bp = P[1] or P.Name or P.Title or "Button!"
            local bq = P.Desc or P.Description or ""
            local b4 = P[2] or P.Callback or function()
                end
            local br = {}
            local aU, bn = aa(bd, bp, bq, UDim2.new(1, -10))
            local bs =
                p(
                "ImageLabel",
                aU,
                {
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new(1, -10, 0.5),
                    AnchorPoint = Vector2.new(1, 0.5),
                    BackgroundTransparency = 1,
                    Image = "rbxassetid://15458295336"
                }
            )
            aU.Activated:Connect(
                function()
                    task.spawn(b4, "Click")
                    table.foreach(
                        br,
                        function(s, b4)
                            if type(b4) == "function" then
                                task.spawn(b4, "Click")
                            end
                        end
                    )
                end
            )
            local aU = {}
            table.insert(j.Options, {type = "Button", Name = bp, func = aU})
            function aU:Callback(M)
                table.insert(br, M)
            end
            function aU:Set(aX, aY)
                if type(aX) == "string" and type(aY) == "string" then
                    bn:SetTitle(aX)
                    bn:SetDesc(aY)
                elseif type(aX) == "string" then
                    bn:SetTitle(aX)
                elseif type(aX) == "function" then
                    b4 = aX
                end
            end
            function aU:Destroy()
                aU:Destroy()
            end
            function aU:Visible(bf)
                if bf == nil then
                    aU.Visible = not aU.Visible
                    return
                end
                aU.Visible = bf
            end
            return aU
        end
        function b6:AddToggle(P)
            local b8 = P[1] or P.Name or P.Title or "Toggle"
            local bt = P.Desc or P.Description or ""
            local bu = P[2] or P.Default or false
            local b4 = P[3] or P.Callback
            local bv = P[4] or P.Flag or false
            local br = {}
            local aU, bn = aa(bd, b8, bt, UDim2.new(1, -10))
            local bw =
                o(
                p(
                    "Frame",
                    aU,
                    {
                        Size = UDim2.new(0, 20, 0, 19),
                        Position = UDim2.new(1, -10, 0.5),
                        AnchorPoint = Vector2.new(1, 0.5),
                        BackgroundColor3 = z["Color Stroke"]
                    }
                ),
                "Stroke"
            )
            a4("Corner", bw, UDim.new(0, 5))
            local bx =
                p(
                "Frame",
                bw,
                {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0.5, 0, 0.5, 0),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5)
                }
            )
            local by =
                o(
                p(
                    "Frame",
                    bx,
                    {
                        Size = UDim2.new(0, 12, 0, 12),
                        Position = UDim2.new(-0.1, 0, 0.5),
                        AnchorPoint = Vector2.new(0, 0.5),
                        BackgroundColor3 = z["Color Theme"]
                    }
                ),
                "Theme"
            )
            a4("Corner", by, UDim.new(0.5, 0))
            if bv and type(bv) == "string" and rawget(au, bv) then
                bu = au[bv]
            end
            local function bz()
                if bv and typeof(bv) == "string" then
                    aw(bv, bu)
                end
                task.spawn(b4, bu)
                table.foreach(
                    br,
                    function(s, ao)
                        if type(ao) == "function" then
                            task.spawn(ao, bu)
                        end
                    end
                )
            end
            local bA
            local function bB(ao)
                if bA then
                    return
                end
                bA, bu = true, ao
                bz()
                if bu then
                    O({by, "BackgroundTransparency", 0, 0.25})
                else
                    O({by, "BackgroundTransparency", 1, 0.25})
                end
                bA = false
            end
            task.spawn(bB, bu)
            aU.Activated:Connect(
                function()
                    bB(not bu)
                end
            )
            local by = {}
            table.insert(j.Options, {type = "Toggle", Name = b8, func = by})
            function by:Callback(M)
                table.insert(br, M)
                task.spawn(M, bu)
            end
            function by:Set(aX, aY)
                if type(aX) == "string" and type(aY) == "string" then
                    bn:SetTitle(aX)
                    bn:SetDesc(aY)
                elseif type(aX) == "string" then
                    bn:SetTitle(aX, false, true)
                elseif type(aX) == "boolean" then
                    if bA and aY then
                        repeat
                            task.wait()
                        until not bA
                    end
                    task.spawn(bB, aX)
                elseif type(aX) == "function" then
                    b4 = aX
                end
            end
            function by:Destroy()
                aU:Destroy()
            end
            function by:Visible(bf)
                if bf == nil then
                    aU.Visible = not aU.Visible
                    return
                end
                aU.Visible = bf
            end
            return by
        end
        function b6:AddDropdown(P)
            local bC = P[1] or P.Name or P.Title or "Dropdown"
            local bD = P.Desc or P.Description or ""
            local b0 = P[2] or P.Options or {}
            local bE = P[3] or P.Default or {}
            local b4 = P[4] or P.Callback or function()
                end
            local bv = P[5] or P.Flag or false
            local br = {}
            if bv and type(bv) == "string" and rawget(au, bv) then
                bE = au[bv]
            end
            local aU, bn = aa(bd, bC, bD, UDim2.new(1, -20))
            local bF =
                o(
                p(
                    "Frame",
                    aU,
                    {
                        Size = UDim2.new(0, 150, 0, 18),
                        Position = UDim2.new(1, -10, 0.5),
                        AnchorPoint = Vector2.new(1, 0.5),
                        BackgroundColor3 = z["Color Stroke"]
                    }
                ),
                "Stroke"
            )
            a4("Corner", bF, UDim.new(0, 4))
            local bG =
                o(
                p(
                    "TextLabel",
                    bF,
                    {
                        Size = UDim2.new(0.85, 0, 0.85, 0),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        BackgroundTransparency = 1,
                        Font = Enum.Font.GothamBold,
                        TextScaled = true,
                        TextColor3 = z["Color Text"],
                        Text = "..."
                    }
                ),
                "Text"
            )
            local bH =
                p(
                "ImageLabel",
                bF,
                {
                    Size = UDim2.new(0, 15, 0, 15),
                    Position = UDim2.new(0, -5, 0.5),
                    AnchorPoint = Vector2.new(1, 0.5),
                    Image = "rbxassetid://10709791523",
                    BackgroundTransparency = 1
                }
            )
            local bI =
                p(
                "TextButton",
                aG,
                {
                    Name = "AntiClick",
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Visible = false,
                    Text = ""
                }
            )
            local bJ =
                p(
                "Frame",
                bI,
                {
                    Size = UDim2.new(bF.Size.X, 0, 0),
                    BackgroundTransparency = 0.1,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    AnchorPoint = Vector2.new(0, 1),
                    Name = "DropdownFrame",
                    ClipsDescendants = true,
                    Active = true
                }
            )
            a4("Corner", bJ)
            a4("Stroke", bJ)
            a4("Gradient", bJ, {Rotation = 60})
            local bK =
                o(
                p(
                    "ScrollingFrame",
                    bJ,
                    {
                        ScrollBarImageColor3 = z["Color Theme"],
                        Size = UDim2.new(1, 0, 1, 0),
                        ScrollBarThickness = 1.5,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        CanvasSize = UDim2.new(),
                        ScrollingDirection = "Y",
                        AutomaticCanvasSize = "Y",
                        Active = true
                    },
                    {
                        p(
                            "UIPadding",
                            {
                                PaddingLeft = UDim.new(0, 8),
                                PaddingRight = UDim.new(0, 8),
                                PaddingTop = UDim.new(0, 5),
                                PaddingBottom = UDim.new(0, 5)
                            }
                        ),
                        p("UIListLayout", {Padding = UDim.new(0, 4)})
                    }
                ),
                "ScrollBar"
            )
            local bL, bA = 5
            local function bM()
                bA = true
                O({bH, "Rotation", 0, 0.2})
                O({bJ, "Size", UDim2.new(0, 152, 0, 0), 0.2, true})
                O({bH, "ImageColor3", Color3.fromRGB(255, 255, 255), 0.2})
                bH.Image = "rbxassetid://10709791523"
                bI.Visible = false
                bA = false
            end
            local function bN()
                return UDim2.fromOffset(152, bL)
            end
            local function bO()
                local bP = 0
                for s, ag in pairs(bK:GetChildren()) do
                    if ag:IsA("Frame") or ag.Name == "Option" then
                        bP = bP + 1
                    end
                end
                bL = math.clamp(bP, 0, 10) * 25 + 10
                if bI.Visible then
                    bI.Visible = true
                    O({bJ, "Size", bN(), 0.2, true})
                end
            end
            local function bQ()
                if bA then
                    return
                end
                bA = true
                if bI.Visible then
                    bH.Image = "rbxassetid://10709791523"
                    O({bH, "ImageColor3", Color3.fromRGB(255, 255, 255), 0.2})
                    O({bJ, "Size", UDim2.new(0, 152, 0, 0), 0.2, true})
                    bI.Visible = false
                else
                    bI.Visible = true
                    bH.Image = "rbxassetid://10709790948"
                    O({bH, "ImageColor3", z["Color Theme"], 0.2})
                    O({bJ, "Size", bN(), 0.2, true})
                end
                bA = false
            end
            local function bR()
                local bS = bF.AbsolutePosition
                local bT = J.AbsoluteSize
                local bU = math.clamp(bS.X / l, 0, bT.X / l - bJ.Size.X.Offset)
                local bV = math.clamp(bS.Y / l, 0, bT.Y / l)
                local bW = UDim2.fromOffset(bU, bV)
                local bX = bS.Y > bT.Y / 1.4 and 1 or bL > 80 and 0.5 or 0
                bJ.AnchorPoint = Vector2.new(0, bX)
                O({bJ, "Position", bW, 0.1})
            end
            local bu = type(bE) == "table" and bE or {bE}
            local bY, bZ, bc = {}, bu, bu
            local function b_(Option)
                for s, ao in pairs(bY) do
                    if ao.Name == Option then
                        return true
                    end
                end
            end
            local function c0(c1)
                c1 = typeof(c1) == "Instance" and c1.Name or c1
                if b_(c1) then
                    return
                end
                local Option =
                    a4(
                    "Button",
                    bK,
                    {
                        Name = "Option",
                        Size = UDim2.new(1, 0, 0, 21),
                        Position = UDim2.new(0, 0, 0.5),
                        AnchorPoint = Vector2.new(0, 0.5)
                    }
                )
                a4("Corner", Option, UDim.new(0, 4))
                local bF =
                    o(
                    p(
                        "Frame",
                        Option,
                        {
                            Position = UDim2.new(0, 1, 0.5),
                            Size = UDim2.new(1, 0, 0, 21),
                            BackgroundColor3 = z["Color Theme"],
                            BackgroundTransparency = 1,
                            AnchorPoint = Vector2.new(0, 0.5)
                        }
                    ),
                    "Theme"
                )
                a4("Corner", bF)
                local c2 =
                    o(
                    p(
                        "TextLabel",
                        Option,
                        {
                            Size = UDim2.new(1, 0, 1),
                            Position = UDim2.new(0, 10),
                            Text = c1,
                            TextColor3 = z["Color Text"],
                            Font = Enum.Font.GothamBold,
                            TextXAlignment = "Left",
                            BackgroundTransparency = 1,
                            TextTransparency = 0.4
                        }
                    ),
                    "Text"
                )
                local function bz()
                    if bv and typeof(bv) == "string" then
                        aw(bv, bc[1])
                    end
                    task.spawn(b4, bc[1])
                    table.foreach(
                        br,
                        function(s, M)
                            if type(M) == "function" then
                                task.spawn(M, bc[1])
                            end
                        end
                    )
                end
                local function bM()
                    if bc[1] == c1 then
                        bG.Text = "..."
                    end
                    Option:Destroy()
                    for c3, ao in pairs(bY) do
                        if ao.Button == Option then
                            table.remove(bY, c3)
                        end
                    end
                end
                local function c4()
                    for s, ao in pairs(bY) do
                        if ao.Button ~= Option then
                            O({ao.Label, "TextTransparency", 0.4, 0.35})
                            O({ao.Frame, "BackgroundTransparency", 1, 0.35})
                            O({ao.Frame, "Size", UDim2.fromOffset(4, 4), 0.35})
                        end
                    end
                    O({c2, "TextTransparency", 0, 0.35})
                    O({bF, "BackgroundTransparency", 1, 0.35})
                    O({bF, "Size", UDim2.fromOffset(4, 14), 0.35})
                    bc = {c1}
                    bG.Text = bc[1]
                    bz()
                end
                if table.find(bc, c1) then
                    c4()
                end
                Option.Activated:Connect(
                    function()
                        c4()
                    end
                )
                table.insert(bY, {Button = Option, Label = c2, Frame = bF, Name = c1, Active = c4, Disable = bM})
            end
            table.foreach(
                b0,
                function(s, Option)
                    c0(Option)
                end
            )
            local function c5(c5)
                for s, ao in pairs(bY) do
                    ao:Disable()
                end
                table.foreach(
                    c5,
                    function(s, ao)
                        c0(ao)
                    end
                )
            end
            aU.Activated:Connect(bQ)
            bI.MouseButton1Down:Connect(bM)
            bI.MouseButton1Click:Connect(bM)
            aD:GetPropertyChangedSignal("Visible"):Connect(bM)
            bF:GetPropertyChangedSignal("AbsolutePosition"):Connect(bR)
            aU.Activated:Connect(bO)
            bK.ChildAdded:Connect(bO)
            bK.ChildRemoved:Connect(bO)
            bR()
            bO()
            local c6 = {}
            table.insert(j.Options, {type = "Dropdown", Name = bC, func = c6})
            function c6:Visible(bf)
                if bf == nil then
                    aU.Visible = not aU.Visible
                    return
                end
                aU.Visible = bf
            end
            function c6:Destroy()
                aU:Destroy()
            end
            function c6:Add(...)
                local c5 = {...}
                if type(c5[1]) == "table" then
                    table.foreach(
                        Option,
                        function(s, a2)
                            c0(a2)
                        end
                    )
                else
                    table.foreach(
                        c5,
                        function(s, a2)
                            c0(a2)
                        end
                    )
                end
            end
            function c6:Remove(Option)
                if type(Option) == "string" then
                    for s, ao in pairs(bY) do
                        if ao.Name == Option then
                            ao.Disable()
                        end
                    end
                elseif type(Option) == "number" then
                    for c3, ao in pairs(bY) do
                        if c3 == Option then
                            ao.Disable()
                        end
                    end
                end
            end
            function c6:Select(Option)
                if type(Option) == "string" then
                    for s, ao in pairs(bY) do
                        if ao.Name == Option then
                            ao.Active()
                        end
                    end
                elseif type(Option) == "number" then
                    for c3, ao in pairs(bY) do
                        if c3 == Option then
                            ao.Active()
                        end
                    end
                end
            end
            function c6:Set(aX)
                if type(aX) == "table" then
                    c5(aX)
                elseif type(aX) == "function" then
                    b4 = aX
                end
            end
            function c6:Callback(M)
                table.insert(br, M)
                task.spawn(M, bc[1])
            end
            return c6
        end
        function b6:AddSlider(P)
            local c7 = P[1] or P.Name or P.Title or "Slider!"
            local c8 = P.Desc or P.Description or ""
            local c9 = P[2] or P.MinValue or P.Min or 10
            local ca = P[3] or P.MaxValue or P.Max or 100
            local cb = P[4] or P.Increase or 1
            local bu = P[5] or P.Default or 25
            local b4 = P[6] or P.Callback or function()
                end
            local bv = P[7] or P.Flag or false
            local br = {}
            c9, ca = c9 / cb, ca / cb
            if bv and type(bv) == "string" and rawget(au, bv) then
                bu = au[bv]
            end
            local aU, bn = aa(bd, c7, c8, UDim2.new(1, -180))
            local cc =
                p(
                "TextButton",
                aU,
                {
                    Size = UDim2.new(0.45, 0, 1),
                    Position = UDim2.new(1),
                    AnchorPoint = Vector2.new(1, 0),
                    AutoButtonColor = false,
                    Text = "",
                    BackgroundTransparency = 1
                }
            )
            local cd =
                o(
                p(
                    "Frame",
                    cc,
                    {
                        BackgroundColor3 = z["Color Stroke"],
                        Size = UDim2.new(1, -20, 0, 6),
                        Position = UDim2.new(0.5, 0, 0.5),
                        AnchorPoint = Vector2.new(0.5, 0.5)
                    }
                ),
                "Stroke"
            )
            a4("Corner", cd)
            local ce =
                o(
                p(
                    "Frame",
                    cd,
                    {BackgroundColor3 = z["Color Theme"], Size = UDim2.fromScale(0.3, 1), BorderSizePixel = 0}
                ),
                "Theme"
            )
            a4("Corner", ce)
            local cf =
                p(
                "Frame",
                cd,
                {
                    Size = UDim2.new(0, 12, 0, 12),
                    BackgroundColor3 = Color3.fromRGB(220, 220, 220),
                    Position = UDim2.fromScale(0.3, 0.5),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundTransparency = 0.2
                }
            )
            a4("Corner", cf)
            local cg =
                o(
                p(
                    "TextLabel",
                    cc,
                    {
                        Size = UDim2.new(0, 14, 0, 14),
                        AnchorPoint = Vector2.new(1, 0.5),
                        Position = UDim2.new(0, 0, 0.5),
                        BackgroundTransparency = 1,
                        TextColor3 = z["Color Text"],
                        Font = Enum.Font.FredokaOne,
                        TextSize = 12
                    }
                ),
                "Text"
            )
            local l = p("UIScale", cg)
            local ch = p("Frame", cd, {Position = UDim2.new(0, 0, 0.5, 0), Visible = false})
            local function ci()
                if bv and typeof(bv) == "string" then
                    aw(bv, bu)
                end
            end
            local function cj(ck)
                local cl = tonumber(ck * cb)
                cl = math.floor(cl * 100) / 100
                bu, cg.Text = cl, tostring(cl)
                task.spawn(b4, bu)
            end
            local function cm()
                local cn = i:GetMouse()
                local co = cn.X - ch.AbsolutePosition.X
                local cp = co / cd.AbsoluteSize.X
                cf.Position = UDim2.new(math.clamp(cp, 0, 1), 0, 0.5, 0)
            end
            cc.MouseButton1Down:Connect(
                function()
                    O({cf, "Transparency", 0, 0.3})
                    bd.ScrollingEnabled = false
                    while b:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                        task.wait()
                        cm()
                    end
                    table.foreach(
                        br,
                        function(s, M)
                            if type(M) == "function" then
                                task.spawn(M, bu)
                            end
                        end
                    )
                    O({cf, "Transparency", 0.2, 0.3})
                    bd.ScrollingEnabled = true
                    ci()
                end
            )
            cg:GetPropertyChangedSignal("Text"):Connect(
                function()
                    l.Scale = 0.3
                    O({l, "Scale", 1.2, 0.1})
                    O({cg, "Rotation", math.random(-1, 1) * 5, 0.15, true})
                    O({l, "Scale", 1, 0.2})
                    O({cg, "Rotation", 0, 0.1})
                end
            )
            cf:GetPropertyChangedSignal("Position"):Connect(
                function()
                    ce.Size = UDim2.new(cf.Position.X.Scale, 0, 1, 0)
                    local cq = cf.Position.X.Scale
                    local ck = math.floor(cq * ca / ca * (ca - c9) + c9)
                    cj(ck)
                end
            )
            function SetSlider(ck)
                local c9, ca = c9 * cb, ca * cb
                local cq = (ck - c9) / (ca - c9)
                O({cf, "Position", UDim2.fromScale(math.clamp(cq, 0, 1), 0.5), 0.3, true})
                ci()
            end
            SetSlider(bu)
            local bx = {}
            table.insert(j.Options, {type = "Slider", Name = c7, func = bx})
            function bx:Set(cr, cs)
                if cr and cs then
                    bn:SetTitle(cr)
                    bn:SetDesc(cs)
                elseif type(cr) == "string" then
                    bn:SetTitle(cr)
                elseif type(cr) == "function" then
                    b4 = cr
                elseif type(cr) == "number" then
                    SetSlider(cr)
                end
            end
            function bx:Callback(M)
                table.insert(br, M)
            end
            function bx:Destroy()
                aU:Destroy()
            end
            function bx:Visible(bf)
                if bf == nil then
                    aU.Visible = not aU.Visible
                    return
                end
                aU.Visible = bf
            end
            return bx
        end
        function b6:AddTextBox(P)
            local b8 = P[1] or P.Name or P.Title or "Text Box"
            local bt = P.Desc or P.Description or ""
            local ct = P[2] or P.Default or ""
            local cu = P.PlaceholderText or "Input"
            local cv = P[3] or P.ClearText or false
            local b4 = P[2] or P.Callback or function()
                end
            local br = {}
            if type(ct) ~= "string" or ct:gsub(" ", ""):len() < 1 then
                ct = false
            end
            local aU, bn = aa(bd, b8, bt, UDim2.new(1, -38))
            local bF =
                o(
                p(
                    "Frame",
                    aU,
                    {
                        Size = UDim2.new(0, 150, 0, 18),
                        Position = UDim2.new(1, -10, 0.5),
                        AnchorPoint = Vector2.new(1, 0.5),
                        BackgroundColor3 = z["Color Stroke"]
                    }
                ),
                "Stroke"
            )
            a4("Corner", bF, UDim.new(0, 4))
            local cw =
                o(
                p(
                    "TextBox",
                    bF,
                    {
                        Size = UDim2.new(0.85, 0, 0.85, 0),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        BackgroundTransparency = 1,
                        Font = Enum.Font.GothamBold,
                        TextScaled = true,
                        TextColor3 = z["Color Text"],
                        ClearTextOnFocus = cv,
                        Text = ""
                    }
                ),
                "Text"
            )
            local cx =
                p(
                "ImageLabel",
                bF,
                {
                    Size = UDim2.new(0, 12, 0, 12),
                    Position = UDim2.new(0, -5, 0.5),
                    AnchorPoint = Vector2.new(1, 0.5),
                    Image = "rbxassetid://15637081879",
                    BackgroundTransparency = 1
                }
            )
            local function N()
                local cy = cw.Text
                if cy:gsub(" ", ""):len() < 1 then
                    return
                end
                task.spawn(b4, cy)
                table.foreach(
                    br,
                    function(M)
                        if type(M) == "function" then
                            task.spawn(M, cy)
                        end
                    end
                )
            end
            cw.FocusLost:Connect(N)
            cw.FocusLost:Connect(
                function()
                    O({cx, "ImageColor3", Color3.fromRGB(255, 255, 255), 0.2})
                end
            )
            cw.Focused:Connect(
                function()
                    O({cx, "ImageColor3", z["Color Theme"], 0.2})
                end
            )
            local cz = {}
            function cz:Destroy()
                aU:Destroy()
            end
            function cz:Visible(bf)
                if bf == nil then
                    aU.Visible = not aU.Visible
                    return
                end
                aU.Visible = bf
            end
            return cz
        end
        function b6:AddDiscordInvite(P)
            local ab = P[1] or P.Name or P.Title or ""
            local cA = P.Desc or P.Description or ""
            local cB = P[2] or P.Logo or ""
            local cC = P[3] or P.Invite or ""
            local cD = p("Frame", bd, {Size = UDim2.new(1, 0, 0, 80), Name = "Option", BackgroundTransparency = 1})
            local cE =
                o(
                p(
                    "Frame",
                    cD,
                    {
                        Size = UDim2.new(1, 0, 0, 65),
                        AnchorPoint = Vector2.new(0, 1),
                        Position = UDim2.new(0, 0, 1),
                        BackgroundColor3 = z["Color Hub 2"]
                    }
                ),
                "Frame"
            )
            a4("Corner", cE)
            local cF =
                p(
                "ImageLabel",
                cE,
                {
                    Size = UDim2.new(0, 30, 0, 30),
                    Position = UDim2.new(0, 7, 0, 7),
                    Image = cB,
                    BackgroundTransparency = 1
                }
            )
            a4("Corner", cF, UDim.new(0, 5))
            a4("Stroke", cF)
            o(
                p(
                    "TextLabel",
                    cE,
                    {
                        Size = UDim2.new(1, -52, 0, 15),
                        Position = UDim2.new(0, 44, 0, 7),
                        Font = Enum.Font.GothamBold,
                        TextColor3 = z["Color Text"],
                        TextXAlignment = "Left",
                        BackgroundTransparency = 1,
                        TextSize = 10,
                        Text = ab
                    }
                ),
                "Text"
            )
            local cG =
                o(
                p(
                    "TextLabel",
                    cE,
                    {
                        Size = UDim2.new(1, -52, 0, 0),
                        Position = UDim2.new(0, 44, 0, 22),
                        TextWrapped = "Y",
                        AutomaticSize = "Y",
                        Font = Enum.Font.Gotham,
                        TextColor3 = z["Color Dark Text"],
                        TextXAlignment = "Left",
                        BackgroundTransparency = 1,
                        TextSize = 8,
                        Text = cA
                    }
                ),
                "DarkText"
            )
            local cH =
                p(
                "TextButton",
                cE,
                {
                    Size = UDim2.new(1, -14, 0, 16),
                    AnchorPoint = Vector2.new(0.5, 1),
                    Position = UDim2.new(0.5, 0, 1, -7),
                    Text = "Join",
                    Font = Enum.Font.GothamBold,
                    TextSize = 12,
                    TextColor3 = Color3.fromRGB(200, 200, 200),
                    BackgroundColor3 = z["Color Theme"]
                }
            )
            a4("Corner", cH, UDim.new(0, 3))
            local cI
            cH.Activated:Connect(
                function()
                    setclipboard(cC)
                    if cI then
                        return
                    end
                    cI = true
                    m(
                        cH,
                        {
                            Text = "Copied to Clipboard",
                            BackgroundColor3 = Color3.fromRGB(100, 100, 100),
                            TextColor3 = Color3.fromRGB(150, 150, 150)
                        }
                    )
                    task.wait(5)
                    m(
                        cH,
                        {
                            Text = "Join",
                            BackgroundColor3 = Color3.fromRGB(50, 150, 50),
                            TextColor3 = Color3.fromRGB(220, 220, 220)
                        }
                    )
                    cI = false
                end
            )
            local cJ = {}
            function cJ:Destroy()
                cD:Destroy()
            end
            function cJ:Visible(bf)
                if bf == nil then
                    cD.Visible = not cD.Visible
                    return
                end
                cD.Visible = bf
            end
            return cJ
        end
        return b6
    end
    aQ.Activated:Connect(aR.CloseBtn)
    return aR
end
return j
