-- Credits to Inf Yield & all the other scripts that helped me make bypasses
local GuiLibrary = shared.GuiLibrary
local players = game:GetService("Players")
local textservice = game:GetService("TextService")
local repstorage = game:GetService("ReplicatedStorage")
local lplr = players.LocalPlayer
local workspace = game:GetService("Workspace")
local lighting = game:GetService("Lighting")
local cam = workspace.CurrentCamera
local targetinfo = shared.VapeTargetInfo
local uis = game:GetService("UserInputService")
local mouse = lplr:GetMouse()
local robloxfriends = {}
local bedwars = {}
local getfunctions
local origC0 = nil
local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport or function() end
local teleportfunc
local betterisfile = function(file)
	local suc, res = pcall(function() return readfile(file) end)
	return suc and res ~= nil
end
local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request or function(tab)
	if tab.Method == "GET" then
		return {
			Body = game:HttpGet(tab.Url, true),
			Headers = {},
			StatusCode = 200
		}
	else
		return {
			Body = "bad exploit",
			Headers = {},
			StatusCode = 404
		}
	end
end 
local getasset = getsynasset or getcustomasset
local storedshahashes = {}
local oldchanneltab
local oldchannelfunc
local oldchanneltabs = {}

local function GetURL(scripturl)
	if shared.VapeDeveloper then
		return readfile("vape/"..scripturl)
	else
		return game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/"..scripturl, true)
	end
end

local shalib = loadstring(GetURL("Libraries/sha.lua"))()
local whitelisted = {
	players = {
		"94a10e281a721c62346185156c15dcc62a987aa9a73c482db4d1b0f2b4673261ec808040fb70886bf50453c7af97903ffe398199b43fccf5d8b619121493382d",
		"a91361a785c34c433f33386ef224586b7076e1e10ebb8189fdc39b7e37822eb6c79a7d810e0d2d41e000db65f8c539ffe2144e70d48e6d3df7b66350d4699c36",
		"cd41b8c39abf4b186f611f3afd13e5d0a2e5d65540b0dab93eed68a68f3891e0448d87dbba0937395ab1b7c3d4b6aed4025caad2b90b2cdbf4ca69441644d561",
		"28f1c2514aea620a23ef6a1f084e86a993e2585110c1ddd7f98cc6b3bd331251382c0143f7520153c91a368be5683d3406e06c9e35fba61f8bd2ac811c05f46b",
		"8b6c2833fa6e3a7defdeb8ffb4dcd6d4c652e6d02621c054df7c44ebaf94858ac5cbed6a6aadf0270c07d7054b7a2dd1ebf49ab20ffbc567213376c7848b8b90",
		"6662a5dfbb5311ee66af25cf9b6255c8b70f977022fcaed8fa9e6bcb4fe0159c148835d7c3b599a5f92f9a67455e0158f8977f33e9306dd4cee3efceb0b75441",
		"bdf4e13afb63148ad68cf75e25ec6f0cf11e0c4a597e8bdd5c93724a44bde2ce12eee46549a90ae4390bbfa36f8c662b7634600c552ca21d093004d473f9b23f"
	},
	owners = {
		"66ed442039083616d035cd09a9701e6c225bd61278aaad11a759956172144867ed1b0dc1ecc4f779e6084d7d576e49250f8066e2f9ad86340185939a7e79b30f",
		"55273f4b0931f16c1677680328f2784842114d212498a657a79bb5086b3929c173c5e3ca5b41fa3301b62cccf1b241db68a85e3cd9bbe5545b7a8c6422e7f0d2",
		"478f0b3d89f381dffec0c9414700d03760f27d3d38fe8f4743f05c699e971704af2668e107ce45b4b4fef3981d9235f880383d0e7c2d282680a7ae5aba89ddb7",
		"9d971e1f06b498a8266cfb36ad2bd618435feb6bba9c3eed3796a5e970f881bbe56142330ae95351458761a719e27318464a433ac3927c14b97e7be0d5587cfe" 
		}
	},
	chattags = {
		["a"] = {
			NameColor = {r = 255, g = 0, b = 0},
			Tags = {
				{
					TagColor = {r = 255, g = 0, b = 0},
					TagText = "okay"
				}
			}
		}
	}
}
 pcall(function()
	whitelisted = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://raw.githubusercontent.com/leaker-lol/WLV2/main/Ez.json", true))
end)

local RunLoops = {RenderStepTable = {}, StepTable = {}, HeartTable = {}}
do
	function RunLoops:BindToRenderStep(name, num, func)
		if RunLoops.RenderStepTable[name] == nil then
			RunLoops.RenderStepTable[name] = game:GetService("RunService").RenderStepped:connect(func)
		end
	end

	function RunLoops:UnbindFromRenderStep(name)
		if RunLoops.RenderStepTable[name] then
			RunLoops.RenderStepTable[name]:Disconnect()
			RunLoops.RenderStepTable[name] = nil
		end
	end

	function RunLoops:BindToStepped(name, num, func)
		if RunLoops.StepTable[name] == nil then
			RunLoops.StepTable[name] = game:GetService("RunService").Stepped:connect(func)
		end
	end

	function RunLoops:UnbindFromStepped(name)
		if RunLoops.StepTable[name] then
			RunLoops.StepTable[name]:Disconnect()
			RunLoops.StepTable[name] = nil
		end
	end

	function RunLoops:BindToHeartbeat(name, num, func)
		if RunLoops.HeartTable[name] == nil then
			RunLoops.HeartTable[name] = game:GetService("RunService").Heartbeat:connect(func)
		end
	end

	function RunLoops:UnbindFromHeartbeat(name)
		if RunLoops.HeartTable[name] then
			RunLoops.HeartTable[name]:Disconnect()
			RunLoops.HeartTable[name] = nil
		end
	end
end

local function runcode(func)
	func()
end

local function betterfind(tab, obj)
	for i,v in pairs(tab) do
		if v == obj or type(v) == "table" and v.hash == obj then
			return v
		end
	end
	return nil
end

local function addvectortocframe(cframe, vec)
	local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = cframe:GetComponents()
	return CFrame.new(x + vec.X, y + vec.Y, z + vec.Z, R00, R01, R02, R10, R11, R12, R20, R21, R22)
end

local function getremote(tab)
	for i,v in pairs(tab) do
		if v == "Client" then
			return tab[i + 1]
		end
	end
	return ""
end

local function getcustomassetfunc(path)
	if not betterisfile(path) then
		spawn(function()
			local textlabel = Instance.new("TextLabel")
			textlabel.Size = UDim2.new(1, 0, 0, 36)
			textlabel.Text = "Downloading "..path
			textlabel.BackgroundTransparency = 1
			textlabel.TextStrokeTransparency = 0
			textlabel.TextSize = 30
			textlabel.Font = Enum.Font.SourceSans
			textlabel.TextColor3 = Color3.new(1, 1, 1)
			textlabel.Position = UDim2.new(0, 0, 0, -36)
			textlabel.Parent = GuiLibrary["MainGui"]
			repeat task.wait() until betterisfile(path)
			textlabel:Remove()
		end)
		local req = requestfunc({
			Url = "https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/"..path:gsub("vape/assets", "assets"),
			Method = "GET"
		})
		writefile(path, req.Body)
	end
	return getasset(path) 
end

local function isAlive(plr)
	if plr then
		return plr and plr.Character and plr.Character.Parent ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Head") and plr.Character:FindFirstChild("Humanoid")
	end
	return lplr and lplr.Character and lplr.Character.Parent ~= nil and lplr.Character:FindFirstChild("HumanoidRootPart") and lplr.Character:FindFirstChild("Head") and lplr.Character:FindFirstChild("Humanoid")
end

local function createwarning(title, text, delay)
	local suc, res = pcall(function()
		local frame = GuiLibrary["CreateNotification"](title, text, delay, "assets/WarningNotification.png")
		frame.Frame.Frame.ImageColor3 = Color3.fromRGB(236, 129, 44)
		return frame
	end)
	return (suc and res)
end

local newupdate = lplr.PlayerScripts.TS:WaitForChild("ui", 3) and true or false

runcode(function()
    local flaggedremotes = {"SelfReport"}

    getfunctions = function()
        local Flamework = require(repstorage["rbxts_include"]["node_modules"]["@flamework"].core.out).Flamework
		repeat task.wait() until Flamework.isInitialized
        local KnitClient = debug.getupvalue(require(lplr.PlayerScripts.TS.knit).setup, 6)
        local Client = require(repstorage.TS.remotes).default.Client
        local OldClientGet = getmetatable(Client).Get
		local OldClientWaitFor = getmetatable(Client).WaitFor
        bedwars = {
			["BedwarsKits"] = require(repstorage.TS.games.bedwars.kit["bedwars-kit-shop"]).BedwarsKitShop,
            ["ClientHandler"] = Client,
            ["ClientStoreHandler"] = (newupdate and require(lplr.PlayerScripts.TS.ui.store).ClientStore or require(lplr.PlayerScripts.TS.rodux.rodux).ClientStore),
			["KitMeta"] = require(repstorage.TS.games.bedwars.kit["bedwars-kit-meta"]).BedwarsKitMeta,
			["LobbyClientEvents"] = (newupdate and require(repstorage["rbxts_include"]["node_modules"]["@easy-games"].lobby.out.client.events).LobbyClientEvents),
            ["sprintTable"] = KnitClient.Controllers.SprintController,
			["WeldTable"] = require(repstorage.TS.util["weld-util"]).WeldUtil,
			["QueueMeta"] = require(repstorage.TS.game["queue-meta"]).QueueMeta,
			["CheckWhitelisted"] = function(plr, ownercheck)
				local plrstr = bedwars["HashFunction"](plr.Name..plr.UserId)
				local localstr = bedwars["HashFunction"](lplr.Name..lplr.UserId)
				return ((ownercheck == nil and (betterfind(whitelisted.players, plrstr) or betterfind(whitelisted.owners, plrstr)) or ownercheck and betterfind(whitelisted.owners, plrstr))) and betterfind(whitelisted.players, localstr) == nil and betterfind(whitelisted.owners, localstr) == nil and true or false
			end,
			["CheckPlayerType"] = function(plr)
				local plrstr = bedwars["HashFunction"](plr.Name..plr.UserId)
				local playertype = "DEFAULT"
				if betterfind(whitelisted.players, plrstr) then
					playertype = "VAPE PRIVATE"
				end
				if betterfind(whitelisted.owners, plrstr) then
					playertype = "VAPE OWNER"
				end
				return playertype
			end,
			["HashFunction"] = function(str)
				if storedshahashes[tostring(str)] == nil then
					storedshahashes[tostring(str)] = shalib.sha512(tostring(str).."SelfReport")
				end
				return storedshahashes[tostring(str)]
			end,
			["getEntityTable"] = require(repstorage.TS.entity["entity-util"]).EntityUtil,
        }
		if not shared.vapebypassed then
			local realremote = repstorage:WaitForChild("GameAnalyticsError")
			realremote.Parent = nil
			local fakeremote = Instance.new("RemoteEvent")
			fakeremote.Name = "GameAnalyticsError"
			fakeremote.Parent = repstorage
			game:GetService("ScriptContext").Error:Connect(function(p1, p2, p3)
				if not p3 then
					return;
				end;
				local u2 = nil;
				local v4, v5 = pcall(function()
					u2 = p3:GetFullName();
				end);
				if not v4 then
					return;
				end;
				if p3.Parent == nil then
					return;
				end
				realremote:FireServer(p1, p2, u2);
			end)
			shared.vapebypassed = true
		end
		spawn(function()
			local chatsuc, chatres = pcall(function() return game:GetService("HttpService"):JSONDecode(readfile("vape/Profiles/bedwarssettings.json")) end)
			if chatsuc then
				if chatres.crashed and (not chatres.said) then
					pcall(function()
						local notification1 = createwarning("Vape", "either ur poor or its a exploit moment", 10)
						notification1:GetChildren()[5].TextSize = 15
						local notification2 = createwarning("Vape", "getconnections crashed, chat hook not loaded.", 10)
						notification2:GetChildren()[5].TextSize = 13
					end)
					local jsondata = game:GetService("HttpService"):JSONEncode({
						crashed = true,
						said = true,
					})
					writefile("vape/Profiles/bedwarssettings.json", jsondata)
				end
				if chatres.crashed then
					return nil
				else
					local jsondata = game:GetService("HttpService"):JSONEncode({
						crashed = true,
						said = false,
					})
					writefile("vape/Profiles/bedwarssettings.json", jsondata)
				end
			else
				local jsondata = game:GetService("HttpService"):JSONEncode({
					crashed = true,
					said = false,
				})
				writefile("vape/Profiles/bedwarssettings.json", jsondata)
			end
			for i3,v3 in pairs(whitelisted.chattags) do
				if v3.NameColor then
					v3.NameColor = Color3.fromRGB(v3.NameColor.r, v3.NameColor.g, v3.NameColor.b)
				end
				if v3.ChatColor then
					v3.ChatColor = Color3.fromRGB(v3.ChatColor.r, v3.ChatColor.g, v3.ChatColor.b)
				end
				if v3.Tags then
					for i4,v4 in pairs(v3.Tags) do
						if v4.TagColor then
							v4.TagColor = Color3.fromRGB(v4.TagColor.r, v4.TagColor.g, v4.TagColor.b)
						end
					end
				end
			end
			for i,v in pairs(getconnections(repstorage.DefaultChatSystemChatEvents.OnNewMessage.OnClientEvent)) do
				if v.Function and #debug.getupvalues(v.Function) > 0 and type(debug.getupvalues(v.Function)[1]) == "table" and getmetatable(debug.getupvalues(v.Function)[1]) and getmetatable(debug.getupvalues(v.Function)[1]).GetChannel then
					oldchanneltab = getmetatable(debug.getupvalues(v.Function)[1])
					oldchannelfunc = getmetatable(debug.getupvalues(v.Function)[1]).GetChannel
					getmetatable(debug.getupvalues(v.Function)[1]).GetChannel = function(Self, Name)
						local tab = oldchannelfunc(Self, Name)
						if tab and tab.AddMessageToChannel then
							local addmessage = tab.AddMessageToChannel
							if oldchanneltabs[tab] == nil then
								oldchanneltabs[tab] = tab.AddMessageToChannel
							end
							tab.AddMessageToChannel = function(Self2, MessageData)
								if MessageData.FromSpeaker and players[MessageData.FromSpeaker] then
									local plrtype = bedwars["CheckPlayerType"](players[MessageData.FromSpeaker])
									local hash = bedwars["HashFunction"](players[MessageData.FromSpeaker].Name..players[MessageData.FromSpeaker].UserId)
									if plrtype == "VAPE PRIVATE" then
										MessageData.ExtraData = {
											NameColor = players[MessageData.FromSpeaker].Team == nil and Color3.new(0, 1, 1) or players[MessageData.FromSpeaker].TeamColor.Color,
											Tags = {
												table.unpack(MessageData.ExtraData.Tags),
												{
													TagColor = Color3.new(0.7, 0, 1),
													TagText = "VAPE PRIVATE"
												}
											}
										}
									end
									if plrtype == "VAPE OWNER" then
										MessageData.ExtraData = {
											NameColor = players[MessageData.FromSpeaker].Team == nil and Color3.new(1, 0, 0) or players[MessageData.FromSpeaker].TeamColor.Color,
											Tags = {
												table.unpack(MessageData.ExtraData.Tags),
												{
													TagColor = Color3.new(1, 0.3, 0.3),
													TagText = "VAPE OWNER"
												}
											}
										}
									end
									if whitelisted.chattags[hash] then
										MessageData.ExtraData = whitelisted.chattags[hash]
									end
								end
								return addmessage(Self2, MessageData)
							end
						end
						return tab
					end
				end
			end
			local jsondata = game:GetService("HttpService"):JSONEncode({
				crashed = false,
				said = false,
			})
			writefile("vape/Profiles/bedwarssettings.json", jsondata)
		end)
	end
end)
getfunctions()

GuiLibrary["SelfDestructEvent"].Event:connect(function()
	if chatconnection then
		chatconnection:Disconnect()
	end
	if teleportfunc then
		teleportfunc:Disconnect()
	end
	if oldchannelfunc and oldchanneltab then
		oldchanneltab.GetChannel = oldchannelfunc
	end
	for i2,v2 in pairs(oldchanneltabs) do
		i2.AddMessageToChannel = v2
	end
end)

local function getNametagString(plr)
	local nametag = ""
	if bedwars["CheckPlayerType"](plr) == "VAPE PRIVATE" then
		nametag = '<font color="rgb(127, 0, 255)">[VAPE PRIVATE] '..(plr.DisplayName or plr.Name)..'</font>'
	end
	if bedwars["CheckPlayerType"](plr) == "VAPE OWNER" then
		nametag = '<font color="rgb(255, 80, 80)">[VAPE OWNER] '..(plr.DisplayName or plr.Name)..'</font>'
	end
	if whitelisted.chattags[bedwars["HashFunction"](plr.Name..plr.UserId)] then
		local data = whitelisted.chattags[bedwars["HashFunction"](plr.Name..plr.UserId)]
		local newnametag = ""
		if data.Tags then
			for i2,v2 in pairs(data.Tags) do
				newnametag = newnametag..'<font color="rgb('..math.floor(v2.TagColor.r)..', '..math.floor(v2.TagColor.g)..', '..math.floor(v2.TagColor.b)..')">['..v2.TagText..']</font> '
			end
		end
		nametag = newnametag..(newnametag.NameColor and '<font color="rgb('..math.floor(newnametag.NameColor.r)..', '..math.floor(newnametag.NameColor.g)..', '..math.floor(newnametag.NameColor.b)..')">' or '')..(plr.DisplayName or plr.Name)..(newnametag.NameColor and '</font>' or '')
	end
	return nametag
end

local function Cape(char, texture)
	for i,v in pairs(char:GetDescendants()) do
		if v.Name == "Cape" then
			v:Remove()
		end
	end
	local hum = char:WaitForChild("Humanoid")
	local torso = nil
	if hum.RigType == Enum.HumanoidRigType.R15 then
	torso = char:WaitForChild("UpperTorso")
	else
	torso = char:WaitForChild("Torso")
	end
	local p = Instance.new("Part", torso.Parent)
	p.Name = "Cape"
	p.Anchored = false
	p.CanCollide = false
	p.TopSurface = 0
	p.BottomSurface = 0
	p.FormFactor = "Custom"
	p.Size = Vector3.new(0.2,0.2,0.2)
	p.Transparency = 1
	local decal = Instance.new("Decal", p)
	decal.Texture = texture
	decal.Face = "Back"
	local msh = Instance.new("BlockMesh", p)
	msh.Scale = Vector3.new(9,17.5,0.5)
	local motor = Instance.new("Motor", p)
	motor.Part0 = p
	motor.Part1 = torso
	motor.MaxVelocity = 0.01
	motor.C0 = CFrame.new(0,2,0) * CFrame.Angles(0,math.rad(90),0)
	motor.C1 = CFrame.new(0,1,0.45) * CFrame.Angles(0,math.rad(90),0)
	local wave = false
	repeat wait(1/44)
		decal.Transparency = torso.Transparency
		local ang = 0.1
		local oldmag = torso.Velocity.magnitude
		local mv = 0.002
		if wave then
			ang = ang + ((torso.Velocity.magnitude/10) * 0.05) + 0.05
			wave = false
		else
			wave = true
		end
		ang = ang + math.min(torso.Velocity.magnitude/11, 0.5)
		motor.MaxVelocity = math.min((torso.Velocity.magnitude/111), 0.04) --+ mv
		motor.DesiredAngle = -ang
		if motor.CurrentAngle < -0.2 and motor.DesiredAngle > -0.2 then
			motor.MaxVelocity = 0.04
		end
		repeat wait() until motor.CurrentAngle == motor.DesiredAngle or math.abs(torso.Velocity.magnitude - oldmag) >= (torso.Velocity.magnitude/10) + 1
		if torso.Velocity.magnitude < 0.1 then
			wait(0.1)
		end
	until not p or p.Parent ~= torso.Parent
end	

local function renderNametag(plr)
	if bedwars["CheckPlayerType"](plr) ~= "DEFAULT" or whitelisted.chattags[bedwars["HashFunction"](plr.Name..plr.UserId)] then
		local playerlist = game:GetService("CoreGui"):FindFirstChild("PlayerList")
		if playerlist then
			pcall(function()
				local playerlistplayers = playerlist.PlayerListMaster.OffsetFrame.PlayerScrollList.SizeOffsetFrame.ScrollingFrameContainer.ScrollingFrameClippingFrame.ScollingFrame.OffsetUndoFrame
				local targetedplr = playerlistplayers:FindFirstChild("p_"..plr.UserId)
				if targetedplr then 
					targetedplr.ChildrenFrame.NameFrame.BGFrame.OverlayFrame.PlayerIcon.Image = getcustomassetfunc("vape/assets/VapeIcon.png")
				end
			end)
		end
		local nametag = getNametagString(plr)
		plr.CharacterAdded:connect(function(char)
			if char ~= oldchar then
				spawn(function()
					pcall(function() 
						bedwars["getEntityTable"]:getEntity(plr):setNametag(nametag)
						Cape(char, getcustomassetfunc("vape/assets/VapeCape.png"))
					end)
				end)
			end
		end)
		spawn(function()
			if plr.Character and plr.Character ~= oldchar then
				spawn(function()
					pcall(function() 
						bedwars["getEntityTable"]:getEntity(plr):setNametag(nametag)
						Cape(plr.Character, getcustomassetfunc("vape/assets/VapeCape.png"))
					end)
				end)
			end
		end)
	end
end

for i,v in pairs(players:GetChildren()) do renderNametag(v) end
players.PlayerAdded:connect(renderNametag)

GuiLibrary["RemoveObject"]("SilentAimOptionsButton")
GuiLibrary["RemoveObject"]("AutoClickerOptionsButton")
GuiLibrary["RemoveObject"]("MouseTPOptionsButton")
GuiLibrary["RemoveObject"]("ReachOptionsButton")
GuiLibrary["RemoveObject"]("HitBoxesOptionsButton")
GuiLibrary["RemoveObject"]("KillauraOptionsButton")
GuiLibrary["RemoveObject"]("LongJumpOptionsButton")
GuiLibrary["RemoveObject"]("HighJumpOptionsButton")
GuiLibrary["RemoveObject"]("SafeWalkOptionsButton")

teleportfunc = lplr.OnTeleport:Connect(function(State)
    if State == Enum.TeleportState.Started then
		if shared.vapeoverlay then
			queueteleport('shared.vapeoverlay = "'..shared.vapeoverlay..'"')
		end
		if shared.nobolineupdate then
			queueteleport('shared.nobolineupdate = '..tostring(shared.nobolineupdate))
		end
    end
end)

local Sprint = {["Enabled"] = false}
Sprint = GuiLibrary["ObjectsThatCanBeSaved"]["CombatWindow"]["Api"].CreateOptionsButton({
	["Name"] = "Sprint",
	["Function"] = function(callback)
		if callback then
			spawn(function()
				repeat
					task.wait()
					if bedwars["sprintTable"].sprinting == false then
						getmetatable(bedwars["sprintTable"])["startSprinting"](bedwars["sprintTable"])
					end
				until Sprint["Enabled"] == false
			end)
		end
	end, 
	["HoverText"] = "Sets your sprinting to true."
})

GuiLibrary["RemoveObject"]("FlyOptionsButton")
local flymissile
runcode(function()
	local OldNoFallFunction
	local flyspeed = {["Value"] = 40}
	local flyverticalspeed = {["Value"] = 40}
	local flyupanddown = {["Enabled"] = true}
	local flypop = {["Enabled"] = true}
	local flyautodamage = {["Enabled"] = true}
	local olddeflate
	local flyrequests = 0
	local flytime = 60
	local flylimit = false
	local flyup = false
	local flydown = false
	local tnttimer = 0
	local flypress
	local flyendpress
	local flycorountine

	local flytog = false
	local flytogtick = tick()
	fly = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "Fly",
		["Function"] = function(callback)
			if callback then
				--buyballoons()
				flypress = uis.InputBegan:connect(function(input1)
					if flyupanddown["Enabled"] and uis:GetFocusedTextBox() == nil then
						if input1.KeyCode == Enum.KeyCode.Space then
							flyup = true
						end
						if input1.KeyCode == Enum.KeyCode.LeftShift then
							flydown = true
						end
					end
				end)
				flyendpress = uis.InputEnded:connect(function(input1)
					if input1.KeyCode == Enum.KeyCode.Space then
						flyup = false
					end
					if input1.KeyCode == Enum.KeyCode.LeftShift then
						flydown = false
					end
				end)
				RunLoops:BindToHeartbeat("Fly", 1, function(delta) 
					if isAlive() then
						local mass = (lplr.Character.HumanoidRootPart:GetMass() - 1.4) * (delta * 100)
						mass = mass + (flytog and -10 or 10)
						if flytogtick <= tick() then
							flytog = not flytog
							flytogtick = tick() + 0.2
						end
						local flypos = lplr.Character.Humanoid.MoveDirection * math.clamp(flyspeed["Value"], 1, 20)
						local flypos2 = (lplr.Character.Humanoid.MoveDirection * math.clamp(flyspeed["Value"] - 20, 0, 1000)) * delta
						lplr.Character.HumanoidRootPart.Transparency = 1
						lplr.Character.HumanoidRootPart.Velocity = flypos + (Vector3.new(0, mass + (flyup and flyverticalspeed["Value"] or 0) + (flydown and -flyverticalspeed["Value"] or 0), 0))
						lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame + flypos2
						flyvelo = flypos + Vector3.new(0, mass + (flyup and flyverticalspeed["Value"] or 0) + (flydown and -flyverticalspeed["Value"] or 0), 0)
					end
				end)
			else
				flyup = false
				flydown = false
				flypress:Disconnect()
				flyendpress:Disconnect()
				RunLoops:UnbindFromHeartbeat("Fly")
			end
		end,
		["HoverText"] = "Makes you go zoom (Balloons or TNT Required)"
	})
	flyspeed = fly.CreateSlider({
		["Name"] = "Speed",
		["Min"] = 1,
		["Max"] = 38,
		["Function"] = function(val) end, 
		["Default"] = 38
	})
	flyverticalspeed = fly.CreateSlider({
		["Name"] = "Vertical Speed",
		["Min"] = 1,
		["Max"] = 100,
		["Function"] = function(val) end, 
		["Default"] = 44
	})
	flyupanddown = fly.CreateToggle({
		["Name"] = "Y Level",
		["Function"] = function() end, 
		["Default"] = true
	})
end)

local function findfrom(name)
	for i,v in pairs(bedwars["QueueMeta"]) do 
		if v.title == name and i:find("voice") == nil then
			return i
		end
	end
	return "bedwars_to1"
end

local QueueTypes = {}
for i,v in pairs(bedwars["QueueMeta"]) do 
	if v.title:find("Test") == nil then
		table.insert(QueueTypes, v.title..(i:find("voice") and " (VOICE)" or "")) 
	end
end
local JoinQueue = {["Enabled"] = false}
local JoinQueueTypes = {["Value"] = ""}
local JoinQueueDelay = {["Value"] = 1}
local firstqueue = true
JoinQueue = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
	["Name"] = "AutoQueue",
	["Function"] = function(callback)
		if callback then
			spawn(function()
				repeat
					task.wait(JoinQueueDelay["Value"])
					firstqueue = false
					if shared.vapeteammembers and bedwars["ClientStoreHandler"]:getState().Party then
						repeat task.wait() until #bedwars["ClientStoreHandler"]:getState().Party.members >= shared.vapeteammembers or JoinQueue["Enabled"] == false
					end
					if JoinQueue["Enabled"] and JoinQueueTypes["Value"] ~= "" then
						if bedwars["ClientStoreHandler"]:getState().Party.queueState > 0 then
							if newupdate then
								bedwars["LobbyClientEvents"].leaveQueue:fire()
							else
								bedwars["ClientHandler"]:Get("LeaveQueue"):CallServer()
							end
						end
						if bedwars["ClientStoreHandler"]:getState().Party.leader.userId == lplr.UserId and (newupdate and bedwars["LobbyClientEvents"].joinQueue:fire({
							queueType = findfrom(JoinQueueTypes["Value"])
						}) or (not newupdate) and bedwars["ClientHandler"]:Get("JoinQueue"):CallServer({
							queueType = findfrom(JoinQueueTypes["Value"])
						})) then
							if JoinQueue["Enabled"] == false and bedwars["ClientStoreHandler"]:getState().Party.queueState > 0 then
								if newupdate then
									bedwars["LobbyClientEvents"].leaveQueue:fire()
								else
									bedwars["ClientHandler"]:Get("LeaveQueue"):CallServer()
								end
							end
						end
						repeat task.wait() until bedwars["ClientStoreHandler"]:getState().Party.queueState == 3 or JoinQueue["Enabled"] == false
						for i = 1, 10 do
							if JoinQueue["Enabled"] == false then
								break
							end
							task.wait(1)
						end
						if bedwars["ClientStoreHandler"]:getState().Party.queueState > 0 then
							if newupdate then
								bedwars["LobbyClientEvents"].leaveQueue:fire()
							else
								bedwars["ClientHandler"]:Get("LeaveQueue"):CallServer()
							end
						end
					end
				until JoinQueue["Enabled"] == false
			end)
		else
			firstqueue = false
			shared.vapeteammembers = nil
			if bedwars["ClientStoreHandler"]:getState().Party.queueState > 0 then
				if newupdate then
					bedwars["LobbyClientEvents"].leaveQueue:fire()
				else
					bedwars["ClientHandler"]:Get("LeaveQueue"):CallServer()
				end
			end
		end
	end
})
JoinQueueTypes = JoinQueue.CreateDropdown({
	["Name"] = "Mode",
	["List"] = QueueTypes,
	["Function"] = function(val) 
		if JoinQueue["Enabled"] and firstqueue == false then
			JoinQueue["ToggleButton"](false)
			JoinQueue["ToggleButton"](true)
		end
	end
})
JoinQueueDelay = JoinQueue.CreateSlider({
	["Name"] = "Delay",
	["Min"] = 1,
	["Max"] = 10,
	["Function"] = function(val) end,
	["Default"] = 1
})

runcode(function()
	local AutoKitTextList = {["ObjectList"] = {}, ["RefreshValues"] = function() end}

	local function betterfindkit()
		local tab = {}
		local tab2 = {}
		if #AutoKitTextList["ObjectList"] > 0 then
			for i,v in pairs(AutoKitTextList["ObjectList"]) do
				local splitstr = v:split(" : ")
				if #splitstr > 1 then
					tab[tonumber(splitstr[2])] = splitstr[1]:lower()
					if #splitstr > 2 then
						tab2[tonumber(splitstr[2])] = splitstr[3]:lower() == "true"
					end
				end
			end
		else
			tab = {
				[1] = "Trinity",
				[2] = "Grim Reaper",
				[3] = "Infernal Shielder",
				[4] = "Eldertree",
				[5] = "Barbarian",
				[6] = "Melody",
				[7] = "Baker"
			}
			tab2 = {}
		end
		return tab, tab2
	end

	local AutoKit = {["Enabled"] = false}
	local ownedkits = {}
	local ownedkitsamount = 0
	for i3,v3 in pairs(bedwars["BedwarsKits"].FreeKits) do
		ownedkitsamount = ownedkitsamount + 1
		ownedkits[bedwars["KitMeta"][v3].name:lower()] = v3
	end
	AutoKit = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "AutoKit",
		["Function"] = function(callback)
			if callback then
				spawn(function()
					repeat task.wait() until ownedkitsamount > 0
					local tab, tab2 = betterfindkit()
					for i = 1, #tab do
						local v = tab[i]
						if ownedkits[v:lower()] then
							bedwars["ClientHandler"]:Get("BedwarsActivateKit"):CallServerAsync({
								kit = ownedkits[v:lower()]
							})
							bedwars["ClientHandler"]:Get("BedwarsSetUseKitSkin"):CallServerAsync({
								useKitSkin = tab2[i] and true or false
							})
							return
						end
					end
					local rand = math.random(1, ownedkitsamount)
					local ownedkitsnum = 0
					for i2,v2 in pairs(ownedkits) do
						ownedkitsnum = ownedkitsnum + 1
						if ownedkitsnum == rand then
							bedwars["ClientHandler"]:Get("BedwarsActivateKit"):CallServerAsync({
								kit = v2
							})
							bedwars["ClientHandler"]:Get("BedwarsSetUseKitSkin"):CallServerAsync({
								useKitSkin = false
							})
						end
					end
				end)
			end
		end,
		["HoverText"] = "Automatically Equips kits in a list."
	})
	AutoKitTextList = AutoKit.CreateTextList({
		["Name"] = "KitList",
		["TempText"] = "kit name : prio : kitskin",
	})
end)

runcode(function()
	local CameraFix = {["Enabled"] = false}
	CameraFix = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
		["Name"] = "CameraFix",
		["Function"] = function(callback)
			if callback then
				spawn(function()
					repeat
						task.wait()
						if (not CameraFix["Enabled"]) then break end
						UserSettings():GetService("UserGameSettings").RotationType = ((cam.CFrame.Position - cam.Focus.Position).Magnitude <= 0.5 and Enum.RotationType.CameraRelative or Enum.RotationType.MovementRelative)
					until (not CameraFix["Enabled"])
				end)
			end
		end,
		["HoverText"] = "Fixes third person camera face bug"
	})
end)

runcode(function()
	local tpstring = shared.vapeoverlay or nil
	local origtpstring = tpstring
	local Overlay = GuiLibrary.CreateCustomWindow({
		["Name"] = "Overlay", 
		["Icon"] = "vape/assets/TargetIcon1.png",
		["IconSize"] = 16
	})
	local overlayframe = Instance.new("Frame")
	overlayframe.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	overlayframe.Size = UDim2.new(0, 200, 0, 120)
	overlayframe.Position = UDim2.new(0, 0, 0, 5)
	overlayframe.Parent = Overlay.GetCustomChildren()
	local overlayframe2 = Instance.new("Frame")
	overlayframe2.Size = UDim2.new(1, 0, 0, 10)
	overlayframe2.Position = UDim2.new(0, 0, 0, -5)
	overlayframe2.Parent = overlayframe
	local overlayframe3 = Instance.new("Frame")
	overlayframe3.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	overlayframe3.Size = UDim2.new(1, 0, 0, 6)
	overlayframe3.Position = UDim2.new(0, 0, 0, 6)
	overlayframe3.BorderSizePixel = 0
	overlayframe3.Parent = overlayframe2
	local oldguiupdate = GuiLibrary["UpdateUI"]
	GuiLibrary["UpdateUI"] = function(...)
		overlayframe2.BackgroundColor3 = Color3.fromHSV(GuiLibrary["Settings"]["GUIObject"]["Color"], 0.7, 0.9)
		return oldguiupdate(...)
	end
	local framecorner1 = Instance.new("UICorner")
	framecorner1.CornerRadius = UDim.new(0, 5)
	framecorner1.Parent = overlayframe
	local framecorner2 = Instance.new("UICorner")
	framecorner2.CornerRadius = UDim.new(0, 5)
	framecorner2.Parent = overlayframe2
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -7, 1, -5)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextYAlignment = Enum.TextYAlignment.Top
	label.Font = Enum.Font.GothamBold
	label.LineHeight = 1.2
	label.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	label.TextSize = 16
	label.Text = ""
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.fromRGB(200, 200, 200)
	label.Position = UDim2.new(0, 7, 0, 5)
	label.Parent = overlayframe
	Overlay["Bypass"] = true
	local oldnetworkowner
	local mapname = "Lobby"
	GuiLibrary["ObjectsThatCanBeSaved"]["GUIWindow"]["Api"].CreateCustomToggle({
		["Name"] = "Overlay", 
		["Icon"] = "vape/assets/TargetIcon1.png", 
		["Function"] = function(callback)
			Overlay.SetVisible(callback) 
			if callback then
				task.spawn(function()
					repeat
						wait(1)
						if not tpstring then
							tpstring = tick().."/0/0/0/0/0/0"
							origtpstring = tpstring
						end
						local splitted = origtpstring:split("/")
						label.Text = "Session Info\nTime Played : "..os.date("!%X",math.floor(tick() - splitted[1])).."\nKills : "..(splitted[2]).."\nBeds : "..(splitted[3]).."\nWins : "..(splitted[4]).."\nGames : "..splitted[5].."\nLagbacks : "..(splitted[6]).."\nReported : "..(splitted[7]).."\nMap : "..mapname
						local textsize = textservice:GetTextSize(label.Text, label.TextSize, label.Font, Vector2.new(100000, 100000))
						overlayframe.Size = UDim2.new(0, math.clamp(textsize.X, 200, 10000), 0, (textsize.Y * 1.2) + 10)
						tpstring = splitted[1].."/"..(splitted[2]).."/"..(splitted[3]).."/"..(splitted[4]).."/"..(splitted[5]).."/"..(splitted[6]).."/"..(splitted[7])
					until (Overlay and Overlay.GetCustomChildren() and Overlay.GetCustomChildren().Parent and Overlay.GetCustomChildren().Parent.Visible == false)
				end)
			end
		end, 
		["Priority"] = 2
	})
end)

spawn(function()
	local url = "https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/CustomModules/bedwarsdata"

	local function createannouncement(announcetab)
		local notifyframereal = Instance.new("TextButton")
		notifyframereal.AnchorPoint = Vector2.new(0.5, 0)
		notifyframereal.BackgroundColor3 = announcetab.Error and Color3.fromRGB(235, 87, 87) or Color3.fromRGB(100, 103, 167)
		notifyframereal.BorderSizePixel = 0
		notifyframereal.AutoButtonColor = false
		notifyframereal.Text = ""
		notifyframereal.Position = UDim2.new(0.5, 0, 0.01, -36)
		notifyframereal.Size = UDim2.new(0.4, 0, 0, 0)
		notifyframereal.Parent = GuiLibrary["MainGui"]
		local notifyframe = Instance.new("Frame")
		notifyframe.BackgroundTransparency = 1
		notifyframe.Size = UDim2.new(1, 0, 1, 0)
		notifyframe.Parent = notifyframereal
		local notifyframecorner = Instance.new("UICorner")
		notifyframecorner.CornerRadius = UDim.new(0, 5)
		notifyframecorner.Parent = notifyframereal
		local notifyframeaspect = Instance.new("UIAspectRatioConstraint")
		notifyframeaspect.AspectRatio = 10
		notifyframeaspect.DominantAxis = Enum.DominantAxis.Height
		notifyframeaspect.Parent = notifyframereal
		local notifyframelist = Instance.new("UIListLayout")
		notifyframelist.SortOrder = Enum.SortOrder.LayoutOrder
		notifyframelist.FillDirection = Enum.FillDirection.Horizontal
		notifyframelist.HorizontalAlignment = Enum.HorizontalAlignment.Left
		notifyframelist.VerticalAlignment = Enum.VerticalAlignment.Center
		notifyframelist.Parent = notifyframe
		local notifyframe2 = Instance.new("Frame")
		notifyframe2.BackgroundTransparency = 1
		notifyframe2.BorderSizePixel = 0
		notifyframe2.LayoutOrder = 1
		notifyframe2.Size = UDim2.new(0.3, 0, 0, 0)
		notifyframe2.SizeConstraint = Enum.SizeConstraint.RelativeYY
		notifyframe2.Parent = notifyframe
		local notifyframesat = Instance.new("ImageLabel")
		notifyframesat.BackgroundTransparency = 1
		notifyframesat.BorderSizePixel = 0
		notifyframesat.Size = UDim2.new(0.7, 0, 0.7, 0)
		notifyframesat.LayoutOrder = 2
		notifyframesat.SizeConstraint = Enum.SizeConstraint.RelativeYY
		notifyframesat.Image = announcetab.Error and "rbxassetid://6768383834" or "rbxassetid://6685538693"
		notifyframesat.Parent = notifyframe
		local notifyframe3 = Instance.new("Frame")
		notifyframe3.BackgroundTransparency = 1
		notifyframe3.BorderSizePixel = 0
		notifyframe3.LayoutOrder = 3
		notifyframe3.Size = UDim2.new(4.1, 0, 0.8, 0)
		notifyframe3.SizeConstraint = Enum.SizeConstraint.RelativeYY
		notifyframe3.Parent = notifyframe
		local notifyframenotifyframelist = Instance.new("UIPadding")
		notifyframenotifyframelist.PaddingBottom = UDim.new(0.08, 0)
		notifyframenotifyframelist.PaddingLeft = UDim.new(0.06, 0)
		notifyframenotifyframelist.PaddingTop = UDim.new(0.08, 0)
		notifyframenotifyframelist.Parent = notifyframe3
		local notifyframeaspectnotifyframeaspect = Instance.new("UIListLayout")
		notifyframeaspectnotifyframeaspect.Parent = notifyframe3
		notifyframeaspectnotifyframeaspect.VerticalAlignment = Enum.VerticalAlignment.Center
		local notifyframelistnotifyframeaspect = Instance.new("TextLabel")
		notifyframelistnotifyframeaspect.BackgroundTransparency = 1
		notifyframelistnotifyframeaspect.BorderSizePixel = 0
		notifyframelistnotifyframeaspect.Size = UDim2.new(1, 0, 0.6, 0)
		notifyframelistnotifyframeaspect.Font = Enum.Font.Roboto
		notifyframelistnotifyframeaspect.Text = "Vape Announcement"
		notifyframelistnotifyframeaspect.TextColor3 = Color3.fromRGB(255, 255, 255)
		notifyframelistnotifyframeaspect.TextScaled = true
		notifyframelistnotifyframeaspect.TextWrapped = true
		notifyframelistnotifyframeaspect.TextXAlignment = Enum.TextXAlignment.Left
		notifyframelistnotifyframeaspect.Parent = notifyframe3
		local notifyframe2notifyframeaspect = Instance.new("TextLabel")
		notifyframe2notifyframeaspect.BackgroundTransparency = 1
		notifyframe2notifyframeaspect.BorderSizePixel = 0
		notifyframe2notifyframeaspect.Size = UDim2.new(1, 0, 0.4, 0)
		notifyframe2notifyframeaspect.Font = Enum.Font.Roboto
		notifyframe2notifyframeaspect.Text = "<b>"..announcetab.Text.."</b>"
		notifyframe2notifyframeaspect.TextColor3 = Color3.fromRGB(255, 255, 255)
		notifyframe2notifyframeaspect.TextScaled = true
		notifyframe2notifyframeaspect.TextWrapped = true
		notifyframe2notifyframeaspect.RichText = true
		notifyframe2notifyframeaspect.TextXAlignment = Enum.TextXAlignment.Left
		notifyframe2notifyframeaspect.Parent = notifyframe3
		local notifyprogress = Instance.new("Frame")
		notifyprogress.Parent = notifyframereal
		notifyprogress.BorderSizePixel = 0
		notifyprogress.BackgroundColor3 = Color3.new(1, 1, 1)
		notifyprogress.Position = UDim2.new(0, 0, 1, -3)
		notifyprogress.Size = UDim2.new(1, 0, 0, 3)
		local notifyprogresscorner = Instance.new("UICorner")
		notifyprogresscorner.CornerRadius = UDim.new(0, 100)
		notifyprogresscorner.Parent = notifyprogress
		game:GetService("TweenService"):Create(notifyframereal, TweenInfo.new(0.12), {Size = UDim2.fromScale(0.4, 0.065)}):Play()
		game:GetService("TweenService"):Create(notifyprogress, TweenInfo.new(announcetab.Time or 20, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 0, 3)}):Play()
		local sound = Instance.new("Sound")
		sound.PlayOnRemove = true
		sound.SoundId = "rbxassetid://6732495464"
		sound.Parent = workspace
		sound:Remove()
		notifyframereal.MouseButton1Click:connect(function()
			local sound = Instance.new("Sound")
			sound.PlayOnRemove = true
			sound.SoundId = "rbxassetid://6732690176"
			sound.Parent = workspace
			sound:Remove()
			notifyframereal:Remove()
			notifyframereal = nil
		end)
		task.wait(announcetab.Time or 20)
		if notifyframereal then
			notifyframereal:Remove()
		end
	end

	local function rundata(datatab, olddatatab)
		if not olddatatab then
			if datatab.Disabled then 
				coroutine.resume(coroutine.create(function()
					repeat task.wait() until shared.VapeFullyLoaded
					task.wait(1)
					GuiLibrary.SelfDestruct()
				end))
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Vape",
					Text = "Vape is currently disabled, check the discord for updates discord.gg/vxpe",
					Duration = 30,
				})
			end
			if datatab.KickUsers and datatab.KickUsers[tostring(lplr.UserId)] then
				lplr:Kick(datatab.KickUsers[tostring(lplr.UserId)])
			end
		else
			local newdatatab = {}
			for i,v in pairs(datatab) do 
				if not olddatatab or olddatatab[i] ~= v then 
					newdatatab[i] = v
				end
			end
			if newdatatab.Disabled then 
				coroutine.resume(coroutine.create(function()
					repeat task.wait() until shared.VapeFullyLoaded
					task.wait(1)
					GuiLibrary.SelfDestruct()
				end))
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Vape",
					Text = "Vape is currently disabled, check the discord for updates discord.gg/vxpe",
					Duration = 30,
				})
			end
			if datatab.KickUsers and datatab.KickUsers[tostring(lplr.UserId)] then
				lplr:Kick(datatab.KickUsers[tostring(lplr.UserId)])
			end
			if newdatatab.Announcement and newdatatab.Announcement.ExpireTime >= os.time() then 
				spawn(function()
					createannouncement(newdatatab.Announcement)
				end)
			end
		end
	end

	pcall(function()
		if betterisfile("vape/Profiles/bedwarsdata.txt") == false then 
			writefile("vape/Profiles/bedwarsdata.txt", game:HttpGet(url, true))
		end
		local olddata = readfile("vape/Profiles/bedwarsdata.txt")
		local newdata = game:HttpGet(url, true)
		if newdata ~= olddata then 
			rundata(game:GetService("HttpService"):JSONDecode(newdata), game:GetService("HttpService"):JSONDecode(olddata))
			olddata = newdata
			writefile("vape/Profiles/bedwarsdata.txt", newdata)
		else
			rundata(game:GetService("HttpService"):JSONDecode(olddata))
		end
		repeat
			task.wait(60)
			newdata = game:HttpGet(url, true)
			if newdata ~= olddata then 
				rundata(game:GetService("HttpService"):JSONDecode(newdata), game:GetService("HttpService"):JSONDecode(olddata))
				olddata = newdata
				writefile("vape/Profiles/bedwarsdata.txt", newdata)
			end
		until uninjectflag
	end)
end)

if shared.nobolineupdate then
	spawn(function()
		repeat
			task.wait()
			if GuiLibrary["MainGui"].Parent ~= nil then
				GuiLibrary["MainGui"].ScaledGui.Visible = false
				GuiLibrary["MainGui"].ScaledGui.ClickGui.Visible = false
				GuiLibrary["MainBlur"].Enabled = false
			else
				break
			end
		until true == false
	end)
	runcode(function()
		local function removeTags(str)
			str = str:gsub("<br%s*/>", "\n")
			str = str:gsub("Vape", "Noboline")
			str = str:gsub("vape", "noboline")
			return (str:gsub("<[^<>]->", ""))
		end
		GuiLibrary["CreateNotification"] = function(top, bottom, duration, customicon)
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "Noboline",
				Text = removeTags(bottom),
				Duration = duration,
			})
		end
	end)
	spawn(function()
		local function isblatant()
			return GuiLibrary["ObjectsThatCanBeSaved"]["SpeedOptionsButton"]["Api"]["Enabled"] or GuiLibrary["ObjectsThatCanBeSaved"]["SpeedOptionsButton"]["Api"]["Keybind"] ~= ""
		end
		task.wait(2)
		local ImageLabel = Instance.new("ImageLabel")
		ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ImageLabel.BackgroundTransparency = 1.000
		ImageLabel.BorderSizePixel = 0
		ImageLabel.Position = UDim2.new(0.5, -120, 0.5, -120)
		ImageLabel.Size = UDim2.new(0, 240, 0, 240)
		ImageLabel.ImageTransparency = 1
		ImageLabel.Image = "http://www.roblox.com/asset/?id=7211055081"
		ImageLabel.Parent = GuiLibrary["MainGui"]
		ImageLabel.Visible = isblatant()
		local TextMessage = Instance.new("TextLabel")
		TextMessage.TextSize = 24
		TextMessage.Font = Enum.Font.SourceSans
		TextMessage.TextStrokeTransparency = 0
		TextMessage.Text = ""
		TextMessage.TextColor3 = Color3.new(1, 1, 1)
		TextMessage.Position = UDim2.new(0.5, 0, 1, 20)
		TextMessage.TextStrokeColor3 = Color3.fromRGB(0,0,0)
		TextMessage.Parent = ImageLabel
		TextMessage.Visible = isblatant()
		for i = 1, 0, -0.1 do 
			wait(0.05)
			ImageLabel.ImageTransparency = i
		end
		task.wait(0.2)
		TextMessage.Text = "Loading dependencies..."
		task.wait(1)
		TextMessage.Text = "Loading tables..."
		task.wait(3)
		TextMessage:Remove()
		ImageLabel:Remove()
		local kavo = loadstring(GetURL("Libraries/kavo.lua"))()
		local window = kavo.CreateLib("Noboline v1.6.2"..(shared.VapePrivate and " - PRIVATE" or ""), "Ocean")
		local realgui = game:GetService("CoreGui")[debug.getupvalue(kavo.ToggleUI, 1)]
		if not is_sirhurt_closure and syn and syn.protect_gui then
			syn.protect_gui(realgui)
		elseif gethui then
			realgui.Parent = gethui()
		end
		fakeuiconnection = uis.InputBegan:connect(function(input1)
			if uis:GetFocusedTextBox() == nil then
				if input1.KeyCode == Enum.KeyCode[GuiLibrary["GUIKeybind"]] and GuiLibrary["KeybindCaptured"] == false then
					realgui.Enabled = not realgui.Enabled
					uis.OverrideMouseIconBehavior = (realgui.Enabled and Enum.OverrideMouseIconBehavior.ForceShow or game:GetService("VRService").VREnabled and Enum.OverrideMouseIconBehavior.ForceHide or Enum.OverrideMouseIconBehavior.None)
				end
			end
		end)
		realgui.Enabled = isblatant()
		game.CoreGui.ChildRemoved:connect(function(obj)
			if obj == realgui then
				GuiLibrary["SelfDestruct"]()
			end
		end)
		local windowtabs = {
			Combat = window:NewTab("Combat"),
			Blatant = window:NewTab("Blatant"),
			Render = window:NewTab("Render"),
			Utility = window:NewTab("Utility"),
			World = window:NewTab("World")
		}
		local windowsections = {}
		local tab = {}
		local tab2 = {}
		for i,v in pairs(GuiLibrary["ObjectsThatCanBeSaved"]) do 
			if v.Type == "OptionsButton" then
				table.insert(tab, v)
			end
			if v.Type == "Toggle" then
				table.insert(tab2, v)
			end
			if v.Type == "Slider" then
				table.insert(tab2, v)
			end
			if v.Type == "Dropdown" then
				table.insert(tab2, v)
			end
			if v.Type == "ColorSlider" then
				table.insert(tab2, v)
			end
		end
		table.sort(tab, function(a, b) 
			if a.Type ~= "OptionsButton" then
				a = {Object = {Name = tostring(a["Object"].Parent):gsub("Children", "")..a["Object"].Name}}
			else
				a = {Object = {Name = a["Object"].Name}}
			end
			if b.Type ~= "OptionsButton" then
				b = {Object = {Name = tostring(b["Object"].Parent):gsub("Children", "")..b["Object"].Name}}
			else
				b = {Object = {Name = b["Object"].Name}}
			end
			return a["Object"].Name:lower() < b["Object"].Name:lower() 
		end)
		table.sort(tab2, function(a, b) 
			a = {Object = {Name = tostring(a["Object"].Parent):gsub("Children", "")..a["Object"].Name}}
			b = {Object = {Name = tostring(b["Object"].Parent):gsub("Children", "")..b["Object"].Name}}
			return a["Object"].Name:lower() < b["Object"].Name:lower() 
		end)
		for i,v in pairs(tab) do 
			if v.Type == "OptionsButton" then 
				local old = v["Api"]["ToggleButton"]
				local newstr = tostring(v["Object"]):gsub("Button", "")
				windowsections[newstr] = windowtabs[tostring(v["Object"].Parent.Parent)]:NewSection(newstr)
				local tog = windowsections[newstr]:NewToggle(newstr, "", function(callback)
					if callback ~= v["Api"]["Enabled"] then
						old(true)
					end
				end)
				local keybind = windowsections[newstr]:NewKeybind("Keybind", "", {Name = v["Api"]["Keybind"] ~= "" and v["Api"]["Keybind"] or "None"}, function(key)
					GuiLibrary["KeybindCaptured"] = true
					v["Api"]["SetKeybind"](key == "None" and "" or key)
					task.delay(0.1, function() GuiLibrary["KeybindCaptured"] = false end)
				end)
				v["Api"]["ToggleButton"] = function(clicked, toggle)
					local res = old(clicked, toggle)
					tog:UpdateToggle(tostring(v["Object"]):gsub("Button", ""), v["Api"]["Enabled"])
					return res
				end
				tog:UpdateToggle(tostring(v["Object"]):gsub("Button", ""), v["Api"]["Enabled"])
			end
		end
		for i,v in pairs(tab2) do 
			if v.Type == "Toggle" and tostring(v["Object"].Parent.Parent.Parent) ~= "ClickGui" and GuiLibrary["ObjectsThatCanBeSaved"][tostring(v["Object"].Parent):gsub("Children", "OptionsButton")] and GuiLibrary["ObjectsThatCanBeSaved"][tostring(v["Object"].Parent):gsub("Children", "OptionsButton")]["ChildrenObject"] == v["Object"].Parent then
				local newstr = tostring(v["Object"].Parent):gsub("Children", "")
				local old = v["Api"]["ToggleButton"]
				local tog = windowsections[newstr]:NewToggle(tostring(v["Object"]):gsub("Button", ""), "", function(callback)
					if callback ~= v["Api"]["Enabled"] then
						old(true)
					end
				end)
				v["Api"]["ToggleButton"] = function(clicked, toggle)
					local res = old(clicked, toggle)
					tog:UpdateToggle(tostring(v["Object"]):gsub("Button", ""), v["Api"]["Enabled"])
					return res
				end
				tog:UpdateToggle(tostring(v["Object"]):gsub("Button", ""), v["Api"]["Enabled"])
			end
			if v.Type == "Slider" and GuiLibrary["ObjectsThatCanBeSaved"][tostring(v["Object"].Parent):gsub("Children", "OptionsButton")] and GuiLibrary["ObjectsThatCanBeSaved"][tostring(v["Object"].Parent):gsub("Children", "OptionsButton")]["ChildrenObject"] == v["Object"].Parent then
				local newstr = tostring(v["Object"].Parent):gsub("Children", "")
				local old = v["Api"]["SetValue"]
				local slider = windowsections[newstr]:NewSlider(v["Object"].Name, "", v["Api"]["Max"], v["Api"]["Min"], function(s) -- 500 (MaxValue) | 0 (MinValue)
					if s ~= v["Api"]["Value"] then
						old(s)
					end
				end)
				v["Api"]["SetValue"] = function(value, ...)
					local res = old(value, ...)
					slider:UpdateSlider(value)
					return res
				end
				v["Api"]["SetValue"](tonumber(v["Api"]["Value"]))
			end
			if v.Type == "ColorSlider" and GuiLibrary["ObjectsThatCanBeSaved"][tostring(v["Object"].Parent):gsub("Children", "OptionsButton")] and GuiLibrary["ObjectsThatCanBeSaved"][tostring(v["Object"].Parent):gsub("Children", "OptionsButton")]["ChildrenObject"] == v["Object"].Parent then
				local newstr = tostring(v["Object"].Parent):gsub("Children", "")
				local old = v["Api"]["SetValue"]
				v["Api"]["RainbowValue"] = false
				local slider = windowsections[newstr]:NewColorPicker(v["Object"].Name, "", Color3.fromHSV(v["Api"]["Hue"], v["Api"]["Sat"], v["Api"]["Value"]), function(col) -- 500 (MaxValue) | 0 (MinValue)
					old(col:ToHSV())
				end)
				--v["Api"]["SetValue"](v["Api"]["Hue"], v["Api"]["Sat"], v["Api"]["Value"])
			end
			if v.Type == "Dropdown" and GuiLibrary["ObjectsThatCanBeSaved"][tostring(v["Object"].Parent):gsub("Children", "OptionsButton")] and GuiLibrary["ObjectsThatCanBeSaved"][tostring(v["Object"].Parent):gsub("Children", "OptionsButton")]["ChildrenObject"] == v["Object"].Parent then
				local newstr = tostring(v["Object"].Parent):gsub("Children", "")
				local old = v["Api"]["SetValue"]
				local dropdown = windowsections[newstr]:NewDropdown(v["Object"].Name, "", debug.getupvalue(v["Api"]["SetValue"], 4)["List"], function(currentOption)
					if currentOption ~= v["Api"]["Value"] then
						v["Api"]["SetValue"](currentOption)
					end
				end)
				dropdown:SetValue(v["Api"]["Value"])
				--v["Api"]["SetValue"](v["Api"]["Hue"], v["Api"]["Sat"], v["Api"]["Value"])
			end
		end
		--windowsections.Combat:NewToggle("a", "", function(callback)
	--		print(callback, "yes")
		--end)
	end)
end
