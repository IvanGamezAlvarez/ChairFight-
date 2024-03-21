
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Tag = "Chair"

local RosourceForModels = ReplicatedStorage:WaitForChild("ResourceForModules")
local Modules = ReplicatedStorage:WaitForChild("Modules")
local ChairsGenerator = require(Modules.ChairsGenerator)
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")




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



ActivateChairs()

