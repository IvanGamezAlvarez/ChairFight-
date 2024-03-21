local ButtonMaker = {}
ButtonMaker.__index = ButtonMaker
function ButtonMaker.new(parent)
   local self = setmetatable({}, ButtonMaker)
   self.button = Instance.new("ImageButton", parent)
   return self
end
function ButtonMaker:CreateOutline(parent)
    self.outline = Instance.new("UIStroke", parent)
    self.outline.Thickness = 12
    self.outline.Color = Color3.fromRGB(0, 0, 254)
    return self
end
function ButtonMaker:ActiveOutline(parent)
    if self.outline == nil then
        self:CreateOutline(parent)
    else
        self.outline.Enabled = true
    end 
    return self
end
function ButtonMaker:DesactivateOutline(parent)
    if self.outline == nil then
        self:CreateOutline(parent)
        self.outline.Enabled = false
    else
        self.outline.Enabled = false
    end 
    return self
end
function ButtonMaker:FullSize()
    self.button.Size = UDim2.new(1,0,1,0)
    self.button.BackgroundTransparency = 1
    return self
end
return ButtonMaker