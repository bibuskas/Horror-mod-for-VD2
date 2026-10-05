return function()
    local Players = game:GetService("Players")

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

    local function clean(container)
        if not container then return end
        for _, item in ipairs(container:GetChildren()) do
            if item:IsA("Tool") and not ALLOWED[item.Name] then
                item:Destroy()
            end
        end
    end

    local function setupPlayer(player)
        player.CharacterAdded:Connect(function(char)
            clean(char)
            char.ChildAdded:Connect(function(child)
                if child:IsA("Tool") and not ALLOWED[child.Name] then
                    child:Destroy()
                end
            end)

            local backpack = player:FindFirstChild("Backpack")
            if backpack then
                clean(backpack)
                backpack.ChildAdded:Connect(function(child)
                    if child:IsA("Tool") and not ALLOWED[child.Name] then
                        child:Destroy()
                    end
                end)
            end
        end)

        if player.Character then
            clean(player.Character)
            local backpack = player:FindFirstChild("Backpack")
            if backpack then clean(backpack) end
        end
    end

    Players.PlayerAdded:Connect(setupPlayer)
    for _, p in ipairs(Players:GetPlayers()) do
        setupPlayer(p)
    end
