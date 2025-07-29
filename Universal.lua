local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/rsdashman/Syfire-ui-project000138/refs/heads/main/UIlibs/SecretFile'))()
--script zone
local HttpService = game:GetService("HttpService")
local FAVORITOS_FILE = "myFav.txt"
local favoritos = {}

if isfile and isfile(FAVORITOS_FILE) then
    local ok, data = pcall(function()
        return HttpService:JSONDecode(readfile(FAVORITOS_FILE))
    end)
    if ok and type(data) == "table" then
        favoritos = data
    end
end

local function salvarFavoritos()
    if writefile then
        writefile(FAVORITOS_FILE, HttpService:JSONEncode(favoritos))
    end
end


OrionLib.FavoriteEvent.Event:Connect(function(nomeOriginal)
    if not table.find(favoritos, nomeOriginal) then
        table.insert(favoritos, nomeOriginal)
        salvarFavoritos()
        OrionLib:MakeNotification({
            Name = "Favorito salvo!",
            Content = nomeOriginal .. " got added to favs.",
            Time = 2
        })
    else
        OrionLib:MakeNotification({
            Name = "alred saved!",
            Content = nomeOriginal .. " in favorites files.",
            Time = 2
        })
    end
end)












print("V.1.1.30")



local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local tpwalking = false
local tpwalkConnection = nil

--esp//


local ESPEnabled = false
local Highlights = {}

local function highlightCharacter(player)
    if not ESPEnabled then return end
    if player == game.Players.LocalPlayer then return end

    local function applyHighlight(char)
        if not ESPEnabled or not char then return end
        if Highlights[player] then return end

        local highlight = Instance.new("Highlight")
        highlight.Name = "ESP_Highlight"
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0.2
        highlight.Adornee = char
        highlight.Parent = char

        Highlights[player] = highlight
    end

    if player.Character then
        applyHighlight(player.Character)
    end

    player.CharacterAdded:Connect(function(char)
        task.wait(1)
        applyHighlight(char)
    end)
end

local function removeHighlight(player)
    if Highlights[player] then
        Highlights[player]:Destroy()
        Highlights[player] = nil
    end
end

for _, player in pairs(game.Players:GetPlayers()) do
    if player ~= game.Players.LocalPlayer then
        highlightCharacter(player)
    end
end

game.Players.PlayerRemoving:Connect(removeHighlight)



--<esp/>





--script zone/


local Window = OrionLib:MakeWindow({
    Name = "NTRF.VIP",
    SearchBar = {
        Default = "🔍 Search...",
        ClearTextOnFocus = true
    },
    SaveConfig = true,
    ConfigFolder = "OrionConfig",
    IntroEnabled = true,
    IntroText = "Script Hub"
})

local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "link"
})
local MainSection = MainTab:AddSection({
    Name = "Scripts"
})


MainSection:AddButton({
    Name = "s / FLY Universal",
    Callback = function()
loadstring(game:HttpGet("https://gist.githubusercontent.com/rsdashman/b96e031446d5a19d8495043a1c134837/raw/acce3da478a58b6345dace47161ca89b26b5d5c3/gistfile1.txt"))() 
    end
})

MainSection:AddButton({
    Name = "Ctrl+click tp",
    Callback = function()
if _G.WRDClickTeleport == nil then
	_G.WRDClickTeleport = true
	
	local player = game:GetService("Players").LocalPlayer
	local UserInputService = game:GetService("UserInputService")
	 --Wanted to avoid using mouse instance, but UIS^ is very tedious to get mouse hit position
	local mouse = player:GetMouse()

	--Waits until the player's mouse is found
	repeat wait() until mouse
	
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			--Only click teleport if the toggle is enabled
			if _G.WRDClickTeleport and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
				player.Character:MoveTo(Vector3.new(mouse.Hit.x, mouse.Hit.y, mouse.Hit.z)) 
			end
		end
	end)
--Just toggle instead of re-executing the script
else
	_G.WRDClickTeleport = not _G.WRDClickTeleport
	--Notify
	if _G.WRDClickTeleport then
		game.StarterGui:SetCore("SendNotification", {Title="WeAreDevs.net"; Text="Click teleport enabled"; Duration=5;})
	else
		game.StarterGui:SetCore("SendNotification", {Title="WeAreDevs.net"; Text="Click teleport disabled"; Duration=5;})
	end
end
    end
})




local SpeedSlider = MainSection:AddSlider({
    Name = "Walkspeed",
    Min = 16,
    Max = 300,
    Default = 16,
    Increment = 1,
    ValueName = "km/h",
    Color = Color3.fromRGB(0, 255, 0),
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = Value
        end
    end
})

local JumpP = MainSection:AddSlider({
    Name = "Jumpp",
    Min = 50,
    Max = 500,
    Default = 50,
    Increment = 1,
    ValueName = "H/gh",
    Color = Color3.fromRGB(0, 255, 0),
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = Value
        end
    end
})

MainSection:AddToggle({
    Name = "Infinite Jump",
    Default = false,
    Callback = function(enabled)
        _G.InfJumpEnabled = enabled

        if _G._InfJumpConn then
            _G._InfJumpConn:Disconnect()
            _G._InfJumpConn = nil
        end

        if enabled then
            local UserInputService = game:GetService("UserInputService")
            _G._InfJumpConn = UserInputService.JumpRequest:Connect(function()
                local player = game.Players.LocalPlayer
                if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end
    end
})


MainSection:AddToggle({
    Name = "BEST NoClip",
    Default = false,
    Callback = function(enabled)
        _G.NoClipEnabled = enabled

        -- Parar qualquer loop anterior
        if _G._NoClipLoop then
            _G._NoClipLoop:Disconnect()
            _G._NoClipLoop = nil
        end

        -- Ativar noclip
        if enabled then
            local RunService = game:GetService("RunService")

            _G._NoClipLoop = RunService.Stepped:Connect(function()
                local character = game.Players.LocalPlayer.Character
                if character then
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") and (part.Name == "Head" or part.Name == "Torso" or part.Name == "UpperTorso" or part.Name == "LowerTorso" or part.Name == "HumanoidRootPart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            -- Restaurar colisão
            local character = game.Players.LocalPlayer.Character
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and (part.Name == "Head" or part.Name == "Torso" or part.Name == "UpperTorso" or part.Name == "LowerTorso" or part.Name == "HumanoidRootPart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end
})



MainSection:AddToggle({
    Name = "Fly",
    Default = false,
    Callback = function(enabled)
        _G.FlyEnabled = enabled

        if _G._FlyConn then
            _G._FlyConn:Disconnect()
            _G._FlyConn = nil
        end

        if not enabled then
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.Velocity = Vector3.zero
            end
            return
        end

        local UIS = game:GetService("UserInputService")
        local RunService = game:GetService("RunService")
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")

        local speed = 60
        local flying = true
        local direction = Vector3.zero

        local keysDown = {}

        _G._FlyConn = RunService.RenderStepped:Connect(function()
            if not _G.FlyEnabled then return end

            direction = Vector3.zero
            local cam = workspace.CurrentCamera

            if keysDown["W"] then direction = direction + cam.CFrame.LookVector end
            if keysDown["S"] then direction = direction - cam.CFrame.LookVector end
            if keysDown["A"] then direction = direction - cam.CFrame.RightVector end
            if keysDown["D"] then direction = direction + cam.CFrame.RightVector end
            if keysDown["Space"] then direction = direction + cam.CFrame.UpVector end
            if keysDown["LeftShift"] then direction = direction - cam.CFrame.UpVector end

            if direction.Magnitude > 0 then
                hrp.Velocity = direction.Unit * speed
            else
                hrp.Velocity = Vector3.zero
            end
        end)

        UIS.InputBegan:Connect(function(input, gpe)
            if not gpe then
                keysDown[input.KeyCode.Name] = true
            end
        end)

        UIS.InputEnded:Connect(function(input, gpe)
            if not gpe then
                keysDown[input.KeyCode.Name] = false
            end
        end)
    end
})


MainSection:AddToggle({
    Name = "Feather Touch",
    Default = false,
    Callback = function(enabled)
        _G.FeatherTouch = enabled

        if _G._FeatherLoop then
            _G._FeatherLoop:Disconnect()
            _G._FeatherLoop = nil
        end

        if enabled then
            local RunService = game:GetService("RunService")
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer

            _G._FeatherLoop = RunService.RenderStepped:Connect(function()
                local myChar = LocalPlayer.Character
                local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
                if not myHRP then return end

                -- Procurar o jogador mais próximo
                local closestDistance = math.huge
                local closestHRP = nil

                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local targetHRP = player.Character.HumanoidRootPart
                        local dist = (targetHRP.Position - myHRP.Position).Magnitude
                        if dist < closestDistance then
                            closestDistance = dist
                            closestHRP = targetHRP
                        end
                    end
                end

                if closestHRP then
                    local offset = -closestHRP.CFrame.LookVector * 2 -- distância atrás
                    local targetPos = closestHRP.Position + offset + Vector3.new(0, 1.2, 0) -- levemente acima
                    myHRP.CFrame = CFrame.new(targetPos, closestHRP.Position)
                end
            end)
        end
    end
})



MainSection:AddToggle({
    Name = "to stick",
    Default = false,
    Callback = function(enabled)
        _G.FeatherTouch = enabled

        if _G._FeatherLoop then
            _G._FeatherLoop:Disconnect()
            _G._FeatherLoop = nil
        end

        if enabled then
            local RunService = game:GetService("RunService")
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer

            _G._FeatherLoop = RunService.RenderStepped:Connect(function()
                local myChar = LocalPlayer.Character
                local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
                if not myHRP then return end

                -- Procurar o jogador mais próximo
                local closestDistance = math.huge
                local closestHRP = nil

                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local targetHRP = player.Character.HumanoidRootPart
                        local dist = (targetHRP.Position - myHRP.Position).Magnitude
                        if dist < closestDistance then
                            closestDistance = dist
                            closestHRP = targetHRP
                        end
                    end
                end

                if closestHRP then
                    local offset = -closestHRP.CFrame.LookVector * 1 -- distância atrás
                    local targetPos = closestHRP.Position + offset + Vector3.new(0, 0, 0) -- levemente acima
                    myHRP.CFrame = CFrame.new(targetPos, closestHRP.Position)
                end
            end)
        end
    end
})





MainSection:AddToggle({
    Name = "ESP",
    Default = false,
    Callback = function(enabled)
	 ESPEnabled = Value
        if ESPEnabled then
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer then
                    highlightCharacter(player)
                end
            end
        else
            for _, v in pairs(Highlights) do
                v:Destroy()
            end
            Highlights = {}
        end
    end
})


MainSection:AddToggle({
    Name = "X-Ray Mode",
    Default = false,
    Callback = function(enabled)
        _G.XRay = enabled

        local function setTransparency(object, transparency)
            for _, v in pairs(object:GetDescendants()) do
                if v:IsA("BasePart") and not v:IsDescendantOf(game.Players.LocalPlayer.Character) then
                    v.LocalTransparencyModifier = transparency
                end
            end
        end

        if enabled then
            spawn(function()
                while _G.XRay do
                    setTransparency(workspace, 0.7)
                    wait(1)
                end
            end)
        else
            
            setTransparency(workspace, 0)
        end
    end
})





local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

local spinning = false
local spinSpeed = 0
local spinConnection

MainSection:AddSlider({
    Name = "Spin",
    Min = 0,
    Max = 999,
    Default = 0,
    Increment = 1,
    ValueName = "Speed",
    Callback = function(value)
        spinSpeed = value

        if spinSpeed > 0 and not spinning then
            spinning = true
            spinConnection = RunService.RenderStepped:Connect(function(dt)
                if character and rootPart then
                    rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0)
                end
            end)
        elseif spinSpeed == 0 and spinning then
            spinning = false
            if spinConnection then
                spinConnection:Disconnect()
                spinConnection = nil
            end
        end
    end
})

--//////////////////////////////////////////////






































local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = game.Players.LocalPlayer

local airwalkPlatform = Instance.new("Part")
airwalkPlatform.Anchored = true
airwalkPlatform.Size = Vector3.new(5, 1, 5)
airwalkPlatform.Transparency = 1
airwalkPlatform.CanCollide = false
airwalkPlatform.Parent = workspace

local airwalkEnabled = false
local airwalkY = 0
local airwalkSpeed = 5
local keyUp = false
local keyDown = false
local airwalkConnection

-- Input handlers
UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Space then
		keyUp = true
	elseif input.KeyCode == Enum.KeyCode.LeftShift then
		keyDown = true
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Space then
		keyUp = false
	elseif input.KeyCode == Enum.KeyCode.LeftShift then
		keyDown = false
	end
end)

-- Start/stop functions
local function startAirWalk()
	local character = player.Character or player.CharacterAdded:Wait()
	local rootPart = character:WaitForChild("HumanoidRootPart")
	airwalkY = rootPart.Position.Y - 3
	airwalkEnabled = true
	airwalkPlatform.CanCollide = true

	airwalkConnection = RunService.RenderStepped:Connect(function(dt)
		if not airwalkEnabled then return end
		if keyUp then airwalkY += airwalkSpeed * dt end
		if keyDown then airwalkY -= airwalkSpeed * dt end

		local char = player.Character
		if char and char:FindFirstChild("HumanoidRootPart") then
			local root = char.HumanoidRootPart
			airwalkPlatform.Position = Vector3.new(root.Position.X, airwalkY, root.Position.Z)
		end
	end)
end

local function stopAirWalk()
	airwalkEnabled = false
	airwalkPlatform.CanCollide = false
	airwalkPlatform.Position = Vector3.new(0, -1000, 0)
	if airwalkConnection then
		airwalkConnection:Disconnect()
		airwalkConnection = nil
	end
end

-- Toggle
MainSection:AddToggle({
	Name = "Air Walk V2",
	Default = false,
	Callback = function(v)
		if v then
			startAirWalk()
		else
			stopAirWalk()
		end
	end
})

-- Slider de velocidade
MainSection:AddSlider({
	Name = "AirWalk V2 Speed",
	Min = -10,
	Max = 25,
	Default = 5,
	Increment = 1,
	ValueName = "stud/s",
	Callback = function(value)
		airwalkSpeed = value
	end
})





local TpwalkToggle = MainTab:AddToggle({
	Name = "Tpwalk",
	Default = false,
	Callback = function(Value)
		tpwalking = Value
		
		if Value then
			-- Start tpwalk
			local chr = LocalPlayer.Character
			local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
			
			if chr and hum then
				tpwalkConnection = RunService.Heartbeat:Connect(function(delta)
					if tpwalking and chr and hum and hum.Parent then
						if hum.MoveDirection.Magnitude > 0 then
							chr:TranslateBy(hum.MoveDirection * delta * 10)
						end
					end
				end)
			end
		else
			-- Stop tpwalk
			if tpwalkConnection then
				tpwalkConnection:Disconnect()
				tpwalkConnection = nil
			end
		end
	end
})

-- Speed Slider
local SpeedSlider = MainTab:AddSlider({
	Name = "Tpwalk Speed",
	Min = 1,
	Max = 200,
	Default = 16,
	Increment = 1,
	ValueName = "Speed",
	Callback = function(Value)
		-- Update speed if tpwalk is active
		if tpwalking and tpwalkConnection then
			tpwalkConnection:Disconnect()
			
			local chr = LocalPlayer.Character
			local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
			
			if chr and hum then
				tpwalkConnection = RunService.Heartbeat:Connect(function(delta)
					if tpwalking and chr and hum and hum.Parent then
						if hum.MoveDirection.Magnitude > 0 then
							chr:TranslateBy(hum.MoveDirection * delta * Value)
						end
					end
				end)
			end
		end
	end
})












































-----/////////////////////////////////////////////////////////////
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local camera = workspace.CurrentCamera
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local mouse = localPlayer:GetMouse()

local AimbotEnabled = false
local HoldingRightClick = false
local AimbotFOV = 250
local AimPart = "Head"

-- Função para pegar o jogador mais próximo do mouse
local function GetClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = AimbotFOV

    for _, player in pairs(players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild(AimPart) and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local part = player.Character[AimPart]
            local pos, onScreen = camera:WorldToViewportPoint(part.Position)
            if onScreen then
                local dist = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
                if dist < shortestDistance then
                    shortestDistance = dist
                    closestPlayer = part
                end
            end
        end
    end

    return closestPlayer
end

-- Mover a câmera suavemente para o alvo
RunService.RenderStepped:Connect(function()
    if AimbotEnabled and HoldingRightClick then
        local target = GetClosestPlayer()
        if target then
            camera.CFrame = CFrame.new(camera.CFrame.Position, target.Position)
        end
    end
end)

-- Detecta quando botão direito é segurado
UIS.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        HoldingRightClick = true
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        HoldingRightClick = false
    end
end)

-- Toggle Orion Lib
MainSection:AddToggle({
    Name = "Aimbot (right button)",
    Default = false,
    Callback = function(enabled)
        AimbotEnabled = enabled
    end
})



local ESPEnabled = false
local ESPObjects = {}
local camera = workspace.CurrentCamera
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer

-- ESP Functions
local function CreateESP(player)
    if player == localPlayer then return end
    if ESPObjects[player] then return end

    local text = Drawing.new("Text")
    text.Size = 14
    text.Center = true
    text.Outline = true
    text.Color = Color3.new(1, 0, 0)
    text.Visible = false

    ESPObjects[player] = text
end

local function RemoveESP(player)
    if ESPObjects[player] then
        ESPObjects[player]:Remove()
        ESPObjects[player] = nil
    end
end

for _, p in ipairs(players:GetPlayers()) do
    CreateESP(p)
end

players.PlayerAdded:Connect(CreateESP)
players.PlayerRemoving:Connect(RemoveESP)

game:GetService("RunService").RenderStepped:Connect(function()
    if not ESPEnabled then
        for _, esp in pairs(ESPObjects) do
            esp.Visible = false
        end
        return
    end

    for player, esp in pairs(ESPObjects) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local pos, onScreen = camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
            if onScreen and player.Character:FindFirstChild("Humanoid").Health > 0 then
                esp.Position = Vector2.new(pos.X, pos.Y - 15)
                esp.Text = player.Name .. " [" .. math.floor(player.Character.Humanoid.Health) .. " HP]"
                esp.Visible = true
            else
                esp.Visible = false
            end
        end
    end
end)

MainSection:AddToggle({
    Name = "ESP (Name + HP)",
    Default = false,
    Callback = function(enabled)
        ESPEnabled = enabled
        if not enabled then
            for _, v in pairs(ESPObjects) do
                v.Visible = false
            end
        end
    end
})











































local MainTab = Window:MakeTab({
    Name = "Tower of hell",
    Icon = "link"
})

-- ===== Example section =====
local MainSection = MainTab:AddSection({
    Name = "Scripts"
})

MainSection:AddButton({
    Name = "Inf Jump",
    Callback = function()
local player = game.Players.LocalPlayer
local gear = game.ReplicatedStorage.Assets.Gear.jump

if gear then
    gear:Clone().Parent = player.Backpack
else
    warn("Gear not found!")
end
    end
})

MainSection:AddButton({
    Name = "idk tp2",
    Callback = function()
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local teleportLocation = game:GetService("Workspace").tower.sections.finish.steps.stop

if teleportLocation then
    character:SetPrimaryPartCFrame(teleportLocation.CFrame)
else
    warn("-----------------")
end
    end
})

MainSection:AddButton({
    Name = "Get all coil",
    Callback = function()

local player = game.Players.LocalPlayer
local gear = game.ReplicatedStorage.Assets.Gear.jump
local gear2 = game.ReplicatedStorage.Assets.Gear.gravity
local gear3 = game.ReplicatedStorage.Assets.Gear.fusion
local gear4 = game.ReplicatedStorage.Assets.Gear.speed

if gear then
    gear:Clone().Parent = player.Backpack
else
    warn("Gear not found!")
end

if gear2 then
    gear2:Clone().Parent = player.Backpack
else
    warn("Gear not found!")
end

if gear3 then
    gear3:Clone().Parent = player.Backpack
else
    warn("Gear not found!")
end

if gear4 then
    gear4:Clone().Parent = player.Backpack
else
    warn("Gear not found!")
end
    
end})

MainSection:AddButton({
    Name = "Tower Of Hell script | no key",
    Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/rsdashman/Syfire-ui-project000138/refs/heads/main/UIlibs/Games/Tower%20of%20hell%20script%20Source"))()
    end
})



local SpeedSlider = MainSection:AddSlider({
    Name = "Walkspeed",
    Min = 16,
    Max = 300,
    Default = 16,
    Increment = 1,
    ValueName = "km/h",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = Value
        end
    end
})

local SpeedSlider = MainSection:AddSlider({
    Name = "JumpPower",
    Min = 50,
    Max = 500,
    Default = 50,
    Increment = 1,
    ValueName = "gh/h",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = Value
        end
    end
})
-------============Tab2=================-----
local MainTab = Window:MakeTab({
    Name = "Admin scripts",
    Icon = "link"
})

local MainSection = MainTab:AddSection({
    Name = "Scripts"
})

MainSection:AddButton({
    Name = "s/ IY",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end
})

MainSection:AddButton({
    Name = "s/ N/A admin",
    Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source'))()
    end
})


--------============Tab3=============-----------------
local MainTab = Window:MakeTab({
    Name = "Grow a gardem",
    Icon = "link"
})
local MainSection = MainTab:AddSection({
    Name = "Scripts"
})

MainSection:AddButton({
    Name = "Soon",
    Callback = function()
print("Soon")
    end
})

----=========Tab4=========----
local MainTab = Window:MakeTab({
    Name = "Esp and aimbot",
    Icon = "link"
})
local MainSection = MainTab:AddSection({
    Name = "Scripts"
})

MainSection:AddButton({
    Name = "Owl hub",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"))();
    end
})

MainSection:AddButton({
    Name = "Open aimbot and esp",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ttwizz/Open-Aimbot/master/source.lua", true))()
    end
})

MainSection:AddButton({
    Name = "Vocano aimbot",
    Callback = function()
loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Volcano-universal-aimbot-36995"))()
    end
})

MainSection:AddButton({
    Name = "Aimbot arena",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rsdashman/RdScript-s/refs/heads/main/TOP%20UNIVERSAL/aimbot%20Arena%20%5Bnot%20mine%5D", true))()
    end
})

MainSection:AddButton({
    Name = "Acc age esp",
    Callback = function()
loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Account-Age-ESP-41401", true))()
    end
})

MainSection:AddButton({
    Name = "Friend esp",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/itsryp/roblox-scripts/main/friendviewer.lua"))()
    end
})

----=========Tab5=========----
local MainTab = Window:MakeTab({
    Name = "Devlopment",
    Icon = "link"
})
local MainSection = MainTab:AddSection({
    Name = "Scripts"
})

MainSection:AddButton({
    Name = "Rspy",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua"))()
    end
})

MainSection:AddButton({
    Name = "Dex Working",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()
    end
})

MainSection:AddButton({
    Name = "Dark dex v3",
    Callback = function()
if game:GetService'CoreGui':FindFirstChild'Dex' then game:GetService'CoreGui'.Dex:Destroy(); end

math.randomseed(tick())

local charset = {} for i = 48, 57 do table.insert(charset, string.char(i)) end for i = 65, 90 do table.insert(charset, string.char(i)) end for i = 97, 122 do table.insert(charset, string.char(i)) end function RandomCharacters(length) if length > 0 then return RandomCharacters(length - 1) .. charset[math.random(1, #charset)] else return "" end end

local Dex = game:GetObjects("rbxassetid://3567096419")[1] Dex.Name = RandomCharacters(math.random(5, 20)) Dex.Parent = game:GetService("CoreGui")

local function Load(Obj, Url) local function GiveOwnGlobals(Func, Script) local Fenv = {} local RealFenv = {script = Script} local FenvMt = {} FenvMt.__index = function(a,b) if RealFenv[b] == nil then return getfenv()[b] else return RealFenv[b] end end FenvMt.__newindex = function(a, b, c) if RealFenv[b] == nil then getfenv()[b] = c else RealFenv[b] = c end end setmetatable(Fenv, FenvMt) setfenv(Func, Fenv) return Func end

local function LoadScripts(Script) if Script.ClassName == "Script" or Script.ClassName == "LocalScript" then spawn(function() GiveOwnGlobals(loadstring(Script.Source, "=" .. Script:GetFullName()), Script)() end) end for i,v in pairs(Script:GetChildren()) do LoadScripts(v) end end

LoadScripts(Obj) end

Load(Dex)
    end
})

MainSection:AddButton({
    Name = "Better Save instance",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rsdashman/Syfire-ui-project000138/refs/heads/main/save%20instance"))()
    end
})

----=========Tab6=========----
local MainTab = Window:MakeTab({
    Name = "Tools",
    Icon = "link"
})
local MainSection = MainTab:AddSection({
    Name = "Scripts"
})

MainSection:AddButton({
    Name = "TPtool",
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/rsdashman/8def4101f93a3bb65779346593442026/raw/fef58863e216ebb3686dcc983a8dd5737bf0fe59/gistfile1.txt"))()
    end
})

MainSection:AddButton({
    Name = "Btools",
    Callback = function()
        loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/BTools.txt"))()
    end
})

MainSection:AddButton({
    Name = "F3X",
    Callback = function()
        loadstring(game:GetObjects("rbxassetid://6695644299")[1].Source)()
    end
})

MainSection:AddButton({
    Name = "Float tool",
    Callback = function()
        local floatTool = Instance.new("Tool")
floatTool.Name = "Float tool"
floatTool.ToolTip = "SKIDED, BIG SORRY :("
floatTool.RequiresHandle = false
floatTool.Parent = game.Players.LocalPlayer.Backpack  -- Assuming the tool goes to the player's backpack

local floatConn, floatBP, floatBG
local baseY = 0
local floatStartTime = 0

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local HRP = character:WaitForChild("HumanoidRootPart")
local RunService = game:GetService("RunService")

floatTool.Equipped:Connect(function(mouse)
    -- Float tool does not force PlatformStand, so movement remains normal.
    baseY = HRP.Position.Y
    floatStartTime = tick()

    floatBP = Instance.new("BodyPosition")
    floatBP.MaxForce = Vector3.new(0, 1e5, 0)
    floatBP.P = 1e4
    floatBP.D = 100
    floatBP.Parent = HRP

    floatBG = Instance.new("BodyGyro")
    floatBG.MaxTorque = Vector3.new(0, 0, 1e5)
    floatBG.P = 1e4
    floatBG.D = 100
    floatBG.Parent = HRP

    floatConn = RunService.RenderStepped:Connect(function(dt)
        local t = tick() - floatStartTime
        local offsetY = math.sin(t * 1) * 2  -- Vertical bobbing
        floatBP.Position = Vector3.new(HRP.Position.X, baseY + offsetY, HRP.Position.Z)

        local rollOsc = math.sin(t * 1) * math.rad(10)  -- Tilt (roll) oscillation
        local _, currentYaw, _ = HRP.CFrame:ToEulerAnglesYXZ()
        floatBG.CFrame = CFrame.Angles(0, currentYaw, rollOsc)
    end)
end)

floatTool.Unequipped:Connect(function()
    if floatConn then
        floatConn:Disconnect()
        floatConn = nil
    end
    if floatBP then
        floatBP:Destroy()
        floatBP = nil
    end
    if floatBG then
        floatBG:Destroy()
        floatBG = nil
    end
    HRP.Velocity = Vector3.new(0, 0, 0)
    HRP.RotVelocity = Vector3.new(0, 0, 0)
end)
    end
})

MainSection:AddButton({
    Name = "Minecraft tools",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Ahma174/Tool/refs/heads/main/Minecraft%20Tools"))()
    end
})

MainSection:AddButton({
    Name = "Bang",
    Callback = function()
        
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Backpack = LocalPlayer.Backpack

local bangTool = Instance.new("Tool")
bangTool.Name = "Bang"
bangTool.ToolTip = "Winter arc of palace fr"
bangTool.RequiresHandle = false
bangTool.Parent = Backpack

local bangOrbiting = false
local bangConn, bangBP, bangBG, bangClickConn
local bangTime = 0
local distanceBehind = 1.2  -- Distance behind target is now 1.2 studs

bangTool.Equipped:Connect(function(mouse)
    -- Enable PlatformStand for Bang tool
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local HRP = character:WaitForChild("HumanoidRootPart")
    
    humanoid.PlatformStand = true
    
    bangClickConn = mouse.Button1Down:Connect(function()
        if bangOrbiting then return end
        local targetPart = mouse.Target
        if targetPart then
            local targetChar = targetPart:FindFirstAncestorOfClass("Model")
            local targetPlayer = targetChar and Players:GetPlayerFromCharacter(targetChar)
            if targetPlayer and targetPlayer ~= LocalPlayer then
                local targetHRP = targetChar:FindFirstChild("HumanoidRootPart") or targetChar:FindFirstChild("Torso")
                if targetHRP then
                    bangOrbiting = true
                    bangTime = 0

                    bangBP = Instance.new("BodyPosition")
                    bangBP.MaxForce = Vector3.new(1e5, 1e5, 1e5)
                    bangBP.P = 1e4
                    bangBP.D = 100
                    bangBP.Parent = HRP

                    bangBG = Instance.new("BodyGyro")
                    bangBG.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
                    bangBG.P = 1e4
                    bangBG.D = 100
                    bangBG.Parent = HRP

                    bangConn = RunService.RenderStepped:Connect(function(dt)
                        if not (targetHRP and targetHRP.Parent) then
                            bangConn:Disconnect()
                            bangOrbiting = false
                            if bangBP then bangBP:Destroy() bangBP = nil end
                            if bangBG then bangBG:Destroy() bangBG = nil end
                            return
                        end

                        bangTime = bangTime + dt
                        local targetPos = targetHRP.Position
                        local targetLook = targetHRP.CFrame.LookVector
                        local desiredPos = targetPos - (targetLook * distanceBehind)
                        bangBP.Position = desiredPos

                        -- More intense oscillation: frequency increased to 8 and amplitude increased to 40°.
                        local frequency = 8
                        local amplitude = math.rad(40)
                        local pitchOsc = math.sin(bangTime * frequency) * amplitude
                        local baseCFrame = CFrame.new(desiredPos, desiredPos + targetLook)
                        bangBG.CFrame = baseCFrame * CFrame.Angles(pitchOsc, 0, 0)
                    end)
                end
            end
        end
    end)
end)

bangTool.Unequipped:Connect(function()
    if bangClickConn then
        bangClickConn:Disconnect()
        bangClickConn = nil
    end
    if bangConn then
        bangConn:Disconnect()
        bangConn = nil
    end
    if bangBP then
        bangBP:Destroy()
        bangBP = nil
    end
    if bangBG then
        bangBG:Destroy()
        bangBG = nil
    end
    bangOrbiting = false

    -- Properly reference the Humanoid and HRP when Unequipped
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local HRP = character:WaitForChild("HumanoidRootPart")
    
    humanoid.PlatformStand = false
    HRP.Velocity = Vector3.new(0, 0, 0)
    HRP.RotVelocity = Vector3.new(0, 0, 0)
end)
    end
})


----=========Tab7=========----
local MainTab = Window:MakeTab({
    Name = "Minigames",
    Icon = "link"
})
local MainSection = MainTab:AddSection({
    Name = "Scripts"
})

MainSection:AddButton({
    Name = "Flappy bird",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/rsdashman/RdScript-s/refs/heads/main/%5Bnot%20mine%5D%20flappy%20bird"))()
    end
})

MainSection:AddButton({
    Name = "Dino game Admin",
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/rsdashman/e80987558087d802d05aebc56eea1029/raw/c6d5bc9e930233e5ac048d12b4705c898af53a0f/gistfile1.txt"))()
    end
})

MainSection:AddButton({
    Name = "Dino game",
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/rsdashman/826a570a68894562bb121eee1d1c0d91/raw/47839dc45d0ffc6c20448880a2ec5a11a4150f73/gistfile1.txt"))()
    end
})

----=========Tab8=========----
local MainTab = Window:MakeTab({
    Name = "Misc",
    Icon = "link"
})
local MainSection = MainTab:AddSection({
    Name = "Scripts"
})

MainSection:AddButton({
    Name = "Hamster ball",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/rsdashman/Syfire-ui-project000138/refs/heads/main/some%20scripts/BallMode"))()
    end
})

MainSection:AddButton({
    Name = "Super ring",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Super-ring-parts-V6-Open-source-No-chat-26899"))()
    end
})

MainSection:AddButton({
    Name = "Fake lag",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Biem6ondo/FAKELAG/refs/heads/main/Fakelag"))()
    end
})

MainSection:AddButton({
    Name = "Face bang",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AKadminlol/Facefuck/refs/heads/main/CreditsbyAK"))()
    end
})

MainSection:AddButton({
    Name = "Orbit player",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/long191910/all-my-roblox-script/refs/heads/main/orbit.lua"))()
    end
})

----=========Tab9=========----
local MainTab = Window:MakeTab({
    Name = "Bang/troll",
    Icon = "link"
})
local MainSection = MainTab:AddSection({
    Name = "Scripts"
})

MainSection:AddButton({
    Name = "s / Jerk",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
    end
})

MainSection:AddButton({
    Name = "s / Face bang",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AKadminlol/Facefuck/refs/heads/main/CreditsbyAK"))()
    end
})

MainSection:AddButton({
    Name = "s / Bang",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/FWwdST5Y"))()
    end
})

MainSection:AddButton({
    Name = "s / Anti-bang",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Anti-Bang-Script-39958"))()
    end
})

----=========Tab10=========----
local MainTab = Window:MakeTab({
    Name = "Survive 99 days",
    Icon = "link"
})
local MainSection = MainTab:AddSection({
    Name = "Scripts"
})

MainSection:AddButton({
    Name = "s / Bring items | no key",
    Callback = function()
local v0=game.Players.LocalPlayer.Character.HumanoidRootPart;local v1=Workspace:FindFirstChild("Items");if  not v1 then return;end for _,Item in v1:GetChildren() do if Item:IsA("PVInstance") then Item:PivotTo(v0.CFrame + Vector3.new((0 -0) -(1422 -(378 + 1044)) ,1427 -((893 -515) + 1044) ,0 -(0 -0) ) );end end
    end
})

MainSection:AddButton({
    Name = "s / H4XScripts | no key",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/H4xScripts/Loader/refs/heads/main/loader.lua", true))()
    end
})

MainSection:AddButton({
    Name = "s / eF Hub | no key",
    Callback = function()
loadstring(game:HttpGet('https://api.exploitingis.fun/loader', true))()
    end
})

MainSection:AddButton({
    Name = "s / Ringta | no key",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/wefwef127382/99daysloader.github.io/refs/heads/main/ringta.lua"))()
    end
})

----=========Tab11=========----
local MainTab = Window:MakeTab({
    Name = "Universals",
    Icon = "link"
})
local MainSection = MainTab:AddSection({
    Name = "Scripts"
})

MainSection:AddButton({
    Name = "s / Orca hub",
    Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/richie0866/orca/master/public/latest.lua"))()
    end
})

MainSection:AddButton({
    Name = "s / Sirius",
    Callback = function()
    loadstring(game:HttpGet('https://sirius.menu/sirius'))()
    end
})

MainSection:AddButton({
    Name = "s / wisl universal",
    Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/wisl884/wisl-i-Universal-Project1/refs/heads/main/Wisl'i%20Universal%20Project%20new%20UI.lua", true))()
    end
})

----=========Tab12=========----
local MainTab = Window:MakeTab({
    Name = "Ink game",
    Icon = "link"
})
local MainSection = MainTab:AddSection({
    Name = "Scripts"
})

MainSection:AddButton({
    Name = "InkGame X-Force | no key / InkGame X-Force | no key",
    Callback = function()
    loadstring(game:HttpGet("https://gist.githubusercontent.com/KevinBak123/62b6c4c59b9583cb9993f81064842a0d/raw/f563ea418e8a948f5eb3382124a93e38806c8097/gistfile1.txt"))()
    end
})

MainSection:AddButton({
    Name = "InkGame Tora | no key / InkGame Tora",
    Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/InkGame"))()
    end
})

MainSection:AddButton({
    Name = "Siff | no key / Siff | no key",
    Callback = function()
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/284c7c5eb4a430a82162018c617e9aa0.lua"))()
    end
})

MainSection:AddButton({
    Name = "Tuff | no key / Tuff | no key",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TuffGuys/TuffGuys/refs/heads/main/Loader"))()
    end
})

----=========Tab13=========----
local MainTab = Window:MakeTab({
    Name = "Squid game season 3",
    Icon = "link"
})
local MainSection = MainTab:AddSection({
    Name = "Scripts"
})

MainSection:AddButton({
    Name = "s / Tora | no key",
    Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/SquidGame3"))()
    end
})

----=========Tab14=========----
local MainTab = Window:MakeTab({
    Name = "Fling scripts",
    Icon = "link"
})
local MainSection = MainTab:AddSection({
    Name = "Scripts"
})

MainSection:AddButton({
    Name = "s / OPTouchFling",
    Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/rsdashman/RdScript-s/refs/heads/main/OP%20TOUCHFLING"))()
    end
})

MainSection:AddButton({
    Name = "s / OldTouchFling",
    Callback = function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Universal-Touch-fling-27515"))()
    end
})

MainSection:AddButton({
    Name = "s / CrashPlayer",
    Callback = function()
    loadstring(game:HttpGet("https://gist.githubusercontent.com/SolentraXminishakk/28e5606b99480adb6f0aa82846e4ff16/raw/03487f4a04364a912ffc93e3987d372b4a98df39/gistfile1.txt"))()
    end
})

----=========Tab15=========----
local MainTab = Window:MakeTab({
    Name = "Brookhaven",
    Icon = "link"
})
local MainSection = MainTab:AddSection({
    Name = "Scripts"
})

MainSection:AddButton({
    Name = "s / Chaos Hub",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Venom-devX/ChaosHub/main/loader.lua"))();
    end
})

----=========Tab16=========----
local MainTab = Window:MakeTab({
    Name = "Steal a brainrot",
    Icon = "link"
})
local MainSection = MainTab:AddSection({
    Name = "Scripts"
})

MainSection:AddButton({
    Name = "s / Steal a Brain rot Hub| no key",
    Callback = function()
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/ffdfeadf0af798741806ea404682a938.lua"))()
    end
})

MainSection:AddButton({
    Name = "s / AV Hub | no key",
    Callback = function()
loadstring(game:HttpGet("https://get-avth-ontop.netlify.app/my-paste/script.lua"))()

    end
})

MainSection:AddButton({
    Name = "s / LunaFyer Hub | Whitelist system",
    Callback = function()
loadstring(game:HttpGet("https://lunafyer.onrender.com/initialize"))()
    end
})

MainSection:AddButton({
    Name = "s / ArbixHub | no key",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Youifpg/Steal-a-Brainrot-op/refs/heads/main/Arbixhub-obfuscated.lua"))()
    end
})

MainSection:AddButton({
    Name = "s / Chilli hub | no key",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()
    end
})

----=========Tab17=========----
local MainTab = Window:MakeTab({
    Name = "Blox fruits",
    Icon = "link"
})
local MainSection = MainTab:AddSection({
    Name = "Scripts"
})

MainSection:AddButton({
    Name = "s / Redz hub",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/Scripts/refs/heads/main/main.luau"))()

    end
})

----=========Tab17=========----
local MainTab = Window:MakeTab({
    Name = "Forsaken",
    Icon = "link"
})
local MainSection = MainTab:AddSection({
    Name = "Scripts"
})

MainSection:AddButton({
    Name = "s / NovaZhub",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/NovaZHub/Yield/main/Forsaken.lua"))()

    end
})

MainSection:AddButton({
    Name = "s / NTRF Hub",
    Callback = function()
loadstring(game:HttpGet("https://github.com/rsdashman/Advanced-Scripthub-kit/raw/refs/heads/main/Games/Forsaken"))()
    end
})

----=========Tab18=========----
local MainTab = Window:MakeTab({
    Name = "FE scripts",
    Icon = "link"
})
local MainSection = MainTab:AddSection({
    Name = "Scripts"
})

MainSection:AddButton({
    Name = "[FE] Jerk off / [FE] Jerk off",
    Callback = function()
loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
    end
})

MainSection:AddButton({
    Name = "[FE] Invisible / [FE] Invisible",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Gon900p/script/refs/heads/main/invisible"))()
    end
})

MainSection:AddButton({
    Name = "[Fe] Laser Arm [PalHair] / [Fe] Laser Arm [PalHair]",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/b07Nxyh0/raw"))()
    end
})

MainSection:AddButton({
    Name = "[FE] BackFlip / [FE] BackFlip",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/rsdashman/RdScript-s/refs/heads/main/FE-Backflip"))()
    end
})

----=========Tab19=========----
local MainTab = Window:MakeTab({
    Name = "mm2",
    Icon = "link"
})
local MainSection = MainTab:AddSection({
    Name = "Scripts"
})

MainSection:AddButton({
    Name = "Tora hub / Tora isme",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/mm2"))()
    end
})


