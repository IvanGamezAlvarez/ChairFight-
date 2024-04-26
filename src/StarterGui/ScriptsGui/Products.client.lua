local GeneralGui = script.Parent.Parent
local StoreGUi = GeneralGui:WaitForChild("Store")
local FrameButtons = StoreGUi:GetChildren()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")

for _,Frame in pairs(FrameButtons) do
    local Button = Frame:WaitForChild("ImageButton") 
    Button.Activated:Connect(function()
        local Id = Frame:WaitForChild("Id")
        MarketplaceService:PromptProductPurchase(LocalPlayer, Id.Value)
    end)
end