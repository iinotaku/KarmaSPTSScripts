local player = game:GetService("Players").LocalPlayer
local screengui = player.PlayerGui:WaitForChild("ScreenGui")
local Combat_FirstPunch = false
local alive = false
player.CharacterAdded:Connect(function(character : Model)
	local hrp = character:WaitForChild("HumanoidRootPart")
		alive = true
	character:WaitForChild("Humanoid").Died:Connect(function()
				alive = false
		game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer({ "Respawn" })
		spawn(function()
			task.wait(4)
			game:GetService("Lighting"):WaitForChild("Blur").Enabled = false
			player.PlayerGui:WaitForChild("IntroGui").Enabled = false
			player.PlayerGui:WaitForChild("ScreenGui").Enabled = true
		end)
	end)
	while alive do
		if game.Players[_G.HuntPlayer].Character:WaitForChild("HumanoidRootPart") and player.Character then
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
			task.wait(0.5)
	end
end)


