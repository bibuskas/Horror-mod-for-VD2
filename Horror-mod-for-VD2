return function()
    local ALLOWED = {
        ["Pistol"] = true,
        ["Explosive"] = true,
        ["Detonator"] = true,
        ["Sledgehammer"] = true,
        ["Plank"] = true,
        ["Flashlight"] = true
    }

    local function checkAndClear(player)
        local backpack = player:FindFirstChild("Backpack")
        local UserInputService = game:GetService("UserInputService")
      
        if backpack and not UserInputService.TouchEnabled then
            for _, item in ipairs(backpack:GetChildren()) do
                if not ALLOWED[item.Name] then
                    item:Destroy()
                end
            end
        end
    end

    game.Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function()
            task.wait(0.5)
            checkAndClear(player)
        end)
    end)
end
