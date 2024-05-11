
--Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local ContextA = game:GetService("ContextActionService")


local RemoteEvents = ReplicatedStorage:FindFirstChild("RemoteEvents") or ReplicatedStorage:WaitForChild("RemoteEvents")
local ChairEvent = RemoteEvents:WaitForChild("ChairEvent")
local BindableEvents = ReplicatedStorage:FindFirstChild("BindableEvents") or ReplicatedStorage:WaitForChild("BindableEvents")
local ChairBindable = BindableEvents:WaitForChild("ChairBE")


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
local KillsMultiple
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

hitTruck = loadAnimation(17356095015)

local function SetStats(Chair)
    print("Setting Chair")
    for index, value in pairs(ChairsLibrary) do 
        if Chair.Name == value["Name"] then
            print("Encontramos la silla indicada es "..value["Name"] )
            Humanoid.Health = value["Health"]

            if LocalPlayer.Backpack.X2Health then
                Humanoid.MaxHealth = value["Health"] * 2
            else
                Humanoid.MaxHealth = value["Health"] 
            end
            if LocalPlayer.Backpack.X2Speed then
                Humanoid.WalkSpeed = value["Speed"] * 2
            else
                Humanoid.WalkSpeed = value["Speed"] 
            end
            if LocalPlayer.Backpack.X2SpeedAttack then
                SpeedAttack = value["SpeedAttack"] * 2
            else
                SpeedAttack = value["SpeedAttack"] 
            end
            if LocalPlayer.Backpack.X2Damage then
                Damage = value["Damage"] * 2
            else
                Damage = value["Damage"]
            end
            KillsMultiple = value["Multiply"]
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


local function Hiting()
        ActiveChair()
        SetStats(Tool)
            if CanHit then
                ChairBindable:Fire("ShakeDo")
                hitTruck:Play()
                hitTruck:AdjustSpeed(SpeedAttack)
                CanMakeDamage = true
                CanHit = false
            end    
end

local function MakeConnection()
    Tool.Handle.touched:Connect(function(part)
        local player = game:GetService("Players"):GetPlayerFromCharacter(part.Parent)
            if player then
                if CanMakeDamage then
                    local ExternalHumanoid = player.Character:WaitForChild("Humanoid")
                    local tag = "MakeDamage"
                    ChairEvent:FireServer(tag, ExternalHumanoid, Damage, KillsMultiple, player)
                    CanMakeDamage = false
                end
            else
                if part.Parent.Name == "Skeleton" then
                    if CanMakeDamage then
                        print("we found the alien mf")
                        local Alien = part.Parent
                        local ExternalHumanoid = Alien:WaitForChild("Humanoid")
                        local tag = "MakeDamage"
                        ChairEvent:FireServer(tag, ExternalHumanoid, Damage, KillsMultiple)
                        CanMakeDamage = false    
                    end
                end
            end
        
    end)
    -- Tool.Equipped:Connect(function(Mouse)
    --     ActiveChair()
    --     SetStats(Tool)
    --     Mouse.Button1Down:Connect(function()
    --         if CanHit then
    --             ChairBindable:Fire("ShakeDo")
    --             hitTruck:Play()
    --             hitTruck:AdjustSpeed(SpeedAttack)
    --             CanMakeDamage = true
    --             CanHit = false
    --         end
            
    --     end)
    --     Mouse.Button2Down:Connect(function()
    --     --    playAnimation(holdAnimation)
    --     end)
    -- end)
    
end



LocalPlayer.Character.ChildAdded:Connect(function(tool)
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


ContextA:BindAction("ChairHit", Hiting, true,  Enum.UserInputType.MouseButton1)
ContextA:SetPosition("ChairHit",UDim2.new(0.3,0,0.3,0))
ContextA:SetImage("ChairHit", "rbxassetid://17355786962")