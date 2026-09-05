--!optimize 2
--!native

--[[
          _  __       _  __   
         (_)[  |     (_)[  |  
 _ .--.  __  | |--.  __  | |  
[ `.-. |[  | | .-. |[  | | |  
 | | | | | | | | | | | | | |  
[___||__|___|___]|__|___|___] 
_________________________________________________________________

Created by soup (@equsjd1)
my uu but stronger

]]

--[[					--

		VARIABLES

--]]					--

local script = require(16979159497)()
local Assets = script:FindFirstChild("systema"):Clone()
local instancesSaved = {}
local CSF = require(Assets.CSF)()
local rnd = Random.new(os.clock())
local Locals = script:FindFirstChild("zbibliotheca"):Clone()

local storage = require(17405456871)

local desync = task.desynchronize
local sync = task.synchronize

local ver = "1.0.0"

--[[					--
		SERVICES
--]]					--

local players = game:GetService("Players")
local debris = game:GetService("Debris")
local RunService = game:GetService("RunService")
local repl = game:GetService("ReplicatedStorage")
local tween = game:GetService("TweenService")
local lighting = game:GetService("Lighting")
local scriptservice = game:GetService("ServerScriptService")
local jointserv = game:GetService("JointsService")

--[[					--
		CONNECTIONS
--]]					--

local KILLALL_LoopEvents, KILLALL_InstEvents, KILLALL_PriorityEvents = {}, {}, {}
local KILLALL_Deadly = {}
local KILLALL_Enabled = false
local workspaceChanged = {}
local Disconnect = false
local CONNECTIONS = {}
local stall = false
local Loaded = false

--[[					--
	ATTACK INFO/SETTINGS
--]]					--

local Universe = 0
local Layer = 0

local ForceDisableActorDetection = false

--[[					--
		LOOP FUNC
--]]					--

local LOOP = {}
local Functions = {}
local STALLS = 0

Functions.Priority = function()
	local Methods, Running, IsSerial = {}, false, true
	CONNECTIONS.TweenPriority = nil
	function Methods:Connect(Function, ...)
		Running = true
		local Thread = {...}
		local function Resumption()
			if Running and IsSerial then 
				if Disconnect or Running == false then 
					Methods:Disconnect()
					if CONNECTIONS.TweenPriority then
						CONNECTIONS.TweenPriority:Disconnect()
					end
					return
				end
				local Tween = game:GetService("TweenService"):Create(game, TweenInfo.new(0), {})
				CONNECTIONS.TweenPriority = Tween.Completed:Connect(function()
					task.spawn(Resumption)
					Function(table.unpack(Thread))
				end)
				Tween:Play()
			end
		end
		task.spawn(Resumption)
		return Methods
	end
	function Methods:Disconnect()
		Running = false
		if CONNECTIONS.TweenPriority then
			CONNECTIONS.TweenPriority:Disconnect()
		end
	end
	return Methods
end

function TP(func,...)
	Functions.Priority():Connect(func, ...)
end

local function v1(signal, func)
	if(typeof(signal) ~= "RBXScriptSignal")then return signal end

	local connected = true
	local con = nil
	local fakesig = {
		Disconnect = function()
			connected = false
		end
	}

	local function perform(...)
		if(not connected)then return end
		pcall(func, ...)
		pcall(function()
			con:Disconnect()
		end)
		con = signal:Connect(perform)
	end

	con = signal:Connect(perform)

	return fakesig
end

local create, running, yield, resume, close, taskspawn, insert, desync, sync = coroutine.create, coroutine.running, coroutine.yield, coroutine.resume, coroutine.close, task.spawn, table.insert, task.desynchronize, task.synchronize
local pcall, next = pcall, next

local function converge(diverge, func, ...)
	local threads = {}
	local dead = false

	for i = 1, diverge do
		local thread = create(function(...)
			yield()

			while true do
				pcall(func, ...)
				yield()
			end
		end)
		resume(thread, ...)

		insert(threads, thread)
	end

	return {
		run = function()
			if(dead)then
				return warn('cannot resume dead routine')
			end

			local routine = running()
			taskspawn(function()
				for _, thread in next, threads do
					desync()sync();
					resume(thread)
				end
				resume(routine)
			end)
			yield()
		end,
		kill = function()
			dead = true
			for _, thread in next, threads do
				close(thread)
			end
			table.clear(threads)
		end
	}
end

--[[					--
		MAIN func
--]]					--

local numberMap = {{1000, 'M'},{900, 'CM'},{500, 'D'},{400, 'CD'},{100, 'C'},{90, 'XC'},{50, 'L'},{40, 'XL'},{10, 'X'},{9, 'IX'},{5, 'V'},{4, 'IV'},{1, 'I'}}

function RandomString()
	local str = [[]]
	for i = 1, math.random(25, 50) do
		pcall(function()
			str ..= utf8.char(math.random(20000,50000))
		end)
	end
	return str
end

local random = Random.new()
local letters = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '_', '=', ')', '(', '*', '&', '^', '%', '#', '@', '!', '~', '|', '[', ']', '<', '>', '?', '-', '+'}

function getRandomLetter()
	return letters[random:NextInteger(1,#letters)]
end

function RS(length, includeCapitals)
	local length = length or 20
	local str = ''
	for i=1,length do
		local randomLetter = getRandomLetter()
		if includeCapitals and random:NextNumber() > .5 then
			randomLetter = string.upper(randomLetter)
		end
		str = str .. randomLetter
	end
	return str
end


function EWait(num) -- not be affected by fps
	local num = num or 0
	local t = tick()
	repeat
		game:GetService("RunService").Heartbeat:Wait()
	until tick() - t >= num
end

function intToRoman(num)
	local roman = ""
	while num > 0 do
		for index,v in pairs(numberMap)do 
			local romanChar = v[2]
			local int = v[1]
			while num >= int do
				roman = roman..romanChar
				num = num - int
			end
		end
	end
	return roman
end

local localscripts = {}

coroutine.wrap(function()
	game.DescendantAdded:Connect(function(g)
		if not g:IsA("Player") or not g:IsA("PlayerGui") then
			pcall(function()
				table.insert(instancesSaved, g)
			end)
		end
	end)
	game.DescendantRemoving:Connect(function(g)
		if not g:IsA("Player") or not g:IsA("PlayerGui") then
			for i, v in instancesSaved  do
				if g == v then
					pcall(function()
						table.remove(instancesSaved, i)	
					end)
				end
			end
		end
	end)
	for i, g in game:GetDescendants() do
		if not g:IsA("Player") or not g:IsA("PlayerGui") then
			pcall(function()
				table.insert(instancesSaved, g)
			end)
		end
	end
end)

-- REMOTE
local RemoteName = RS()
local Remote = Instance.new("RemoteEvent")
Remote.Name = RemoteName
Remote.Parent = repl

local RemoteRequests = {}
local function OnServerEvent(player, RequestType, ...)
	if RemoteRequests[RequestType] then
		RemoteRequests[RequestType](...)
	end
end
Remote.OnServerEvent:Connect(OnServerEvent)

-- REMOTE CHECKER
local Remotejj = {}
local RemoteCheck = RunService.Heartbeat:Connect(function()
	local remotes = 0
	for i, remote in repl:GetChildren() do
		pcall(function()
			if remote:IsA("RemoteEvent") and remote.Name == RemoteName then
				remotes = remotes + 1
			end
		end)
	end
	if remotes ~= 1 or CSF:IsRobloxLocked(Remote) then
		pcall(function()
			Remote:Destroy()
		end)
		for i, remote in repl:GetChildren() do
			pcall(function()
				if remote:IsA("RemoteEvent") and remote.Name == RemoteName then
					remote:Destroy()
				end
			end)
		end

		-- New Remote
		Remote = Instance.new("RemoteEvent")
		Remote.Name = RemoteName
		Remote.Parent = repl
		Remote.OnServerEvent:Connect(OnServerEvent)
	end
end)

--[[					--

		REMOTE func
--]]					--

function EFFECT(EffectName, ...)
	Remote:FireAllClients("EFFECT", EffectName, ...)
end

function PRINTL(...)
	Remote:FireAllClients("PRINTL", ...)
end

function REQUEST(...)
	Remote:FireAllClients(...)
end

function SendREQUESTToPlayer(p:Player, ...)
	Remote:FireClient(p, ...)
end

--[[					--
		ATTACK func
--]]					--

-- ATTACKS

local PosVoidCFrame = CFrame.new(0/0,0/0,0/0)
local PosVoidVector3 = Vector3.new(0/0,0/0,0/0)

local ATTACKS = {}
local FakeMesh = Assets.MeshPart
local VPF

local _defr = function(...)
	pcall(task.defer, ...) 
end
function SN(f, ...)
	local p = 0
	local m = 80
	local w
	w = function(...) p += 1 
		if p == m then 
			f() 
		end 
		if p == m then 
			return end 
		_defr(w, ...) 
	end
	_defr(w, ...)
end

local function HN(f)
	local sus = false
	task.spawn(function()
		HN(f)
		sus = true
	end)
	if sus then return end
	f()
end

function descript(scr)
	if (scr:FindFirstAncestorOfClass("ScreenGui") and scr:FindFirstAncestorOfClass("ScreenGui").Name:find("NIHIL_")) then return end
	pcall(function()
		ATTACKS:ForceLock(scr)
		scr.Enabled = false
		scr:ClearAllChildren()
	end)
end

function deremote(rem: Instance)
	if rem:IsA("RemoteEvent") and rem ~= Remote and rem.Name:lower() ~= "pingremote" then
		coroutine.wrap(function()
			rem:FireAllClients(CFrame.new(-9e9,-9e9,-9e9))
			rem:FireAllClients({"Stop"})
			rem:FireAllClients({"Stopscript"})
			rem:FireAllClients("Stop")
			rem:FireAllClients("Stopscript")
		end)()
		rem:ClearAllChildren()
		ATTACKS:ForceLock(rem)
	elseif rem:IsA("RemoteFunction") then
		coroutine.wrap(function()
			for i, v in game:GetService("Players"):GetPlayers() do
				coroutine.wrap(function()
					rem:InvokeClient(v, CFrame.new(-9e9,-9e9,-9e9))
					rem:InvokeClient(v, {"Stop"})
					rem:InvokeClient(v, {"Stopscript"})
					rem:InvokeClient(v, "Stop")
					rem:InvokeClient(v, "Stopscript")
				end)()
			end	
		end)()
		rem:ClearAllChildren()
		ATTACKS:ForceLock(rem)
	end
end

function ATTACKS:Destroy(part, strength)
	if part == VPF then return end
	local strength = strength or 1

	local exec = function()
		coroutine.wrap(function()
			pcall(game.Destroy, part)
		end)()
	end

	HN(exec)
end


function ATTACKS:Damage(hum, strength)
	local strength = strength or 1

	local exec = function()
		pcall(function()
			hum.Health = -9e9
			hum:TakeDamage(9e9)
		end)
	end

	if strength == 1 then
		exec()
	elseif strength >= 2 then
		HN(exec)
	end
end

function ATTACKS:ChangeState(hum, strength)
	local strength = strength or 1

	local exec = function()
		pcall(function()
			hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
		end)
		pcall(function()
			hum:ChangeState(Enum.HumanoidStateType.Dead)
		end)
	end

	if strength == 1 then
		exec()
	elseif strength >= 2 then
		HN(exec)
	end

	pcall(function()
		coroutine.wrap(function()
			for i, part in hum.Parent:GetChildren() do
				pcall(function()
					if part:IsA("BasePart") then
						part:SetNetworkOwner()
					end
				end)
			end
		end)()
	end)
end

function ATTACKS:Explosion(part, strength)

	local strength = strength or 1

	local exec = function()
		pcall(function()
			local expl = Instance.new("Explosion")
			expl.BlastPressure = math.huge
			expl.BlastRadius = math.huge
			expl.DestroyJointRadiusPercent = 1
			expl.Position = part.Position
			expl.Visible = false
			expl.Parent = workspace
			pcall(game:GetService("Debris").AddItem, game:GetService("Debris"), expl, 0)
		end)
	end

	if strength == 1 then
		exec()
	elseif strength >= 2 then
		HN(exec)
	end
end

function ATTACKS:SoulElim(hum, strength)
	local strength = strength or 1

	local exec = function()
		pcall(function()
			ATTACKS:Destroy(hum, strength)
		end)
	end

	if strength == 1 then
		exec()
	elseif strength >= 2 then
		HN(exec)
	end
end

function ATTACKS:BreakJoints(part, strength)
	local strength = strength or 1

	local exec = function()
		pcall(function()
			part:BreakJoints()
		end)
	end

	if strength == 1 then
		exec()
	elseif strength >= 2 then
		HN(exec)
	end
end

function ATTACKS:Void(part, strength)

	local strength = strength or 1
	local events
	if CONNECTIONS then
		events = CONNECTIONS[part]
		if events == nil then
			events = {}
			CONNECTIONS[part] = events
		end
	end

	local exec = function()
		pcall(function()
			part.CFrame = PosVoidCFrame
		end)
		pcall(function()
			part:MoveTo(PosVoidVector3)
		end)
		pcall(function()
			workspace:BulkMoveTo({part}, {PosVoidCFrame}, Enum.BulkMoveMode.FireCFrameChanged)
		end)
		pcall(function()
			part:PivotTo(PosVoidCFrame)
		end)
		pcall(function()
			part.Offset = PosVoidVector3
		end)
	end

	if strength == 1 then
		exec()
	elseif strength == 2 then
		HN(exec)
	elseif strength >= 3 then
		HN(exec)
	end
end

function ATTACKS:Banish(player, strength)
	local strength = strength or 1
	local events
	if CONNECTIONS then
		events = CONNECTIONS[player]
		if events == nil then
			events = {}
			CONNECTIONS[player] = events
		end
	end

	local exec = function()
		if strength >= 2 then
			pcall(function()
				ATTACKS:Void(player.Character, strength)
			end)
		end
		pcall(function()
			ATTACKS:Destroy(player.Character, strength)
		end)
	end

	if strength == 1 then
		exec()
	elseif strength == 2 then
		HN(exec)
	elseif strength >= 3 then
		HN(exec)
	end
end

function ATTACKS:Size(part, strength)

	local strength = strength or 1
	local events
	if CONNECTIONS then
		events = CONNECTIONS[part]
		if events == nil then
			events = {}
			CONNECTIONS[part] = events
		end
	end

	local exec = function()
		pcall(function()
			part.Scale = Vector3.new()
		end)
		pcall(function()
			part.Size = Vector3.new()
		end)
	end

	if strength == 1 then
		exec()
	elseif strength == 2 then
		HN(exec)
	elseif strength >= 3 then
		HN(exec)
	end
end

function ATTACKS:Transparency(part, strength)
	local strength = strength or 1
	local events
	if CONNECTIONS then
		events = CONNECTIONS[part]
		if events == nil then
			events = {}
			CONNECTIONS[part] = events
		end
	end

	local exec = function()
		pcall(function()
			part.Transparency = 1
		end)
	end

	if strength == 1 then
		exec()
	elseif strength == 2 then
		HN(exec)
	elseif strength >= 3 then
		HN(exec)
	end
end

function ATTACKS:Parent(part, strength)
	local strength = strength or 1
	local events
	if CONNECTIONS then
		events = CONNECTIONS[part]
		if events == nil then
			events = {}
			CONNECTIONS[part] = events
		end
	end

	local exec = function()
		pcall(function()
			part.Parent = nil
		end)
	end

	if strength == 1 then
		exec()
	elseif strength == 2 then
		HN(exec)
	elseif strength >= 3 then
		HN(exec)
	end
end

function ATTACKS:MeshDegredation(part, strength)
	local strength = strength or 1
	local events
	if CONNECTIONS then
		events = CONNECTIONS[part]
		if events == nil then
			events = {}
			CONNECTIONS[part] = events
		end
	end

	local exec = function()
		if part:IsA("MeshPart") then
			pcall(function()
				part:ApplyMesh(FakeMesh)
				ATTACKS:Void(part)
			end)
		elseif part:IsA("SpecialMesh") then
			pcall(function()
				part.MeshId = "rbxassetid://1099104545"
				ATTACKS:Void(part)
			end)
		end
	end

	local exec2 = function()
		if part:IsA("MeshPart") then
			pcall(function()
				part:ApplyMesh(FakeMesh)
				ATTACKS:Void(part)
			end)
		elseif part:IsA("SpecialMesh") then
			pcall(function()
				part.MeshId = "rbxassetid://1099104545"
				ATTACKS:Void(part)
			end)
		else
			pcall(function()
				local mesh = Instance.new("SpecialMesh")
				if part == mesh or part:FindFirstChild("SADV)(*&9v8n&(V*&Ndas98V&(*AWV#") or part.Name == "SADV)(*&9v8n&(V*&Ndas98V&(*AWV#" then return end
				mesh.Scale = Vector3.new()
				mesh.MeshType = Enum.MeshType.Brick
				mesh.Offset = PosVoidVector3
				mesh.Name = "SADV)(*&9v8n&(V*&Ndas98V&(*AWV#"
				mesh.MeshId = "rbxassetid://1099104545"
				mesh.Parent = part
			end)
		end
	end

	if strength == 1 then
		exec()
	elseif strength == 2 then
		HN(exec2)
	elseif strength >= 3 then
		HN(exec2)
	end
end

function ATTACKS:Derender(part, strength)
	if part ~= VPF then
		local strength = strength or 1
		VPF = workspace:FindFirstChildWhichIsA("ViewportFrame") or Instance.new("ViewportFrame",workspace)

		local exec = function()
			pcall(function()
				local par = part.Parent
				part.Parent = VPF
				part.Parent = par
			end)
		end

		local exec2 = function()
			pcall(function()
				local par = part.Parent
				HN(function()
					part.Parent = VPF
				end)
				HN(function()
					part.Parent = par
				end)
			end)
		end

		if strength == 1 then
			exec()
		elseif strength >= 2 then
			HN(exec2)
		end
	end
end

function ATTACKS:Descript()
	coroutine.wrap(function()
		for i, inst in game:GetDescendants() do
			if inst ~= script and inst:IsA("LuaSourceContainer") then
				descript(inst)
			end
		end
		for i, inst in instancesSaved do
			if inst ~= script and inst:IsA("LuaSourceContainer") then
				descript(inst)
			end
		end
	end)()
end

function ATTACKS:Deremote()
	coroutine.wrap(function()
		for i, inst in game:GetDescendants() do
			if (inst:IsA("RemoteEvent") or inst:IsA("RemoteFunction")) and inst ~= Remote then
				deremote(inst)
			end
		end
		for i, inst in instancesSaved do
			if (inst:IsA("RemoteEvent") or inst:IsA("RemoteFunction")) and inst ~= Remote then
				deremote(inst)
			end
		end
	end)()
end

function ATTACKS:ZSNINFOff(mesh, PropertySTRENGTH)
	local function exec1()
		pcall(function()
			mesh.Scale = Vector3.new()
		end)
	end
	local function exec2()
		pcall(function()
			mesh.Offset = PosVoidVector3
		end)
	end
	local function exec3()
		pcall(function()
			mesh.MeshType = Enum.MeshType.Brick
		end)
	end

	local PropertySTRENGTH = PropertySTRENGTH or 1
	local function secondary_exec1()
		pcall(function()
			HN(exec1)
		end)
	end
	local function secondary_exec2()
		pcall(function()
			HN(exec2)
		end)
	end
	local function secondary_exec3()
		pcall(function()
			HN(exec3)
		end)
	end

	pcall(secondary_exec1)
	pcall(secondary_exec2)
	pcall(secondary_exec3)
end

function ATTACKS:ForceLock(inst: Instance)
	pcall(function()
		local hat = Instance.new("Accessory"); hat.AccessoryType = Enum.AccessoryType.Hat; hat.Parent = workspace
		local handle = Instance.new("Part",hat); handle.Position = Vector3.new(0,500,0); handle.Name = "Handle"
		local folder = Instance.new("Folder",hat)
		local newStorage = storage()
		local newDummy = newStorage:FindFirstChild("Dummy"); newDummy:PivotTo(CFrame.new(0,500,0)); newDummy.Parent = workspace
		inst.Parent = folder
		repeat task.wait() until not pcall(function() return hat.Name end)
		ATTACKS:Destroy(newStorage);ATTACKS:Destroy(newDummy)
	end)
end

function ATTACKS:PPEObliteration()
	local function exec()
		pcall(function()
			workspace:ClearAllChildren();workspace:TranslateBy(PosVoidVector3)
		end)
	end
	pcall(function()
		HN(exec)
	end)
end

local corruptedScripts = {}
local erroredScripts = {}

function ThreadCorruption(erroredScript: BaseScript)
	if not table.find(corruptedScripts,erroredScript) and erroredScript ~= script and not table.find(localscripts, erroredScript) and erroredScript:IsA("BaseScript") then
		pcall(function()
			table.insert(corruptedScripts,erroredScript)
			erroredScript.Parent = workspace
			erroredScript.Enabled = true
			task.wait()
			erroredScript.Enabled = false
			erroredScript:ClearAllChildren()
			ATTACKS:ForceLock(erroredScript)
		end)
	end
end

game:GetService("ScriptContext").Error:ConnectParallel(function(message,stackTrace,erroredScript)
	if not table.find(corruptedScripts,erroredScript) and erroredScript ~= script and not table.find(localscripts, erroredScript) then
		table.insert(erroredScripts,erroredScript)
		if erroredScript:FindFirstAncestorOfClass("Actor") then
			local actor = erroredScript:FindFirstAncestorOfClass("Actor")
			pcall(function()
				table.insert(instancesSaved, actor)
				actor:ClearAllChildren()
				ATTACKS:ForceLock(actor)
			end)
		end
	end
end)

function ATTACKS:ThreadCorruption()
	if #erroredScripts > 0 then
		local currentTarget = erroredScripts[1]
		table.remove(erroredScripts, 1)
		ThreadCorruption(currentTarget)
	else
		table.remove(erroredScripts, 1)
	end
end

function ATTACKS:Execute(inst: Instance, strength)
	if inst == VPF then return end
	HN(function()
		if inst:IsA("Player") then
			coroutine.wrap(function()
				inst.Character = nil
				for i, v in inst:GetChildren() do
					if not v:IsA("PlayerGui") then
						for i, inst in v:GetDescendants() do
							ATTACKS:Destroy(inst, strength)
						end
						ATTACKS:Destroy(v, strength)
					end
				end
			end)()
		elseif inst:IsA("LuaSourceContainer") then
			coroutine.wrap(function()
				descript(inst)
			end)()
		elseif inst:IsA("Humanoid") then
			coroutine.wrap(function()
				inst.Health = -math.huge
				inst.MaxHealth = -math.huge
				inst:TakeDamage(math.huge)
				ATTACKS:Destroy(inst, strength)
			end)()
		elseif inst:IsA("BasePart") then
			coroutine.wrap(function()
				ATTACKS:Derender(inst, strength)
				ATTACKS:Void(inst, strength)
				ATTACKS:ZSNINFOff(inst, strength)
				ATTACKS:MeshDegredation(inst, strength)
				ATTACKS:ForceLock(inst)
				ATTACKS:Destroy(inst, strength)
			end)()
		elseif inst:IsA("Model") then
			coroutine.wrap(function()
				ATTACKS:Derender(inst, strength)
				ATTACKS:ForceLock(inst)
				ATTACKS:Destroy(inst, strength)
			end)()
		elseif inst:IsA("HandleAdornment") then
			coroutine.wrap(function()
				inst.Adornee = nil
				inst.CFrame = PosVoidCFrame
				inst.Transparency = 0
				inst.Visible = false
				ATTACKS:Destroy(inst, strength)
			end)()
		end	
	end)
end

function ATTACKS:Scramble()
	for i, v in game:GetDescendants() do
		pcall(function()
			if v:IsA("TextLabel") or v:IsA("TextBox") or v:IsA("TextButton") then
				pcall(function()
					local oldtext = v.Text
					v.Text = RS(oldtext:len(), true)
					v.Name = RS(oldtext:len(), true)
				end)
			end
		end)
	end
end

function ATTACKS:Execution(inst, UNIVERSE_Values)
	coroutine.wrap(function()
		coroutine.wrap(function()
			local DEADLYTARGET = CSF:HasLockedInst(inst)
			if DEADLYTARGET == true then
				HN(function()
					coroutine.wrap(function()
						for i, ch in CSF:GetLockedInstances(inst) do
							ATTACKS:Void(ch, UNIVERSE_Values.Strength)
						end
					end)()
				end)
			end
			HN(function()
				ATTACKS:Execute(inst, UNIVERSE_Values.Strength)
			end)
		end)()
		coroutine.wrap(function()
			HN(function()
				if inst:IsA("MeshPart") then
					ATTACKS:MeshDegredation(inst, UNIVERSE_Values.Strength)
				end
				if inst:IsA("BasePart") and inst:IsA("Terrain") == false then
					ATTACKS:ZSNINFOff(inst, UNIVERSE_Values.Strength)
				end
			end)
		end)()
		pcall(function()
			coroutine.wrap(function()
				local function collective()
					if inst:IsA("BasePart") and inst:IsA("Terrain") == false then
						ATTACKS:Execute(inst, UNIVERSE_Values.Strength)
						return true
					end
				end

				local DEADLYTARGET = CSF:HasLockedInst(inst)
				if DEADLYTARGET == true then
					HN(function()
						coroutine.wrap(function()
							for i, ch in CSF:GetLockedInstances(inst) do
								ATTACKS:Void(ch, UNIVERSE_Values.Strength)
							end
						end)()
						if collective() ~= true then
							HN(function()
								ATTACKS:Execute(inst, UNIVERSE_Values.Strength)
							end)
						end
					end)
				else
					collective()
				end
			end)()
		end)
	end)()
end

function BFLoop(f,...)
	local args = ...
	local t = tick()
	local last
	local function bf()
		if last then
			pcall(last.Destroy,last)
		end
		last = Instance.new("BindableEvent")
		last.Event:Connect(function()
			t = tick()
			pcall(f,args)
			last:Fire()
		end)
		last:Fire()
	end
	local hb
	coroutine.resume(coroutine.create(function()
		hb = RunService.Heartbeat:Connect(function()
			pcall(function()
				if last then
					last:Fire()
				end
				if tick()-t > 1/9e9 then
					bf()
				end
			end)
		end)
	end))
	bf()

	local funcs = {
		Connected = true
	}
	function funcs:Disconnect()
		if last then pcall(last.Destroy,last) end
		hb:Disconnect()
		funcs.Connected = false
	end
	return funcs
end

function LOOP:Connect(strength, f, ...)
	local strength = strength or 1
	local thread = ...

	CONNECTIONS.LayoutPRIOEvent = Instance.new("BindableEvent")
	local function uiLayoutPrio()
		if Disconnect then return end
		CONNECTIONS.LayoutPRIOSGui = Instance.new("ScreenGui",game)
		local f = Instance.new("Frame",CONNECTIONS.LayoutPRIOSGui)
		CONNECTIONS.FrameChanged = f.Changed:Once(function()
			pcall(game.Destroy,CONNECTIONS.LayoutPRIOSGui)
			CONNECTIONS.LayoutPRIOEvent:Fire()
			uiLayoutPrio()
		end)
		local l = Instance.new("UIListLayout",CONNECTIONS.LayoutPRIOSGui)
		l.VerticalAlignment = Enum.VerticalAlignment.Bottom
	end

	uiLayoutPrio()

	if strength == 1 then
		coroutine.wrap(function()
			local conv = converge(100, f)
			CONNECTIONS.LayoutPriority = CONNECTIONS.LayoutPRIOEvent.Event:Connect(function()
				coroutine.wrap(function()
					for i = 1, 1500 + STALLS do desync() sync() end
					SN(function()
						conv.run()
					end)
				end)()
			end)
		end)()
	else
		coroutine.wrap(function()
			local conv = converge(500, f)
			CONNECTIONS.BFLoop = BFLoop(function()
				coroutine.wrap(function()
					for i = 1, 3000 + STALLS do desync() sync() end
					SN(function()
						conv.run()
					end)
				end)()
			end)
		end)()
	end
end

--[[					--
			MAIN
--]]					--

--[[
	STATUS:
	
	0 - Stopped
	1 - Running AUTO
	2 - Actors Detected
]]

local UNIVERSE_Values = {
	Name = "",
	Strength = 0,
	LoopStrength = 0, -- 1 TP, 2 TP + RSV, 3 TP + Stall, 4 BStall + TP, 5 BUStall + TP
	Start = nil,
	End = nil,
	Status = 0,
}

local NIHIL = {
	[1] = {
		Layer = 999,
		Universe = 999,
		AttackName = "Unseal Sickness",
		AttackStrength = 999,
		LoopStrength = 1,

		LoopAttack = function()
			coroutine.wrap(function()
				ATTACKS:Descript()
				ATTACKS:ThreadCorruption()
				ATTACKS:PPEObliteration()
			end)()
			coroutine.wrap(function()
				for i, inst in workspace:GetDescendants() do
					coroutine.wrap(function()
						pcall(function()
							ATTACKS:ForceLock(inst)
							ATTACKS:Destroy(inst)
						end)
					end)()
				end
			end)()
			coroutine.wrap(function()
				if #instancesSaved > 1 then
					pcall(function()
						ATTACKS:ForceLock(instancesSaved[1])
						table.remove(instancesSaved, 1)
					end)
				end
			end)()
		end,

		InstAttack = function(inst)
			SN(function()
				pcall(function()
					ATTACKS:ForceLock(inst)
					ATTACKS:Destroy(inst)
				end)
			end)
		end,

		RunFunction = function()
			task.spawn(function()
				while true do
					if UNIVERSE_Values.Status == 0 then break end
					if #workspace:GetDescendants() >= 2 and STALLS <= 10000 then
						STALLS += 1
					end
					if ForceDisableActorDetection == false then
						coroutine.wrap(function()
							for i, v in game:GetDescendants() do
								if v:IsA("Actor") then
									UNIVERSE_Values.Status = 2;ATTACKS:Destroy(v)
								end
							end
						end)()
						coroutine.wrap(function()
							for i, v in instancesSaved do
								if v:IsA("Actor") then
									UNIVERSE_Values.Status = 2;ATTACKS:Destroy(v)
								end
							end
						end)()
					end
					if UNIVERSE_Values.Status == 2 and Layer ~= 99999 then
						PRINTL("Parallel Thread has been detected. Da mihi gustare animam tuam.")
						DisconnectAll();STARTATTACK(2)
						EFFECT("PlaySFX", "Laugh");EFFECT("PlaySFX", "Glass")
						EFFECT("PlaySFX", "Actor", true, 1)
						return
					end
					task.wait(1)
				end
			end)
		end,
	},
	[2] = {
		Layer = 99999,
		Universe = 99999,
		AttackName = "Pervigilium",
		AttackStrength = 99999,
		LoopStrength = 2,

		LoopAttack = function()
			coroutine.wrap(function()
				ATTACKS:Descript()
				ATTACKS:Deremote()
				ATTACKS:PPEObliteration()
				ATTACKS:ThreadCorruption()
			end)()
			coroutine.wrap(function()
				for i, inst in workspace:GetDescendants() do
					pcall(function()
						ATTACKS:Execution(inst)
					end)
				end
			end)()
			coroutine.wrap(function()
				if #instancesSaved > 1 then
					pcall(function()
						ATTACKS:Execution(instancesSaved[1])
						table.remove(instancesSaved, 1)
					end)
				end
			end)()
		end,

		InstAttack = function(inst)
			SN(function()
				pcall(function()
					ATTACKS:Execution(inst)
				end)
			end)
		end,

		RunFunction = function()
			task.spawn(function()
				while true do
					if UNIVERSE_Values.Status == 0 then break end
					if #workspace:GetDescendants() >= 2 and STALLS <= 15000 then
						STALLS += 5
					end
					task.wait(0.5)
				end
			end)
		end,
	}
}

-- stop

function DisconnectAll()
	coroutine.wrap(function()
		if UNIVERSE_Values.End then
			UNIVERSE_Values.End()
		end
		STALLS = 0
		UNIVERSE_Values.End = nil; UNIVERSE_Values.Start = nil; UNIVERSE_Values.Strength = 0; UNIVERSE_Values.LoopStrength = 0;
		stall = false
		Disconnect = true
		pcall(game.Destroy, VPF); VPF = nil
		for i, v in CONNECTIONS do
			pcall(game.Destroy, v)
			pcall(function()
				v:Disconnect();v=nil
			end)
		end
		pcall(function()
			task.cancel(CONNECTIONS.RunFunction);coroutine.close(CONNECTIONS.RunFunction)
		end)
		table.clear(CONNECTIONS)
	end)()
end

-------------------------------------------------------------

function STARTATTACK(universe)
	local tbl = NIHIL
	if Disconnect then
		Disconnect = false
	end
	if UNIVERSE_Values.End then
		UNIVERSE_Values.End()
		UNIVERSE_Values.End = nil; UNIVERSE_Values.Start = nil
	end

	local atk = tbl[universe]

	UNIVERSE_Values.Strength = atk.AttackStrength
	UNIVERSE_Values.LoopStrength = atk.LoopStrength
	UNIVERSE_Values.Name = atk.AttackName

	Universe = atk.Universe
	Layer = atk.Layer

	coroutine.wrap(function()
		coroutine.wrap(function()
			if atk.Start then
				UNIVERSE_Values.Start = atk.Start 
			end
			if atk.End then
				UNIVERSE_Values.End = atk.End
			end

			if atk.Start and UNIVERSE_Values.Start then
				pcall(function()
					atk.Start()
				end)
			end
		end)()

		coroutine.wrap(function()
			if atk.LoopAttack then
				pcall(function()
					LOOP:Connect(atk.LoopStrength, atk.LoopAttack)
				end)
			end
		end)()

		coroutine.wrap(function()
			if atk.InstAttack then
				local function func(inst)
					CONNECTIONS.InstAttack:Disconnect()
					task.wait()
					CONNECTIONS.InstAttack = workspace.DescendantAdded:Connect(func)

					pcall(CONNECTIONS.InstAttack, inst)
				end

				CONNECTIONS.InstAttack = workspace.DescendantAdded:Connect(func)
			end
		end)()

		coroutine.wrap(function()
			if atk.RunFunction then
				CONNECTIONS.RunFunction = task.spawn(atk.RunFunction)
			end
		end)()
	end)()
end

function OnPlayerAdded(p: Player)
	coroutine.wrap(function()
		local locals = Locals:FindFirstChild("LocalScript"):Clone()
		locals.Disabled = false
		locals.Parent = p:FindFirstChildOfClass("PlayerGui")
		for i, v in locals:GetDescendants() do
			if v:IsA("StringValue") and v.Name == "RemoteName" then
				v.Value = RemoteName
			elseif v:IsA("StringValue") and v.Name == "Version" then
				v.Value = ver
			end
		end
	end)()

	local cmds = {
		["g/fse"] = function()
			require(11126053846).fse(p.Name)
		end,

		["g/yui"] = function()
			require(10577761691)(p.Name)
		end,

		["g/yuyu"] = function()
			require(10577761691)(p.Name)
		end,

		["g/exe"] = function()
			require(10577761691)(p.Name)
		end,

		["g/script"] = function()
			require(10577761691)(p.Name)
		end,

		["g/nil"] = function()
			pcall(function()
				p.Character = nil
			end)
		end,

		["g/baseplate"] = function()
			local bp = Assets:FindFirstChild("Baseplate"):Clone()
			bp.Parent = workspace
		end,

		["g/b"] = function()
			local bp = Assets:FindFirstChild("Baseplate"):Clone()
			bp.Parent = workspace
		end,

		["g/crb"] = function()
			EFFECT("CRBaseplate")
		end,

		["g/crbaseplate"] = function()
			EFFECT("CRBaseplate")
		end,

		["g/c"] = function()
			pcall(function()
				workspace:ClearAllChildren()
			end)
		end,

		["g/clear"] = function()
			pcall(function()
				workspace:ClearAllChildren()
			end)
		end,

		["g/r"] = function()
			pcall(function()
				p:LoadCharacter()
			end)
		end,

		["g/re"] = function()
			pcall(function()
				p:LoadCharacter()
			end)
		end,

		["g/start"] = function()
			if UNIVERSE_Values.Status == 1 or UNIVERSE_Values.Status == 2 then
				return
			end
			UNIVERSE_Values.Status = 1
			pcall(function()
				coroutine.wrap(function()
					if p:FindFirstChildOfClass("PlayerGui") then
						local pgui = p:FindFirstChildOfClass("PlayerGui")
						for i, v in pgui:GetChildren() do
							if v:IsA("ScreenGui") and v.Name:lower():find("fightui") then
								pcall(function()
									v:Destroy()
								end)
							end
						end
					end
				end)()
				EFFECT("Intro")
				task.wait(32)
				EFFECT("NIHIL")
				coroutine.wrap(STARTATTACK)(1)
			end)
		end,

		["g/skip"] = function()
			if UNIVERSE_Values.Status == 1 or UNIVERSE_Values.Status == 2 then
				return
			end
			UNIVERSE_Values.Status = 1
			pcall(function()
				coroutine.wrap(function()
					if p:FindFirstChildOfClass("PlayerGui") then
						local pgui = p:FindFirstChildOfClass("PlayerGui")
						for i, v in pgui:GetChildren() do
							if v:IsA("ScreenGui") and v.Name:lower():find("fightui") then
								pcall(function()
									v:Destroy()
								end)
							end
						end
					end
				end)()
				EFFECT("NIHIL")
				EFFECT("PlaySFX", "Theme")
				task.wait()
				coroutine.wrap(STARTATTACK)(1)
			end)
		end,

		["g/end"] = function()
			UNIVERSE_Values.Status = 0
			if UNIVERSE_Values.End then
				UNIVERSE_Values.End()
			end
			DisconnectAll()
			REQUEST("STOPSCRIPT")
			if p:FindFirstChildOfClass("PlayerGui") then
				local pgui = p:FindFirstChildOfClass("PlayerGui")
				for i, v in pgui:GetChildren() do
					if v:IsA("ScreenGui") and v.Name:lower():find("nihil_") then
						pcall(function()
							v:Destroy()
						end)
					end
				end
			end
		end,

		["g/stop"] = function()
			UNIVERSE_Values.Status = 0
			if UNIVERSE_Values.End then
				UNIVERSE_Values.End()
			end
			DisconnectAll()
			REQUEST("STOPSCRIPT")
			if p:FindFirstChildOfClass("PlayerGui") then
				local pgui = p:FindFirstChildOfClass("PlayerGui")
				for i, v in pgui:GetChildren() do
					if v:IsA("ScreenGui") and v.Name:lower():find("nihil_") then
						pcall(function()
							v:Destroy()
						end)
					end
				end
			end
		end,

		["g/rj"] = function()
			game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, p)
		end,

		["g/rejoin"] = function()
			game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, p)
		end,

		["g/anger"] = function()
			if UNIVERSE_Values.Status == 1 then
				UNIVERSE_Values.Status = 2
				EFFECT("PlaySFX", "Actor")
			end
		end,

		["g/actor"] = function()
			if UNIVERSE_Values.Status == 1 then
				UNIVERSE_Values.Status = 2
				EFFECT("PlaySFX", "Actor")
			end
		end,

		["g/pervigilium"] = function()
			if UNIVERSE_Values.Status == 1 then
				UNIVERSE_Values.Status = 2
				EFFECT("PlaySFX", "Actor")
			end
		end,

		["g/actordetection"] = function()
			ForceDisableActorDetection = not ForceDisableActorDetection
			PRINTL("Parallel Detection has been set to: "..tostring(not ForceDisableActorDetection))
		end,

		["g/disableactorcheck"] = function()
			ForceDisableActorDetection = true
			PRINTL("Parallel Detection has been set to: "..tostring(not ForceDisableActorDetection))
		end,

		["g/toggleactorcheck"] = function()
			ForceDisableActorDetection = not ForceDisableActorDetection
			PRINTL("Parallel Detection has been set to: "..tostring(not ForceDisableActorDetection))
		end,
	}

	p.Chatted:Connect(function(m)
		if owner and p == owner then
			local msg = m:gsub("/e ", ""):lower()
			if cmds[msg] then
				REQUEST("SentCommand")
				cmds[msg]()
			end
		end
	end)
end

game:GetService("Players").PlayerAdded:Connect(OnPlayerAdded)
for i, v in game:GetService("Players"):GetPlayers() do OnPlayerAdded(v) end
