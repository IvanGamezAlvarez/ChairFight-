local GestoreInventory = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Modules = ReplicatedStorage:WaitForChild("Modules")
local ChairsLibrary = require(Modules.ChairsLibrary)
local FolderOfResources =   ReplicatedStorage:WaitForChild("ResourceForModules")
local ChairsGenerator = require(Modules.ChairsGenerator)
local ViewportMaker = require(Modules.ViewportMaker)



GestoreInventory.__index = GestoreInventory

function GestoreInventory.new(InventoryFrame, Player)
    local self = setmetatable({}, GestoreInventory)
    self.Player = Player
    self.SpecsFrame = InventoryFrame.Specs
    self.SpecImage = self.SpecsFrame:WaitForChild("SpecImage")
    self.SpecName = self.SpecsFrame:WaitForChild("Chair Name")
    self.SpecDamage = self.SpecsFrame:WaitForChild("Damage Stat")
    self.SpecSpeed = self.SpecsFrame:WaitForChild("Speed Stat")
    self.SpecHealth = self.SpecsFrame:WaitForChild("Health Stat")
    self.SpecMultiply = self.SpecsFrame:WaitForChild("Multiply Stat")
    self.InventoryFrame = InventoryFrame
    self.ScrollFrame = InventoryFrame.ScrollingFrame
    self.ChairsLibrary = ChairsLibrary
    self.ViewportClassSpecImage = ViewportMaker.new(self.SpecImage, "Classic Chair", false)
    return self
end

function GestoreInventory:SpawnTool(ChairName)
    self.ChairsTool = FolderOfResources:WaitForChild(ChairName):Clone()
    self.ChairsTool.Parent = self.Player.Character
    return self
end

function GestoreInventory:SpawnChairsButtons()
    for index, value in pairs(self.ChairsLibrary) do
        local Button = ViewportMaker.new(self.ScrollFrame, value["Name"], true)
        Button:SetTouchable()
        Button.ClassButton.button.Activated:Connect(function()
            self.ViewportClassSpecImage:UpdateModel(value["Name"])
            self.SpecName.Text = value["Name"]
            self.SpecDamage.Text = "Damage:  " .. value["Damage"]
            self.SpecSpeed.Text = "Speed:  " .. value["Speed"]
            self.SpecHealth.Text = "Health:  " .. value["Health"]
            self.SpecMultiply.Text =  "Multuply:  " .. value["Multiply"]
        end)
    end
    return self
end



















return GestoreInventory