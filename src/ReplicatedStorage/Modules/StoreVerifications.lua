
local CollectionService = game:GetService("CollectionService")
local DataStoreService = game:GetService("DataStoreService")
local Players  = game:GetService("Players")


local module = {}

function module.FindTheOwner(player)
    local StoreOwner = CollectionService:GetTagged("StoreOwners")

    for _, store in pairs(StoreOwner) do
        local storeOwner
        storeOwner = store:FindFirstChild("Owner")
        if storeOwner then 
         
            if storeOwner.Value == player.Name then
                return store
            end
        end
    end
end 

function module.FindTheMannequin(player, mannequinId)
    local store = module.FindTheOwner(player)
    for _ , Mannequin in pairs(store:GetChildren()) do
        if CollectionService:HasTag(Mannequin, "CustomMannequin") then
            local MannequinIdentificator
            MannequinIdentificator = Mannequin:FindFirstChild("MannequinNumber")
            if MannequinIdentificator then
                if MannequinIdentificator == mannequinId then
                    return Mannequin
                end
            end

        end

    end 
end

function module.GetStoreData(player:player, LargeStoreData, MiddleStoreData, SmallStoreData)
    local store = module.FindTheOwner(player)
    if store then 
        if store.Name == "LargeStore" then
            local ownerId = Players:GetUserIdFromNameAsync(player)
            local Data = LargeStoreData:GetAsync(ownerId)	          	
            return Data
        end
        if store.Name == "MiddleStore" then
            local ownerId = Players:GetUserIdFromNameAsync(player)
            local Data = MiddleStoreData:GetAsync(ownerId)	
            return Data
        end
        if store.Name == "SmallStore" then
            local ownerId = Players:GetUserIdFromNameAsync(player)
            local Data = SmallStoreData:GetAsync(ownerId)	
            return Data      
        end
    end


end

return module

