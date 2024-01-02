local TweenService = game:GetService("TweenService")

local function setTweenInfo(travelTime, tweenRepeats, reversAfterFinish, delayTime)
	if not travelTime then
		travelTime = .01
	end
	if not tweenRepeats then
		tweenRepeats = 0
	end
	if not reversAfterFinish then
		reversAfterFinish = false 
	end
	if not delayTime then
		delayTime = 0
	end
	local tweenInfo = TweenInfo.new(
		travelTime, -- duration
		Enum.EasingStyle.Linear, -- easing style
		Enum.EasingDirection.InOut, -- direction
		tweenRepeats, -- number of repeats
		reversAfterFinish, -- reverses when finished
		delayTime -- delay
	)
	return tweenInfo
end

local module = {}

function module.resetCamera(Camera, Character, OriginalFieldOfView)
	Camera.CameraSubject = Character.Humanoid
	Camera.FieldOfView = OriginalFieldOfView
	Camera.CameraType = Enum.CameraType.Custom
end

function module.focusCamera(Camera, Part)
	Camera.Focus = Part.CFrame
end

function module.changeCameraSubject(Camera, Part)
	Camera.CameraSubject = Part
	Camera.CameraType = Enum.CameraType.Track
end

function module.rotateCamera(Camera, XAngle, YAngle, ZAngle, travelTime)
	Camera.CameraType = Enum.CameraType.Scriptable
	
	local tweenInfo = setTweenInfo(travelTime)
	local goal = {}
	goal.CFrame = Camera.CFrame * CFrame.Angles(math.rad(XAngle), math.rad(YAngle), math.rad(ZAngle))
	local tween = TweenService:Create(Camera, tweenInfo, goal)
	return tween
end

function module.setFielOfView(Camera, fieldOfView)
	Camera.FieldOfView = fieldOfView
end

function module.tweenCamera(Camera, EndPart, travelTime, tweenRepeats, reversAfterFinish, delayTime)
	Camera.CameraType = Enum.CameraType.Scriptable
	local tweenInfo = setTweenInfo(travelTime, tweenRepeats, reversAfterFinish, delayTime)
	local goal = {}
	goal.CFrame = EndPart.CFrame
	local tween = TweenService:Create(Camera, tweenInfo, goal)
	return tween
end

function module.tweenCameraWithAngle(Camera, EndPart, XAngle, YAngle, ZAngle, travelTime, tweenRepeats, reversAfterFinish, delayTime)
	Camera.CameraType = Enum.CameraType.Scriptable
	local tweenInfo = setTweenInfo(travelTime, tweenRepeats, reversAfterFinish, delayTime)
	local goal = {}
	goal.CFrame = EndPart.CFrame * CFrame.Angles(math.rad(XAngle), math.rad(YAngle), math.rad(ZAngle))
	local tween = TweenService:Create(Camera, tweenInfo, goal)
	return tween
end

return module
