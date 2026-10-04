--[==[ Void Hub - Device Key + Server Hop + Test Bypass ]==]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Stats = game:GetService("Stats")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer

local existing = CoreGui:FindFirstChild("VoidHubSystem")
if existing then existing:Destroy() end

local voidHubSystem = Instance.new("ScreenGui")
voidHubSystem.Name = "VoidHubSystem"
voidHubSystem.ResetOnSpawn = false
voidHubSystem.Parent = CoreGui

local purpleColor = Color3.fromRGB(140, 40, 220)
local DISCORD_LINK = "https://discord.gg/rkwe7eun8"

local function getDeviceIdentifier()
    local id = nil
    pcall(function()
        local service = game:GetService("RbxAnalyticsService")
        if service and service.GetClientId then
            id = service:GetClientId()
        end
    end)
    if not id or id == "" then
        pcall(function()
            id = HttpService:GetUserAgent()
        end)
    end
    if not id or id == "" then
        id = tostring(LocalPlayer.UserId) .. "_" .. tostring(game.PlaceId)
    end
    return id
end

local deviceId = getDeviceIdentifier()

local function generateDeviceKey()
    local str = "VOIDHUB_" .. deviceId .. "_" .. tostring(LocalPlayer.UserId) .. "_" .. tostring(game.PlaceId)
    local hash = 0
    for i = 1, #str do
        hash = (hash * 31 + string.byte(str, i)) % 4294967296
    end
    return string.format("VH-%08X-%04X", hash, (hash * 7) % 65536)
end

local deviceKey = generateDeviceKey()

local keyContainer = Instance.new("Frame", voidHubSystem)
keyContainer.Name = "KeyContainer"
keyContainer.Size = UDim2.new(0, 400, 0, 240)
keyContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
keyContainer.AnchorPoint = Vector2.new(0.5, 0.5)
keyContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
keyContainer.BackgroundTransparency = 0.3
keyContainer.ClipsDescendants = true

Instance.new("UICorner", keyContainer).CornerRadius = UDim.new(0, 28)

local keyBg = Instance.new("ImageLabel", keyContainer)
keyBg.Name = "KeyBackgroundImage"
keyBg.Size = UDim2.new(1, 0, 1, 0)
keyBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
keyBg.BackgroundTransparency = 1
keyBg.Image = "rbxassetid://112459375607724"
keyBg.ImageTransparency = 0
keyBg.ScaleType = Enum.ScaleType.Crop
keyBg.ZIndex = 0
Instance.new("UICorner", keyBg).CornerRadius = UDim.new(0, 28)

local keyStroke = Instance.new("UIStroke", keyContainer)
keyStroke.Color = purpleColor
keyStroke.Thickness = 2.5

local titleKey = Instance.new("TextLabel", keyContainer)
titleKey.Size = UDim2.new(1, 0, 0, 32)
titleKey.Position = UDim2.new(0, 0, 0, 18)
titleKey.BackgroundTransparency = 1
titleKey.Text = "VOID HUB"
titleKey.Font = Enum.Font.GothamBold
titleKey.TextSize = 20
titleKey.TextColor3 = Color3.fromRGB(255, 255, 255)
titleKey.ZIndex = 3

local subTitleKey = Instance.new("TextLabel", keyContainer)
subTitleKey.Size = UDim2.new(1, 0, 0, 16)
subTitleKey.Position = UDim2.new(0, 0, 0, 48)
subTitleKey.BackgroundTransparency = 1
subTitleKey.Text = "Digite sua Key para continuar"
subTitleKey.Font = Enum.Font.Gotham
subTitleKey.TextSize = 11
subTitleKey.TextColor3 = Color3.fromRGB(180, 160, 200)
subTitleKey.ZIndex = 3

local textBox = Instance.new("TextBox", keyContainer)
textBox.Size = UDim2.new(0, 340, 0, 40)
textBox.Position = UDim2.new(0.5, -170, 0, 78)
textBox.BackgroundColor3 = Color3.fromRGB(15, 10, 25)
textBox.BackgroundTransparency = 0.4
textBox.PlaceholderText = "Digite sua Key..."
textBox.PlaceholderColor3 = Color3.fromRGB(140, 120, 160)
textBox.Text = ""
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 13
Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 10)
textBox.ZIndex = 3

local validateBtn = Instance.new("TextButton", keyContainer)
validateBtn.Size = UDim2.new(0, 165, 0, 40)
validateBtn.Position = UDim2.new(0, 30, 0, 130)
validateBtn.BackgroundColor3 = purpleColor
validateBtn.BackgroundTransparency = 0.2
validateBtn.Text = "Verificar"
validateBtn.Font = Enum.Font.GothamBold
validateBtn.TextSize = 13
validateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
validateBtn.AutoButtonColor = false
Instance.new("UICorner", validateBtn).CornerRadius = UDim.new(0, 10)
validateBtn.ZIndex = 3

local getKeyBtn = Instance.new("TextButton", keyContainer)
getKeyBtn.Size = UDim2.new(0, 165, 0, 40)
getKeyBtn.Position = UDim2.new(1, -195, 0, 130)
getKeyBtn.BackgroundColor3 = Color3.fromRGB(20, 15, 30)
getKeyBtn.BackgroundTransparency = 0.4
getKeyBtn.Text = "Obter Key"
getKeyBtn.Font = Enum.Font.GothamBold
getKeyBtn.TextSize = 13
getKeyBtn.TextColor3 = Color3.fromRGB(220, 180, 255)
getKeyBtn.AutoButtonColor = false
Instance.new("UICorner", getKeyBtn).CornerRadius = UDim.new(0, 10)
getKeyBtn.ZIndex = 3
local getKeyStroke = Instance.new("UIStroke", getKeyBtn)
getKeyStroke.Color = purpleColor
getKeyStroke.Thickness = 1.5

local discordLink = Instance.new("TextLabel", keyContainer)
discordLink.Size = UDim2.new(1, 0, 0, 18)
discordLink.Position = UDim2.new(0, 0, 0, 188)
discordLink.BackgroundTransparency = 1
discordLink.Text = "discord.gg/rkwe7eun8"
discordLink.Font = Enum.Font.GothamBold
discordLink.TextSize = 11
discordLink.TextColor3 = Color3.fromRGB(180, 150, 220)
discordLink.ZIndex = 3

getKeyBtn.MouseButton1Click:Connect(function()
    if setclipboard then setclipboard(deviceKey) end
    
    local notif = Instance.new("TextLabel", voidHubSystem)
    notif.Size = UDim2.new(0, 320, 0, 50)
    notif.Position = UDim2.new(0.5, -160, 0, 20)
    notif.BackgroundColor3 = Color3.fromRGB(20, 15, 30)
    notif.BackgroundTransparency = 0.1
    notif.TextColor3 = Color3.fromRGB(255, 255, 255)
    notif.Text = "Sua Key: " .. deviceKey .. "\n(Copiada para a área de transferência)"
    notif.Font = Enum.Font.GothamBold
    notif.TextSize = 11
    notif.TextWrapped = true
    notif.ZIndex = 20
    notif.Parent = voidHubSystem
    Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)
    local st = Instance.new("UIStroke", notif)
    st.Color = purpleColor
    st.Thickness = 1.5
    
    task.delay(5, function()
        if notif and notif.Parent then notif:Destroy() end
    end)
end)

local voidHubMain = Instance.new("Frame", voidHubSystem)
voidHubMain.Name = "VoidHubMain"
voidHubMain.Size = UDim2.new(0, 360, 0, 400)
voidHubMain.Position = UDim2.new(0.5, 0, 0.3, 0)
voidHubMain.AnchorPoint = Vector2.new(0.5, 0)
voidHubMain.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
voidHubMain.BackgroundTransparency = 0.6
voidHubMain.ClipsDescendants = true
voidHubMain.Visible = false

Instance.new("UICorner", voidHubMain).CornerRadius = UDim.new(0, 28)
local mainStroke = Instance.new("UIStroke", voidHubMain)
mainStroke.Color = purpleColor
mainStroke.Thickness = 2.5

local mainBg = Instance.new("ImageLabel", voidHubMain)
mainBg.Name = "BackgroundImage"
mainBg.Size = UDim2.new(1, 0, 1, 0)
mainBg.Position = UDim2.new(0, 0, 0, 0)
mainBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainBg.BackgroundTransparency = 1
mainBg.Image = "rbxassetid://112459375607724"
mainBg.ImageTransparency = 0
mainBg.ScaleType = Enum.ScaleType.Crop
mainBg.ZIndex = 0
Instance.new("UICorner", mainBg).CornerRadius = UDim.new(0, 28)

local mainTitle = Instance.new("TextLabel", voidHubMain)
mainTitle.Size = UDim2.new(1, -100, 0, 25)
mainTitle.Position = UDim2.new(0.5, 0, 0, 12)
mainTitle.AnchorPoint = Vector2.new(0.5, 0)
mainTitle.BackgroundTransparency = 1
mainTitle.Text = "Void Hub"
mainTitle.Font = Enum.Font.GothamBold
mainTitle.TextSize = 20
mainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
mainTitle.ZIndex = 3

local subTitle = Instance.new("TextLabel", voidHubMain)
subTitle.Size = UDim2.new(1, 0, 0, 15)
subTitle.Position = UDim2.new(0.5, 0, 0, 38)
subTitle.AnchorPoint = Vector2.new(0.5, 0)
subTitle.BackgroundTransparency = 1
subTitle.Text = "The best script"
subTitle.Font = Enum.Font.GothamBold
subTitle.TextSize = 10
subTitle.TextColor3 = Color3.fromRGB(210, 150, 255)
subTitle.ZIndex = 3

local minimizeBtn = Instance.new("TextButton", voidHubMain)
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(0, 12, 0, 12)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(20, 15, 30)
minimizeBtn.BackgroundTransparency = 0.5
minimizeBtn.Text = "-"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 20
minimizeBtn.TextColor3 = purpleColor
minimizeBtn.ZIndex = 5
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 9)

local lockBtn = Instance.new("TextButton", voidHubMain)
lockBtn.Size = UDim2.new(0, 30, 0, 30)
lockBtn.Position = UDim2.new(1, -42, 0, 12)
lockBtn.BackgroundColor3 = Color3.fromRGB(20, 15, 30)
lockBtn.BackgroundTransparency = 0.5
lockBtn.Text = "🔓"
lockBtn.Font = Enum.Font.Gotham
lockBtn.TextSize = 14
lockBtn.ZIndex = 5
Instance.new("UICorner", lockBtn).CornerRadius = UDim.new(0, 9)

local bodyContainer = Instance.new("Frame", voidHubMain)
bodyContainer.Name = "BodyContainer"
bodyContainer.Size = UDim2.new(1, 0, 1, -55)
bodyContainer.Position = UDim2.new(0, 0, 0, 55)
bodyContainer.BackgroundTransparency = 1
bodyContainer.ClipsDescendants = true
bodyContainer.ZIndex = 3

local statusFrame = Instance.new("Frame", bodyContainer)
statusFrame.Size = UDim2.new(0, 300, 0, 24)
statusFrame.Position = UDim2.new(0.5, -150, 0, 8)
statusFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 25)
statusFrame.BackgroundTransparency = 0.6
statusFrame.ZIndex = 3
Instance.new("UICorner", statusFrame).CornerRadius = UDim.new(0, 7)

local statusLabel = Instance.new("TextLabel", statusFrame)
statusLabel.Size = UDim2.new(1, -10, 1, 0)
statusLabel.Position = UDim2.new(0, 5, 0, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Status: Nada ativo"
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 11
statusLabel.TextColor3 = Color3.fromRGB(190, 170, 220)
statusLabel.ZIndex = 4

local contentArea = Instance.new("ScrollingFrame", bodyContainer)
contentArea.Size = UDim2.new(1, -20, 1, -50)
contentArea.Position = UDim2.new(0, 10, 0, 42)
contentArea.BackgroundTransparency = 1
contentArea.CanvasSize = UDim2.new(0, 0, 0, 500)
contentArea.ScrollBarThickness = 3
contentArea.ZIndex = 4

local extrasArea = Instance.new("ScrollingFrame", bodyContainer)
extrasArea.Size = UDim2.new(1, -20, 1, -50)
extrasArea.Position = UDim2.new(0, 10, 0, 42)
extrasArea.BackgroundTransparency = 1
extrasArea.CanvasSize = UDim2.new(0, 0, 0, 550)
extrasArea.ScrollBarThickness = 3
extrasArea.Visible = false
extrasArea.ZIndex = 4

local scriptsArea = Instance.new("ScrollingFrame", bodyContainer)
scriptsArea.Size = UDim2.new(1, -20, 1, -50)
scriptsArea.Position = UDim2.new(0, 10, 0, 42)
scriptsArea.BackgroundTransparency = 1
scriptsArea.CanvasSize = UDim2.new(0, 0, 0, 400)
scriptsArea.ScrollBarThickness = 3
scriptsArea.Visible = false
scriptsArea.ZIndex = 4

local function createButton(parent, name, label, yPos)
    local btn = Instance.new("TextButton", parent)
    btn.Name = name
    btn.Size = UDim2.new(1, -10, 0, 36)
    btn.Position = UDim2.new(0, 5, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.BackgroundTransparency = 1
    btn.Text = label
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.TextColor3 = Color3.fromRGB(240, 240, 240)
    btn.AutoButtonColor = false
    btn.ZIndex = 5
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    local st = Instance.new("UIStroke", btn)
    st.Color = Color3.fromRGB(160, 110, 210)
    st.Thickness = 1.2
    st.Transparency = 0.25
    return btn, st
end

local activeFunction = nil
local deactivateFuncs = {}
local buttonRefs = {}

local function handleToggle(name, btn, activateFn, deactivateFn)
    if activeFunction == name then
        if deactivateFn then pcall(deactivateFn) end
        btn.BackgroundTransparency = 1
        activeFunction = nil
        statusLabel.Text = "Status: Nada ativo"
    else
        if activeFunction then
            local prevDeactivate = deactivateFuncs[activeFunction]
            if prevDeactivate then pcall(prevDeactivate) end
            local prevBtn = buttonRefs[activeFunction]
            if prevBtn then 
                prevBtn.BackgroundTransparency = 1
            end
        end
        deactivateFuncs[name] = deactivateFn
        buttonRefs[name] = btn
        activateFn()
        btn.BackgroundTransparency = 0.55
        activeFunction = name
        statusLabel.Text = "Status: " .. name .. " ativo"
    end
end

local killAllActive = false
local killAllRemotes = {}
local killAllCacheFeito = false

local function cacheRemotesDeDano()
    if killAllCacheFeito then return end
    killAllCacheFeito = true
    killAllRemotes = {}
    local rs = game:GetService("ReplicatedStorage")
    local palavras = {"damage", "hit", "attack"}
    local contador = 0
    for _, obj in ipairs(rs:GetDescendants()) do
        if contador >= 15 then break end
        if obj:IsA("RemoteEvent") then
            local n = obj.Name:lower()
            for _, p in ipairs(palavras) do
                if n:find(p) then
                    table.insert(killAllRemotes, obj)
                    contador = contador + 1
                    break
                end
            end
        end
    end
end

local function killAllOn()
    killAllActive = true
    task.spawn(function()
        cacheRemotesDeDano()
        while killAllActive do
            pcall(function()
                local myChar = LocalPlayer.Character
                local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
                local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")
                if not myRoot or not myHum or myHum.Health <= 0 then return end

                local tool = myChar:FindFirstChildOfClass("Tool")
                if not tool and LocalPlayer.Backpack then
                    local bt = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                    if bt then
                        bt.Parent = myChar
                        tool = bt
                    end
                end

                for _, player in ipairs(Players:GetPlayers()) do
                    if not killAllActive then break end
                    if player ~= LocalPlayer and player.Character then
                        local tHum = player.Character:FindFirstChildOfClass("Humanoid")
                        local tRoot = player.Character:FindFirstChild("HumanoidRootPart")
                        if tHum and tHum.Health > 0 and tRoot then
                            myRoot.CFrame = tRoot.CFrame * CFrame.new(0, 0, 2)
                            if tool then
                                pcall(function() tool:Activate() end)
                            end
                            for _, remote in ipairs(killAllRemotes) do
                                pcall(function() remote:FireServer(tHum, 99999) end)
                            end
                            task.wait(0.08)
                        end
                    end
                end
            end)
            task.wait(0.4)
        end
    end)
end
local function killAllOff() killAllActive = false end

local flyActive = false
local flyGui = nil
local flyBV = nil
local flyDirection = Vector3.zero
local VELOCIDADE_FLY = 250
local function flyOn()
    flyActive = true
    flyGui = Instance.new("ScreenGui", CoreGui)
    flyGui.Name = "VoidFlyGui"
    flyGui.ResetOnSpawn = false
    local function criarBotaoFly(parent, txt, pos, setDir)
        local b = Instance.new("TextButton", parent)
        b.Size = UDim2.new(0, 45, 0, 45)
        b.Position = pos
        b.BackgroundColor3 = Color3.fromRGB(20, 15, 30)
        b.BackgroundTransparency = 0.4
        b.Text = txt
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.TextSize = 18
        b.Font = Enum.Font.GothamBold
        b.AutoButtonColor = false
        b.ZIndex = 100
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
        local st = Instance.new("UIStroke", b)
        st.Color = purpleColor
        st.Thickness = 1.5
        b.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                flyDirection = setDir
            end
        end)
        b.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                flyDirection = Vector3.zero
            end
        end)
    end
    local leftPanel = Instance.new("Frame", flyGui)
    leftPanel.Size = UDim2.new(0, 150, 0, 150)
    leftPanel.Position = UDim2.new(0, 20, 0.55, 0)
    leftPanel.BackgroundTransparency = 1
    criarBotaoFly(leftPanel, "▲", UDim2.new(0.5, -22, 0, 0), Vector3.new(0, 0, -1))
    criarBotaoFly(leftPanel, "◄", UDim2.new(0, 0, 0.5, -22), Vector3.new(-1, 0, 0))
    criarBotaoFly(leftPanel, "►", UDim2.new(1, -45, 0.5, -22), Vector3.new(1, 0, 0))
    criarBotaoFly(leftPanel, "▼", UDim2.new(0.5, -22, 1, -45), Vector3.new(0, 0, 1))
    local rightPanel = Instance.new("Frame", flyGui)
    rightPanel.Size = UDim2.new(0, 45, 0, 100)
    rightPanel.Position = UDim2.new(1, -65, 0.55, 0)
    rightPanel.BackgroundTransparency = 1
    criarBotaoFly(rightPanel, "⬆", UDim2.new(0, 0, 0, 0), Vector3.new(0, 1, 0))
    criarBotaoFly(rightPanel, "⬇", UDim2.new(0, 0, 1, -45), Vector3.new(0, -1, 0))
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        flyBV = Instance.new("BodyVelocity")
        flyBV.Name = "VoidFlyBV"
        flyBV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        flyBV.Velocity = Vector3.zero
        flyBV.Parent = hrp
    end
    task.spawn(function()
        while flyActive do
            pcall(function()
                local c = LocalPlayer.Character
                local r = c and c:FindFirstChild("HumanoidRootPart")
                local cam = workspace.CurrentCamera
                if r and flyBV and flyBV.Parent then
                    local vel = Vector3.zero
                    if flyDirection.Magnitude > 0 then
                        if flyDirection.Y ~= 0 then
                            vel = flyDirection * VELOCIDADE_FLY
                        else
                            vel = (cam.CFrame.LookVector * -flyDirection.Z + cam.CFrame.RightVector * flyDirection.X) * VELOCIDADE_FLY
                        end
                    end
                    flyBV.Velocity = vel
                end
            end)
            task.wait()
        end
    end)
end
local function flyOff()
    flyActive = false
    if flyGui then flyGui:Destroy() flyGui = nil end
    if flyBV then flyBV:Destroy() flyBV = nil end
    flyDirection = Vector3.zero
end

local bypassActive = false

local function escolherAlvoBypass()
    local alvos = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hrp and hum and hum.Health > 0 then
                table.insert(alvos, hrp)
            end
        end
    end
    if #alvos == 0 then return nil end
    return alvos[math.random(1, #alvos)]
end

local function runBypassLogic()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp then return end

    local colisoes = {}
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            colisoes[part] = part.CanCollide
            part.CanCollide = false
        end
    end

    hum.PlatformStand = true

    local bv = Instance.new("BodyVelocity")
    bv.Name = "VoidBypassBV"
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bv.Velocity = Vector3.zero
    bv.Parent = hrp

    local bg = Instance.new("BodyGyro")
    bg.Name = "VoidBypassBG"
    bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bg.CFrame = hrp.CFrame
    bg.Parent = hrp

    local posInicial = hrp.Position

    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {char}
    params.FilterType = Enum.RaycastFilterType.Exclude

    local dirs = {
        Vector3.new(1, 0, 0),
        Vector3.new(-1, 0, 0),
        Vector3.new(0, 0, 1),
        Vector3.new(0, 0, -1)
    }
    local menores = {}
    for _, dir in ipairs(dirs) do
        local result = workspace:Raycast(posInicial, dir * 5000, params)
        local dist = result and result.Distance or 5000
        table.insert(menores, { dist = dist, dir = dir })
    end
    table.sort(menores, function(a, b) return a.dist < b.dist end)
    local melhorDir = menores[1].dir

    local startTime = tick()
    while hrp.Position.Y < 800 and tick() - startTime < 6 and bypassActive do
        bv.Velocity = Vector3.new(0, 300, 0)
        RunService.RenderStepped:Wait()
    end

    local targetForward = posInicial + (melhorDir * 1000)
    local t2 = tick()
    while tick() - t2 < 3 and bypassActive do
        local diff = targetForward - hrp.Position
        local diffH = Vector3.new(diff.X, 0, diff.Z)
        if diffH.Magnitude < 20 then break end
        bv.Velocity = diffH.Unit * 400
        RunService.RenderStepped:Wait()
    end

    if bv then bv:Destroy() end
    if bg then bg:Destroy() end

    hum.PlatformStand = false
    hrp.AssemblyLinearVelocity = Vector3.new(0, -100, 0)

    task.delay(4, function()
        if char and char.Parent then
            for part, col in pairs(colisoes) do
                if part.Parent then part.CanCollide = col end
            end
        end
    end)
end

local function bypassOn()
    bypassActive = true
    task.spawn(function()
        statusLabel.Text = "Status: Bypass Void..."

        runBypassLogic()

        local timeoutMorrer = tick() + 15
        while bypassActive and tick() < timeoutMorrer do
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health <= 0 then break end
            task.wait(0.2)
        end

        bypassActive = false

        if buttonRefs["Bypass"] then
            buttonRefs["Bypass"].BackgroundTransparency = 1
        end
        if activeFunction == "Bypass" then
            activeFunction = nil
        end
        statusLabel.Text = "Status: Nada ativo"
    end)
end

local function bypassOff()
    bypassActive = false
end

local function testarBypass()
    statusLabel.Text = "status: testando..."

    local alvo = escolherAlvoBypass()
    if not alvo then
        statusLabel.Text = "status: falhou❌"
        task.wait(2)
        statusLabel.Text = "Status: Nada ativo"
        return
    end

    local myHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myHrp then
        statusLabel.Text = "status: falhou❌"
        task.wait(2)
        statusLabel.Text = "Status: Nada ativo"
        return
    end

    local destino = alvo.CFrame * CFrame.new(0, 0, 3)
    myHrp.CFrame = destino
    local posTeleporte = destino.Position

    task.wait(2)

    local currentHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if currentHrp then
        local dist = (currentHrp.Position - posTeleporte).Magnitude
        if dist < 30 then
            statusLabel.Text = "status: sucesso✅"
        else
            statusLabel.Text = "status: falhou❌"
        end
    else
        statusLabel.Text = "status: falhou❌"
    end

    task.wait(2.5)
    statusLabel.Text = "Status: Nada ativo"
end

local function serverHop()
    statusLabel.Text = "Status: Procurando servidor..."
    task.spawn(function()
        local success, result = pcall(function()
            local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"
            local response = HttpService:JSONDecode(game:HttpGet(url))
            return response
        end)
        
        if success and result and result.data then
            local candidatos = {}
            for _, server in ipairs(result.data) do
                if server.id ~= game.JobId and server.playing < server.maxPlayers and server.playing >= 3 then
                    local razao = server.playing / server.maxPlayers
                    if razao >= 0.25 and razao <= 0.75 then
                        table.insert(candidatos, server)
                    end
                end
            end

            table.sort(candidatos, function(a, b)
                local razaoA = a.playing / a.maxPlayers
                local razaoB = b.playing / b.maxPlayers
                return math.abs(razaoA - 0.5) < math.abs(razaoB - 0.5)
            end)

            for _, server in ipairs(candidatos) do
                pcall(function()
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                end)
                return
            end
        end
        
        pcall(function()
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end)
    end)
end

local espDummyActive = false
local function espDummyOn()
    espDummyActive = true
    task.spawn(function()
        while espDummyActive do
            pcall(function()
                for _, obj in ipairs(workspace:GetChildren()) do
                    if obj.Name == "Dummy" and obj:FindFirstChild("HumanoidRootPart") and not obj:FindFirstChild("RGBHighlight") then
                        local hl = Instance.new("Highlight", obj)
                        hl.Name = "RGBHighlight"
                        task.spawn(function()
                            while hl and hl.Parent do
                                hl.FillColor = Color3.fromHSV((tick() * 0.5) % 1, 1, 1)
                                task.wait(0.1)
                            end
                        end)
                    end
                    for _, sub in ipairs(obj:GetChildren()) do
                        if sub.Name == "Dummy" and sub:FindFirstChild("HumanoidRootPart") and not sub:FindFirstChild("RGBHighlight") then
                            local hl = Instance.new("Highlight", sub)
                            hl.Name = "RGBHighlight"
                            task.spawn(function()
                                while hl and hl.Parent do
                                    hl.FillColor = Color3.fromHSV((tick() * 0.5) % 1, 1, 1)
                                    task.wait(0.1)
                                end
                            end)
                        end
                    end
                end
            end)
            task.wait(3)
        end
    end)
end
local function espDummyOff()
    espDummyActive = false
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name == "Dummy" then
            local hl = obj:FindFirstChild("RGBHighlight")
            if hl then hl:Destroy() end
        end
    end
end

local espJogadoresActive = false
local function espJogadoresOn()
    espJogadoresActive = true
    task.spawn(function()
        while espJogadoresActive do
            pcall(function()
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and not player.Character:FindFirstChild("PurpleHighlight") then
                        local hl = Instance.new("Highlight", player.Character)
                        hl.Name = "PurpleHighlight"
                        hl.FillColor = Color3.fromRGB(140, 40, 220)
                        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    end
                end
            end)
            task.wait(1)
        end
    end)
end
local function espJogadoresOff()
    espJogadoresActive = false
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            local hl = player.Character:FindFirstChild("PurpleHighlight")
            if hl then hl:Destroy() end
        end
    end
end

local espDomainActive = false
local espDomainGui = nil
local espDomainTxt = nil

local function temDominioNoMapa()
    local padroes = {"domain", "dominio", "domínio", "shrine", "expansion", "infinite void", "malevolent", "unlimited", "coffin", "chimera", "idle death", "horizon", "authentic", "mutual", "love"}
    for _, obj in ipairs(workspace:GetChildren()) do
        local nome = obj.Name:lower()
        for _, p in ipairs(padroes) do
            if nome:find(p) then
                if (obj:IsA("BasePart") and obj.Size.Magnitude > 20) or obj:IsA("Model") then
                    return true
                end
            end
        end
        for _, sub in ipairs(obj:GetChildren()) do
            local snome = sub.Name:lower()
            for _, p in ipairs(padroes) do
                if snome:find(p) then
                    if (sub:IsA("BasePart") and sub.Size.Magnitude > 20) or sub:IsA("Model") then
                        return true
                    end
                end
            end
        end
    end
    return false
end

local function espDomainOn()
    espDomainActive = true
    espDomainGui = Instance.new("ScreenGui", CoreGui)
    espDomainGui.Name = "VoidEspDomain"
    espDomainGui.ResetOnSpawn = false

    local f = Instance.new("Frame", espDomainGui)
    f.Size = UDim2.new(0, 200, 0, 34)
    f.Position = UDim2.new(0.02, 0, 0.15, 0)
    f.BackgroundColor3 = Color3.fromRGB(15, 10, 25)
    f.BackgroundTransparency = 0.3
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 10)
    local fs = Instance.new("UIStroke", f)
    fs.Color = purpleColor
    fs.Thickness = 2

    espDomainTxt = Instance.new("TextLabel", f)
    espDomainTxt.Size = UDim2.new(1, -10, 1, 0)
    espDomainTxt.Position = UDim2.new(0, 5, 0, 0)
    espDomainTxt.BackgroundTransparency = 1
    espDomainTxt.Text = "ESP Domain: OFF"
    espDomainTxt.TextColor3 = Color3.fromRGB(255, 80, 80)
    espDomainTxt.Font = Enum.Font.GothamBold
    espDomainTxt.TextSize = 13

    task.spawn(function()
        while espDomainActive and espDomainGui and espDomainGui.Parent do
            pcall(function()
                if temDominioNoMapa() then
                    espDomainTxt.Text = "ESP Domain: ON"
                    espDomainTxt.TextColor3 = Color3.fromRGB(80, 255, 120)
                else
                    espDomainTxt.Text = "ESP Domain: OFF"
                    espDomainTxt.TextColor3 = Color3.fromRGB(255, 80, 80)
                end
            end)
            task.wait(3)
        end
    end)
end

local function espDomainOff()
    espDomainActive = false
    if espDomainGui then espDomainGui:Destroy() espDomainGui = nil end
    espDomainTxt = nil
end

local fpsActive = false
local function fpsOn()
    fpsActive = true
    task.spawn(function()
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level05
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 999999
            Lighting.Brightness = 2
            for _, v in ipairs(Lighting:GetChildren()) do
                if v:IsA("PostEffect") or v:IsA("Atmosphere") or v:IsA("Sky") or v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("SunRaysEffect") then
                    v.Enabled = false
                end
            end
        end)
    end)
end
local function fpsOff() fpsActive = false end

local panelGui = nil
local function panelOn()
    panelGui = Instance.new("ScreenGui", CoreGui)
    panelGui.Name = "VoidFpsPingPanel"
    panelGui.ResetOnSpawn = false
    local f = Instance.new("Frame", panelGui)
    f.Size = UDim2.new(0, 180, 0, 75)
    f.Position = UDim2.new(0.78, 0, 0.1, 0)
    f.BackgroundColor3 = Color3.fromRGB(15, 10, 25)
    f.BackgroundTransparency = 0.3
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 14)
    local fs = Instance.new("UIStroke", f)
    fs.Color = purpleColor
    fs.Thickness = 2
    local txt = Instance.new("TextLabel", f)
    txt.Size = UDim2.new(1, 0, 1, 0)
    txt.BackgroundTransparency = 1
    txt.TextColor3 = Color3.fromRGB(255, 255, 255)
    txt.Font = Enum.Font.GothamBold
    txt.TextSize = 13
    task.spawn(function()
        while panelGui and f.Parent do
            local fps = math.floor(1 / RunService.RenderStepped:Wait())
            local ping = 0
            pcall(function()
                ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
            end)
            txt.Text = string.format(" FPS: %d\n Ping: %d ms\n Players: %d", fps, ping, #Players:GetPlayers())
            task.wait(1)
        end
    end)
end
local function panelOff()
    if panelGui then panelGui:Destroy() panelGui = nil end
end

local btnKillAll = createButton(contentArea, "KillAll", "☠  Kill All (Mata todos)", 5)
btnKillAll.MouseButton1Click:Connect(function()
    handleToggle("KillAll", btnKillAll, killAllOn, killAllOff)
end)

local btnFly = createButton(contentArea, "Fly", "🛫  Fly com Botões", 48)
btnFly.MouseButton1Click:Connect(function()
    handleToggle("Fly", btnFly, flyOn, flyOff)
end)

local btnBypass = createButton(contentArea, "Bypass", "🛡  Bypass Void (Persistente)", 91)
btnBypass.MouseButton1Click:Connect(function()
    handleToggle("Bypass", btnBypass, bypassOn, bypassOff)
end)

local btnTestBypass = createButton(contentArea, "TesteBypass", "🔄  Testar Bypass (TP Player)", 134)
btnTestBypass.MouseButton1Click:Connect(function()
    btnTestBypass.BackgroundTransparency = 0.55
    testarBypass()
    btnTestBypass.BackgroundTransparency = 1
end)

local btnServerHop = createButton(contentArea, "ServerHop", "🌐  Server Hop (Trocar Servidor)", 177)
btnServerHop.MouseButton1Click:Connect(function()
    btnServerHop.BackgroundTransparency = 0.55
    serverHop()
    task.wait(2)
    btnServerHop.BackgroundTransparency = 1
end)

local btnAbrirExtras = createButton(contentArea, "AbrirExtras", "⚡  Extras & Visuals", 220)
btnAbrirExtras.MouseButton1Click:Connect(function()
    contentArea.Visible = false
    extrasArea.Visible = true
end)

local btnEspJogadores = createButton(extrasArea, "EspJogadores", "👁  ESP Jogadores", 5)
btnEspJogadores.MouseButton1Click:Connect(function()
    if not espJogadoresActive then
        espJogadoresOn()
        btnEspJogadores.BackgroundTransparency = 0.55
    else
        espJogadoresOff()
        btnEspJogadores.BackgroundTransparency = 1
    end
end)

local btnEspDummy = createButton(extrasArea, "EspDummy", "🎯  ESP Dummy", 48)
btnEspDummy.MouseButton1Click:Connect(function()
    if not espDummyActive then
        espDummyOn()
        btnEspDummy.BackgroundTransparency = 0.55
    else
        espDummyOff()
        btnEspDummy.BackgroundTransparency = 1
    end
end)

local btnEspDomain = createButton(extrasArea, "EspDomain", "👁  ESP Domain", 91)
btnEspDomain.MouseButton1Click:Connect(function()
    if not espDomainActive then
        espDomainOn()
        btnEspDomain.BackgroundTransparency = 0.55
    else
        espDomainOff()
        btnEspDomain.BackgroundTransparency = 1
    end
end)

local btnFPS = createButton(extrasArea, "FPS", "🚀  FPS Booster", 134)
btnFPS.MouseButton1Click:Connect(function()
    if not fpsActive then
        fpsOn()
        btnFPS.BackgroundTransparency = 0.55
    else
        fpsOff()
        btnFPS.BackgroundTransparency = 1
    end
end)

local btnPainel = createButton(extrasArea, "Painel", "📊  Painel FPS/Ping", 177)
btnPainel.MouseButton1Click:Connect(function()
    if not panelGui then
        panelOn()
        btnPainel.BackgroundTransparency = 0.55
    else
        panelOff()
        btnPainel.BackgroundTransparency = 1
    end
end)

local btnCoresHub = createButton(extrasArea, "CoresHub", "🎨  Cores do Hub", 220)
btnCoresHub.MouseButton1Click:Connect(function()
    local picker = Instance.new("ScreenGui", CoreGui)
    picker.Name = "VoidColorPicker"
    picker.ResetOnSpawn = false
    local f = Instance.new("Frame", picker)
    f.Size = UDim2.new(0, 220, 0, 150)
    f.Position = UDim2.new(0.5, -110, 0.5, -75)
    f.BackgroundColor3 = Color3.fromRGB(15, 10, 25)
    f.BackgroundTransparency = 0.1
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 16)
    local fs = Instance.new("UIStroke", f)
    fs.Color = purpleColor
    fs.Thickness = 2

    local title = Instance.new("TextLabel", f)
    title.Size = UDim2.new(1, 0, 0, 25)
    title.Position = UDim2.new(0, 0, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "Cor do Hub"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 13
    title.TextColor3 = Color3.fromRGB(255, 255, 255)

    local opcoesCores = {
        { cor = Color3.fromRGB(140, 40, 220), img = "rbxassetid://112459375607724" },
        { cor = Color3.fromRGB(40, 100, 240), img = "rbxassetid://102472450810637" },
        { cor = Color3.fromRGB(40, 220, 100), img = "rbxassetid://75159994736056"  },
        { cor = Color3.fromRGB(220, 40, 40),  img = "rbxassetid://136888893575149" },
        { cor = Color3.fromRGB(240, 220, 40), img = "rbxassetid://71099604853241"  },
        { cor = Color3.fromRGB(240, 240, 240),img = "rbxassetid://123694908192472" },
    }

    for i, opcao in ipairs(opcoesCores) do
        local row = math.floor((i-1) / 3)
        local col = (i-1) % 3
        local b = Instance.new("TextButton", f)
        b.Size = UDim2.new(0, 55, 0, 38)
        b.Position = UDim2.new(0, 20 + col * 62, 0, 45 + row * 45)
        b.BackgroundColor3 = opcao.cor
        b.Text = ""
        b.AutoButtonColor = false
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
        local bs = Instance.new("UIStroke", b)
        bs.Color = Color3.fromRGB(255, 255, 255)
        bs.Thickness = 1
        bs.Transparency = 0.6

        b.MouseButton1Click:Connect(function()
            mainStroke.Color = opcao.cor
            keyStroke.Color = opcao.cor
            mainBg.Image = opcao.img
            keyBg.Image = opcao.img
            picker:Destroy()
        end)
    end

    local close = Instance.new("TextButton", f)
    close.Size = UDim2.new(0, 80, 0, 24)
    close.Position = UDim2.new(1, -90, 1, -30)
    close.BackgroundColor3 = Color3.fromRGB(60, 30, 30)
    close.Text = "Fechar"
    close.Font = Enum.Font.GothamBold
    close.TextSize = 11
    close.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", close).CornerRadius = UDim.new(0, 7)
    close.MouseButton1Click:Connect(function() picker:Destroy() end)
end)

local btnAbrirScripts = createButton(extrasArea, "AbrirScripts", "📜  Scripts Especiais", 263)
btnAbrirScripts.MouseButton1Click:Connect(function()
    extrasArea.Visible = false
    scriptsArea.Visible = true
end)

local btnVoltar = createButton(extrasArea, "Voltar", "⬅️  Voltar", 306)
btnVoltar.MouseButton1Click:Connect(function()
    extrasArea.Visible = false
    contentArea.Visible = true
end)

local scriptsList = {
    { "TBO", "🔥  TBO Script", "https://raw.githubusercontent.com/cool5013/TBO/main/TBOscript" },
    { "Kokusen", "⚡  Kokusen Chain", "https://raw.githubusercontent.com/ggab2351-stack/Jjs/refs/heads/main/obfuscated_script-1770002780541.lua.txt" },
    { "Kokusen2", "⚡  Kokusen 2", "https://raw.githubusercontent.com/dream77239/sss/refs/heads/main/yuji" },
    { "LockOn", "🎯  Lock On", "https://raw.githubusercontent.com/b17111326-hue/Lock-On/refs/heads/main/obfuscated_script-1786226030102.lua.txt" },
    { "Jujutsuer", "🔮  Jujutsuer V2", "https://raw.githubusercontent.com/solarastuff/tze/refs/heads/main/JujutsuerV2.lua" },
    { "Yuki", "🌀  Black Hole Yuki", "https://raw.githubusercontent.com/Dragonfly5101/Minosr/refs/heads/main/InstantBlackHole.JJS" },
}
for i, data in ipairs(scriptsList) do
    local btn = createButton(scriptsArea, data[1], data[2], 5 + (i-1) * 42)
    btn.MouseButton1Click:Connect(function()
        btn.BackgroundTransparency = 0.55
        statusLabel.Text = "Status: Executando " .. data[1] .. "..."
        pcall(function()
            loadstring(game:HttpGet(data[3]))()
        end)
        task.wait(0.5)
        btn.BackgroundTransparency = 1
    end)
end

local btnVoltar2 = createButton(scriptsArea, "Voltar2", "⬅️  Voltar", 5 + #scriptsList * 42)
btnVoltar2.MouseButton1Click:Connect(function()
    scriptsArea.Visible = false
    contentArea.Visible = true
end)

local isLocked = false
local dragging = false
local dragStart, startPos

voidHubMain.InputBegan:Connect(function(input)
    if isLocked then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        local my = input.Position.Y
        local abs = voidHubMain.AbsolutePosition
        if my - abs.Y < 55 then
            dragging = true
            dragStart = input.Position
            startPos = voidHubMain.Position
        end
    end
end)
voidHubMain.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and not isLocked then
        local delta = input.Position - dragStart
        voidHubMain.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

lockBtn.MouseButton1Click:Connect(function()
    isLocked = not isLocked
    lockBtn.Text = isLocked and "🔒" or "🔓"
    lockBtn.BackgroundColor3 = isLocked and Color3.fromRGB(120, 40, 40) or Color3.fromRGB(20, 15, 30)
end)

local isMinimized = false
local fullHeight = 400
local minHeight = 55

minimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        bodyContainer.Visible = false
        TweenService:Create(voidHubMain, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 360, 0, minHeight)
        }):Play()
        minimizeBtn.Text = "+"
    else
        TweenService:Create(voidHubMain, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 360, 0, fullHeight)
        }):Play()
        task.wait(0.3)
        bodyContainer.Visible = true
        minimizeBtn.Text = "-"
    end
end)

local function abrirHub()
    TweenService:Create(keyContainer, TweenInfo.new(0.4), {Size = UDim2.new(0,0,0,0)}):Play()
    task.wait(0.4)
    keyContainer:Destroy()
    voidHubMain.Visible = true
end

validateBtn.MouseButton1Click:Connect(function()
    if textBox.Text == deviceKey then
        abrirHub()
    else
        validateBtn.Text = "Incorreta!"
        task.wait(1.5)
        validateBtn.Text = "Verificar"
    end
end)

print("✅ Void Hub carregado com sucesso!")
