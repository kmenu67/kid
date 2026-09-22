local RF=loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local P=game:GetService("Players").LocalPlayer
local R=game:GetService("RunService")
local RS=game:GetService("ReplicatedStorage")

local AL=true
local rE=RS:WaitForChild("rEvents",10)
local mR=rE and rE:FindFirstChild("machineInteractRemote")
local mE=P:FindFirstChild("muscleEvent") or P:WaitForChild("muscleEvent",5)
local rbR=rE and rE:FindFirstChild("rebirthRemote")

local S={ex=nil,cps=12,lock=false,atp=false,rb=false,cap=0,fr=false,fm=8,boss=false,bd=1,btp=true,af=false,gym=false,gymSel=nil,gfr=true,gfm=8,noTP=false}
local cm,lc,sc=nil,nil,nil
local mC,gC,bC={},{},{}
local lbS=0

local function refM()
 mC={}
 local mf=workspace:FindFirstChild("machinesFolder")
 if mf then for _,m in ipairs(mf:GetChildren())do local s=m:FindFirstChild("interactSeat") if s and s:IsA("BasePart")then table.insert(mC,{m=m,s=s})end end end
 for _,m in ipairs(workspace:GetDescendants())do
  if m:IsA("Model")then
   local s=m:FindFirstChild("interactSeat")
   if s and s:IsA("BasePart")then
    local d=false
    for _,e in ipairs(mC)do if e.m==m then d=true break end end
    if not d then table.insert(mC,{m=m,s=s})end
   end
  end
 end
end
refM()
task.spawn(function()while AL do task.wait(20) refM() end end)

local function cl()
 local c=P.Character if not c then return end
 local h=c:FindFirstChild("HumanoidRootPart") if not h then return end
 local b,d=nil,math.huge
 for _,e in ipairs(mC)do if e.s.Parent then local x=(h.Position-e.s.Position).Magnitude if x<d then b=e.m d=x end end end
 return b
end
local function sit(m) if not mR or not m then return end local s=m:FindFirstChild("interactSeat") if not s then return end pcall(function() mR:InvokeServer("useMachine",s) end) cm=m end
local function st()
 if mR then pcall(function() mR:InvokeServer("leaveMachine") end) end
 cm=nil
 local c=P.Character
 if c then local h=c:FindFirstChildOfClass("Humanoid") if h and h.Sit then pcall(function() h.Sit=false h.Jump=true end) end end
 task.wait(0.3)
end

local KW={weight="weight",pushup="pushup",situp="situp",handstand="handstand"}
local function fE(k) local c=P.Character if not c then return end for _,t in ipairs(c:GetChildren())do if t:IsA("Tool")and string.lower(t.Name):find(k)then return t end end end
local function equip(k)
 local c=P.Character if not c then return end
 local h=c:FindFirstChildOfClass("Humanoid") if not h or h.Sit or h.Health<=0 then return end
 local e=fE(k) if e then return e end
 local bp=P:FindFirstChild("Backpack") if not bp then return end
 for _,t in ipairs(bp:GetChildren())do if t:IsA("Tool")and string.lower(t.Name):find(k)then pcall(function() h:EquipTool(t) end) task.wait(.1) return fE(k)or t end end
end
local le=0
local function act(k)
 local c=P.Character if not c then return end
 local h=c:FindFirstChildOfClass("Humanoid") if not h or h.Health<=0 or h.Sit then return end
 local t=fE(k) if t then pcall(function() t:Activate() end) return end
 if tick()-le>0.5 then le=tick() local e=equip(k) if e then pcall(function() e:Activate() end) end end
end

local function gv(names)
 local ls=P:FindFirstChild("leaderstats")
 if ls then for _,v in ipairs(ls:GetChildren())do local n=string.lower(v.Name) for _,k in ipairs(names)do if n:find(k)and(v:IsA("IntValue")or v:IsA("NumberValue"))then return v.Value end end end end
 for k,v in pairs(P:GetAttributes())do local n=string.lower(k) for _,kw in ipairs(names)do if n:find(kw)and type(v)=="number"then return v end end end
end
local function gRB() return gv({"rebirth"}) end
local function gST() return gv({"strength","str"}) end
local function rq(r) return 5000*r+10000 end
local function gm()
 local uf=P:FindFirstChild("ultimatesFolder")
 local gR=uf and uf:FindFirstChild("Golden Rebirth")
 if gR and type(gR.Value)=="number" and gR.Value>0 then return 1-(gR.Value*0.1) end
 return 1
end

local function refB()
 if tick()-lbS<3 then return end
 lbS=tick()
 bC={}
 local function scan(p) for _,m in ipairs(p:GetChildren())do if m:IsA("Model")then local n=string.lower(m.Name) if n:find("boss")or n:find("enemy")or n:find("titan")then local h=m:FindFirstChildOfClass("Humanoid") local hr=m:FindFirstChild("HumanoidRootPart") if h and hr then table.insert(bC,{m=m,h=h,hr=hr})end end end end end
 scan(workspace)
 for _,f in ipairs(workspace:GetChildren())do if f:IsA("Folder")or f:IsA("Model")then scan(f) end end
end
local function atkB()
 local c=P.Character if not c then return end
 local hr=c:FindFirstChild("HumanoidRootPart") if not hr then return end
 local hu=c:FindFirstChildOfClass("Humanoid") if not hu or hu.Health<=0 or hu.Sit then return end
 refB() if #bC==0 then return end
 local t,d=nil,math.huge
 for _,b in ipairs(bC)do if b.h.Health>0 and b.hr.Parent then local x=(hr.Position-b.hr.Position).Magnitude if x<d then t=b d=x end end end
 if not t then return end
 if S.btp and d>5 then pcall(function() hr.CFrame=CFrame.new(t.hr.Position+Vector3.new(0,0,3),t.hr.Position) end) end
 if mE then pcall(function() mE:FireServer("punch","leftHand") mE:FireServer("punch","rightHand") end) end
end

local MK={
 ["Industrial Rock"]={"industrial rock","industrialrock","durability"},
 ["Bench Press"]={"bench press","benchpress","bench"},
 ["Squat Rack"]={"squat rack","squatrack","squat"},
 ["Deadlift"]={"deadlift"},
 ["Treadmill"]={"treadmill"},
 ["Heavy Bag"]={"punching bag","punchingbag","heavy bag","heavybag","punching"},
}
local function classify(n)
 local s=string.lower(n)
 local best,bl=nil,0
 for l,kws in pairs(MK)do for _,kw in ipairs(kws)do if s:find(kw)and #kw>bl then best=l bl=#kw end end end
 return best
end

local indDD
local function refI()
 gC={}
 local c=P.Character if not c then return end
 local hrp=c:FindFirstChild("HumanoidRootPart") if not hrp then return end
 local myPos=hrp.Position
 local seen={}
 for _,m in ipairs(workspace:GetDescendants())do
  if m:IsA("Model")then
   local s=m:FindFirstChild("interactSeat")
   if s and s:IsA("BasePart")then
    local d=(s.Position-myPos).Magnitude
    if d<1000 and not seen[m]then
     seen[m]=true
     local lb=classify(m.Name)
     table.insert(gC,{m=m,s=s,d=d,label=lb or m.Name})
    end
   end
  end
 end
 table.sort(gC,function(a,b)return a.d<b.d end)
 local cnt={}
 for _,e in ipairs(gC)do
  cnt[e.label]=(cnt[e.label] or 0)+1
  e.uid=e.label.." "..cnt[e.label]
 end
 if indDD then
  local opts={}
  for _,e in ipairs(gC)do table.insert(opts,e.uid) end
  if #opts==0 then opts={"Không tìm thấy máy"} end
  pcall(function() indDD:Refresh(opts,true) end)
 end
end
local function findIT()
 if not S.gymSel then return gC[1] end
 for _,e in ipairs(gC)do if e.s.Parent and e.uid==S.gymSel then return e end end
 for _,e in ipairs(gC)do if e.s.Parent and e.label==S.gymSel then return e end end
end

local function fr()
 local e=S.ex
 if not e or S.fr then return end
 if e=="machine" then
  if not cm or not cm.Parent then local m=cl() if m then sit(m) end end
  if mE then pcall(function() mE:FireServer("rep") end) end
 else
  local k=KW[e]
  if k then act(k) end
 end
end

local lf=0
R.RenderStepped:Connect(function()
 if not AL then return end
 local now=tick()
 if now-lf<0.033 then return end
 lf=now
 local c=P.Character if not c then return end
 local h=c:FindFirstChildOfClass("Humanoid")
 if not h or h.Health<=0 or h.Sit then return end
 local an=h:FindFirstChildOfClass("Animator")
 if an then for _,t in ipairs(an:GetPlayingAnimationTracks())do pcall(function() t:AdjustSpeed(S.fm*3) end) end end
 if S.fr and S.ex and S.ex~="machine" then
  local k=KW[S.ex]
  if k then local t=fE(k) if t then for i=1,S.fm do pcall(function() t:Activate() end) end end end
 end
 if S.gfr and S.gym and cm and mE then for i=1,S.gfm do pcall(function() mE:FireServer("rep") end) end end
end)

local ba=0
R.Heartbeat:Connect(function(dt)
 if not AL then return end
 if S.boss then ba=ba+dt if ba>=S.bd then ba=0 pcall(atkB) end end
 if S.af then local c=P.Character if c then local hr=c:FindFirstChild("HumanoidRootPart") if hr and hr.AssemblyLinearVelocity.Magnitude>200 then hr.AssemblyLinearVelocity=Vector3.zero end end end
 if not S.lock then lc=nil
 else
  local c=P.Character
  if not c then lc=nil
  else
   local h=c:FindFirstChild("HumanoidRootPart") local u=c:FindFirstChildOfClass("Humanoid")
   if not h or not u or u.Sit then lc=nil
   elseif not lc then lc=h.CFrame
   elseif(h.Position-lc.Position).Magnitude>1 then h.CFrame=lc h.Velocity=Vector3.zero end
  end
 end
end)

P.CharacterAdded:Connect(function(ch)
 cm=nil
 if not S.atp or not sc then return end
 local t=sc
 task.spawn(function()
  local e=tick()+3
  while AL and tick()<e do
   task.wait(.1)
   if not S.atp then break end
   local h=ch:FindFirstChild("HumanoidRootPart")
   if h then pcall(function() h.CFrame=t h.Velocity=Vector3.zero end) end
  end
 end)
end)

P.CharacterAdded:Connect(function(ch)
 if not S.gym or not S.gymSel then return end
 task.spawn(function()
  task.wait(2.5)
  if not AL then return end
  local c=P.Character
  if not c or c~=ch then return end
  local hrp=c:FindFirstChild("HumanoidRootPart") local hum=c:FindFirstChildOfClass("Humanoid")
  if not hrp or not hum then return end
  while AL and hum.Health<=0 do task.wait(.2) end
  refI()
  local t=findIT()
  if t and t.s.Parent then
   pcall(function() hrp.CFrame=CFrame.new(t.s.Position+Vector3.new(0,5,0)) end)
   task.wait(.5)
   sit(t.m)
   RF:Notify({Title="Respawn",Content="Đã quay lại: "..t.uid,Duration=5})
  end
 end)
end)

local rbT
task.spawn(function()
 while AL do
  task.wait(0.3)
  if S.rb and rbR then
   local rb=gRB() local st2=gST()
   if rb~=nil and st2~=nil then
    local nd=rq(rb)*gm()
    if S.cap>0 and rb>=S.cap then S.rb=false if rbT and rbT.Set then pcall(function() rbT:Set(false) end) end
    elseif st2>=nd then
     for i=1,5 do
      if not S.rb then break end
      if S.atp then local c=P.Character if c then local h=c:FindFirstChild("HumanoidRootPart") if h then sc=h.CFrame end end end
      pcall(function() rbR:InvokeServer("rebirthRequest") end)
      task.wait(.3)
      local nr=gRB()
      if nr and nr>rb then break end
     end
     task.wait(1)
    end
   else
    if S.atp then local c=P.Character if c then local h=c:FindFirstChild("HumanoidRootPart") if h then sc=h.CFrame end end end
    pcall(function() rbR:InvokeServer("rebirthRequest") end)
    task.wait(3)
   end
  end
 end
end)

task.spawn(function()
 task.wait(3)
 while AL do
  task.wait(1)
  if S.gym then
   local c=P.Character
   if c then
    local hrp=c:FindFirstChild("HumanoidRootPart") local hum=c:FindFirstChildOfClass("Humanoid")
    if hrp and hum and hum.Health>0 then
     local t=findIT()
     if t and t.s.Parent then
      local d=(hrp.Position-t.s.Position).Magnitude
      if cm~=t.m then
       if hum.Sit then st() task.wait(.3) end
       if d>100 and not S.noTP then pcall(function() hrp.CFrame=CFrame.new(t.s.Position+Vector3.new(0,5,0)) end) task.wait(.5) end
       if d<=100 or not S.noTP then sit(t.m) end
      end
     end
    end
   end
  end
 end
end)

local a,iv=0,1/S.cps
R.Heartbeat:Connect(function(dt)
 if not AL or not S.ex or S.fr then a=0 return end
 local c=P.Character
 if not c or not c:FindFirstChild("Humanoid")or c.Humanoid.Health<=0 then a=0 return end
 a=a+dt
 if a>=iv then a=0 fr() iv=(1/S.cps)*(0.8+math.random()*0.5) end
end)

local W=RF:CreateWindow({Name="KhangZLoz",LoadingTitle="Đang tải...",LoadingSubtitle="ML",ConfigurationSaving={Enabled=false},KeySystem=false})

local T1=W:CreateTab("Tập")
local tgs={}
local function sel(n) return function(v)
 if v then
  if S.ex=="machine" and n~="machine" then st() end
  S.ex=n
  if n=="machine" then local m=cl() if m then sit(m) end
  else local k=KW[n] if k then task.spawn(function() equip(k) end) end end
  for k,t in pairs(tgs)do if k~=n and t.Set then pcall(function() t:Set(false) end) end end
 else
  if S.ex==n then S.ex=nil if n=="machine" then st() end end
 end
end end
local function ad(n,l) tgs[n]=T1:CreateToggle({Name=l,CurrentValue=false,Flag="E"..n,Callback=sel(n)}) end
ad("machine","Máy tập") ad("weight","Weight") ad("pushup","Pushups") ad("situp","Situps") ad("handstand","Handstands")
T1:CreateToggle({Name="⚡ Fast Rep",CurrentValue=false,Flag="FR",Callback=function(v) S.fr=v end})
T1:CreateSlider({Name="Multi",Range={1,15},Increment=1,Suffix="x",CurrentValue=8,Flag="FM",Callback=function(v) S.fm=v end})
T1:CreateButton({Name="🗑 Destroy",Callback=function() AL=false if cm then pcall(st) end RF:Destroy() end})

local T2=W:CreateTab("Industrial")
T2:CreateParagraph({Title="Industrial Gym",Content="Đứng trong gym → Scan → chọn máy (Bench 1, 2...) → bật Auto."})
indDD=T2:CreateDropdown({Name="Máy/Rock",Options={"Đang scan..."},CurrentOption="",Flag="IndSel",Callback=function(o) S.gymSel=o end})
T2:CreateToggle({Name="⚡ Auto Industrial",CurrentValue=false,Flag="G",Callback=function(v) S.gym=v if v then refI() RF:Notify({Title="Auto",Content="Tìm thấy "..#gC.." máy",Duration=5}) else st() end end})
T2:CreateToggle({Name="Không tự TP",CurrentValue=false,Flag="NTP",Callback=function(v) S.noTP=v end})
T2:CreateToggle({Name="⚡ Fast Rep",CurrentValue=true,Flag="GFR",Callback=function(v) S.gfr=v end})
T2:CreateSlider({Name="Multi",Range={1,15},Increment=1,Suffix="x",CurrentValue=8,Flag="GFM",Callback=function(v) S.gfm=v end})
T2:CreateButton({Name="🔍 Scan Industrial",Callback=function()
 refI()
 if #gC==0 then RF:Notify({Title="Scan",Content="Không tìm thấy máy",Duration=8}) return end
 RF:Notify({Title="Scan OK",Content=#gC.." máy",Duration=8})
 for i=1,math.min(#gC,6)do local e=gC[i] RF:Notify({Title="Máy "..i,Content=e.uid.." | "..math.floor(e.d).."m",Duration=12}) end
end})

local T3=W:CreateTab("Boss")
T3:CreateToggle({Name="🗡 Auto Boss",CurrentValue=false,Flag="AB",Callback=function(v) S.boss=v end})
T3:CreateToggle({Name="Teleport",CurrentValue=true,Flag="BT",Callback=function(v) S.btp=v end})
T3:CreateSlider({Name="Delay",Range={0.5,3},Increment=0.1,Suffix="s",CurrentValue=1,Flag="BD",Callback=function(v) S.bd=v end})
T3:CreateButton({Name="🔍 Scan Boss",Callback=function()
 lbS=0 refB()
 if #bC==0 then RF:Notify({Title="Boss",Content="Không tìm thấy",Duration=8})
 else RF:Notify({Title="Boss",Content=#bC.." boss",Duration=8}) for i=1,math.min(#bC,3)do RF:Notify({Title="Boss "..i,Content=bC[i].m.Name.." HP:"..math.floor(bC[i].h.Health),Duration=10}) end end
end})

local T4=W:CreateTab("Farm")
T4:CreateToggle({Name="🛡 Anti Fling",CurrentValue=false,Flag="AF",Callback=function(v) S.af=v end})

local T5=W:CreateTab("Rebirth")
T5:CreateButton({Name="📊 Check Rebirth",Callback=function()
 local rb=gRB() local st2=gST()
 if rb~=nil and st2~=nil then
  local nd=rq(rb)*gm()
  RF:Notify({Title="Rebirth",Content="RB:"..rb.." STR:"..st2.." Cần:"..math.floor(nd).." "..(st2>=nd and "ĐỦ" or "THIẾU"),Duration=15})
 else RF:Notify({Title="Lỗi",Content="Không đọc được stats",Duration=8}) end
end})
rbT=T5:CreateToggle({Name="🔄 Auto Rebirth",CurrentValue=false,Flag="RB",Callback=function(v) S.rb=v end})
T5:CreateInput({Name="Cap (0=∞)",CurrentValue="0",RemoveTextAfterFocusLost=false,Flag="RC",Callback=function(v) S.cap=tonumber(v) or 0 end})

local T6=W:CreateTab("Bảo vệ")
T6:CreateToggle({Name="🔒 Lock Pos",CurrentValue=false,Flag="LP",Callback=function(v) S.lock=v lc=nil end})
T6:CreateToggle({Name="🛡 Anti TP",CurrentValue=false,Flag="ATP",Callback=function(v) S.atp=v sc=nil end})

local T7=W:CreateTab("Set")
T7:CreateSlider({Name="CPS",Range={5,40},Increment=1,CurrentValue=12,Flag="CPS",Callback=function(v) S.cps=v iv=1/v end})
T7:CreateInput({Name="Tên player",CurrentValue="",PlaceholderText="VD: Rozo_X",RemoveTextAfterFocusLost=false,Flag="TPN",Callback=function(v) _G.TPN=v end})
T7:CreateButton({Name="🚀 Teleport tới player",Callback=function()
 if not _G.TPN or _G.TPN=="" then return end
 local t=game:GetService("Players"):FindFirstChild(_G.TPN)
 if t and t.Character then
  local th=t.Character:FindFirstChild("HumanoidRootPart")
  local c=P.Character local h=c and c:FindFirstChild("HumanoidRootPart")
  if th and h then h.CFrame=th.CFrame RF:Notify({Title="TP",Content="Đã tới ".._G.TPN,Duration=5}) end
 else RF:Notify({Title="Lỗi",Content="Không tìm thấy player",Duration=5}) end
end})
T7:CreateButton({Name="🗑 Destroy",Callback=function() AL=false if cm then pcall(st) end RF:Destroy() end})

task.wait(2)
refI()
RF:Notify({Title="KhangZLoz",Content="Script đã tải xong!",Duration=5})
print("[KhangZLoz] Ready")
