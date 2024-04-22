
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

local function AddExpirience(player)
    local StatsData = player:WaitForChild("StatsData")
    local Experience = StatsData:WaitForChild("Experience")
    Experience.Value += 1 
    ChairEvent:FireClient(player,"AddExpirience", Experience.Value )

    if Experience.Value >= 3 then
        player.leaderstats.Level.Value += 1
        ChairEvent:FireClient(player,"LevelUp", player.leaderstats.Level.Value )
        Experience.Value = 0
    end
end


local function ActivateChairs()
    for _, chair in pairs(CollectionService:GetTagged(Tag)) do
        local ClassChair = ChairsGenerator.new(chair)
        ClassChair:SetBillboardGui()  
        print(ClassChair.ProximityPromptInstance)
        ClassChair.ProximityPromptInstance.Triggered:Connect(function(player)
            print(ClassChair.RequireLevel)
            if player.leaderstats.Level.Value >= tonumber(ClassChair.RequireLevel) then
            DestroyChairs(player)
            ClassChair:SpawnTool(player)
            ClassChair:HideChairs()
            else
                print("not enoght level")
                print(player.leaderstats.Level.Value)
                ChairEvent:FireClient(player, "NotLevel")
            end
        end)
    end
end

ChairEvent.OnServerEvent:Connect(function(player, tag, Value1, Value2, Value3)
    if tag == "MakeDamage" then
        Value1.Health = Value1.Health - Value2
        if Value1.Health <= 0 then
            print(Value1.Parent.Name .. "Was Killed by" ..player.Name)
            --local KillsData = leaderstats:WaitForChild("Kills")
            --KillsData.Value += 1 * Value3
            AddExpirience(player)
        end 
    elseif tag == "EquipChair" then
        print("EquipChair")
        DestroyChairs(player)
        local ChairsTool = RosourceForModels:WaitForChild(Value1):Clone()
        ChairsTool.Parent = player.Character
    end
end)

ActivateChairs()

