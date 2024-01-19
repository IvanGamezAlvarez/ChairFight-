



local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()




local Tool = workspace:WaitForChild("Chair")

-- Función para reproducir la animación
local function playAnimation(animationId)
    local humanoid = Tool.Parent:FindFirstChildOfClass("Humanoid")
    if humanoid then
        local track = humanoid:LoadAnimation(animationId)
        track:Play()
        print("Playing bro")
    end
end




-- Conecta las funciones a los eventos del mouse
local function ActiveChair()
    if Tool then 
    Tool.Activated:Connect(function(mouse)
        
    end)
    end
end


Tool.Equipped:Connect(function(Mouse)
    local holdAnimation = Tool:WaitForChild("Hold")
    local equipedAnimation = Tool:WaitForChild("Eqquiped")
    local actionAnimation = Tool:WaitForChild("Action")
   
    local humanoid = Tool.Parent:FindFirstChildOfClass("Humanoid")
    local track = humanoid:LoadAnimation(equipedAnimation)
    track:Play()
	Mouse.Button1Down:Connect(function()
        print("jala we")
      --  print(holdAnimation.AnimationId)
        playAnimation(holdAnimation)
	end)
    Mouse.Button1Up:Connect(function()
        playAnimation(actionAnimation)
	end)
    Mouse.Button2Down:Connect(function()
    --    playAnimation(holdAnimation)
	end)
end)




game.Players.PlayerAdded:Connect(function(player)
    player.Character.ChildAdded:Connect(function(tool)
        if tool:IsA("Tool") then
            print("Is a chair")
            tool.Equipped:Connect(function()
                print("the tool is equiped" .. tool.Name)
                Tool = tool
                ActiveChair()
            end)
            tool.Unequipped:Connect(function()
                print("Do something")
            end)
        end
    end)
end)