 -- NETRIX | Fluxo PVP Hub - Tema Roxo Reto (Com Pontas)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Variáveis de Estado (Ignorar Mortos agora inicia DESATIVADO por padrão)
local AimBotEnabled = false
local ShowFOV = false
local FOVRadius = 150
local IgnoreDowned = false -- Alterado para false

local ESPBoxEnabled = false
local ESPSkeletonEnabled = false
local ESPLineEnabled = false

local SpinbotEnabled = false
local SpinSpeed = 50

local DiscordLink = "https://discord.gg/5TFHuucxgw"
local YoutubeLink = "https://www.youtube.com/@Netrixofc"

-- --- Interface Gráfica ---
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NetrixHubRoxo"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Painel Principal (Com Bordas Quadradas / Pontas)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 360, 0, 240)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -120)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 8, 15)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
MainFrame.BorderSizePixel = 0

-- UIStroke aplicado reto para contorno roxo
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(138, 43, 226)
MainStroke.Thickness = 2.5

-- Barra Superior (Topo Roxo Reto)
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 32)
TopBar.Position = UDim2.new(0, 0, 0, 0)
TopBar.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
TopBar.BorderSizePixel = 0

-- Título
local Title = Instance.new("TextLabel", TopBar)
Title.Text = "NETRIX HUB | Fluxo PVP"
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Botão Minimizar (Ícone ❌ no canto superior direito)
local MinimizeBtn = Instance.new("TextButton", TopBar)
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.Size = UDim2.new(0, 30, 1, 0)
MinimizeBtn.Position = UDim2.new(1, -30, 0, 0)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Text = "❌"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 12

-- Botão Flutuante (Usando formato rbxthumb para garantir o carregamento do Asset)
local FloatingButton = Instance.new("ImageButton", ScreenGui)
FloatingButton.Name = "FloatingButton"
FloatingButton.Size = UDim2.new(0, 48, 0, 48)
FloatingButton.Position = UDim2.new(0.05, 0, 0.2, 0)
FloatingButton.Image = "rbxthumb://type=Asset&id=109965584967630&w=150&h=150"
FloatingButton.BackgroundColor3 = Color3.fromRGB(30, 0, 50)
FloatingButton.Active = true
FloatingButton.Draggable = true
FloatingButton.Visible = false

local FloatStroke = Instance.new("UIStroke", FloatingButton)
FloatStroke.Color = Color3.fromRGB(138, 43, 226)
FloatStroke.Thickness = 1.5

local function ToggleMenu()
    MainFrame.Visible = not MainFrame.Visible
    FloatingButton.Visible = not MainFrame.Visible
end

FloatingButton.MouseButton1Click:Connect(ToggleMenu)
MinimizeBtn.MouseButton1Click:Connect(ToggleMenu)

-- Barra Lateral de Navegação (Menu Esquerdo Reto)
local SideBar = Instance.new("Frame", MainFrame)
SideBar.Name = "SideBar"
SideBar.Size = UDim2.new(0, 50, 1, -32)
SideBar.Position = UDim2.new(0, 0, 0, 32)
SideBar.BackgroundColor3 = Color3.fromRGB(15, 12, 22)
SideBar.BorderSizePixel = 0

local SideList = Instance.new("UIListLayout", SideBar)
SideList.FillDirection = Enum.FillDirection.Vertical
SideList.HorizontalAlignment = Enum.HorizontalAlignment.Center
SideList.Padding = UDim.new(0, 6)

local SidePadding = Instance.new("UIPadding", SideBar)
SidePadding.PaddingTop = UDim.new(0, 8)

local TabPVPBtn = Instance.new("TextButton", SideBar)
TabPVPBtn.Size = UDim2.new(0, 36, 0, 36)
TabPVPBtn.Text = "🎯"
TabPVPBtn.Font = Enum.Font.GothamBold
TabPVPBtn.TextSize = 16
TabPVPBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
TabPVPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TabPVPBtn.BorderSizePixel = 0

local TabRedesBtn = Instance.new("TextButton", SideBar)
TabRedesBtn.Size = UDim2.new(0, 36, 0, 36)
TabRedesBtn.Text = "🌐"
TabRedesBtn.Font = Enum.Font.GothamBold
TabRedesBtn.TextSize = 16
TabRedesBtn.BackgroundColor3 = Color3.fromRGB(25, 20, 35)
TabRedesBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
TabRedesBtn.BorderSizePixel = 0

-- Containers de Conteúdo
local PVPFrame = Instance.new("ScrollingFrame", MainFrame)
PVPFrame.Name = "PVPFrame"
PVPFrame.Size = UDim2.new(1, -60, 1, -40)
PVPFrame.Position = UDim2.new(0, 55, 0, 36)
PVPFrame.BackgroundTransparency = 1
PVPFrame.ScrollBarThickness = 2
PVPFrame.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
PVPFrame.CanvasSize = UDim2.new(0, 0, 0, 210)
PVPFrame.Visible = true

local RedesFrame = Instance.new("ScrollingFrame", MainFrame)
RedesFrame.Name = "RedesFrame"
RedesFrame.Size = UDim2.new(1, -60, 1, -40)
RedesFrame.Position = UDim2.new(0, 55, 0, 36)
RedesFrame.BackgroundTransparency = 1
RedesFrame.ScrollBarThickness = 2
RedesFrame.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
RedesFrame.CanvasSize = UDim2.new(0, 0, 0, 100)
RedesFrame.Visible = false

local PVPGrid = Instance.new("UIGridLayout", PVPFrame)
PVPGrid.CellSize = UDim2.new(0.47, 0, 0, 30)
PVPGrid.CellPadding = UDim2.new(0, 6, 0, 6)

local RedesList = Instance.new("UIListLayout", RedesFrame)
RedesList.SortOrder = Enum.SortOrder.LayoutOrder
RedesList.Padding = UDim.new(0, 6)

-- Troca de Abas
TabPVPBtn.MouseButton1Click:Connect(function()
    PVPFrame.Visible = true
    RedesFrame.Visible = false
    TabPVPBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    TabRedesBtn.BackgroundColor3 = Color3.fromRGB(25, 20, 35)
end)

TabRedesBtn.MouseButton1Click:Connect(function()
    PVPFrame.Visible = false
    RedesFrame.Visible = true
    TabRedesBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    TabPVPBtn.BackgroundColor3 = Color3.fromRGB(25, 20, 35)
end)

-- --- Criador de Switch estilo Quadrado ---
local function CreateSwitch(name, defaultState, callback)
    local state = defaultState

    local btnFrame = Instance.new("TextButton", PVPFrame)
    btnFrame.Size = UDim2.new(1, 0, 1, 0)
    btnFrame.BackgroundColor3 = Color3.fromRGB(20, 16, 28)
    btnFrame.Text = ""
    btnFrame.AutoButtonColor = false
    btnFrame.BorderSizePixel = 0

    local box = Instance.new("Frame", btnFrame)
    box.Size = UDim2.new(0, 16, 0, 16)
    box.Position = UDim2.new(0, 7, 0.5, -8)
    box.BackgroundColor3 = state and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(35, 30, 45)
    box.BorderSizePixel = 0

    local stroke = Instance.new("UIStroke", box)
    stroke.Color = Color3.fromRGB(138, 43, 226)
    stroke.Thickness = 1

    local label = Instance.new("TextLabel", btnFrame)
    label.Size = UDim2.new(1, -30, 1, 0)
    label.Position = UDim2.new(0, 28, 0, 0)
    label.Text = name
    label.TextColor3 = Color3.fromRGB(230, 230, 230)
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1

    btnFrame.MouseButton1Click:Connect(function()
        state = not state
        box.BackgroundColor3 = state and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(35, 30, 45)
        callback(state)
    end)
end

-- Slider FOV Compacto
local SliderFrame = Instance.new("Frame", PVPFrame)
SliderFrame.Size = UDim2.new(1, 0, 1, 0)
SliderFrame.BackgroundColor3 = Color3.fromRGB(20, 16, 28)
SliderFrame.BorderSizePixel = 0

local MinusBtn = Instance.new("TextButton", SliderFrame)
MinusBtn.Size = UDim2.new(0, 18, 0, 18)
MinusBtn.Position = UDim2.new(0, 5, 0.5, -9)
MinusBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
MinusBtn.Text = "-"
MinusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinusBtn.Font = Enum.Font.GothamBold
MinusBtn.TextSize = 11
MinusBtn.BorderSizePixel = 0

local FOVValText = Instance.new("TextLabel", SliderFrame)
FOVValText.Size = UDim2.new(1, -50, 1, 0)
FOVValText.Position = UDim2.new(0, 26, 0, 0)
FOVValText.Text = "FOV: " .. tostring(FOVRadius) .. "px"
FOVValText.TextColor3 = Color3.fromRGB(230, 230, 230)
FOVValText.Font = Enum.Font.GothamMedium
FOVValText.TextSize = 10
FOVValText.TextXAlignment = Enum.TextXAlignment.Left
FOVValText.BackgroundTransparency = 1

local PlusBtn = Instance.new("TextButton", SliderFrame)
PlusBtn.Size = UDim2.new(0, 18, 0, 18)
PlusBtn.Position = UDim2.new(1, -23, 0.5, -9)
PlusBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
PlusBtn.Text = "+"
PlusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PlusBtn.Font = Enum.Font.GothamBold
PlusBtn.TextSize = 11
PlusBtn.BorderSizePixel = 0

MinusBtn.MouseButton1Click:Connect(function()
    if FOVRadius > 30 then
        FOVRadius = FOVRadius - 15
        FOVValText.Text = "FOV: " .. tostring(FOVRadius) .. "px"
    end
end)

PlusBtn.MouseButton1Click:Connect(function()
    if FOVRadius < 400 then
        FOVRadius = FOVRadius + 15
        FOVValText.Text = "FOV: " .. tostring(FOVRadius) .. "px"
    end
end)

-- Opções na Aba PVP
CreateSwitch("Aimbot Cabeça", false, function(s) AimBotEnabled = s end)
CreateSwitch("Exibir FOV", false, function(s) ShowFOV = s end)
CreateSwitch("Ignorar Mortos", false, function(s) IgnoreDowned = s end) -- Inicia desativado (false)
CreateSwitch("ESP Box", false, function(s) ESPBoxEnabled = s end)
CreateSwitch("ESP Esqueleto", false, function(s) ESPSkeletonEnabled = s end)
CreateSwitch("ESP Line", false, function(s) ESPLineEnabled = s end)
CreateSwitch("Spinbot", false, function(s) SpinbotEnabled = s end)

-- Criador de Botões para a Aba Redes
local function CreateSocialBtn(text, link, iconText)
    local btn = Instance.new("TextButton", RedesFrame)
    btn.Size = UDim2.new(0.95, 0, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(20, 16, 28)
    btn.Text = iconText .. " " .. text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.BorderSizePixel = 0

    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(138, 43, 226)
    stroke.Thickness = 1

    btn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(link)
        elseif toclipboard then
            toclipboard(link)
        end

        pcall(function()
            StarterGui:SetCore("SendNotification", {
                Title = "NETRIX",
                Text = "Link do " .. text .. " copiado!",
                Duration = 3
            })
        end)
    end)
end

CreateSocialBtn("Discord", DiscordLink, "💬")
CreateSocialBtn("YouTube", YoutubeLink, "▶")

-- --- Função para verificar se o jogador está Vivo / Válido ---
local function IsPlayerAlive(player)
    if not player or not player.Character then return false end
    local char = player.Character
    local hum = char:FindFirstChildOfClass("Humanoid")
    
    if not hum then return false end

    if IgnoreDowned then
        if hum.Health <= 0 then return false end

        local isDowned = char:FindFirstChild("IsDowned") or char:FindFirstChild("Downed") or char:FindFirstChild("Killed") or char:FindFirstChild("Knocked") or char:FindFirstChild("Dead")
        if isDowned and (isDowned.Value == true or isDowned.Value == 1) then
            return false
        end

        if hum:GetState() == Enum.HumanoidStateType.Physics or hum:GetState() == Enum.HumanoidStateType.Dead then
            return false
        end
    end

    return true
end

-- --- Lógica Aimbot, FOV, Spinbot e ESPs ---
local FOVCircle = Drawing.new("Circle")
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
FOVCircle.Radius = FOVRadius
FOVCircle.Color = Color3.fromRGB(0, 255, 255)
FOVCircle.Thickness = 1.5
FOVCircle.Filled = false
FOVCircle.Visible = false

local Lines = {}
local Skeletons = {}
local Boxes = {}

local function GetLine(player)
    if not Lines[player] then
        local line = Drawing.new("Line")
        line.Color = Color3.fromRGB(0, 255, 255)
        line.Thickness = 1.5
        line.Transparency = 1
        Lines[player] = line
    end
    return Lines[player]
end

local function GetSkeleton(player)
    if not Skeletons[player] then
        local skel = {}
        for i = 1, 10 do
            local l = Drawing.new("Line")
            l.Color = Color3.fromRGB(0, 255, 255)
            l.Thickness = 1.5
            l.Transparency = 1
            table.insert(skel, l)
        end
        Skeletons[player] = skel
    end
    return Skeletons[player]
end

local function GetBox(player)
    if not Boxes[player] then
        local box = Drawing.new("Square")
        box.Color = Color3.fromRGB(0, 255, 255)
        box.Thickness = 1.5
        box.Filled = false
        box.Transparency = 1
        Boxes[player] = box
    end
    return Boxes[player]
end

local function HideSkeleton(skel)
    if skel then
        for _, l in ipairs(skel) do
            l.Visible = false
        end
    end
end

RunService.RenderStepped:Connect(function()
    pcall(function()
        FOVCircle.Visible = ShowFOV
        if ShowFOV then
            FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            FOVCircle.Radius = FOVRadius
        end
        
        if SpinbotEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(SpinSpeed), 0)
        end
        
        if AimBotEnabled then
            local TargetHead = nil
            local NearestDist = FOVRadius
            local CenterScreen = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and IsPlayerAlive(p) and p.Character:FindFirstChild("Head") then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(p.Character.Head.Position)
                    if onScreen then
                        local dist = (Vector2.new(screenPos.X, screenPos.Y) - CenterScreen).Magnitude
                        if dist < NearestDist then
                            TargetHead = p.Character.Head
                            NearestDist = dist
                        end
                    end
                end
            end
            
            if TargetHead then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, TargetHead.Position)
            end
        end
        
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                local char = p.Character
                
                if IsPlayerAlive(p) and char:FindFirstChild("HumanoidRootPart") then
                    local hrp = char.HumanoidRootPart
                    
                    local box = GetBox(p)
                    if ESPBoxEnabled then
                        local hrpPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                        if onScreen then
                            local headPos = Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3, 0))
                            local legPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3.5, 0))
                            local height = math.abs(headPos.Y - legPos.Y)
                            local width = height / 1.8

                            box.Size = Vector2.new(width, height)
                            box.Position = Vector2.new(hrpPos.X - width / 2, headPos.Y)
                            box.Visible = true
                        else
                            box.Visible = false
                        end
                    else
                        box.Visible = false
                    end

                    local skel = GetSkeleton(p)
                    if ESPSkeletonEnabled then
                        local joints = {
                            {"Head", "UpperTorso"}, {"UpperTorso", "LowerTorso"},
                            {"UpperTorso", "LeftUpperArm"}, {"LeftUpperArm", "LeftLowerArm"},
                            {"UpperTorso", "RightUpperArm"}, {"RightUpperArm", "RightLowerArm"},
                            {"LowerTorso", "LeftUpperLeg"}, {"LeftUpperLeg", "LeftLowerLeg"},
                            {"LowerTorso", "RightUpperLeg"}, {"RightUpperLeg", "RightLowerLeg"}
                        }
                        
                        if not char:FindFirstChild("UpperTorso") then
                            joints = {
                                {"Head", "Torso"}, {"Torso", "Left Arm"},
                                {"Torso", "Right Arm"}, {"Torso", "Left Leg"},
                                {"Torso", "Right Leg"}
                            }
                        end

                        for idx, pair in ipairs(joints) do
                            local partA = char:FindFirstChild(pair[1])
                            local partB = char:FindFirstChild(pair[2])
                            local l = skel[idx]
                            if partA and partB and l then
                                local posA, visA = Camera:WorldToViewportPoint(partA.Position)
                                local posB, visB = Camera:WorldToViewportPoint(partB.Position)
                                if visA and visB then
                                    l.From = Vector2.new(posA.X, posA.Y)
                                    l.To = Vector2.new(posB.X, posB.Y)
                                    l.Visible = true
                                else
                                    l.Visible = false
                                end
                            elseif l then
                                l.Visible = false
                            end
                        end
                    else
                        HideSkeleton(skel)
                    end

                    local line = GetLine(p)
                    if ESPLineEnabled then
                        local hrpPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                        if onScreen then
                            line.From = Vector2.new(Camera.ViewportSize.X / 2, 0)
                            line.To = Vector2.new(hrpPos.X, hrpPos.Y)
                            line.Visible = true
                        else
                            line.Visible = false
                        end
                    else
                        line.Visible = false
                    end
                else
                    if Boxes[p] then Boxes[p].Visible = false end
                    if Lines[p] then Lines[p].Visible = false end
                    if Skeletons[p] then HideSkeleton(Skeletons[p]) end
                end
            end
        end
    end)
end)

Players.PlayerRemoving:Connect(function(p)
    if Boxes[p] then
        Boxes[p]:Remove()
        Boxes[p] = nil
    end
    if Lines[p] then
        Lines[p]:Remove()
        Lines[p] = nil
    end
    if Skeletons[p] then
        for _, l in ipairs(Skeletons[p]) do
            l:Remove()
        end
        Skeletons[p] = nil
    end
end)
