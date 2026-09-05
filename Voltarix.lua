--[[ 
oh my god nigga
hey btw for anyone looking at this CROSSFIRE CANT SCRIPT!!!
the worst convert ive ever done in my life fuccckkk
]]
-- || Start || --

Auth = game:GetService("HttpService"):GenerateGUID(false)
local ls = [[
Auth = script:GetAttribute("Authorization")

function RandomString(Length)
	local Thread = ""
	if type(Length) ~= "number" then
		assert(Length, "'Length' must be a number.")
		return
	elseif type(Thread) ~= "string" then
		assert(Thread, "'Thread' must be a string.")
		return
	end
	for i = 1, Length do
		Thread = Thread.. utf8.char(math.random(0, 10000))
	end
	return Thread
end

local User = owner.Name
local LPlr = game:GetService("Players").LocalPlayer
local Mouse = LPlr:GetMouse()

repeat
	script.Parent = nil
	task.wait()
until script.Parent == nil

function SetProperty(Object, Property, Value)
	pcall(function()
		Object:GetPropertyChangedSignal(Property):Connect(function()
			if Object[Property] ~= Value then
				Object[Property] = Value
			end
		end)
	end)
end

local Mover = {
	CFrame = CFrame.new(0, 30, 0), 
	PotentialCFrame = CFrame.new(0, 0, 0), 
	WalkSpeed = 16, 
	HipHeight = 0, 
	Flying = false, 
	Jumping = false, 
	Running = false, 
}

-- || Camera || --

function FindCam()
	for i, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
		if v:IsA("Actor") and v.Archivable == true and v.Name == "C_Actor" and v:IsDescendantOf(game:GetService("ReplicatedStorage")) and v.PrimaryPart == nil and v:GetAttribute("Camera_Actor") then
			return v
		end
	end
end

if LPlr.Name == User then
	game:GetService("Workspace").CurrentCamera.Archivable = false
	game:GetService("Workspace").CurrentCamera.HeadLocked = true
	game:GetService("Workspace").CurrentCamera.HeadScale = 1
	game:GetService("Workspace").CurrentCamera.VRTiltAndRollEnabled = false
	game:GetService("Workspace").CurrentCamera.CameraSubject = FindCam()
	game:GetService("Workspace").CurrentCamera.CameraType = "Custom"
	SetProperty(game:GetService("Workspace").CurrentCamera, "Archivable", false)
	SetProperty(game:GetService("Workspace").CurrentCamera, "HeadLocked", true)
	SetProperty(game:GetService("Workspace").CurrentCamera, "HeadScale", 1)
	SetProperty(game:GetService("Workspace").CurrentCamera, "VRTiltAndRollEnabled", false)
	SetProperty(game:GetService("Workspace").CurrentCamera, "CameraType", "Custom")
	game:GetService("Workspace").DescendantAdded:Connect(function(v)
		if v:IsA("Camera") and v ~= nil then
			v.Archivable = false
			v.HeadLocked = true
			v.HeadScale = 1
			v.VRTiltAndRollEnabled = false
			v.CameraSubject = FindCam()
			v.CameraType = "Custom"
			SetProperty(v, "Archivable", false)
			SetProperty(v, "HeadLocked", true)
			SetProperty(v, "HeadScale", 1)
			SetProperty(v, "VRTiltAndRollEnabled", false)
			SetProperty(v, "CameraType", "Custom")
		end
	end)
end

-- || Artificial Heartbeat || --

local ArtificialHB = Instance.new("BindableEvent")
ArtificialHB.Name = RandomString(math.random(1, 100))
local FPS = 1 / 60
local TF = 0
local Last = tick()
ArtificialHB:Fire()
game:GetService("RunService").Heartbeat:Connect(function(Step)
	TF = TF + Step
	if TF >= FPS then
		local Frames = math.floor(TF / FPS)
		for i = 1, Frames do
			ArtificialHB:Fire()
		end
		Last = tick()
		if Frames > 0 then
			TF = TF - FPS * Frames
		end
	end
end)

function SWait(Number)
	if not Number or Number == 0 then
		ArtificialHB.Event:Wait()
	else
		for i = 1, Number do
			ArtificialHB.Event:Wait()
		end
	end
end

-- || Remote || --

function FindRem()
	for i, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
		if v:IsA("RemoteEvent") and v:GetAttribute("Authorization") == Auth and v:GetAttribute(User) and v.Archivable == false then
			return v
		end
	end
end

-- || Movement || --

function MoveCharacter(X, Y, Z)
	Mover.PotentialCFrame = Mover.PotentialCFrame * CFrame.new(X, Y, Z)
end

function Turn(Position)
	if Mover.Flying then
		Mover.CFrame = CFrame.new(Mover.CFrame.Position, Vector3.new(Position.X, Position.Y, Position.Z)) * CFrame.new(0, 0, 0)
	elseif not Mover.Flying then
		Mover.CFrame = CFrame.new(Mover.CFrame.Position, Vector3.new(Position.X, Mover.CFrame.Position.Y, Position.Z)) * CFrame.new(0, 0, 0)
	end
end

function Clerp(A, B, C)
	return A:Lerp(B, C < math.huge and math.clamp(C * 1, -math.huge, 1) or 1)
end

local Rays = RaycastParams.new()
Rays.FilterType = Enum.RaycastFilterType.Exclude
Rays.BruteForceAllSlow = false
Rays.RespectCanCollide = false
Rays.IgnoreWater = false
Rays.CollisionGroup = "Default" or "None"
Rays.FilterDescendantsInstances = {}

-- || Mouse || --

Mouse.Button1Down:Connect(function()
	if not Mover.Flying then
		pcall(function()
			for i = 1.5, 1.5, 1.5 do
				task.wait()
				Turn(Mouse.Hit.Position)
				FindRem():FireServer("Melee"..Auth)
			end
		end)
	end
end)

Mouse.KeyDown:Connect(function(Key)
	pcall(function()
		FindRem():FireServer("KeyDown"..Auth, tostring(Key))
	end)
	if Key == "r" then
		pcall(function()
			for i = 1.5, 1.5, 1.5 do
				task.wait()
				Turn(Mouse.Hit.Position)
				FindRem():FireServer("Teleportation"..Auth, Mouse.Hit.Position)
				Mover.CFrame = CFrame.new(Mouse.Hit.Position) * CFrame.new(0, 3, 0)
			end
		end)
	elseif Key == "x" then
		if not Mover.Flying then
			pcall(function()
				for i = 1.5, 1.5, 1.5 do
					task.wait()
					Turn(Mouse.Hit.Position)
					FindRem():FireServer("Attack_2"..Auth)
				end
			end)
		end
	elseif Key == "[" then
		Mover.CFrame = CFrame.new(0, 30, 0)
	elseif Key == "f" then
		Mover.Flying = not Mover.Flying
		local LookVector = Mover.CFrame.LookVector
		Mover.CFrame = CFrame.new(Mover.CFrame.Position, Mover.CFrame.Position + Vector3.new(LookVector.X, 0, LookVector.Z))
		Mover.Falling = false
	elseif Key == "0" then
		Mover.Running = true
		if Mover.Running and not Mover.Flying then
			game:GetService("TweenService"):Create(game:GetService("Workspace").CurrentCamera, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0), {FieldOfView = 85}):Play()
		end
		if Mover.Flying then
			game:GetService("TweenService"):Create(game:GetService("Workspace").CurrentCamera, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0), {FieldOfView = 70}):Play()
		end
	elseif Key == "'" then
		game:GetService("Workspace").CurrentCamera:Destroy()
		game:GetService("Workspace").CurrentCamera.CameraSubject = FindCam()
		game:GetService("Workspace").CurrentCamera.CameraType = "Custom"
		game:GetService("Workspace").CurrentCamera.HeadLocked = true
		game:GetService("Workspace").CurrentCamera.HeadScale = 1
		game:GetService("Workspace").CurrentCamera.Archivable = false
		SetProperty(game:GetService("Workspace").CurrentCamera, "Archivable", false)
		SetProperty(game:GetService("Workspace").CurrentCamera, "HeadLocked", true)
		SetProperty(game:GetService("Workspace").CurrentCamera, "HeadScale", 1)
		SetProperty(game:GetService("Workspace").CurrentCamera, "VRTiltAndRollEnabled", false)
		SetProperty(game:GetService("Workspace").CurrentCamera, "CameraType", "Custom")
	end
end)

Mouse.KeyUp:Connect(function(Key)
	pcall(function()
		FindRem():FireServer("KeyUp"..Auth, tostring(Key))
	end)
	if Key == "0" then
		Mover.Running = false
		if not Mover.Running and not Mover.Flying then
			game:GetService("TweenService"):Create(game:GetService("Workspace").CurrentCamera, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0), {FieldOfView = 70}):Play()
		end
		if Mover.Flying then
			game:GetService("TweenService"):Create(game:GetService("Workspace").CurrentCamera, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0), {FieldOfView = 70}):Play()
		end
	end
end)

function KeyDown(Key)
	return game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode[Key]) and game:GetService("UserInputService"):GetFocusedTextBox() == nil
end

-- || Loops || --

task.spawn(function()
	while true do
		SWait()
		if LPlr.Name == User then
			game:GetService("Workspace").CurrentCamera.Archivable = false
			game:GetService("Workspace").CurrentCamera.HeadLocked = true
			game:GetService("Workspace").CurrentCamera.HeadScale = 1
			game:GetService("Workspace").CurrentCamera.VRTiltAndRollEnabled = false
			game:GetService("Workspace").CurrentCamera.CameraSubject = FindCam()
			game:GetService("Workspace").CurrentCamera.CameraType = "Custom"
		end
		if not Mover.Flying and not Mover.Running then
			Mover.WalkSpeed = 16
		elseif not Mover.Flying and Mover.Running then
			Mover.WalkSpeed = 48
		elseif Mover.Flying and not Mover.Running then
			Mover.WalkSpeed = 64
		end
		local OldCFrame = Mover.CFrame
		local LookVector = game:GetService("Workspace").CurrentCamera.CFrame.LookVector
		if not Mover.Flying then
			local CRay = game:GetService("Workspace"):Raycast(Mover.CFrame.Position - Vector3.new(0, -Mover.HipHeight, 0), Vector3.new(0, -9e9, 0), Rays)
			local SRay = game:GetService("Workspace"):Raycast(Mover.CFrame * CFrame.new(1.5, -2.5, 5.75).Position, Vector3.new(0, -1, 0), Rays)
			if CRay then
				Mover.Falling = false
				local NewCFrame = CFrame.new(0, (CRay.Position.Y - Mover.CFrame.Y) + 3, 0) * Mover.CFrame
				Mover.CFrame = Clerp(Mover.CFrame, NewCFrame, 0.1)
				if (Mover.CFrame.Position - NewCFrame.Position).Magnitude > 1 then
					Mover.Falling = true
				end
				if not SRay then
					Mover.Falling = true
				end
			else
				Mover.Falling = true
			end
		end
		if Mover.Flying then
			Mover.PotentialCFrame = CFrame.new(Mover.CFrame.Position, Mover.CFrame.Position + LookVector)
		elseif not Mover.Flying then
			Mover.PotentialCFrame = CFrame.new(Mover.CFrame.Position, Vector3.new(Mover.CFrame.X + LookVector.X, Mover.CFrame.Y, Mover.CFrame.Z + LookVector.Z))
		end
		if KeyDown("W") then
			MoveCharacter(0, 0, -1)
		end
		if KeyDown("A") then
			MoveCharacter(-1, 0, 0)
		end
		if KeyDown("S") then
			MoveCharacter(0, 0, 1)
		end
		if KeyDown("D") then
			MoveCharacter(1, 0, 0)
		end
		if KeyDown("Q") and Mover.Flying then
			MoveCharacter(0, 1, 0)
		end
		if KeyDown("E") and Mover.Flying then
			MoveCharacter(0, -1, 0)
		end
		if KeyDown("Z") then
			pcall(function()
				for i = 1.5, 1.5, 1.5 do
					task.wait()
					Turn(Mouse.Hit.Position)
					FindRem():FireServer("Attack_1"..Auth, Mouse.Hit.Position)
				end
			end)
		end
		if game:GetService("UserInputService").MouseBehavior == Enum.MouseBehavior.LockCenter then
			if Mover.Flying then
				Mover.CFrame = CFrame.new(Mover.CFrame.Position, Mover.CFrame.Position + LookVector)
			elseif not Mover.Flying then
				Mover.CFrame = CFrame.new(Mover.CFrame.Position, Vector3.new(Mover.CFrame.X + LookVector.X, Mover.CFrame.Y, Mover.CFrame.Z + LookVector.Z))
			end
		end
		if (Mover.PotentialCFrame.X ~= OldCFrame.X or Mover.PotentialCFrame.Z ~= OldCFrame.Z) then
			Mover.Walking = true
			Mover.CFrame = CFrame.new(Mover.CFrame.Position, Mover.PotentialCFrame.Position) * CFrame.new(0, 0, -((Mover.WalkSpeed / 60) * 1))
		else
			Mover.Walking = false
		end
		pcall(function()
			FindRem():FireServer("Mover"..Auth, nil, {CFrame = Mover.CFrame, Walking = Mover.Walking, Flying = Mover.Flying, Jumping = Mover.Jumping, HipHeight = Mover.HipHeight, Falling = Mover.Falling, Running = Mover.Running})
		end)
	end
end)

]]

local InsertService = game:GetService("InsertService")

local folder = Instance.new("Folder")
folder.Parent = nil

local config = Instance.new("Configuration")
config.Parent = folder

local mesh1 = InsertService:CreateMeshPartAsync("rbxasset://fonts/head.mesh", Enum.CollisionFidelity.Default, Enum.RenderFidelity.Precise)
mesh1.Name = "Head"
mesh1.Material = Enum.Material.Ice
mesh1.Color = Color3.new(255, 255, 255)
mesh1.Parent = config

local mesh2 = InsertService:CreateMeshPartAsync("rbxasset://fonts/leftarm.mesh", Enum.CollisionFidelity.Default, Enum.RenderFidelity.Precise)
mesh2.Name = "Left Arm"
mesh2.Material = Enum.Material.Ice
mesh2.Color = Color3.new(255, 255, 255)
mesh2.Parent = config

local mesh3 = InsertService:CreateMeshPartAsync("rbxasset://fonts/leftleg.mesh", Enum.CollisionFidelity.Default, Enum.RenderFidelity.Precise)
mesh3.Name = "Left Leg"
mesh3.Material = Enum.Material.Ice
mesh3.Color = Color3.fromRGB(100, 100, 100)
mesh3.Parent = config

local mesh4 = InsertService:CreateMeshPartAsync("rbxasset://fonts/rightarm.mesh", Enum.CollisionFidelity.Default, Enum.RenderFidelity.Precise)
mesh4.Name = "Right Arm"
mesh4.Material = Enum.Material.Ice
mesh4.Color = Color3.new(255, 255, 255)
mesh4.Parent = config

local mesh5 = InsertService:CreateMeshPartAsync("rbxasset://fonts/rightleg.mesh", Enum.CollisionFidelity.Default, Enum.RenderFidelity.Precise)
mesh5.Name = "Right Leg"
mesh5.Material = Enum.Material.Ice
mesh5.Color = Color3.fromRGB(100, 100, 100)
mesh5.Parent = config

local mesh6 = InsertService:CreateMeshPartAsync("rbxassetid://14688273469", Enum.CollisionFidelity.Default, Enum.RenderFidelity.Precise)
mesh6.Name = "Ring"
mesh6.Material = Enum.Material.Foil
mesh6.Color = Color3.fromRGB(0, 255, 155)
mesh6.Parent = config

local mesh7 = InsertService:CreateMeshPartAsync("rbxasset://fonts/torso.mesh", Enum.CollisionFidelity.Default, Enum.RenderFidelity.Precise)
mesh7.Name = "Torso"
mesh7.Material = Enum.Material.Ice
mesh7.Color = Color3.fromRGB(0, 255, 155)
mesh7.Parent = config

local Assets = folder
local SavedAssets = Assets.Configuration:Clone()

local Hypernull = (function()
	return function(Function, ...)
		if not game:GetService("RunService"):IsStudio() then
			local Bindable = Instance.new("BindableFunction")
			Bindable.OnInvoke = function(...)
				if pcall(Bindable.Invoke, Bindable, ...) == false then
					Function()
				end
			end
			if pcall(Bindable.Invoke, Bindable, ...) == false then
				Function()
				return
			end
		end
	end
end)()

function RandomString(Length)
	local Thread = ""
	if type(Length) ~= "number" then
		assert(Length, "'Length' must be a number.")
		return
	elseif type(Thread) ~= "string" then
		assert(Thread, "'Thread' must be a string.")
		return
	end
	for i = 1, Length do
		Thread = Thread.. utf8.char(math.random(0, 10000))
	end
	return Thread
end

local Player = owner

local LocalScript = NLS(ls, Player:FindFirstChildOfClass("PlayerGui") or Player:FindFirstChildOfClass("Backpack"))
LocalScript.Archivable = true
LocalScript:SetAttribute("Authorization", Auth)


function SetProperty(Object, Property, Value)
	pcall(function()
		Object:GetPropertyChangedSignal(Property):Connect(function()
			if Object[Property] ~= Value then
				Object[Property] = Value
			end
		end)
	end)
end

-- || Remote || --

local Rem = Instance.new("RemoteEvent", game:GetService("ReplicatedStorage")) 
Rem.Archivable = false
Rem.Name = RandomString(math.random(1, 100))
Rem:SetAttribute("Authorization", Auth)
Rem:SetAttribute(Player.Name, Player.UserId)


-- || Character || --

local CamPart = Instance.new("Actor")
CamPart.Name = "C_Actor"
CamPart.Archivable = true
CamPart.Parent = game:GetService("ReplicatedStorage")
CamPart.PrimaryPart = nil
CamPart:SetAttribute("Camera_Actor", RandomString(math.random(1, 100)))

local MeshPart = Instance.new("MeshPart")

local SavedMeshPart = MeshPart:Clone()
local SavedCamPart = CamPart:Clone()

local Head = MeshPart:Clone()
Head.CastShadow = true
Head.Color = Color3.fromRGB(255, 255, 255)
Head.Material = "Ice"
Head.Reflectance = 0
Head.TextureID = ""
Head.Transparency = 0
Head.Archivable = false
Head.Locked = true
Head.Name = RandomString(math.random(1, 100))
Head.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
Head.Size = Vector3.new(1.2, 1.2, 1.2)
Head.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
Head.EnableFluidForces = false
Head.CanCollide = false
Head.CanQuery = false
Head.CanTouch = false
Head.CollisionGroup = "None"
Head.Anchored = true
Head.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
Head.Massless = true
Head.RootPriority = 127
Head.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
Head.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
Head:ApplyMesh(SavedAssets["Head"])

local Torso = MeshPart:Clone()
Torso.CastShadow = true
Torso.Color = Color3.fromRGB(0, 255, 155)
Torso.Material = "Ice"
Torso.Reflectance = 0
Torso.TextureID = ""
Torso.Transparency = 0
Torso.Archivable = false
Torso.Locked = true
Torso.Name = RandomString(math.random(1, 100))
Torso.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
Torso.Size = Vector3.new(2, 2, 1)
Torso.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
Torso.EnableFluidForces = false
Torso.CanCollide = false
Torso.CanQuery = false
Torso.CanTouch = false
Torso.CollisionGroup = "None"
Torso.Anchored = true
Torso.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
Torso.Massless = true
Torso.RootPriority = 127
Torso.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
Torso.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
Torso:ApplyMesh(SavedAssets["Torso"])

local RightArm = MeshPart:Clone()
RightArm.CastShadow = true
RightArm.Color = Color3.fromRGB(255, 255, 255)
RightArm.Material = "Ice"
RightArm.Reflectance = 0
RightArm.TextureID = ""
RightArm.Transparency = 0
RightArm.Archivable = false
RightArm.Locked = true
RightArm.Name = RandomString(math.random(1, 100))
RightArm.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
RightArm.Size = Vector3.new(1, 2, 1)
RightArm.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
RightArm.EnableFluidForces = false
RightArm.CanCollide = false
RightArm.CanQuery = false
RightArm.CanTouch = false
RightArm.CollisionGroup = "None"
RightArm.Anchored = true
RightArm.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
RightArm.Massless = true
RightArm.RootPriority = 127
RightArm.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
RightArm.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
RightArm:ApplyMesh(SavedAssets["Right Arm"])

local LeftArm = MeshPart:Clone()
LeftArm.CastShadow = true
LeftArm.Color = Color3.fromRGB(255, 255, 255)
LeftArm.Material = "Ice"
LeftArm.Reflectance = 0
LeftArm.TextureID = ""
LeftArm.Transparency = 0
LeftArm.Archivable = false
LeftArm.Locked = true
LeftArm.Name = RandomString(math.random(1, 100))
LeftArm.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
LeftArm.Size = Vector3.new(1, 2, 1)
LeftArm.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
LeftArm.EnableFluidForces = false
LeftArm.CanCollide = false
LeftArm.CanQuery = false
LeftArm.CanTouch = false
LeftArm.CollisionGroup = "None"
LeftArm.Anchored = true
LeftArm.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
LeftArm.Massless = true
LeftArm.RootPriority = 127
LeftArm.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
LeftArm.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
LeftArm:ApplyMesh(SavedAssets["Left Arm"])

local RightLeg = MeshPart:Clone()
RightLeg.CastShadow = true
RightLeg.Color = Color3.fromRGB(100, 100, 100)
RightLeg.Material = "Ice"
RightLeg.Reflectance = 0
RightLeg.TextureID = ""
RightLeg.Transparency = 0
RightLeg.Archivable = false
RightLeg.Locked = true
RightLeg.Name = RandomString(math.random(1, 100))
RightLeg.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
RightLeg.Size = Vector3.new(1, 2, 1)
RightLeg.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
RightLeg.EnableFluidForces = false
RightLeg.CanCollide = false
RightLeg.CanQuery = false
RightLeg.CanTouch = false
RightLeg.CollisionGroup = "None"
RightLeg.Anchored = true
RightLeg.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
RightLeg.Massless = true
RightLeg.RootPriority = 127
RightLeg.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
RightLeg.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
RightLeg:ApplyMesh(SavedAssets["Right Leg"])

local LeftLeg = MeshPart:Clone()
LeftLeg.CastShadow = true
LeftLeg.Color = Color3.fromRGB(100, 100, 100)
LeftLeg.Material = "Ice"
LeftLeg.Reflectance = 0
LeftLeg.TextureID = ""
LeftLeg.Transparency = 0
LeftLeg.Archivable = false
LeftLeg.Locked = true
LeftLeg.Name = RandomString(math.random(1, 100))
LeftLeg.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
LeftLeg.Size = Vector3.new(1, 2, 1)
LeftLeg.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
LeftLeg.EnableFluidForces = false
LeftLeg.CanCollide = false
LeftLeg.CanQuery = false
LeftLeg.CanTouch = false
LeftLeg.CollisionGroup = "None"
LeftLeg.Anchored = true
LeftLeg.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
LeftLeg.Massless = true
LeftLeg.RootPriority = 127
LeftLeg.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
LeftLeg.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
LeftLeg:ApplyMesh(SavedAssets["Left Leg"])

local Ring = MeshPart:Clone()
Ring.CastShadow = true
Ring.Color = Color3.fromRGB(0, 255, 155)
Ring.Material = "Foil"
Ring.Reflectance = 0
Ring.TextureID = ""
Ring.Transparency = 0
Ring.Archivable = false
Ring.Locked = true
Ring.Name = RandomString(math.random(1, 100))
Ring.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
Ring.Size = Vector3.new(5.5, 5.5, 0.5)
Ring.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
Ring.EnableFluidForces = false
Ring.CanCollide = false
Ring.CanQuery = false
Ring.CanTouch = false
Ring.CollisionGroup = "None"
Ring.Anchored = true
Ring.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
Ring.Massless = true
Ring.RootPriority = 127
Ring.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
Ring.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
Ring:ApplyMesh(SavedAssets["Ring"])

local Effects = Instance.new("WorldModel", game:GetService("Workspace"):FindFirstChildOfClass("Terrain"))
Effects.Archivable = false
Effects.Name = RandomString(math.random(1, 100))
Effects.PrimaryPart = nil

local Attach = Instance.new("Attachment", Ring)
Attach.Visible = false
Attach.Archivable = false
Attach.Name = RandomString(math.random(1, 100))
Attach.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(0))

local Aura = Instance.new("ParticleEmitter", Attach)
Aura.Brightness = 15
Aura.Color = ColorSequence.new(Color3.fromRGB(0, 255, 155))
Aura.LightEmission = 1
Aura.LightInfluence = 0
Aura.Orientation = "VelocityPerpendicular"
Aura.Size = NumberSequence.new(0, 3.6)
Aura.Squash = NumberSequence.new(0, 0)
Aura.Texture = "rbxassetid://8095997435"
Aura.Transparency = NumberSequence.new(0.497, 0.879)
Aura.ZOffset = 0
Aura.Archivable = false
Aura.Name = RandomString(math.random(1, 100))
Aura.EmissionDirection = "Top"
Aura.Enabled = true
Aura.Lifetime = NumberRange.new(1.5, 1.5)
Aura.Rate = 5
Aura.Rotation = NumberRange.new(0, 0)
Aura.RotSpeed = NumberRange.new(-360, 360)
Aura.Speed = NumberRange.new(0.001, 0.001)
Aura.SpreadAngle = Vector2.new(0, 0)
Aura.Shape = "Box"
Aura.ShapeInOut = "Outward"
Aura.ShapeStyle = "Volume"
Aura.FlipbookLayout = "None"
Aura.Acceleration = Vector3.new(0, 0, 0)
Aura.Drag = 0
Aura.LockedToPart = true
Aura.TimeScale = 1
Aura.VelocityInheritance = 0
Aura.WindAffectsDrag = false

-- || Artificial Heartbeat || --

local ArtificialHB = Instance.new("BindableEvent")
ArtificialHB.Name = RandomString(math.random(1, 100))
local FramesPerSecond = 1 / 60
local TimeLapse = 0
ArtificialHB:Fire()
game:GetService("RunService").Heartbeat:Connect(function(Step)
	TimeLapse = TimeLapse + Step
	if TimeLapse >= FramesPerSecond then
		local Frames = math.floor(TimeLapse / FramesPerSecond)
		for i = 1, Frames do
			ArtificialHB:Fire()
		end
		if Frames > 0 then
			TimeLapse = TimeLapse - FramesPerSecond * Frames
		end
	end
end)

function SWait(Number)
	if not Number or Number == 0 then
		ArtificialHB.Event:Wait()
	else
		for i = 1, Number do
			ArtificialHB.Event:Wait()
		end
	end
end

-- || Movement Table || --

local Mover = {
	CFrame = CFrame.new(0, 0, 0), 
	RootPart = {CFrame = CFrame.new(0, 0, 0)}, 
	PotentialCFrame = CFrame.new(0, 0, 0), 
	RC0 = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)), 
	NC0 = CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)), 
	RSC0 = CFrame.new(-.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)), 
	LSC0 = CFrame.new(.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)), 
	HipHeight = 0, 
	Sine = 0, 
	TPos = 0, 
	Counter = 0, 
	Combo = 1, 
	Breaks = {
		7140152455, 
		7140152893, 
	}, 
	Walking = false, 
	Flying = false, 
	Jumping = false, 
	Running = false, 
	Fixing_1 = false, 
	Fixing_2 = false, 
	Attack = false, 
	KillAura = false, 
	Extermination = false, 
	Shapes = {
		"Ball", 
		"Block", 
		"CornerWedge", 
		"Cylinder", 
		"Wedge", 
	}, 
	Table = {}, 
	None = {}, 
	Character = {
		Head, 
		Torso, 
		RightArm, 
		LeftArm, 
		RightLeg, 
		LeftLeg, 
		Ring, 
	}, 
}

-- || Welds || --

Neck = {C0 = Mover.NC0 * CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), math.rad(-180), math.rad(0)), C1 = CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(90), math.rad(-180), math.rad(0))}
RootJoint = {C0 = Mover.RC0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(-180), math.rad(0)), C1 = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(90), math.rad(-180), math.rad(0))}
RightShoulder = {C0 = CFrame.new(1, 0.5, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * Mover.RSC0, C1 = CFrame.new(-0.5, 0.5, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0))}
LeftShoulder = {C0 = CFrame.new(-1, 0.5, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)) * Mover.LSC0, C1 = CFrame.new(0.5, 0.5, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0))}
RightHip = {C0 = CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)), C1 = CFrame.new(0.5, 1, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0))}
LeftHip = {C0 = CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)), C1 = CFrame.new(-0.5, 1, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0))}
RingJoint = {C0 = CFrame.new(0, 0, 1) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), C1 = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))}

function UpdateWeld(Weld, Part1, Part0)
	Part1.CFrame = Part1.CFrame:Lerp(Part0.CFrame * (Weld.C0 * Weld.C1:Inverse()), 1)
end

function Clerp(A, B, C)
	return A:Lerp(B, C < math.huge and math.clamp(C * 1, -math.huge, 1) or 1)
end

local FakeWelds = {{RootJoint, Torso, Mover.RootPart}, {Neck, Head, Torso}, {RightShoulder, RightArm, Torso}, {LeftShoulder, LeftArm, Torso}, {RightHip, RightLeg, Torso}, {LeftHip, LeftLeg, Torso}, {RingJoint, Ring, Torso}}
for i, v in ipairs(FakeWelds) do
	local Weld, Part0, Part1 = unpack(v)
	UpdateWeld(Weld, Part0, Part1)
end

-- || Anti Parenting || --

function AntiParent(Object, Ancestor)
	if Object:IsA("BasePart") then
		task.defer(function()
			pcall(function()
				Hypernull(function()
					if not Object or not Object:IsDescendantOf(Ancestor) then
						pcall(function()
							Object:Destroy()
						end)
						Object.Parent = Ancestor
						coroutine.resume(coroutine.create(function()
							Object.Parent = Ancestor
							if Object.Parent ~= Ancestor then
								Object.Parent = Ancestor
							else
								Object.Parent = Ancestor
								if Object.Parent ~= Ancestor then
									Object.Parent = Ancestor
								else
									Object.Parent = Ancestor
									if Object.Parent ~= Ancestor then
										Object.Parent = Ancestor
									else
										Object.Parent = Ancestor
									end
								end
							end
						end))
						repeat
							task.defer(function()
								Object.Parent = Ancestor
								task.wait()
							end)
						until Object.Parent == Ancestor
					end
				end)
			end)
		end)
	end
end

-- || Refit || --

function Refit_1()
	Mover.Fixing_1 = true
	pcall(function()
		for i, v in ipairs(Mover.Character) do
			if v:IsA("MeshPart") then
				v:Destroy()
			end
		end
		Effects:Destroy()
		Attach:Destroy()
		Aura:Destroy()
	end)
	pcall(function()
		Head = SavedMeshPart:Clone()
		Head.CastShadow = true
		Head.Color = Color3.fromRGB(255, 255, 255)
		Head.Material = "Ice"
		Head.Reflectance = 0
		Head.TextureID = ""
		Head.Transparency = 0
		Head.Archivable = false
		Head.Locked = true
		Head.Name = RandomString(math.random(1, 100))
		Head.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
		Head.Size = Vector3.new(1.2, 1.2, 1.2)
		Head.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
		Head.EnableFluidForces = false
		Head.CanCollide = false
		Head.CanQuery = false
		Head.CanTouch = false
		Head.CollisionGroup = "None"
		Head.Anchored = true
		Head.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
		Head.Massless = true
		Head.RootPriority = 127
		Head.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		Head.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
		Head:ApplyMesh(SavedAssets["Head"])

		Torso = SavedMeshPart:Clone()
		Torso.CastShadow = true
		Torso.Color = Color3.fromRGB(0, 255, 155)
		Torso.Material = "Ice"
		Torso.Reflectance = 0
		Torso.TextureID = ""
		Torso.Transparency = 0
		Torso.Archivable = false
		Torso.Locked = true
		Torso.Name = RandomString(math.random(1, 100))
		Torso.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
		Torso.Size = Vector3.new(2, 2, 1)
		Torso.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
		Torso.EnableFluidForces = false
		Torso.CanCollide = false
		Torso.CanQuery = false
		Torso.CanTouch = false
		Torso.CollisionGroup = "None"
		Torso.Anchored = true
		Torso.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
		Torso.Massless = true
		Torso.RootPriority = 127
		Torso.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		Torso.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
		Torso:ApplyMesh(SavedAssets["Torso"])

		RightArm = SavedMeshPart:Clone()
		RightArm.CastShadow = true
		RightArm.Color = Color3.fromRGB(255, 255, 255)
		RightArm.Material = "Ice"
		RightArm.Reflectance = 0
		RightArm.TextureID = ""
		RightArm.Transparency = 0
		RightArm.Archivable = false
		RightArm.Locked = true
		RightArm.Name = RandomString(math.random(1, 100))
		RightArm.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
		RightArm.Size = Vector3.new(1, 2, 1)
		RightArm.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
		RightArm.EnableFluidForces = false
		RightArm.CanCollide = false
		RightArm.CanQuery = false
		RightArm.CanTouch = false
		RightArm.CollisionGroup = "None"
		RightArm.Anchored = true
		RightArm.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
		RightArm.Massless = true
		RightArm.RootPriority = 127
		RightArm.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		RightArm.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
		RightArm:ApplyMesh(SavedAssets["Right Arm"])

		LeftArm = SavedMeshPart:Clone()
		LeftArm.CastShadow = true
		LeftArm.Color = Color3.fromRGB(255, 255, 255)
		LeftArm.Material = "Ice"
		LeftArm.Reflectance = 0
		LeftArm.TextureID = ""
		LeftArm.Transparency = 0
		LeftArm.Archivable = false
		LeftArm.Locked = true
		LeftArm.Name = RandomString(math.random(1, 100))
		LeftArm.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
		LeftArm.Size = Vector3.new(1, 2, 1)
		LeftArm.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
		LeftArm.EnableFluidForces = false
		LeftArm.CanCollide = false
		LeftArm.CanQuery = false
		LeftArm.CanTouch = false
		LeftArm.CollisionGroup = "None"
		LeftArm.Anchored = true
		LeftArm.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
		LeftArm.Massless = true
		LeftArm.RootPriority = 127
		LeftArm.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		LeftArm.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
		LeftArm:ApplyMesh(SavedAssets["Left Arm"])

		RightLeg = SavedMeshPart:Clone()
		RightLeg.CastShadow = true
		RightLeg.Color = Color3.fromRGB(100, 100, 100)
		RightLeg.Material = "Ice"
		RightLeg.Reflectance = 0
		RightLeg.TextureID = ""
		RightLeg.Transparency = 0
		RightLeg.Archivable = false
		RightLeg.Locked = true
		RightLeg.Name = RandomString(math.random(1, 100))
		RightLeg.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
		RightLeg.Size = Vector3.new(1, 2, 1)
		RightLeg.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
		RightLeg.EnableFluidForces = false
		RightLeg.CanCollide = false
		RightLeg.CanQuery = false
		RightLeg.CanTouch = false
		RightLeg.CollisionGroup = "None"
		RightLeg.Anchored = true
		RightLeg.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
		RightLeg.Massless = true
		RightLeg.RootPriority = 127
		RightLeg.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		RightLeg.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
		RightLeg:ApplyMesh(SavedAssets["Right Leg"])

		LeftLeg = SavedMeshPart:Clone()
		LeftLeg.CastShadow = true
		LeftLeg.Color = Color3.fromRGB(100, 100, 100)
		LeftLeg.Material = "Ice"
		LeftLeg.Reflectance = 0
		LeftLeg.TextureID = ""
		LeftLeg.Transparency = 0
		LeftLeg.Archivable = false
		LeftLeg.Locked = true
		LeftLeg.Name = RandomString(math.random(1, 100))
		LeftLeg.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
		LeftLeg.Size = Vector3.new(1, 2, 1)
		LeftLeg.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
		LeftLeg.EnableFluidForces = false
		LeftLeg.CanCollide = false
		LeftLeg.CanQuery = false
		LeftLeg.CanTouch = false
		LeftLeg.CollisionGroup = "None"
		LeftLeg.Anchored = true
		LeftLeg.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
		LeftLeg.Massless = true
		LeftLeg.RootPriority = 127
		LeftLeg.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		LeftLeg.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
		LeftLeg:ApplyMesh(SavedAssets["Left Leg"])

		Ring = SavedMeshPart:Clone()
		Ring.CastShadow = true
		Ring.Color = Color3.fromRGB(0, 255, 155)
		Ring.Material = "Foil"
		Ring.Reflectance = 0
		Ring.TextureID = ""
		Ring.Transparency = 0
		Ring.Archivable = false
		Ring.Locked = true
		Ring.Name = RandomString(math.random(1, 100))
		Ring.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
		Ring.Size = Vector3.new(5.5, 5.5, 0.5)
		Ring.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
		Ring.EnableFluidForces = false
		Ring.CanCollide = false
		Ring.CanQuery = false
		Ring.CanTouch = false
		Ring.CollisionGroup = "None"
		Ring.Anchored = true
		Ring.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
		Ring.Massless = true
		Ring.RootPriority = 127
		Ring.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		Ring.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
		Ring:ApplyMesh(SavedAssets["Ring"])

		Attach = Instance.new("Attachment", Ring)
		Attach.Visible = false
		Attach.Archivable = false
		Attach.Name = RandomString(math.random(1, 100))
		Attach.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(0))

		Aura = Instance.new("ParticleEmitter", Attach)
		Aura.Brightness = 15
		Aura.Color = ColorSequence.new(Color3.fromRGB(0, 255, 155))
		Aura.LightEmission = 1
		Aura.LightInfluence = 0
		Aura.Orientation = "VelocityPerpendicular"
		Aura.Size = NumberSequence.new(0, 3.6)
		Aura.Squash = NumberSequence.new(0, 0)
		Aura.Texture = "rbxassetid://8095997435"
		Aura.Transparency = NumberSequence.new(0.497, 0.879)
		Aura.ZOffset = 0
		Aura.Archivable = false
		Aura.Name = RandomString(math.random(1, 100))
		Aura.EmissionDirection = "Top"
		Aura.Enabled = true
		Aura.Lifetime = NumberRange.new(1.5, 1.5)
		Aura.Rate = 5
		Aura.Rotation = NumberRange.new(0, 0)
		Aura.RotSpeed = NumberRange.new(-360, 360)
		Aura.Speed = NumberRange.new(0.001, 0.001)
		Aura.SpreadAngle = Vector2.new(0, 0)
		Aura.Shape = "Box"
		Aura.ShapeInOut = "Outward"
		Aura.ShapeStyle = "Volume"
		Aura.FlipbookLayout = "None"
		Aura.Acceleration = Vector3.new(0, 0, 0)
		Aura.Drag = 0
		Aura.LockedToPart = true
		Aura.TimeScale = 1
		Aura.VelocityInheritance = 0
		Aura.WindAffectsDrag = false

		Effects = Instance.new("WorldModel", game:GetService("Workspace"):FindFirstChildOfClass("Terrain"))
		Effects.Archivable = false
		Effects.Name = RandomString(math.random(1, 100))
		Effects.PrimaryPart = nil


		Mover.Character = {
			Head, 
			Torso, 
			RightArm, 
			LeftArm, 
			RightLeg, 
			LeftLeg, 
			Ring, 
		}

		local FakeWelds = {{RootJoint, Torso, Mover.RootPart}, {Neck, Head, Torso}, {RightShoulder, RightArm, Torso}, {LeftShoulder, LeftArm, Torso}, {RightHip, RightLeg, Torso}, {LeftHip, LeftLeg, Torso}, {RingJoint, Ring, Torso}}
		for i, v in ipairs(FakeWelds) do
			local Weld, Part0, Part1 = unpack(v)
			UpdateWeld(Weld, Part0, Part1)
		end

		AntiParent(Head, game:GetService("Workspace"):FindFirstChildOfClass("Terrain"))
		AntiParent(Torso, game:GetService("Workspace"):FindFirstChildOfClass("Terrain"))
		AntiParent(RightArm, game:GetService("Workspace"):FindFirstChildOfClass("Terrain"))
		AntiParent(LeftArm, game:GetService("Workspace"):FindFirstChildOfClass("Terrain"))
		AntiParent(RightLeg, game:GetService("Workspace"):FindFirstChildOfClass("Terrain"))
		AntiParent(LeftLeg, game:GetService("Workspace"):FindFirstChildOfClass("Terrain"))
		AntiParent(Ring, game:GetService("Workspace"):FindFirstChildOfClass("Terrain"))
	end)
	Mover.Fixing_1 = false
end

game:GetService("Workspace"):FindFirstChildOfClass("Terrain").DescendantRemoving:Connect(function(v)
	if not Mover.Fixing_1 then
		task.wait()
		if v == Head or v == Torso or v == RightArm or v == LeftArm or v == RightLeg or v == LeftLeg or v == Ring or v == Attach or v == Aura or v == Effects then
			Refit_1()
		end
	end
end)

function Refit_2()
	Mover.Fixing_2 = true
	pcall(function()
		CamPart:Destroy()
	end)
	pcall(function()
		CamPart = SavedCamPart:Clone()
		CamPart.Archivable = true
		CamPart.Name = "C_Actor"
		CamPart.Parent = game:GetService("ReplicatedStorage")
		CamPart.PrimaryPart = nil
		CamPart:SetAttribute("Camera_Actor", RandomString(math.random(1, 100)))
	end)
	Mover.Fixing_2 = false
end

game:GetService("ReplicatedStorage").DescendantRemoving:Connect(function(v)
	if not Mover.Fixing_2 then
		task.wait()
		if v == CamPart then
			Refit_2()
		end
	end
end)

-- || Functions || --

function SetDestroy(Object, Time)
	task.spawn(function()
		if Time >= 0 then 
			task.wait(Time)
		end
		pcall(function()
			Object:Destroy()
		end)
	end)
end

function SetTween(BasePart, Time, Style, Direction, Repeat, Reverse, Del, Properties)
	local Tween = game:GetService("TweenService")
	local Tweening = Tween:Create(BasePart, TweenInfo.new(Time, Style, Direction, Repeat, Reverse, Del), Properties)
	Tweening:Play()
	return Tween
end

function SetMesh(Parent, MeshId, MeshType, Offset, Scale, TextureId, VertexColor, Usage)
	local Mesh = Instance.new("SpecialMesh", Parent)
	Mesh.Archivable = false
	Mesh.Name = RandomString(math.random(1, 100))
	Mesh.MeshType = MeshType
	Mesh.Offset = Offset
	Mesh.Scale = Scale
	Mesh.VertexColor = VertexColor
	if Usage == true then
		Mesh.MeshId = "rbxassetid://"..tostring(MeshId)
		Mesh.TextureId = "rbxassetid://"..tostring(TextureId)
	elseif Usage == false then
		Mesh.MeshId = ""
		Mesh.TextureId = ""
	end
	return Mesh
end

function SetEffect(Parent, Color, Material, Transparency, Size, CF, Shape, Randomize)
	local Effect = Instance.new("Part", Parent)
	Effect:BreakJoints()
	Effect.Name = RandomString(math.random(1, 100))
	Effect.Color = Color
	Effect.CastShadow = true
	Effect.Material = Material
	Effect.Reflectance = 0
	Effect.Transparency = Transparency
	Effect.Archivable = false
	Effect.Size = Size
	Effect.CFrame = CF
	Effect.Locked = true
	Effect.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
	Effect.EnableFluidForces = false
	Effect.CanCollide = false
	Effect.CanQuery = false
	Effect.CanTouch = false
	Effect.CollisionGroup = "None"
	Effect.Anchored = true
	Effect.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
	Effect.Massless = true
	Effect.RootPriority = 127
	Effect.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
	Effect.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
	--	Effect.Steer = 0
	--	Effect.StickyWheels = false
	--	Effect.Throttle = 0
	Effect.TopSurface = "Smooth"
	Effect.BottomSurface = "Smooth"
	Effect.FrontSurface = "Smooth"
	Effect.BackSurface = "Smooth"
	Effect.RightSurface = "Smooth"
	Effect.LeftSurface = "Smooth"
	if Randomize == true then
		Effect.Shape = Mover.Shapes[math.random(1, #Mover.Shapes)]
	elseif Randomize == false then
		Effect.Shape = Shape
	end
	return Effect
end

function SetSound(Id, Parent, Volume, PlaybackSpeed, Looped)
	local Sound = Instance.new("Sound", Parent)
	Sound.Archivable = false
	Sound.Name = RandomString(math.random(1, 100))
	Sound.PlayOnRemove = false
	Sound.SoundId = "rbxassetid://"..tostring(Id)
	Sound.RollOffMaxDistance = 10000
	Sound.RollOffMinDistance = 10
	Sound.RollOffMode = "Inverse"
	Sound.PlaybackRegionsEnabled = false
	Sound.PlaybackSpeed = PlaybackSpeed
	Sound.Playing = true
	Sound.TimePosition = 0
	Sound.Volume = Volume
	Sound.SoundGroup = nil
	if Looped == true then
		Sound.Looped = true
	else
		task.spawn(function()
			repeat
				task.wait()
			until Sound.Playing == false
			Sound:Destroy()
		end)
	end
	return Sound
end

function SetLightning(Part0, Part1, Offset, Size, Speed)
	local Magz = (Part0 - Part1).Magnitude
	local Curpos = Part0
	local Times = math.floor(math.clamp(Magz / 10, 1, 20))
	local RZone = {-Offset, Offset}
	task.spawn(function()
		for i = 1, Times do
			task.wait()
			local Bolt = SetEffect(nil, Color3.fromRGB(0, 0, 0), "Neon", 1, Vector3.new(0.1 + math.random(-0.5, 0.5), 0.1, Magz / Times), CFrame.new(0, 0, 0), "Block", false)
			local Magzz = (Curpos - Part1).Magnitude
			local Offsets = Vector3.new(RZone[math.random(1, 2)], RZone[math.random(1, 2)], RZone[math.random(1, 2)])
			local Pos = CFrame.new(Curpos, Part1) * CFrame.new(0 + math.random(-1, 2), 0, Magz / Times + math.random(-1, 2)).Position + Offsets
			if Times == i then
				Bolt.Size = Vector3.new(0.1, 0.1, Magzz)
				Bolt.CFrame = CFrame.new(Curpos, Part1) * CFrame.new(0, 0, -Magzz / 2)
			else
				Bolt.CFrame = CFrame.new(Curpos, Pos) * CFrame.new(0, 0, Magz / Times / 2)
			end
			Curpos = Bolt.CFrame * CFrame.new(0, 0, Magz / Times / 2).Position
			local BoltEffect = SetEffect(Effects, Ring.Color, "Neon", 0, Vector3.new(Size, Size, Bolt.Size.Z), Bolt.CFrame * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0 + math.random(-360, 360))), "Block", false)
			SetTween(BoltEffect, 1, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0, {Transparency = 1, Color = Color3.fromRGB(0, 0, 0), Size = Vector3.new(0, 0, Bolt.Size.Z)})
			SetDestroy(BoltEffect, 1)
		end
	end)
end

-- || Chat || --

function Chat(Text)
	local Send = coroutine.wrap(function()
		local function FindBoard()
			pcall(function()
				for i, v in pairs(workspace:GetDescendants()) do
					if v:IsA("BillboardGui") and v:IsDescendantOf(game) then
						if v ~= nil and v:GetAttribute(Player.Name) then
							v:Destroy()
						end
					end
				end
			end)
		end
		FindBoard()
		if string.sub(Text, 1, 8) == "/console" or string.sub(Text, 1, 3) == "/e " or string.sub(Text, 1, 3) == "/w " or string.sub(Text, 1, 3) == "/c " then
			return
		end
		local Board = Instance.new("BillboardGui", game:GetService("Workspace"):FindFirstChildOfClass("Terrain"))
		Board:SetAttribute(Player.Name, Player.UserId)
		Board.Archivable = false
		Board.Adornee = Head
		coroutine.resume(coroutine.create(function()
			while true do
				task.wait()
				Board.Adornee = Head
				task.defer(function()
					Board.Adornee = Head
				end)
			end
		end))
		Board.Brightness = 1
		Board.LightInfluence = 0
		Board.AlwaysOnTop = false
		Board.Name = RandomString(math.random(1, 100))
		Board.Size = UDim2.new(11, 35, 3, 15)
		Board.StudsOffset = Vector3.new(0, 1.5, 0)
		local Label = Instance.new("TextLabel", Board)
		Label.Archivable = false
		Label.RichText = true
		Label.Text = ""
		Label.TextSize = 35
		Label.TextScaled = true
		Label.BorderSizePixel = 1
		Label.Font = "IndieFlower"
		Label.Name = RandomString(math.random(1, 100))
		Label.BackgroundTransparency = 1
		Label.TextStrokeTransparency = 0
		Label.Size = UDim2.new(1, 0, 0.5, 0)
		Label.TextColor3 = Ring.Color
		Label.BorderColor3 = Ring.Color
		Label.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		Label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		Label.TextWrapped = true
		Label.Rotation = 0 + 5 * math.cos(Mover.Sine / 22)
		Label.Position = UDim2.new(0, 0 - 5 * math.cos(Mover.Sine / 22), 0, 0 - 5 * math.sin(Mover.Sine / 22))
		local Gradient = Instance.new("UIGradient", Label)
		Gradient.Archivable = false
		Gradient.Rotation = 90
		Gradient.Enabled = true
		Gradient.Name = RandomString(math.random(1, 100))
		Gradient.Offset = Vector2.new(0, 0)
		Gradient.Transparency = NumberSequence.new(0)
		Gradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(0, 0, 0))
		task.spawn(function()
			while true do
				task.wait()
				Label.TextColor3 = Ring.Color
				Label.BorderColor3 = Ring.Color
				Label.Rotation = 0 + 5 * math.cos(Mover.Sine / 22)
				Label.Font = "IndieFlower"
				Label.Position = UDim2.new(0, 0 - 5 * math.cos(Mover.Sine / 22), 0, 0 - 5 * math.sin(Mover.Sine / 22))
			end
		end)
		for i = 1, #Text do
			task.wait(0.04)
			SetSound(226892749, Torso, 0.5, math.random(8, 15) / 10, false)
			Label.Text = string.sub(Text, 1, i)
		end
		task.wait(2)
		for i = 1, 90 do
			task.wait()
			Label.TextTransparency = i/90
			Label.TextStrokeTransparency = i/90
		end
		task.wait(2)
		pcall(function()
			Board:Destroy()
			Label:Destroy()
			Gradient:Destroy()
		end)
	end)
	Send()
end

Player.Chatted:Connect(function(Msg)
	Chat(Msg)
end)

-- || Effect || --

function SetKillEffect(v)
	pcall(function()
		if v:IsA("BasePart") and not (v == Head or v == Torso or v == RightArm or v == LeftArm or v == RightLeg or v == LeftLeg or v == Ring or v:IsDescendantOf(Effects) or v:IsA("Terrain")) then
			v.Archivable = true
			local v2 = v:Clone()
			v2:BreakJoints()
			v2:ClearAllChildren()
			v2.Parent = Effects
			v2.Name = RandomString(math.random(1, 100))
			v2.Color = Ring.Color
			v2.CastShadow = true
			v2.Material = "Glass"
			v2.Reflectance = 0
			v2.Transparency = 0
			v2.Archivable = false
			v2.Size = v.Size
			v2.CFrame = v.CFrame
			v2.Locked = true
			v2.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
			v2.CanCollide = false
			v2.CanQuery = false
			v2.CanTouch = false
			v2.CollisionGroup = "None"
			v2.Anchored = true
			v2.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
			v2.Massless = true
			v2.RootPriority = 127
			v2.TopSurface = "Smooth"
			v2.BottomSurface = "Smooth"
			v2.FrontSurface = "Smooth"
			v2.BackSurface = "Smooth"
			v2.RightSurface = "Smooth"
			v2.LeftSurface = "Smooth"
			if v2:IsA("MeshPart") then
				v2.TextureID = ""
			elseif v2:IsA("UnionOperation") then
				v2.UsePartColor = true
			end
			SetSound(Mover.Breaks[math.random(1, #Mover.Breaks)], v2, 4, math.random(8, 15) / 10, false)
			SetTween(v2, 3, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0, {Transparency = 1, Size = Vector3.new(0, 0, 0)})
			SetDestroy(v2, 1.5)
			task.spawn(function()
				while true do
					task.wait()
					v2.CFrame = v2.CFrame * CFrame.new(math.random(-1, 1), math.random(-1, 1), math.random(-1, 1)) * CFrame.Angles(math.rad(math.random(-2, 2)), math.rad(math.random(-2, 2)), math.rad(math.random(-2, 2)))
				end
			end)
		end
	end)
end

-- || Damage || --

function _Extermination_(Object)
	if Object:IsA("BasePart") and not (Object == Head or Object == Torso or Object == RightArm or Object == LeftArm or Object == RightLeg or Object == LeftLeg or Object == Ring or Object:IsDescendantOf(Effects) or Object:IsA("Terrain")) then
		if Object then
			SetKillEffect(Object)
			Chat("Shatter, "..Object.Name..".")
		end
		table.insert(Mover.Table, Object.ClassName)
		Object:BreakJoints()
		if not Mover.Extermination then
			task.defer(function()
				Object.Parent = nil
			end)
		elseif Mover.Extermination then
			game:GetService("RunService").Heartbeat:Once(function()
				repeat
					task.defer(function()
						pcall(function()
							Hypernull(function()
								coroutine.resume(coroutine.create(function()
									task.defer(Object.Remove, Object)
									task.defer(Object.remove, Object)
									task.defer(Object.Destroy, Object)
									task.defer(Object.destroy, Object)
									task.defer(Object.ClearAllChildren, Object)
									task.defer(game:GetService("Debris").AddItem, game:GetService("Debris"), Object, 0)
								end))
							end)
						end)
					end)
					task.wait()
				until Object.Parent == nil
			end)
		end
	end
end

function SetAoE(Location, Range)
	for i, v in pairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") and not (v == Head or v == Torso or v == RightArm or v == LeftArm or v == RightLeg or v == LeftLeg or v == Ring or v:IsDescendantOf(Effects) or v:IsA("Terrain")) then
			if v then
				if (v.Position - Location).Magnitude <= Range then
					_Extermination_(v)
				end
			end
		end
	end
end

workspace.DescendantAdded:Connect(function(Base)
	if Base:IsA("BasePart") and not (Base == Head or Base == Torso or Base == RightArm or Base == LeftArm or Base == RightLeg or Base == LeftLeg or Base == Ring or Base:IsDescendantOf(Effects) or Base:IsA("Terrain")) then
		local OldCF = Base.CFrame
		local SavedOldCF = OldCF
		task.spawn(function()
			for i = 1, #Mover.Table do
				if Base.ClassName == Mover.Table[i] then
					Mover.Counter = Mover.Counter + 1
				end
			end
			if Mover.Counter >= 1 then
				table.insert(Mover.Table, Base.ClassName)
				Base:BreakJoints()
				if not Mover.Extermination then
					task.defer(function()
						Base.Parent = nil
					end)
				elseif Mover.Extermination then
					game:GetService("RunService").Heartbeat:Once(function()
						repeat
							task.defer(function()
								pcall(function()
									Hypernull(function()
										coroutine.resume(coroutine.create(function()
											task.defer(Base.Remove, Base)
											task.defer(Base.remove, Base)
											task.defer(Base.Destroy, Base)
											task.defer(Base.destroy, Base)
											task.defer(Base.ClearAllChildren, Base)
											task.defer(game:GetService("Debris").AddItem, game:GetService("Debris"), Base, 0)
										end))
									end)
								end)
							end)
							task.wait()
						until Base.Parent == nil
					end)
				end
			end
		end)
	end
end)

-- || Attacks || --

function Ravage_Ring(Hit)
	Mover.Attack = true
	for i = 0, 0.5, 0.3 / 3 do
		SWait()
		if Mover.Flying then
			RingJoint.C0 = Clerp(RingJoint.C0, CFrame.new(-3.25 - 0.1 * math.cos(Mover.Sine / 22), 0.1 - 0.1 * math.sin(Mover.Sine / 22), -3.35 - 0.1 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(-2 - 2 * math.cos(Mover.Sine / 22)), math.rad(21 - 2 * math.sin(Mover.Sine / 22)), math.rad(0 - 180 * math.sin(Mover.Sine / 12))), 1 / 3)
			RootJoint.C0 = Clerp(RootJoint.C0, Mover.RC0 * CFrame.new(0 - 0.5 * math.cos(Mover.Sine / 22), 0 - 0.5 * math.sin(Mover.Sine / 22), 1.1 - 0.5 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(0 - 5 * math.sin(Mover.Sine / 22)), math.rad(0 - 5 * math.cos(Mover.Sine / 22)), math.rad(-35 + 5 * math.cos(Mover.Sine / 22))), 1 / 3)
			Neck.C0 = Clerp(Neck.C0, Mover.NC0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(5 - 5 * math.cos(Mover.Sine / 22)), math.rad(0 + 5 * math.sin(Mover.Sine / 22)), math.rad(35 - 5 * math.sin(Mover.Sine / 22))), 1 / 3)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.3 + 0.03 * math.cos(Mover.Sine / 22), 0.1) * CFrame.Angles(math.rad(-1 - 5 * math.cos(Mover.Sine / 22)), math.rad(-10 + 5 * math.sin(Mover.Sine / 22)), math.rad(5)) * Mover.RSC0, 1 / 3)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.25 + 0.03 * math.cos(Mover.Sine / 22), -0.35) * CFrame.Angles(math.rad(90 - 5 * math.cos(Mover.Sine / 22)), math.rad(-5 - 5 * math.sin(Mover.Sine / 22)), math.rad(-30 - 5 * math.sin(Mover.Sine / 22))) * Mover.LSC0, 1 / 3)
			RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -0.6 - 0.03 * math.cos(Mover.Sine / 22), -0.25) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * CFrame.Angles(math.rad(-2 - 1.5 * math.cos(Mover.Sine / 22)), math.rad(-15 + 5 * math.sin(Mover.Sine / 22)), math.rad(-5 + 2 * math.cos(Mover.Sine / 22))), 1 / 3)
			LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1 - 0.03 * math.cos(Mover.Sine / 22), 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)) * CFrame.Angles(math.rad(-2.5 - 1.5 * math.cos(Mover.Sine / 22)), math.rad(10 - 5 * math.sin(Mover.Sine / 22)), math.rad(5 - 5 * math.cos(Mover.Sine / 22))), 1 / 3)
		elseif not Mover.Flying then
			RingJoint.C0 = Clerp(RingJoint.C0, CFrame.new(-3.25 - 0.1 * math.cos(Mover.Sine / 22), 0.1 - 0.1 * math.sin(Mover.Sine / 22), -3.35 - 0.1 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(-2 - 2 * math.cos(Mover.Sine / 22)), math.rad(21 - 2 * math.sin(Mover.Sine / 22)), math.rad(0 - 180 * math.sin(Mover.Sine / 12))), 1 / 3)
			RootJoint.C0 = Clerp(RootJoint.C0, Mover.RC0 * CFrame.new(0, 0, 0 + 0.05 * math.cos(Mover.Sine / 22)) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-35)), 1 / 3)
			Neck.C0 = Clerp(Neck.C0, Mover.NC0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(5 - 1 * math.cos(Mover.Sine / 22)), math.rad(0 + 1 * math.sin(Mover.Sine / 22)), math.rad(35 - 1 * math.sin(Mover.Sine / 22))), 1 / 3)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.45 + 0.03 * math.cos(Mover.Sine / 22), 0.1) * CFrame.Angles(math.rad(-1 - 1 * math.cos(Mover.Sine / 22)), math.rad(5 + 1 * math.sin(Mover.Sine / 22)), math.rad(5)) * Mover.RSC0, 1 / 3)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.25 + 0.03 * math.cos(Mover.Sine / 22), -0.35) * CFrame.Angles(math.rad(90 - 1 * math.cos(Mover.Sine / 22)), math.rad(-5 - 1 * math.sin(Mover.Sine / 22)), math.rad(-30 - 1 * math.sin(Mover.Sine / 22))) * Mover.LSC0, 1 / 3)
			RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -1 - 0.01 * math.cos(Mover.Sine / 22), 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * CFrame.Angles(math.rad(-2), math.rad(-15 + 1 * math.cos(Mover.Sine / 22)), math.rad(0)), 1 / 3)
			LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1 - 0.01 * math.cos(Mover.Sine / 22), 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)) * CFrame.Angles(math.rad(-2), math.rad(15 - 1 * math.cos(Mover.Sine / 22)), math.rad(0)), 1 / 3)
		end
	end

	local Effect2 = SetEffect(Effects, Ring.Color, "Neon", 0, Vector3.new(3.5, 3.5, 3.5), Ring.CFrame * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360))), "Ball", false)
	SetSound(9126102562, Effect2, 1, math.random(8, 15) / 10, false)
	SetTween(Effect2, 1.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0, {Transparency = 1, Color = Color3.fromRGB(0, 0, 0), Size = Vector3.new(0, 0, 0)})
	SetDestroy(Effect2, 2.5)

	for i = 0, 0.5, 0.3 / 3 do
		SWait()
		local Effect3 = SetEffect(Effects, Ring.Color, "ForceField", 0, Vector3.new(0.5, 0.5, 0.5), Effect2.CFrame * CFrame.new(math.random(-3, 3), math.random(-2, 2), math.random(-3, 3)) * CFrame.Angles(math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360))), "Ball", false)
		SetTween(Effect3, 1.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0, {Transparency = 1, Color = Color3.fromRGB(0, 0, 0), Size = Vector3.new(0, 0, 0)})
		SetDestroy(Effect3, 1)
		if Mover.Flying then
			RingJoint.C0 = Clerp(RingJoint.C0, CFrame.new(-3.25 - 0.1 * math.cos(Mover.Sine / 22), 0.1 - 0.1 * math.sin(Mover.Sine / 22), -3.35 - 0.1 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(-2 - 2 * math.cos(Mover.Sine / 22)), math.rad(21 - 2 * math.sin(Mover.Sine / 22)), math.rad(0 - 180 * math.sin(Mover.Sine / 12))), 1 / 3)
			RootJoint.C0 = Clerp(RootJoint.C0, Mover.RC0 * CFrame.new(0 - 0.5 * math.cos(Mover.Sine / 22), 0 - 0.5 * math.sin(Mover.Sine / 22), 1.1 - 0.5 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(0 - 5 * math.sin(Mover.Sine / 22)), math.rad(0 - 5 * math.cos(Mover.Sine / 22)), math.rad(-35 + 5 * math.cos(Mover.Sine / 22))), 1 / 3)
			Neck.C0 = Clerp(Neck.C0, Mover.NC0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(5 - 5 * math.cos(Mover.Sine / 22)), math.rad(0 + 5 * math.sin(Mover.Sine / 22)), math.rad(35 - 5 * math.sin(Mover.Sine / 22))), 1 / 3)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.3 + 0.03 * math.cos(Mover.Sine / 22), 0.1) * CFrame.Angles(math.rad(-1 - 5 * math.cos(Mover.Sine / 22)), math.rad(-10 + 5 * math.sin(Mover.Sine / 22)), math.rad(5)) * Mover.RSC0, 1 / 3)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.25 + 0.03 * math.cos(Mover.Sine / 22), -0.35) * CFrame.Angles(math.rad(95 - 5 * math.cos(Mover.Sine / 22)), math.rad(-5 - 5 * math.sin(Mover.Sine / 22)), math.rad(-30 - 5 * math.sin(Mover.Sine / 22))) * Mover.LSC0, 1 / 3)
			RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -0.6 - 0.03 * math.cos(Mover.Sine / 22), -0.25) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * CFrame.Angles(math.rad(-2 - 1.5 * math.cos(Mover.Sine / 22)), math.rad(-15 + 5 * math.sin(Mover.Sine / 22)), math.rad(-5 + 2 * math.cos(Mover.Sine / 22))), 1 / 3)
			LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1 - 0.03 * math.cos(Mover.Sine / 22), 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)) * CFrame.Angles(math.rad(-2.5 - 1.5 * math.cos(Mover.Sine / 22)), math.rad(10 - 5 * math.sin(Mover.Sine / 22)), math.rad(5 - 5 * math.cos(Mover.Sine / 22))), 1 / 3)
		elseif not Mover.Flying then
			RingJoint.C0 = Clerp(RingJoint.C0, CFrame.new(-3.25 - 0.1 * math.cos(Mover.Sine / 22), 0.1 - 0.1 * math.sin(Mover.Sine / 22), -3.35 - 0.1 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(-2 - 2 * math.cos(Mover.Sine / 22)), math.rad(21 - 2 * math.sin(Mover.Sine / 22)), math.rad(0 - 180 * math.sin(Mover.Sine / 12))), 1 / 3)
			RootJoint.C0 = Clerp(RootJoint.C0, Mover.RC0 * CFrame.new(0, 0, 0 + 0.05 * math.cos(Mover.Sine / 22)) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-35)), 1 / 3)
			Neck.C0 = Clerp(Neck.C0, Mover.NC0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(5 - 1 * math.cos(Mover.Sine / 22)), math.rad(0 + 1 * math.sin(Mover.Sine / 22)), math.rad(35 - 1 * math.sin(Mover.Sine / 22))), 1 / 3)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.45 + 0.03 * math.cos(Mover.Sine / 22), 0.1) * CFrame.Angles(math.rad(-1 - 1 * math.cos(Mover.Sine / 22)), math.rad(5 + 1 * math.sin(Mover.Sine / 22)), math.rad(5)) * Mover.RSC0, 1 / 3)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.25 + 0.03 * math.cos(Mover.Sine / 22), -0.35) * CFrame.Angles(math.rad(95 - 1 * math.cos(Mover.Sine / 22)), math.rad(-5 - 1 * math.sin(Mover.Sine / 22)), math.rad(-30 - 1 * math.sin(Mover.Sine / 22))) * Mover.LSC0, 1 / 3)
			RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -1 - 0.01 * math.cos(Mover.Sine / 22), 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * CFrame.Angles(math.rad(-2), math.rad(-15 + 1 * math.cos(Mover.Sine / 22)), math.rad(0)), 1 / 3)
			LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1 - 0.01 * math.cos(Mover.Sine / 22), 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)) * CFrame.Angles(math.rad(-2), math.rad(15 - 1 * math.cos(Mover.Sine / 22)), math.rad(0)), 1 / 3)
		end
	end

	local Effect6 = SetEffect(Effects, Ring.Color, "Neon", 0, Vector3.new(8.5, 8.5, 8.5), CFrame.new(Hit) * CFrame.new(math.random(-3, 3), 0, math.random(-3, 3)) * CFrame.Angles(math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360))), "Ball", false)
	SetSound(7109752018, Effect6, 1, math.random(8, 15) / 10, false)
	SetTween(Effect6, 2.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0, {Transparency = 1, Color = Color3.fromRGB(0, 0, 0), Size = Vector3.new(0, 0, 0)})
	SetDestroy(Effect6, 2)

	SetLightning(Effect2.Position, Effect6.Position, 0, 1.4, 0)

	SetAoE(Effect2.Position, 3)
	SetAoE(Effect6.Position, 8)
	Mover.Attack = false

	for i = 1, 10 do
		local Effect2 = SetEffect(Effects, Ring.Color, "ForceField", 0, Vector3.new(0.5, 0.5, 0.5), Effect6.CFrame * CFrame.new(math.random(-6, 6), math.random(-6, 6), math.random(-6, 6)) * CFrame.Angles(math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360))), "Ball", false)
		SetTween(Effect2, 1.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0, {Transparency = 1, Color = Color3.fromRGB(0, 0, 0), Size = Vector3.new(0, 0, 0)})
		SetDestroy(Effect2, 1)
	end

	for i = 1, 5 do
		local Effect4 = SetEffect(Effects, Ring.Color, "Neon", 0, Vector3.new(6, 0, 6), Effect6.CFrame * CFrame.Angles(math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360))), "Block", false)
		local Effect4Mesh = SetMesh(Effect4, "", "Sphere", Vector3.new(0, 0, 0), Vector3.new(1, 1, 1), "", Vector3.new(1, 1, 1), false)
		SetTween(Effect4, 1, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0, {Transparency = 1, Color = Color3.fromRGB(0, 0, 0), Size = Vector3.new(0.1, 30 + math.random(-1, 1), 0.1)})
		SetDestroy(Effect4, 1.5)
	end
end

function Ravage_Spire()
	Mover.Attack = true
	local Distance = 10
	for i = 0, 0.5, 0.05 / 3 do
		SWait()
		local Effect1 = SetEffect(Effects, Ring.Color, "Neon", 0, Vector3.new(0, 0, 0), LeftArm.CFrame * CFrame.new(0, -2.45, 0) * CFrame.Angles(math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360))), "Ball", false)
		SetTween(Effect1, 1, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0, {Transparency = 1, Color = Color3.fromRGB(0, 0, 0), Size = Vector3.new(2.5, 2.5, 2.5)})
		SetDestroy(Effect1, 2)
		if Mover.Flying then
			break
		elseif not Mover.Flying then
			RingJoint.C0 = Clerp(RingJoint.C0, CFrame.new(0, 0.3, 1.5) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0 - 180 * math.sin(Mover.Sine / 12))), 1 / 3)
			RootJoint.C0 = Clerp(RootJoint.C0, Mover.RC0 * CFrame.new(0, 0, 0 + 0.05 * math.cos(Mover.Sine / 22)) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(15)), 1 / 3)
			Neck.C0 = Clerp(Neck.C0, Mover.NC0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-6 + 1 * math.cos(Mover.Sine / 22)), math.rad(0), math.rad(-15 + 1 * math.sin(Mover.Sine / 22))), 1 / 3)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.45 + 0.05 * math.cos(Mover.Sine / 22), 0.2) * CFrame.Angles(math.rad(3 - 1 * math.cos(Mover.Sine / 22)), math.rad(-10 + 1 * math.sin(Mover.Sine / 22)), math.rad(5 - 1 * math.sin(Mover.Sine / 22))) * Mover.RSC0, 1 / 3)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.6 + 0.05 * math.cos(Mover.Sine / 22), 0) * CFrame.Angles(math.rad(180 + 1 * math.cos(Mover.Sine / 22)), math.rad(-5 - 1 * math.sin(Mover.Sine / 22)), math.rad(-5 + 1 * math.sin(Mover.Sine / 22))) * Mover.LSC0, 1 / 3)
			RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -1 - 0.05 * math.cos(Mover.Sine / 22), 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * CFrame.Angles(math.rad(-3), math.rad(-10), math.rad(0)), 1 / 3)
			LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1 - 0.05 * math.cos(Mover.Sine / 22), 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)) * CFrame.Angles(math.rad(-3), math.rad(10), math.rad(0)), 1 / 3)
		end
	end

	for i = 0, 0.5, 0.05 / 3 do
		SWait()
		if Mover.Flying then
			break
		elseif not Mover.Flying then
			RingJoint.C0 = Clerp(RingJoint.C0, CFrame.new(0, 0.3, 1.5) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0 - 180 * math.sin(Mover.Sine / 12))), 1 / 3)
			RootJoint.C0 = Clerp(RootJoint.C0, Mover.RC0 * CFrame.new(0, 0, -0.8 + 0.05 * math.cos(Mover.Sine / 22)) * CFrame.Angles(math.rad(20), math.rad(0), math.rad(-10)), 1 / 3)
			Neck.C0 = Clerp(Neck.C0, Mover.NC0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-5 + 1 * math.cos(Mover.Sine / 22)), math.rad(0), math.rad(10 - 1 * math.sin(Mover.Sine / 22))), 1 / 3)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.4 + 0.05 * math.cos(Mover.Sine / 22), 0.15) * CFrame.Angles(math.rad(-4 - 1 * math.cos(Mover.Sine / 22)), math.rad(-10 - 1 * math.sin(Mover.Sine / 22)), math.rad(9 - 1 * math.sin(Mover.Sine / 22))) * Mover.RSC0, 1 / 3)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.55, -0.05 + 0.05 * math.cos(Mover.Sine / 22), -0.95) * CFrame.Angles(math.rad(80 + 1 * math.cos(Mover.Sine / 22)), math.rad(-15 + 1 * math.sin(Mover.Sine / 22)), math.rad(-3 + 1 * math.sin(Mover.Sine / 22))) * Mover.LSC0, 1 / 3)
			RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -0.5 - 0.05 * math.cos(Mover.Sine / 22), -0.3) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * CFrame.Angles(math.rad(-2), math.rad(-10), math.rad(40)), 1 / 3)
			LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1.1 - 0.05 * math.cos(Mover.Sine / 22), 0.1) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)) * CFrame.Angles(math.rad(-2), math.rad(5), math.rad(28)), 1 / 3)
		end
		local Effect1 = SetEffect(Effects, Ring.Color, "Neon", 0, Vector3.new(0, 0, 0), LeftArm.CFrame * CFrame.new(0, -2.45, 0) * CFrame.Angles(math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360))), "Ball", false)
		SetTween(Effect1, 1, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0, {Transparency = 1, Color = Color3.fromRGB(0, 0, 0), Size = Vector3.new(2.5, 2.5, 2.5)})
		SetDestroy(Effect1, 2)
	end

	for i = 1, 25 do
		task.wait()
		local Effect1 = SetEffect(Effects, Ring.Color, "Neon", 0, Vector3.new(10, 0, 10), Mover.RootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.Angles(math.rad(0), math.rad(0 + math.random(-360, 360)), math.rad(0)) + Mover.RootPart.CFrame.LookVector * Distance, "Block", false)
		local Effect1Mesh = SetMesh(Effect1, "", "Sphere", Vector3.new(0, 0, 0), Vector3.new(1, 1, 1), "", Vector3.new(1, 1, 1), false)
		SetAoE(Effect1.Position, 15)
		SetSound(7158347304, Effect1, 1, math.random(8, 15) / 10, false)
		SetTween(Effect1, 2, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0, {Transparency = 1, Size = Vector3.new(5, 55, 5)})
		SetDestroy(Effect1, 2)
		local Effect3 = SetEffect(Effects, Ring.Color, "Neon", 0, Vector3.new(0, 0, 0), Effect1.CFrame * CFrame.Angles(math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360))), "Block", false)
		SetSound(1741599172, Effect3, 1, math.random(8, 15) / 10, false)
		SetTween(Effect3, 2, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0, {Transparency = 1, Size = Vector3.new(8, 8, 8)})
		SetDestroy(Effect3, 2)
		local Effect4 = SetEffect(Effects, Ring.Color, "ForceField", 0, Vector3.new(0, 0.1, 0), Effect1.CFrame * CFrame.Angles(math.rad(0), math.rad(0 + math.random(-360, 360)), math.rad(0)), "Block", false)
		local Effect4Mesh = SetMesh(Effect4, "", "Sphere", Vector3.new(0, 0, 0), Vector3.new(1, 1, 1), "", Vector3.new(1, 1, 1), false)
		SetSound(919941001, Effect4, 1, math.random(8, 15) / 10, false)
		SetTween(Effect4, 2, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0, {Transparency = 1, Size = Vector3.new(20, 0.1, 20)})
		SetDestroy(Effect4, 2.5)
		local Effect5 = SetEffect(Effects, Ring.Color, "Neon", 0, Vector3.new(0, 0, 0), Effect1.CFrame * CFrame.Angles(math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360))), "Ball", false)
		SetSound(8120249833, Torso, 1, math.random(8, 15) / 10, false)
		SetTween(Effect5, 2, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0, {Transparency = 1, Color = Color3.fromRGB(0, 0, 0), Size = Vector3.new(15, 15, 15)})
		SetDestroy(Effect5, 1.5)
		Distance = Distance + 5
	end
	Mover.Attack = false
end

function Ravage_Teleportation(Hit)
	Mover.Attack = true
	local Effect1 = SetEffect(Effects, Ring.Color, "Neon", 0, Vector3.new(15, 15, 15), Torso.CFrame * CFrame.Angles(math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360))), "Ball", false)
	SetSound(9057675920, Effect1, 1, math.random(8, 15) / 10, false)
	SetTween(Effect1, 2, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0, {Transparency = 1, Color = Color3.fromRGB(0, 0, 0), Size = Vector3.new(0, 0, 0)})
	SetDestroy(Effect1, 2.5)

	local Effect3 = SetEffect(Effects, Ring.Color, "Neon", 0, Vector3.new(15, 15, 15), CFrame.new(Hit) * CFrame.new(0, 3, 0) * CFrame.Angles(math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360))), "Ball", false)
	SetSound(6583177371, Effect3, 1, math.random(8, 15) / 10, false)
	SetTween(Effect3, 2, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0, {Transparency = 1, Color = Color3.fromRGB(0, 0, 0), Size = Vector3.new(0, 0, 0)})
	SetDestroy(Effect3, 2.5)

	SetLightning(Effect1.Position, Effect3.Position, 1, 5, 0)

	SetAoE(Effect1.Position, 10)
	SetAoE(Effect3.Position, 10)
	Mover.Attack = false
end

function Right_Punch()
	Mover.Attack = true
	SetAoE(RightArm.Position, 6)
	SetSound(200632136, Torso, 1, math.random(8, 15) / 10, false)
	for i = 0, 0.5, 0.05 / 3 do
		SWait()
		if Mover.Flying then
			break
		elseif not Mover.Flying then
			RingJoint.C0 = Clerp(RingJoint.C0, CFrame.new(0, 0.3, 1.5) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0 - 180 * math.sin(Mover.Sine / 12))), 1 / 3)
			RootJoint.C0 = Clerp(RootJoint.C0, Mover.RC0 * CFrame.new(0, 0, -0.1 + 0.05 * math.cos(Mover.Sine / 22)) * CFrame.Angles(math.rad(15), math.rad(0), math.rad(25)), 1 / 3)
			Neck.C0 = Clerp(Neck.C0, Mover.NC0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-10 + 1 * math.cos(Mover.Sine / 22)), math.rad(10 - 1 * math.sin(Mover.Sine / 22)), math.rad(-25 + 1 * math.sin(Mover.Sine / 22))), 1 / 3)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.6, 0.455 + 0.05 * math.cos(Mover.Sine / 22), -0.5) * CFrame.Angles(math.rad(100 - 1 * math.cos(Mover.Sine / 22)), math.rad(10 - 1 * math.sin(Mover.Sine / 22)), math.rad(23 - 1 * math.sin(Mover.Sine / 22))) * Mover.RSC0, 1 / 3)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.4 + 0.05 * math.cos(Mover.Sine / 22), 0.25) * CFrame.Angles(math.rad(-25 + 1 * math.cos(Mover.Sine / 22)), math.rad(10 + 1 * math.sin(Mover.Sine / 22)), math.rad(-6.5 + 1 * math.sin(Mover.Sine / 22))) * Mover.LSC0, 1 / 3)
			RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -0.75 - 0.05 * math.cos(Mover.Sine / 22), -0.3) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * CFrame.Angles(math.rad(-4.5), math.rad(-15), math.rad(15)), 1 / 3)
			LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1.095 - 0.05 * math.cos(Mover.Sine / 22), 0.3) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)) * CFrame.Angles(math.rad(-8), math.rad(25), math.rad(15)), 1 / 3)
		end
		local Effect1 = SetEffect(Effects, Ring.Color, "Neon", 0, Vector3.new(1.09, 2.09, 1.09), RightArm.CFrame, "Block", false)
		SetTween(Effect1, 3, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0, {Transparency = 1, Color = Color3.fromRGB(0, 0, 0), Size = Vector3.new(0, 0, 0)})
		SetDestroy(Effect1, 1)
	end
	Mover.Attack = false
end

function Left_Punch()
	Mover.Attack = true
	SetAoE(LeftArm.Position, 6)
	SetSound(200632136, Torso, 1, math.random(8, 15) / 10, false)
	for i = 0, 0.5, 0.05 / 3 do
		SWait()
		if Mover.Flying then
			break
		elseif not Mover.Flying then
			RingJoint.C0 = Clerp(RingJoint.C0, CFrame.new(0, 0.3, 1.5) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0 - 180 * math.sin(Mover.Sine / 12))), 1 / 3)
			RootJoint.C0 = Clerp(RootJoint.C0, Mover.RC0 * CFrame.new(0, 0, -0.1 + 0.05 * math.cos(Mover.Sine / 22)) * CFrame.Angles(math.rad(15), math.rad(0), math.rad(-25)), 1 / 3)
			Neck.C0 = Clerp(Neck.C0, Mover.NC0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-10 + 1 * math.cos(Mover.Sine / 22)), math.rad(-10 + 1 * math.sin(Mover.Sine / 22)), math.rad(25 - 1 * math.sin(Mover.Sine / 22))), 1 / 3)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.4 + 0.05 * math.cos(Mover.Sine / 22), 0.25) * CFrame.Angles(math.rad(-25 - 1 * math.cos(Mover.Sine / 22)), math.rad(-10 - 1 * math.sin(Mover.Sine / 22)), math.rad(6.5 - 1 * math.sin(Mover.Sine / 22))) * Mover.RSC0, 1 / 3)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.6, 0.455 + 0.05 * math.cos(Mover.Sine / 22), -0.5) * CFrame.Angles(math.rad(100 + 1 * math.cos(Mover.Sine / 22)), math.rad(-10 + 1 * math.sin(Mover.Sine / 22)), math.rad(-23 + 1 * math.sin(Mover.Sine / 22))) * Mover.LSC0, 1 / 3)
			RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -1.095 - 0.05 * math.cos(Mover.Sine / 22), 0.3) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * CFrame.Angles(math.rad(-8), math.rad(-15), math.rad(-15)), 1 / 3)
			LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -0.75 - 0.05 * math.cos(Mover.Sine / 22), -0.3) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)) * CFrame.Angles(math.rad(-4.5), math.rad(25), math.rad(-15)), 1 / 3)
		end
		local Effect1 = SetEffect(Effects, Ring.Color, "Neon", 0, Vector3.new(1.09, 2.09, 1.09), LeftArm.CFrame, "Block", false)
		SetTween(Effect1, 3, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0, {Transparency = 1, Color = Color3.fromRGB(0, 0, 0), Size = Vector3.new(0, 0, 0)})
		SetDestroy(Effect1, 1)
	end
	Mover.Attack = false
end

function Right_Stomp()
	Mover.Attack = true
	for i = 0, 0.5, 0.05 / 3 do
		SWait()
		if Mover.Flying then
			break
		elseif not Mover.Flying then
			RingJoint.C0 = Clerp(RingJoint.C0, CFrame.new(0, 0.3, 1.5) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0 - 180 * math.sin(Mover.Sine / 12))), 1 / 3)
			RootJoint.C0 = Clerp(RootJoint.C0, Mover.RC0 * CFrame.new(0, 0, 0 + 0.05 * math.cos(Mover.Sine / 22)) * CFrame.Angles(math.rad(-15), math.rad(0), math.rad(0)), 1 / 3)
			Neck.C0 = Clerp(Neck.C0, Mover.NC0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-5.5 + 1 * math.cos(Mover.Sine / 22)), math.rad(0), math.rad(0 - 1 * math.sin(Mover.Sine / 22))), 1 / 3)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.4 + 0.05 * math.cos(Mover.Sine / 22), 0.2) * CFrame.Angles(math.rad(-10 - 1 * math.cos(Mover.Sine / 22)), math.rad(-5 - 1 * math.sin(Mover.Sine / 22)), math.rad(3.5 - 1 * math.sin(Mover.Sine / 22))) * Mover.RSC0, 1 / 3)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.4 + 0.05 * math.cos(Mover.Sine / 22), 0.2) * CFrame.Angles(math.rad(-10 + 1 * math.cos(Mover.Sine / 22)), math.rad(5 + 1 * math.sin(Mover.Sine / 22)), math.rad(-3.5 + 1 * math.sin(Mover.Sine / 22))) * Mover.LSC0, 1 / 3)
			RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -0.02 - 0.05 * math.cos(Mover.Sine / 22), -0.4) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * CFrame.Angles(math.rad(-0.5), math.rad(0), math.rad(3.5)), 1 / 3)
			LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1.02 - 0.05 * math.cos(Mover.Sine / 22), 0.1) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)) * CFrame.Angles(math.rad(-2), math.rad(10), math.rad(15)), 1 / 3)
		end
	end

	SetAoE(RightLeg.Position, 10)
	for i = 0, 0.5, 0.05 / 3 do
		SWait()
		if Mover.Flying then
			break
		elseif not Mover.Flying then
			RingJoint.C0 = Clerp(RingJoint.C0, CFrame.new(0, 0.3, 1.5) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0 - 180 * math.sin(Mover.Sine / 12))), 1 / 3)
			RootJoint.C0 = Clerp(RootJoint.C0, Mover.RC0 * CFrame.new(0, 0, -0.3 + 0.05 * math.cos(Mover.Sine / 22)) * CFrame.Angles(math.rad(35), math.rad(0), math.rad(0)), 1 / 3)
			Neck.C0 = Clerp(Neck.C0, Mover.NC0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-10 + 1 * math.cos(Mover.Sine / 22)), math.rad(0), math.rad(0 - 1 * math.sin(Mover.Sine / 22))), 1 / 3)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.4 + 0.05 * math.cos(Mover.Sine / 22), 0.25) * CFrame.Angles(math.rad(-25 - 1 * math.cos(Mover.Sine / 22)), math.rad(-5 - 1 * math.sin(Mover.Sine / 22)), math.rad(5 - 1 * math.sin(Mover.Sine / 22))) * Mover.RSC0, 1 / 3)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.4 + 0.05 * math.cos(Mover.Sine / 22), 0.25) * CFrame.Angles(math.rad(-25 + 1 * math.cos(Mover.Sine / 22)), math.rad(5 + 1 * math.sin(Mover.Sine / 22)), math.rad(-5 + 1 * math.sin(Mover.Sine / 22))) * Mover.LSC0, 1 / 3)
			RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -0.6 - 0.05 * math.cos(Mover.Sine / 22), -0.65) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(45)), 1 / 3)
			LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1.5 - 0.05 * math.cos(Mover.Sine / 22), -0.15) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)) * CFrame.Angles(math.rad(-2), math.rad(10), math.rad(20)), 1 / 3)
		end
		local Effect1 = SetEffect(Effects, Ring.Color, "Neon", 0, Vector3.new(3, 0, 3), RightLeg.CFrame * CFrame.new(0, -1.45, 0) * CFrame.Angles(math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360))), "Block", false)
		local Effect1Mesh = SetMesh(Effect1, "", "Sphere", Vector3.new(0, 0, 0), Vector3.new(1, 1, 1), "", Vector3.new(1, 1, 1), false)
		SetSound(8120249833, Torso, 1, math.random(8, 15) / 10, false)
		SetTween(Effect1, 1.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0, {Transparency = 1, Color = Color3.fromRGB(0, 0, 0), Size = Vector3.new(0.1, 12 + math.random(-1, 1), 0.1)})
		SetDestroy(Effect1, 1.5)

		local Effect2 = SetEffect(Effects, Ring.Color, "ForceField", 1, Vector3.new(4.5, 4.5, 4.5), RightLeg.CFrame * CFrame.new(0, -1.45, 0) * CFrame.Angles(math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360))), "Block", false)
		local Effect2Mesh = SetMesh(Effect2, "", "Sphere", Vector3.new(0, 0, 0), Vector3.new(1, 1, 1), "", Vector3.new(1, 1, 1), false)
		SetSound(7158347304, Torso, 1, math.random(8, 15) / 10, false)
		SetTween(Effect2, 1.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0, {Transparency = 0, Color = Color3.fromRGB(0, 0, 0), Size = Vector3.new(0, 0, 0)})
		SetDestroy(Effect2, 1.5)
	end
	Mover.Attack = false
end

-- || Keys || --

function KeyDown(key)
	local Key = string.lower(key)
	Mover.KeyHold = true
	if Key == "]" then
		Refit_1()
		Refit_2()
	elseif Key == "l" then
		Effects:ClearAllChildren()
	elseif key == "t" then
		Mover.Counter = 0
		Mover.Table = {}
		Chat("Tables have been Cleared.")
	elseif key == "1" then
		Mover.Extermination = not Mover.Extermination
		Chat("Extermination = "..tostring(Mover.Extermination).."")
	elseif key == "k" then
		Mover.KillAura = not Mover.KillAura
		Chat("Kill Aura = "..tostring(Mover.KillAura).."")
	end
end

function KeyUp(key)
	local Key = string.lower(key)
	Mover.KeyHold = false
end

-- || Setup || --

Rem.OnServerEvent:Connect(function(Plr, Type, Input, Task)
	if Plr ~= Player and type(Type) ~= "string" then
		return
	end
	if Plr == Player then
		if Type == "KeyDown"..Auth then
			KeyDown(string.lower(Input))
		elseif Type == "KeyUp"..Auth then
			KeyUp(string.lower(Input))
		elseif Type == "Mover"..Auth then
			Mover.PotentialCFrame, Mover.Walking, Mover.Flying, Mover.Jumping, Mover.HipHeight, Mover.Running = Task.CFrame, Task.Walking, Task.Flying, Task.Jumping, Task.HipHeight, Task.Running
		elseif Type == "Attack_1"..Auth then
			if Mover.Attack == false then
				Ravage_Ring(Input)
			end
		elseif Type == "Attack_2"..Auth then
			if Mover.Attack == false then
				Ravage_Spire()
			end
		elseif Type == "Teleportation"..Auth then
			if Mover.Attack == false then
				Ravage_Teleportation(Input)
			end
		elseif Type == "Melee"..Auth then
			if Mover.Attack == false and Mover.Combo == 1 then
				Mover.Combo = 2
				Left_Punch()
			elseif Mover.Attack == false and Mover.Combo == 2 then
				Mover.Combo = 3
				Right_Stomp()
			elseif Mover.Attack == false and Mover.Combo == 3 then
				Mover.Combo = 1
				Right_Punch()
			end
		end
	end
end)

function Remake()
	pcall(function()
		Rem:Destroy()
	end)
	pcall(function()
		Rem = Instance.new("RemoteEvent", game:GetService("ReplicatedStorage"))
		Rem.Archivable = false
		Rem.Name = RandomString(math.random(1, 100))
		Rem:SetAttribute("Authorization", Auth)
		Rem:SetAttribute(Player.Name, Player.UserId)
		Rem:ClearAllChildren()
	end)
	pcall(function()
		local Timing = os.time()
		local Connection = Rem.OnServerEvent:Connect(function(Plr, Type, Input, Task)
			if Plr ~= Player and type(Type) ~= "string" then
				return
			end
			if Plr == Player then
				if Type == "KeyDown"..Auth then
					KeyDown(string.lower(Input))
				elseif Type == "KeyUp"..Auth then
					KeyUp(string.lower(Input))
				elseif Type == "Mover"..Auth then
					Mover.PotentialCFrame, Mover.Walking, Mover.Flying, Mover.Jumping, Mover.HipHeight, Mover.Running = Task.CFrame, Task.Walking, Task.Flying, Task.Jumping, Task.HipHeight, Task.Running
				elseif Type == "Attack_1"..Auth then
					if Mover.Attack == false then
						Ravage_Ring(Input)
					end
				elseif Type == "Attack_2"..Auth then
					if Mover.Attack == false then
						Ravage_Spire()
					end
				elseif Type == "Teleportation"..Auth then
					if Mover.Attack == false then
						Ravage_Teleportation(Input)
					end
				elseif Type == "Melee"..Auth then
					if Mover.Attack == false and Mover.Combo == 1 then
						Mover.Combo = 2
						Right_Punch()
					elseif Mover.Attack == false and Mover.Combo == 2 then
						Mover.Combo = 3
						Left_Punch()
					elseif Mover.Attack == false and Mover.Combo == 3 then
						Mover.Combo = 1
						Right_Stomp()
					end
				end
			end
		end)
		local Looping = true
		local Removal
		Removal = Rem.AncestryChanged:Connect(function()
			if not Rem or not Rem:IsA("RemoteEvent") or Rem.Parent ~= game:GetService("ReplicatedStorage") or Rem == nil or Rem.Archivable == false then
				Looping = false
				Connection:Disconnect()
				Removal:Disconnect()
			end
		end)
		task.spawn(function()
			while Looping do
				task.wait()
				if Looping == false or Rem == nil or Rem:IsA("RemoteEvent") == false or Rem.Parent ~= game:GetService("ReplicatedStorage") or Rem.Archivable ~= false then 
					break 
				end
				if (os.time() - Timing > 10) then
					task.spawn(Remake)
					break
				end
			end
		end)
		task.spawn(function()
			for i, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
				pcall(function()
					if v:IsA("RemoteEvent") and v.Archivable == false and v:GetAttribute("Authorization") and v:GetAttribute(Player.Name) and v.Parent == game:GetService("ReplicatedStorage") and v ~= Rem then
						v:Destroy()
					end
				end)
			end
		end)
	end)
end
Mover.None[#Mover.None + 0.2] = game:GetService("RunService").Heartbeat:Connect(function()
	if not Rem or not Rem:IsA("RemoteEvent") or Rem.Parent == nil or Rem == nil or Rem.Parent ~= game:GetService("ReplicatedStorage") or Rem.Archivable ~= false or Rem:GetAttribute("Authorization") == nil or Rem:GetAttribute(Player.Name) == nil or #Rem:GetChildren() ~= 0 then
		Remake()
	end
end)

-- || Loops || --

game:GetService("RunService").Heartbeat:Connect(function()
	task.defer(function()
		pcall(function()
			Player.Character = nil
			Rem:SetAttribute("Authorization", Auth)
			Rem:SetAttribute(Player.Name, Player.UserId)
			if CamPart == nil or CamPart.Archivable ~= true or CamPart.Name ~= "C_Actor" or CamPart.Parent ~= game:GetService("ReplicatedStorage") or CamPart.PrimaryPart ~= nil or CamPart:GetAttribute("Camera_Actor") == nil or #CamPart:GetChildren() ~= 0 then
				Refit_2()
			end
			for i, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
				if v:IsA("Actor") and v.Archivable == true and v.Name == "C_Actor" and v:IsDescendantOf(game:GetService("ReplicatedStorage")) and v.PrimaryPart == nil and v:GetAttribute("Camera_Actor") and #v:GetChildren() == 0 and v ~= CamPart then
					v:Destroy()
				end
			end
			Hypernull(function()
				local FakeWelds = {{RootJoint, Torso, Mover.RootPart}, {Neck, Head, Torso}, {RightShoulder, RightArm, Torso}, {LeftShoulder, LeftArm, Torso}, {RightHip, RightLeg, Torso}, {LeftHip, LeftLeg, Torso}, {RingJoint, Ring, Torso}}
				for i, v in ipairs(FakeWelds) do
					local Weld, Part0, Part1 = unpack(v)
					UpdateWeld(Weld, Part0, Part1)
				end
				Head:ApplyMesh(SavedAssets["Head"])
				Torso:ApplyMesh(SavedAssets["Torso"])
				LeftArm:ApplyMesh(SavedAssets["Left Arm"])
				RightArm:ApplyMesh(SavedAssets["Right Arm"])
				LeftLeg:ApplyMesh(SavedAssets["Left Leg"])
				RightLeg:ApplyMesh(SavedAssets["Right Leg"])
				Ring:ApplyMesh(SavedAssets["Ring"])
				if not Head or not (Head.MeshId == "rbxasset://fonts/head.mesh") then
					pcall(function()
						Head:Destroy()
					end)
					Refit_1()
				end
				if not Torso or not (Torso.MeshId == "rbxasset://fonts/torso.mesh") then
					pcall(function()
						Torso:Destroy()
					end)
					Refit_1()
				end
				if not LeftArm or not (LeftArm.MeshId == "rbxasset://fonts/leftarm.mesh") then
					pcall(function()
						LeftArm:Destroy()
					end)
					Refit_1()
				end
				if not RightArm or not (RightArm.MeshId == "rbxasset://fonts/rightarm.mesh") then
					pcall(function()
						RightArm:Destroy()
					end)
					Refit_1()
				end
				if not LeftLeg or not (LeftLeg.MeshId == "rbxasset://fonts/leftleg.mesh") then
					pcall(function()
						LeftLeg:Destroy()
					end)
					Refit_1()
				end
				if not RightLeg or not (RightLeg.MeshId == "rbxasset://fonts/rightleg.mesh") then
					pcall(function()
						RightLeg:Destroy()
					end)
					Refit_1()
				end
				if not Ring or not (Ring.MeshId == "rbxassetid://14688273469") then
					pcall(function()
						Ring:Destroy()
					end)
					Refit_1()
				end
				if not Head or not (Head.Color == Color3.fromRGB(255, 255, 255)) or not (Head.Material == "Ice") or not (Head.Size == Vector3.new(1.2, 1.2, 1.2)) then
					Head.Material = "Ice"
					Head.Color = Color3.fromRGB(255, 255, 255)
					Head.Size = Vector3.new(1.2, 1.2, 1.2)
				end
				if not Torso or not (Torso.Color == Color3.fromRGB(0, 255, 155)) or not (Torso.Material == "Ice") or not (Torso.Size == Vector3.new(2, 2, 1)) then
					Torso.Material = "Ice"
					Torso.Color = Color3.fromRGB(0, 255, 155)
					Torso.Size = Vector3.new(2, 2, 1)
				end
				if not LeftArm or not (LeftArm.Color == Color3.fromRGB(255, 255, 255)) or not (LeftArm.Material == "Ice") or not (LeftArm.Size == Vector3.new(1, 2, 1)) then
					LeftArm.Material = "Ice"
					LeftArm.Color = Color3.fromRGB(255, 255, 255)
					LeftArm.Size = Vector3.new(1, 2, 1)
				end
				if not RightArm or not (RightArm.Color == Color3.fromRGB(255, 255, 255)) or not (RightArm.Material == "Ice") or not (RightArm.Size == Vector3.new(1, 2, 1)) then
					RightArm.Material = "Ice"
					RightArm.Color = Color3.fromRGB(255, 255, 255)
					RightArm.Size = Vector3.new(1, 2, 1)
				end
				if not LeftLeg or not (LeftLeg.Color == Color3.fromRGB(100, 100, 100)) or not (LeftLeg.Material == "Ice") or not (LeftLeg.Size == Vector3.new(1, 2, 1)) then
					LeftLeg.Material = "Ice"
					LeftLeg.Color = Color3.fromRGB(100, 100, 100)
					LeftLeg.Size = Vector3.new(1, 2, 1)
				end
				if not RightLeg or not (RightLeg.Color == Color3.fromRGB(100, 100, 100)) or not (RightLeg.Material == "Ice") or not (RightLeg.Size == Vector3.new(1, 2, 1)) then
					RightLeg.Material = "Ice"
					RightLeg.Color = Color3.fromRGB(100, 100, 100)
					RightLeg.Size = Vector3.new(1, 2, 1)
				end
				if not Ring or not (Ring.Color == Color3.fromRGB(0, 255, 155)) or not (Ring.Material == "Foil") or not (Ring.Size == Vector3.new(5.5, 5.5, 0.5)) then
					Ring.Material = "Foil"
					Ring.Color = Color3.fromRGB(0, 255, 155)
					Ring.Size = Vector3.new(5.5, 5.5, 0.5)
				end
				if not Attach or not (Attach.Visible == false) or not (Attach.Archivable == false) or not (Attach.CFrame == CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(0))) then
					Attach.Visible = false
					Attach.Archivable = false
					Attach.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(0))
				end
				if not Aura or not (Aura.Brightness == 15) or not (Aura.Color == ColorSequence.new(Color3.fromRGB(0, 255, 155))) or not (Aura.LightEmission == 1) or not (Aura.LightInfluence == 0) or not (Aura.Orientation == "VelocityPerpendicular") or not (Aura.Size == NumberSequence.new(0, 3.6)) or not (Aura.Squash == NumberSequence.new(0, 0)) or not (Aura.Texture == "rbxassetid://8095997435") or not (Aura.Transparency == NumberSequence.new(0.497, 0.879)) or not (Aura.ZOffset == 0) or not (Aura.Archivable == false) or not (Aura.EmissionDirection == "Top") or not (Aura.Enabled == true) or not (Aura.Lifetime == NumberRange.new(1.5, 1.5)) or not (Aura.Rate == 5) or not (Aura.Rotation == NumberRange.new(0, 0)) or not (Aura.RotSpeed == NumberRange.new(-360, 360)) or not (Aura.Speed == NumberRange.new(0.001, 0.001)) or not (Aura.SpreadAngle == Vector2.new(0, 0)) or not (Aura.Shape == "Box") or not (Aura.ShapeInOut == "Outward") or not (Aura.ShapeStyle == "Volume") or not (Aura.FlipbookLayout == "None") or not (Aura.Acceleration == Vector3.new(0, 0, 0)) or not (Aura.Drag == 0) or not (Aura.LockedToPart == true) or not (Aura.TimeScale == 1) or not (Aura.VelocityInheritance == 0) or not (Aura.WindAffectsDrag == false) then
					Aura.Brightness = 15
					Aura.Color = ColorSequence.new(Color3.fromRGB(0, 255, 155))
					Aura.LightEmission = 1
					Aura.LightInfluence = 0
					Aura.Orientation = "VelocityPerpendicular"
					Aura.Size = NumberSequence.new(0, 3.65)
					Aura.Squash = NumberSequence.new(0, 0)
					Aura.Texture = "rbxassetid://8095997435"
					Aura.Transparency = NumberSequence.new(0.497, 0.879)
					Aura.ZOffset = 0
					Aura.Archivable = false
					Aura.EmissionDirection = "Top"
					Aura.Enabled = true
					Aura.Lifetime = NumberRange.new(1.5, 1.5)
					Aura.Rate = 5
					Aura.Rotation = NumberRange.new(0, 0)
					Aura.RotSpeed = NumberRange.new(-360, 360)
					Aura.Speed = NumberRange.new(0.001, 0.001)
					Aura.SpreadAngle = Vector2.new(0, 0)
					Aura.Shape = "Box"
					Aura.ShapeInOut = "Outward"
					Aura.ShapeStyle = "Volume"
					Aura.FlipbookLayout = "None"
					Aura.Acceleration = Vector3.new(0, 0, 0)
					Aura.Drag = 0
					Aura.LockedToPart = true
					Aura.TimeScale = 1
					Aura.VelocityInheritance = 0
					Aura.WindAffectsDrag = false
				end
				if (Torso.Position - Mover.CFrame.Position).Magnitude >= 14 + Torso.Size.Magnitude or Torso.Parent ~= game:GetService("Workspace"):FindFirstChildOfClass("Terrain") or Torso.CastShadow ~= true or Torso.Reflectance ~= 0 or Torso.TextureID ~= "" or Torso.Transparency ~= 0 or Torso.Locked ~= true or Torso.PivotOffset ~= CFrame.new(1e6, 1e6, 1e6) or Torso.EnableFluidForces ~= false or Torso.CanCollide ~= false or Torso.CanQuery ~= false or Torso.CanTouch ~= false or Torso.CollisionGroup ~= "None" or Torso.Anchored ~= true or Torso.CustomPhysicalProperties ~= PhysicalProperties.new(0.01, 0, 0, 0, 0) or Torso.Massless ~= true or Torso.RootPriority ~= 127 or Torso.AssemblyLinearVelocity ~= Vector3.new(0, 0, 0) or Torso.AssemblyAngularVelocity ~= Vector3.new(0, 0, 0) then
					UpdateWeld(RootJoint, Torso, Mover.RootPart)
					Refit_1()
					Torso.CastShadow = true
					Torso.Color = Color3.fromRGB(0, 255, 155)
					Torso.Material = "Ice"
					Torso.Reflectance = 0
					Torso.TextureID = ""
					Torso.Transparency = 0
					Torso.Archivable = false
					Torso.Locked = true
					Torso.Name = RandomString(math.random(1, 100))
					Torso.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
					Torso.Size = Vector3.new(2, 2, 1)
					Torso.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
					Torso.EnableFluidForces = false
					Torso.CanCollide = false
					Torso.CanQuery = false
					Torso.CanTouch = false
					Torso.CollisionGroup = "None"
					Torso.Anchored = true
					Torso.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
					Torso.Massless = true
					Torso.RootPriority = 127
					Torso.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
					Torso.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
					Torso:ApplyMesh(SavedAssets["Torso"])
				end
				if (Head.Position - Mover.CFrame.Position).Magnitude >= 14 + Head.Size.Magnitude or Head.Parent ~= game:GetService("Workspace"):FindFirstChildOfClass("Terrain") or Head.CastShadow ~= true or Head.Reflectance ~= 0 or Head.TextureID ~= "" or Head.Transparency ~= 0 or Head.Locked ~= true or Head.PivotOffset ~= CFrame.new(1e6, 1e6, 1e6) or Head.EnableFluidForces ~= false or Head.CanCollide ~= false or Head.CanQuery ~= false or Head.CanTouch ~= false or Head.CollisionGroup ~= "None" or Head.Anchored ~= true or Head.CustomPhysicalProperties ~= PhysicalProperties.new(0.01, 0, 0, 0, 0) or Head.Massless ~= true or Head.RootPriority ~= 127 or Head.AssemblyLinearVelocity ~= Vector3.new(0, 0, 0) or Head.AssemblyAngularVelocity ~= Vector3.new(0, 0, 0) then
					UpdateWeld(Neck, Head, Torso)
					Refit_1()
					Head.CastShadow = true
					Head.Color = Color3.fromRGB(255, 255, 255)
					Head.Material = "Ice"
					Head.Reflectance = 0
					Head.TextureID = ""
					Head.Transparency = 0
					Head.Archivable = false
					Head.Locked = true
					Head.Name = RandomString(math.random(1, 100))
					Head.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
					Head.Size = Vector3.new(1.2, 1.2, 1.2)
					Head.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
					Head.EnableFluidForces = false
					Head.CanCollide = false
					Head.CanQuery = false
					Head.CanTouch = false
					Head.CollisionGroup = "None"
					Head.Anchored = true
					Head.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
					Head.Massless = true
					Head.RootPriority = 127
					Head.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
					Head.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
					Head:ApplyMesh(SavedAssets["Head"])
					coroutine.resume(coroutine.create(function()
						if (Torso.Position - Mover.CFrame.Position).Magnitude >= 14 + Torso.Size.Magnitude or Torso.Parent ~= game:GetService("Workspace"):FindFirstChildOfClass("Terrain") or Torso.CastShadow ~= true or Torso.Reflectance ~= 0 or Torso.TextureID ~= "" or Torso.Transparency ~= 0 or Torso.Locked ~= true or Torso.PivotOffset ~= CFrame.new(1e6, 1e6, 1e6) or Torso.EnableFluidForces ~= false or Torso.CanCollide ~= false or Torso.CanQuery ~= false or Torso.CanTouch ~= false or Torso.CollisionGroup ~= "None" or Torso.Anchored ~= true or Torso.CustomPhysicalProperties ~= PhysicalProperties.new(0.01, 0, 0, 0, 0) or Torso.Massless ~= true or Torso.RootPriority ~= 127 or Torso.AssemblyLinearVelocity ~= Vector3.new(0, 0, 0) or Torso.AssemblyAngularVelocity ~= Vector3.new(0, 0, 0) then
							UpdateWeld(RootJoint, Torso, Mover.RootPart)
							UpdateWeld(Neck, Head, Torso)
							Refit_1()
							Torso.CastShadow = true
							Torso.Color = Color3.fromRGB(0, 255, 155)
							Torso.Material = "Ice"
							Torso.Reflectance = 0
							Torso.TextureID = ""
							Torso.Transparency = 0
							Torso.Archivable = false
							Torso.Locked = true
							Torso.Name = RandomString(math.random(1, 100))
							Torso.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
							Torso.Size = Vector3.new(2, 2, 1)
							Torso.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
							Torso.EnableFluidForces = false
							Torso.CanCollide = false
							Torso.CanQuery = false
							Torso.CanTouch = false
							Torso.CollisionGroup = "None"
							Torso.Anchored = true
							Torso.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
							Torso.Massless = true
							Torso.RootPriority = 127
							Torso.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
							Torso.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
							Torso:ApplyMesh(SavedAssets["Torso"])
						end
					end))
				end
				if (LeftArm.Position - Mover.CFrame.Position).Magnitude >= 14 + LeftArm.Size.Magnitude or LeftArm.Parent ~= game:GetService("Workspace"):FindFirstChildOfClass("Terrain") or LeftArm.CastShadow ~= true or LeftArm.Reflectance ~= 0 or LeftArm.TextureID ~= "" or LeftArm.Transparency ~= 0 or LeftArm.Locked ~= true or LeftArm.PivotOffset ~= CFrame.new(1e6, 1e6, 1e6) or LeftArm.EnableFluidForces ~= false or LeftArm.CanCollide ~= false or LeftArm.CanQuery ~= false or LeftArm.CanTouch ~= false or LeftArm.CollisionGroup ~= "None" or LeftArm.Anchored ~= true or LeftArm.CustomPhysicalProperties ~= PhysicalProperties.new(0.01, 0, 0, 0, 0) or LeftArm.Massless ~= true or LeftArm.RootPriority ~= 127 or LeftArm.AssemblyLinearVelocity ~= Vector3.new(0, 0, 0) or LeftArm.AssemblyAngularVelocity ~= Vector3.new(0, 0, 0) then
					UpdateWeld(LeftShoulder, LeftArm, Torso)
					Refit_1()
					LeftArm.CastShadow = true
					LeftArm.Color = Color3.fromRGB(255, 255, 255)
					LeftArm.Material = "Ice"
					LeftArm.Reflectance = 0
					LeftArm.TextureID = ""
					LeftArm.Transparency = 0
					LeftArm.Archivable = false
					LeftArm.Locked = true
					LeftArm.Name = RandomString(math.random(1, 100))
					LeftArm.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
					LeftArm.Size = Vector3.new(1, 2, 1)
					LeftArm.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
					LeftArm.EnableFluidForces = false
					LeftArm.CanCollide = false
					LeftArm.CanQuery = false
					LeftArm.CanTouch = false
					LeftArm.CollisionGroup = "None"
					LeftArm.Anchored = true
					LeftArm.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
					LeftArm.Massless = true
					LeftArm.RootPriority = 127
					LeftArm.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
					LeftArm.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
					LeftArm:ApplyMesh(SavedAssets["Left Arm"])
					coroutine.resume(coroutine.create(function()
						if (Torso.Position - Mover.CFrame.Position).Magnitude >= 14 + Torso.Size.Magnitude or Torso.Parent ~= game:GetService("Workspace"):FindFirstChildOfClass("Terrain") or Torso.CastShadow ~= true or Torso.Reflectance ~= 0 or Torso.TextureID ~= "" or Torso.Transparency ~= 0 or Torso.Locked ~= true or Torso.PivotOffset ~= CFrame.new(1e6, 1e6, 1e6) or Torso.EnableFluidForces ~= false or Torso.CanCollide ~= false or Torso.CanQuery ~= false or Torso.CanTouch ~= false or Torso.CollisionGroup ~= "None" or Torso.Anchored ~= true or Torso.CustomPhysicalProperties ~= PhysicalProperties.new(0.01, 0, 0, 0, 0) or Torso.Massless ~= true or Torso.RootPriority ~= 127 or Torso.AssemblyLinearVelocity ~= Vector3.new(0, 0, 0) or Torso.AssemblyAngularVelocity ~= Vector3.new(0, 0, 0) then
							UpdateWeld(RootJoint, Torso, Mover.RootPart)
							UpdateWeld(LeftShoulder, LeftArm, Torso)
							Refit_1()
							Torso.CastShadow = true
							Torso.Color = Color3.fromRGB(0, 255, 155)
							Torso.Material = "Ice"
							Torso.Reflectance = 0
							Torso.TextureID = ""
							Torso.Transparency = 0
							Torso.Archivable = false
							Torso.Locked = true
							Torso.Name = RandomString(math.random(1, 100))
							Torso.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
							Torso.Size = Vector3.new(2, 2, 1)
							Torso.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
							Torso.EnableFluidForces = false
							Torso.CanCollide = false
							Torso.CanQuery = false
							Torso.CanTouch = false
							Torso.CollisionGroup = "None"
							Torso.Anchored = true
							Torso.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
							Torso.Massless = true
							Torso.RootPriority = 127
							Torso.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
							Torso.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
							Torso:ApplyMesh(SavedAssets["Torso"])
						end
					end))
				end
				if (RightArm.Position - Mover.CFrame.Position).Magnitude >= 14 + RightArm.Size.Magnitude or RightArm.Parent ~= game:GetService("Workspace"):FindFirstChildOfClass("Terrain") or RightArm.CastShadow ~= true or RightArm.Reflectance ~= 0 or RightArm.TextureID ~= "" or RightArm.Transparency ~= 0 or RightArm.Locked ~= true or RightArm.PivotOffset ~= CFrame.new(1e6, 1e6, 1e6) or RightArm.EnableFluidForces ~= false or RightArm.CanCollide ~= false or RightArm.CanQuery ~= false or RightArm.CanTouch ~= false or RightArm.CollisionGroup ~= "None" or RightArm.Anchored ~= true or RightArm.CustomPhysicalProperties ~= PhysicalProperties.new(0.01, 0, 0, 0, 0) or RightArm.Massless ~= true or RightArm.RootPriority ~= 127 or RightArm.AssemblyLinearVelocity ~= Vector3.new(0, 0, 0) or RightArm.AssemblyAngularVelocity ~= Vector3.new(0, 0, 0) then
					UpdateWeld(RightShoulder, RightArm, Torso)
					Refit_1()
					RightArm.CastShadow = true
					RightArm.Color = Color3.fromRGB(255, 255, 255)
					RightArm.Material = "Ice"
					RightArm.Reflectance = 0
					RightArm.TextureID = ""
					RightArm.Transparency = 0
					RightArm.Archivable = false
					RightArm.Locked = true
					RightArm.Name = RandomString(math.random(1, 100))
					RightArm.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
					RightArm.Size = Vector3.new(1, 2, 1)
					RightArm.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
					RightArm.EnableFluidForces = false
					RightArm.CanCollide = false
					RightArm.CanQuery = false
					RightArm.CanTouch = false
					RightArm.CollisionGroup = "None"
					RightArm.Anchored = true
					RightArm.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
					RightArm.Massless = true
					RightArm.RootPriority = 127
					RightArm.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
					RightArm.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
					RightArm:ApplyMesh(SavedAssets["Right Arm"])
					coroutine.resume(coroutine.create(function()
						if (Torso.Position - Mover.CFrame.Position).Magnitude >= 14 + Torso.Size.Magnitude or Torso.Parent ~= game:GetService("Workspace"):FindFirstChildOfClass("Terrain") or Torso.CastShadow ~= true or Torso.Reflectance ~= 0 or Torso.TextureID ~= "" or Torso.Transparency ~= 0 or Torso.Locked ~= true or Torso.PivotOffset ~= CFrame.new(1e6, 1e6, 1e6) or Torso.EnableFluidForces ~= false or Torso.CanCollide ~= false or Torso.CanQuery ~= false or Torso.CanTouch ~= false or Torso.CollisionGroup ~= "None" or Torso.Anchored ~= true or Torso.CustomPhysicalProperties ~= PhysicalProperties.new(0.01, 0, 0, 0, 0) or Torso.Massless ~= true or Torso.RootPriority ~= 127 or Torso.AssemblyLinearVelocity ~= Vector3.new(0, 0, 0) or Torso.AssemblyAngularVelocity ~= Vector3.new(0, 0, 0) then
							UpdateWeld(RootJoint, Torso, Mover.RootPart)
							UpdateWeld(RightShoulder, RightArm, Torso)
							Refit_1()
							Torso.CastShadow = true
							Torso.Color = Color3.fromRGB(0, 255, 155)
							Torso.Material = "Ice"
							Torso.Reflectance = 0
							Torso.TextureID = ""
							Torso.Transparency = 0
							Torso.Archivable = false
							Torso.Locked = true
							Torso.Name = RandomString(math.random(1, 100))
							Torso.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
							Torso.Size = Vector3.new(2, 2, 1)
							Torso.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
							Torso.EnableFluidForces = false
							Torso.CanCollide = false
							Torso.CanQuery = false
							Torso.CanTouch = false
							Torso.CollisionGroup = "None"
							Torso.Anchored = true
							Torso.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
							Torso.Massless = true
							Torso.RootPriority = 127
							Torso.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
							Torso.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
							Torso:ApplyMesh(SavedAssets["Torso"])
						end
					end))
				end
				if (LeftLeg.Position - Mover.CFrame.Position).Magnitude >= 14 + LeftLeg.Size.Magnitude or LeftLeg.Parent ~= game:GetService("Workspace"):FindFirstChildOfClass("Terrain") or LeftLeg.CastShadow ~= true or LeftLeg.Reflectance ~= 0 or LeftLeg.TextureID ~= "" or LeftLeg.Transparency ~= 0 or LeftLeg.Locked ~= true or LeftLeg.PivotOffset ~= CFrame.new(1e6, 1e6, 1e6) or LeftLeg.EnableFluidForces ~= false or LeftLeg.CanCollide ~= false or LeftLeg.CanQuery ~= false or LeftLeg.CanTouch ~= false or LeftLeg.CollisionGroup ~= "None" or LeftLeg.Anchored ~= true or LeftLeg.CustomPhysicalProperties ~= PhysicalProperties.new(0.01, 0, 0, 0, 0) or LeftLeg.Massless ~= true or LeftLeg.RootPriority ~= 127 or LeftLeg.AssemblyLinearVelocity ~= Vector3.new(0, 0, 0) or LeftLeg.AssemblyAngularVelocity ~= Vector3.new(0, 0, 0) then
					UpdateWeld(LeftHip, LeftLeg, Torso)
					Refit_1()
					LeftLeg.CastShadow = true
					LeftLeg.Color = Color3.fromRGB(100, 100, 100)
					LeftLeg.Material = "Ice"
					LeftLeg.Reflectance = 0
					LeftLeg.TextureID = ""
					LeftLeg.Transparency = 0
					LeftLeg.Archivable = false
					LeftLeg.Locked = true
					LeftLeg.Name = RandomString(math.random(1, 100))
					LeftLeg.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
					LeftLeg.Size = Vector3.new(1, 2, 1)
					LeftLeg.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
					LeftLeg.EnableFluidForces = false
					LeftLeg.CanCollide = false
					LeftLeg.CanQuery = false
					LeftLeg.CanTouch = false
					LeftLeg.CollisionGroup = "None"
					LeftLeg.Anchored = true
					LeftLeg.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
					LeftLeg.Massless = true
					LeftLeg.RootPriority = 127
					LeftLeg.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
					LeftLeg.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
					LeftLeg:ApplyMesh(SavedAssets["Left Leg"])
					coroutine.resume(coroutine.create(function()
						if (Torso.Position - Mover.CFrame.Position).Magnitude >= 14 + Torso.Size.Magnitude or Torso.Parent ~= game:GetService("Workspace"):FindFirstChildOfClass("Terrain") or Torso.CastShadow ~= true or Torso.Reflectance ~= 0 or Torso.TextureID ~= "" or Torso.Transparency ~= 0 or Torso.Locked ~= true or Torso.PivotOffset ~= CFrame.new(1e6, 1e6, 1e6) or Torso.EnableFluidForces ~= false or Torso.CanCollide ~= false or Torso.CanQuery ~= false or Torso.CanTouch ~= false or Torso.CollisionGroup ~= "None" or Torso.Anchored ~= true or Torso.CustomPhysicalProperties ~= PhysicalProperties.new(0.01, 0, 0, 0, 0) or Torso.Massless ~= true or Torso.RootPriority ~= 127 or Torso.AssemblyLinearVelocity ~= Vector3.new(0, 0, 0) or Torso.AssemblyAngularVelocity ~= Vector3.new(0, 0, 0) then
							UpdateWeld(RootJoint, Torso, Mover.RootPart)
							UpdateWeld(LeftHip, LeftLeg, Torso)
							Refit_1()
							Torso.CastShadow = true
							Torso.Color = Color3.fromRGB(0, 255, 155)
							Torso.Material = "Ice"
							Torso.Reflectance = 0
							Torso.TextureID = ""
							Torso.Transparency = 0
							Torso.Archivable = false
							Torso.Locked = true
							Torso.Name = RandomString(math.random(1, 100))
							Torso.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
							Torso.Size = Vector3.new(2, 2, 1)
							Torso.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
							Torso.EnableFluidForces = false
							Torso.CanCollide = false
							Torso.CanQuery = false
							Torso.CanTouch = false
							Torso.CollisionGroup = "None"
							Torso.Anchored = true
							Torso.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
							Torso.Massless = true
							Torso.RootPriority = 127
							Torso.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
							Torso.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
							Torso:ApplyMesh(SavedAssets["Torso"])
						end
					end))
				end
				if (RightLeg.Position - Mover.CFrame.Position).Magnitude >= 14 + RightLeg.Size.Magnitude or RightLeg.Parent ~= game:GetService("Workspace"):FindFirstChildOfClass("Terrain") or RightLeg.CastShadow ~= true or RightLeg.Reflectance ~= 0 or RightLeg.TextureID ~= "" or RightLeg.Transparency ~= 0 or RightLeg.Locked ~= true or RightLeg.PivotOffset ~= CFrame.new(1e6, 1e6, 1e6) or RightLeg.EnableFluidForces ~= false or RightLeg.CanCollide ~= false or RightLeg.CanQuery ~= false or RightLeg.CanTouch ~= false or RightLeg.CollisionGroup ~= "None" or RightLeg.Anchored ~= true or RightLeg.CustomPhysicalProperties ~= PhysicalProperties.new(0.01, 0, 0, 0, 0) or RightLeg.Massless ~= true or RightLeg.RootPriority ~= 127 or RightLeg.AssemblyLinearVelocity ~= Vector3.new(0, 0, 0) or RightLeg.AssemblyAngularVelocity ~= Vector3.new(0, 0, 0) then
					UpdateWeld(RightHip, RightLeg, Torso)
					Refit_1()
					RightLeg.CastShadow = true
					RightLeg.Color = Color3.fromRGB(100, 100, 100)
					RightLeg.Material = "Ice"
					RightLeg.Reflectance = 0
					RightLeg.TextureID = ""
					RightLeg.Transparency = 0
					RightLeg.Archivable = false
					RightLeg.Locked = true
					RightLeg.Name = RandomString(math.random(1, 100))
					RightLeg.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
					RightLeg.Size = Vector3.new(1, 2, 1)
					RightLeg.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
					RightLeg.EnableFluidForces = false
					RightLeg.CanCollide = false
					RightLeg.CanQuery = false
					RightLeg.CanTouch = false
					RightLeg.CollisionGroup = "None"
					RightLeg.Anchored = true
					RightLeg.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
					RightLeg.Massless = true
					RightLeg.RootPriority = 127
					RightLeg.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
					RightLeg.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
					RightLeg:ApplyMesh(SavedAssets["Right Leg"])
					coroutine.resume(coroutine.create(function()
						if (Torso.Position - Mover.CFrame.Position).Magnitude >= 14 + Torso.Size.Magnitude or Torso.Parent ~= game:GetService("Workspace"):FindFirstChildOfClass("Terrain") or Torso.CastShadow ~= true or Torso.Reflectance ~= 0 or Torso.TextureID ~= "" or Torso.Transparency ~= 0 or Torso.Locked ~= true or Torso.PivotOffset ~= CFrame.new(1e6, 1e6, 1e6) or Torso.EnableFluidForces ~= false or Torso.CanCollide ~= false or Torso.CanQuery ~= false or Torso.CanTouch ~= false or Torso.CollisionGroup ~= "None" or Torso.Anchored ~= true or Torso.CustomPhysicalProperties ~= PhysicalProperties.new(0.01, 0, 0, 0, 0) or Torso.Massless ~= true or Torso.RootPriority ~= 127 or Torso.AssemblyLinearVelocity ~= Vector3.new(0, 0, 0) or Torso.AssemblyAngularVelocity ~= Vector3.new(0, 0, 0) then
							UpdateWeld(RootJoint, Torso, Mover.RootPart)
							UpdateWeld(RightHip, RightLeg, Torso)
							Refit_1()
							Torso.CastShadow = true
							Torso.Color = Color3.fromRGB(0, 255, 155)
							Torso.Material = "Ice"
							Torso.Reflectance = 0
							Torso.TextureID = ""
							Torso.Transparency = 0
							Torso.Archivable = false
							Torso.Locked = true
							Torso.Name = RandomString(math.random(1, 100))
							Torso.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
							Torso.Size = Vector3.new(2, 2, 1)
							Torso.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
							Torso.EnableFluidForces = false
							Torso.CanCollide = false
							Torso.CanQuery = false
							Torso.CanTouch = false
							Torso.CollisionGroup = "None"
							Torso.Anchored = true
							Torso.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
							Torso.Massless = true
							Torso.RootPriority = 127
							Torso.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
							Torso.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
							Torso:ApplyMesh(SavedAssets["Torso"])
						end
					end))
				end
				if (Ring.Position - Mover.CFrame.Position).Magnitude >= 14 + Ring.Size.Magnitude or Ring.Parent ~= game:GetService("Workspace"):FindFirstChildOfClass("Terrain") or Ring.CastShadow ~= true or Ring.Reflectance ~= 0 or Ring.TextureID ~= "" or Ring.Transparency ~= 0 or Ring.Locked ~= true or Ring.PivotOffset ~= CFrame.new(1e6, 1e6, 1e6) or Ring.EnableFluidForces ~= false or Ring.CanCollide ~= false or Ring.CanQuery ~= false or Ring.CanTouch ~= false or Ring.CollisionGroup ~= "None" or Ring.Anchored ~= true or Ring.CustomPhysicalProperties ~= PhysicalProperties.new(0.01, 0, 0, 0, 0) or Ring.Massless ~= true or Ring.RootPriority ~= 127 or Ring.AssemblyLinearVelocity ~= Vector3.new(0, 0, 0) or Ring.AssemblyAngularVelocity ~= Vector3.new(0, 0, 0) then
					UpdateWeld(RingJoint, Ring, Head)
					Refit_1()
					Ring.CastShadow = true
					Ring.Color = Color3.fromRGB(0, 255, 155)
					Ring.Material = "Foil"
					Ring.Reflectance = 0
					Ring.TextureID = ""
					Ring.Transparency = 0
					Ring.Archivable = false
					Ring.Locked = true
					Ring.Name = RandomString(math.random(1, 100))
					Ring.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
					Ring.Size = Vector3.new(5.5, 5.5, 0.5)
					Ring.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
					Ring.EnableFluidForces = false
					Ring.CanCollide = false
					Ring.CanQuery = false
					Ring.CanTouch = false
					Ring.CollisionGroup = "None"
					Ring.Anchored = true
					Ring.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
					Ring.Massless = true
					Ring.RootPriority = 127
					Ring.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
					Ring.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
					Ring:ApplyMesh(SavedAssets["Ring"])
					coroutine.resume(coroutine.create(function()
						if (Torso.Position - Mover.CFrame.Position).Magnitude >= 14 + Torso.Size.Magnitude or Torso.Parent ~= game:GetService("Workspace"):FindFirstChildOfClass("Terrain") or Torso.CastShadow ~= true or Torso.Reflectance ~= 0 or Torso.TextureID ~= "" or Torso.Transparency ~= 0 or Torso.Locked ~= true or Torso.PivotOffset ~= CFrame.new(1e6, 1e6, 1e6) or Torso.EnableFluidForces ~= false or Torso.CanCollide ~= false or Torso.CanQuery ~= false or Torso.CanTouch ~= false or Torso.CollisionGroup ~= "None" or Torso.Anchored ~= true or Torso.CustomPhysicalProperties ~= PhysicalProperties.new(0.01, 0, 0, 0, 0) or Torso.Massless ~= true or Torso.RootPriority ~= 127 or Torso.AssemblyLinearVelocity ~= Vector3.new(0, 0, 0) or Torso.AssemblyAngularVelocity ~= Vector3.new(0, 0, 0) then
							UpdateWeld(RootJoint, Torso, Mover.RootPart)
							UpdateWeld(RingJoint, Ring, Torso)
							Refit_1()
							Torso.CastShadow = true
							Torso.Color = Color3.fromRGB(0, 255, 155)
							Torso.Material = "Ice"
							Torso.Reflectance = 0
							Torso.TextureID = ""
							Torso.Transparency = 0
							Torso.Archivable = false
							Torso.Locked = true
							Torso.Name = RandomString(math.random(1, 100))
							Torso.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
							Torso.Size = Vector3.new(2, 2, 1)
							Torso.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
							Torso.EnableFluidForces = false
							Torso.CanCollide = false
							Torso.CanQuery = false
							Torso.CanTouch = false
							Torso.CollisionGroup = "None"
							Torso.Anchored = true
							Torso.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
							Torso.Massless = true
							Torso.RootPriority = 127
							Torso.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
							Torso.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
							Torso:ApplyMesh(SavedAssets["Torso"])
						end
					end))
				end
			end)
		end)
	end)
end)

task.spawn(function()
	while true do
		task.wait()
		if Mover.KillAura then
			local Sizes = {
				0.5, 
				1, 
				1.5, 
			}
			local Point_A = SetEffect(Effects, Ring.Color, "Neon", 0, Vector3.new(4, 4, 4), Torso.CFrame * CFrame.new(math.random(-15, 15), math.random(-15, 15), math.random(-15, 15)) * CFrame.Angles(math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360))), "Ball", false)
			SetAoE(Point_A.Position, 10)
			SetTween(Point_A, 1, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0, {Transparency = 1, Color = Color3.fromRGB(0, 0, 0), Size = Vector3.new(0, 0, 0)})
			SetDestroy(Point_A, 1)
			local Point_B = SetEffect(Effects, Ring.Color, "Neon", 0, Vector3.new(4, 4, 4), Torso.CFrame * CFrame.new(math.random(-25, 25), math.random(-25, 25), math.random(-25, 25)) * CFrame.Angles(math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360)), math.rad(0 + math.random(-360, 360))), "Ball", false)
			SetAoE(Point_B.Position, 5)
			SetTween(Point_B, 1, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0, {Transparency = 1, Color = Color3.fromRGB(0, 0, 0), Size = Vector3.new(0, 0, 0)})
			SetDestroy(Point_B, 1)
			SetLightning(Point_A.Position, Point_B.Position, 10, Sizes[math.random(1, #Sizes)], 0)
		end
		if Mover.Running and Mover.Walking and not Mover.Flying then
			local HD = Instance.new("MeshPart")
			HD.CastShadow = true
			HD.Reflectance = 0
			HD.TextureID = ""
			HD.Transparency = 0
			HD.Locked = true
			HD.Name = RandomString(math.random(1, 100))
			HD.Size = Vector3.new(1.2, 1.2, 1.2)
			HD.CFrame = Head.CFrame
			HD.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
			HD.CanCollide = false
			HD.CanQuery = false
			HD.CanTouch = false
			HD.CollisionGroup = "None"
			HD.Anchored = true
			HD.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
			HD.Massless = true
			HD.RootPriority = 127
			HD.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			HD.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
			HD:ApplyMesh(SavedAssets["Head"])

			local TO = Instance.new("MeshPart")
			TO.CastShadow = true
			TO.Reflectance = 0
			TO.TextureID = ""
			TO.Transparency = 0
			TO.Locked = true
			TO.Name = RandomString(math.random(1, 100))
			TO.Size = Vector3.new(2, 2, 1)
			TO.CFrame = Torso.CFrame
			TO.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
			TO.CanCollide = false
			TO.CanQuery = false
			TO.CanTouch = false
			TO.CollisionGroup = "None"
			TO.Anchored = true
			TO.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
			TO.Massless = true
			TO.RootPriority = 127
			TO.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			TO.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
			TO:ApplyMesh(SavedAssets["Torso"])

			local LA = Instance.new("MeshPart")
			LA.CastShadow = true
			LA.Reflectance = 0
			LA.TextureID = ""
			LA.Transparency = 0
			LA.Locked = true
			LA.Name = RandomString(math.random(1, 100))
			LA.Size = Vector3.new(1, 2, 1)
			LA.CFrame = LeftArm.CFrame
			LA.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
			LA.CanCollide = false
			LA.CanQuery = false
			LA.CanTouch = false
			LA.CollisionGroup = "None"
			LA.Anchored = true
			LA.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
			LA.Massless = true
			LA.RootPriority = 127
			LA.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			LA.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
			LA:ApplyMesh(SavedAssets["Left Arm"])

			local RA = Instance.new("MeshPart")
			RA.CastShadow = true
			RA.Reflectance = 0
			RA.TextureID = ""
			RA.Transparency = 0
			RA.Locked = true
			RA.Name = RandomString(math.random(1, 100))
			RA.Size = Vector3.new(1, 2, 1)
			RA.CFrame = RightArm.CFrame
			RA.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
			RA.CanCollide = false
			RA.CanQuery = false
			RA.CanTouch = false
			RA.CollisionGroup = "None"
			RA.Anchored = true
			RA.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
			RA.Massless = true
			RA.RootPriority = 127
			RA.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			RA.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
			RA:ApplyMesh(SavedAssets["Right Arm"])

			local LL = Instance.new("MeshPart")
			LL.CastShadow = true
			LL.Reflectance = 0
			LL.TextureID = ""
			LL.Transparency = 0
			LL.Locked = true
			LL.Name = RandomString(math.random(1, 100))
			LL.Size = Vector3.new(1, 2, 1)
			LL.CFrame = LeftLeg.CFrame
			LL.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
			LL.CanCollide = false
			LL.CanQuery = false
			LL.CanTouch = false
			LL.CollisionGroup = "None"
			LL.Anchored = true
			LL.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
			LL.Massless = true
			LL.RootPriority = 127
			LL.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			LL.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
			LL:ApplyMesh(SavedAssets["Left Leg"])

			local RL = Instance.new("MeshPart")
			RL.CastShadow = true
			RL.Reflectance = 0
			RL.TextureID = ""
			RL.Transparency = 0
			RL.Locked = true
			RL.Name = RandomString(math.random(1, 100))
			RL.Size = Vector3.new(1, 2, 1)
			RL.CFrame = RightLeg.CFrame
			RL.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
			RL.CanCollide = false
			RL.CanQuery = false
			RL.CanTouch = false
			RL.CollisionGroup = "None"
			RL.Anchored = true
			RL.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
			RL.Massless = true
			RL.RootPriority = 127
			RL.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			RL.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
			RL:ApplyMesh(SavedAssets["Right Leg"])

			local RG = Instance.new("MeshPart")
			RG.CastShadow = true
			RG.Reflectance = 0
			RG.TextureID = ""
			RG.Transparency = 0
			RG.Locked = true
			RG.Name = RandomString(math.random(1, 100))
			RG.Size = Vector3.new(5.5, 5.5, 0.5)
			RG.CFrame = Ring.CFrame
			RG.PivotOffset = CFrame.new(1e6, 1e6, 1e6)
			RG.CanCollide = false
			RG.CanQuery = false
			RG.CanTouch = false
			RG.CollisionGroup = "None"
			RG.Anchored = true
			RG.CustomPhysicalProperties = PhysicalProperties.new(0.01, 0, 0, 0, 0)
			RG.Massless = true
			RG.RootPriority = 127
			RG.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			RG.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
			RG:ApplyMesh(SavedAssets["Ring"])
			local Collection = {
				HD, 
				TO, 
				LA, 
				RA, 
				LL, 
				RL, 
				RG, 
			}
			for i, v in ipairs(Collection) do
				if v:IsA("MeshPart") then
					task.delay(0.01, function()
						v.Archivable = true
						local v2 = v:Clone()
						v2.Color = Ring.Color
						v2.Material = "Neon"
						v2.Parent = Effects
						SetTween(v2, 0.66, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0, {Transparency = 1, Color = Color3.fromRGB(0, 0, 0)})
						SetDestroy(v2, 0.16)
					end)
				end
			end
		end
	end
end)

task.spawn(function()
	while true do
		SWait()
		Mover.Sine = Mover.Sine + 1
		Mover.CFrame = Mover.PotentialCFrame
		Mover.RootPart.CFrame = CFrame.new(0, Mover.HipHeight, 0) * Mover.CFrame
		CamPart.WorldPivot = Mover.CFrame * CFrame.new(0, 1.5, 0)
		local FakeWelds = {{RootJoint, Torso, Mover.RootPart}, {Neck, Head, Torso}, {RightShoulder, RightArm, Torso}, {LeftShoulder, LeftArm, Torso}, {RightHip, RightLeg, Torso}, {LeftHip, LeftLeg, Torso}, {RingJoint, Ring, Torso}}
		for i, v in ipairs(FakeWelds) do
			local Weld, Part0, Part1 = unpack(v)
			UpdateWeld(Weld, Part0, Part1)
		end
		if Mover.Walking == false and not Mover.Flying then
			if Mover.Attack == false then
				RingJoint.C0 = Clerp(RingJoint.C0, CFrame.new(0 - 0.1 * math.cos(Mover.Sine / 22), 0.3 - 0.1 * math.sin(Mover.Sine / 22), 1.5 - 0.1 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(-2 - 2 * math.cos(Mover.Sine / 22)), math.rad(0 - 2 * math.sin(Mover.Sine / 22)), math.rad(0 - 180 * math.sin(Mover.Sine / 12))), 0.15 / 3)
				RootJoint.C0 = Clerp(RootJoint.C0, Mover.RC0 * CFrame.new(0, 0, 0 + 0.03 * math.cos(Mover.Sine / 22)) * CFrame.Angles(math.rad(-5 - -2 * math.sin(Mover.Sine / 22)), math.rad(0), math.rad(0)), 0.15 / 3)
				Neck.C0 = Clerp(Neck.C0, Mover.NC0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(10 - 2 * math.cos(Mover.Sine / 22)), math.rad(0 - 2 * math.sin(Mover.Sine / 22)), math.rad(0 - 2 * math.sin(Mover.Sine / 22))), 0.15 / 3)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.4 + 0.03 * math.cos(Mover.Sine / 22), 0.15 - 0.03 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(-5 - 2 * -math.cos(Mover.Sine / 22)), math.rad(-10 - 2 * math.sin(Mover.Sine / 22)), math.rad(3 + 2 * math.sin(Mover.Sine / 22))) * Mover.RSC0, 0.15 / 3)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.4 + 0.03 * math.cos(Mover.Sine / 22), 0.15 - 0.03 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(-5 + 2 * -math.cos(Mover.Sine / 22)), math.rad(10 + 2 * math.sin(Mover.Sine / 22)), math.rad(-3 - 2 * math.sin(Mover.Sine / 22))) * Mover.LSC0, 0.15 / 3)
				RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -1 - 0.03 * math.cos(Mover.Sine / 22), 0 + 0.03 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(0 + -2 * -math.sin(Mover.Sine / 22)), math.rad(90), math.rad(0)) * CFrame.Angles(math.rad(-2.5), math.rad(-5 + 1 * math.sin(Mover.Sine / 22)), math.rad(-5)), 0.15 / 3)
				LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1 - 0.03 * math.cos(Mover.Sine / 22), 0 + 0.03 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(0 + -2 * -math.sin(Mover.Sine / 22)), math.rad(-90), math.rad(0)) * CFrame.Angles(math.rad(-2.5), math.rad(5 - 1 * math.sin(Mover.Sine / 22)), math.rad(5)), 0.15 / 3)
			end
		elseif Mover.Walking == true and Mover.Running == false and not Mover.Flying then
			if Mover.Attack == false then
				RingJoint.C0 = Clerp(RingJoint.C0, CFrame.new(0 - 0.1 * math.cos(Mover.Sine / 22), 0.3 - 0.1 * math.sin(Mover.Sine / 22), 1.55 - 0.1 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(-6 - 0.5 * math.cos(Mover.Sine / 22)), math.rad(0 - 2 * math.sin(Mover.Sine / 22)), math.rad(0 - 180 * math.sin(Mover.Sine / 12))), 0.15 / 3)
				RootJoint.C0 = Clerp(RootJoint.C0, Mover.RC0 * CFrame.new(0, 0, -0.1 + 0.05 * math.cos(Mover.Sine / 22)) * CFrame.Angles(math.rad(15 - 0.05 * math.cos(Mover.Sine / 22)), math.rad(0 - 1.5 * math.cos(Mover.Sine / 10)), math.rad(0 - 1.5 * math.cos(Mover.Sine / 10))), 0.15 / 3)
				Neck.C0 = Clerp(Neck.C0, Mover.NC0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-5 - 1 * math.sin(Mover.Sine / 10)), math.rad(0 + 1.5 * math.cos(Mover.Sine / 10)), math.rad(0 + 2 * math.sin(Mover.Sine / 10))), 0.25 / 3)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.45 + 0.01 * math.cos(Mover.Sine / 22), 0 - 0.01 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(10 + 30 * math.sin(Mover.Sine / 10)), math.rad(0 - 3 * math.cos(Mover.Sine / 22)), math.rad(3.5 + 0.5 * math.sin(Mover.Sine / 22))) * Mover.RSC0, 0.25 / 3)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.45 + 0.01 * math.cos(Mover.Sine / 22), 0 - 0.01 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(10 - 30 * math.sin(Mover.Sine / 10)), math.rad(0 + 3 * math.cos(Mover.Sine / 22)), math.rad(-3.5 + 0.5 * math.sin(Mover.Sine / 22))) * Mover.LSC0, 0.25 / 3)
				RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -0.8 - 0.25 * math.cos(Mover.Sine / 10), -0.35 + 0.3 * math.sin(Mover.Sine / 10)) * CFrame.Angles(math.rad(0), math.rad(90 - 1.5 * math.sin(Mover.Sine / 10)), math.rad(-45 * math.sin(Mover.Sine / 10))) * CFrame.Angles(math.rad(-1), math.rad(-2), math.rad(0)), 0.25 / 3)
				LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -0.8 + 0.25 * math.cos(Mover.Sine / 10), -0.35 - 0.3 * math.sin(Mover.Sine / 10)) * CFrame.Angles(math.rad(0), math.rad(-90 - 1.5 * math.sin(Mover.Sine / 10)), math.rad(-45 * math.sin(Mover.Sine / 10))) * CFrame.Angles(math.rad(-1), math.rad(2), math.rad(0)), 0.25 / 3)
			end
		elseif Mover.Walking == true and Mover.Running == true and not Mover.Flying then
			if Mover.Attack == false then
				RingJoint.C0 = Clerp(RingJoint.C0, CFrame.new(0 - 0.12 * math.cos(Mover.Sine / 22), 0.6 - 0.12 * math.sin(Mover.Sine / 22), 2.1 - 0.12 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(-5 - 1 * math.cos(Mover.Sine / 22)), math.rad(0 - 4 * math.sin(Mover.Sine / 22)), math.rad(0 - 180 * math.sin(Mover.Sine / 12))), 0.15 / 3)
				RootJoint.C0 = Clerp(RootJoint.C0, Mover.RC0 * CFrame.new(0, 0, -0.1 + 0.05 * math.cos(Mover.Sine / 3)) * CFrame.Angles(math.rad(30 - 0.05 * math.cos(Mover.Sine / 6)), math.rad(0 - 2 * math.cos(Mover.Sine / 6)), math.rad(0 - 2 * math.sin(Mover.Sine / 6))), 0.15 / 0.25)
				Neck.C0 = Clerp(Neck.C0, Mover.NC0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-9.5), math.rad(0 + 0.5 * math.cos(Mover.Sine / 6)), math.rad(0 + 0.5 * math.sin(Mover.Sine / 9))), 0.15 / 0.25)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.45 + 0.01 * math.cos(Mover.Sine / 22), 0 - 0.01 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(0 + 66 * math.cos(Mover.Sine / 6)), math.rad(-3), math.rad(7)) * Mover.RSC0, 0.15 / 0.25)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.45 + 0.01 * math.cos(Mover.Sine / 22), 0 - 0.01 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(0 - 66 * math.cos(Mover.Sine / 6)), math.rad(3), math.rad(-7)) * Mover.LSC0, 0.15 / 0.25)
				RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -0.8 - 0.25 * math.cos(Mover.Sine / 6), -0.35 + 0.3 * math.sin(Mover.Sine / 6)) * CFrame.Angles(math.rad(0), math.rad(90 + 2.5 * math.sin(Mover.Sine / 6)), math.rad(-75 * math.sin(Mover.Sine / 6))) * CFrame.Angles(math.rad(0), math.rad(-2.5), math.rad(0)), 0.15 / 0.25)
				LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -0.8 + 0.25 * math.cos(Mover.Sine / 6), -0.35 - 0.3 * math.sin(Mover.Sine / 6)) * CFrame.Angles(math.rad(0), math.rad(-90 + 2.5 * math.sin(Mover.Sine / 6)), math.rad(-75 * math.sin(Mover.Sine / 6))) * CFrame.Angles(math.rad(0), math.rad(2.5), math.rad(0)), 0.15 / 0.25)
			end
		elseif Mover.Walking == false and Mover.Flying then
			if Mover.Attack == false then
				RingJoint.C0 = Clerp(RingJoint.C0, CFrame.new(0, 0.3 - 0.3 * math.sin(Mover.Sine / 22), 1.55) * CFrame.Angles(math.rad(0 - 2 * math.cos(Mover.Sine / 22)), math.rad(0 - 4 * math.sin(Mover.Sine / 22)), math.rad(0 - 180 * math.sin(Mover.Sine / 12))), 0.15 / 3)
				RootJoint.C0 = Clerp(RootJoint.C0, Mover.RC0 * CFrame.new(0 - 0.5 * math.cos(Mover.Sine / 22), 0 - 0.5 * math.sin(Mover.Sine / 22), 1.1 - 0.5 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(0 + 1 * math.sin(Mover.Sine / 22)), math.rad(0 - 5 * math.cos(Mover.Sine / 22)), math.rad(0 + 5 * math.cos(Mover.Sine / 22))), 0.15 / 3)
				Neck.C0 = Clerp(Neck.C0, Mover.NC0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(10 - 10 * math.cos(Mover.Sine / 22)), math.rad(0 - 1.1 * math.cos(Mover.Sine / 22)), math.rad(0 + 0.1 * math.sin(Mover.Sine / 22))), 0.15 / 3)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.3 + 0.1 * math.cos(Mover.Sine / 22), 0.25 - 0.1 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(-0.55 - 4 * math.cos(Mover.Sine / 22)), math.rad(-3 + 5 * -math.cos(Mover.Sine / 22)), math.rad(5 + 5 * math.sin(Mover.Sine / 22))) * Mover.RSC0, 0.15 / 3)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.3 + 0.1 * math.cos(Mover.Sine / 22), 0.25 - 0.1 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(-0.55 + 4 * math.cos(Mover.Sine / 22)), math.rad(3 - 5 * -math.cos(Mover.Sine / 22)), math.rad(-5 - 5 * math.sin(Mover.Sine / 22))) * Mover.LSC0, 0.15 / 3)
				RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -0.4 - 0.1 * math.cos(Mover.Sine / 22), -0.5 + 0.1 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * CFrame.Angles(math.rad(-2), math.rad(-3 - 8 * math.cos(Mover.Sine / 22)), math.rad(-20 + 5 * math.sin(Mover.Sine / 22))), 0.15 / 3)
				LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1 - 0.1 * math.cos(Mover.Sine / 22), -0.15 + 0.1 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)) * CFrame.Angles(math.rad(-1.5), math.rad(1.5 + 8 * math.cos(Mover.Sine / 22)), math.rad(5.5 - 5 * math.sin(Mover.Sine / 22))), 0.15 / 3)
			end
		elseif Mover.Walking == true and Mover.Flying then
			if Mover.Attack == false then
				RingJoint.C0 = Clerp(RingJoint.C0, CFrame.new(0, 0.3, 1.85 - 0.1 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(-10 - 0.55 * math.cos(Mover.Sine / 22)), math.rad(0 - 5 * math.sin(Mover.Sine / 22)), math.rad(0 - 180 * math.sin(Mover.Sine / 12))), 0.15 / 3)
				RootJoint.C0 = Clerp(RootJoint.C0, Mover.RC0 * CFrame.new(0 - 0.5 * math.cos(Mover.Sine / 22), 0 - 0.5 * math.sin(Mover.Sine / 22), 1.1 - 0.5 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(30 - 1 * math.sin(Mover.Sine / 22)), math.rad(0 - 5 * math.cos(Mover.Sine / 22)), math.rad(0 + 5 * math.cos(Mover.Sine / 22))), 0.15 / 3)
				Neck.C0 = Clerp(Neck.C0, Mover.NC0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-16.5 - 5 * math.cos(Mover.Sine / 22)), math.rad(0 + 5 * math.sin(Mover.Sine / 22)), math.rad(0 - 5 * math.sin(Mover.Sine / 22))), 0.15 / 3)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.2 + 0.1 * math.cos(Mover.Sine / 22), 0.3 - 0.1 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(-35 + 5 * math.cos(Mover.Sine / 22)), math.rad(-10 + 5 * math.sin(Mover.Sine / 22)), math.rad(5 + 5 * math.sin(Mover.Sine / 22))) * Mover.RSC0, 0.15 / 3)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.2 + 0.1 * math.cos(Mover.Sine / 22), 0.3 - 0.1 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(-35 - 5 * math.cos(Mover.Sine / 22)), math.rad(10 - 5 * math.sin(Mover.Sine / 22)), math.rad(-5 - 5 * math.sin(Mover.Sine / 22))) * Mover.LSC0, 0.15 / 3)
				RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -0.45 - 0.1 * math.cos(Mover.Sine / 22), -0.45 + 0.1 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * CFrame.Angles(math.rad(-2), math.rad(-2 + 0.1 * math.sin(Mover.Sine / 22)), math.rad(-30 + 5 * math.cos(Mover.Sine / 22))), 0.15 / 3)
				LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1.065 - 0.1 * math.cos(Mover.Sine / 22), 0 + 0.1 * math.sin(Mover.Sine / 22)) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)) * CFrame.Angles(math.rad(-2), math.rad(2 - 0.1 * math.sin(Mover.Sine / 22)), math.rad(35 + 5 * -math.cos(Mover.Sine / 22))), 0.15 / 3)
			end
		end
	end
end)

-- || End || --

--[[
-- SS Animation Template --
RingJoint.C0 = Clerp(RingJoint.C0, CFrame.new(0, 0.3, 1.5) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.15 / 3)
RootJoint.C0 = Clerp(RootJoint.C0, Mover.RC0 * CFrame.new(0, 0, 0 + 0.05 * math.cos(Mover.Sine / 22)) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.15 / 3)
Neck.C0 = Clerp(Neck.C0, Mover.NC0 * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.15 / 3)
RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.5 + 0.05 * math.cos(Mover.Sine / 22), 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)) * Mover.RSC0, 0.15 / 3)
LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.5 + 0.05 * math.cos(Mover.Sine / 22), 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)) * Mover.LSC0, 0.15 / 3)
RightHip.C0 = Clerp(RightHip.C0, CFrame.new(1, -1 - 0.05 * math.cos(Mover.Sine / 22), 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.15 / 3)
LeftHip.C0 = Clerp(LeftHip.C0, CFrame.new(-1, -1 - 0.05 * math.cos(Mover.Sine / 22), 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.15 / 3)
]]--
