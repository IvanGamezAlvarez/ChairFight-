local Masteer = workspace:WaitForChild("Masteer")
local Head = Masteer:WaitForChild("Head")-- Referencia al objeto Part1
local Hat = Masteer:WaitForChild("Hat").Handle
local PlayerToLook

-- Función para hacer que un objeto mire hacia otro




local function findPlayerWithHighestLevel()
    local highestLevel = 0
    for _, player in ipairs(game.Players:GetPlayers()) do
        local playerStats = player:WaitForChild("leaderstats")
        local level = playerStats:WaitForChild("Level").Value
        if level > highestLevel then
            highestLevel = level
            PlayerToLook = player
        end
    end
end




local function lookAt(targetPosition)
    local lookVector = (targetPosition - Head.Position).unit
    local rotation = CFrame.new(Head.Position, Head.Position + Vector3.new(lookVector.X, lookVector.Y, lookVector.Z))
    Head.CFrame = rotation
    Hat.CFrame = rotation
end
-- Actualizar la rotación continuamente
while true do
    
    findPlayerWithHighestLevel()
    if PlayerToLook== nil then
        print("we cant find a player")
        wait(1)

    else
        lookAt(PlayerToLook.Character.HumanoidRootPart.Position)
        wait(0.1) -- Puedes ajustar este valor para cambiar la velocidad de actualización
    
    end
end