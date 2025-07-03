-- 🦅 Harpy's Stealth Cloak - Behavior Normalization Layer
-- Purpose: Blend in, avoid drawing mod logs

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- 1. Delay Execution (Anti-Sig)
task.wait(math.random(1,5))

-- 2. Spoof typical player inputs
local function simulateLegitActions()
    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid:Move(Vector3.new(math.random(), 0, math.random()).Unit, true)
    end
end

-- 3. Occasional Random Chat to Look Legit
local legitChats = {"hello", "lol", "nice", "gg", "bruh", "wait for me", "help"}
local function randomChat()
    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
        legitChats[math.random(1, #legitChats)],
        "All"
    )
end

-- 4. Regular legit activity spoofing
while true do
    task.wait(math.random(10,30))
    simulateLegitActions()
    if math.random() > 0.5 then
        randomChat()
    end
end

