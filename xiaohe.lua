-- ============================================================
-- 小贺脚本 V11 · 全功能优化版【可直接执行】
-- QQ交流群：1104880878
-- ============================================================

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local Debris = game:GetService("Debris")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ============================================================
-- 全局安全包装：任何功能出错不崩溃整个脚本
-- ============================================================
local function safe(fn, errName)
    return function(...)
        local ok, err = pcall(fn, ...)
        if not ok then
            warn("[小贺脚本]["..(errName or "未知").."] 错误: "..tostring(err))
        end
    end
end

-- ============================================================
-- 【魔幻开场动画】
-- ============================================================
local IntroGui = Instance.new("ScreenGui")
IntroGui.Name = "HeIntro"; IntroGui.IgnoreGuiInset = true
IntroGui.ResetOnSpawn = false; IntroGui.DisplayOrder = 9999
IntroGui.Parent = PlayerGui

local Bg = Instance.new("Frame")
Bg.Size = UDim2.fromScale(1,1); Bg.BackgroundColor3 = Color3.fromRGB(8,4,20)
Bg.BackgroundTransparency = 1; Bg.Parent = IntroGui

-- 星空
for i=1,80 do
    local s=Instance.new("Frame")
    s.Size=UDim2.fromOffset(math.random(1,3),math.random(1,3))
    s.Position=UDim2.fromScale(math.random(),math.random())
    s.BackgroundColor3=Color3.fromRGB(math.random(180,255),math.random(160,230),255)
    s.BackgroundTransparency=1; s.BorderSizePixel=0
    Instance.new("UICorner",s).CornerRadius=UDim.new(1,0)
    s.Parent=Bg
    task.spawn(function() task.wait(math.random(0,0.5))
        TweenService:Create(s,TweenInfo.new(0.4),{BackgroundTransparency=math.random(3,7)/10}):Play() end)
end

local Core=Instance.new("TextLabel")
Core.AnchorPoint=Vector2.new(0.5,0.5);Core.Position=UDim2.fromScale(0.5,0.4)
Core.Size=UDim2.fromOffset(120,120);Core.BackgroundTransparency=1
Core.Text="✦";Core.TextColor3=Color3.fromRGB(200,160,255);Core.TextSize=80
Core.Font=Enum.Font.GothamBold;Core.TextTransparency=1;Core.Parent=IntroGui

local function makeRing(size,color,thick)
    local r=Instance.new("Frame")
    r.AnchorPoint=Vector2.new(0.5,0.5);r.Position=UDim2.fromScale(0.5,0.4)
    r.Size=UDim2.fromOffset(size,size);r.BackgroundTransparency=1;r.Parent=IntroGui
    Instance.new("UICorner",r).CornerRadius=UDim.new(1,0)
    local s=Instance.new("UIStroke");s.Thickness=thick;s.Transparency=1;s.Color=color;s.Parent=r
    return r,s
end
local R1,S1=makeRing(100,Color3.fromRGB(140,180,255),2)
local R2,S2=makeRing(170,Color3.fromRGB(200,120,255),2)
local R3,S3=makeRing(240,Color3.fromRGB(255,120,200),1)

local Title=Instance.new("TextLabel")
Title.AnchorPoint=Vector2.new(0.5,0.5);Title.Position=UDim2.fromScale(0.5,0.56)
Title.Size=UDim2.fromOffset(400,50);Title.BackgroundTransparency=1;Title.Text=""
Title.TextColor3=Color3.new(1,1,1);Title.TextSize=34;Title.Font=Enum.Font.GothamBold;Title.Parent=IntroGui

local Sub=Instance.new("TextLabel")
Sub.AnchorPoint=Vector2.new(0.5,0.5);Sub.Position=UDim2.fromScale(0.5,0.62)
Sub.Size=UDim2.fromOffset(400,25);Sub.BackgroundTransparency=1;Sub.Text=""
Sub.TextColor3=Color3.fromRGB(180,160,255);Sub.TextSize=13;Sub.Font=Enum.Font.Code;Sub.Parent=IntroGui

local Pbg=Instance.new("Frame")
Pbg.AnchorPoint=Vector2.new(0.5,0.5);Pbg.Position=UDim2.fromScale(0.5,0.70)
Pbg.Size=UDim2.fromOffset(260,6);Pbg.BackgroundColor3=Color3.fromRGB(25,15,50)
Pbg.BackgroundTransparency=0.2;Pbg.Parent=IntroGui
Instance.new("UICorner",Pbg).CornerRadius=UDim.new(1,0)
local Pf=Instance.new("Frame")
Pf.Size=UDim2.new(0,0,1,0);Pf.BackgroundColor3=Color3.fromRGB(160,100,255);Pf.Parent=Pbg
Instance.new("UICorner",Pf).CornerRadius=UDim.new(1,0)
local Pt=Instance.new("TextLabel")
Pt.AnchorPoint=Vector2.new(0.5,0.5);Pt.Position=UDim2.fromScale(0.5,0.75)
Pt.Size=UDim2.fromOffset(200,20);Pt.BackgroundTransparency=1
Pt.Text="0%";Pt.TextColor3=Color3.fromRGB(180,160,255);Pt.TextSize=12;Pt.Font=Enum.Font.Code;Pt.Parent=IntroGui

local function tw(obj,text,speed) for i=1,#text do obj.Text=string.sub(text,1,i) task.wait(speed) end end

TweenService:Create(Bg,TweenInfo.new(0.5),{BackgroundTransparency=0}):Play()
task.wait(0.3)
TweenService:Create(Core,TweenInfo.new(0.8,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{TextTransparency=0,TextSize=100}):Play()
TweenService:Create(S1,TweenInfo.new(0.8),{Transparency=0}):Play()
TweenService:Create(S2,TweenInfo.new(0.8),{Transparency=0}):Play()
TweenService:Create(S3,TweenInfo.new(0.8),{Transparency=0.5}):Play()
task.wait(0.3)
tw(Title,"小贺脚本 V11",0.06)
task.wait(0.1)
tw(Sub,"SYSTEM LOADING...",0.04)

task.spawn(function() while IntroGui.Parent do R1.Rotation+=4;R2.Rotation-=3;R3.Rotation+=2;task.wait(0.02) end end)
task.spawn(function() while IntroGui.Parent do
    TweenService:Create(Core,TweenInfo.new(0.7,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{TextSize=110}):Play()
    task.wait(0.7)
    TweenService:Create(Core,TweenInfo.new(0.7,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{TextSize=95}):Play()
    task.wait(0.7)
end end)

for i=1,15 do
    task.spawn(function()
        local p=Instance.new("TextLabel")
        p.AnchorPoint=Vector2.new(0.5,0.5);p.Position=UDim2.fromScale(0.5,0.4)
        p.Size=UDim2.fromOffset(20,20);p.BackgroundTransparency=1;p.Text="✦"
        p.TextSize=math.random(8,18);p.TextColor3=Color3.fromRGB(math.random(150,255),math.random(100,200),255)
        p.Parent=IntroGui
        local a=math.rad(math.random(0,360));local d=math.random(100,280)
        TweenService:Create(p,TweenInfo.new(math.random(7,14)/10,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{
            Position=UDim2.fromScale(0.5+math.cos(a)*d/1000,0.4+math.sin(a)*d/1000),
            TextTransparency=1,Rotation=math.random(-180,180)}):Play()
        Debris:AddItem(p,1.5)
    end)
    task.wait(0.03)
end

for i=0,100,3 do
    Pf.Size=UDim2.new(i/100,0,1,0);Pt.Text=i.."%"
    task.wait(0.02)
end
Pt.Text="100% 完成"
task.wait(0.3)

local Flash=Instance.new("Frame")
Flash.Size=UDim2.fromScale(1,1);Flash.BackgroundColor3=Color3.fromRGB(200,160,255)
Flash.BackgroundTransparency=1;Flash.Parent=IntroGui
TweenService:Create(Flash,TweenInfo.new(0.2),{BackgroundTransparency=0}):Play()
task.wait(0.15)
TweenService:Create(Bg,TweenInfo.new(0.5),{BackgroundTransparency=1}):Play()
TweenService:Create(Core,TweenInfo.new(0.5),{TextTransparency=1,TextSize=160}):Play()
TweenService:Create(S1,TweenInfo.new(0.5),{Transparency=1}):Play()
TweenService:Create(S2,TweenInfo.new(0.5),{Transparency=1}):Play()
TweenService:Create(S3,TweenInfo.new(0.5),{Transparency=1}):Play()
TweenService:Create(Title,TweenInfo.new(0.4),{TextTransparency=1}):Play()
TweenService:Create(Sub,TweenInfo.new(0.4),{TextTransparency=1}):Play()
TweenService:Create(Pbg,TweenInfo.new(0.4),{BackgroundTransparency=1}):Play()
TweenService:Create(Pt,TweenInfo.new(0.4),{TextTransparency=1}):Play()
TweenService:Create(Flash,TweenInfo.new(0.4),{BackgroundTransparency=1}):Play()
for _,s in ipairs(Bg:GetChildren()) do if s:IsA("Frame") then TweenService:Create(s,TweenInfo.new(0.4),{BackgroundTransparency=1}):Play() end end
task.wait(0.6)
IntroGui:Destroy()

-- ============================================================
-- 反挂机
-- ============================================================
pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification",{Title="小贺脚本",Text="反挂机已开启",Duration=3})
end)
local vu=game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
    pcall(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        task.wait(1);vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end)

-- ============================================================
-- 【主菜单 UI 系统】
-- ============================================================
local MainGui=Instance.new("ScreenGui")
MainGui.Name="HeScriptUI";MainGui.IgnoreGuiInset=true;MainGui.ResetOnSpawn=false
MainGui.DisplayOrder=900;MainGui.Parent=PlayerGui

local COL={
    Bg=Color3.fromRGB(15,10,35), Bg2=Color3.fromRGB(25,18,50),
    Accent=Color3.fromRGB(160,100,255), Accent2=Color3.fromRGB(80,180,255),
    Text=Color3.fromRGB(240,235,255), TextDim=Color3.fromRGB(160,155,190),
    Button=Color3.fromRGB(30,22,55), ToggleOn=Color3.fromRGB(80,200,130),
    ToggleOff=Color3.fromRGB(55,48,80),
}

-- 悬浮按钮
local FloatBtn=Instance.new("TextButton")
FloatBtn.Name="FloatBtn";FloatBtn.Size=UDim2.fromOffset(52,52)
FloatBtn.Position=UDim2.new(0,16,0.5,-26);FloatBtn.BackgroundColor3=COL.Accent
FloatBtn.Text="✦";FloatBtn.TextColor3=Color3.new(1,1,1)
FloatBtn.TextSize=26;FloatBtn.Font=Enum.Font.GothamBold
FloatBtn.AutoButtonColor=false;FloatBtn.Parent=MainGui
Instance.new("UICorner",FloatBtn).CornerRadius=UDim.new(1,0)
local FloatBorder=Instance.new("UIStroke")
FloatBorder.Thickness=2;FloatBorder.Color=COL.Accent2;FloatBorder.Transparency=0.4;FloatBorder.Parent=FloatBtn

task.spawn(function()
    while FloatBtn.Parent do
        TweenService:Create(FloatBtn,TweenInfo.new(1,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{BackgroundColor3=COL.Accent2}):Play()
        TweenService:Create(FloatBorder,TweenInfo.new(1,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{Color=COL.Accent}):Play()
        task.wait(1)
        TweenService:Create(FloatBtn,TweenInfo.new(1,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{BackgroundColor3=COL.Accent}):Play()
        TweenService:Create(FloatBorder,TweenInfo.new(1,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{Color=COL.Accent2}):Play()
        task.wait(1)
    end
end)

-- 主面板
local Panel=Instance.new("Frame")
Panel.Name="Panel";Panel.AnchorPoint=Vector2.new(0.5,0.5)
Panel.Position=UDim2.new(0.5,0,0.5,0);Panel.Size=UDim2.new(0,620,0,400)
Panel.BackgroundColor3=COL.Bg;Panel.BackgroundTransparency=1
Panel.Visible=false;Panel.Parent=MainGui
Instance.new("UICorner",Panel).CornerRadius=UDim.new(0,16)
local PanelBorder=Instance.new("UIStroke")
PanelBorder.Thickness=2;PanelBorder.Color=COL.Accent;PanelBorder.Transparency=0.5;PanelBorder.Parent=Panel

-- 动态霓虹背景
local function createDynamicBackground(parent)
    local bg = Instance.new("Frame")
    bg.Name = "DynamicBg"; bg.Size = UDim2.fromScale(1,1)
    bg.Position = UDim2.new(0,0,0,0); bg.BackgroundColor3 = Color3.fromRGB(10,6,25)
    bg.BorderSizePixel = 0; bg.ZIndex = 1; bg.Parent = parent
    Instance.new("UICorner",bg).CornerRadius = UDim.new(0,16)
    local glow1=Instance.new("Frame");glow1.Size=UDim2.fromOffset(220,220)
    glow1.Position=UDim2.new(0,-60,0,-60);glow1.BackgroundColor3=Color3.fromRGB(130,70,210)
    glow1.BorderSizePixel=0;glow1.ZIndex=1;glow1.Parent=bg
    Instance.new("UICorner",glow1).CornerRadius=UDim.new(1,0)
    local g1=Instance.new("UIGradient");g1.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(1,1)});g1.Parent=glow1
    local glow2=Instance.new("Frame");glow2.Size=UDim2.fromOffset(200,200)
    glow2.Position=UDim2.new(1,-90,1,-90);glow2.BackgroundColor3=Color3.fromRGB(70,150,230)
    glow2.BorderSizePixel=0;glow2.ZIndex=1;glow2.Parent=bg
    Instance.new("UICorner",glow2).CornerRadius=UDim.new(1,0)
    local g2=Instance.new("UIGradient");g2.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(1,1)});g2.Parent=glow2
    local glow3=Instance.new("Frame");glow3.Size=UDim2.fromOffset(140,140)
    glow3.Position=UDim2.new(0.5,-70,0.25,-70);glow3.BackgroundColor3=Color3.fromRGB(210,90,170)
    glow3.BorderSizePixel=0;glow3.ZIndex=1;glow3.Parent=bg
    Instance.new("UICorner",glow3).CornerRadius=UDim.new(1,0)
    local g3=Instance.new("UIGradient");g3.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.2),NumberSequenceKeypoint.new(1,1)});g3.Parent=glow3
    for i=1,15 do
        local p=Instance.new("Frame");p.Size=UDim2.fromOffset(math.random(2,5),math.random(2,5))
        p.Position=UDim2.fromScale(math.random(),math.random())
        p.BackgroundColor3=Color3.fromRGB(math.random(180,255),math.random(160,230),math.random(220,255))
        p.BorderSizePixel=0;p.ZIndex=1;p.Parent=bg
        Instance.new("UICorner",p).CornerRadius=UDim.new(1,0)
        task.spawn(function()
            while p.Parent do
                TweenService:Create(p,TweenInfo.new(math.random(3,7),Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{
                    Position=UDim2.fromScale(math.random(5,95)/100,math.random(5,95)/100),
                    BackgroundTransparency=math.random(4,8)/10}):Play()
                task.wait(math.random(3,7))
            end
        end)
    end
    task.spawn(function()
        while bg.Parent do
            TweenService:Create(glow1,TweenInfo.new(2.5,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{BackgroundTransparency=0.25}):Play()
            TweenService:Create(glow2,TweenInfo.new(3,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{BackgroundTransparency=0.35}):Play()
            TweenService:Create(glow3,TweenInfo.new(2,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{BackgroundTransparency=0.1}):Play()
            task.wait(2.5)
            TweenService:Create(glow1,TweenInfo.new(2.5,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{BackgroundTransparency=0.55}):Play()
            TweenService:Create(glow2,TweenInfo.new(3,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{BackgroundTransparency=0.65}):Play()
            TweenService:Create(glow3,TweenInfo.new(2,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{BackgroundTransparency=0.45}):Play()
            task.wait(2.5)
        end
    end)
    local dim=Instance.new("Frame");dim.Size=UDim2.fromScale(1,1)
    dim.BackgroundColor3=Color3.fromRGB(5,3,15);dim.BackgroundTransparency=0.5
    dim.BorderSizePixel=0;dim.ZIndex=2;dim.Parent=bg
    Instance.new("UICorner",dim).CornerRadius=UDim.new(0,16)
    return bg
end
createDynamicBackground(Panel)

-- 标题栏
local Header=Instance.new("Frame")
Header.Size=UDim2.new(1,0,0,44);Header.BackgroundColor3=COL.Bg2
Header.BackgroundTransparency=0.3;Header.ZIndex=3;Header.Parent=Panel
Instance.new("UICorner",Header).CornerRadius=UDim.new(0,16)
local HeaderTitle=Instance.new("TextLabel")
HeaderTitle.Size=UDim2.new(1,-100,1,0);HeaderTitle.Position=UDim2.new(0,16,0,0)
HeaderTitle.BackgroundTransparency=1;HeaderTitle.Text="✦ 小贺脚本 V11"
HeaderTitle.TextColor3=COL.Text;HeaderTitle.TextSize=16;HeaderTitle.Font=Enum.Font.GothamBold
HeaderTitle.TextXAlignment=Enum.TextXAlignment.Left;HeaderTitle.ZIndex=4;HeaderTitle.Parent=Header
local CloseBtn=Instance.new("TextButton")
CloseBtn.Size=UDim2.fromOffset(36,36);CloseBtn.Position=UDim2.new(1,-42,0,4)
CloseBtn.BackgroundColor3=COL.Button;CloseBtn.Text="✕";CloseBtn.TextColor3=COL.TextDim
CloseBtn.TextSize=14;CloseBtn.AutoButtonColor=false;CloseBtn.ZIndex=4;CloseBtn.Parent=Header
Instance.new("UICorner",CloseBtn).CornerRadius=UDim.new(1,0)

-- 标签栏
local TabBar=Instance.new("Frame")
TabBar.Size=UDim2.new(0,110,1,-52);TabBar.Position=UDim2.new(0,8,0,50)
TabBar.BackgroundColor3=COL.Bg2;TabBar.BackgroundTransparency=0.4
TabBar.ZIndex=3;TabBar.Parent=Panel
Instance.new("UICorner",TabBar).CornerRadius=UDim.new(0,10)
local TabList=Instance.new("UIListLayout")
TabList.Padding=UDim.new(0,6);TabList.SortOrder=Enum.SortOrder.LayoutOrder;TabList.Parent=TabBar
local TabPad=Instance.new("UIPadding")
TabPad.PaddingTop=UDim.new(0,8);TabPad.PaddingLeft=UDim.new(0,6);TabPad.PaddingRight=UDim.new(0,6);TabPad.Parent=TabBar

-- 内容区
local Content=Instance.new("ScrollingFrame")
Content.Size=UDim2.new(1,-130,1,-52);Content.Position=UDim2.new(0,122,0,50)
Content.BackgroundTransparency=1;Content.BorderSizePixel=0
Content.ScrollBarThickness=6;Content.ScrollBarImageColor3=COL.Accent
Content.CanvasSize=UDim2.new(0,0,0,0);Content.AutomaticCanvasSize=Enum.AutomaticSize.Y
Content.ZIndex=3;Content.Parent=Panel

local Tabs={};local TabBtns={};CurrentTab=nil
local function createTab(name)
    local c=Instance.new("Frame")
    c.Name=name;c.Size=UDim2.new(1,0,0,0);c.BackgroundTransparency=1
    c.AutomaticSize=Enum.AutomaticSize.Y;c.Visible=false;c.ZIndex=4;c.Parent=Content
    local ll=Instance.new("UIListLayout");ll.Padding=UDim.new(0,6);ll.SortOrder=Enum.SortOrder.LayoutOrder;ll.Parent=c
    local pad=Instance.new("UIPadding");pad.PaddingTop=UDim.new(0,4);pad.PaddingBottom=UDim.new(0,10);pad.PaddingRight=UDim.new(0,4);pad.Parent=c
    Tabs[name]=c;return c
end
local function switchTab(name)
    for n,t in pairs(Tabs) do t.Visible=(n==name) end
    for n,b in pairs(TabBtns) do
        if n==name then b.BackgroundColor3=COL.Accent;b.TextColor3=Color3.new(1,1,1)
        else b.BackgroundColor3=COL.Button;b.TextColor3=COL.TextDim end
    end
    CurrentTab=name
end
local function addTabBtn(name,idx)
    local b=Instance.new("TextButton")
    b.Size=UDim2.new(1,0,0,40);b.BackgroundColor3=COL.Button
    b.Text=name;b.TextColor3=COL.TextDim;b.TextSize=13
    b.Font=Enum.Font.GothamBold;b.AutoButtonColor=false;b.LayoutOrder=idx
    b.ZIndex=4;b.Parent=TabBar
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,8)
    b.MouseButton1Click:Connect(function() switchTab(name) end)
    TabBtns[name]=b;return b
end
local function addLabel(c,text)
    local l=Instance.new("TextLabel")
    l.Size=UDim2.new(1,0,0,22);l.BackgroundTransparency=1
    l.Text=text;l.TextColor3=COL.TextDim;l.TextSize=12
    l.Font=Enum.Font.Gotham;l.TextXAlignment=Enum.TextXAlignment.Left
    l.ZIndex=5;l.Parent=c;return l
end
local function addPara(c,title,text)
    local f=Instance.new("Frame")
    f.Size=UDim2.new(1,0,0,46);f.BackgroundColor3=COL.Bg2
    f.BackgroundTransparency=0.3;f.ZIndex=5;f.Parent=c
    Instance.new("UICorner",f).CornerRadius=UDim.new(0,10)
    local t=Instance.new("TextLabel");t.Size=UDim2.new(1,-12,0,18);t.Position=UDim2.new(0,10,0,5)
    t.BackgroundTransparency=1;t.Text=title;t.TextColor3=COL.Accent;t.TextSize=13
    t.Font=Enum.Font.GothamBold;t.TextXAlignment=Enum.TextXAlignment.Left;t.ZIndex=6;t.Parent=f
    local d=Instance.new("TextLabel");d.Size=UDim2.new(1,-12,0,18);d.Position=UDim2.new(0,10,0,24)
    d.BackgroundTransparency=1;d.Text=text;d.TextColor3=COL.Text;d.TextSize=12
    d.Font=Enum.Font.Gotham;d.TextXAlignment=Enum.TextXAlignment.Left;d.ZIndex=6;d.Parent=f
    return f
end
local function addBtn(c,name,cb)
    local b=Instance.new("TextButton")
    b.Size=UDim2.new(1,0,0,40);b.BackgroundColor3=COL.Button
    b.BackgroundTransparency=0.15;b.Text="  "..name;b.TextColor3=COL.Text;b.TextSize=13
    b.Font=Enum.Font.Gotham;b.TextXAlignment=Enum.TextXAlignment.Left
    b.AutoButtonColor=false;b.ZIndex=5;b.Parent=c
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,10)
    b.MouseButton1Click:Connect(safe(function()
        TweenService:Create(b,TweenInfo.new(0.1),{BackgroundColor3=COL.Accent}):Play()
        task.wait(0.1);TweenService:Create(b,TweenInfo.new(0.2),{BackgroundColor3=COL.Button}):Play()
        cb()
    end, "按钮:"..name))
    return b
end
local function addToggle(c,name,default,cb)
    local f=Instance.new("Frame")
    f.Size=UDim2.new(1,0,0,40);f.BackgroundColor3=COL.Button
    f.BackgroundTransparency=0.15;f.ZIndex=5;f.Parent=c
    Instance.new("UICorner",f).CornerRadius=UDim.new(0,10)
    local l=Instance.new("TextLabel");l.Size=UDim2.new(1,-60,1,0);l.Position=UDim2.new(0,12,0,0)
    l.BackgroundTransparency=1;l.Text=name;l.TextColor3=COL.Text;l.TextSize=13
    l.Font=Enum.Font.Gotham;l.TextXAlignment=Enum.TextXAlignment.Left;l.ZIndex=6;l.Parent=f
    local t=Instance.new("TextButton");t.Size=UDim2.fromOffset(44,22);t.Position=UDim2.new(1,-52,0,9)
    t.BackgroundColor3=default and COL.ToggleOn or COL.ToggleOff;t.Text="";t.AutoButtonColor=false
    t.ZIndex=6;t.Parent=f
    Instance.new("UICorner",t).CornerRadius=UDim.new(1,0)
    local k=Instance.new("Frame");k.Size=UDim2.fromOffset(16,16)
    k.Position=default and UDim2.new(1,-19,0,3) or UDim2.new(0,3,0,3)
    k.BackgroundColor3=Color3.new(1,1,1);k.BorderSizePixel=0;k.ZIndex=7;k.Parent=t
    Instance.new("UICorner",k).CornerRadius=UDim.new(1,0)
    local state=default
    t.MouseButton1Click:Connect(safe(function()
        state=not state
        TweenService:Create(t,TweenInfo.new(0.2),{BackgroundColor3=state and COL.ToggleOn or COL.ToggleOff}):Play()
        TweenService:Create(k,TweenInfo.new(0.2),{Position=state and UDim2.new(1,-19,0,3) or UDim2.new(0,3,0,3)}):Play()
        cb(state)
    end, "开关:"..name))
    return f
end
local function addSlider(c,name,min,max,default,cb)
    local f=Instance.new("Frame")
    f.Size=UDim2.new(1,0,0,50);f.BackgroundColor3=COL.Button
    f.BackgroundTransparency=0.15;f.ZIndex=5;f.Parent=c
    Instance.new("UICorner",f).CornerRadius=UDim.new(0,10)
    local l=Instance.new("TextLabel");l.Size=UDim2.new(1,-12,0,16);l.Position=UDim2.new(0,10,0,5)
    l.BackgroundTransparency=1;l.Text=name.." : "..default;l.TextColor3=COL.Text;l.TextSize=12
    l.Font=Enum.Font.Gotham;l.TextXAlignment=Enum.TextXAlignment.Left;l.ZIndex=6;l.Parent=f
    local bar=Instance.new("Frame");bar.Size=UDim2.new(1,-20,0,6);bar.Position=UDim2.new(0,10,0,30)
    bar.BackgroundColor3=Color3.fromRGB(15,10,35);bar.ZIndex=6;bar.Parent=f
    Instance.new("UICorner",bar).CornerRadius=UDim.new(1,0)
    local fill=Instance.new("Frame");fill.Size=UDim2.new((default-min)/(max-min),0,1,0)
    fill.BackgroundColor3=COL.Accent;fill.ZIndex=7;fill.Parent=bar
    Instance.new("UICorner",fill).CornerRadius=UDim.new(1,0)
    local btn=Instance.new("TextButton");btn.Size=UDim2.new(1,0,1,0);btn.BackgroundTransparency=1
    btn.Text="";btn.ZIndex=8;btn.Parent=bar
    local dragging=false
    btn.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true end end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and(i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then
            local p=math.clamp((i.Position.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)
            fill.Size=UDim2.new(p,0,1,0)
            local val=math.floor(min+p*(max-min))
            l.Text=name.." : "..val;cb(val)
        end
    end)
    return f
end

-- ============================================================
-- 【玩家选择器 V11 · 修复名称显示】
-- ============================================================
local function selectPlayer(cb, title)
    local plrs = Players:GetPlayers()
    local others = {}
    for _, p in ipairs(plrs) do if p ~= LocalPlayer then table.insert(others, p) end end
    if #others == 0 then
        pcall(function() game:GetService("StarterGui"):SetCore("SendNotification",{Title="小贺脚本",Text="服务器里没有其他玩家",Duration=3}) end)
        return
    end
    local selGui = Instance.new("ScreenGui")
    selGui.Name = "PlayerSelect_V11"; selGui.IgnoreGuiInset = true
    selGui.DisplayOrder = 9998; selGui.Parent = PlayerGui

    local bg = Instance.new("Frame")
    bg.Size = UDim2.fromScale(1,1); bg.BackgroundColor3 = Color3.new(0,0,0)
    bg.BackgroundTransparency = 0.6; bg.ZIndex = 1; bg.Parent = selGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0,320,0,420); frame.Position = UDim2.new(0.5,-160,0.5,-210)
    frame.BackgroundColor3 = COL.Bg; frame.ZIndex = 2; frame.Parent = selGui
    Instance.new("UICorner",frame).CornerRadius = UDim.new(0,14)
    local fb = Instance.new("UIStroke"); fb.Thickness=2; fb.Color=COL.Accent; fb.Transparency=0.4; fb.Parent=frame

    -- 标题
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1,0,0,44); titleBar.BackgroundColor3 = COL.Bg2
    titleBar.BackgroundTransparency = 0.3; titleBar.ZIndex = 3; titleBar.Parent = frame
    Instance.new("UICorner",titleBar).CornerRadius = UDim.new(0,14)
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1,-50,1,0); t.Position = UDim2.new(0,14,0,0)
    t.BackgroundTransparency = 1; t.ZIndex = 4
    t.Text = (title or "选择玩家").." ("..#others.."人)"
    t.TextColor3 = COL.Text; t.TextSize = 16; t.Font = Enum.Font.GothamBold
    t.TextXAlignment = Enum.TextXAlignment.Left; t.Parent = titleBar
    local close = Instance.new("TextButton")
    close.Size = UDim2.fromOffset(36,36); close.Position = UDim2.new(1,-40,0,4)
    close.BackgroundColor3 = COL.Button; close.Text = "✕"; close.TextColor3 = COL.TextDim
    close.TextSize = 14; close.AutoButtonColor = false; close.ZIndex = 4; close.Parent = titleBar
    Instance.new("UICorner",close).CornerRadius = UDim.new(1,0)
    close.MouseButton1Click:Connect(function() selGui:Destroy() end)
    bg.MouseButton1Click:Connect(function() selGui:Destroy() end)

    -- 滚动列表
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1,-16,1,-56); scroll.Position = UDim2.new(0,8,0,50)
    scroll.BackgroundTransparency = 1; scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 4; scroll.ScrollBarImageColor3 = COL.Accent
    scroll.CanvasSize = UDim2.new(0,0,0,0); scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.ZIndex = 3; scroll.Parent = frame
    local ll = Instance.new("UIListLayout"); ll.Padding = UDim.new(0,6); ll.SortOrder = Enum.SortOrder.LayoutOrder; ll.Parent = scroll
    local sp = Instance.new("UIPadding"); sp.PaddingTop=UDim.new(0,4); sp.PaddingBottom=UDim.new(0,8); sp.Parent = scroll

    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

    for idx, p in ipairs(others) do
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1,0,0,48); b.BackgroundColor3 = COL.Button
        b.BackgroundTransparency = 0.1; b.LayoutOrder = idx; b.ZIndex = 4; b.Parent = scroll
        Instance.new("UICorner",b).CornerRadius = UDim.new(0,10)

        -- 队伍色条
        if p.Team then
            local bar = Instance.new("Frame")
            bar.Size = UDim2.new(0,5,1,-10); bar.Position = UDim2.new(0,6,0,5)
            bar.BackgroundColor3 = p.Team.TeamColor.Color; bar.BorderSizePixel = 0
            bar.ZIndex = 5; bar.Parent = b
            Instance.new("UICorner",bar).CornerRadius = UDim.new(1,0)
        end

        -- 玩家名称（关键修复：确保文字可见）
        local nameLbl = Instance.new("TextLabel")
        nameLbl.Size = UDim2.new(1,-90,0,22); nameLbl.Position = UDim2.new(0,18,0,6)
        nameLbl.BackgroundTransparency = 1; nameLbl.ZIndex = 6
        nameLbl.Text = p.Name  -- 直接用 p.Name，确保显示
        nameLbl.TextColor3 = COL.Text; nameLbl.TextSize = 14
        nameLbl.Font = Enum.Font.GothamBold; nameLbl.TextXAlignment = Enum.TextXAlignment.Left
        nameLbl.Parent = b

        -- 显示名（如果有）
        local dispLbl = Instance.new("TextLabel")
        dispLbl.Size = UDim2.new(1,-90,0,16); dispLbl.Position = UDim2.new(0,18,0,27)
        dispLbl.BackgroundTransparency = 1; dispLbl.ZIndex = 6
        local dispText = ""
        if p.DisplayName and p.DisplayName ~= p.Name then
            dispText = "@"..p.DisplayName
        end
        if p.Team then
            dispText = dispText.."  ["..p.Team.Name.."]"
        end
        dispLbl.Text = dispText
        dispLbl.TextColor3 = COL.TextDim; dispLbl.TextSize = 11
        dispLbl.Font = Enum.Font.Gotham; dispLbl.TextXAlignment = Enum.TextXAlignment.Left
        dispLbl.Parent = b

        -- 距离
        local distLbl = Instance.new("TextLabel")
        distLbl.Size = UDim2.new(0,70,1,0); distLbl.Position = UDim2.new(1,-78,0,0)
        distLbl.BackgroundTransparency = 1; distLbl.ZIndex = 6
        local distText = "离线"
        local theirRoot = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
        if myRoot and theirRoot then
            local dist = (theirRoot.Position - myRoot.Position).Magnitude
            distText = string.format("%.0fm", dist)
        elseif theirRoot then
            distText = "在场"
        end
        distLbl.Text = distText
        distLbl.TextColor3 = COL.Accent2; distLbl.TextSize = 13
        distLbl.Font = Enum.Font.GothamBold; distLbl.TextXAlignment = Enum.TextXAlignment.Right
        distLbl.Parent = b

        b.MouseButton1Click:Connect(safe(function()
            selGui:Destroy()
            if p and p.Parent then
                cb(p)
            else
                pcall(function() game:GetService("StarterGui"):SetCore("SendNotification",{Title="小贺脚本",Text="目标已离开游戏",Duration=2}) end)
            end
        end, "玩家选择"))
    end
end

-- 面板开关
local panelOpen=false
local function openPanel()
    panelOpen=true;FloatBtn.Visible=false;Panel.Visible=true
    Panel.BackgroundTransparency=1;PanelBorder.Transparency=1
    TweenService:Create(Panel,TweenInfo.new(0.35,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{BackgroundTransparency=0}):Play()
    TweenService:Create(PanelBorder,TweenInfo.new(0.3),{Transparency=0.4}):Play()
end
local function closePanel()
    panelOpen=false
    TweenService:Create(Panel,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{BackgroundTransparency=1}):Play()
    TweenService:Create(PanelBorder,TweenInfo.new(0.25),{Transparency=1}):Play()
    task.wait(0.25);Panel.Visible=false;FloatBtn.Visible=true
end
FloatBtn.MouseButton1Click:Connect(function() if panelOpen then closePanel() else openPanel() end end)
CloseBtn.MouseButton1Click:Connect(closePanel)

-- 拖动
local dragging=false;local dragStart=nil;local startPos=nil;local dragTarget=nil
FloatBtn.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true;dragStart=i.Position;startPos=FloatBtn.Position;dragTarget=FloatBtn end end)
Header.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true;dragStart=i.Position;startPos=Panel.Position;dragTarget=Panel end end)
UserInputService.InputChanged:Connect(function(i)
    if dragging and(i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then
        local d=i.Position-dragStart
        dragTarget.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
    end
end)
UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)

-- ============================================================
-- 【核心工具函数】
-- ============================================================
local function getChar() return LocalPlayer.Character end
local function getHum() local c=getChar();return c and c:FindFirstChildOfClass("Humanoid") end
local function getRoot() local c=getChar();return c and c:FindFirstChild("HumanoidRootPart") end

-- ============================================================
-- 【独立飞行面板 V11 · 完整还原原GUI+原理】
-- ============================================================
local FlyGui = nil
local flyActive = false
local flySpeed = 50
local flyBv = nil
local flyBg = nil
local flyConn = nil
local flyDiedConn = nil
local flyCharAddedConn = nil
local flyUpHeld = false
local flyDownHeld = false

local function cleanupFly()
    flyActive = false
    if flyConn then pcall(function() flyConn:Disconnect() end); flyConn = nil end
    if flyDiedConn then pcall(function() flyDiedConn:Disconnect() end); flyDiedConn = nil end
    if flyBg then pcall(function() flyBg:Destroy() end); flyBg = nil end
    if flyBv then pcall(function() flyBv:Destroy() end); flyBv = nil end
    flyUpHeld = false; flyDownHeld = false
    local hum = getHum()
    if hum then
        pcall(function()
            hum.PlatformStand = false
            hum.GravityScale = 1
            hum.JumpPower = 50
        end)
    end
end

local function startFly()
    local hum = getHum(); local root = getRoot()
    if not hum or not root then
        pcall(function() game:GetService("StarterGui"):SetCore("SendNotification",{Title="飞行面板",Text="等待角色加载...",Duration=2}) end)
        return false
    end
    flyActive = true
    pcall(function()
        hum.PlatformStand = true
        hum.GravityScale = 0
        hum.JumpPower = 0
    end)

    flyBv = Instance.new("BodyVelocity")
    flyBv.Name = "FlyBV"; flyBv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
    flyBv.Velocity = Vector3.new(0,0,0); flyBv.P = 12000; flyBv.Parent = root

    flyBg = Instance.new("BodyGyro")
    flyBg.Name = "FlyBG"; flyBg.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
    flyBg.P = 10000; flyBg.CFrame = root.CFrame; flyBg.Parent = root

    flyDiedConn = hum.Died:Connect(function() cleanupFly() end)

    -- 核心原理：摇杆方向 + 视角朝向 + 上下按钮
    flyConn = RunService.Heartbeat:Connect(function()
        local h = getHum(); local r = getRoot()
        if not h or not r or not flyBv or not flyBg then return end
        local cam = workspace.CurrentCamera
        local moveDir = h.MoveDirection
        local vel = Vector3.new(0,0,0)
        -- 摇杆水平移动（罗布乐思原版操控）
        if moveDir.Magnitude > 0.1 then
            vel = moveDir * flySpeed
        end
        -- 上/下按钮控制垂直
        if flyUpHeld then
            vel = vel + Vector3.new(0, flySpeed, 0)
        elseif flyDownHeld then
            vel = vel + Vector3.new(0, -flySpeed, 0)
        end
        flyBv.Velocity = vel
        -- 视角朝向跟随
        local lookDir = cam.CFrame.LookVector * Vector3.new(1,0,1)
        if lookDir.Magnitude > 0.01 then
            flyBg.CFrame = CFrame.new(r.Position, r.Position + lookDir)
        end
    end)

    pcall(function() game:GetService("StarterGui"):SetCore("SendNotification",{Title="飞行面板",Text="✈ 飞行已开启",Duration=2}) end)
    return true
end

local function stopFly()
    cleanupFly()
    pcall(function() game:GetService("StarterGui"):SetCore("SendNotification",{Title="飞行面板",Text="飞行已关闭",Duration=2}) end)
end

-- 角色重生时自动清理
flyCharAddedConn = LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    if flyActive then cleanupFly() end
end)

-- ============================================================
-- 飞行面板GUI · 完整还原原脚本样式
-- ============================================================
local function createFlyPanel()
    if FlyGui then pcall(function() FlyGui:Destroy() end); FlyGui = nil end
    FlyGui = Instance.new("ScreenGui")
    FlyGui.Name = "FlyPanel_V11"; FlyGui.IgnoreGuiInset = true
    FlyGui.ResetOnSpawn = false; FlyGui.DisplayOrder = 950; FlyGui.Parent = PlayerGui

    -- 主面板（还原原绿色风格）
    local Frame = Instance.new("Frame")
    Frame.Name = "FlyFrame"
    Frame.BackgroundColor3 = Color3.fromRGB(163,255,137)
    Frame.BorderColor3 = Color3.fromRGB(103,221,213)
    Frame.Position = UDim2.new(0.1,0,0.38,0)
    Frame.Size = UDim2.new(0,190,0,57)
    Frame.Active = true; Frame.Draggable = true
    Frame.Parent = FlyGui

    -- 上按钮
    local up = Instance.new("TextButton")
    up.Name="up";up.Parent=Frame
    up.BackgroundColor3=Color3.fromRGB(79,255,152)
    up.Size=UDim2.new(0,44,0,28)
    up.Position=UDim2.new(0,0,0,0)
    up.Font=Enum.Font.SourceSans;up.Text="上"
    up.TextColor3=Color3.new(0,0,0);up.TextSize=14
    up.AutoButtonColor=false

    -- 下按钮
    local down = Instance.new("TextButton")
    down.Name="down";down.Parent=Frame
    down.BackgroundColor3=Color3.fromRGB(215,255,121)
    down.Position=UDim2.new(0,0,0.49,0)
    down.Size=UDim2.new(0,44,0,28)
    down.Font=Enum.Font.SourceSans;down.Text="下"
    down.TextColor3=Color3.new(0,0,0);down.TextSize=14
    down.AutoButtonColor=false

    -- 飞行开关
    local onof = Instance.new("TextButton")
    onof.Name="onof";onof.Parent=Frame
    onof.BackgroundColor3=Color3.fromRGB(255,249,74)
    onof.Position=UDim2.new(0.70,0,0.49,0)
    onof.Size=UDim2.new(0,56,0,28)
    onof.Font=Enum.Font.SourceSans;onof.Text="飞行"
    onof.TextColor3=Color3.new(0,0,0);onof.TextSize=14
    onof.AutoButtonColor=false

    -- 标题
    local title = Instance.new("TextLabel")
    title.Parent=Frame
    title.BackgroundColor3=Color3.fromRGB(242,60,255)
    title.Position=UDim2.new(0.47,0,0,0)
    title.Size=UDim2.new(0,100,0,28)
    title.Font=Enum.Font.SourceSans;title.Text="小贺脚本 飞行V11"
    title.TextColor3=Color3.new(0,0,0);title.TextScaled=true;title.TextSize=14

    -- 加速
    local plus = Instance.new("TextButton")
    plus.Name="plus";plus.Parent=Frame
    plus.BackgroundColor3=Color3.fromRGB(133,145,255)
    plus.Position=UDim2.new(0.23,0,0,0)
    plus.Size=UDim2.new(0,45,0,28)
    plus.Font=Enum.Font.SourceSans;plus.Text="加速"
    plus.TextColor3=Color3.new(0,0,0);plus.TextScaled=true;plus.TextSize=14
    plus.AutoButtonColor=false

    -- 速度显示
    local speedLbl = Instance.new("TextLabel")
    speedLbl.Name="speed";speedLbl.Parent=Frame
    speedLbl.BackgroundColor3=Color3.fromRGB(255,85,0)
    speedLbl.Position=UDim2.new(0.47,0,0.49,0)
    speedLbl.Size=UDim2.new(0,44,0,28)
    speedLbl.Font=Enum.Font.SourceSans;speedLbl.Text=tostring(flySpeed)
    speedLbl.TextColor3=Color3.new(0,0,0);speedLbl.TextScaled=true;speedLbl.TextSize=14

    -- 减速
    local mine = Instance.new("TextButton")
    mine.Name="mine";mine.Parent=Frame
    mine.BackgroundColor3=Color3.fromRGB(123,255,247)
    mine.Position=UDim2.new(0.23,0,0.49,0)
    mine.Size=UDim2.new(0,45,0,29)
    mine.Font=Enum.Font.SourceSans;mine.Text="减速"
    mine.TextColor3=Color3.new(0,0,0);mine.TextScaled=true;mine.TextSize=14
    mine.AutoButtonColor=false

    -- 关闭
    local closeBtn = Instance.new("TextButton")
    closeBtn.Name="Close";closeBtn.Parent=Frame
    closeBtn.BackgroundColor3=Color3.fromRGB(225,25,0)
    closeBtn.Font=Enum.Font.SourceSans;closeBtn.Size=UDim2.new(0,45,0,28)
    closeBtn.Text="关闭";closeBtn.TextSize=14
    closeBtn.Position=UDim2.new(0,0,-1,27)
    closeBtn.AutoButtonColor=false

    -- 隐藏
    local mini = Instance.new("TextButton")
    mini.Name="minimize";mini.Parent=Frame
    mini.BackgroundColor3=Color3.fromRGB(192,150,230)
    mini.Font=Enum.Font.SourceSans;mini.Size=UDim2.new(0,45,0,28)
    mini.Text="隐藏";mini.TextSize=14
    mini.Position=UDim2.new(0,44,-1,27)
    mini.AutoButtonColor=false

    -- 展开（隐藏后显示）
    local mini2 = Instance.new("TextButton")
    mini2.Name="minimize2";mini2.Parent=Frame
    mini2.BackgroundColor3=Color3.fromRGB(192,150,230)
    mini2.Font=Enum.Font.SourceSans;mini2.Size=UDim2.new(0,45,0,28)
    mini2.Text="+";mini2.TextSize=24
    mini2.Position=UDim2.new(0,44,-1,57)
    mini2.Visible=false
    mini2.AutoButtonColor=false

    -- 飞行开关逻辑
    onof.MouseButton1Click:Connect(safe(function()
        if flyActive then
            stopFly()
            onof.BackgroundColor3 = Color3.fromRGB(255,249,74)
            onof.Text = "飞行"
        else
            if startFly() then
                onof.BackgroundColor3 = Color3.fromRGB(80,255,80)
                onof.Text = "飞行中"
            end
        end
    end, "飞行开关"))

    -- 上按钮（按住上升）
    up.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
            flyUpHeld = true
            TweenService:Create(up,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(40,200,100)}):Play()
        end
    end)
    up.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
            flyUpHeld = false
            TweenService:Create(up,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(79,255,152)}):Play()
        end
    end)

    -- 下按钮（按住下降）
    down.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
            flyDownHeld = true
            TweenService:Create(down,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(180,220,80)}):Play()
        end
    end)
    down.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
            flyDownHeld = false
            TweenService:Create(down,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(215,255,121)}):Play()
        end
    end)

    -- 加速
    plus.MouseButton1Click:Connect(safe(function()
        flySpeed = math.min(flySpeed + 10, 300)
        speedLbl.Text = tostring(flySpeed)
    end, "飞行加速"))

    -- 减速
    mine.MouseButton1Click:Connect(safe(function()
        flySpeed = math.max(flySpeed - 10, 10)
        speedLbl.Text = tostring(flySpeed)
    end, "飞行减速"))

    -- 关闭面板
    closeBtn.MouseButton1Click:Connect(safe(function()
        if flyActive then stopFly() end
        FlyGui:Destroy(); FlyGui = nil
    end, "飞行面板关闭"))

    -- 隐藏
    mini.MouseButton1Click:Connect(function()
        up.Visible=false;down.Visible=false;onof.Visible=false
        plus.Visible=false;speedLbl.Visible=false;mine.Visible=false
        mini.Visible=false;mini2.Visible=true
        Frame.BackgroundTransparency=1
        closeBtn.Position=UDim2.new(0,0,-1,57)
    end)
    mini2.MouseButton1Click:Connect(function()
        up.Visible=true;down.Visible=true;onof.Visible=true
        plus.Visible=true;speedLbl.Visible=true;mine.Visible=true
        mini.Visible=true;mini2.Visible=false
        Frame.BackgroundTransparency=0
        closeBtn.Position=UDim2.new(0,0,-1,27)
    end)

    pcall(function() game:GetService("StarterGui"):SetCore("SendNotification",{Title="飞行面板",Text="已打开飞行面板",Duration=2}) end)
end

-- ============================================================
-- 【实时翻译 V11】
-- ============================================================
local translateEnabled = false
local translateConns = {}
local translateCache = {}

local function hasChinese(text)
    for i=1,#text do local c=string.byte(text,i); if c>=228 and c<=233 then return true end end
    return false
end

local function doTranslate(text, callback)
    local url = "https://api.mymemory.translated.net/get?q="..HttpService:UrlEncode(text).."&langpair=auto|zh-CN"
    task.spawn(function()
        local success, result = pcall(function() return game:HttpGet(url, true) end)
        if success and result then
            local ok, decoded = pcall(function() return HttpService:JSONDecode(result) end)
            if ok and decoded and decoded.responseData and decoded.responseData.translatedText then
                callback(decoded.responseData.translatedText, decoded.responseData.detectedLanguage)
            else callback(nil) end
        else callback(nil) end
    end)
end

local function showTranslateResult(plrName, original, translated, sourceLang)
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0,320,0,72)
    notif.Position = UDim2.new(1,-340,0,100 + #translateCache*80)
    notif.BackgroundColor3 = Color3.fromRGB(15,10,35)
    notif.BackgroundTransparency = 0.1; notif.BorderSizePixel = 0; notif.Parent = MainGui
    Instance.new("UICorner",notif).CornerRadius = UDim.new(0,10)
    local nb = Instance.new("UIStroke");nb.Thickness=1.5;nb.Color=Color3.fromRGB(80,180,255);nb.Transparency=0.3;nb.Parent=notif
    local t1=Instance.new("TextLabel");t1.Size=UDim2.new(1,-10,0,18);t1.Position=UDim2.new(0,10,0,5)
    t1.BackgroundTransparency=1;t1.Text="🌐 "..plrName..(sourceLang and "  ["..sourceLang.."]" or "")
    t1.TextColor3=Color3.fromRGB(120,200,255);t1.TextSize=12;t1.Font=Enum.Font.GothamBold
    t1.TextXAlignment=Enum.TextXAlignment.Left;t1.Parent=notif
    local t2=Instance.new("TextLabel");t2.Size=UDim2.new(1,-10,0,18);t2.Position=UDim2.new(0,10,0,22)
    t2.BackgroundTransparency=1;t2.Text=string.sub(original,1,50)
    t2.TextColor3=Color3.fromRGB(180,175,200);t2.TextSize=11;t2.Font=Enum.Font.Gotham
    t2.TextXAlignment=Enum.TextXAlignment.Left;t2.Parent=notif
    local t3=Instance.new("TextLabel");t3.Size=UDim2.new(1,-10,0,22);t3.Position=UDim2.new(0,10,0,42)
    t3.BackgroundTransparency=1;t3.Text="→ "..string.sub(translated,1,55)
    t3.TextColor3=Color3.fromRGB(120,255,170);t3.TextSize=12;t3.Font=Enum.Font.GothamBold
    t3.TextXAlignment=Enum.TextXAlignment.Left;t3.Parent=notif
    notif.BackgroundTransparency=1
    TweenService:Create(notif,TweenInfo.new(0.3),{BackgroundTransparency=0.1}):Play()
    task.delay(5,function()
        TweenService:Create(notif,TweenInfo.new(0.4),{BackgroundTransparency=1}):Play()
        for _,c in ipairs(notif:GetChildren()) do if c:IsA("TextLabel") then TweenService:Create(c,TweenInfo.new(0.4),{TextTransparency=1}):Play() end end
        task.wait(0.5);pcall(function() notif:Destroy() end)
    end)
end

local function handleChatMessage(plr, message)
    if not translateEnabled or plr==LocalPlayer or not message or #message<2 then return end
    if hasChinese(message) or translateCache[message] then return end
    translateCache[message]=true
    if #translateCache>30 then table.remove(translateCache,1) end
    doTranslate(message,function(translated,sourceLang)
        if translated and translated~=message then showTranslateResult(plr.Name,message,translated,sourceLang) end
    end)
end

local function setTranslate(v)
    translateEnabled=v
    if v then
        local c1=Players.PlayerChatted:Connect(function(plr,msg) handleChatMessage(plr,msg) end)
        table.insert(translateConns,c1)
        local TCS=game:GetService("TextChatService")
        if TCS and TCS.TextChannels then
            for _,ch in ipairs(TCS.TextChannels:GetChildren()) do
                if ch:IsA("TextChannel") then
                    local c2=ch.MessageReceived:Connect(function(msg)
                        local plr=Players:GetPlayerByUserId(msg.TextSource and msg.TextSource.UserId or 0)
                        if plr then handleChatMessage(plr,msg.Text) end
                    end)
                    table.insert(translateConns,c2)
                end
            end
            local c3=TCS.TextChannels.ChildAdded:Connect(function(ch)
                if ch:IsA("TextChannel") then
                    local c4=ch.MessageReceived:Connect(function(msg)
                        local plr=Players:GetPlayerByUserId(msg.TextSource and msg.TextSource.UserId or 0)
                        if plr then handleChatMessage(plr,msg.Text) end
                    end)
                    table.insert(translateConns,c4)
                end
            end)
            table.insert(translateConns,c3)
        end
        pcall(function() game:GetService("StarterGui"):SetCore("SendNotification",{Title="小贺脚本",Text="🌐 实时翻译已开启",Duration=3}) end)
    else
        for _,c in ipairs(translateConns) do pcall(function() c:Disconnect() end) end
        translateConns={}
        pcall(function() game:GetService("StarterGui"):SetCore("SendNotification",{Title="小贺脚本",Text="实时翻译已关闭",Duration=2}) end)
    end
end

-- ============================================================
-- 【防坠落 V11】
-- ============================================================
local antiFallEnabled=false;local antiFallConn=nil;local lastSafeCFrame=nil
local jumpProtectTime=0;local fallStartTime=nil
local function setAntiFall(v)
    antiFallEnabled=v
    if v then
        local root=getRoot();if root then lastSafeCFrame=root.CFrame end
        local jc=UserInputService.JumpRequest:Connect(function() jumpProtectTime=tick() end)
        antiFallConn=RunService.Heartbeat:Connect(safe(function()
            if flyActive then return end
            local root=getRoot();local hum=getHum()
            if not root or not hum then return end
            local vel=root.AssemblyLinearVelocity
            local onGround=hum.FloorMaterial~=Enum.Material.Air
            local now=tick()
            if onGround and vel.Magnitude<30 then lastSafeCFrame=root.CFrame;fallStartTime=nil;return end
            if now-jumpProtectTime<0.6 then fallStartTime=nil;return end
            local isFalling=hum:GetState()==Enum.HumanoidStateType.FreeFall
            if vel.Y<-90 and isFalling then
                if not fallStartTime then fallStartTime=now
                elseif now-fallStartTime>0.4 then
                    if lastSafeCFrame then
                        root.CFrame=lastSafeCFrame
                        root.AssemblyLinearVelocity=Vector3.new(0,0,0)
                        root.AssemblyAngularVelocity=Vector3.new(0,0,0)
                        fallStartTime=nil
                        pcall(function() game:GetService("StarterGui"):SetCore("SendNotification",{Title="小贺脚本",Text="🛡 防坠落已触发",Duration=2}) end)
                    end
                end
            else fallStartTime=nil end
        end, "防坠落"))
    else
        if antiFallConn then pcall(function() antiFallConn:Disconnect() end);antiFallConn=nil end
    end
end

-- ============================================================
-- 【人物自转 V11 · 速度可调节】
-- ============================================================
local spinEnabled=false;local spinConn=nil;local spinSpeed=0.06
local function setSpin(v)
    spinEnabled=v
    if v then
        spinConn=RunService.Heartbeat:Connect(safe(function()
            local root=getRoot();if not root or flyActive then return end
            root.CFrame=root.CFrame*CFrame.Angles(0,spinSpeed,0)
        end, "人物自转"))
    else
        if spinConn then pcall(function() spinConn:Disconnect() end);spinConn=nil end
    end
end

-- ============================================================
-- 【无限跳】
-- ============================================================
local ijConn=nil
local function setInfiniteJump(v)
    if v then
        ijConn=UserInputService.JumpRequest:Connect(safe(function()
            local h=getHum();if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
        end, "无限跳"))
    else
        if ijConn then pcall(function() ijConn:Disconnect() end);ijConn=nil end
    end
end

-- ============================================================
-- 【穿墙】
-- ============================================================
local ncConn=nil
local function setNoclip(v)
    if v then
        ncConn=RunService.Stepped:Connect(safe(function()
            local c=getChar();if not c then return end
            for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end
        end, "穿墙"))
    else
        if ncConn then pcall(function() ncConn:Disconnect() end);ncConn=nil end
        local c=getChar();if c then for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") and p.Name~="HumanoidRootPart" then p.CanCollide=true end end end
    end
end

-- ============================================================
-- 【ESP 透视 V11 · 距离可调节】
-- ============================================================
local espEnabled=false;local espBoxEnabled=true;local espTracerEnabled=true
local espInfoEnabled=true;local espHealthEnabled=true;local espTeamCheckEnabled=false
local espMaxDistance=300  -- V11新增：最大显示距离
local espGui=nil;local espRenderConn=nil;local espHighlightFolder=nil

local function createEspGui()
    local g=Instance.new("ScreenGui")
    g.Name="ESP_V11";g.IgnoreGuiInset=true;g.ResetOnSpawn=false
    g.DisplayOrder=800;g.ZIndexBehavior=Enum.ZIndexBehavior.Sibling;g.Parent=PlayerGui
    return g
end
local function isTeammate(plr)
    if not espTeamCheckEnabled then return false end
    if not plr.Team or not LocalPlayer.Team then return false end
    return plr.Team==LocalPlayer.Team
end
local function getCharacterBox(char)
    local cam=workspace.CurrentCamera
    local root=char:FindFirstChild("HumanoidRootPart");local head=char:FindFirstChild("Head")
    if not root then return nil end
    local topPart=head or root
    local bottomPos=root.Position-Vector3.new(0,3,0);local topPos=topPart.Position+Vector3.new(0,1.5,0)
    local bottomScreen,on1=cam:WorldToViewportPoint(bottomPos)
    local topScreen,on2=cam:WorldToViewportPoint(topPos)
    if not on1 and not on2 then return nil end
    if bottomScreen.Z<=0 or topScreen.Z<=0 then return nil end
    local height=math.abs(bottomScreen.Y-topScreen.Y)
    if height<5 then return nil end
    local width=height*0.55
    local cx=(bottomScreen.X+topScreen.X)/2;local cy=(bottomScreen.Y+topScreen.Y)/2
    return {x=cx-width/2,y=cy-height/2,w=width,h=height,centerX=cx,centerY=cy,bottomY=bottomScreen.Y,onScreen=on1 or on2}
end
local function drawLine(parent,x1,y1,x2,y2,color,thickness)
    local len=math.sqrt((x2-x1)^2+(y2-y1)^2)
    if len<1 then return nil end
    local angle=math.atan2(y2-y1,x2-x1)
    local f=Instance.new("Frame")
    f.Size=UDim2.new(0,len,0,thickness or 1);f.Position=UDim2.new(0,x1,0,y1)
    f.BackgroundColor3=color;f.BorderSizePixel=0;f.BackgroundTransparency=0.3
    f.Rotation=math.deg(angle);f.AnchorPoint=Vector2.new(0,0.5);f.Parent=parent
    return f
end
local function renderESP()
    if not espGui then return end
    for _,c in ipairs(espGui:GetChildren()) do if c:IsA("Frame") or c:IsA("TextLabel") then c:Destroy() end end
    local cam=workspace.CurrentCamera;local myRoot=getRoot()
    if not myRoot then return end
    for _,plr in ipairs(Players:GetPlayers()) do
        if plr==LocalPlayer or isTeammate(plr) then continue end
        local char=plr.Character;if not char then continue end
        local hum=char:FindFirstChildOfClass("Humanoid");local root=char:FindFirstChild("HumanoidRootPart")
        if not hum or not root then continue end
        -- V11：距离过滤
        local dist=(root.Position-myRoot.Position).Magnitude
        if dist>espMaxDistance then
            -- 超出距离的移除highlight
            if espHighlightFolder and espHighlightFolder:FindFirstChild(plr.Name) then
                pcall(function() espHighlightFolder[plr.Name]:Destroy() end)
            end
            continue
        end
        -- Highlight保底
        if espHighlightFolder and not espHighlightFolder:FindFirstChild(plr.Name) then
            local hl=Instance.new("Highlight")
            hl.Name=plr.Name;hl.FillColor=Color3.fromRGB(180,80,255)
            hl.FillTransparency=0.7;hl.OutlineColor=Color3.fromRGB(255,80,80)
            hl.OutlineTransparency=0;hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
            hl.Adornee=char;hl.Parent=espHighlightFolder
        end
        local box=getCharacterBox(char);if not box or not box.onScreen then continue end
        -- 方框
        if espBoxEnabled then
            local bf=Instance.new("Frame")
            bf.Size=UDim2.new(0,box.w,0,box.h);bf.Position=UDim2.new(0,box.x,0,box.y)
            bf.BackgroundTransparency=1;bf.BorderSizePixel=0;bf.Parent=espGui
            local bs=Instance.new("UIStroke");bs.Thickness=1.5;bs.Color=Color3.fromRGB(255,60,60)
            bs.Transparency=0.2;bs.Parent=bf
            -- 四角装饰
            local cornerLen=math.min(box.w,box.h)*0.2
            local corners={{box.x,box.y,1,1},{box.x+box.w,box.y,-1,1},{box.x,box.y+box.h,1,-1},{box.x+box.w,box.y+box.h,-1,-1}}
            for _,cp in ipairs(corners) do
                local cl=Instance.new("Frame");cl.Size=UDim2.new(0,cornerLen,0,2);cl.Position=UDim2.new(0,cp[1],0,cp[2])
                cl.BackgroundColor3=Color3.fromRGB(255,255,255);cl.BorderSizePixel=0;cl.AnchorPoint=Vector2.new(cp[3]<0 and 1 or 0,cp[4]<0 and 1 or 0);cl.Parent=espGui
            end
        end
        -- 追踪线
        if espTracerEnabled then
            local camSize=cam.ViewportSize
            drawLine(espGui,camSize.X/2,camSize.Y,box.centerX,box.bottomY,Color3.fromRGB(255,80,80),1)
        end
        -- 信息
        if espInfoEnabled then
            local info=Instance.new("TextLabel")
            info.Size=UDim2.new(0,box.w+40,0,16);info.Position=UDim2.new(0,box.x-20,0,box.y-18)
            info.BackgroundTransparency=1;info.Text=plr.Name..string.format("  %.0fm",dist)
            info.TextColor3=Color3.fromRGB(255,255,255);info.TextSize=11;info.Font=Enum.Font.Code
            info.TextXAlignment=Enum.TextXAlignment.Center;info.Parent=espGui
            if plr.Team then
                local teamLbl=Instance.new("TextLabel")
                teamLbl.Size=UDim2.new(0,box.w+40,0,14);teamLbl.Position=UDim2.new(0,box.x-20,0,box.y-34)
                teamLbl.BackgroundTransparency=1;teamLbl.Text="["..plr.Team.Name.."]"
                teamLbl.TextColor3=plr.Team.TeamColor.Color;teamLbl.TextSize=10;teamLbl.Font=Enum.Font.Code
                teamLbl.TextXAlignment=Enum.TextXAlignment.Center;teamLbl.Parent=espGui
            end
        end
        -- 血条
        if espHealthEnabled and hum.MaxHealth>0 then
            local hpPct=hum.Health/hum.MaxHealth
            local hpBg=Instance.new("Frame")
            hpBg.Size=UDim2.new(0,5,0,box.h);hpBg.Position=UDim2.new(0,box.x-10,0,box.y)
            hpBg.BackgroundColor3=Color3.fromRGB(40,40,40);hpBg.BorderSizePixel=0;hpBg.Parent=espGui
            local hpFg=Instance.new("Frame")
            hpFg.Size=UDim2.new(1,0,hpPct,0);hpFg.Position=UDim2.new(0,0,1-hpPct,0)
            hpFg.BackgroundColor3=hpPct>0.5 and Color3.fromRGB(80,255,80) or (hpPct>0.25 and Color3.fromRGB(255,200,0) or Color3.fromRGB(255,60,60))
            hpFg.BorderSizePixel=0;hpFg.Parent=hpBg
        end
    end
end
local function setESP(v)
    espEnabled=v
    if v then
        if not espGui then espGui=createEspGui() end
        if not espHighlightFolder then
            espHighlightFolder=Instance.new("Folder")
            espHighlightFolder.Name="ESP_Highlight";espHighlightFolder.Parent=game:GetService("CoreGui")
        end
        espRenderConn=RunService.RenderStepped:Connect(safe(renderESP,"ESP渲染"))
    else
        if espRenderConn then pcall(function() espRenderConn:Disconnect() end);espRenderConn=nil end
        if espGui then pcall(function() espGui:Destroy() end);espGui=nil end
        if espHighlightFolder then pcall(function() espHighlightFolder:Destroy() end);espHighlightFolder=nil end
    end
end

-- ============================================================
-- 【防甩飞 V11】
-- ============================================================
local antiKbEnabled=false;local antiKbConn=nil
local function setAntiKb(v)
    antiKbEnabled=v
    if v then
        antiKbConn=RunService.Heartbeat:Connect(safe(function()
            if flyActive then return end
            local root=getRoot();if not root then return end
            local vel=root.AssemblyLinearVelocity
            local angVel=root.AssemblyAngularVelocity
            if vel.Magnitude>150 or angVel.Magnitude>30 or vel.Y>200 then
                root.AssemblyLinearVelocity=Vector3.new(0,0,0)
                root.AssemblyAngularVelocity=Vector3.new(0,0,0)
                root.Anchored=true
                task.wait(0.35)
                if root and root.Parent then root.Anchored=false end
            end
        end,"防甩飞"))
    else
        if antiKbConn then pcall(function() antiKbConn:Disconnect() end);antiKbConn=nil end
    end
end

-- ============================================================
-- 【甩飞玩家 V11 · 高密度碰撞箱原理】
-- ============================================================
local function flingPlayer(targetPlr)
    local targetChar=targetPlr.Character
    if not targetChar then
        pcall(function() game:GetService("StarterGui"):SetCore("SendNotification",{Title="甩飞",Text="目标没有角色",Duration=2}) end)
        return
    end
    local targetRoot=targetChar:FindFirstChild("HumanoidRootPart")
    if not targetRoot then
        pcall(function() game:GetService("StarterGui"):SetCore("SendNotification",{Title="甩飞",Text="目标没有RootPart",Duration=2}) end)
        return
    end
    pcall(function() game:GetService("StarterGui"):SetCore("SendNotification",{Title="甩飞",Text="正在甩飞 "..targetPlr.Name.."...",Duration=2}) end)

    -- 创建高密度碰撞箱
    local hammer=Instance.new("Part")
    hammer.Name="FlingHammer";hammer.Size=Vector3.new(4,4,4)
    hammer.Anchored=true;hammer.CanCollide=true;hammer.CanTouch=true
    hammer.Transparency=0.5;hammer.Color=Color3.fromRGB(255,0,0)
    hammer.Material=Enum.Material.Neon
    -- 高密度物理属性
    local pp=PhysicalProperties.new(100,0.3,0.5,100,100)
    pcall(function() hammer.CustomPhysicalProperties=pp end)
    hammer.Parent=workspace

    -- 8方向高速撞击
    local directions={
        Vector3.new(1,0,0),Vector3.new(-1,0,0),
        Vector3.new(0,0,1),Vector3.new(0,0,-1),
        Vector3.new(1,0,1),Vector3.new(-1,0,-1),
        Vector3.new(1,0,-1),Vector3.new(-1,0,1)
    }
    task.spawn(function()
        for wave=1,3 do
            for _,dir in ipairs(directions) do
                if not targetRoot or not targetRoot.Parent then break end
                hammer.Position=targetRoot.Position+dir*6
                hammer.Velocity=dir*2500
                task.wait(0.03)
            end
            -- 直接速度注入补刀
            if targetRoot and targetRoot.Parent then
                pcall(function()
                    targetRoot.AssemblyLinearVelocity=Vector3.new(
                        math.random(-3000,3000),
                        math.random(2000,4000),
                        math.random(-3000,3000)
                    )
                end)
            end
            task.wait(0.1)
        end
        pcall(function() hammer:Destroy() end)
        pcall(function() game:GetService("StarterGui"):SetCore("SendNotification",{Title="甩飞",Text="甩飞完成: "..targetPlr.Name,Duration=2}) end)
    end)
end

-- ============================================================
-- 【传送玩家 V11】
-- ============================================================
local function teleportToPlayer(targetPlr)
    local targetChar=targetPlr.Character
    local myRoot=getRoot()
    if not targetChar or not myRoot then
        pcall(function() game:GetService("StarterGui"):SetCore("SendNotification",{Title="传送",Text="目标或自己没有角色",Duration=2}) end)
        return
    end
    local targetRoot=targetChar:FindFirstChild("HumanoidRootPart")
    if not targetRoot then
        pcall(function() game:GetService("StarterGui"):SetCore("SendNotification",{Title="传送",Text="目标没有RootPart",Duration=2}) end)
        return
    end
    -- 传送到目标旁边（不重叠）
    local offset=Vector3.new(math.random(-5,5),0,math.random(-5,5))
    myRoot.CFrame=CFrame.new(targetRoot.Position+offset)
    myRoot.AssemblyLinearVelocity=Vector3.new(0,0,0)
    pcall(function() game:GetService("StarterGui"):SetCore("SendNotification",{Title="传送",Text="已传送到 "..targetPlr.Name,Duration=2}) end)
end

-- ============================================================
-- 【FPS显示】
-- ============================================================
local fpsEnabled=false;local fpsConn=nil;local fpsLabel=nil
local function setFPS(v)
    fpsEnabled=v
    if v then
        fpsLabel=Instance.new("TextLabel")
        fpsLabel.Size=UDim2.new(0,120,0,30);fpsLabel.Position=UDim2.new(0,10,0,10)
        fpsLabel.BackgroundColor3=Color3.fromRGB(0,0,0);fpsLabel.BackgroundTransparency=0.5
        fpsLabel.Text="FPS: --";fpsLabel.TextColor3=Color3.fromRGB(0,255,0)
        fpsLabel.TextSize=14;fpsLabel.Font=Enum.Font.Code;fpsLabel.Parent=MainGui
        Instance.new("UICorner",fpsLabel).CornerRadius=UDim.new(0,6)
        local lastTime=tick();local frames=0
        fpsConn=RunService.RenderStepped:Connect(function()
            frames=frames+1
            local now=tick()
            if now-lastTime>=1 then
                fpsLabel.Text="FPS: "..frames
                frames=0;lastTime=now
            end
        end)
    else
        if fpsConn then pcall(function() fpsConn:Disconnect() end);fpsConn=nil end
        if fpsLabel then pcall(function() fpsLabel:Destroy() end);fpsLabel=nil end
    end
end

-- ============================================================
-- 【构建标签页】
-- ============================================================

-- 标签1：主页
addTabBtn("主页",1)
local tabHome=createTab("主页")
addPara(tabHome,"作者","小贺")
addPara(tabHome,"版本","V11 · 全功能优化版")
addPara(tabHome,"QQ群","1104880878")
addLabel(tabHome,"此脚本完全免费，禁止倒卖")
addLabel(tabHome,"执行器: "..identifyexecutor())
addLabel(tabHome,"用户名: "..LocalPlayer.Name)
addBtn(tabHome,"关闭全部功能",function()
    setESP(false);setAntiFall(false);setSpin(false);setInfiniteJump(false)
    setNoclip(false);setAntiKb(false);setTranslate(false);setFPS(false)
    if flyActive then stopFly() end
    pcall(function() game:GetService("StarterGui"):SetCore("SendNotification",{Title="小贺脚本",Text="已关闭全部功能",Duration=2}) end)
end)

-- 标签2：移动
addTabBtn("移动",2)
local tabMove=createTab("移动")
addBtn(tabMove,"飞行面板",createFlyPanel)
addToggle(tabMove,"无限跳",false,setInfiniteJump)
addToggle(tabMove,"穿墙",false,setNoclip)
addToggle(tabMove,"防坠落",false,setAntiFall)
addToggle(tabMove,"人物自转",false,setSpin)
addSlider(tabMove,"自转速度",1,20,6,function(v) spinSpeed=v/100 end)
addSlider(tabMove,"移动速度",16,200,16,function(v)
    local h=getHum();if h then h.WalkSpeed=v end
end)
addSlider(tabMove,"跳跃高度",50,300,50,function(v)
    local h=getHum();if h then h.JumpPower=v end
end)
addSlider(tabMove,"重力设置",0,300,196,function(v)
    workspace.Gravity=v
end)

-- 标签3：战斗
addTabBtn("战斗",3)
local tabCombat=createTab("战斗")
addBtn(tabCombat,"甩飞玩家",function()
    selectPlayer(function(p) flingPlayer(p) end,"选择要甩飞的玩家")
end)
addBtn(tabCombat,"传送玩家",function()
    selectPlayer(function(p) teleportToPlayer(p) end,"选择要传送的目标")
end)
addToggle(tabCombat,"防甩飞",false,setAntiKb)
addBtn(tabCombat,"自杀/重置",function()
    local h=getHum();if h then h.Health=0 end
end)
addBtn(tabCombat,"清空背包",function()
    local c=getChar();if c then
        for _,item in ipairs(c:GetChildren()) do
            if item:IsA("Tool") then item:Destroy() end
        end
        local bp=LocalPlayer:FindFirstChild("Backpack")
        if bp then for _,item in ipairs(bp:GetChildren()) do if item:IsA("Tool") then item:Destroy() end end end
    end
end)
addSlider(tabCombat,"人物大小",0.5,3,1,function(v)
    local h=getHum();if h then
        h.BodyHeightScale.Value=v
        h.BodyWidthScale.Value=v
        h.BodyDepthScale.Value=v
        h.HeadScale.Value=v
    end
end)

-- 标签4：透视
addTabBtn("透视",4)
local tabEsp=createTab("透视")
addToggle(tabEsp,"透视总开关",false,setESP)
addToggle(tabEsp,"显示方框",true,function(v) espBoxEnabled=v end)
addToggle(tabEsp,"显示追踪线",true,function(v) espTracerEnabled=v end)
addToggle(tabEsp,"显示信息",true,function(v) espInfoEnabled=v end)
addToggle(tabEsp,"显示血条",true,function(v) espHealthEnabled=v end)
addToggle(tabEsp,"队伍检测(只透视敌人)",false,function(v) espTeamCheckEnabled=v end)
addSlider(tabEsp,"透视最大距离",50,1000,300,function(v) espMaxDistance=v end)
addLabel(tabEsp,"提示：距离越远性能消耗越大")

-- 标签5：渲染
addTabBtn("渲染",5)
local tabRender=createTab("渲染")
addToggle(tabRender,"全亮夜视",false,function(v)
    if v then
        game.Lighting.Ambient=Color3.new(1,1,1)
        game.Lighting.OutdoorAmbient=Color3.new(1,1,1)
        game.Lighting.Brightness=3
    else
        game.Lighting.Ambient=Color3.new(0,0,0)
        game.Lighting.OutdoorAmbient=Color3.new(0.5,0.5,0.5)
        game.Lighting.Brightness=1
    end
end)
addToggle(tabRender,"FPS显示",false,setFPS)
addSlider(tabRender,"FOV视野",50,120,70,function(v)
    workspace.CurrentCamera.FieldOfView=v
end)
addBtn(tabRender,"时间-白天",function() game.Lighting.ClockTime=12 end)
addBtn(tabRender,"时间-黑夜",function() game.Lighting.ClockTime=0 end)
addBtn(tabRender,"画质-最低",function()
    settings().Rendering.QualityLevel=Enum.QualityLevel.Level01
end)
addBtn(tabRender,"画质-最高",function()
    settings().Rendering.QualityLevel=Enum.QualityLevel.Level21
end)

-- 标签6：翻译
addTabBtn("翻译",6)
local tabTrans=createTab("翻译")
addToggle(tabTrans,"实时翻译开关",false,setTranslate)
addPara(tabTrans,"说明","开启后自动识别聊天中的外语并翻译成中文")
addPara(tabTrans,"支持语言","英语、日语、韩语、法语、德语、西班牙语等")
addLabel(tabTrans,"翻译来源：MyMemory 免费API")
addLabel(tabTrans,"每日免费额度约5000字符")

-- 标签7：外部脚本
addTabBtn("外部脚本",7)
local tabExt=createTab("外部脚本")
addLabel(tabExt,"以下功能通过加载外部脚本实现")
addLabel(tabExt,"需要执行器开启Http请求权限")
local extScripts={
    {"光影","https://pastebin.com/raw/arzRCgwS"},
    {"画质","https://pastebin.com/raw/jHBfJYmS"},
    {"旋转","https://pastebin.com/raw/r97d7dS0"},
    {"飞车","https://pastebin.com/raw/MHE1cbWF"},
    {"工具挂","https://raw.githubusercontent.com/Bebo-Mods/BeboScripts/main/StandAwekening.lua"},
    {"人物无敌","https://pastebin.com/raw/H3RLCWWZ"},
    {"速度更改","https://pastebin.com/raw/Zuw5T7DP"},
    {"爬墙","https://pastebin.com/raw/zXk4Rq2r"},
    {"动作","https://pastebin.com/raw/Zj4NnKs6"},
    {"电脑键盘","https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt"},
    {"铁拳","https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt"},
    {"吸取全部玩家","https://pastebin.com/raw/hQSBGsw2"},
    {"死亡笔记","https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%AD%BB%E4%BA%A1%E7%AC%94%E8%AE%B0%20(1).txt"},
    {"甩人","https://pastebin.com/raw/zqyDSUWX"},
    {"踏空","https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float"},
    {"无限跳(外部)","https://pastebin.com/raw/V5PQy3y0"},
}
for _,s in ipairs(extScripts) do
    addBtn(tabExt,s[1],function()
        pcall(function()
            loadstring(game:HttpGet(s[2],true))()
            game:GetService("StarterGui"):SetCore("SendNotification",{Title="外部脚本",Text=s[1].." 已加载",Duration=2})
        end)
    end)
end

-- 默认打开主页
switchTab("主页")

print("✦ 小贺脚本 V11 启动完成 ✦")
print("QQ交流群：1104880878")
