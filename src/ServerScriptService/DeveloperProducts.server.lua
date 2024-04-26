local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")


local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage:FindFirstChild("RemoteEvents") or ReplicatedStorage:WaitForChild("RemoteEvents")
local ChairEvent = RemoteEvents:WaitForChild("ChairEvent")

local productFunctions = {}

--10 Levels
productFunctions[1814293092] = function(receipt, player)
	local stats = player:FindFirstChild("leaderstats")
	if player then
		stats.Level.Value += 10
		ChairEvent:FireClient(player,"LevelUp", player.leaderstats.Level.Value )
        ChairEvent:FireClient(player,"ProductAdvise", "+10 Levels")
		return true
	end
end
--50 Levels
productFunctions[1814293286] = function(receipt, player)
	local stats = player:FindFirstChild("leaderstats")
	if player then
		stats.Level.Value += 50
		ChairEvent:FireClient(player,"LevelUp", player.leaderstats.Level.Value )
        ChairEvent:FireClient(player,"ProductAdvise", "+50 Levels")
		return true
	end
end
--100 Levels
productFunctions[1814293500] = function(receipt, player)
	local stats = player:FindFirstChild("leaderstats")
	if player then
		stats.Level.Value += 100
		ChairEvent:FireClient(player,"LevelUp", player.leaderstats.Level.Value )
        ChairEvent:FireClient(player,"ProductAdvise", "+100 Levels")
		return true
	end
end
--100 Kills
productFunctions[1814287044] = function(receipt, player)
	local stats = player:FindFirstChild("leaderstats")
	if player then
		stats.Kills.Value += 100
        ChairEvent:FireClient(player,"ProductAdvise", "+100 Kills")
		return true
	end
end
--500 Kills
productFunctions[1814287315] = function(receipt, player) 
	local stats = player:FindFirstChild("leaderstats")
	if player then
		stats.Kills.Value += 500
        ChairEvent:FireClient(player,"ProductAdvise", "+500 Kills")
		return true
	end
end
--1000 Kills
productFunctions[1814287594] = function(receipt, player) 
	local stats = player:FindFirstChild("leaderstats")
	if player then
		stats.Kills.Value += 1000
        ChairEvent:FireClient(player,"ProductAdvise", "+1000 Kills")
		return true
	end
end



local function processReceipt(receiptInfo)
	local userId = receiptInfo.PlayerId
	local productId = receiptInfo.ProductId
	local player = Players:GetPlayerByUserId(userId)
	if player then
		-- Get the handler function associated with the developer product ID and attempt to run it
		local handler = productFunctions[productId]
		local success, result = pcall(handler, receiptInfo, player)
		if success then
			-- The user has received their benefits!
			-- return PurchaseGranted to confirm the transaction.
			return Enum.ProductPurchaseDecision.PurchaseGranted
		else
			warn("Failed to process receipt:", receiptInfo, result)
		end
	end
	return Enum.ProductPurchaseDecision.NotProcessedYet
end

-- Set the callback; this can only be done once by one script on the server!
MarketplaceService.ProcessReceipt = processReceipt