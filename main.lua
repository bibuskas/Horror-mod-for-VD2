return function()
    -- Точный список разрешённых предметов из твоего инвентаря:
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

    local function cleanBackpack(backpack)
        if not backpack then return end
        for _, item in ipairs(backpack:GetChildren()) do
            if not ALLOWED[item.Name] then
                item:Destroy()
            end
        end
    end

    local function setupPlayer(player)
        -- Очищаем инвентарь при добавлении предметов
        local function attachBackpackListener(backpack)
            cleanBackpack(backpack)
            backpack.ChildAdded:Connect(function(child)
                task.wait(0.05)
                if not ALLOWED[child.Name] then
                    child:Destroy()
                end
            end)
        end

        player.CharacterAdded:Connect(function()
            local backpack = player:WaitForChild("Backpack", 5)
            if backpack then
                attachBackpackListener(backpack)
            end
        end)

        if player.Character then
            local backpack = player:FindFirstChild("Backpack")
            if backpack then
                attachBackpackListener(backpack)
            end
        end
    end

    game.Players.PlayerAdded:Connect(setupPlayer)
    for _, player in ipairs(game.Players:GetPlayers()) do
        setupPlayer(player)
    end
end
