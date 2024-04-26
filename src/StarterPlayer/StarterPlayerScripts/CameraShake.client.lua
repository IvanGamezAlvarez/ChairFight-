--Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--References
local Player = game.Players.LocalPlayer
local Char = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Char.Humanoid

--Events
local RemoteEvents = ReplicatedStorage:FindFirstChild("RemoteEvents") or ReplicatedStorage:WaitForChild("RemoteEvents")
local ChairEvent = RemoteEvents:WaitForChild("ChairEvent")
local BindableEvents = ReplicatedStorage:FindFirstChild("BindableEvents") or ReplicatedStorage:WaitForChild("BindableEvents")
local ChairBindable = BindableEvents:WaitForChild("ChairBE")

local function CameraDoHit()
    for i = 1,5 do
        workspace.Camera.CFrame = workspace.Camera.CFrame * CFrame.Angles(0.03,0,0)
        wait()
        end
        for i = 1,5 do
        workspace.Camera.CFrame = workspace.Camera.CFrame * CFrame.Angles(-0.03,0,0)
        wait()
        end
end
local function CameraReciveHit()
    for i = 1, 10 do
        local x = math.random(-100,100)/100
        local y = math.random(-100,100)/100
        local z = math.random(-100,100)/100
        Humanoid.CameraOffset = Vector3.new(x,y,z)
        print(i)
        wait()
    end
end


ChairEvent.OnClientEvent:Connect(function(tag)
    if tag == "ShakeDo" then
        CameraDoHit()
    elseif tag == "ShakeRecive" then
        print("recive a hit")
        CameraReciveHit()
    end
end)

ChairBindable.Event:Connect(function(tag)
    if tag == "ShakeDo" then
        CameraDoHit()
    elseif tag == "ShakeRecive" then
        CameraReciveHit()
    end
end)