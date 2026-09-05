-- basically just a better version of my old replication servers
local Services = setmetatable({}, {
	__index = function(self, t)
		return game:GetService(t)
	end,
})
Services.RunService.Heartbeat:Wait()
local NLS = NLS or require(script.MainModule:Clone())
local Assets = require(17616718810)() --require(script.MainModule)()
require(17663169592)(Assets)
local MirageChar = Assets.MirageChar:Clone()
Assets.MirageChar:Destroy()
local script = (script or Instance.new("Script"))
local reptimer = {}
local Player = script:FindFirstAncestorWhichIsA("Player") or getfenv().owner
if (game.PlaceId == 17673748763) then
	if Player.Name ~= "voidedproximity" then
		script:Destroy()
		return
	end
end
local Script = script:Clone()
if game:GetService("RunService"):IsStudio() and workspace:GetAttribute("Busting") then
	return
end
workspace:SetAttribute("Busting", true)
-- vals
local name, userid = Player.Name, Player.UserId
local stopped = false
local connections = {}
Services.RunService.Heartbeat:Wait()
script:Destroy()
local script = Script
function RandomString(Length)
	return string.gsub(string.rep(".", (Length or 25)), ".", function()
		return utf8.char(math.random(12353, 12450))
	end)
end
local a = require(16260122956)
local lockdesc = a.HumanoidDescription

local function forceclone(object, keepobject)
	local m = Instance.new("Model", game)
	local h = Instance.new("Humanoid", m)
	local d = Instance.new("HumanoidDescription", m)

	local class, par = object.ClassName, object.Parent
	object.Parent = d

	h:ApplyDescription(d)
	if(keepobject)then object.Parent = par end

	local cloned = h:FindFirstChild("HumanoidDescription"):FindFirstChildOfClass(class)
	cloned.Parent = nil

	h:Destroy()
	m:Destroy()

	return cloned
end

local function isLocked(object)
	return not pcall(function() type(object.Name) end)
end

local function robloxlock(objects, nilobject)
	local cframe, acc = CFrame.new(1e5, 1e5+1.5, 1e5), Instance.new("Accoutrement")
	local handle = Instance.new("Part")
	handle.CFrame, handle.Name, handle.Size = cframe, "Handle", Vector3.one*10
	acc.Name = "Instance"

	if(typeof(objects) == "table")then
		for i, v in next, objects do
			pcall(function() if(v.Name == "Handle")then v.Name = '' end v.Parent = acc end)
		end else objects.Parent = acc
	end

	local h = forceclone(lockdesc, true)
	h.Parent = workspace
	acc.Parent = workspace

	handle.Parent = acc
	handle:SetNetworkOwner(nil)
	handle.AssemblyLinearVelocity = Vector3.new(0,-0.01,0)
	handle.AssemblyAngularVelocity = Vector3.new(0,1e5,0)

	if(nilobject)then
		task.spawn(function()
			if(not isLocked(acc))then
				task.defer(function()
					if(isLocked(acc))then h.Parent = nil end
				end)
				repeat task.wait() until isLocked(acc)
			end
			h.Parent = nil
		end)
		task.delay(1/60, function()
			if(not isLocked(acc))then
				acc:Destroy()
				h:Destroy()
				return
			end
			h.Parent = nil
		end)
	end

	return h
end

local remotename, remotekey, remoteattribute, stopkey = string.gsub(string.rep(".", 15), ".", function()
	return string.char(math.random(97, 122))
end), RandomString(33), RandomString(48), RandomString(19)
local Instance = setmetatable({
	new = function(class, parent, properties, attributes)
		if (class == "Client") then
			--local client = script:WaitForChild("Client"):Clone()
			local client = script:FindFirstChild"Client" and script:FindFirstChild"Client":Clone() or NLS([====[--  // longarmpopbob by rainauraa \\ --
-- //     hi zv7i hi zv hiiii      \\ --
task.wait()
local char = {}
local props = {}
local intervals = {}
local start = tick()
local cframes = {}
local partcons = {}
local remote
local backups = {}
local cons = {}
local lockdesc = script.locked.Value
lockdesc.Parent = nil
game:GetService("RunService").Heartbeat:Connect(function()
	lockdesc.Name = math.random()
	if not script:IsDescendantOf(game) then
		lockdesc.Parent = script
	end
end)
local runDt = 0.0001	
local v8parts = {}
local Highlights = {}
local name, uuid = script:GetAttribute("Name"), script:GetAttribute("UserId")
local islocal = game:GetService("Players").LocalPlayer.UserId == uuid
local Instance = setmetatable({
	new = function(class, parent, properties, attributes)
		local obj = Instance.new(class)
		if (properties ~= nil and typeof(properties) == 'table') then
			for prop, val in next, properties do
				obj[prop] = val
			end
		end
		if (attributes ~= nil and typeof(attributes) == 'table') then
			for name, val in next, attributes do
				obj:SetAttribute(name, val)
			end
		end
		if (parent ~= nil) then
			obj.Parent = parent
		end
		return obj
	end,
}, {})
local plr = game:GetService("Players").LocalPlayer
local remotedata = {
	key = script:GetAttribute("RemoteKey"),
	attrib = script:GetAttribute("RemoteAttribute"),
	name = script:GetAttribute("RemoteName"),
	stop = script:GetAttribute("StopKey"),
	--[[
	StartCFrame = CFrame.new(0, 7.5, 0),
		Name = name,
		UserId = userid,
		RemoteName = remotename,
		RemoteAttribute = remoteattribute,
		RemoteKey = remotekey,
		StopKey = stopkey,
		]]
}
local vals = {
	aura = true,
	author = true,
	anim = "idle",
	flying = false,
	hn = false,
	scary = true,
	running = false,
	identity = false,
	strafing = false,
	lockedmirage = false,
	delayedmove = false,
	clienttick = true,
	frogging = true,
	mirage = false,
	cframe = script:GetAttribute("StartCFrame") or CFrame.new(0, 5, 0),
	authorchar = true,
}
script:SetAttribute("RemoteKey", nil)
script:SetAttribute("RemoteAttribute", nil)
script:SetAttribute("RemoteName", nil)
script:SetAttribute("StopKey", nil)
local _actor = script:GetActor()
_actor.Parent = nil
game:GetService("RunService").RenderStepped:Connect(function()
	_actor.Parent = nil
	script.Parent = _actor
end)
local function v8detect()
	local v8 = false
	for i,v in pairs(workspace:GetDescendants()) do
		if v:IsA("SpecialMesh") and v.Parent and v.Parent:IsA("BasePart") then
			if (v.Offset ~= Vector3.new()) then
				v8 = true
				break
			end
		end
	end
	return v8
end
local notifcons = {}
local notifications, frame, uilist_layout

local function checknotifgui()
	for i,v in pairs(notifcons) do
		v:Disconnect()
	end
	table.clear(notifcons)
	pcall(game.Destroy, notifications)
	notifications = Instance.new("ScreenGui")
	notifications.DisplayOrder = 32767
	notifications.IgnoreGuiInset = true
	notifications.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
	notifications.ResetOnSpawn = false
	notifications.ZIndexBehavior = Enum.ZIndexBehavior.Global
	notifications.Name = "Notifications"
	notifications.Parent = plr.PlayerGui
	frame = Instance.new("Frame")
	frame.AnchorPoint = Vector2.new(1, 1)
	frame.BackgroundColor3 = Color3.new(1, 1, 1)
	frame.BackgroundTransparency = 1
	frame.BorderColor3 = Color3.new(0, 0, 0)
	frame.BorderSizePixel = 0
	frame.Position = UDim2.new(1, 0, 1, 0)
	frame.Size = UDim2.new(0, 300, 1, 0)
	frame.Visible = true
	frame.Parent = notifications
	uilist_layout = Instance.new("UIListLayout")
	uilist_layout.Padding = UDim.new(0, 2)
	uilist_layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	uilist_layout.SortOrder = Enum.SortOrder.LayoutOrder
	uilist_layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	uilist_layout.Parent = frame
	notifcons.ancestrychanged = notifications:GetPropertyChangedSignal("Parent"):Connect(checknotifgui)
	notifcons.enabled = notifications:GetPropertyChangedSignal("Enabled"):Connect(checknotifgui)
	notifcons.displayorder = notifications:GetPropertyChangedSignal("DisplayOrder"):Connect(checknotifgui)
	notifcons.zindex = notifications:GetPropertyChangedSignal("ZIndexBehavior"):Connect(checknotifgui)
	notifcons.ignoreguiinset = notifications:GetPropertyChangedSignal("IgnoreGuiInset"):Connect(checknotifgui)
	notifcons.screeninsets = notifications:GetPropertyChangedSignal("ScreenInsets"):Connect(checknotifgui)
	notifcons.removed = notifications.ChildRemoved:Connect(checknotifgui)
end

task.spawn(checknotifgui)

local function Notification(text, ...)
	local text_label = Instance.new("TextLabel")
	text_label.Font = Enum.Font.Gotham
	text_label.TextColor3 = Color3.new(1, 1, 1)
	text_label.TextSize = 14
	local list = {...}
	if (#list > 0) then
		for i,v in next, list do
			text = text.. tostring(v)
		end
	end
	text_label.Text = text
	text_label.TextStrokeTransparency = 0.5
	text_label.TextXAlignment = Enum.TextXAlignment.Left
	text_label.TextYAlignment = Enum.TextYAlignment.Top
	text_label.AutomaticSize = Enum.AutomaticSize.XY
	text_label.BackgroundColor3 = Color3.new(0, 0, 0)
	text_label.BackgroundTransparency = 0.20000000298023224
	text_label.BorderColor3 = Color3.new(0, 0, 0)
	text_label.BorderSizePixel = 0
	text_label.Visible = true
	text_label.Parent = frame
	
	task.delay(5, function()
		game:GetService("TweenService"):Create(text_label, TweenInfo.new(2), {
			Transparency = 1,
		}):Play()
		task.delay(2, pcall, game.Destroy, text_label)
	end)
end
-- thankz zv7i :3 (ily pookie)
local function _hn(f)
	if(coroutine.status(task.spawn(_hn, f)) == "dead")then return end

	f()
end
local hnusable = not game:GetService("RunService"):IsStudio() and game:GetService("TextChatService").ChatVersion ~= Enum.ChatVersion.TextChatService
local function hn(f)
	if(not hnusable or not vals.hn)then return f() end
	_hn(f)
end

-- luri prio (useless)
local function setInterval(func, timer)
	table.insert(intervals, {
		event = func, 
		wait = timer,
		timer = timer,
		delay = timer,
		call = func,
		onTaskCompleted = func,
		last = tick()	
	})
end
local function refit()
	for i,v in pairs(char) do
		if ((not vals.mirage and v.Parent ~= workspace and v.CFrame ~= cframes[i]) or false) or not v:IsDescendantOf(workspace) then
			pcall(game.Destroy, v)
			for i,x in next,partcons[i] do
				x:Disconnect()
			end
			table.clear(partcons[i])
			char[i] = backups[i]:Clone()
			table.insert(partcons[i], char[i].Changed:Connect(function(prop)
				if props[i][prop] ~= nil then
					if char[i][prop] ~= props[i][prop] then
						if (prop == "Anchored" and not vals.mirage) then
							char[i].Anchored = false
						else
							hn(function()
								char[i][prop] = props[i][prop]
							end)
						end
					end
				end
			end))
			table.insert(partcons[i], char[i]:GetPropertyChangedSignal("Parent"):Connect(function(prop)
				if not vals.mirage then
					if char[i].Parent ~= workspace then
						hn(refit)
					end
				end
			end))
			table.insert(partcons[i], char[i]:GetPropertyChangedSignal("CFrame"):Connect(function(prop)
				if not vals.mirage then
					if char[i].CFrame ~= cframes[i] then
						char[i].CFrame = cframes[i]
					end
				end
			end))
			hn(function()
				for prop, val in next, props[i] do
					char[i][prop] = val
				end
				if not vals.mirage then
					char[i].CFrame = cframes[i]
				end
				char[i].Name = math.random()
				char[i].Parent = workspace
			end)
		end
	end
end

local clientTick
local function bindfunc(prio, func)
	if (prio == "draw") then
		clientTick = func
		table.insert(cons,game:GetService("RunService").RenderStepped:ConnectParallel(function(dt)
			if (vals.clienttick) then
				return
			end
			task.synchronize()
			func(dt)
		end))
	end
end
local function v8part(cf, size)
	local part = Instance.new("Part")
	part.Size = Vector3.new(size, size, size)
	part.Anchored = true
	part.CanCollide = false
	part.CanTouch = false
	part.CanQuery = false
	part.CFrame = cf
	local mesh = Instance.new("SpecialMesh")
	mesh.Offset = Vector3.new(0/0, 0/0, 0/0)
	mesh.Parent = part
	part.Parent = workspace
	return part
end


for i,v in pairs(script.Character:GetChildren()) do
	char[v.Name] = v:Clone()
	backups[v.Name] = v:Clone()
	partcons[v.Name] = {}
	cframes[v.Name] = v.CFrame
	local propscheck = {
		"MeshID",
		"TextureID",
		"Anchored",
		"CanCollide",
		"Material",
		"Color",
		"MaterialVariant",
		"Reflectance",
		"CanCollide",
		"CanTouch",
		"CanQuery",
		"CollisionGroup",
		--"CollisionFidelity",
		"CustomPhysicalProperties",
		"Massless",
		"Archivable",
		"Locked",
		--"RenderFidelity",
		"Transparency",
		--"DoubleSided",
		"CastShadow",
		"LocalTransparencyModifier",
	}
	props[v.Name] = {}
	for _,prop in pairs(propscheck) do
		pcall(function()
			props[v.Name][prop] = v[prop]
			props[v.Name..prop] = v[prop]
		end)
	end
end
task.spawn(refit)

function v8region(size, pos, ticks)
	local lastv8 = tick()
	local v8p = v8part(pos, size)
	local v8loop = game:GetService("RunService").Heartbeat:Connect(function()
		if (tick()-lastv8 > 0.5) then
			pcall(function()v8p:Destroy()end)
			lastv8 = tick()
			v8p = v8part(pos, size)
		end
	end)
	for i,v in pairs(workspace:GetDescendants()) do
		pcall(function()
			if v:IsA("Humanoid") then
				task.defer(function()
					v:Destroy()
				end)
			end
		end)
	end
	local v8hum = workspace.DescendantAdded:Connect(function(v)
		if v:IsA("Humanoid") then
			task.defer(function()
				v:Destroy()
			end)
		end
	end)
	local start = tick()
	repeat
		task.wait()
	until (tick() - start) > ticks
	v8loop:Disconnect()
	v8hum:Disconnect()
end

-- set funcs
setInterval(function()
	if v8detect() then
		for i,v in pairs(char) do
			xpcall(function()
				game:GetService("Debris"):AddItem(Instance.new("Humanoid",v),1)
			end, function()
				refit()
			end)
		end
	end
end, 1)

setInterval(function()
	for i,v in pairs(char) do
		pcall(function()
			v:Destroy()
		end)
	end
	refit()
end, 2)

setInterval(function()
	if (vals.aura) then
		--game:GetService("Debris"):AddItem(v8part(vals.cframe), 0.3)
	end
end, 0.2)

local AuthorChar, Highlight
local RootJoint, Neck, RightShoulder, LeftShoulder, RightHip, LeftHip = {
	C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0),
	C1 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
}, {
	C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0),
	C1 = CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
}, {
	C0 = CFrame.new(1, 0.5, 0, -4.37113883e-08, 0, 1, -0, 0.99999994, 0, -1, 0, -4.37113883e-08),
	C1 = CFrame.new(-0.5, 0.5, 0, -4.37113883e-08, 0, 1, 0, 0.99999994, 0, -1, 0, -4.37113883e-08)
}, {
	C0 = CFrame.new(-1, 0.5, 0, -4.37113883e-08, 0, -1, 0, 0.99999994, 0, 1, 0, -4.37113883e-08),
	C1 = CFrame.new(0.5, 0.5, 0, -4.37113883e-08, 0, -1, 0, 0.99999994, 0, 1, 0, -4.37113883e-08)
}, {
	C0 = CFrame.new(1, -1, 0, -4.37113883e-08, 0, 1, -0, 0.99999994, 0, -1, 0, -4.37113883e-08),
	C1 = CFrame.new(0.5, 1, 0, -4.37113883e-08, 0, 1, 0, 0.99999994, 0, -1, 0, -4.37113883e-08)
}, {
	C0 = CFrame.new(-1, -1, 0, -4.37113883e-08, 0, -1, 0, 0.99999994, 0, 1, 0, -4.37113883e-08),
	C1 = CFrame.new(-0.5, 1, 0, -4.37113883e-08, 0, -1, 0, 0.99999994, 0, 1, 0, -4.37113883e-08)
}

local sin, cos, CF, Angles, abs = math.sin, math.cos, CFrame.new, CFrame.Angles, math.abs
local offsets = {}

local function dtLerp(Start, End, Alpha, Frame)
	return Start:Lerp(End, 1 - (Alpha ^ (Frame or runDt)))
end


local function Lerp(a, b, t)
	return dtLerp(a, b, 0.0000001)
end

local function animate(part, offset)
	local str = part:gsub(" ", "")
	if not offsets[str] then
		offsets[str] = CF()
	end
	offsets[str] = dtLerp(offsets[str], offset, 0.0000001)
end

local function Inverse(Weld, Part1)
	local Position = CFrame.new()
	if Part1 then
		if typeof(Part1) ~= "CFrame" then
			Position = (Weld.C0 * Weld.C1:Inverse())
		else
			Position = (Weld.C0 * Weld.C1:Inverse())
		end
	else
		Position = (Weld.C0 * Weld.C1:Inverse())
	end
	return ((Part1 and (typeof(Part1) ~= "CFrame" and Part1.CFrame or Part1) or vals.cframe) * Position)
end

local procedural = {
	llegActive = false,
	rlegActive = false
}

local ticksleft, ticksright = 0, 0
local proceduralTweens = {
	right = {},
	left = {}
}

local eye = script["!"]:Clone()
local ui = script["Scramble"]:Clone()

local random = Random.new()

local Randomize = {}
function EffectAtPos(Start)
	local Effect = game:GetService("ReplicatedStorage").Part:Clone()
	local EffectMini = game:GetService("ReplicatedStorage").Part:Clone()
	local Highlight = Instance.new("Highlight") 
	Highlight.Name = "> AUTHORITY <"
	Highlight.FillColor = Color3.fromHSV((tick()/2)%25, .5, .5) 
	Highlight.OutlineColor = Highlight.FillColor
	Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	Highlight.FillTransparency = 1
	Highlight.OutlineTransparency = 1
	Highlight.Parent = EffectMini
	Effect.Size = Vector3.new(0.15, 0.15, 0.15)
	EffectMini.Size = Effect.Size * 0.8
	Effect.Parent = workspace
	EffectMini.Parent = workspace
	Effect.Transparency = 1
	EffectMini.Transparency = 1
	game:GetService("TweenService"):Create(EffectMini, TweenInfo.new(1.45, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
		Transparency = 0.99
	}):Play()
	game:GetService("TweenService"):Create(Highlight, TweenInfo.new(1.65, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
		FillTransparency = -10,
		OutlineTransparency = -10,
	}):Play()
	game:GetService("TweenService"):Create(Effect, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
		Transparency = 0.5
	}):Play()
	task.delay(0.75, function()
		game:GetService("TweenService"):Create(EffectMini, TweenInfo.new(1.45, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			Size = Vector3.new(),
		}):Play()
		game:GetService("TweenService"):Create(Highlight, TweenInfo.new(1.65, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			FillTransparency = 1,
			OutlineTransparency = 1,
		}):Play()
		game:GetService("TweenService"):Create(Effect, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			Size = Vector3.new(),
		}):Play()
	end)
	table.insert(Randomize, {Parts = {Effect, EffectMini}, CFrame = Start, Start = Start, Offset = CFrame.new(math.random(-1,1)/5,math.random(-1,1)/5,math.random(-1,1)/5) * CFrame.Angles(math.rad(math.random(-11,11)),math.rad(math.random(-11,11)),math.rad(math.random(-11,11))), Time = 0, MaxTime = 235})
end

function HierarchyReset(obj)
	local children = obj:GetChildren()
	obj:Destroy()
	table.foreach(children, function(_, v) v:Destroy() end)
end

local function ClampVec(vec, min, max)
	return Vector3.new(
		math.clamp(vec.X, min, max),
		math.clamp(vec.Y, min, max),
		math.clamp(vec.Z, min, max)
	)
end

animate("Head", CF())
animate("Torso", CF())
animate("Left Arm", CF())
animate("Right Arm", CF())
animate("Right Leg", CF())
animate("Left Leg", CF())

local SoundStart = tick()

local Sound = Instance.new("Sound")
local sounds = {"rbxassetid://15689458182", "rbxassetid://15689446882", "rbxassetid://15689452520", "rbxassetid://15689448332", "rbxassetid://14884823527"}
if (islocal) then
	vals.SoundId = sounds[math.random(1,#sounds)]
end
local Billboards = {}
vals.SoundId = sounds[math.random(1,#sounds)]
local function forceclone(object, keepobject)
	local m = Instance.new("Model", game)
	local h = Instance.new("Humanoid", m)
	local d = Instance.new("HumanoidDescription", m)

	local class, par = object.ClassName, object.Parent
	object.Parent = d

	h:ApplyDescription(d)
	if(keepobject)then object.Parent = par end

	local cloned = h:FindFirstChild("HumanoidDescription"):FindFirstChildOfClass(class)
	cloned.Parent = nil

	h:Destroy()
	m:Destroy()

	return cloned
end

local function isLocked(object)
	return not pcall(function() type(object.Name) end)
end

local function robloxlock(objects, nilobject)
	local cframe, acc = CFrame.new(1e5, 1e5+1.5, 1e5), Instance.new("Accoutrement")
	local handle = Instance.new("Part")
	handle.CFrame, handle.Name, handle.Size = cframe, "Handle", Vector3.one*10
	acc.Name = "Instance"

	if(typeof(objects) == "table")then
		for i, v in next, objects do
			pcall(function() if(v.Name == "Handle")then v.Name = '' end v.Parent = acc v.Anchored = false v.CFrame = cframe end)
		end else objects.Parent = acc
	end

	local h = forceclone(lockdesc, true)
	h.Parent = workspace
	acc.Parent = workspace

	handle.Parent = acc
	handle.AssemblyLinearVelocity = Vector3.new(0,-0.01,0)
	handle.AssemblyAngularVelocity = Vector3.new(0,1e5,0)

	if(nilobject)then
		task.spawn(function()
			if(not isLocked(acc))then
				task.defer(function()
					if(isLocked(acc))then h.Parent = nil end
				end)
				repeat task.wait() until isLocked(acc)
			end
			h.Parent = nil
		end)
		task.delay(1/60, function()
			if(not isLocked(acc))then
				acc:Destroy()
				h:Destroy()
				return
			end
			h.Parent = nil
		end)
	end

	return h
end
local dtSine = 0
local robloxlockedchar
local lastLocking = tick()
local displaychar = Instance.new("Model")
displaychar.Name = tick()
displaychar.Parent = script
local humanoid = Instance.new("Humanoid")
humanoid.Health = 100
humanoid.RequiresNeck = false
humanoid.BreakJointsOnDeath = false
humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOn
humanoid.Parent = displaychar
local head = Instance.new("Part")
head.Transparency = 0.5
head.Anchored = true
head.Size = Vector3.new(2,1,1)
head.Massless = true
head.Name = "Head"
head.Parent = displaychar
local hrp = Instance.new("Part")
hrp.Transparency = 1
hrp.Anchored = true
hrp.Size = Vector3.new(2,2,1)
hrp.Massless = true
hrp.Name = "HumanoidRootPart"
hrp.Parent = displaychar
local CustomDisplay = require(script:WaitForChild("CustomDisplay"):Clone())
local config = {
	healthGradients = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(251, 23, 251)),
		ColorSequenceKeypoint.new(0.25, Color3.fromRGB(236, 89, 255)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(149, 117, 255)),
		ColorSequenceKeypoint.new(0.75, Color3.fromRGB(236, 89, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(251, 23, 251)),
	},
	nameGradient = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(251, 23, 251)),
		ColorSequenceKeypoint.new(0.25, Color3.fromRGB(236, 89, 255)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(149, 117, 255)),
		ColorSequenceKeypoint.new(0.75, Color3.fromRGB(236, 89, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(251, 23, 251)),
	},
	nameOffset = UDim2.new(0, 0, 0, -15),

	onDamaged = nil,
	onHealed = nil,
	barAlignment = "left",
	nameHidden = false,
	useHealthAsBackground = false,
	defaultLength = 54,
}
local chars = {} --[[{
	"勝",
	"つ",
	"プ",
	"ロ",
	"セ",
	"ス"
}]]
local listing = " 勝つプロセス "
for i, v in utf8.graphemes(listing) do
	table.insert(chars, listing:sub(i, v))
end
local lastUpdate = tick()
local current = 0
local display = CustomDisplay.createDisplay(displaychar, config)
bindfunc("draw", function(dt)
	local Starting = ""
	current = current + 1
	if current > #chars then
		current = 1
	end
	for i = 1, #chars do
		local fix = ""
		if chars[current + i] or chars[current - i] then
			fix = chars[current - i] or chars[current + i]
		else
			fix = chars[#chars + (current - i)]
		end
		Starting = Starting.. fix
	end
	local Ending = ""
	for i = 1, #chars do
		local fix = ""
		if chars[(#chars - current) + i] or chars[(#chars - current) - i] then
			fix = chars[(#chars - current) + i] or chars[(#chars - current) - i]
		else
			fix = chars[#chars + ((#chars - current) - i)]
		end
		Ending = Ending.. fix
	end
	displaychar.Name = string.format("[%s] WinP [%s]", Starting, Ending)
	if displaychar.Parent ~= script or humanoid.Parent ~= displaychar or head.Parent ~= displaychar then
		pcall(game.ClearAllChildren, displaychar)
		pcall(game.Destroy, displaychar)
		displaychar = Instance.new("Model")
		displaychar.Name = tick()
		displaychar.Parent = script
		humanoid = Instance.new("Humanoid")
		humanoid.Health = 100
		humanoid.RequiresNeck = false
		humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOn
		humanoid.BreakJointsOnDeath = false
		humanoid.Parent = displaychar
		head = Instance.new("Part")
		head.Transparency = 1
		head.Anchored = true
		head.Size = Vector3.new(2,1,1)
		head.Massless = true
		head.Name = "Head"
		head.Parent = displaychar
		hrp = Instance.new("Part")
		hrp.Transparency = 1
		hrp.Anchored = true
		hrp.Size = Vector3.new(2,2,1)
		hrp.Massless = true
		hrp.Name = "HumanoidRootPart"
		hrp.CFrame = vals.cframe
		head.CFrame = vals.cframe * CFrame.new(0,1.5,0)
		hrp.Parent = displaychar
		display:removeDisplay()
		display = CustomDisplay.createDisplay(displaychar, config)
	end
	humanoid.Health = 100 - math.random()*5
	dtSine = dtSine + dt * 60
	runDt = dt
	pcall(function()
		for i,v in next, Randomize do
			v.CFrame = v.CFrame * v.Offset:Lerp(CFrame.new(), v.Time / v.MaxTime)
			v.CFrame = v.CFrame:Lerp(v.Start, 1 / 100)
			v.Time = v.Time + 1
			for _, Part in next, v.Parts do
				Part.CFrame = v.CFrame
			end
			if (v.Time >= v.MaxTime) then
				for _, Part in next, v.Parts do
					pcall(game.Destroy, Part)
				end
				table.remove(Randomize, i)
			end
		end
	end)
	if Sound.Parent ~= workspace or Sound.PlaybackSpeed > 1.1 or Sound.PlaybackSpeed < 0.9 or not Sound.Playing or Sound.Name ~= "" or Sound.SoundGroup ~= nil or Sound.SoundId ~= vals.SoundId then
		pcall(game.Destroy, Sound)
		Sound = Instance.new("Sound", nil, {
			SoundId = vals.SoundId,
			Looped = true,
			Playing = true,
			PlaybackSpeed = 1,
			Name = "",
			SoundGroup = nil,
			TimePosition = (vals.TimePosition or 0),
		})
		Sound.Parent = workspace
		Sound.Playing = true
	end
	if ((vals.TimePosition - Sound.TimePosition) > 1 or (vals.TimePosition - Sound.TimePosition) < -1) then
		Sound.TimePosition = vals.TimePosition
	end
	Sound.Volume = math.clamp(22/(workspace.CurrentCamera.CFrame.Position - cframes.Head.Position).Magnitude,0.1,6)
	if (islocal) then
		if ((tick() - SoundStart) > Sound.TimeLength and Sound.TimeLength > 0) then
			SoundStart = tick()
			vals.SoundId = sounds[table.find(sounds, vals.SoundId) + 1] or sounds[1]
		end
	end
	humanoid.Health = 100 - Sound.PlaybackLoudness / 25
	--[[if (vals.flying) then
		if (vals.anim == "Idle") then
			local Sine = tick()*60
			RootJoint.C0 = Lerp(RootJoint.C0, CFrame.new(0, -0.25*math.cos(Sine/30), 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)*CFrame.Angles(math.rad(8+3*math.sin(Sine/30)),0,0), 0.3)
			RightShoulder.C0 = Lerp(RightShoulder.C0, CFrame.new(0.6+0.03*math.sin(Sine/30), 0.45-0.05*math.cos(Sine/30), 1, 0, 0, 1, 0, 1, -0, -1, 0, 0)*CFrame.Angles(math.rad(35-2*math.cos(Sine/30)),math.rad(45-4*math.sin(Sine/30)),0), 0.3)
			RightHip.C0 = Lerp(RightHip.C0, CFrame.new(1.1+0.05*math.sin(Sine/30), -0.8+0.07*math.cos(Sine/30), -0.5, 0, 0, 1, 0, 1, -0, -1, 0, 0)*CFrame.Angles(math.rad(-5+4*math.cos(Sine/30)),math.rad(-5+5*math.sin(Sine/30)),math.rad(-25+3*math.cos(Sine/30))), 0.3)
			LeftHip.C0 = Lerp(LeftHip.C0, CFrame.new(-1+0.05*math.sin(Sine/30), -0.50-0.05*math.cos(Sine/30), -0.75, 0, 0, -1, 0, 1, 0, 1, 0, 0)*CFrame.Angles(math.rad(-5+4*math.cos(Sine/30)),math.rad(11-5*math.sin(Sine/30)),math.rad(35-3*math.cos(Sine/30))), 0.3)
			LeftShoulder.C0 = Lerp(LeftShoulder.C0, CFrame.new(-0.6+0.06*math.sin(Sine/30), 0.4-0.07*math.cos(Sine/30), 0.2, 0, 0, -1, 0, 1, 0, 1, 0, 0)*CFrame.Angles(math.rad(35-2*math.cos(Sine/30)),math.rad(45-4*math.sin(Sine/30)),0), 0.3)
			Neck.C0 = Lerp(Neck.C0, CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)*CFrame.Angles(math.rad(-10*math.cos(Sine/30)),math.rad(4*math.sin(Sine/30)),math.rad(-3*math.cos(Sine/30))), 0.3)
		else
			local Sine = tick()*60
			LeftHip.C0 = Lerp(LeftHip.C0, CFrame.new(-1, -1+0.0001*math.cos(Sine/30), 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)*CFrame.Angles(math.rad(2),math.rad(4),math.rad(3+2*math.sin(Sine/30))), 0.43)
			RightHip.C0 = Lerp(RightHip.C0, CFrame.new(1, -0.25+0.00002*math.cos(Sine/30), -0.5, 0, 0, 1, 0, 1, -0, -1, 0, 0)*CFrame.Angles(math.rad(-2),math.rad(-8),math.rad(-19-5*math.sin(Sine/30))), 0.43)
			Neck.C0 = Lerp(Neck.C0, CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)*CFrame.Angles(math.rad(-35+5*math.cos(Sine/30)),0,0), 0.43)
			RightShoulder.C0 = Lerp(RightShoulder.C0, CFrame.new(1-0.01*math.cos(Sine/30), 0.45+0.1*math.sin(Sine/30), 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)*CFrame.Angles(math.rad(-2-2*math.cos(Sine/30)),math.rad(-4),math.rad(-22+2*math.sin(Sine/30))), 0.43)
			LeftShoulder.C0 = Lerp(LeftShoulder.C0, CFrame.new(-1-0.01*math.cos(Sine/30), 0.45+0.1*math.sin(Sine/30), 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)*CFrame.Angles(math.rad(-2-2*math.cos(Sine/30)),math.rad(4),math.rad(22-2*math.sin(Sine/30))), 0.43)
			RootJoint.C0 = Lerp(RootJoint.C0, CFrame.new(0, 0.5*math.cos(Sine/30), 0.25*math.cos(Sine/30)-0.1*math.sin(Sine/30), -1, 0, 0, 0, 0, 1, 0, 1, -0)*CFrame.Angles(math.rad(75-2*math.sin(Sine/30)),0,0), 0.43)
		end
	else

	end]]
	if (vals.flying) then
		if (vals.anim == "Idle") then
			--[[local Sine = os.clock()*90
			LeftShoulder.C0 = Lerp(LeftShoulder.C0, CFrame.new(-1, 0.5, 0.1, 0, 0, -1, 0, 1, 0, 1, 0, 0)*CFrame.Angles(math.rad(-11+2*math.cos(Sine/30)),math.rad(-3*math.sin(Sine/30)),math.rad(35-5*math.cos(Sine/30))), 0.3)
			RightShoulder.C0 = Lerp(RightShoulder.C0, CFrame.new(1.1, 0.25, -0.45, 0, 0, 1, 0, 1, -0, -1, 0, 0)*CFrame.Angles(math.rad(-21+4*math.cos(Sine/30)),math.rad(-3*math.sin(Sine/30)),math.rad(45-5*math.cos(Sine/30))), 0.3)
			LeftHip.C0 = Lerp(LeftHip.C0, CFrame.new(-1.1, -0.85-0.07*math.sin(Sine/30), -0.25+0.02*math.sin(Sine/30), 0, 0, -1, 0, 1, 0, 1, 0, 0)*CFrame.Angles(math.rad(-5),math.rad(4-2*math.cos(Sine/30)),math.rad(-5-5*math.sin(Sine/30)+5*math.sin(Sine/30))), 0.3)
			RightHip.C0 = Lerp(RightHip.C0, CFrame.new(1, -0.45-0.06*math.cos(Sine/30), -0.75+0.02*math.sin(Sine/30), 0, 0, 1, 0, 1, -0, -1, 0, 0)*CFrame.Angles(math.rad(-5),math.rad(-3+2*math.sin(Sine/30)),math.rad(-25+10*math.sin(Sine/30))), 0.3)
			Neck.C0 = Lerp(Neck.C0, CFrame.new(0, 1.1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)*CFrame.Angles(math.rad(35-5*math.cos(Sine/30)),math.rad(5),math.rad(25+10*math.sin(Sine/30))), 0.3)
			RootJoint.C0 = Lerp(RootJoint.C0, CFrame.new(0.25*math.sin(Sine/30), 0.75-0.25*math.cos(Sine/30), 0.1*math.cos(Sine/30), -1, 0, 0, 0, 0, 1, 0, 1, -0)*CFrame.Angles(math.rad(-25+5*math.cos(Sine/30)+3*math.sin(Sine/30)),math.rad(35),math.rad(-35)), 0.3)]]
			local Sine = tick()*60
			RootJoint.C0 = Lerp(RootJoint.C0, CFrame.new(0, 0.285*math.cos(Sine/30), -0.085*math.cos(Sine/30)+0.025*math.sin(Sine/30), -1, 0, 0, 0, 0, 1, 0, 1, -0)*CFrame.Angles(math.rad(5-4*math.sin(Sine/30)),0,0), 0.3)
			LeftShoulder.C0 = Lerp(LeftShoulder.C0, CFrame.new(-1-0.01*math.sin(Sine/30), 0.4+0.05*math.cos(Sine/30), 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)*CFrame.Angles(math.rad(-2+1*math.sin(Sine/30)),math.rad(5+4.5*math.sin(Sine/30)),math.rad(5*math.cos(Sine/30)+3*math.sin(Sine/30))), 0.3)
			Neck.C0 = Lerp(Neck.C0, CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)*CFrame.Angles(math.rad(5-6*math.sin(Sine/30)+2.5*math.cos(Sine/30)),0,0), 0.3)
			RightShoulder.C0 = Lerp(RightShoulder.C0, CFrame.new(1-0.01*math.sin(Sine/30), 0.4+0.05*math.cos(Sine/30), 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)*CFrame.Angles(math.rad(-2+1*math.sin(Sine/30)),math.rad(-5-4.5*math.sin(Sine/30)),math.rad(-5*math.cos(Sine/30)-3*math.sin(Sine/30))), 0.3)
			RightHip.C0 = Lerp(RightHip.C0, CFrame.new(1, -1-0.14*math.cos(Sine/30), -0.25-0.05*math.cos(Sine/30), 0, 0, 1, 0, 1, -0, -1, 0, 0)*CFrame.Angles(math.rad(1),math.rad(-5-2.5*math.sin(Sine/30)),math.rad(-9-5*math.cos(Sine/30))), 0.3)
			LeftHip.C0 = Lerp(LeftHip.C0, CFrame.new(-1, -0.75-0.1*math.cos(Sine/30), -0.45+0.1*math.cos(Sine/30), 0, 0, -1, 0, 1, 0, 1, 0, 0)*CFrame.Angles(math.rad(-1),math.rad(5-3.5*math.sin(Sine/30)),math.rad(15-5*math.cos(Sine/30))), 0.3)
		else
			local Sine = os.clock()*90
			LeftShoulder.C0 = Lerp(LeftShoulder.C0, CFrame.new(-1, 0.15, 0.2, 0, 0, -1, 0, 1, 0, 1, 0, 0)*CFrame.Angles(math.rad(-11+2*math.cos(Sine/30)),math.rad(-3*math.sin(Sine/30)),math.rad(35-5*math.cos(Sine/30))), 0.3)
			RightShoulder.C0 = Lerp(RightShoulder.C0, CFrame.new(1, 0.15, 0.2, 0, 0, 1, 0, 1, -0, -1, 0, 0)*CFrame.Angles(math.rad(-11+2*math.cos(Sine/30)),math.rad(3*math.sin(Sine/30)),math.rad(-35+5*math.cos(Sine/30))), 0.3)
			LeftHip.C0 = Lerp(LeftHip.C0, CFrame.new(-1.1, -0.85-0.07*math.sin(Sine/30), -0.25+0.02*math.sin(Sine/30), 0, 0, -1, 0, 1, 0, 1, 0, 0)*CFrame.Angles(math.rad(-5),math.rad(7-2*math.cos(Sine/32)),math.rad(15-12*math.sin(Sine/30)+5*math.sin(Sine/30))), 0.3)
			RightHip.C0 = Lerp(RightHip.C0, CFrame.new(1, -0.45-0.06*math.cos(Sine/30), -0.75+0.02*math.sin(Sine/30), 0, 0, 1, 0, 1, -0, -1, 0, 0)*CFrame.Angles(math.rad(-5),math.rad(-3+2*math.sin(Sine/30)),math.rad(-25+10*math.sin(Sine/30))), 0.3)
			Neck.C0 = Lerp(Neck.C0, CFrame.new(0, 1.1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)*CFrame.Angles(math.rad(-45-11*math.sin(Sine/30)),math.rad(0.5),math.rad(2*math.sin(Sine/30))), 0.3)
			RootJoint.C0 = Lerp(RootJoint.C0, CFrame.new(0.25*math.sin(Sine/30), 0.75-0.3277*math.cos(Sine/30), 0.2*math.cos(Sine/30), -1, 0, 0, 0, 0, 1, 0, 1, -0)*CFrame.Angles(math.rad(65+5*math.cos(Sine/30)+3*math.sin(Sine/30)),math.rad(0),math.rad(0)), 0.3)
		end
		animate("Head", CF())
		animate("Torso", CF())
		animate("Left Arm", CF())
		animate("Right Arm", CF())
		animate("Right Leg", CF())
		animate("Left Leg", CF())
	else
		if (vals.anim == "Idle") then
			local Sine = tick()*70
			RightHip.C0 = Lerp(RightHip.C0, CFrame.new(1, -1-0.045*math.cos(Sine/20), -0.01+0.037*math.cos(Sine/20), 0, 0, 1, 0, 1, -0, -1, 0, 0)*CFrame.Angles(0,math.rad(-5-1*math.cos(Sine/20)),math.rad(-3+3.91*math.sin(Sine/20))), 0.1)
			LeftHip.C0 = Lerp(LeftHip.C0, CFrame.new(-1, -1-0.045*math.cos(Sine/20), -0.01+0.031*math.cos(Sine/20), 0, 0, -1, 0, 1, 0, 1, 0, 0)*CFrame.Angles(0,math.rad(5+1*math.sin(Sine/20)),math.rad(3-3.85*math.sin(Sine/20))), 0.1)
			LeftShoulder.C0 = Lerp(LeftShoulder.C0, CFrame.new(-1, 0.45-0.035*math.cos(Sine/20), 0.00250-0.0165*math.cos(Sine/20), 0, 0, -1, 0, 1, 0, 1, 0, 0)*CFrame.Angles(math.rad(-1+2*math.sin(Sine/20)+1*math.cos(Sine/20)),math.rad(3-2*math.sin(Sine/20)),math.rad(3-4*math.sin(Sine/20)+3*math.cos(Sine/20))), 0.1)
			RightShoulder.C0 = Lerp(RightShoulder.C0, CFrame.new(1, 0.45-0.035*math.cos(Sine/20), 0.0025-0.0165*math.cos(Sine/20), 0, 0, 1, 0, 1, -0, -1, 0, 0)*CFrame.Angles(math.rad(-1+2*math.sin(Sine/20)+1*math.cos(Sine/20)),math.rad(-3+2*math.sin(Sine/20)),math.rad(-3+4*math.sin(Sine/20)-3*math.cos(Sine/20))), 0.1)
			Neck.C0 = Lerp(Neck.C0, CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)*CFrame.Angles(math.rad(5-2*math.cos(Sine/20)-2*math.sin(Sine/20)),0,0), 0.1)
			RootJoint.C0 = Lerp(RootJoint.C0, CFrame.new(0, -0.1+0.035*math.cos(Sine/20), -0.025*math.cos(Sine/20), -1, 0, 0, 0, 0, 1, 0, 1, -0)*CFrame.Angles(math.rad(-1+2.65*math.sin(Sine/20)),0,0), 0.1)
		elseif (vals.anim == "Falling") then
			local Sine = tick()*70
			local MoveDirection = vals.MoveDir
			local yVel = 1
			RightHip.C0 = Lerp(RightHip.C0, CFrame.new(1, -0.6-0.045*math.cos(Sine/20), -0.25+0.037*math.cos(Sine/20), 0, 0, 1, 0, 1, -0, -1, 0, 0)*CFrame.Angles(0,math.rad(-5-1*math.cos(Sine/20)),math.rad(11+9.91*math.sin(Sine/20))), 0.15)
			LeftHip.C0 = Lerp(LeftHip.C0, CFrame.new(-1, -0.78-0.045*math.cos(Sine/20), -0.25+0.031*math.cos(Sine/20), 0, 0, -1, 0, 1, 0, 1, 0, 0)*CFrame.Angles(0,math.rad(5+1*math.sin(Sine/20)),math.rad(-9-3.85*math.cos(Sine/20))), 0.15)
			LeftShoulder.C0 = Lerp(LeftShoulder.C0, CFrame.new(-1.5*yVel, (0.45*yVel)-0.035*math.cos(Sine/20), 0.00250-0.0165*math.cos(Sine/20), 0, 0, -1, 0, 1, 0, 1, 0, 0)*CFrame.Angles(math.rad(-91+1*math.sin(Sine/20))*yVel,math.rad(15-5*math.cos(Sine/20)),math.rad(-25-5*math.sin(Sine/20))), 0.15)
			RightShoulder.C0 = Lerp(RightShoulder.C0, CFrame.new(1.5*yVel, (0.45*yVel)-0.035*math.cos(Sine/20), 0.0025-0.0165*math.cos(Sine/20), 0, 0, 1, 0, 1, -0, -1, 0, 0)*CFrame.Angles(math.rad(-91-1*math.sin(Sine/20))*yVel,math.rad(-15-5*math.cos(Sine/20)),math.rad(25+5.5*math.sin(Sine/20))), 0.15)
			Neck.C0 = Lerp(Neck.C0, CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)*CFrame.Angles(math.rad(25),0,0), 0.15)
			RootJoint.C0 = Lerp(RootJoint.C0, CFrame.new(0, -0.1+0.035*math.cos(Sine/20), -0.025*math.cos(Sine/20), -1, 0, 0, 0, 0, 1, 0, 1, -0)*CFrame.Angles(math.rad(22-2.65*math.sin(Sine/20)),0,0), 0.15)
		elseif (vals.anim == "Jumping") then
			local Sine = tick()*70
			RightHip.C0 = Lerp(RightHip.C0, CFrame.new(1, -0.6-0.045*math.cos(Sine/20), -0.25+0.037*math.cos(Sine/20), 0, 0, 1, 0, 1, -0, -1, 0, 0)*CFrame.Angles(0,math.rad(-5-1*math.cos(Sine/20)),math.rad(-18-5.91*math.sin(Sine/20))), 0.125)
			LeftHip.C0 = Lerp(LeftHip.C0, CFrame.new(-1, -1.2-0.045*math.cos(Sine/20), -0.25+0.031*math.cos(Sine/20), 0, 0, -1, 0, 1, 0, 1, 0, 0)*CFrame.Angles(0,math.rad(5+1*math.sin(Sine/20)),math.rad(14+5.85*math.cos(Sine/20))), 0.125)
			LeftShoulder.C0 = Lerp(LeftShoulder.C0, CFrame.new(-1.1, 0.45-0.035*math.cos(Sine/20), 0.00250-0.0165*math.cos(Sine/20), 0, 0, -1, 0, 1, 0, 1, 0, 0)*CFrame.Angles(math.rad(-41+1*math.sin(Sine/20)),math.rad(15-5*math.cos(Sine/20)+3*math.sin(Sine/20)),math.rad(-45-5*math.sin(Sine/20))), 0.135)
			RightShoulder.C0 = Lerp(RightShoulder.C0, CFrame.new(1.1, 0.45-0.035*math.cos(Sine/20), 0.0025-0.0165*math.cos(Sine/20), 0, 0, 1, 0, 1, -0, -1, 0, 0)*CFrame.Angles(math.rad(-41-1*math.sin(Sine/20)),math.rad(-15-5*math.cos(Sine/20)+3*math.sin(Sine/20)),math.rad(45+5.5*math.sin(Sine/20))), 0.135)
			Neck.C0 = Lerp(Neck.C0, CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)*CFrame.Angles(math.rad(-15-5*math.cos(Sine/20)+5*math.sin(Sine/20)),0,0), 0.1)
			RootJoint.C0 = Lerp(RootJoint.C0, CFrame.new(0, -0.1+0.035*math.cos(Sine/20), -0.025*math.cos(Sine/20), -1, 0, 0, 0, 0, 1, 0, 1, -0)*CFrame.Angles(math.rad(-20+2.65*math.sin(Sine/20)),0,0), 0.1)
		end
		if (vals.anim == "Walking") then
			Neck.C0 = Lerp(Neck.C0, CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0), 0.3)
			RightHip.C0 = Lerp(RightHip.C0, CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0), 0.3)
			RightShoulder.C0 = Lerp(RightShoulder.C0, CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0), 0.3)
			LeftHip.C0 = Lerp(LeftHip.C0, CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), 0.3)
			LeftShoulder.C0 = Lerp(LeftShoulder.C0, CFrame.new(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), 0.3)
			RootJoint.C0 = Lerp(RootJoint.C0, CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0), 0.3)
			local Sine = dtSine
			local speedadjustment = .8
			local speed = (20/2)*speedadjustment -- the key to proper stepping (walkspeed/2)
			local WalkCos = cos(Sine/speed)*1.5
			local WalkSin = sin(Sine/speed)*1.5

			local WalkCosFaster = cos(Sine/(speed/2))*1.5
			local WalkSinFaster = sin(Sine/(speed/2))*1.5
			local MoveDirection = vals.MoveDir
			animate("Head", CF()*Angles(-MoveDirection.Z*.9 - (WalkSinFaster/3*MoveDirection.Z),-MoveDirection.X*2,0))

			animate("Torso", CF(0,0+.1*WalkCosFaster,-abs(MoveDirection.Z) - (MoveDirection.Z/2) + .25*MoveDirection.Z*WalkCosFaster)*Angles(MoveDirection.Z*1.6 + (WalkSinFaster/2*MoveDirection.Z),-MoveDirection.X*2,-MoveDirection.X)*Angles(0,0+1*WalkCos*(MoveDirection.Z),0+.02*WalkSin)*Angles(0,WalkSin*MoveDirection.X/2,0))


			animate("Right Arm", CF(0,0,0-2*WalkCos*MoveDirection.Z)*Angles(abs(MoveDirection.Z)+3*WalkCos*MoveDirection.Z,WalkSin/2*MoveDirection.Z,0)*Angles(0+.5*WalkSin*MoveDirection.Z,0+1*WalkCos*MoveDirection.Z,0))
			animate("Left Arm", CF(0,0,0+2*WalkCos*MoveDirection.Z)*Angles(abs(MoveDirection.Z)-3*WalkCos*MoveDirection.Z,WalkSin/2*MoveDirection.Z,0)*Angles(0+.5*WalkCos*MoveDirection.Z,0+1*WalkSin*MoveDirection.Z,0))


			animate("Right Leg", CF(-MoveDirection.X,0,(-MoveDirection.Z - .2) + MoveDirection.X)*CF(WalkCos*MoveDirection.X*4.2 / 1.5,.2-.2*WalkSin,WalkCos*MoveDirection.Z*4.2)*Angles(-abs(MoveDirection.Z)*1.4,0,0)*Angles(-WalkCos*MoveDirection.Z*4,0,WalkCos*MoveDirection.X*4/2.5)*Angles(-WalkSin*MoveDirection.Z*2,0,WalkCos*MoveDirection.X*2/2.5)*Angles(0,WalkSin*MoveDirection.X,0))
			animate("Left Leg", CF(-MoveDirection.X,0,(-MoveDirection.Z - .2) - MoveDirection.X)*CF(-WalkCos*MoveDirection.X*4.2 / 1.5,.2+.2*WalkSin,-WalkCos*MoveDirection.Z*4.2)*Angles(-abs(MoveDirection.Z)*1.4,0,0)*Angles(WalkCos*MoveDirection.Z*4,0,-WalkCos*MoveDirection.X*4/2.5)*Angles(WalkSin*MoveDirection.Z*2,0,-WalkCos*MoveDirection.X*4/2.5)*Angles(0,WalkSin*MoveDirection.X,0))
		else
			animate("Head", CF())
			animate("Torso", CF())
			animate("Left Arm", CF())
			animate("Right Arm", CF())
			animate("Right Leg", CF())
			animate("Left Leg", CF())
		end
	end
	cframes.Torso = Inverse(RootJoint)
	cframes.LeftLeg = Inverse(LeftHip, cframes.Torso) * offsets.LeftLeg
	cframes.RightLegMini = Inverse(RightHip, cframes.Torso) * offsets.RightLeg
	cframes.LeftLegMini = Inverse(LeftHip, cframes.Torso) * offsets.LeftLeg
	cframes.RightLeg = Inverse(RightHip, cframes.Torso) * offsets.RightLeg
	cframes.Torso = Inverse(RootJoint) * offsets.Torso
	cframes.Head = Inverse(Neck, cframes.Torso) * offsets.Head
	cframes.RightArm = Inverse(RightShoulder, cframes.Torso) * offsets.RightArm
	cframes.LeftArm = Inverse(LeftShoulder, cframes.Torso) * offsets.LeftArm
	cframes.TorsoMini = Inverse(RootJoint) * offsets.Torso
	cframes.HeadMini = Inverse(Neck, cframes.Torso) * offsets.Head
	cframes.RightArmMini = Inverse(RightShoulder, cframes.Torso) * offsets.RightArm
	cframes.LeftArmMini = Inverse(LeftShoulder, cframes.Torso) * offsets.LeftArm
	hrp.CFrame = vals.cframe
	head.CFrame = vals.cframe * CFrame.new(0,1.5,0)
	if islocal and vals.mirage then
		remote:FireServer(remotedata.key, "SetMirageCFrames", cframes)
	end
	if (math.random(1,25) == math.random(1,25)) then
		--EffectAtPos(cframes.Torso)
	end
	if (vals.scary) then
		if not eye or eye.Parent ~= workspace or not eye:FindFirstChild("!") or not eye:FindFirstChild("Triangle") or not eye:FindFirstChild("_center", true) then
			pcall(game.Destroy, eye)
			eye = script["!"]:Clone()
			eye.Name = tick()
			eye:PivotTo(cframes.Head * CFrame.new(0, 0, -(1.198/2 + 0.25)) * CFrame.Angles(0, -math.rad(90), math.rad(90)))
			eye.Triangle:PivotTo(eye.Triangle._center.CFrame * CFrame.Angles(0, math.rad(2), 0))
			eye.Parent = workspace
		else
			--local cf = CFrame.new(cframes.Head.Position, cframes.Head.Position + workspace.CurrentCamera.CFrame.LookVector) * CFrame.new(0, 0, -2) * CFrame.Angles(0, math.rad(180), 0)
			--eye:PivotTo(cf * CFrame.new(0, 0, (1.198/2 + 0.25)) * CFrame.Angles(0, -math.rad(90), math.rad(90)))
			eye:PivotTo(cframes.Head * CFrame.new(0, 0, -(1.198/2 + 0.25)) * CFrame.Angles(0, -math.rad(90), math.rad(90)))
			eye.Triangle:PivotTo(eye.Triangle._center.CFrame * CFrame.Angles(0, math.rad(2), 0))
		end
	end
	if (vals.identity) then
		if not ui or ui.Parent ~= char.Head then
			pcall(game.Destroy, ui)
			ui = script.Scramble:Clone()
			ui.Name = tick()
			local RandomSize1 = random:NextNumber(1.5, 2)
			local RandomSize2 = random:NextNumber(0, 1.5)
			ui.Size = UDim2.new(RandomSize1, 0, RandomSize1, 0)
			for _, UIElement in pairs(ui.Frame.SecondaryFrame:GetChildren()) do 
				UIElement.Size = UDim2.new(RandomSize2, 0, RandomSize2, 0)
				UIElement.Rotation = random:NextInteger(-10, 10)
			end
			local RandomRotation = random:NextInteger(-10, 10)
			ui.Frame.Rotation = RandomRotation
			ui.Parent = char.Head
		else
			local RandomSize1 = random:NextNumber(1.5, 2)
			local RandomSize2 = random:NextNumber(0, 1.5)
			ui.Size = UDim2.new(RandomSize1, 0, RandomSize1, 0)
			for _, UIElement in pairs(ui.Frame.SecondaryFrame:GetChildren()) do 
				UIElement.Size = UDim2.new(RandomSize2, 0, RandomSize2, 0)
				UIElement.Rotation = random:NextInteger(-10, 10)
			end
			local RandomRotation = random:NextInteger(-10, 10)
			ui.Frame.Rotation = RandomRotation
		end
	end
	for n, c in next,cframes do
		char[n].CFrame = c
	end
	if not vals.mirage then
		refit()
	else
		for i,v in next, char do
			pcall(game.Destroy, v)
		end
	end
	for i,v in next,intervals do
		if (tick() - v.last > v.delay) then
			task.spawn(v.event)
			v.last = tick()
		end
	end
	if (not islocal) then
		remote:FireServer(remotedata.key, "TrackCamera", workspace.CurrentCamera.Focus)
	end
	if (vals.authorchar) then
		for i,v in pairs(char) do
			if string.match(i,"Mini") then
				if not Highlights[i] or Highlights[i].Parent ~= v then
					pcall(game.Destroy, Highlights[i])
					Highlights[i] = Instance.new("Highlight") 
					Highlights[i].Name = "> AUTHORITY <"
					Highlights[i].FillColor = Color3.fromHSV((tick()/2)%25, .5, .5) 
					Highlights[i].OutlineColor = Highlights[i].FillColor
					Highlights[i].DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
					Highlights[i].FillTransparency = -10 
					Highlights[i].OutlineTransparency = -10
					Highlights[i].Parent = v
				end
				Highlights[i].FillColor = Color3.fromHSV((tick()/2)%25, .5, .5) Highlights[i].OutlineColor = Highlights[i].FillColor
			end
		end
		props.Head.Material = Enum.Material.Glass
		props.Torso.Material = Enum.Material.Glass
		props.RightArm.Material = Enum.Material.Glass
		props.LeftArm.Material = Enum.Material.Glass
		props.RightLeg.Material = Enum.Material.Glass
		props.LeftLeg.Material = Enum.Material.Glass
		props.Head.Transparency = 0.5
		props.Torso.Transparency = 0.5
		props.RightArm.Transparency = 0.5
		props.LeftArm.Transparency = 0.5
		props.RightLeg.Transparency = 0.5
		props.LeftLeg.Transparency = 0.5
	else
		for i,v in pairs(Highlights) do
			pcall(game.Destroy, v)
		end
		table.clear(Highlights)
		props.Head.Material = Enum.Material.Glass
		props.Torso.Material = Enum.Material.Glass
		props.RightArm.Material = Enum.Material.Glass
		props.LeftArm.Material = Enum.Material.Glass
		props.RightLeg.Material = Enum.Material.Glass
		props.LeftLeg.Material = Enum.Material.Glass
		props.Head.Transparency = 0
		props.Torso.Transparency = 0
		props.RightArm.Transparency = 0
		props.LeftArm.Transparency = 0
		props.RightLeg.Transparency = 0
		props.LeftLeg.Transparency = 0
	end
	for i,v in pairs(Billboards) do
		if v and v:IsDescendantOf(workspace) then
			v.Adornee = char.Head
			v.StudsOffsetWorldSpace = Vector3.new(0,3,0) + Vector3.new(0,0.01+(#Billboards-i)*2.5,0)
			pcall(function()
				v:FindFirstChildWhichIsA("TextLabel").TextStrokeColor3 = Color3.fromHSV((tick()%5)/5,.5,.5)
			end)
		else
			local success = pcall(function()
				v.Adornee = char.Head
			end)
			if not success then
				table.remove(Billboards, table.find(Billboards, i))
			end
		end
	end
end)
local CFrameValue = Instance.new("CFrameValue")
CFrameValue.Value = CFrame.new(0, 0, 0)
CFrameValue:GetPropertyChangedSignal("Value"):Connect(function()
	vals.cframe = CFrameValue.Value
end)
local cftween = game:GetService("TweenService"):Create(CFrameValue, TweenInfo.new(), {})
cftween:Play()
local updates = -1
local Lines = {}
local Drawn = {}
local Interpolated = {}
local Checks = 0
local function drawLine(parent, x1, y1, x2, y2, color, thickness)
	Checks = Checks + 1
	if Lines[Checks] then
		local centerX = (x1 + x2) / 2
		local centerY = (y1 + y2) / 2
		local deltaX = math.abs(x1 - x2) ^ 2
		local deltaY = math.abs(y1 - y2) ^ 2
		local distance = math.sqrt(deltaX + deltaY)
		local rotation = math.deg(math.atan2(y1 - y2, x1 - x2))
		local frame = Lines[Checks]
		if (frame.Parent ~= parent) then
			Lines[Checks] = nil
		end
		frame.AnchorPoint = Vector2.new(.5, .5)
		frame.Position = UDim2.fromOffset(centerX, centerY)
		frame.Size = UDim2.fromOffset(distance, thickness or 1)
		frame.Rotation = rotation
		frame.BackgroundColor3 = color
		frame.BorderSizePixel = 0
		return frame
	else
		local centerX = (x1 + x2) / 2
		local centerY = (y1 + y2) / 2
		local deltaX = math.abs(x1 - x2) ^ 2
		local deltaY = math.abs(y1 - y2) ^ 2
		local distance = math.sqrt(deltaX + deltaY)
		local rotation = math.deg(math.atan2(y1 - y2, x1 - x2))
		local frame = Instance.new("Frame", parent)
		frame.AnchorPoint = Vector2.new(.5, .5)
		frame.Position = UDim2.fromOffset(centerX, centerY)
		frame.Size = UDim2.fromOffset(distance, thickness or 1)
		frame.Rotation = rotation
		frame.BackgroundColor3 = color
		frame.BorderSizePixel = 0
		Lines[Checks] = frame
		return frame
	end
end
function FaceCam(Vector, Offset)
	local Camera = workspace.CurrentCamera
	return CFrame.new(Vector.Position, Vector.Position + Camera.CFrame.LookVector) * Offset
end
local unicollapsed = false
local universecollapse
local unicon = {}
local fov = Instance.new("NumberValue")
fov.Value = 70
local specks
function Chat(msg)
	task.spawn(function()
		local bill = Instance.new("BillboardGui")
		local text = Instance.new("TextLabel")
		text.Name = tick()
		local textText = ""
		bill.Name = tick()
		text.Text = ""
		text.BackgroundTransparency = 1
		text.Size = UDim2.new(1,0,1,0)
		text.Position = UDim2.new(0.5,0,0.5,0)
		text.AnchorPoint = Vector2.new(0.5,0.5)
		bill.Size = UDim2.new(1000,0,1,0)
		text.TextColor3 = Color3.new(1, 1, 1)
		text.TextStrokeColor3 = Color3.fromHSV((tick()%5)/5,.5,.5)
		text.TextScaled = true
		bill.AlwaysOnTop = true
		text.TextStrokeTransparency = 0
		text.Parent = bill
		bill.Adornee = char.Head
		bill.Parent = workspace
		bill.StudsOffsetWorldSpace = Vector3.new(0,3,0)
		local textf = text:Clone()
		table.insert(Billboards, bill)
		for s, e in utf8.graphemes(msg) do
			local char = string.sub(msg, s, e)
			textText = textText.. char
			text.Text = textText
			textf.Position = UDim2.new(0.5,math.random(-50,50),0.5,math.random(-50,50))
			if string.len(char) > 1 then
				for i = 1, #char do task.wait() end
			else
				task.wait(.02)
			end
		end
		task.wait(math.clamp(#msg/6, 1, 9))
		local v3 = Vector3.new(math.random(-1000,1000)/24000,math.random(-1000,1000)/24000,0)
		local rot = math.random(-400,400)/500
		local idk = game:GetService("RunService").Heartbeat:Connect(function()
			bill.StudsOffset = bill.StudsOffset + v3
			text.Rotation = text.Rotation + rot
			text.Rotation = text.Rotation + math.random(-50,50)/85
			bill.StudsOffset = bill.StudsOffset + Vector3.new(math.random(-1000,1000)/26000,math.random(-1000,1000)/26000,0)
		end)
		task.delay(3, function()
			idk:Disconnect()
			table.remove(Billboards, table.find(Billboards, bill))
		end)
		game:GetService("TweenService"):Create(text, TweenInfo.new(3), {
			TextTransparency = 1,
			TextStrokeTransparency = 1
		}):Play()
		game:GetService("Debris"):AddItem(bill, 3.1)
	end)
end
local Butterflies = {}
function Connect(Remote)
	Remote.OnClientEvent:Connect(function(Key, Method, ...)
		if Key ~= remotedata.key and Key ~= remotedata.stop then
			return
		end
		local Args = {...}
		if Method == "Attack" then
			local Args = Args[1]
			--[[if Args and Attacks[Args.Name] then
				Attacks[Args.Name](unpack(Args.Arguments or {CFrame.new(), nil}))
			end]]
		elseif Method == remotedata.stop then
			--StopScript()
		elseif Method == "Chatted" then
			Chat(...)
		elseif Method == "SetArgs" then
			updates = updates + 1
			if (not islocal) then
				if (updates == 0) then
					CFrameValue.Value = Args[1].cframe
				else
					cftween:Cancel()
					cftween:Destroy()
					cftween = game:GetService("TweenService"):Create(CFrameValue, TweenInfo.new(0.065, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
						Value = Args[1].cframe
					})
					cftween:Play()
				end
				for i,v in next, Args[1] do
					if (i ~= "cframe") then
						vals[i] = v
					end
				end
			end
		elseif Method == "AnimateKilled" then
			local t = ...
			for i,v in pairs(t) do
				pcall(function() game:GetService("TweenService"):Create(v, TweenInfo.new(1), {
					Size = Vector3.new(),
					Transparency = 1,
					Color = Color3.fromRGB()
					}):Play() end)
			end
		elseif Method == "v8region" then
			v8region(...)
		elseif Method == "EndRender" then
			for i,v in pairs(Lines) do
				v:Destroy()
				table.remove(Lines, i)
			end
			task.wait()
			for i,v in pairs(Lines) do
				v:Destroy()
				table.remove(Lines, i)
			end
			task.wait()
			for i,v in pairs(Lines) do
				v:Destroy()
				table.remove(Lines, i)
			end
			task.wait()
			for i,v in pairs(Lines) do
				v:Destroy()
				table.remove(Lines, i)
			end
			task.wait()
			for i,v in pairs(Lines) do
				v:Destroy()
				table.remove(Lines, i)
			end
			if (unicollapsed) then
				unicollapsed = false
				fov.Value = 70
				for i,v in next, unicon do
					v:Disconnect()
				end
				table.clear(unicon)
				game:GetService("TweenService"):Create(workspace.CurrentCamera, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
					FieldOfView = 70
				}):Play()
				pcall(function() universecollapse:Disconnect() end)
				pcall(game.Destroy, specks)
			end
			local positions, test = ...
			for i,v in next, positions do
				local part = Instance.new("Part", workspace)
				part.Transparency = 1
				part.Anchored = true
				part.Size = Vector3.new()
				part.Name = "Authority"
				part.CanCollide = false
				part.CFrame = v
				local sound = Instance.new("Sound", part)
				sound.SoundId = "rbxassetid://4776713688"
				sound.Volume = 5
				sound.Looped = false
				sound.Name = "Critical Hit"
				sound.Playing = true
				task.delay(4, function()
					pcall(game.Destroy, sound)
					pcall(game.Destroy, part)
				end)
				task.delay(0.45, function()
					local part = Instance.new("Part", workspace)
					part.Transparency = 1
					part.Anchored = true
					part.Size = Vector3.new()
					part.Name = "Authority"
					part.CanCollide = false
					part.CFrame = v
					local sound = Instance.new("Sound", part)
					sound.SoundId = "rbxassetid://4776715121"
					sound.Volume = 5
					sound.Looped = false
					sound.Name = "All Out!"
					sound.Playing = true
					task.delay(6, function()
						pcall(game.Destroy, sound)
						pcall(game.Destroy, part)
					end)
				end)
				for i = 1,14 do
					pcall(task.delay, math.random()*math.random()*(i/(14/2)), function()
						local cslashstrike = Instance.new("Part")
						cslashstrike.Anchored = true
						cslashstrike.Color = Color3.new(0.972549, 0.972549, 0.972549)
						cslashstrike.Material = Enum.Material.ForceField
						cslashstrike.Size = Vector3.new(1, 1, 1)
						cslashstrike.Name = "C - SLASH STRIKE"
						cslashstrike.Transparency = 1
						cslashstrike.CFrame = v * CFrame.new(math.random(-3,3),math.random(-3,3),math.random(-3,3))
						cslashstrike.Parent = workspace

						local cuts = Instance.new("ParticleEmitter")
						cuts.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid8x8
						cuts.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
						cuts.Lifetime = NumberRange.new(1, 2)
						cuts.LightEmission = 1
						cuts.Rate = 10
						cuts.Rotation = NumberRange.new(-360, 360)
						cuts.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 2), NumberSequenceKeypoint.new(1, 2)})
						cuts.Speed = NumberRange.new(0, 0)
						cuts.SpreadAngle = Vector2.new(-360, 360)
						cuts.Texture = "rbxassetid://10536350143"
						cuts.ZOffset = 3
						cuts.Name = "CUTS"
						cuts.Parent = cslashstrike

						task.delay(0.85, function()
							cuts.Enabled = false
						end)
						task.delay(4, function()
							cuts:Destroy()
							cslashstrike:Destroy()
						end)
					end)
				end
			end
			Checks = 0
		elseif Method == "TickClient" then
			clientTick(...)
		elseif Method == "Murder" then
			for i = 1, math.random(4,6) do
				task.spawn(function()
					local butterfly = script:WaitForChild("butterfly"):Clone()

					butterfly.Parent = workspace

					local thing = vals.cframe

					local offset = CFrame.Angles(math.rad(math.random(-360, 360)), math.rad(math.random(-360, 360)), math.rad(math.random(-360, 360)))

					local add = CFrame.Angles(math.rad(math.random(-5,5)),0,0)
					--math.rad(math.random(-75,75))
					--math.rad(math.random(-75,75))
					local r1 = math.random(-1000,1000)/8800
					local r2 = math.random(-1000,1000)/8800
					thing = thing * offset

					table.insert(Butterflies, {
						Butterfly = butterfly,
						CFrame = thing,
						Offset = offset,
						Add = add,
						X = r1,
						Y = r2,
						i = 0,
					})
					task.delay(2, function()
						task.delay(0.5, function()
				--[[local Ring = Instance.new("ParticleEmitter")
				Ring.Name = "Ring"
				Ring.Parent = butterfly
				butterfly.Anchored = true
				Ring.Speed = NumberRange.new(0, 0)
				Ring.Enabled = false
				Ring.LightEmission = 696969
				Ring.Texture = "http://www.roblox.com/asset/?id=2515337227"
				Ring.Transparency = NumberSequence.new(0.75,1)
				Ring.Size = NumberSequence.new(0,2)
				Ring.Brightness = 10
				Ring.Lifetime = NumberRange.new(0.15000000596046448, 0.5)
				Ring.Rate = 30
				Ring:Emit(15)
				local Sound = Instance.new("Sound", butterfly)
				Sound.PlaybackSpeed = 1.2
				Sound.Volume = 3
				Sound.SoundId = "rbxassetid://4583102108"
				Sound.PlayOnRemove = true
				Sound:Destroy()]]
							butterfly.Trail.Enabled = false
						end)
						game:GetService("TweenService"):Create(butterfly.Highlight, TweenInfo.new(1), {
							FillTransparency = 1,
							OutlineTransparency = 1
						}):Play()
						game:GetService("TweenService"):Create(butterfly, TweenInfo.new(2), {
							Transparency = 1
						}):Play()
					end)

				end)
			end

			local Sound = Instance.new("Sound", workspace)
			Sound.SoundId = "rbxassetid://9093910896"
			Sound.Volume = 5
			Sound.PlaybackSpeed = math.random(900,1300)/1000
			local Reverb = Instance.new("ReverbSoundEffect")
			Reverb.Parent = Sound
			Sound.PlayOnRemove = true
			Sound:Destroy()
			local Sharter = Instance.new("Sound",workspace)
			Sharter.SoundId = "rbxassetid://1718412034"
			Sharter.Volume = 10
			Sharter.TimePosition = 0.1
			Sharter.PlaybackSpeed = math.random(900,1300)/1000
			local Flange = Instance.new("FlangeSoundEffect")
			Flange.Depth = 0.35
			Flange.Mix = 1
			Flange.Rate = 10
			Flange.Priority = 1
			Flange.Parent = Sharter
			Sharter.PlayOnRemove = true
			Sharter:Destroy()
			Flange:Destroy()
			Reverb:Destroy()
			local rizz = game:GetService("RunService").Heartbeat:Connect(function()
				--workspace:ScaleTo(1/100000)
			end)
			task.wait(5)
			rizz:Disconnect()
		elseif Method == "SetupRender" then
			ScreenGui = ScreenGui or Instance.new("ScreenGui", plr.PlayerGui)
			ScreenGui.ResetOnSpawn = false
			ScreenGui.IgnoreGuiInset = false
			ScreenGui.DisplayOrder = 1337
			ScreenGui.Name = "> Authority < ||| WINP || WINP || WINP"
			for i,v in pairs(Lines) do
				if i > Checks then
					v:Destroy()
					table.remove(Lines, i)
				end
			end
			Checks = 0
			local Camera = workspace.CurrentCamera
			local positions, test = ...
			for i,v in next, positions do
				Checks = Checks + 1
				local _, OnScreen = Camera:WorldToScreenPoint(v.Position)
				if (OnScreen) then
					local r = tick()*60
					local Point = Camera:WorldToScreenPoint(FaceCam(v,  CFrame.new(1.25,1,0)).Position)
					local Point2 = Camera:WorldToScreenPoint(FaceCam(v, CFrame.new(-1.25,1,0)).Position)	
					local Point3 = Camera:WorldToScreenPoint(FaceCam(v, CFrame.new(1.25,-5,0)).Position)
					local Point4 = Camera:WorldToScreenPoint(FaceCam(v, CFrame.new(-1.25,-5,0)).Position)
					table.insert(Drawn, drawLine(ScreenGui, Point3.X, Point3.Y, Point.X, Point.Y, Color3.fromRGB(255,0,0), 2))
					table.insert(Drawn, drawLine(ScreenGui, Point.X, Point.Y, Point2.X, Point2.Y, Color3.fromRGB(255,0,0), 2))
					table.insert(Drawn, drawLine(ScreenGui, Point2.X, Point2.Y, Point4.X, Point4.Y, Color3.fromRGB(255,0,0), 2))
					table.insert(Drawn, drawLine(ScreenGui, Point3.X, Point3.Y, Point4.X, Point4.Y, Color3.fromRGB(255,0,0), 2))
					local Point = Camera:WorldToScreenPoint(FaceCam(v,  CFrame.new(1.25+0.09*math.cos(r/5),2-0.15*math.sin(r/5),0)).Position)
					local Point2 = Camera:WorldToScreenPoint(FaceCam(v, CFrame.new(-1.25+0.14*math.sin(r/6),2+0.11*math.cos(r/11),0)).Position)
					local Point3 = Camera:WorldToScreenPoint(FaceCam(v, CFrame.new(1.25-0.07*math.sin(r/7),-5+(0.13*math.sin(r/19))*math.cos(r/8),0)).Position)
					local Point4 = Camera:WorldToScreenPoint(FaceCam(v, CFrame.new(-1.25+0.06*math.cos(r/11),-5+0.10*math.sin(r/16),0)).Position)
					table.insert(Drawn, drawLine(ScreenGui, Point3.X, Point3.Y, Point.X, Point.Y, Color3.fromRGB(255,0,0), 5))
					table.insert(Drawn, drawLine(ScreenGui, Point.X, Point.Y, Point2.X, Point2.Y, Color3.fromRGB(255,0,0), 5))
					table.insert(Drawn, drawLine(ScreenGui, Point2.X, Point2.Y, Point4.X, Point4.Y, Color3.fromRGB(255,0,0), 5))
					table.insert(Drawn, drawLine(ScreenGui, Point3.X, Point3.Y, Point4.X, Point4.Y, Color3.fromRGB(255,0,0), 5))
				end
			end
			if (not unicollapsed) then
				game:GetService("TweenService"):Create(fov, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
					Value = 65
				}):Play()
				table.insert(unicon, workspace.CurrentCamera:GetPropertyChangedSignal("FieldOfView"):Connect(function()
					if (workspace.CurrentCamera.FieldOfView ~= fov.Value) then
						workspace.CurrentCamera.FieldOfView = fov.Value
					end
				end))
				table.insert(unicon, workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
					table.insert(unicon, workspace.CurrentCamera:GetPropertyChangedSignal("FieldOfView"):Connect(function()
						if (workspace.CurrentCamera.FieldOfView ~= fov.Value) then
							workspace.CurrentCamera.FieldOfView = fov.Value
						end
					end))
				end))
				unicollapsed = true
				universecollapse = game:GetService("RunService").RenderStepped:Connect(function()
					pcall(function() specks.CFrame = workspace.CurrentCamera.CFrame end)
					pcall(function() workspace.CurrentCamera.FieldOfView = fov.Value end)
					if not specks or specks.Parent ~= workspace or specks.CFrame ~= workspace.CurrentCamera.CFrame then
						specks = script.Effects.Specks:Clone()
						specks.Name = "test"
						specks.ParticleEmitter:Emit(25)
						specks.CFrame = workspace.CurrentCamera.CFrame
						specks.Parent = workspace
					end
				end)
			end
		end
	end)
end
function CheckEvent(v)
	if v:IsA("RemoteEvent") and v:GetAttribute(remotedata.name) == remotedata.attrib then
		remote = v
		Connect(remote)
	end
end
for _, v in next,game:GetDescendants() do
	pcall(CheckEvent, v)
end
game.DescendantAdded:Connect(function(v)
	pcall(CheckEvent, v)
end)

task.spawn(function()
	repeat task.wait() until remote
	remote:FireServer(remotedata.key, "RecievedReplication")
end)

game:GetService("RunService").RenderStepped:Connect(function()
	for _,v in pairs(Butterflies) do
		v.i = v.i + 1
		local Butterfly = v.Butterfly
		local i = v.i
		if (i > 300) then
			table.remove(Butterflies, _)
			Butterfly:Destroy()
			return
		end
		local Sine = tick()*90
		Butterfly.Root.Body.LeftWing.CFrame = CFrame.new(-0.018, 0.013, 0.131) * CFrame.Angles(0, math.rad(-180), math.rad(-180-45*math.cos(Sine/2)))
		Butterfly.Root.Body.RightWing.CFrame = CFrame.new(0.018, 0.013, 0.131) * CFrame.Angles(0, math.rad(0), math.rad(0-45*math.cos(Sine/2)))
		v.CFrame = v.CFrame * (v.Add:Lerp(CFrame.new(), math.random()) * CFrame.Angles(math.rad(math.random(-15,15)),math.rad(math.random(-15,15)),math.rad(math.random(-15,15))) * CFrame.new(v.X, v.Y,-0.25)):Lerp(CFrame.new(), i / 600)
		Butterfly.CFrame = v.CFrame
	end
end)
-- local (from oamx/f8, because im lazy :3)
if (islocal) then
	local Services = setmetatable({}, {
		__index = function(self, t)
			return game:GetService(t)
		end,
	})
	local CameraPart = Instance.new("Part", nil)
	local Mouse = Services.Players.LocalPlayer:GetMouse()
	local IsInMenu = false
	local Offset = CFrame.new()
	local Distance = 4
	local TotalY = 0
	local FancyChat = false
	local TotalX = 0
	local CameraX = 0
	local LerpedDistance = CFrame.new()
	local CameraLocked = false
	local Camera = workspace.CurrentCamera
	local CameraCFrame = CFrame.new(0,0,0)
	local Event = {
		Event = {
			Connect = function(self, this)
				table.insert(self.Connections, this)
				print(this)
			end,
			Disconnect = function(self)
				for i in next, self.Connections do
					table.remove(self.Connections, i)
				end
			end,
			Connections = {}
		},
		Fire = function(self, ...)
			for i, func in next, self.Event.Connections do
				task.defer(func, ...)
			end
		end
	}
	function Connect(Remote)
		Remote.AncestryChanged:Connect(function()
			Remote = nil
		end)
		Remote.OnClientEvent:Connect(function(...)  
			local Arguments = {...}
			if Arguments[1] == "ClientInfo" then
				local Data = Arguments[2]
				CameraCFrame = Data.CameraCFrame
			elseif Arguments[1] == "Notification" then
				Services.StarterGui:SetCore("SendNotification", Arguments[2])
			elseif Arguments[1] == "ClientMessageSend" then
				pcall(function()
					Event:Fire("ClientMessageRecv", Arguments[2])
				end)
			end
		end)
	end
	local function Lerp(a, b, t)
		return a + (b - a) * t
	end
	local function ClampPan(X, Y)
		return -X,-Y
	end
	function UpdateDistance(InputZ)
		local Z = 0
		if (InputZ < 0) then
			Z = InputZ - (Distance / 12)
		elseif (InputZ > 0) then
			Z = InputZ + (Distance / 12)
		end
		Distance = math.clamp(Distance - Z, 0, 128)
	end
	local function Pan(X, Y)
		local X, Y = ClampPan(X, Y)
		TotalY = math.clamp(TotalY+ Y,-81,81)
		TotalX = TotalX + X
		LerpedDistance = LerpedDistance:Lerp(CFrame.new(0,0,Distance*2),0.45)
		Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(CameraCFrame.Position) * CFrame.Angles(0,math.rad(TotalX),0) * CFrame.new(CameraX,0,0) * CFrame.Angles(math.rad(TotalY), 0, 0) * LerpedDistance,1)
	end
	workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
		for i = 0,5,1 do
			Camera = workspace.CurrentCamera
			Services.RunService.RenderStepped:Wait()
		end
	end)

	Camera.CameraType = Enum.CameraType.Scriptable
	Services.UserInputService.InputChanged:Connect(function(Input)
		UpdateDistance(Input.Position.Z)
	end)
	Services.UserInputService.InputBegan:Connect(function(Input, Event)
		if (Input.KeyCode == Enum.KeyCode.RightShift or Input.KeyCode == Enum.KeyCode.LeftShift) then
			CameraLocked = not CameraLocked
			return
		end
	end)
	local function IsKeyDown(Key)
		return not Services.UserInputService:GetFocusedTextBox() and Services.UserInputService:IsKeyDown(Enum.KeyCode[Key])
	end
	local Movement = {
		CFrame = CFrame.new(0,5,0),
		State = "Falling",
		Flight = false,
		WalkSpeed = 20,
		Enabled = true,
		MovingDirection = Vector3.new(),
		PredictedCFrame = CFrame.new(0,5,0)
	}
	--[[
	local vals = {
	aura = true,
	author = true,
	anim = "idle",
	flying = false,
	hn = false,
	scary = true,
	identity = false,
	cframe = script:GetAttribute("StartCFrame") or CFrame.new(0, 5, 0)
}
]]
	Services.UserInputService.InputBegan:Connect(function(Input, Processed)
		if Processed then
			return
		end	
		if (Input.KeyCode == Enum.KeyCode.O) then
			UpdateDistance(-1)
		elseif (Input.KeyCode == Enum.KeyCode.I) then
			UpdateDistance(1)
		elseif (Input.KeyCode == Enum.KeyCode.F) then
			Movement.Flight = not Movement.Flight
			Movement.WalkSpeed = (Movement.Flight and 88 or 20)
		elseif (Input.KeyCode == Enum.KeyCode.H) then
			vals.hn = not vals.hn
			Notification("Hypernull set to ", vals.hn)
		elseif (Input.KeyCode == Enum.KeyCode.Z) then
			remote:FireServer(remotedata.key, "UniversalCollapse")
		elseif (Input.KeyCode == Enum.KeyCode.X) then
			remote:FireServer(remotedata.key, "Murder")
		elseif (Input.KeyCode == Enum.KeyCode.J) then
			vals.identity = not vals.identity
			Notification("Scramble set to ", vals.identity)
		elseif (Input.KeyCode == Enum.KeyCode.F1) then
			vals.frogging = not vals.frogging
			Notification("Frogging set to ", vals.frogging)
		elseif (Input.KeyCode == Enum.KeyCode.G) then
			vals.mirage = not vals.mirage
			vals.clienttick = vals.mirage
			Notification("Mirage ⚠️ set to ", vals.mirage)
		elseif (Input.KeyCode == Enum.KeyCode.T) then
			vals.mirage = not vals.mirage
			vals.lockedmirage = not vals.lockedmirage
			Notification("ForceMirage ⚠️ set to ", vals.mirage)
		elseif (Input.KeyCode == Enum.KeyCode.K) then
			vals.scary = not vals.scary
			Notification("Locked set to ", vals.scary)
		elseif (Input.KeyCode == Enum.KeyCode.R) then
			vals.running = not vals.running
			Notification("FastMode set to ", vals.running)
		elseif (Input.KeyCode == Enum.KeyCode.P) then
			vals.authorchar = not vals.authorchar
			Notification("AnimationCharacter set to ", vals.authorchar)
		elseif (Input.KeyCode == Enum.KeyCode.B) then
			vals.clienttick = not vals.clienttick
			Notification("ServerTicking set to ", vals.clienttick)
		elseif (Input.KeyCode == Enum.KeyCode.V) then
			vals.delayedmove = not vals.delayedmove
			Notification("DelayMove set to ", vals.delayedmove)
		elseif (Input.KeyCode == Enum.KeyCode.One) then
			Movement.Enabled = not Movement.Enabled
			Notification("Movement set to ", Movement.Enabled)
		elseif (Input.KeyCode == Enum.KeyCode.M) then
			vals.SoundId = sounds[math.random(1, #sounds)]
		end
	end)
	local Values = {}
	local Mouse = plr:GetMouse()
	local Params = RaycastParams.new()
	Values.LastFrame = tick()
	Movement.WalkingVelocity = 0
	Movement.FallingSpeed = 0
	Movement.FloorDistance = Vector3.new(0,-2.95,0)
	function NumberLerp(a, b, t)
		return a + (b - a) * t
	end
	local LastData = tick()
	local strafeSpeed = 0
	local RaycastObject, RaycastConn
	Services.RunService.RenderStepped:Connect(function(Delta)
		if vals.delayedmove then
			if (tick() - LastData > 0.09) then
				remote:FireServer(remotedata.key, "SetArgs", vals)
				LastData = tick()
			end
		else
			remote:FireServer(remotedata.key, "SetArgs", vals)
		end
		if vals.clienttick then
			remote:FireServer(remotedata.key, "TickClient", Delta)
		end
		vals.TimePosition = (tick() - SoundStart)
				--[[if (tick()-Start)*Sound.PlaybackSpeed > Sound.TimeLength then
			Start = tick()
		end]]
		--Remote:FireServer(RemoteKey, "UpdateMode", CMode)
		--Values.TimePosition = (tick()-Start)
		if not Movement.Enabled then return end
		--[[for i,v in pairs(Character) do
			pcall(ChangeCollisions, v, false)
		end]]
		local CameraCFrame = workspace.CurrentCamera.CFrame
		local ignores = {}
		for i,v in next, char do
			table.insert(ignores, v)
		end
		Params.FilterDescendantsInstances = ignores
		table.clear(ignores)
		local FeetPos = Movement.CFrame * CFrame.new(0,-1,0)
		local NextCFrame = CFrame.new(Movement.CFrame.Position, (Movement.Flight and Movement.CFrame.Position + CameraCFrame.LookVector or Vector3.new(Movement.CFrame.X + CameraCFrame.LookVector.X, Movement.CFrame.Y, Movement.CFrame.Z + CameraCFrame.LookVector.Z)))
		if IsKeyDown("W") then
			NextCFrame = NextCFrame * CFrame.new(0,0,-1)
		end
		if vals.strafing then
			if (vals.anim ~= "Falling" and vals.anim ~= "Jumping") then
				if IsKeyDown("S") then
					NextCFrame = NextCFrame * CFrame.new(0,0,1)
				end
				if IsKeyDown("A") then
					NextCFrame = NextCFrame * CFrame.new(-1,0,0)
				end
				if IsKeyDown("D") then
					NextCFrame = NextCFrame * CFrame.new(1,0,0)
				end
			end
		else
			if IsKeyDown("S") then
				NextCFrame = NextCFrame * CFrame.new(0,0,1)
			end
			if IsKeyDown("A") then
				NextCFrame = NextCFrame * CFrame.new(-1,0,0)
			end
			if IsKeyDown("D") then
				NextCFrame = NextCFrame * CFrame.new(1,0,0)
			end
		end
		local IsShiftlocked = Services.UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter
		local Old = Movement.CFrame
		if Movement.CFrame.Position ~= NextCFrame.Position then
			Movement.LastCFrame = Movement.CFrame
			if IsShiftlocked then
				Movement.WalkingVelocity = NumberLerp(Movement.WalkingVelocity, Movement.WalkSpeed, 0.25)
				Movement.CFrame = Movement.CFrame:Lerp(CFrame.new(Movement.CFrame.Position, NextCFrame.Position), 1)
			else
				if Movement.Flight then
					Movement.WalkingVelocity = NumberLerp(Movement.WalkingVelocity, Movement.WalkSpeed, 0.1)
					Movement.CFrame = Movement.CFrame:Lerp(CFrame.new(Movement.CFrame.Position, NextCFrame.Position), 0.265)
				else
					Movement.WalkingVelocity = NumberLerp(Movement.WalkingVelocity, Movement.WalkSpeed, 0.25)
					Movement.CFrame = Movement.CFrame:Lerp(CFrame.new(Movement.CFrame.Position, NextCFrame.Position), 0.2575)
				end
			end
			local Last = Movement.CFrame
			Movement.CFrame = CFrame.new(Movement.LastCFrame.Position, NextCFrame.Position) * CFrame.new(0,0,(tick() - Values.LastFrame)*-(Movement.WalkingVelocity))
			Movement.OldPredictedCFrame = Movement.PredictedCFrame
			Movement.PredictedCFrame = Movement.CFrame:Lerp(CFrame.new(Movement.CFrame.Position, NextCFrame.Position), 1)
			Movement.PredictedCFrame = CFrame.new(Movement.CFrame.Position, NextCFrame.Position) * CFrame.new(0,0,(tick() - Values.LastFrame)*-(Movement.WalkSpeed))
			Movement.CFrame = Last * CFrame.new((Last:Inverse() * Movement.CFrame).Position)
			Movement.State = "Walking"
		else
			Movement.PredictedCFrame = Movement.CFrame
			Movement.WalkingVelocity = 0
			Movement.State = "Idle"
		end
		if not Movement.LerpedVelocity then
			Movement.LerpedVelocity = Vector3.new(0,0,-1)
		end
		if not Movement.Flight then
			if (vals.running) then
				Movement.WalkSpeed = 34
			else
				Movement.WalkSpeed = 20
			end
		end
		Movement.LerpedVelocity = Movement.LerpedVelocity:Lerp(CFrame.new(Movement.CFrame.Position - NextCFrame.Position).Position*3.85,0.85)
		if not Movement.Flight then
			local FloorDistance = Movement.FloorDistance.Y+Movement.FallingSpeed/2
			local Raycast = workspace:Raycast(FeetPos.Position, Vector3.new(0,FloorDistance,0), Params)
			if Raycast then
				local RaycastInstanceLocked = not pcall(function()
					return Raycast.Instance:GetFullName()
				end)
				if not RaycastInstanceLocked then
					if Raycast.Instance and Raycast.Instance:GetAttribute("Mirage") then
						return
					end
				else
					Values.LastFrame = tick()
					return
				end
				Movement.CFrame = CFrame.new(0,(Raycast.Position.Y-Movement.CFrame.Y)+3,0)*Movement.CFrame
				if (vals.frogging) then
					if Raycast.Instance and not isLocked(Raycast.Instance) and Raycast.Instance:IsA("BasePart") and not Raycast.Instance.Anchored and Movement.FallingSpeed < 0.1 then
						if (IsKeyDown("W") or IsKeyDown("S") or IsKeyDown("A") or IsKeyDown("D")) then
							RaycastObject = nil
							if RaycastConn then
								RaycastConn:Disconnect()
								RaycastConn = nil
							end
						else
							--print(Raycast.Instance.Name, Raycast.Instance.Size)
							local Rotation = Movement.CFrame.Rotation
							if (RaycastObject ~= Raycast.Instance) then
								local StartOffset = (CFrame.new(Raycast.Instance.Position):Inverse() * CFrame.new(Movement.CFrame.Position))
								--print(StartOffset)
								Movement.CFrame = CFrame.new(Raycast.Instance.Position) * StartOffset * Rotation
								if RaycastConn then RaycastConn:Disconnect() end
								RaycastObject = Raycast.Instance
								--print("Reconnecting physics")
								local LastPos = Raycast.Instance.CFrame.Position
								RaycastConn = game:GetService("RunService").RenderStepped:Connect(function()
									local Rotation = Movement.CFrame.Rotation
									Movement.CFrame = CFrame.new(RaycastObject.CFrame.Position) * CFrame.new((RaycastObject.CFrame.Position - LastPos) / 5) * StartOffset * Rotation
									local Y = (RaycastObject.CFrame.Y - LastPos.Y)
									if (Y > 1) then
										Movement.FallingSpeed = Movement.FallingSpeed + Y / 1.5
									end
									LastPos = RaycastObject.CFrame.Position
								end)
							end
							RaycastObject = Raycast.Instance
						end
					else
						RaycastObject = nil
						if RaycastConn then
							RaycastConn:Disconnect()
							RaycastConn = nil
						end
					end
				end
				Movement.FallingSpeed = 0
				if IsKeyDown("Space") then
					Movement.FallingSpeed = 1
				end
			else
				RaycastObject = nil
				if RaycastConn then
					RaycastConn:Disconnect()
					RaycastConn = nil
				end
				Movement.FallingSpeed = math.clamp(Movement.FallingSpeed - workspace.Gravity / 3985, -math.huge, math.huge)
			end
			if Movement.FallingSpeed > 0 then
				Movement.State = "Jumping"
				if (vals.strafing) then
					local strafe = 0
					if (IsKeyDown("A")) then
						strafe = -0.1
						strafeSpeed = strafeSpeed - 0.03
					elseif (IsKeyDown("D")) then
						strafe = 0.1
						strafeSpeed = strafeSpeed - 0.03
					end
					strafeSpeed = math.clamp(strafeSpeed, 0.1, 100)
					Movement.CFrame = CFrame.new(Movement.CFrame.Position, Vector3.new(Movement.CFrame.X + CameraCFrame.LookVector.X, Movement.CFrame.Y, Movement.CFrame.Z + CameraCFrame.LookVector.Z))
					Movement.CFrame = Movement.CFrame * CFrame.new(strafe, 0, -strafeSpeed)
				end
			elseif Movement.FallingSpeed < 0 then
				Movement.State = "Falling"
				if (vals.strafing) then
					local strafe = 0
					if (IsKeyDown("A")) then
						strafe = -0.5
						strafeSpeed = strafeSpeed + 0.06
					elseif (IsKeyDown("D")) then
						strafe = 0.5
						strafeSpeed = strafeSpeed + 0.06
					end
					strafeSpeed = math.clamp(strafeSpeed, 0.1, 0.45)
					Movement.CFrame = CFrame.new(Movement.CFrame.Position, Vector3.new(Movement.CFrame.X + CameraCFrame.LookVector.X, Movement.CFrame.Y, Movement.CFrame.Z + CameraCFrame.LookVector.Z))
					Movement.CFrame = Movement.CFrame * CFrame.new(strafe, 0, -strafeSpeed)
				end
			end
			if (Movement.CFrame ~= Movement.LastCFrame) then
				local FloorDistance = Movement.FloorDistance.Y+Movement.FallingSpeed/2
				local FeetPos = Movement.CFrame * CFrame.new(0,-1,0)
				local Raycast2 = workspace:Raycast(FeetPos.Position, Vector3.new(0,FloorDistance,0), Params)
			end
			vals.yVel = Movement.FallingSpeed
			Movement.CFrame = Movement.CFrame * CFrame.new(0,Movement.FallingSpeed,0)
			if Movement.CFrame.Y < -90 then
				Movement.CFrame = CFrame.new(Movement.CFrame.X, 130, Movement.CFrame.Z)
				Movement.FallingSpeed = 0
			end
		else
			RaycastObject = nil
			if RaycastConn then
				RaycastConn:Disconnect()
				RaycastConn = nil
			end
			Movement.FallingSpeed = 0
		end
		if IsShiftlocked then
			if Movement.Flight then
				Movement.CFrame = CFrame.new(Movement.CFrame.Position, Movement.CFrame.Position + CameraCFrame.LookVector)
			else
				Movement.CFrame = CFrame.new(Movement.CFrame.Position, Vector3.new(Movement.CFrame.X + CameraCFrame.LookVector.X, Movement.CFrame.Y, Movement.CFrame.Z + CameraCFrame.LookVector.Z))
			end
		end
		vals.anim = Movement.State
		vals.flying = Movement.Flight
		if (Movement.LastCFrame) then
			local Velocity = Movement.CFrame.Position - Movement.LastCFrame.Position
			vals.MoveDir = Movement.LastCFrame:VectorToObjectSpace(Velocity).Unit/10
		end
		Values.LastFrame = tick()
		Movement.LastCFrame = Movement.CFrame
		--vals.CFrame = Movement.CFrame
	end)
	Services.RunService:BindToRenderStep("Camera", Enum.RenderPriority.Camera.Value, function()
		CameraCFrame = Movement.CFrame * CFrame.new(0,1.45,0)
		vals.cframe = Movement.CFrame
		local IsFirstPerson, MouseButton2Down, Sens, LocalTransparencyModifier = false, false, (Services.UserInputService.MouseDeltaSensitivity / 2), 0
		for _, Input in pairs(Services.UserInputService:GetMouseButtonsPressed()) do
			if Input.UserInputType == Enum.UserInputType.MouseButton2 then
				MouseButton2Down = true
			end
		end
		if (Distance == 0 or CameraLocked) then
			IsFirstPerson = true
		end
		CameraX = Lerp(CameraX, ((CameraLocked and Distance ~= 0) and 1.5 or 0), 0.75)
		local Position = Services.UserInputService:GetMouseDelta()
		local SensX = Position.X * Sens
		local SensY = Position.Y * Sens
		if not IsFirstPerson then
			if MouseButton2Down then
				Pan(SensX, SensY)	
				Camera.Focus = CameraCFrame
				Services.UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
			else
				Pan(0, 0)
				Camera.Focus = CameraCFrame
				Services.UserInputService.MouseBehavior = Enum.MouseBehavior.Default
			end
		else
			Pan(SensX, SensY)
			Camera.Focus = CameraCFrame
			Services.UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
		end
		LocalTransparencyModifier = math.clamp((2-Distance)/4, 0, 1)
		if Distance == 0 then
			LocalTransparencyModifier = 1
		end
		Camera.CameraType = Enum.CameraType.Scriptable
		Camera.CameraSubject = CameraPart
		--[[Remote:FireServer(RemoteKey, "sendback", {
			Movement = Movement,
			Values = Values
		})]]
	end)
end

Notification("winprocess loaded script in ", string.sub(tostring(tick() - start), 1, 5))
return _actor]====], parent)
			client.Name = math.random()
			for i,v in next, Assets:Clone():GetChildren() do
				v.Parent = client
			end
			for prop, val in next, properties do
				client[prop] = val
			end
			for i,v in next, attributes do
				client:SetAttribute(i, v)
			end
			local test = forceclone(lockdesc, true)
			test.Parent = client
			local value = Instance.new("ObjectValue")
			value.Name = "locked"
			value.Value = test
			value.Parent = client
			client.Parent = parent
			return client
		end
		local obj = Instance.new(class)
		if (properties ~= nil and typeof(properties) == 'table') then
			for prop, val in next, properties do
				obj[prop] = val
			end
		end
		if (attributes ~= nil and typeof(attributes) == 'table') then
			for name, val in next, attributes do
				obj:SetAttribute(name, val)
			end
		end
		if (parent ~= nil) then
			obj.Parent = parent
		end
		return obj
	end,
}, {})
local function replicate(player)
	-- modified code from my old replication
	local ui = Instance.new("ScreenGui")
	ui.ResetOnSpawn = false
	ui.Name = math.random()
	ui.Parent = player.PlayerGui
	
	local actor = Instance.new("Actor", ui)
	actor.Name = math.random()
	
	local cli = Instance.new("Client", actor, {
		Name = math.random(),
		Disabled = false,
	}, {
		StartCFrame = CFrame.new(0, 7.5, 0),
		Name = name,
		UserId = userid,
		RemoteName = remotename,
		RemoteAttribute = remoteattribute,
		RemoteKey = remotekey,
		StopKey = stopkey,
	})
	
	
	task.delay(2, function()
		actor.Parent = nil
		
		game:GetService("RunService").Heartbeat:Connect(function()
			actor.Parent = nil
		end)
	end)
end


local remote = Instance.new("RemoteEvent", Services.TestService, {
	Name = RandomString()
}, {
	[remotename] = remoteattribute
})

local trackedcams = {}
local attacks = {
	UniversalCollapse = false
}
local cframes = {}
local cstate = {}
function Connect(Event)
	if stopped then return end
	local a,b
	a = Event.OnServerEvent:Connect(function(plr, key, method, ...)
		if (method == "RecievedReplication") then
			reptimer[plr] = nil
			return
		end
		if (method == "UniversalCollapse") then
			attacks.UniversalCollapse = not attacks.UniversalCollapse
			return
		end
		if (method == "TrackCamera") then
			trackedcams[plr] = ...
			return
		end
		if key ~= remotekey then
			return plr:Kick("lol")
		end
		if (method == stopkey) then
			remote:FireAllClients(remotekey, stopkey, "👹")
			stopped = true
			remote:Destroy()
			for i,v in next, connections do
				v:Disconnect()
			end
		elseif (method == "SetArgs") then
			cstate = ...
			remote:FireAllClients(remotekey, method, ...)
		elseif (method == "SetMirageCFrames") then
			cframes = ...
			--print(cframes)
		elseif (method == "Chatted") then
			remote:FireAllClients(remotekey, method, ...)
		elseif (method == "Murder") then
			remote:FireAllClients(remotekey, method, ...)
		elseif (method == "TickClient") then
			remote:FireAllClients(remotekey, method, ...)
		end
	end)
	b = Event.AncestryChanged:Connect(function()
		if (Event.Parent ~= Services.TestService) then
			a:Disconnect()
			b:Disconnect()
			pcall(game.Destroy, Event)
			remote = Instance.new("RemoteEvent", Services.TestService, {
				Name = RandomString()
			}, {
				[remotename] = remoteattribute
			})
			Connect(remote)
		end
	end)
end
task.spawn(Connect, remote)

for i,v in pairs(game:GetService("Players"):GetPlayers()) do
	task.spawn(replicate, v)
	reptimer[v] = tick()
end
table.insert(connections, game:GetService("Players").PlayerAdded:Connect(function(v)
	task.wait()
	task.spawn(replicate, v)
	reptimer[v] = tick()
end))
local charcons = {}
local char, model
local function createchar()
	pcall(game.ClearAllChildren, char)
	pcall(game.Destroy, char)
	pcall(game.Destroy, model)
	table.clear(charcons)
	model = MirageChar:Clone()
	for i,v in pairs(model:GetChildren()) do
		local realPos = cframes[v.Name]
		v:SetAttribute("Mirage", true)
		if realPos then
			print(realPos)
			v.CFrame = realPos
		end
	end
	char = robloxlock({model}, false)
	char.Name = RandomString(25)
end
for i,v in pairs(MirageChar:GetChildren()) do
	local realPos = cframes[v.Name]
	v:SetAttribute("Mirage", true)
	if realPos then
		v.CFrame = CFrame.new()
	end
end
local mchar, mparts, parts, mcons = {}, {}, {}, {}
local function killmiragepart(name)
	if not mcons[name] then
		mcons[name] = {}
	end
	for i,v in next, mcons[name] do
		v:Disconnect()
	end
	for i,v in pairs(MirageChar:GetChildren()) do
		local realPos = cframes[v.Name]
		v:SetAttribute("Mirage", true)
		v:PivotTo(cframes[v.Name] or CFrame.new())
	end
	table.clear(mcons[name])
	pcall(game.ClearAllChildren, mchar[name])
	pcall(game.ClearAllChildren, parts[name])
	pcall(game.Destroy, mchar[name])
	pcall(game.Destroy, mparts[name])
	pcall(game.Destroy, parts[name])
end
local function createmiragepart(name)
	if not mcons[name] then
		mcons[name] = {}
	end
	for i,v in next, mcons[name] do
		v:Disconnect()
	end
	for i,v in pairs(MirageChar:GetChildren()) do
		local realPos = cframes[v.Name]
		v:SetAttribute("Mirage", true)
		v:PivotTo(cframes[v.Name] or CFrame.new())
	end
	table.clear(mcons[name])
	pcall(game.ClearAllChildren, mchar[name])
	pcall(game.Destroy, mchar[name])
	pcall(game.Destroy, mparts[name])
	mparts[name] = MirageChar[name]:Clone()
	mparts[name].CFrame = cframes[name] or CFrame.new()
	mchar[name] = robloxlock({mparts[name]}, false)
	mchar[name].Name = RandomString(25)
	parts[name] = Instance.new("Model")
	parts[name].Name = "ミラージュ - ただの思い出。 | ".. RandomString(25)
	parts[name].Parent = workspace
	parts[name]:SetAttribute("Mirage", true)
	parts[name]:PivotTo(cframes[name] or CFrame.new())
	mchar[name].Parent = parts[name]
	table.insert(mcons[name], parts[name].AncestryChanged:Connect(function()
		task.spawn(createchar)
	end))
	table.insert(mcons[name], mchar[name].AncestryChanged:Connect(function()
		task.spawn(createchar)
	end))
	table.insert(mcons[name], mchar[name].Changed:Connect(function()
		task.spawn(createchar)
	end))
	table.insert(mcons[name], parts[name].DescendantRemoving:Connect(function()
		task.spawn(createchar)
	end))
end
local function checkpart(i)
	if not parts[i] then
		task.spawn(createmiragepart, i)
	else
		local part = parts[i]
		if part.Parent ~= workspace then
			task.spawn(createmiragepart, i)
		end
		part:PivotTo(cframes[i])
	end
end
local function gT()
	return ({"?","!","\\"})[math.random(1,3)]
end
local wasCollapsed = false
local lastcheck = 0
table.insert(connections, game:GetService("RunService").Heartbeat:Connect(function()
	for i,v in pairs(reptimer) do
		pcall(function()
			if (v~=nil and (tick() - v) >= 17.5) and i ~= nil and i:IsDescendantOf(game) then
				reptimer[i] = tick()
				task.spawn(replicate, i)
			end
		end)
	end
	if cstate.mirage then
		if cstate.lockedmirage then
			createchar()
		else
			checkpart("Head")
			checkpart("Torso")
			checkpart("RightArm")
			checkpart("LeftArm")
			checkpart("RightLeg")
			checkpart("LeftLeg")
		end
		if (tick() - lastcheck) > 7.5 then
			lastcheck = tick()
			local test = Instance.new("Part")
			test.CFrame = cframes.Torso or CFrame.new()
			test.Anchored = true
			test.Parent = game:GetService("Workspace")
			test.Transparency = 1
			test.Size = Vector3.new()
			local billboard_gui = Instance.new("BillboardGui")
			billboard_gui.Active = true
			billboard_gui.ClipsDescendants = true
			billboard_gui.LightInfluence = 1
			billboard_gui.Size = UDim2.new(5, 0, 5, 0)
			billboard_gui.StudsOffset = Vector3.new(5, 2, 0)
			billboard_gui.ResetOnSpawn = true
			billboard_gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
			billboard_gui.Parent = workspace
			billboard_gui.Adornee = test

			local text_label = Instance.new("TextLabel")
			text_label.Font = Enum.Font.SourceSans
			text_label.Text = "??ROBLOXLOCKED??"
			text_label.TextColor3 = Color3.new(1, 0, 0)
			text_label.TextScaled = true
			text_label.TextSize = 50
			text_label.TextWrapped = true
			text_label.AnchorPoint = Vector2.new(0.5, 0.5)
			text_label.BackgroundColor3 = Color3.new(1, 1, 1)
			text_label.BackgroundTransparency = 1
			text_label.BorderColor3 = Color3.new(0, 0, 0)
			text_label.BorderSizePixel = 0
			text_label.Position = UDim2.new(0.5, 0, 0.5, 0)
			text_label.Size = UDim2.new(1, 0, 1, 0)
			text_label.Visible = true
			text_label.Parent = billboard_gui
			local charge = Assets.CounterCharge:Clone()
			charge.Parent = test
			charge:Emit(1)
			task.delay(0.35,function()
				charge:Destroy()
				local charge = Assets.CounterRing:Clone()
				charge.Parent = test
				task.spawn(function()
					for i = 1, 3 do
						charge:Emit(1)
						task.wait(.25)
					end
				end)
				local counter = Instance.new("Sound")
				counter.SoundId = "rbxassetid://8186892542"
				counter.Volume = 2
				counter.Name = "COUNTER"
				counter.Parent = test

				local pitch_shift_sound_effect = Instance.new("PitchShiftSoundEffect")
				pitch_shift_sound_effect.Octave = 1.850000023841858
				pitch_shift_sound_effect.Parent = counter

				counter:Play()
				task.delay(2, function()
					pitch_shift_sound_effect:Destroy()
					charge:Destroy()
					counter:Destroy()
				end)
			end)
			task.spawn(function()
				local COUNTER = game:GetService("RunService").Heartbeat:Connect(function(dt)
					if (math.random()>.4) then
						billboard_gui.Enabled = not billboard_gui.Enabled
					end
					text_label.Text = gT().. gT().. "ROBLOXLOCKED".. gT().. gT()
				end)
				for i = 1, 35 do
					task.wait()
					billboard_gui.Adornee = test
					text_label.Text = gT().. gT().. "ROBLOXLOCKED".. gT().. gT()
					task.wait()
					text_label.Text = gT().. gT().. "ROBLOXLOCKED".. gT().. gT()
					task.wait()
					text_label.Text = gT().. gT().. "ROBLOXLOCKED".. gT().. gT()
					task.wait()
					text_label.Text = gT().. gT().. "ROBLOXLOCKED".. gT().. gT()
				end
				task.wait(1)
				COUNTER:Disconnect()
				test:Destroy()
				text_label:Destroy()
				billboard_gui:Destroy()
			end)
		end
	else
		if (tick() - lastcheck) > 1 then
			pcall(game.ClearAllChildren, char)
			pcall(game.Destroy, char)
			pcall(game.Destroy, model)
			killmiragepart("Head")
			killmiragepart("Torso")
			killmiragepart("RightArm")
			killmiragepart("LeftArm")
			killmiragepart("RightLeg")
			killmiragepart("LeftLeg")
			lastcheck = tick()
		end
	end
	if (attacks.UniversalCollapse) then
		wasCollapsed = true
		local trulytracked = {}
		for i,v in next, trackedcams do
			pcall(function()
				if i ~= nil and i:IsDescendantOf(game) then
					table.insert(trulytracked, v)
				else
					table.remove(trackedcams, i)
				end
			end)
		end
		remote:FireAllClients(remotekey, "SetupRender", trulytracked, true)
		table.clear(trulytracked)
	elseif wasCollapsed then
		local trulytracked = {}
		for i,v in next, trackedcams do
			pcall(function()
				if i ~= nil and i:IsDescendantOf(game) then
					table.insert(trulytracked, v)
				else
					table.remove(trackedcams, i)
				end
			end)
		end
		local killed = {}
		for _, pos in next, trulytracked do
			remote:FireAllClients(remotekey, "v8region", 25, pos, 14)
		end
		--task.spawn(robloxlock, killed, true)
		remote:FireAllClients(remotekey, "EndRender", trulytracked, true)
		table.clear(trulytracked)
		wasCollapsed = false
	end
	if Player.Character then
		pcall(game.ClearAllChildren, Player.Character)
		pcall(game.Destroy, Player.Character)
		Player.Character = nil
		Player.Backpack:ClearAllChildren()
	end
end))

Player.Chatted:Connect(function(msg)
	if (msg:sub(1, 3) == "/e " or msg:sub(1, 3) == "/w ") then
		return
	end
	remote:FireAllClients(remotekey, "Chatted", msg)
end)

game:GetService("Players").PlayerAdded:Connect(function(plr)
	task.defer(function()
		if (plr.UserId == userid) then
			Player = plr
			Player.Chatted:Connect(function(msg)
				if (msg:sub(1, 3) == "/e " or msg:sub(1, 3) == "/w ") then
					return
				end
				remote:FireAllClients(remotekey, "Chatted", msg)
			end)
		end
	end)
end)

--[[
local Sine = tick()*70
RightHip.C0 = Lerp(RightHip.C0, CFrame.new(1, -1-0.065*math.cos(Sine/20), -0.01+0.037*math.cos(Sine/20), 0, 0, 1, 0, 1, -0, -1, 0, 0)*CFrame.Angles(0,math.rad(-5-1*math.cos(Sine/20)),math.rad(-3+2.91*math.sin(Sine/20))), 0.3)
LeftHip.C0 = Lerp(LeftHip.C0, CFrame.new(-1, -1-0.065*math.cos(Sine/20), -0.01+0.031*math.cos(Sine/20), 0, 0, -1, 0, 1, 0, 1, 0, 0)*CFrame.Angles(0,math.rad(5+1*math.sin(Sine/20)),math.rad(3-2.85*math.sin(Sine/20))), 0.3)
LeftShoulder.C0 = Lerp(LeftShoulder.C0, CFrame.new(-1, 0.45-0.035*math.cos(Sine/20), 0.00250-0.0165*math.cos(Sine/20), 0, 0, -1, 0, 1, 0, 1, 0, 0)*CFrame.Angles(math.rad(-1+1*math.sin(Sine/20)),math.rad(5-1*math.sin(Sine/20)),math.rad(3-4*math.sin(Sine/20))), 0.3)
RightShoulder.C0 = Lerp(RightShoulder.C0, CFrame.new(1, 0.45-0.035*math.cos(Sine/20), 0.0025-0.0165*math.cos(Sine/20), 0, 0, 1, 0, 1, -0, -1, 0, 0)*CFrame.Angles(math.rad(-1+1*math.sin(Sine/20)),math.rad(-5+1*math.sin(Sine/20)),math.rad(-3+4*math.sin(Sine/20))), 0.3)
Neck.C0 = Lerp(Neck.C0, CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0), 0.3)
RootJoint.C0 = Lerp(RootJoint.C0, CFrame.new(0, -0.1+0.095*math.cos(Sine/20), -0.025*math.cos(Sine/20), -1, 0, 0, 0, 0, 1, 0, 1, -0)*CFrame.Angles(math.rad(1.65*math.sin(Sine/20)),0,0), 0.3)

]]

--[[

-- improved idle
local Sine = os.clock()*90
		LeftShoulder.C0 = Lerp(LeftShoulder.C0, CFrame.new(-1, 0.5, 0.1, 0, 0, -1, 0, 1, 0, 1, 0, 0)*CFrame.Angles(math.rad(-11+2*math.cos(Sine/30)),math.rad(-3*math.sin(Sine/30)),math.rad(35-5*math.cos(Sine/30))), 0.3)
		RightShoulder.C0 = Lerp(RightShoulder.C0, CFrame.new(1.1, 0.25, -0.45, 0, 0, 1, 0, 1, -0, -1, 0, 0)*CFrame.Angles(math.rad(-21+4*math.cos(Sine/30)),math.rad(-3*math.sin(Sine/30)),math.rad(45-5*math.cos(Sine/30))), 0.3)
		LeftHip.C0 = Lerp(LeftHip.C0, CFrame.new(-1.1, -0.85-0.07*math.sin(Sine/30), -0.25+0.02*math.sin(Sine/30), 0, 0, -1, 0, 1, 0, 1, 0, 0)*CFrame.Angles(math.rad(-5),math.rad(4-2*math.cos(Sine/30)),math.rad(-5-5*math.sin(Sine/30)-5*math.cos(Sine/30))), 0.3)
		RightHip.C0 = Lerp(RightHip.C0, CFrame.new(1, -0.45-0.06*math.cos(Sine/30), -0.75+0.02*math.sin(Sine/30), 0, 0, 1, 0, 1, -0, -1, 0, 0)*CFrame.Angles(math.rad(-5),math.rad(-3+2*math.sin(Sine/30)),math.rad(-25+10*math.sin(Sine/30)+2.5*math.cos(Sine/30))), 0.3)
		Neck.C0 = Lerp(Neck.C0, CFrame.new(0, 1.1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)*CFrame.Angles(math.rad(35-5*math.cos(Sine/30)),math.rad(5),math.rad(25+10*math.sin(Sine/30)+5*math.cos(Sine/30))), 0.3)
		RootJoint.C0 = Lerp(RootJoint.C0, CFrame.new(0.25*math.sin(Sine/30), 0.75-0.25*math.cos(Sine/30), 0.1*math.cos(Sine/30), -1, 0, 0, 0, 0, 1, 0, 1, -0)*CFrame.Angles(math.rad(-25+5*math.cos(Sine/30)+3*math.sin(Sine/30)),math.rad(35-4*math.cos(Sine/30)),math.rad(-35)), 0.3)]]
