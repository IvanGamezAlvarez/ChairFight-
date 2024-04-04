
--Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")




local RemoteEvents = ReplicatedStorage:FindFirstChild("RemoteEvents") or ReplicatedStorage:WaitForChild("RemoteEvents")
local ChairEvent = RemoteEvents:WaitForChild("ChairEvent")

-- Modules
local Modules = ReplicatedStorage:WaitForChild("Modules")
local ChairsGenerator = require(Modules.ChairsGenerator)
local ChairsLibrary = require(Modules.ChairsLibrary)

-- References
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character
local Humanoid:Humanoid = Character:WaitForChild("Humanoid")
local mouse = LocalPlayer:GetMouse()
local Tool 

local SpeedAttack
local Damage
local CanHit = true
local CanMakeDamage = false
local hitTruck





-- Función para reproducir la animación

local function loadAnimation(animationId)

        local anim = Instance.new('Animation', Character)
        anim.AnimationId = "rbxassetid://"..animationId
        game:GetService('RunService').Stepped:Wait()
        local hitTrack = Humanoid:LoadAnimation(anim)
        return hitTrack

end

hitTruck = loadAnimation(16813079831)

local function SetStats(Chair)
    print("Setting Chair")
    for index, value in pairs(ChairsLibrary) do 
        if Chair.Name == value["Name"] then
            print("Encontramos la silla indicada es "..value["Name"] )
            Humanoid.MaxHealth = value["Health"]
	        Humanoid.Health = value["Health"]
            Humanoid.WalkSpeed = value["Speed"]
            SpeedAttack = value["SpeedAttack"]
            Damage = value["Damage"]
        end
    end
end







-- Conecta las funciones a los eventos del mouse
local function ActiveChair()
    if Tool then 
    Tool.Activated:Connect(function(mouse)
        
    end)
    end
end

local function MakeConnection()
    Tool.Handle.touched:Connect(function(part)
        local player = game:GetService("Players"):GetPlayerFromCharacter(part.Parent)
            if player then
                if CanMakeDamage then
                    local ExternalHumanoid = player.Character:WaitForChild("Humanoid")
                    local tag = "MakeDamage"
                    ChairEvent:FireServer(tag, ExternalHumanoid, Damage)
                    CanMakeDamage = false
                end
            end
        
    end)
    Tool.Equipped:Connect(function(Mouse)
        ActiveChair()
        SetStats(Tool)
        --local Class = ChairsGenerator.new(Tool)
        --Class:SetBillboardGui()

        Mouse.Button1Down:Connect(function()
            if CanHit then
                hitTruck:Play()
                hitTruck:AdjustSpeed(SpeedAttack)
                CanMakeDamage = true
                CanHit = false
            end
            
        end)
    --  Mouse.Button1Up:Connect(function()
    --       playAnimation(16813079831)
    --  end)
        Mouse.Button2Down:Connect(function()
        --    playAnimation(holdAnimation)
        end)
    end)
    
end




Players.PlayerAdded:Connect(function(player)
	print(player.Name .. " joined the game!")
end)


LocalPlayer.Character.ChildAdded:Connect(function(tool)
        print("Is a chair")
        if tool:IsA("Tool") then
            Tool = tool
            print("Is a chair")
            tool.Equipped:Connect(function()
                MakeConnection()
            end)
            tool.Unequipped:Connect(function()
                print("Do something")
            end)
        end
end)

hitTruck.Ended:Connect(function()
    CanHit = true
    CanMakeDamage = false
end)