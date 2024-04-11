-- Configuración
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local tweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true, 0) -- Duración de 2 segundos con easing y repetición inversa
local GolpeaAlTopoFolder = workspace:WaitForChild("GolpeaAlTopo")
local holes = GolpeaAlTopoFolder:WaitForChild("Holes") -- Asume que todos los objetos "Hole" están dentro de un objeto llamado "Holes" en el workspace
local TopoFolder = ReplicatedStorage:WaitForChild("TopoFolder")
local objectToClone = TopoFolder:WaitForChild("Skeleton") -- Asegúrate de reemplazar "ObjectToClone" con el nombre real del objeto que quieres clonar

local maxObjects = 3 -- Máximo número de objetos que pueden aparecer al mismo tiempo
local speed = 5 -- Velocidad de movimiento en segundos

while true do

    local randomHole = holes:GetChildren()[math.random(1, #holes:GetChildren())]
    
    -- Verificar cuántos objetos hay en ese Hole
 
        -- Clonar objeto
        local goal = {}
        goal.Position = randomHole.Position + Vector3.new(0, 4, 0)
        local newObject = objectToClone:Clone()
        newObject.Parent = randomHole
        
        -- Posicionar objeto en el punto de spawn
        newObject:MoveTo(randomHole.Position + Vector3.new(0, 0, 0))  
        
        local tween = tweenService:Create(newObject.HumanoidRootPart, tweenInfo, goal)
        
        -- Hacer aparecer el objeto

        --tween:Play()
    wait(4)
        
        --tween:Reverse()
        
    newObject:Destroy()
  
    wait(2)
end