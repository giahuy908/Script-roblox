-- LocalScript trong StarterGui

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Tạo ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Tạo TextBox
local textBox = Instance.new("TextBox")
textBox.Parent = screenGui
textBox.Size = UDim2.new(0, 200, 0, 50)
textBox.Position = UDim2.new(0.5, -100, 0.4, 0)
textBox.PlaceholderText = "Nhập tốc độ..."
textBox.TextScaled = true
textBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.ClearTextOnFocus = false

-- Tạo Button
local button = Instance.new("TextButton")
button.Parent = screenGui
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.5, 0)
button.Text = "Thay đổi tốc độ"
button.TextScaled = true
button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
button.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Hiệu ứng cầu vồng cho button
task.spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			button.BackgroundColor3 = Color3.fromHSV(i, 1, 1)
			task.wait(0.05)
		end
	end
end)

-- Khi bấm button -> thay đổi tốc độ
button.MouseButton1Click:Connect(function()
	local char = player.Character or player.CharacterAdded:Wait()
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if humanoid then
		local speed = tonumber(textBox.Text)
		if speed then
			humanoid.WalkSpeed = speed
			button.Text = "Tốc độ: "..speed
		else
			button.Text = "Nhập số hợp lệ!"
		end
	end
end)
