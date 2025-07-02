-- LocalScript inside StarterPlayerScripts or a GUI

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local replicatedStorage = game:GetService("ReplicatedStorage")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LocalItemGiver"
screenGui.Parent = playerGui

-- Create Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 300)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Parent = screenGui

-- Create UIListLayout for buttons
local layout = Instance.new("UIListLayout")
layout.Parent = frame
layout.Padding = UDim.new(0, 5)

-- List of item names in ReplicatedStorage to "give"
local items = {"Sword", "Shield", "MagicWand"} -- Change these to your actual item names

for _, itemName in ipairs(items) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 40)
    button.Text = "Get " .. itemName
    button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Parent = frame

    button.MouseButton1Click:Connect(function()
        -- Remove existing tool if any
        local backpack = player:WaitForChild("Backpack")
        local character = player.Character or player.CharacterAdded:Wait()

        for _, tool in ipairs(backpack:GetChildren()) do
            if tool.Name == itemName then
                tool:Destroy()
            end
        end
        for _, tool in ipairs(character:GetChildren()) do
            if tool:IsA("Tool") and tool.Name == itemName then
                tool:Destroy()
            end
        end

        -- Clone the tool locally and put it in the backpack
        local tool = replicatedStorage:FindFirstChild(itemName)
        if tool then
            local clone = tool:Clone()
            clone.Parent = backpack
        else
            warn("Item not found: " .. itemName)
        end
    end)
end

