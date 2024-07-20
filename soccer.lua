--Made by MoRnD












local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ekran"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Name = "ekranframe"
frame.Position = UDim2.new(0.021, 0, 0.163, 0)
frame.Size = UDim2.new(0, 57, 0, 54)
frame.Parent = screenGui

local textButton = Instance.new("TextButton")
textButton.Name = "TextButton"
textButton.Size = UDim2.new(1, 0, 1, 0)
textButton.Text = "Teleport Ball"
textButton.Parent = frame

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local workspace = game:GetService("Workspace")

local isTeleporting = false

local function getCharacter()
    if player.Character then
        return player.Character
    else
        player.CharacterAdded:Wait()
        return player.Character
    end
end

local function getBall()
    local footballField = workspace:FindFirstChild("FootballField")
    if footballField then
        return footballField:FindFirstChild("SoccerBall")
    else
        warn("FootballField bulunamadı.")
        return nil
    end
end

local function teleportBall()
    local character = getCharacter()
    local ball = getBall()

    if character and ball then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            while isTeleporting do
                local targetPosition = humanoidRootPart.CFrame * CFrame.new(0, 0, -5)
                ball.CFrame = targetPosition
                wait(0.1)
            end
        else
            warn("HumanoidRootPart not found.")
        end
    else
        if not ball then
            warn("ball not found.")
        end
        if not character then
            warn("character not found.")
        end
    end
end

textButton.MouseButton1Click:Connect(function()
    if not isTeleporting then
        isTeleporting = true
        teleportBall()
    else
        isTeleporting = false
    end
end)
