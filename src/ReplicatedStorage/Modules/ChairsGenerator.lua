local ChairsModule = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local FolderOfResources =   ReplicatedStorage:WaitForChild("ResourceForModules")
local ChairsStorage =   ReplicatedStorage:WaitForChild("ChairsStorage")
local BillboardGui = FolderOfResources:WaitForChild("BillboardGuiBase")

ChairsModule.__index = ChairsModule

local Modules = ReplicatedStorage:WaitForChild("Modules")
local ChairsLibrary = require(Modules.ChairsLibrary)


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
    for index, value in pairs(ChairsLibrary) do 
        if Chair.Name == value["Name"] then
            self.Name = value["Name"]
            self.Health = value["Health"]
            self.Damage = value["Damage"]
            self.CoinsMultiplier = value["Multiply"]
            self.Speed = value["Speed"]
            self.SpawnTime = value["SpawnTime"]
            self.SpeedAttack = value["SpeedAttack"]
            self.RequireLevel = value["RequireLevel"]
            self.BillboardGui = BillboardGui:Clone()
            self.BillboardGui.Parent = Chair
            self.ProximityPromptInstance = Instance.new("ProximityPrompt", Chair)
            self.ProximityPromptInstance.ActionText = "Equip"
            return self
        end
    end
    warn("the chair can't be found it")
    return self
end

function ChairsModule:SetBillboardGui()
    print(self.Chair)
    print(self.Name)
    self.Frame = self.BillboardGui.Frame
    self.CoinsMultiplierTxt = self.Frame.CoinsMultiplier
    self.DamageTxt= self.Frame.Damage
    self.HealthTxt = self.Frame.Health
    self.SpeedTxt = self.Frame.Speed
    self.SpeedAttackTxt = self.Frame.SpeedAttack
    self.RequireLevelTxt = self.Frame.RequireLevel
    self.CoinsMultiplierTxt.Text = "Multiplier:   " ..self.CoinsMultiplier
    self.DamageTxt.Text = "Damage:   " ..self.Damage
    self.HealthTxt.Text = "Health:   " ..self.Health
    self.SpeedTxt.Text = "Speed:   " ..self.Speed
    self.SpeedAttackTxt.Text = "Speed attack:   " ..self.SpeedAttack
    self.RequireLevelTxt.Text =  "Requiere level:   " ..self.RequireLevel

    return self
end



function ChairsModule:SetStats(Player)
    self.Player = Player
    self.Humanoid = self.Player.Character:WaitForChild("Humanoid")
    self.Humanoid.MaxHealth = self.Health
	self.Humanoid.Health = self.Health



end

function ChairsModule:HideChairs()
    self.Chair.Parent = ChairsStorage
    --print(self.Chair.SpawnTime.Value)
    wait(self.SpawnTime)
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