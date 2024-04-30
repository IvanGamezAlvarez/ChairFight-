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
            local success, productInfo = pcall(function()
                return MarketplaceService:GetProductInfo(Id.Value, Enum.InfoType.GamePass)
            end)
        
            if success and productInfo then
                MarketplaceService:PromptGamePassPurchase(LocalPlayer, Id.Value)

            else        
                success, productInfo = pcall(function()
                    return MarketplaceService:GetProductInfo(Id.Value, Enum.InfoType.Product)
                end)
        
                if success and productInfo then
                    MarketplaceService:PromptProductPurchase(LocalPlayer, Id.Value)

                else
                    print("Developer Product Error:", productInfo)
                    print("Invalid product ID")
                end
            end
        end)
    
end