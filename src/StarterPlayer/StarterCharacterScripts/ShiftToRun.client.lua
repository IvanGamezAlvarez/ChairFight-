
--Services
local ContextActionService = game:GetService("ContextActionService")
local ServerStorage = game:GetService("ServerStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")


-- Bindable Events
local BindableEvents = ReplicatedStorage:FindFirstChild("BindableEvents") or ReplicatedStorage:WaitForChild("BindableEvents")
local EnableRunningEvent:BindableEvent = BindableEvents:FindFirstChild("EnableRunningEvent") or BindableEvents:WaitForChild("EnableRunningEvent")


--References
local Vfx = ReplicatedStorage:FindFirstChild("Vfx") or ReplicatedStorage:WaitForChild("Vfx")
local Emisser = Vfx:FindFirstChild("Emisser")

local ParentStepsVFX = Vfx:FindFirstChild("StepsVFX")
local StepsVFX = ParentStepsVFX:FindFirstChild("PE_StepSmoke")
local ParentWalkVFX = Vfx:FindFirstChild("WalkStepsVFX")
local WalkVFX = ParentWalkVFX:FindFirstChild("PE_StepSmoke")

local player = game.Players.LocalPlayer
local character = script.Parent
local humanoid = character:WaitForChild("Humanoid")
local HumanoidRootPart = character:WaitForChild('HumanoidRootPart')
local LeftFoot = character:WaitForChild('LeftFoot')
local camera = game.Workspace.CurrentCamera


--Inputs
local RunKey = Enum.KeyCode.LeftShift 
local SpeedHUD = player.PlayerGui:WaitForChild('SpeedHUD')
local imageLabel = SpeedHUD:FindFirstChild('ImageLabel') or SpeedHUD:WaitForChild('ImageLabel')
imageLabel.ImageRectSize = Vector2.new(256, 170)

--Variables
local DefaultSpeed = humanoid.WalkSpeed
local RunSpeed = 40
local WalkFov = camera.FieldOfView
local RunFov = 80
local TweenDuration = 0.2
local zoomIn = {FieldOfView = RunFov}
local zoomout = {FieldOfView = WalkFov}
local RunningEnabled = true


local ROW_FRAMES = 4
local COLUMN_FRAMES = 4
local FRAME_DELAY = 0.05
local frames = {}

--Particles Set
local Diference =   LeftFoot.CFrame.Y  - HumanoidRootPart.CFrame.Y
local EmisserClone = Emisser:Clone()
local Weld = Instance.new('Weld')
EmisserClone.Parent = workspace
Weld.Parent = EmisserClone
Weld.Part0 = EmisserClone
Weld.Part1 = HumanoidRootPart
Weld.C0 = LeftFoot.CFrame - LeftFoot.CFrame.p - Vector3.new(-0.5,Diference-.3,-.45)
local ParticlesRunClone = StepsVFX:Clone()

ParticlesRunClone.Enabled = false
ParticlesRunClone.Parent = EmisserClone

local ParticlesWalkClone = WalkVFX:Clone()

ParticlesWalkClone.Enabled = false
ParticlesWalkClone.Parent = EmisserClone


for i = 0, ROW_FRAMES-1, 1 do
	for j = 0, COLUMN_FRAMES-1, 1 do
		table.insert(frames, Vector2.new(j, i))
	end
end

function LoopAnimate (isEnabled)
	if not isEnabled then return end

	for _, frame in ipairs(frames) do
		imageLabel.ImageRectOffset = frame * imageLabel.ImageRectSize
		task.wait(FRAME_DELAY)
	end

	LoopAnimate(SpeedHUD.Enabled)
end

function IsWalking()
	return humanoid.MoveDirection.Magnitude > 0
end

local function SetParticles(bool)
	ParticlesRunClone.Enabled = bool
end

humanoid.Running:Connect(function(speed)
	local currentState = humanoid:GetState()
 if speed > 3 and currentState == Enum.HumanoidStateType.Running then
	ParticlesWalkClone.Enabled = true
 else
	ParticlesWalkClone.Enabled = false
 end
end)

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
		SetParticles(true)
		end
	end
	if inputState == Enum.UserInputState.End then
		local currentState = humanoid:GetState()
		humanoid.WalkSpeed = DefaultSpeed
		SpeedHUD.Enabled = false
		SetParticles(false)
		TweenService:Create(camera, TweenInfo.new(TweenDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), zoomout):Play()
	end

end



RunService.Heartbeat:Connect(function()
	local currentState = humanoid:GetState()
	
	if  currentState == Enum.HumanoidStateType.Running and humanoid.WalkSpeed == DefaultSpeed and  character.PrimaryPart.Velocity.Magnitude  > 4  then
			ParticlesWalkClone.Enabled = true
			--SpeedHUD.Enabled = false
		elseif currentState == Enum.HumanoidStateType.Running and humanoid.WalkSpeed == RunSpeed and  character.PrimaryPart.Velocity.Magnitude  > 4 then
			SpeedHUD.Enabled = true
			ParticlesRunClone.Enabled = true
		else
			SpeedHUD.Enabled = false
			ParticlesWalkClone.Enabled = false
			ParticlesRunClone.Enabled = false
	
		end
		
end)


ContextActionService:BindAction("RunButton", MakeThePlayerRun,true, RunKey)
ContextActionService:SetPosition("RunButton", UDim2.new(0.4,0,0.4,0)) 


--ContextActionService:UnbindAction("RunButton")
SpeedHUD:GetPropertyChangedSignal('Enabled'):Connect(function()
	LoopAnimate(SpeedHUD.Enabled)
end)

EnableRunningEvent.Event:Connect(enableRunning)