
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Tag = "Chair"

local RosourceForModels = ReplicatedStorage:WaitForChild("ResourceForModules")
local Modules = ReplicatedStorage:WaitForChild("Modules")
local ChairsGenerator = require(Modules.ChairsGenerator)
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")


local RemoteEvents = ReplicatedStorage:FindFirstChild("RemoteEvents") or ReplicatedStorage:WaitForChild("RemoteEvents")
local ChairEvent = RemoteEvents:WaitForChild("ChairEvent")



-- Función para reproducir la animación
local function DestroyChairs(player:Player)
    print("Destroying chairs")
    for _, child in pairs(player.Character:GetChildren()) do
		if child:IsA("Tool") then child:Destroy() end
	end

	for _, child in pairs(player.Backpack:GetChildren()) do
        if child:IsA("Tool") then child:Destroy() end
	end
end


-- Conecta las funciones a los eventos del mouse



local function ActivateChairs()
    for _, chair in pairs(CollectionService:GetTagged(Tag)) do
        local ClassChair = ChairsGenerator.new(chair)
        ClassChair:SetBillboardGui()  
        print(ClassChair.ProximityPromptInstance)
        ClassChair.ProximityPromptInstance.Triggered:Connect(function(player)
            ChairsGenerator.DestroyChairs(player)
            ClassChair:SpawnTool(player)
            ClassChair:HideChairs()
        end)
    end
end

ChairEvent.OnServerEvent:Connect(function(player, tag, Value1, Value2, Value3)
    if tag == "MakeDamage" then
        Value1.Health = Value1.Health - Value2
        if Value1.Health <= 0 then
            print(Value1.Parent.Name .. "Was Killed by" ..player.Name)
            local leaderstats = player:WaitForChild("leaderstats")
            local KillsData = leaderstats:WaitForChild("Kills")
            KillsData.Value += 1 * Value3
        end 
    end
end)

ActivateChairs()

