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
local KillAdviceFrame = LevelGui:WaitForChild("KillAdvise")
local KillAdviceText = KillAdviceFrame:WaitForChild("AdviseText")
local ShopAdvise = LevelGui:WaitForChild("ShopAdvise")
local ShopAdviseText = ShopAdvise:WaitForChild("AdviseText")
local LevelAdvise = LevelGui:WaitForChild("LevelUpAdvise")
local LevelAdviseText = LevelAdvise:WaitForChild("AdviseText")


local LevelFrame = LevelGui:WaitForChild("Level")
local LevelText = LevelFrame:WaitForChild("LevelText")
local XPFrame = LevelGui:WaitForChild("XP")
local XPBar = XPFrame:WaitForChild("Fill")
local waitTimeForAdvise = 3


local RemoteEvents = ReplicatedStorage:FindFirstChild("RemoteEvents") or ReplicatedStorage:WaitForChild("RemoteEvents")
local BindableEvents = ReplicatedStorage:FindFirstChild("BindableEvents") or ReplicatedStorage:WaitForChild("BindableEvents")

local ChairEvent = RemoteEvents:WaitForChild("ChairEvent")
local ChairBindable = BindableEvents:WaitForChild("ChairBE")

local leaderstats = LocalPlayer:WaitForChild("leaderstats")
local KillsData = leaderstats:WaitForChild("Kills")


local TweenService = game:GetService("TweenService") 
--print("hola mi gente que pasa min gente")


local function AddExpirience(value)
    XPBar.Size = UDim2.new(value/3, 0 ,1,0)
end


local function LevelUp(newLevel)
    LevelText.Text = "Level: " .. newLevel
    XPBar.Size = UDim2.new(0, 0 ,1,0)
end

local function ShowMessageTween(TextLabel)
    print(TextLabel)
    TextLabel.Visible = true
    TextLabel.Size = UDim2.new(1.5, 0, 1.5, 0)
    TextLabel.TextTransparency = 1
    local popInTween = TweenService:Create(TextLabel,TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size = UDim2.new(1, 0, 1, 0),TextTransparency = 0})
    
    local popOutTween = TweenService:Create(TextLabel,TweenInfo.new(1,Enum.EasingStyle.Exponential,Enum.EasingDirection.Out),{Size = UDim2.new(0, 0, 0, 0),TextTransparency = 1})
    
    popInTween:Play()
    popInTween.Completed:Wait()
    popOutTween:Play()
    popOutTween.Completed:Wait()
    TextLabel.Visible = false
end



ChairEvent.OnClientEvent:Connect(function(tag, value)
    if tag == "NotLevel" then 
        AdviseText.Text = "Not enough level"
        AdviseFrame.Visible = true
        ShowMessageTween(AdviseText)
        
    elseif tag == "LevelUp" then
        LevelUp(value)
        ShowMessageTween(LevelAdviseText)
    elseif tag == "AddExpirience" then
        KillAdviceFrame.Visible = true
        AddExpirience(value) 
        ShowMessageTween(KillAdviceText)
    elseif tag == "ProductAdvise" then
        ShopAdviseText.Text = value
        wait(3)
        ShowMessageTween(ShopAdviseText)
    end
end)

ChairBindable.Event:Connect(function(tag, value)
    if tag == "NotLevel" then 
        print(AdviseText)
        AdviseText.Text = "Not enough level"
        AdviseFrame.Visible = true
        ShowMessageTween(AdviseText)
    end
end)
