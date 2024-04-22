local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Modules = ReplicatedStorage:WaitForChild("Modules")
local GestoreInventory = require(Modules.GestoreInventory)
local ChairsGenerator = require(Modules.ChairsGenerator)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local GeneralGui = script.Parent.Parent
local LevelGui = GeneralGui:WaitForChild("LevelGui")
local AdviseFrame = LevelGui:WaitForChild("Advise")
local AdviseText = AdviseFrame:WaitForChild("AdviseText")
local LevelFrame = LevelGui:WaitForChild("Level")
local LevelText = LevelFrame:WaitForChild("LevelText")
local XPFrame = LevelGui:WaitForChild("XP")
local XPBar = XPFrame:WaitForChild("Fill")
local waitTimeForAdvise = 3


local RemoteEvents = ReplicatedStorage:FindFirstChild("RemoteEvents") or ReplicatedStorage:WaitForChild("RemoteEvents")
local ChairEvent = RemoteEvents:WaitForChild("ChairEvent")

local leaderstats = LocalPlayer:WaitForChild("leaderstats")
local KillsData = leaderstats:WaitForChild("Kills")
--print("hola mi gente que pasa min gente")


local function AddExpirience(value)
    XPBar.Size = UDim2.new(value/3, 0 ,1,0)
end


local function LevelUp(newLevel)
    LevelText.Text = "Level: " .. newLevel
    XPBar.Size = UDim2.new(0, 0 ,1,0)
end



ChairEvent.OnClientEvent:Connect(function(tag, value)
    if tag == "NotLevel" then 
        print("KKKKKKKk")
        AdviseText = "Not enough level"
        AdviseFrame.Visible = true
        wait(waitTimeForAdvise)
        AdviseFrame.Visible = false
    elseif tag == "LevelUp" then
        LevelUp(value)
    elseif tag == "AddExpirience" then
        AddExpirience(value) 
    end
end)
