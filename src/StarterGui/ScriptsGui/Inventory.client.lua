local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Modules = ReplicatedStorage:WaitForChild("Modules")
local GestoreInventory = require(Modules.GestoreInventory)
local ChairsGenerator = require(Modules.ChairsGenerator)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer


local GeneralGui = script.Parent.Parent
local InventoryGui = GeneralGui:WaitForChild("Inventory")
local Toggle = InventoryGui:WaitForChild("Toggle")
local ToggleButton = Toggle:WaitForChild("ImageButton")
local InventoryFrame = InventoryGui:WaitForChild("Inventory")
local CloseButton = InventoryFrame:WaitForChild("CloseButton")
local EquipButton = InventoryFrame:WaitForChild("EquipButton")
print("hola mi gente que pasa min gente")


local InventoryClass = GestoreInventory.new(InventoryFrame, LocalPlayer)
InventoryClass:SpawnChairsButtons()






EquipButton.Activated:Connect(function()
    ChairsGenerator.DestroyChairs(LocalPlayer)
    InventoryClass:SpawnTool(InventoryClass.SpecName.Text)
    InventoryFrame.Visible = false
end)
ToggleButton.Activated:Connect(function()
    InventoryFrame.Visible = true
end)

CloseButton.Activated:Connect(function()
    InventoryFrame.Visible = false
end)