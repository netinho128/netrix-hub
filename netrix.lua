-- NETRIX HUB | Fluxo PVP (Versão Simplificada)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local IMAGE_ID = "rbxassetid://99262930883927"
local DISCORD_LINK = "https://discord.gg/yQyvXYM2CK"
local PURPLE = Color3.fromRGB(150, 70, 255)
local PINK = Color3.fromRGB(255, 90, 200)
local ESP_COLOR = Color3.fromRGB(0, 255, 255)

-- ==========================================
-- ESTADO
-- ==========================================
local State = {
    Aimbot = false,
    Contour = false,
    Line = false,
    Health = false
}

local FOV_RADIUS = 150 -- tamanho do FOV (menor = mais fechado | maior = mais aberto)

-- Círculo de FOV (aparece junto com o Aimbot)
local FOVCircle = Drawing.new("Circle")
FOVCircle.Color = PURPLE
FOVCircle.Thickness = 1.5
FOVCircle.Filled = false
FOVCircle.Transparency = 0.9
FOVCircle.NumSides = 64
FOVCircle.Radius = FOV_RADIUS
FOVCircle.Visible = false

-- ==========================================
-- INTERFACE
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NetrixHubGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = game.CoreGui
elseif gethui then
    ScreenGui.Parent = gethui()
else
    local ok = pcall(function() ScreenGui.Parent = game.CoreGui end)
    if not ok then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
end

-- Painel principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.fromScale(0.5, 0.5)
MainFrame.Size = UDim2.fromOffset(320, 330)
MainFrame.BackgroundColor3 = Color3.fromRGB(14, 10, 24)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Color = Color3.new(1, 1, 1)
MainStroke.Parent = MainFrame

local StrokeGradient = Instance.new("UIGradient")
StrokeGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, PURPLE),
    ColorSequenceKeypoint.new(0.5, PINK),
    ColorSequenceKeypoint.new(1, PURPLE)
})
StrokeGradient.Rotation = 45
StrokeGradient.Parent = MainStroke

-- Degradê de fundo
local BgGradient = Instance.new("UIGradient")
BgGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(26, 16, 46)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 8, 18))
})
BgGradient.Rotation = 90
BgGradient.Parent = MainFrame

-- Imagem de fundo meio transparente (criada primeiro para ficar atrás de tudo)
local BgImage = Instance.new("ImageLabel")
BgImage.Name = "BgImage"
BgImage.Parent = MainFrame
BgImage.AnchorPoint = Vector2.new(0.5, 0.5)
BgImage.Position = UDim2.fromScale(0.5, 0.5)
BgImage.Size = UDim2.fromScale(1, 1)
BgImage.BackgroundTransparency = 1
BgImage.Image = IMAGE_ID
BgImage.ImageTransparency = 0.85
BgImage.ScaleType = Enum.ScaleType.Crop
BgImage.ZIndex = 1
BgImage.Active = false

local BgImageCorner = Instance.new("UICorner")
BgImageCorner.CornerRadius = UDim.new(0, 14)
BgImageCorner.Parent = BgImage

-- Topo (cantos de cima arredondados, acompanhando o painel)
local TOP_HEIGHT = 46
local TOP_COLORS = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(130, 50, 240)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 80, 200))
})

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.Size = UDim2.new(1, 0, 0, TOP_HEIGHT)
TopBar.BackgroundColor3 = Color3.new(1, 1, 1)
TopBar.BackgroundTransparency = 0.15
TopBar.BorderSizePixel = 0
TopBar.ZIndex = 2

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 14)
TopCorner.Parent = TopBar

local TopGradient = Instance.new("UIGradient")
TopGradient.Color = TOP_COLORS
TopGradient.Rotation = 0
TopGradient.Parent = TopBar

-- Faixa reta embaixo da barra (deixa os cantos de baixo da barra retos)
local TopFill = Instance.new("Frame")
TopFill.Name = "TopFill"
TopFill.Parent = MainFrame
TopFill.Position = UDim2.fromOffset(0, TOP_HEIGHT - 16)
TopFill.Size = UDim2.new(1, 0, 0, 16)
TopFill.BackgroundColor3 = Color3.new(1, 1, 1)
TopFill.BackgroundTransparency = 0.15
TopFill.BorderSizePixel = 0
TopFill.ZIndex = 2

local TopFillGradient = Instance.new("UIGradient")
TopFillGradient.Color = TOP_COLORS
TopFillGradient.Rotation = 0
TopFillGradient.Parent = TopFill

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.fromOffset(14, 4)
Title.Size = UDim2.new(1, -60, 0, 22)
Title.Font = Enum.Font.GothamBlack
Title.Text = "🔥 NETRIX HUB"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 17
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 3

local SubTitle = Instance.new("TextLabel")
SubTitle.Parent = MainFrame
SubTitle.BackgroundTransparency = 1
SubTitle.Position = UDim2.fromOffset(14, 26)
SubTitle.Size = UDim2.new(1, -60, 0, 16)
SubTitle.Font = Enum.Font.GothamMedium
SubTitle.Text = "Fluxo PVP"
SubTitle.TextColor3 = Color3.fromRGB(240, 225, 255)
SubTitle.TextSize = 11
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.ZIndex = 3

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.AnchorPoint = Vector2.new(1, 0)
CloseBtn.Position = UDim2.new(1, -10, 0, 8)
CloseBtn.Size = UDim2.fromOffset(30, 30)
CloseBtn.BackgroundColor3 = Color3.new(0, 0, 0)
CloseBtn.BackgroundTransparency = 0.6
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.AutoButtonColor = false
CloseBtn.ZIndex = 3

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

-- Lista de opções
local Content = Instance.new("Frame")
Content.Parent = MainFrame
Content.BackgroundTransparency = 1
Content.Position = UDim2.fromOffset(14, 58)
Content.Size = UDim2.new(1, -28, 1, -70)
Content.ZIndex = 2

local List = Instance.new("UIListLayout")
List.Parent = Content
List.Padding = UDim.new(0, 8)
List.SortOrder = Enum.SortOrder.LayoutOrder

local function CreateToggle(order, icon, text, desc, key)
    local Row = Instance.new("TextButton")
    Row.Parent = Content
    Row.LayoutOrder = order
    Row.Size = UDim2.new(1, 0, 0, 48)
    Row.BackgroundColor3 = Color3.fromRGB(28, 20, 46)
    Row.BackgroundTransparency = 0.25
    Row.Text = ""
    Row.AutoButtonColor = false
    Row.ZIndex = 3

    local RowCorner = Instance.new("UICorner")
    RowCorner.CornerRadius = UDim.new(0, 10)
    RowCorner.Parent = Row

    local RowStroke = Instance.new("UIStroke")
    RowStroke.Color = PURPLE
    RowStroke.Transparency = 0.6
    RowStroke.Thickness = 1
    RowStroke.Parent = Row

    local Label = Instance.new("TextLabel")
    Label.Parent = Row
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.fromOffset(12, 6)
    Label.Size = UDim2.new(1, -80, 0, 18)
    Label.Font = Enum.Font.GothamBold
    Label.Text = icon .. "  " .. text
    Label.TextColor3 = Color3.new(1, 1, 1)
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.ZIndex = 4

    local Desc = Instance.new("TextLabel")
    Desc.Parent = Row
    Desc.BackgroundTransparency = 1
    Desc.Position = UDim2.fromOffset(12, 25)
    Desc.Size = UDim2.new(1, -80, 0, 16)
    Desc.Font = Enum.Font.Gotham
    Desc.Text = desc
    Desc.TextColor3 = Color3.fromRGB(190, 175, 220)
    Desc.TextSize = 11
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.ZIndex = 4

    local Pill = Instance.new("Frame")
    Pill.Parent = Row
    Pill.AnchorPoint = Vector2.new(1, 0.5)
    Pill.Position = UDim2.new(1, -12, 0.5, 0)
    Pill.Size = UDim2.fromOffset(44, 24)
    Pill.BackgroundColor3 = Color3.fromRGB(50, 40, 70)
    Pill.ZIndex = 4

    local PillCorner = Instance.new("UICorner")
    PillCorner.CornerRadius = UDim.new(1, 0)
    PillCorner.Parent = Pill

    local Knob = Instance.new("Frame")
    Knob.Parent = Pill
    Knob.AnchorPoint = Vector2.new(0, 0.5)
    Knob.Position = UDim2.new(0, 3, 0.5, 0)
    Knob.Size = UDim2.fromOffset(18, 18)
    Knob.BackgroundColor3 = Color3.new(1, 1, 1)
    Knob.ZIndex = 5

    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(1, 0)
    KnobCorner.Parent = Knob

    local info = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    Row.MouseButton1Click:Connect(function()
        State[key] = not State[key]
        local on = State[key]
        TweenService:Create(Pill, info, {
            BackgroundColor3 = on and PURPLE or Color3.fromRGB(50, 40, 70)
        }):Play()
        TweenService:Create(Knob, info, {
            Position = on and UDim2.new(1, -21, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
        }):Play()
    end)
end

CreateToggle(1, "🎯", "Aimbot + FOV", "Mira automática com círculo de FOV", "Aimbot")
CreateToggle(2, "✨", "ESP Contorno", "Contorno nos jogadores", "Contour")
CreateToggle(3, "📏", "ESP Line", "Linhas até os jogadores", "Line")
CreateToggle(4, "❤️", "ESP Health", "Mostra a vida dos jogadores", "Health")

-- Botão Join Discord (ícone de link externo)
local DiscordBtn = Instance.new("TextButton")
DiscordBtn.Parent = Content
DiscordBtn.LayoutOrder = 5
DiscordBtn.Size = UDim2.new(1, 0, 0, 44)
DiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
DiscordBtn.Text = ""
DiscordBtn.AutoButtonColor = false
DiscordBtn.ZIndex = 3

local DiscordCorner = Instance.new("UICorner")
DiscordCorner.CornerRadius = UDim.new(0, 10)
DiscordCorner.Parent = DiscordBtn

local DiscordLabel = Instance.new("TextLabel")
DiscordLabel.Parent = DiscordBtn
DiscordLabel.BackgroundTransparency = 1
DiscordLabel.Position = UDim2.fromOffset(14, 0)
DiscordLabel.Size = UDim2.new(1, -60, 1, 0)
DiscordLabel.Font = Enum.Font.GothamBold
DiscordLabel.Text = "💬  Join Discord"
DiscordLabel.TextColor3 = Color3.new(1, 1, 1)
DiscordLabel.TextSize = 14
DiscordLabel.TextXAlignment = Enum.TextXAlignment.Left
DiscordLabel.ZIndex = 4

local LinkIcon = Instance.new("TextLabel")
LinkIcon.Parent = DiscordBtn
LinkIcon.AnchorPoint = Vector2.new(1, 0.5)
LinkIcon.Position = UDim2.new(1, -14, 0.5, 0)
LinkIcon.Size = UDim2.fromOffset(28, 28)
LinkIcon.BackgroundTransparency = 1
LinkIcon.Font = Enum.Font.GothamBlack
LinkIcon.Text = "↗"
LinkIcon.TextColor3 = Color3.new(1, 1, 1)
LinkIcon.TextSize = 22
LinkIcon.ZIndex = 4

DiscordBtn.MouseButton1Click:Connect(function()
    local copied = false
    if setclipboard then
        copied = pcall(setclipboard, DISCORD_LINK)
    elseif toclipboard then
        copied = pcall(toclipboard, DISCORD_LINK)
    end

    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "NETRIX HUB",
            Text = copied and "Link do Discord copiado!" or DISCORD_LINK,
            Duration = 4
        })
    end)
end)

-- ==========================================
-- BOTÃO FLUTUANTE (QUADRADO ARREDONDADO)
-- ==========================================
local FloatButton = Instance.new("ImageButton")
FloatButton.Name = "NetrixFloatBtn"
FloatButton.Parent = ScreenGui
FloatButton.AnchorPoint = Vector2.new(0.5, 0.5)
FloatButton.Size = UDim2.fromOffset(60, 60)
FloatButton.Position = UDim2.new(0.06, 0, 0.2, 0)
FloatButton.Image = IMAGE_ID
FloatButton.BackgroundTransparency = 1
FloatButton.BorderSizePixel = 0
FloatButton.AutoButtonColor = false
FloatButton.ScaleType = Enum.ScaleType.Crop
FloatButton.Active = true
FloatButton.Draggable = true

local FloatCorner = Instance.new("UICorner")
FloatCorner.CornerRadius = UDim.new(0, 16)
FloatCorner.Parent = FloatButton

local floatInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

FloatButton.MouseEnter:Connect(function()
    TweenService:Create(FloatButton, floatInfo, { Size = UDim2.fromOffset(66, 66) }):Play()
end)
FloatButton.MouseLeave:Connect(function()
    TweenService:Create(FloatButton, floatInfo, { Size = UDim2.fromOffset(60, 60) }):Play()
end)

local function TogglePanel()
    MainFrame.Visible = not MainFrame.Visible
end

FloatButton.MouseButton1Click:Connect(TogglePanel)
CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

-- ==========================================
-- FUNÇÕES AUXILIARES
-- ==========================================
local function IsAlive(player)
    if not player or player == LocalPlayer then return false end
    local char = player.Character
    if not char or not char:IsDescendantOf(workspace) then return false end

    local hum = char:FindFirstChildOfClass("Humanoid")
    local head = char:FindFirstChild("Head")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not hum or not head or not root then return false end
    if hum.Health <= 0 then return false end

    local st = hum:GetState()
    if st == Enum.HumanoidStateType.Dead or st == Enum.HumanoidStateType.Physics then
        return false
    end
    return true
end

local RayParams = RaycastParams.new()
RayParams.FilterType = Enum.RaycastFilterType.Exclude
RayParams.IgnoreWater = true

local function IsVisible(char)
    local head = char:FindFirstChild("Head")
    if not head then return false end
    local filter = { char }
    if LocalPlayer.Character then table.insert(filter, LocalPlayer.Character) end
    RayParams.FilterDescendantsInstances = filter
    local origin = Camera.CFrame.Position
    return workspace:Raycast(origin, head.Position - origin, RayParams) == nil
end

local function GetAimTarget()
    local best, bestDist = nil, FOV_RADIUS
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, player in ipairs(Players:GetPlayers()) do
        if IsAlive(player) then
            local head = player.Character.Head
            local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
            if onScreen then
                local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                if dist < bestDist and IsVisible(player.Character) then
                    best, bestDist = head, dist
                end
            end
        end
    end
    return best
end

-- ==========================================
-- ESP
-- ==========================================
local ESP = {}

local function CreateESP(player)
    if ESP[player] then return ESP[player] end

    local d = {
        Line = Drawing.new("Line"),
        BarBack = Drawing.new("Square"),
        BarFill = Drawing.new("Square"),
        HealthText = Drawing.new("Text")
    }

    d.Line.Color = ESP_COLOR
    d.Line.Thickness = 1.5
    d.Line.Visible = false

    d.BarBack.Filled = true
    d.BarBack.Color = Color3.new(0, 0, 0)
    d.BarBack.Transparency = 0.6
    d.BarBack.Visible = false

    d.BarFill.Filled = true
    d.BarFill.Color = Color3.fromRGB(0, 255, 0)
    d.BarFill.Transparency = 1
    d.BarFill.Visible = false

    d.HealthText.Size = 12
    d.HealthText.Center = true
    d.HealthText.Outline = true
    d.HealthText.Color = Color3.new(1, 1, 1)
    d.HealthText.Visible = false

    ESP[player] = d
    return d
end

local function HideESP(d)
    d.Line.Visible = false
    d.BarBack.Visible = false
    d.BarFill.Visible = false
    d.HealthText.Visible = false
end

local function SetContour(char, enabled)
    if not char then return end
    local hl = char:FindFirstChild("NetrixContour")
    if enabled then
        if not hl then
            hl = Instance.new("Highlight")
            hl.Name = "NetrixContour"
            hl.FillColor = ESP_COLOR
            hl.OutlineColor = ESP_COLOR
            hl.FillTransparency = 0.6
            hl.OutlineTransparency = 0
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.Parent = char
        end
        hl.Enabled = true
    elseif hl then
        hl.Enabled = false
    end
end

local function RemoveESP(player)
    local d = ESP[player]
    if d then
        for _, obj in pairs(d) do obj:Remove() end
        ESP[player] = nil
    end
    if player.Character then
        local hl = player.Character:FindFirstChild("NetrixContour")
        if hl then hl:Destroy() end
    end
end

Players.PlayerRemoving:Connect(RemoveESP)

-- ==========================================
-- LOOP PRINCIPAL
-- ==========================================
RunService.RenderStepped:Connect(function()
    Camera = workspace.CurrentCamera or Camera

    -- FOV (aparece junto com o Aimbot)
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    FOVCircle.Radius = FOV_RADIUS
    FOVCircle.Visible = State.Aimbot

    -- Aimbot
    if State.Aimbot then
        local head = GetAimTarget()
        if head then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, head.Position)
        end
    end

    -- ESP
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local d = CreateESP(player)
            local alive = IsAlive(player)

            SetContour(player.Character, State.Contour and alive)

            if alive and (State.Line or State.Health) then
                local char = player.Character
                local hrp = char.HumanoidRootPart
                local hum = char:FindFirstChildOfClass("Humanoid")
                local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)

                if onScreen then
                    -- Linha
                    if State.Line then
                        d.Line.From = Vector2.new(Camera.ViewportSize.X / 2, 0)
                        d.Line.To = Vector2.new(pos.X, pos.Y)
                        d.Line.Visible = true
                    else
                        d.Line.Visible = false
                    end

                    -- Vida
                    if State.Health then
                        local top = Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3, 0))
                        local bottom = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3.5, 0))
                        local height = math.abs(top.Y - bottom.Y)
                        local width = height / 1.8
                        local x = pos.X - width / 2 - 7

                        local ratio = math.clamp(hum.Health / math.max(hum.MaxHealth, 1), 0, 1)

                        d.BarBack.Position = Vector2.new(x, top.Y)
                        d.BarBack.Size = Vector2.new(4, height)
                        d.BarBack.Visible = true

                        d.BarFill.Color = Color3.fromRGB(255, 0, 0):Lerp(Color3.fromRGB(0, 255, 0), ratio)
                        d.BarFill.Size = Vector2.new(4, height * ratio)
                        d.BarFill.Position = Vector2.new(x, top.Y + height * (1 - ratio))
                        d.BarFill.Visible = true

                        d.HealthText.Text = tostring(math.floor(hum.Health)) .. " HP"
                        d.HealthText.Position = Vector2.new(pos.X, bottom.Y + 4)
                        d.HealthText.Visible = true
                    else
                        d.BarBack.Visible = false
                        d.BarFill.Visible = false
                        d.HealthText.Visible = false
                    end
                else
                    HideESP(d)
                end
            else
                HideESP(d)
            end
        end
    end
end)
