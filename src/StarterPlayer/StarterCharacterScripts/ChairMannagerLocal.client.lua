


local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Modules = ReplicatedStorage:WaitForChild("Modules")
local ChairsGenerator = require(Modules.ChairsGenerator)
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local mouse = LocalPlayer:GetMouse()
local Tool 





-- Función para reproducir la animación
local function playAnimation(animationId)
    local humanoid = Tool.Parent:FindFirstChildOfClass("Humanoid")
    if humanoid then
        local track = humanoid:LoadAnimation(animationId)
        track:Play()
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
    Tool.Equipped:Connect(function(Mouse)
        ActiveChair()
        --local Class = ChairsGenerator.new(Tool)
        --Class:SetBillboardGui()
     
        Mouse.Button1Down:Connect(function()
          playAnimation(16812740446)
        end)
        Mouse.Button1Up:Connect(function()
            playAnimation(16812740446)
        end)
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