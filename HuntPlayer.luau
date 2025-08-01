local player = game:GetService("Players").LocalPlayer
local screengui = player.PlayerGui:WaitForChild("ScreenGui")
local Combat_FirstPunch = false
player.CharacterAdded:Connect(function(character : Model)
	local hrp = character:WaitForChild("HumanoidRootPart")
	character:WaitForChild("Humanoid").Died:Connect(function()
		game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer({ "Respawn" })
		spawn(function()
			task.wait(4)
			game:GetService("Lighting"):WaitForChild("Blur").Enabled = false
			player.PlayerGui:WaitForChild("IntroGui").Enabled = false
			player.PlayerGui:WaitForChild("ScreenGui").Enabled = true
		end)
	end)

	while task.wait(0.5) do
		if game.Players[_G.HuntPlayer].Character:WaitForChild("HumanoidRootPart") then
			if not Combat_FirstPunch then
				Combat_FirstPunch = true
				game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer({ "Skill_Punch", "Right" })
			else
				Combat_FirstPunch = false
				game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer({ "Skill_Punch", "Left" })
			end
			if hrp then
				if hrp.CFrame ~= game.Players[_G.HuntPlayer].Character:WaitForChild("HumanoidRootPart").CFrame then
					hrp.CFrame = game.Players[_G.HuntPlayer].Character:WaitForChild("HumanoidRootPart").CFrame
				end
			end
		end
	end
end)
