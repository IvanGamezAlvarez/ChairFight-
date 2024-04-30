local GestoreInventory = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Modules = ReplicatedStorage:WaitForChild("Modules")
local ChairsLibrary = require(Modules.ChairsLibrary)
local FolderOfResources =   ReplicatedStorage:WaitForChild("ResourceForModules")
local ChairsGenerator = require(Modules.ChairsGenerator)
local ViewportMaker = require(Modules.ViewportMaker)
local MarketplaceService = game:GetService("MarketplaceService")



GestoreInventory.__index = GestoreInventory

function GestoreInventory.new(InventoryFrame, Player)
    local self = setmetatable({}, GestoreInventory)
    self.EquipButton = InventoryFrame.EquipButton
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
    self.CanEquip = false
    return self
end

function GestoreInventory:SpawnTool(ChairName)
    self.ChairsTool = FolderOfResources:WaitForChild(ChairName):Clone()
    self.ChairsTool.Parent = self.Player.Character
    return self
end

function GestoreInventory:Unlock(Button)
    Button:Destroy()


end

function GestoreInventory:UnlockButton()
    if self.LastChairToUnlock == nil then
        return
    end

    self.LastChairToUnlock:Destroy()
    self.LastChairToUnlock = nil
    return self
end

function GestoreInventory:LockButton(Button, value)
    
    local verification = value["Cost"]
    print(verification)
    if  value["Cost"] == "0" then
        print("A chair cost 0")
        local lockImage = Instance.new("ImageButton")
        lockImage.Image = "rbxassetid://17269404582"
        lockImage.ImageTransparency = .5
        lockImage.BackgroundColor3 = Color3.new(0, 0, 0)
        lockImage.BackgroundTransparency = .5
        lockImage.Parent = Button
        lockImage.Size = UDim2.new(1,0,1,0)
        lockImage.Name = "LockButton"
        lockImage.Activated:Connect(function()
            MarketplaceService:PromptGamePassPurchase(self.Player, value["IDStore"])
            if self.LastUiStroke then
                self.LastUiStroke.Thickness = 0
            end
        end)
    else
        local lockImage = Instance.new("ImageButton")
        lockImage.Image = "rbxassetid://17003544986"
        lockImage.ImageTransparency = .5
        lockImage.BackgroundColor3 = Color3.new(0, 0, 0)
        lockImage.BackgroundTransparency = .5
        lockImage.Parent = Button
        lockImage.Size = UDim2.new(1,0,1,0)
        lockImage.Name = "LockButton"
        local BuyText = Instance.new("TextLabel")
        BuyText.AnchorPoint = Vector2.new(.5,.5)
        BuyText.Position =  UDim2.new(.5,0,.8,0)
        BuyText.BackgroundColor3 = Color3.new(1, 1, 1)
        BuyText.BackgroundTransparency = 1
        BuyText.Parent = lockImage
        BuyText.Size = UDim2.new(.9,0,.5,0)
        BuyText.TextScaled = true
        BuyText.Name = "BuyText"
        BuyText.Font = "FredokaOne"
        BuyText.Text = value["Cost"] .. " Kills"
        BuyText.TextColor3 = Color3.new(1, 1, 1)
        lockImage.Activated:Connect(function()
            if self.LastUiStroke then
                self.LastUiStroke.Thickness = 0
            end
            self.LastChairName = value["Name"]
            self.LastPrice = value["Cost"]
            self.EquipButton.Text = "Unlock"
            self.LastChairToUnlock = lockImage
            self.CanEquip = false
        end)
    end
    return self
end
function GestoreInventory:UpdateSpecWindow(value)
    self.ViewportClassSpecImage:UpdateModel(value["Name"])
    self.SpecName.Text = value["Name"]
    self.SpecDamage.Text = "Damage:  " .. value["Damage"]
    self.SpecSpeed.Text = "Speed:  " .. value["Speed"]
    self.SpecHealth.Text = "Health:  " .. value["Health"]
    self.SpecMultiply.Text =  "Multiply:  " .. value["Multiply"]
    return self
end

function GestoreInventory:SpawnChairsButtons()
    for index, value in pairs(self.ChairsLibrary) do
        local Button = ViewportMaker.new(self.ScrollFrame, value["Name"], true)
        Button:SetTouchable()
        self:LockButton(Button.ClassButton.button, value)
        Button.ClassButton.button.Activated:Connect(function()
            if self.LastUiStroke then
                self.LastUiStroke.Thickness = 0
            end
            self.LastUiStroke = Button.UIStroke
            Button.UIStroke.Thickness = 3
            self.EquipButton.Text = "Equip"
            self.CanEquip = true
            self:UpdateSpecWindow(value)
            
        end)
        
    end
    return self
end




return GestoreInventory