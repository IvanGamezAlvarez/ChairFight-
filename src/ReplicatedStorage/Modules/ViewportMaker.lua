local ViewportAvatarmodule = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SourceModels = ReplicatedStorage:WaitForChild("ResourceForModules")
local Modules  = ReplicatedStorage:FindFirstChild("Modules")
local ButtonMaker = require(Modules.ButtonMaker)
ViewportAvatarmodule.__index = ViewportAvatarmodule

local function loadAnimation(AnimId, data)
    local anim = Instance.new('Animation', data.mannequin)
	anim.AnimationId = "rbxassetid://"..AnimId
	local load = data.humanoid:LoadAnimation(anim)
    print("The Animation Is Playing")
	return load
end

function ViewportAvatarmodule.new(Parent, ObjectName, CreateViewport)
    local self = setmetatable({}, ViewportAvatarmodule)
    if CreateViewport then
        self.viewport = Instance.new("ViewportFrame", Parent)
    else
        self.viewport = Parent
    end
    self.WorldModel =  Instance.new("WorldModel", self.viewport)
    self.Object = SourceModels:WaitForChild(ObjectName):Clone()
    self.Object.Parent = self.WorldModel
    self.camera = Instance.new("Camera", self.viewport)
    self:SetCamera(self.Object)
    return self
end
function ViewportAvatarmodule:UpdateModel(newObject)
    self.Object = SourceModels:WaitForChild(newObject):Clone()
    self.Object.Parent = self.WorldModel
    self:SetCamera(self.Object)
    return
end
function ViewportAvatarmodule:SetTouchable ()
    self.ClassButton = ButtonMaker.new(self.viewport)
    self.ClassButton:FullSize()
    return self
end

function ViewportAvatarmodule:SetCamera() 
    self.camera.CameraType = Enum.CameraType.Scriptable
    self.viewport.CurrentCamera = self.camera
    self.camera.CFrame = CFrame.new(self.Object.Handle.Position + Vector3.new(0,2,-5), self.Object.Handle.Position) 
    return self
end

function ViewportAvatarmodule:SetAnimation(AnimationId)
    self.humanoid = self.mannequin:WaitForChild("Humanoid")
    self.AnimationID = AnimationId
    if AnimationId == nil or AnimationId == 0 then
        self.AnimationID = 16601047564
        warn("There is not a Id to load")
    end
    local animationToPlay = loadAnimation(self.AnimationID, self)
    animationToPlay:Play()
    return self
end

return ViewportAvatarmodule