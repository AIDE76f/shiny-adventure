
local RunService = game:GetService("RunService")

if not RunService:IsStudio() then
    return
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local existing = playerGui:FindFirstChild("HassanHubTest")
if existing then
    existing:Destroy()
end

local COLORS = {
    Background = Color3.fromRGB(15, 17, 24),
    Panel = Color3.fromRGB(24, 27, 37),
    Card = Color3.fromRGB(33, 37, 49),
    Accent = Color3.fromRGB(255, 48, 65),
    AccentDark = Color3.fromRGB(170, 35, 49),
    Text = Color3.fromRGB(244, 246, 250),
    Muted = Color3.fromRGB(151, 158, 174),
    Green = Color3.fromRGB(45, 180, 115),
    Gray = Color3.fromRGB(73, 79, 95),
    Border = Color3.fromRGB(54, 60, 76)
}

local function create(className, properties, parent)
    local object = Instance.new(className)

    for property, value in pairs(properties or {}) do
        object[property] = value
    end

    object.Parent = parent
    return object
end

local function round(object, radius)
    create("UICorner", {
        CornerRadius = UDim.new(0, radius)
    }, object)
end

local function outline(object, color, transparency)
    create("UIStroke", {
        Color = color or COLORS.Border,
        Transparency = transparency or 0,
        Thickness = 1
    }, object)
end

local function label(parent, text, position, size, textSize, color, font)
    return create("TextLabel", {
        BackgroundTransparency = 1,
        Position = position,
        Size = size,
        Text = text,
        TextColor3 = color or COLORS.Text,
        TextSize = textSize or 14,
        Font = font or Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center
    }, parent)
end

local function button(parent, text, position, size, color)
    local object = create("TextButton", {
        Position = position,
        Size = size,
        BackgroundColor3 = color,
        BorderSizePixel = 0,
        Text = text,
        TextColor3 = COLORS.Text,
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false
    }, parent)

    round(object, 9)

    object.MouseEnter:Connect(function()
        TweenService:Create(object, TweenInfo.new(0.12), {
            BackgroundColor3 = color:Lerp(Color3.new(1, 1, 1), 0.08)
        }):Play()
    end)

    object.MouseLeave:Connect(function()
        TweenService:Create(object, TweenInfo.new(0.12), {
            BackgroundColor3 = color
        }):Play()
    end)

    return object
end

local gui = create("ScreenGui", {
    Name = "HassanHubTest",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 100,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, playerGui)

local panel = create("Frame", {
    Name = "MainPanel",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.fromOffset(390, 360),
    BackgroundColor3 = COLORS.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true
}, gui)

round(panel, 16)
outline(panel, COLORS.Border, 0)

create("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, COLORS.Panel),
        ColorSequenceKeypoint.new(1, COLORS.Background)
    }),
    Rotation = 90
}, panel)

local topbar = create("Frame", {
    Name = "Topbar",
    Position = UDim2.fromOffset(0, 0),
    Size = UDim2.new(1, 0, 0, 58),
    BackgroundColor3 = COLORS.Panel,
    BorderSizePixel = 0
}, panel)

local accentLine = create("Frame", {
    Position = UDim2.new(0, 0, 1, -2),
    Size = UDim2.new(1, 0, 0, 2),
    BackgroundColor3 = COLORS.Accent,
    BorderSizePixel = 0
}, topbar)

label(
    topbar,
    "HASSAN HUB",
    UDim2.fromOffset(18, 8),
    UDim2.new(1, -85, 0, 24),
    19,
    COLORS.Text,
    Enum.Font.GothamBold
)

label(
    topbar,
    "BLOX FRUITS  /  STUDIO TEST",
    UDim2.fromOffset(19, 31),
    UDim2.new(1, -90, 0, 16),
    10,
    COLORS.Muted,
    Enum.Font.GothamMedium
)

local closeButton = button(
    topbar,
    "×",
    UDim2.new(1, -44, 0, 12),
    UDim2.fromOffset(32, 32),
    COLORS.AccentDark
)
closeButton.TextSize = 23

local statusCard = create("Frame", {
    Position = UDim2.fromOffset(18, 68),
    Size = UDim2.new(1, -36, 0, 28),
    BackgroundColor3 = COLORS.Card,
    BorderSizePixel = 0
}, panel)

round(statusCard, 8)

local statusLabel = label(
    statusCard,
    "●  SYSTEM READY",
    UDim2.fromOffset(10, 0),
    UDim2.new(1, -20, 1, 0),
    11,
    COLORS.Green,
    Enum.Font.GothamBold
)

local function setStatus(text, color)
    statusLabel.Text = "●  " .. text
    statusLabel.TextColor3 = color or COLORS.Green
end

label(
    panel,
    "VISUALS",
    UDim2.fromOffset(19, 103),
    UDim2.new(1, -38, 0, 18),
    11,
    COLORS.Muted,
    Enum.Font.GothamBold
)

local espCard = create("Frame", {
    Position = UDim2.fromOffset(18, 125),
    Size = UDim2.new(1, -36, 0, 48),
    BackgroundColor3 = COLORS.Card,
    BorderSizePixel = 0
}, panel)

round(espCard, 10)

local espColor = create("Frame", {
    Position = UDim2.fromOffset(10, 12),
    Size = UDim2.fromOffset(24, 24),
    BackgroundColor3 = COLORS.Accent,
    BorderSizePixel = 0
}, espCard)

round(espColor, 7)

label(
    espCard,
    "PLAYER ESP",
    UDim2.fromOffset(44, 5),
    UDim2.new(1, -125, 0, 20),
    13,
    COLORS.Text,
    Enum.Font.GothamBold
)

label(
    espCard,
    "Red player highlight",
    UDim2.fromOffset(44, 24),
    UDim2.new(1, -125, 0, 16),
    10,
    COLORS.Muted
)

local espToggle = button(
    espCard,
    "OFF",
    UDim2.new(1, -67, 0.5, -14),
    UDim2.fromOffset(55, 28),
    COLORS.Gray
)

label(
    panel,
    "MOVEMENT",
    UDim2.fromOffset(19, 184),
    UDim2.new(1, -38, 0, 18),
    11,
    COLORS.Muted,
    Enum.Font.GothamBold
)

local speedBox = create("TextBox", {
    Position = UDim2.fromOffset(18, 207),
    Size = UDim2.new(1, -36, 0, 42),
    BackgroundColor3 = COLORS.Card,
    BorderSizePixel = 0,
    Text = "10x",
    PlaceholderText = "Enter multiplier, e.g. 10x",
    PlaceholderColor3 = COLORS.Muted,
    TextColor3 = COLORS.Text,
    TextSize = 14,
    Font = Enum.Font.GothamBold,
    ClearTextOnFocus = false
}, panel)

round(speedBox, 9)
outline(speedBox, COLORS.Border, 0.2)

local applyButton = button(
    panel,
    "APPLY SPEED",
    UDim2.fromOffset(18, 260),
    UDim2.new(0.5, -23, 0, 38),
    COLORS.AccentDark
)

local resetButton = button(
    panel,
    "RESET SPEED",
    UDim2.new(0.5, 5, 0, 260),
    UDim2.new(0.5, -23, 0, 38),
    COLORS.Gray
)

label(
    panel,
    "Right Shift: Toggle interface",
    UDim2.fromOffset(19, 311),
    UDim2.new(1, -38, 0, 20),
    10,
    COLORS.Muted
)

label(
    panel,
    "LOCAL TEST BUILD",
    UDim2.new(0, 0, 1, -24),
    UDim2.new(1, -14, 0, 16),
    9,
    COLORS.Muted,
    Enum.Font.GothamBold
).TextXAlignment = Enum.TextXAlignment.Right

local launcher = button(
    gui,
    "H",
    UDim2.new(0, 20, 0.5, -24),
    UDim2.fromOffset(48, 48),
    COLORS.AccentDark
)

launcher.Visible = false
launcher.TextSize = 19
round(launcher, 24)
outline(launcher, COLORS.Accent, 0)

local function showPanel()
    panel.Visible = true
    launcher.Visible = false
    panel.Size = UDim2.fromOffset(370, 340)

    TweenService:Create(panel, TweenInfo.new(
        0.18,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    ), {
        Size = UDim2.fromOffset(390, 360)
    }):Play()
end

local function hidePanel()
    panel.Visible = false
    launcher.Visible = true
end

closeButton.Activated:Connect(hidePanel)
launcher.Activated:Connect(showPanel)

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then
        return
    end

    if input.KeyCode == Enum.KeyCode.RightShift then
        if panel.Visible then
            hidePanel()
        else
            showPanel()
        end
    end
end)

local dragging = false
local dragStart
local startPosition
local dragInput

topbar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPosition = panel.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

topbar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput and dragStart and startPosition then
        local delta = input.Position - dragStart

        panel.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

local espEnabled = false
local highlights = {}
local playerConnections = {}

local function clearHighlight(target)
    local highlight = highlights[target]

    if highlight then
        highlight:Destroy()
        highlights[target] = nil
    end
end

local function addHighlight(target)
    if not espEnabled or target == player then
        return
    end

    local character = target.Character
    if not character then
        return
    end

    local old = highlights[target]

    if old and old.Parent and old.Adornee == character then
        return
    end

    clearHighlight(target)

    local highlight = Instance.new("Highlight")
    highlight.Name = "HassanHub_PlayerESP"
    highlight.Adornee = character
    highlight.FillColor = Color3.fromRGB(255, 35, 50)
    highlight.FillTransparency = 0.48
    highlight.OutlineColor = Color3.fromRGB(255, 65, 75)
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = workspace

    highlights[target] = highlight
end

local function hookPlayer(target)
    if target == player or playerConnections[target] then
        return
    end

    local addedConnection = target.CharacterAdded:Connect(function(character)
        task.delay(0.25, function()
            if espEnabled and target.Parent and target.Character == character then
                addHighlight(target)
            end
        end)
    end)

    local removingConnection = target.CharacterRemoving:Connect(function()
        clearHighlight(target)
    end)

    playerConnections[target] = {
        addedConnection,
        removingConnection
    }

    if espEnabled then
        addHighlight(target)
    end
end

local function setESP(enabled)
    espEnabled = enabled

    if enabled then
        espToggle.Text = "ON"
        espToggle.BackgroundColor3 = COLORS.Accent

        for _, target in ipairs(Players:GetPlayers()) do
            if target ~= player then
                addHighlight(target)
            end
        end

        setStatus("PLAYER ESP ENABLED", COLORS.Accent)
    else
        espToggle.Text = "OFF"
        espToggle.BackgroundColor3 = COLORS.Gray

        for target in pairs(highlights) do
            clearHighlight(target)
        end

        setStatus("PLAYER ESP DISABLED", COLORS.Muted)
    end
end

espToggle.Activated:Connect(function()
    setESP(not espEnabled)
end)

for _, target in ipairs(Players:GetPlayers()) do
    hookPlayer(target)
end

Players.PlayerAdded:Connect(hookPlayer)

Players.PlayerRemoving:Connect(function(target)
    clearHighlight(target)

    local connections = playerConnections[target]
    if connections then
        for _, connection in ipairs(connections) do
            connection:Disconnect()
        end

        playerConnections[target] = nil
    end
end)

local baseWalkSpeed = 16
local speedEnabled = false
local speedMultiplier = 1

local function setupCharacter(character)
    local humanoid = character:WaitForChild("Humanoid", 10)

    if not humanoid then
        return
    end

    baseWalkSpeed = humanoid.WalkSpeed

    if speedEnabled then
        humanoid.WalkSpeed = baseWalkSpeed * speedMultiplier
    end
end

if player.Character then
    task.spawn(setupCharacter, player.Character)
end

player.CharacterAdded:Connect(setupCharacter)

local function getHumanoid()
    local character = player.Character

    if not character then
        return nil
    end

    return character:FindFirstChildOfClass("Humanoid")
end

local function applySpeed()
    local humanoid = getHumanoid()

    if not humanoid then
        setStatus("CHARACTER NOT READY", COLORS.Accent)
        return
    end

    humanoid.WalkSpeed = baseWalkSpeed * speedMultiplier
    speedEnabled = true

    setStatus(
        "SPEED ACTIVE: " .. tostring(speedMultiplier) .. "x",
        COLORS.Green
    )
end

applyButton.Activated:Connect(function()
    local raw = speedBox.Text:lower()
    raw = raw:gsub("x", "")
    raw = raw:gsub("×", "")
    raw = raw:gsub("%s+", "")

    local multiplier = tonumber(raw)

    if not multiplier or multiplier <= 0 then
        setStatus("ENTER A VALID SPEED", COLORS.Accent)
        return
    end

    multiplier = math.clamp(multiplier, 0.1, 100)
    speedMultiplier = multiplier

    speedBox.Text = tostring(multiplier) .. "x"
    applySpeed()
end)

resetButton.Activated:Connect(function()
    speedEnabled = false
    speedMultiplier = 1

    local humanoid = getHumanoid()

    if humanoid then
        humanoid.WalkSpeed = baseWalkSpeed
    end

    speedBox.Text = "1x"
    setStatus("DEFAULT SPEED RESTORED", COLORS.Green)
end)

setStatus("SYSTEM READY", COLORS.Green)
