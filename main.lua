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
        for _, item in ipairs(container:GetChildren()) do
            if item:IsA("Tool") and not ALLOWED[item.Name] then
                item:Destroy()
            end
        end
    end

    local function setupPlayer(player)
        local function onCharacter(char)
            cleanContainer(char)
            char.ChildAdded:Connect(function(child)
                task.wait(0.05)
                if child:IsA("Tool") and not ALLOWED[child.Name] then
                    child:Destroy()
                end
            end)

            local backpack = player:WaitForChild("Backpack", 5)
            if backpack then
                cleanContainer(backpack)
                backpack.ChildAdded:Connect(function(child)
                    task.wait(0.05)
                    if child:IsA("Tool") and not ALLOWED[child.Name] then
                        child:Destroy()
                    end
                end)
            end
        end

        player.CharacterAdded:Connect(onCharacter)
        if player.Character then
            onCharacter(player.Character)
        end
    end

    game.Players.PlayerAdded:Connect(setupPlayer)
    for _, player in ipairs(game.Players:GetPlayers()) do
        setupPlayer(player)
    end
end
