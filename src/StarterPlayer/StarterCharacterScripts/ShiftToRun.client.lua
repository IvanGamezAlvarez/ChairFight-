
--Services
local ContextActionService = game:GetService("ContextActionService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")


-- Bindable Events


--References


local player = game.Players.LocalPlayer
local character = script.Parent
local humanoid = character:WaitForChild("Humanoid")
local HumanoidRootPart = character:WaitForChild('HumanoidRootPart')
local LeftFoot = character:WaitForChild('LeftFoot')
local camera = game.Workspace.CurrentCamera


--Inputs
local RunKey = Enum.KeyCode.LeftShift 

--Variables
local DefaultSpeed = humanoid.WalkSpeed
local RunSpeed = 40
local WalkFov = camera.FieldOfView
local RunFov = 80
local TweenDuration = 0.2
local zoomIn = {FieldOfView = RunFov}
local zoomout = {FieldOfView = WalkFov}
local RunningEnabled = true



--Particles Set




function IsWalking()
	return humanoid.MoveDirection.Magnitude > 0
end



local function enableRunning(value:boolean)
	RunningEnabled = value
end

local function MakeThePlayerRun(actionName, inputState, inputObject)
	if RunningEnabled == false then
		return
	end
	
	if inputState == Enum.UserInputState.Begin then
		local currentState = humanoid:GetState()
		if IsWalking() and currentState ==  Enum.HumanoidStateType.Running  then
		humanoid.WalkSpeed = RunSpeed
		--peedHUD.Enabled = true
		TweenService:Create(camera, TweenInfo.new(TweenDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), zoomIn):Play()
		end
	end
	if inputState == Enum.UserInputState.End then
		local currentState = humanoid:GetState()
		humanoid.WalkSpeed = DefaultSpeed
		TweenService:Create(camera, TweenInfo.new(TweenDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), zoomout):Play()
	end


end
ContextActionService:BindAction("RunButton", MakeThePlayerRun,true, RunKey)
ContextActionService:SetPosition("RunButton", UDim2.new(0.4,0,0.4,0)) 


--ContextActionService:UnbindAction("RunButton")

