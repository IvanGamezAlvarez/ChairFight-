local ChairsModule = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local FolderOfResources =   ReplicatedStorage:WaitForChild("ResourceForModules")
local ChairsStorage =   ReplicatedStorage:WaitForChild("ChairsStorage")
local BillboardGui = FolderOfResources:WaitForChild("BillboardGuiBase")

ChairsModule.__index = ChairsModule


function ChairsModule.DestroyChairs(player:Player)
    print("Destroying chairs")
    for _, child in pairs(player.Character:GetChildren()) do
		if child:IsA("Tool") then child:Destroy() end
	end

	for _, child in pairs(player.Backpack:GetChildren()) do
        if child:IsA("Tool") then child:Destroy() end
	end
end
function ChairsModule:SpawnTool(Player)
    self.ChairsTool = FolderOfResources:WaitForChild(self.Chair.Name):Clone()
    self.ChairsTool.Parent = Player.Character
    return self
end

function ChairsModule.new(Chair)
    local self = setmetatable({}, ChairsModule)
    self.Chair = Chair
    self.Health = Chair.Health.Value
    self.Damage = Chair.Damage.Value
    self.CoinsMultiplier = Chair.CoinsMultiplier.Value
    self.Speed = Chair.Speed.Value
    self.SpawnTime = Chair.SpawnTime.Value
    self.BillboardGui = BillboardGui:Clone()
    self.BillboardGui.Parent = Chair
    self.ProximityPromptInstance = Instance.new("ProximityPrompt", Chair)
    self.ProximityPromptInstance.ActionText = "Equip"
    return self
end

function ChairsModule:SetBillboardGui()
    print("Setting Billboard")
    self.Frame = self.BillboardGui.Frame
    self.CoinsMultiplierTxt = self.Frame.CoinsMultiplier
    self.DamageTxt= self.Frame.Damage
    self.HealthTxt = self.Frame.Health
    self.SpeedTxt = self.Frame.Speed
    self.CoinsMultiplierTxt.Text = "Multiplier:   " ..self.CoinsMultiplier
    self.DamageTxt.Text = "Damage:   " ..self.Damage
    self.HealthTxt.Text = "Health:   " ..self.Health
    self.SpeedTxt.Text = "Speed:   " ..self.Speed
    return self
end

function ChairsModule:HideChairs()
    self.Chair.Parent = ChairsStorage
    --print(self.Chair.SpawnTime.Value)
    wait(self.Chair.SpawnTime.Value)
    self.Chair.Parent = Workspace
end


function ChairsModule:DestroyChair()
    self.ChairsTool:Destroy()
    return self
end




function ChairsModule:DefenseMode()
    return self
end



return ChairsModule 