local Skin = {}

Skin.Name = "Miners Haven 2016"
Skin.Theme = {
	Backgrounds = {
		Dark = Color3.fromRGB(0, 0, 0),
		Medium = Color3.fromRGB(255, 255, 255),
		Light = Color3.fromRGB(255, 255, 255),
		Groupbox = Color3.fromRGB(255, 255, 255),
		Highlight = Color3.fromRGB(241, 241, 241),
	},
	Foregrounds = {
		Active = Color3.fromRGB(32, 33, 35),
		Light = Color3.fromRGB(32, 33, 35),
		Medium = Color3.fromRGB(78, 78, 78),
		Dark = Color3.fromRGB(28, 43, 54),
		MediumHover = Color3.fromRGB(0, 0, 0),
		DarkHover = Color3.fromRGB(14, 106, 173),
	},
	Miscellaneous = {
		Divider = Color3.fromRGB(28, 43, 54),
		Shadow = Color3.fromRGB(0, 0, 0),
		LighterShadow = Color3.fromRGB(32, 33, 35),
	},
	Accents = {
		Main = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(139, 255, 107)),
			ColorSequenceKeypoint.new(0.56, Color3.fromRGB(36, 255, 139)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(24, 215, 53)),
		}),
		Brighter = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 255, 176)),
			ColorSequenceKeypoint.new(0.56, Color3.fromRGB(126, 255, 126)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(36, 255, 139)),
		}),
	},
}

local DARK = Color3.fromRGB(0, 0, 0)
local PANEL = Color3.fromRGB(255, 255, 255)
local BORDER = Color3.fromRGB(28, 43, 54)
local WINDOW_BORDER = Color3.fromRGB(32, 33, 35)
local GREEN = Color3.fromRGB(139, 255, 107)
local WHITE = Color3.fromRGB(255, 255, 255)
local INK = Color3.fromRGB(32, 33, 35)
local TEXTURE = "rbxassetid://209629568"

local function lowered(value)
	return string.lower(tostring(value or ""))
end

local function has(value, part)
	return string.find(lowered(value), part, 1, true) ~= nil
end

local function isDestructive(text)
	text = lowered(text)
	return has(text, "destroy") or has(text, "clear") or has(text, "sell") or has(text, "delete")
end

local function isPrimary(text)
	text = lowered(text)
	return has(text, "load") or has(text, "buy") or has(text, "apply") or has(text, "enable") or has(text, "start")
end

local function findWindow(root)
	if not root then return nil end
	local best, bestArea = nil, 0
	for _, object in ipairs(root:GetDescendants()) do
		if object:IsA("GuiObject") and object.Visible then
			local ok, size = pcall(function() return object.AbsoluteSize end)
			local area = ok and size.X * size.Y or 0
			if area > bestArea and size.X >= 420 and size.Y >= 250 then
				best, bestArea = object, area
			end
		end
	end
	return best
end

local function restyle(object)
	if not object or not object.Parent then return end
	if object:IsA("UICorner") then
		object.CornerRadius = UDim.new(0, 0)
		return
	end
	if object:IsA("UIStroke") then
		object.Color = BORDER
		object.Thickness = 1
		object.Transparency = 0
		return
	end
	if object:IsA("TextLabel") or object:IsA("TextButton") or object:IsA("TextBox") then
		object.Font = Enum.Font.SourceSans
		object.TextColor3 = INK
		object.TextStrokeTransparency = 1
		if object:IsA("TextBox") then
			object.BackgroundColor3 = PANEL
			object.BackgroundTransparency = 0.15
			object.BorderSizePixel = 1
			object.BorderColor3 = BORDER
			object.PlaceholderColor3 = Color3.fromRGB(110, 110, 110)
			object.TextXAlignment = Enum.TextXAlignment.Left
		elseif object:IsA("TextButton") then
			object.BorderSizePixel = 1
			object.BorderColor3 = BORDER
			if isDestructive(object.Text) then
				object.BackgroundColor3 = Color3.fromRGB(255, 225, 232)
				object.BorderColor3 = Color3.fromRGB(215, 133, 137)
				object.TextColor3 = INK
			elseif isPrimary(object.Text) then
				object.BackgroundColor3 = GREEN
				object.BorderColor3 = Color3.fromRGB(0, 0, 0)
				object.TextColor3 = INK
			end
		elseif object.Parent and (has(object.Parent.Name, "top") or has(object.Parent.Name, "title") or has(object.Parent.Name, "header")) then
			object.TextColor3 = WHITE
		end
		return
	end
	if object:IsA("Frame") or object:IsA("ScrollingFrame") then
		local name = lowered(object.Name)
		if has(name, "top") or has(name, "title") or has(name, "header") then
			object.BackgroundColor3 = DARK
		elseif has(name, "tab") or has(name, "sidebar") or has(name, "group") then
			object.BackgroundColor3 = DARK
			object.BackgroundTransparency = 0.5
		else
			object.BackgroundColor3 = PANEL
		end
		object.BorderSizePixel = 1
		object.BorderColor3 = BORDER
	end
end

local function addTexture(window)
	if not window or window:FindFirstChild("MX6_2016_Texture") then return end
	local texture = Instance.new("ImageLabel")
	texture.Name = "MX6_2016_Texture"
	texture.BackgroundTransparency = 1
	texture.BorderSizePixel = 0
	texture.Image = TEXTURE
	texture.ImageColor3 = WHITE
	texture.ImageTransparency = 0.6
	texture.ScaleType = Enum.ScaleType.Tile
	texture.TileSize = UDim2.fromOffset(96, 96)
	texture.Size = UDim2.fromScale(1, 1)
	texture.Position = UDim2.fromScale(0, 0)
	texture.ZIndex = 0
	texture.Active = false
	texture.Parent = window
	return texture
end

local function addBackdrop(root)
	if not root or not root:IsA("ScreenGui") or root:FindFirstChild("MX6_2016_Backdrop") then return end
	local backdrop = Instance.new("Frame")
	backdrop.Name = "MX6_2016_Backdrop"
	backdrop.BackgroundColor3 = DARK
	backdrop.BackgroundTransparency = 0.3
	backdrop.BorderColor3 = DARK
	backdrop.BorderSizePixel = 10
	backdrop.Size = UDim2.fromScale(1, 1)
	backdrop.ZIndex = 0
	backdrop.Active = false
	backdrop.Parent = root
	return backdrop
end

function Skin.Apply(context)
	context = context or {}
	if context.Starlight and context.Starlight.SetTheme then
		pcall(function() context.Starlight:SetTheme(Skin.Theme) end)
	end

	local root = context.Root
	if not root and context.FindRoot then
		local ok, result = pcall(context.FindRoot)
		if ok then root = result end
	end
	if not root then return {Destroy = function() end} end

	local window = findWindow(root)
	addBackdrop(root)
	if window then
		window.BackgroundColor3 = PANEL
		window.BorderSizePixel = 6
		window.BorderColor3 = WINDOW_BORDER
		addTexture(window)
	end
	for _, object in ipairs(root:GetDescendants()) do restyle(object) end

	local connection = root.DescendantAdded:Connect(function(object)
		task.defer(restyle, object)
	end)

	return {
		Destroy = function()
			pcall(function() connection:Disconnect() end)
			if window then
				local texture = window:FindFirstChild("MX6_2016_Texture")
				if texture then texture:Destroy() end
			end
			local backdrop = root:FindFirstChild("MX6_2016_Backdrop")
			if backdrop then backdrop:Destroy() end
		end,
	}
end

return Skin
