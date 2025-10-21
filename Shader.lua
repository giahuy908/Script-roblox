--// 🌫️ BE HUB - Realistic Shader v7 (Fog Enhanced Edition) by Legiahuy
--// Shader có sương mù dày, ánh sáng xuyên sương, mượt và cực thật.

local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")
local Player = game.Players.LocalPlayer

-- 🧹 Xóa shader cũ
for _, v in pairs(Lighting:GetChildren()) do
	if v:IsA("Atmosphere") or v:IsA("BloomEffect") or v:IsA("SunRaysEffect")
	or v:IsA("ColorCorrectionEffect") or v:IsA("DepthOfFieldEffect")
	or v:IsA("BlurEffect") or v:IsA("Sky") then
		v:Destroy()
	end
end

-- 🔔 Thông báo Roblox
StarterGui:SetCore("SendNotification", {
	Title = "🌌 BE HUB SHADER";
	Text = "Đang tải shader ...";
	Duration = 4;
})

-- 💻 Giả lập lag nhẹ
local start = os.clock()
while os.clock() - start < 4 do
	for _ = 1, 6e5 do end
end

-- 🌫️ Atmosphere (SƯƠNG MÙ MỚI)
local atmosphere = Instance.new("Atmosphere")
atmosphere.Density = 0.6           -- tăng sương mù dày hơn (gốc 0.35)
atmosphere.Offset = 0.3
atmosphere.Color = Color3.fromRGB(180, 190, 205)
atmosphere.Decay = Color3.fromRGB(75, 85, 115)
atmosphere.Glare = 0.4
atmosphere.Haze = 2.2              -- tăng hiệu ứng mờ xa
atmosphere.Parent = Lighting

-- ☀️ Ánh sáng tổng thể
Lighting.Brightness = 2.6
Lighting.GlobalShadows = true
Lighting.EnvironmentDiffuseScale = 0.9
Lighting.EnvironmentSpecularScale = 1
Lighting.ClockTime = 7
Lighting.OutdoorAmbient = Color3.fromRGB(120, 125, 135)
Lighting.ColorShift_Top = Color3.fromRGB(255, 255, 255)
Lighting.ColorShift_Bottom = Color3.fromRGB(255, 220, 190)
Lighting.GeographicLatitude = 45

-- 🌁 Thêm Fog gốc của Roblox
Lighting.FogColor = Color3.fromRGB(190, 195, 210)
Lighting.FogStart = 40
Lighting.FogEnd = 350 -- khoảng cách bị phủ sương, càng thấp càng dày

-- ✨ Bloom
local bloom = Instance.new("BloomEffect")
bloom.Intensity = 0.45
bloom.Size = 28
bloom.Threshold = 0.92
bloom.Parent = Lighting

-- 🌞 Sun Rays
local sunrays = Instance.new("SunRaysEffect")
sunrays.Intensity = 0.18
sunrays.Spread = 0.85
sunrays.Parent = Lighting

-- 🎨 Hiệu chỉnh màu
local color = Instance.new("ColorCorrectionEffect")
color.Contrast = 0.2
color.Brightness = 0.08
color.Saturation = 0.4
color.TintColor = Color3.fromRGB(240, 235, 255)
color.Parent = Lighting

-- 🎥 Độ sâu (xa mờ, gần rõ)
local depth = Instance.new("DepthOfFieldEffect")
depth.FarIntensity = 0.4
depth.FocusDistance = 22
depth.InFocusRadius = 25
depth.NearIntensity = 0.45
depth.Parent = Lighting

-- 🌌 Skybox 2017
local sky = Instance.new("Sky")
sky.SkyboxBk = "http://www.roblox.com/asset/?id=245710263"
sky.SkyboxDn = "http://www.roblox.com/asset/?id=245710630"
sky.SkyboxFt = "http://www.roblox.com/asset/?id=245710380"
sky.SkyboxLf = "http://www.roblox.com/asset/?id=245710319"
sky.SkyboxRt = "http://www.roblox.com/asset/?id=245710230"
sky.SkyboxUp = "http://www.roblox.com/asset/?id=245710496"
sky.StarCount = 3000
sky.Parent = Lighting

-- 🌊 Nước thật
local terrain = workspace:FindFirstChildOfClass("Terrain")
if terrain then
	terrain.WaterTransparency = 0.05
	terrain.WaterReflectance = 0.3
	terrain.WaterColor = Color3.fromRGB(35, 100, 220)
	terrain.WaterWaveSize = 0.12
	terrain.WaterWaveSpeed = 18
end

-- 🔥 Cải thiện hiệu ứng lửa
for _, obj in pairs(workspace:GetDescendants()) do
	if obj:IsA("Fire") then
		obj.Heat = 30
		obj.Size = 10
	end
end

-- ✅ Thông báo hoàn tất
StarterGui:SetCore("SendNotification", {
	Title = "✅ BE HUB SHADER";
	Text = "Shader đã bật:   🌫️✨";
	Duration = 6;
})
