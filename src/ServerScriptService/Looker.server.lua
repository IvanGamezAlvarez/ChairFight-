local Masteer = workspace:WaitForChild("Masteer")
local Head = Masteer:WaitForChild("Head")-- Referencia al objeto Part1
local Hat = Masteer:WaitForChild("Hat").Handle
local PlayerToLook = game.Workspace:WaitForChild("HeroNobleDeveloper") -- Referencia al objeto Part2

-- Función para hacer que un objeto mire hacia otro
local function lookAt(targetPosition)
    local lookVector = (targetPosition - Head.Position).unit
    local rotation = CFrame.new(Head.Position, Head.Position + Vector3.new(lookVector.X, lookVector.Y, lookVector.Z))
    Head.CFrame = rotation
    Hat.CFrame = rotation
end

-- Actualizar la rotación continuamente
while true do
    lookAt(PlayerToLook.HumanoidRootPart.Position)
    wait(0.1) -- Puedes ajustar este valor para cambiar la velocidad de actualización
end