--Made by MoRnD












local player = game.Players.LocalPlayer
local rs = game:GetService("RunService")
local uis = game:GetService("UserInputService")

player.CharacterAdded:Connect(function()
	local old = player:WaitForChild("PlayerGui"):FindFirstChild("TeleportBallGUI")
	if old then old:Destroy() end
end)

task.wait(1)

local gui = Instance.new("ScreenGui")
gui.Name = "TeleportBallGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 150, 0, 50)
btn.Position = UDim2.new(0.05, 0, 0.8, 0)
btn.Text = "TeleportBall OFF"
btn.Parent = gui

local toggled = false
local loopConn = nil
local ball

local function findBall()
	local ff = workspace:FindFirstChild("FootballField")
	if ff then
		return ff:FindFirstChild("SoccerBall")
	end
end

local function toggle()
	ball = findBall()
	if not ball then
		warn("SoccerBall bulunamadı")
		return
	end

	toggled = not toggled

	if toggled then
		btn.Text = "TeleportBall ON"

		loopConn = rs.RenderStepped:Connect(function()
			local char = player.Character
			if not char then return end
			local hrp = char:FindFirstChild("HumanoidRootPart")
			if not hrp then return end
			ball.CFrame = hrp.CFrame * CFrame.new(0,0,-3)
		end)

	else
		btn.Text = "TeleportBall OFF"
		if loopConn then loopConn:Disconnect() loopConn = nil end
	end
end

btn.MouseButton1Click:Connect(toggle)

uis.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.V then
		toggle()
	end
end)

task.spawn(function()
	while true do
		task.wait(0.2)
		ball = findBall()
		if ball and not ball:FindFirstChild("Delirium") then
			local s = Instance.new("Script")
			s.Name = "Delirium"
			s.Parent = ball
			s.Source = [[
				local ball = script.Parent
				ball.Touched:Connect(function(hit)
					local hum = hit.Parent:FindFirstChild("Humanoid")
					if hum then
						for i = 1,15 do
							ball.CFrame = ball.CFrame * CFrame.Angles(
								math.random(), math.random(), math.random()
							) + Vector3.new(
								math.random(-20,20),
								math.random(5,25),
								math.random(-20,20)
							)
							task.wait(0.05)
						end
					end
				end)
			]]
		end
	end
end)
