return function()
    local ALLOWED = {
        ["Unarmed"] = true,
        ["Sledge"] = true,
        ["Pistol"] = true,
        ["Explosive Charge"] = true,
        ["Detonator"] = true,
        ["Plank"] = true,
        ["Lantern"] = true,
        ["Flashlight"] = true
    }

    local function cleanContainer(container)
        if not container then return end
        for _, child in ipairs(container:GetChildren()) do
            if child:IsA("Tool") and not ALLOWED[child.Name] then
                child:Destroy()
            end
        end
    end

    local function setupPlayer(player)
        local function onCharacter(char)
            cleanContainer(char)
            char.ChildAdded:Connect(function(child)
                if child:IsA("Tool") and not ALLOWED[child.Name] then
                    task.defer(function()
                        if child and child.Parent then
                            child:Destroy()
                        end
                    end)
                end
            end)

            local backpack = player:FindFirstChild("Backpack") or player:WaitForChild("Backpack", 5)
            if backpack then
                cleanContainer(backpack)
                backpack.ChildAdded:Connect(function(child)
                    if child:IsA("Tool") and not ALLOWED[child.Name] then
                        task.defer(function()
                            if child and child.Parent then
                                child:Destroy()
                            end
                        end)
                    end
                end)
            end
        end

        player.CharacterAdded:Connect(onCharacter)
        if player.Character then
            onCharacter(player.Character)
        end
    end

    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        setupPlayer(player)
    end
    game:GetService("Players").PlayerAdded:Connect(setupPlayer)
end
