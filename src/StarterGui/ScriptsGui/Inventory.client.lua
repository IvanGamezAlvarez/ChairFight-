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
local InventoryScroll =  InventoryFrame:WaitForChild("ScrollingFrame")
local CloseButton = InventoryFrame:WaitForChild("CloseButton")
local EquipButton = InventoryFrame:WaitForChild("EquipButton")
local RemoteEvents = ReplicatedStorage:FindFirstChild("RemoteEvents") or ReplicatedStorage:WaitForChild("RemoteEvents")
local ChairEvent = RemoteEvents:WaitForChild("ChairEvent")

local leaderstats = LocalPlayer:WaitForChild("leaderstats")
local KillsData = leaderstats:WaitForChild("Kills")
--print("hola mi gente que pasa min gente")


local InventoryClass = GestoreInventory.new(InventoryFrame, LocalPlayer)
InventoryClass:SpawnChairsButtons()






EquipButton.Activated:Connect(function()
    if InventoryClass.CanEquip then
        ChairsGenerator.DestroyChairs(LocalPlayer)
        InventoryClass:SpawnTool(InventoryClass.SpecName.Text)
        InventoryFrame.Visible = false
    else
        print(KillsData.Value)
        print(InventoryClass.LastPrice)
        if KillsData.Value >= tonumber(InventoryClass.LastPrice) then
            InventoryClass:UnlockButton()
            KillsData.Value -= tonumber(InventoryClass.LastPrice)
            local tag = "UnlockChair"
            ChairEvent:FireServer(tag, InventoryClass.LastChairName )
        end
       
        
    end
end)
ToggleButton.Activated:Connect(function()
    InventoryFrame.Visible = true
end)

CloseButton.Activated:Connect(function()
    InventoryFrame.Visible = false
end)

ChairEvent.OnClientEvent:Connect(function(Tag, Value1)
    if Tag == "UnlockIndividualChair" then
        print("enter")
        local Scroll = InventoryScroll:FindFirstChild(Value1)
        local Button = Scroll:FindFirstChild("ImageButton")
        print(Button)
        Button:WaitForChild("LockButton"):Destroy()
        print("Chair Active")
    end
end)