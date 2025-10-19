--// 🌌 BE HUB - Join Server GUI (by Legiahuy)
-- Giao diện nhỏ gọn: Join Server Ít Người / Join Server Trống

if game:GetService("CoreGui"):FindFirstChild("BE_HUB_JOIN") then
	game:GetService("CoreGui"):FindFirstChild("BE_HUB_JOIN"):Destroy()
end

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlaceId = game.PlaceId

--// Hàm thông báo
local function Notify(title, text)
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = title;
		Text = text;
		Duration = 5;
	})
end

--// Hàm Join server ít người
local function JoinSmallestServer()
	Notify("🌌 BE HUB", "Đang tìm server ít người nhất...")
	local cursor = ""
	local smallestServer = nil

	repeat
		local success, response = pcall(function()
			return game:HttpGet(
				"https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100&cursor="..cursor
			)
		end)
		if success then
			local data = HttpService:JSONDecode(response)
			for _, server in ipairs(data.data) do
				if server.playing > 0 and server.playing < server.maxPlayers then
					if not smallestServer or server.playing < smallestServer.playing then
						smallestServer = server
					end
				end
			end
			cursor = data.nextPageCursor or ""
		else
			break
		end
	until cursor == "" or not cursor

	if smallestServer then
		Notify("🌌 BE HUB", "Đang vào server ít người...")
		TeleportService:TeleportToPlaceInstance(PlaceId, smallestServer.id, LocalPlayer)
	else
		Notify("🌌 BE HUB", "Không tìm thấy server ít người.")
	end
end

--// Hàm Join server trống
local function JoinEmptyServer()
	Notify("🌌 BE HUB", "Đang tìm server trống nhất...")
	local cursor = ""
	local emptyServer = nil

	repeat
		local success, response = pcall(function()
			return game:HttpGet(
				"https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100&cursor="..cursor
			)
		end)
		if success then
			local data = HttpService:JSONDecode(response)
			for _, server in ipairs(data.data) do
				if server.playing == 0 then
					emptyServer = server
					break
				end
			end
			cursor = data.nextPageCursor or ""
		else
			break
		end
	until emptyServer or cursor == "" or not cursor

	if emptyServer then
		Notify("🌌 BE HUB", "Đang vào server trống...")
		TeleportService:TeleportToPlaceInstance(PlaceId, emptyServer.id, LocalPlayer)
	else
		Notify("🌌 BE HUB", "Không tìm thấy server trống.")
	end
end

--// Tạo GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BE_HUB_JOIN"
ScreenGui.Parent = game:GetService("CoreGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 230, 0, 140)
Frame.Position = UDim2.new(0.5, -115, 0.5, -70)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui
Frame.BackgroundTransparency = 0.05
Frame.ClipsDescendants = true
Frame.Name = "MainFrame"

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "🌌 BE HUB - Join Server"
Title.TextColor3 = Color3.fromRGB(180, 200, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.Parent = Frame

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, 0, 0, 20)
Subtitle.Position = UDim2.new(0, 0, 0, 25)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "by Legiahuy | Cosmic UI"
Subtitle.TextColor3 = Color3.fromRGB(150, 150, 200)
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 12
Subtitle.Parent = Frame

local Btn1 = Instance.new("TextButton")
Btn1.Size = UDim2.new(1, -20, 0, 35)
Btn1.Position = UDim2.new(0, 10, 0, 55)
Btn1.Text = "🌀 Join Server Ít Người"
Btn1.Font = Enum.Font.GothamBold
Btn1.TextSize = 14
Btn1.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn1.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
Btn1.Parent = Frame

local Btn1Corner = Instance.new("UICorner", Btn1)
Btn1Corner.CornerRadius = UDim.new(0, 8)

local Btn2 = Instance.new("TextButton")
Btn2.Size = UDim2.new(1, -20, 0, 35)
Btn2.Position = UDim2.new(0, 10, 0, 95)
Btn2.Text = "🌐 Join Server Trống"
Btn2.Font = Enum.Font.GothamBold
Btn2.TextSize = 14
Btn2.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn2.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
Btn2.Parent = Frame

local Btn2Corner = Instance.new("UICorner", Btn2)
Btn2Corner.CornerRadius = UDim.new(0, 8)

--// Kết nối nút
Btn1.MouseButton1Click:Connect(JoinSmallestServer)
Btn2.MouseButton1Click:Connect(JoinEmptyServer)

Notify("🌌 BE HUB", "Giao diện Join Server đã sẵn sàng!")
