local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

local passesID = {796599875,798246876,801063258,800017028,800073056}  -- Change this to your Pass ID

local function onPlayerAdded(player)
        for _, passID in pairs(passesID) do
            local hasPass = false
		    local success, message = pcall(function()
		    	hasPass = MarketplaceService:UserOwnsGamePassAsync(player.UserId, passID)
		    end)
		    -- If there's an error, issue a warning and exit the function
		    if not success then
		    	warn("Error while checking if player has pass: " .. tostring(message))
		    	return
		    end
		    if hasPass then
                if passID == 796599875 then
                    print("Golden Chair")
                elseif passID == 798246876 then
                    print("Speed")
					local StoreGui = player.PlayerGui.Store
					StoreGui.MultiplySpeed.Visible = false
					player.Backpack.X2Speed.Value = true
                elseif passID == 800073056 then
                    print(" Speed Atack")
					local StoreGui = player.PlayerGui.Store
					StoreGui.MultiplySpeedAtack.Visible = false
					player.Backpack.X2SpeedAttack.Value = true
                elseif passID == 800017028 then
                    print("Damage")
					local StoreGui = player.PlayerGui.Store
					StoreGui.MultiplyDamage.Visible = false
					player.Backpack.X2Damage.Value = true
                elseif passID == 801063258 then
                    print("Health")
					local StoreGui = player.PlayerGui.Store
					StoreGui.MultiplyHealth.Visible = false
					player.Backpack.X2Health.Value = true
                end
		    end
        end
	
end

-- Connect "PlayerAdded" events to the function
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
        print(player)
		onPlayerAdded(player)
	end)
end)