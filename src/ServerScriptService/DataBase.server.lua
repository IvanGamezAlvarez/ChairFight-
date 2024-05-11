local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local KillsData = DataStoreService:GetDataStore("KillsData")
local LevelData = DataStoreService:GetDataStore("LevelData")
local ExpieriencesData = DataStoreService:GetDataStore("ExpieriencesData")

local PlayerDataStoreDonations = DataStoreService:GetDataStore("PlayerDataStoreDonations")
local ChairsData = DataStoreService:GetDataStore("ChairsDataNew")

local RemoteEvents = ReplicatedStorage:FindFirstChild("RemoteEvents") or ReplicatedStorage:WaitForChild("RemoteEvents")
local ChairEvent = RemoteEvents:WaitForChild("ChairEvent")

local function UpdateData (player)
	local PlayerUserId = player.UserId
    local ChairsOfPlayer = {}
    local Success, message = pcall(function()
        ChairsOfPlayer = ChairsData:GetAsync(PlayerUserId)
    end)

    if Success then
		if  ChairsOfPlayer == nil then
			print("empty")
			return
		end
        for _, Chair in pairs(ChairsOfPlayer) do
            print(Chair)
			local Tag = "UnlockIndividualChair"
			ChairEvent:FireClient(player, Tag, Chair)
        end
    else
        wait(5)
        UpdateData()
    end
end





game.Players.PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new("Folder", player)
	leaderstats.Name = "leaderstats"
	local statData = Instance.new("Folder", player)
	statData.Name = "StatsData"
	local PlayerUserId = player.UserId
	local Kills = Instance.new("IntValue", leaderstats)
	Kills.Name = "Kills"
	Kills.Value = KillsData:GetAsync(PlayerUserId)
	local Level = Instance.new("IntValue", leaderstats)
	Level.Name = "Level"
	Level.Value = 1
	Level.Value = LevelData:GetAsync(PlayerUserId)
	if Level.Value == 0 then
		Level.Value = 1
	end
	ChairEvent:FireClient(player,"LevelUp", Level.Value)
	local Experience = Instance.new("IntValue", statData)
	Experience.Name = "Experience"
	Experience.Value = ExpieriencesData:GetAsync(PlayerUserId)		
	ChairEvent:FireClient(player,"AddExpirience", Experience.Value )

	-- local donation = Instance.new("IntValue", leaderstats)
	-- donation.Name = "Donations"
	-- donation.Value = PlayerDataStoreDonations:GetAsync(PlayerUserId)
	UpdateData(player)
end)

game.Players.PlayerRemoving:Connect(function(player)
	local PlayerUserId = player.UserId
	KillsData:SetAsync(PlayerUserId, player.leaderstats.Kills.Value) 
	LevelData:SetAsync(PlayerUserId, player.leaderstats.Level.Value)
	--PlayerDataStoreDonations:SetAsync(PlayerUserId, player.leaderstats.Donations.Value) 
end)

ChairEvent.OnServerEvent:Connect(function(player, tag, Value1)
	local PlayerUserId = player.UserId
	if tag == "UnlockChair" then
		print(Value1)
		local ChairsOfPlayer = {}
		local Success, message = pcall(function()
			ChairsOfPlayer = ChairsData:GetAsync(PlayerUserId)
		end)
		if Success then
			if ChairsOfPlayer == nil then
				ChairsOfPlayer = {}
			end
			print(ChairsOfPlayer)
			--for _,v in pairs() do
				
			--end
			table.insert(ChairsOfPlayer, Value1)
			ChairsData:SetAsync(PlayerUserId, ChairsOfPlayer)
			print("Data guardada creo")
		end
	end
end)



