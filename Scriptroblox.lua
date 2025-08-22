-- LocalScript trong StarterGui

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Tạo ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Hàm thêm bo góc + viền
local function styleUI(uiElement, radius, thickness)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius)
	corner.Parent = uiElement

	local stroke = Instance.new("UIStroke")
	stroke.Thickness = thickness
	stroke.Parent = uiElement

	return stroke
end

-- Frame chứa TextBox + Button chính (có thể ẩn/hiện)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 120)
mainFrame.Position = UDim2.new(0.5, -110, 0.4, 0)
mainFrame.BackgroundTransparency = 1
mainFrame.Parent = screenGui

-- Tạo TextBox nhỏ
local textBox = Instance.new("TextBox")
textBox.Parent = mainFrame
textBox.Size = UDim2.new(0, 150, 0, 35)
textBox.Position = UDim2.new(0.5, -75, 0, 0)
textBox.PlaceholderText = "Nhập tốc độ..."
textBox.TextScaled = true
textBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.ClearTextOnFocus = false
local textStroke = styleUI(textBox, 15, 2)

-- Tạo Button nhỏ
local button = Instance.new("TextButton")
button.Parent = mainFrame
button.Size = UDim2.new(0, 150, 0, 35)
button.Position = UDim2.new(0.5, -75, 0, 45)
button.Text = "Thay đổi tốc độ"
button.TextScaled = true
button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
local buttonStroke = styleUI(button, 15, 2)

-- Nút Toggle bật/tắt GUI
local toggle = Instance.new("TextButton")
toggle.Parent = screenGui
toggle.Size = UDim2.new(0, 100, 0, 30)
toggle.Position = UDim2.new(0.9, -50, 0.05, 0)
toggle.Text = "⚙️ Bật/Tắt"
toggle.TextScaled = true
toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
styleUI(toggle, 10, 2)

-- Hiệu ứng cầu vồng cho button + viền
task.spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			local color = Color3.fromHSV(i, 1, 1)
			button.BackgroundColor3 = color
			buttonStroke.Color = color
			textStroke.Color = color
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

-- Toggle ẩn/hiện GUI
local visible = true
toggle.MouseButton1Click:Connect(function()
	visible = not visible
	mainFrame.Visible = visible
end)
