;========================<BLOOD>=============================
;---Small---
[Statedef 8050]
type=A
anim=9741
velset=0,0

[State 8050, Small]
type=explod
trigger1= !time
anim=8050
ID=8050
postype=p1
vel= -3+(random/166.7), -7.5-(random/400.0)
accel= 0, .5
facing= ifelse(random<500, -1, 1)
vfacing=ifelse(random<500, -1, 1)
trans=addalpha
alpha=256,128
sprpriority=5
scale=.5,.5
ownpal=1
[State 8050, Small]
type=explod
trigger1= !time
anim=8050
ID=8050
postype=p1
vel= -3+(random/166.7),-7.5-(random/400.0)
accel= 0, .5
facing= ifelse(random<500, -1, 1)
vfacing=ifelse(random<500, -1, 1)
trans=addalpha
alpha=256,128
sprpriority=5
scale=.5,.5
ownpal=1
[State 8050, Small]
type=explod
trigger1= !time
anim=8050
ID=8050
postype=p1
vel= -3+(random/166.7), -7.5-(random/400.0)
accel= 0, .5
facing= ifelse(random<500, -1, 1)
vfacing=ifelse(random<500, -1, 1)
trans=addalpha
alpha=256,128
sprpriority=5
scale=.5,.5
ownpal=1

[State 8050, End]
type=destroyself
trigger1= 1


;---Medium---
[Statedef 8051]
type=A
anim=9741
velset=0,0

[State 8051, Medium]
type=explod
trigger1= !time
anim=8051
ID=8050
postype=p1
vel= -10+(random/50.0), -5-(random/200.0)
accel= 0, .5
facing= ifelse(random<500, -1, 1)
vfacing=ifelse(random<500, -1, 1)
trans=addalpha
alpha=256,128
sprpriority=5
scale=.5,.5
ownpal=1

[State 8051, Small]
type=explod
trigger1= !time
anim=8050
ID=8050
postype=p1
vel= -4+(random/125.0), -7.5-(random/400.0)
accel= 0, .5
facing= ifelse(random<500, -1, 1)
vfacing=ifelse(random<500, -1, 1)
trans=addalpha
alpha=256,128
sprpriority=5
scale=.5,.5
ownpal=1
[State 8051, Small]
type=explod
trigger1= !time
anim=8050
ID=8050
postype=p1
vel= -4+(random/125.0), -7.5-(random/400.0)
accel= 0, .5
facing= ifelse(random<500, -1, 1)
vfacing=ifelse(random<500, -1, 1)
trans=addalpha
alpha=256,128
sprpriority=5
scale=.5,.5
ownpal=1
[State 8051, Small]
type=explod
trigger1= !time
anim=8050
ID=8050
postype=p1
vel= -4+(random/125.0), -7.5-(random/400.0)
accel= 0, .5
facing= ifelse(random<500, -1, 1)
vfacing=ifelse(random<500, -1, 1)
trans=addalpha
alpha=256,128
sprpriority=5
scale=.5,.5
ownpal=1

[State 8051, End]
type=destroyself
trigger1= 1


;---Large---
[Statedef 8052]
type=A
anim=9741
velset=0,0

[State 8052, Large]
type=explod
trigger1= !time
anim=8052
ID=8050
postype=p1
vel= -(random/333.3), -2.5-(random/400.0)
accel= 0, .25
trans=addalpha
alpha=256,128
sprpriority=5
scale=.5,.5
ownpal=1

[State 8052, Medium]
type=explod
trigger1= !time
anim=8051
ID=8050
postype=p1
vel= -10+(random/50.0), -5-(random/200.0)
accel= 0, .5
facing= ifelse(random<500, -1, 1)
vfacing=ifelse(random<500, -1, 1)
trans=addalpha
alpha=256,128
sprpriority=5
scale=.5,.5
ownpal=1
[State 8052, Medium]
type=explod
trigger1= !time
anim=8051
ID=8050
postype=p1
vel= -10+(random/50.0), -5-(random/200.0)
accel= 0, .5
facing= ifelse(random<500, -1, 1)
vfacing=ifelse(random<500, -1, 1)
trans=addalpha
alpha=256,128
sprpriority=5
scale=.5,.5
ownpal=1

[State 8052, Small]
type=explod
trigger1= !time
anim=8050
ID=8050
postype=p1
vel= -5+(random/100.0), -7.5-(random/400.0)
accel= 0, .5
facing= ifelse(random<500, -1, 1)
vfacing=ifelse(random<500, -1, 1)
trans=addalpha
alpha=256,128
sprpriority=5
scale=.5,.5
ownpal=1
[State 8052, Small]
type=explod
trigger1= !time
anim=8050
ID=8050
postype=p1
vel= -5+(random/100.0), -7.5-(random/400.0)
accel= 0, .5
facing= ifelse(random<500, -1, 1)
vfacing=ifelse(random<500, -1, 1)
trans=addalpha
alpha=256,128
sprpriority=5
scale=.5,.5
ownpal=1
[State 8052, Small]
type=explod
trigger1= !time
anim=8050
ID=8050
postype=p1
vel= -5+(random/100.0), -7.5-(random/400.0)
accel= 0, .5
facing= ifelse(random<500, -1, 1)
vfacing=ifelse(random<500, -1, 1)
trans=addalpha
alpha=256,128
sprpriority=5
scale=.5,.5
ownpal=1

[State 8052, End]
type=destroyself
trigger1= 1

;---------------------------------------------------------------------------
; Liedown Roll Forward (Author MystikBlaze)
[Statedef 8300]
type    = C
movetype= I
physics = N
poweradd= 0
velset = 12,0
ctrl = 0
anim = 831
sprpriority = -1

[State 8300, PlayerPush]
type = PlayerPush
trigger1 = Time >= 0
value = 0

[State 8300, VelSet]
type = VelSet
trigger1 = AnimTime = 0
x = 0

[State 8300, PosSet]
type = PosSet
trigger1 = Time >= 0
y = 0

[State 8300, MakeDust]
type = MakeDust
trigger1 = Time >= 0
pos = -16,0
spacing = 6

[State 8300, NotHitBy]
type = NotHitBy
trigger1 = 1
value = SCA
time = 1

[State 8300, sound]
type = PlaySnd
trigger1 = AnimElem = 5
value = 30,2

[State 8300, ChangeState]
type = ChangeState
trigger1 = AnimTime = 0
value = 8301
ctrl = 1

[Statedef 8301]
type    = C
movetype= I
physics = N
poweradd= 0
velset = 2,0
ctrl = 0
anim = 835
sprpriority = -1

[State 8301, ChangeState]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

; Liedown Roll Backwards (Author MystikBlaze)
[Statedef 8305]
type    = C
movetype= I
physics = N
poweradd= 0
velset = -12,0
ctrl = 0
anim = 832
sprpriority = -1

[State 8305, PlayerPush]
type = PlayerPush
trigger1 = Time >= 0
value = 0

[State 8305, VelSet]
type = VelSet
trigger1 = AnimTime = 0
x = 0

[State 8305, PosSet]
type = PosSet
trigger1 = Time >= 0
y = 0

[State 8305, MakeDust]
type = MakeDust
trigger1 = Time >= 0
pos = -16,0
spacing = 6

[State 8305, NotHitBy]
type = NotHitBy
trigger1 = 1
value = SCA
time = 1

[State 8305, sound]
type = PlaySnd
trigger1 = AnimElem = 5
value = 30,2

[State 8305, ChangeState]
type = ChangeState
trigger1 = AnimTime = 0
value = 8302
ctrl = 1

[Statedef 8302]
type    = C
movetype= I
physics = N
poweradd= 0
velset = -2,0
ctrl = 0
anim = 835
sprpriority = -1

[State 8301, ChangeState]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;----------------------------------------
; Land FX - Thanx Loganir
[Statedef 8706]
type = S
movetype = I
physics = N
anim = 9999
sprpriority = -7

[State 8706, A0]
type = screenbound
trigger1 = 1
value = 0

[state 8706, a1]
type = assertspecial
trigger1 = 1
flag = noshadow

[State 0, Explod]
type = Explod
trigger1 = !time
anim = 7510
ID = 7510
pos = 0,15
postype = p1  ;p2,front,back,left,right
facing = 1
sprpriority = -20
ownpal = 1
ignorehitpause = 1

[State 8706 Explod]
type = Explod
trigger1 = time <= 5
anim = 23052+random%6
id = 8706
pos = 0,0
postype = p1
bindtime = 1
vel = (IfElse(Random <= 499,Random/120,Random/(-120))),Random/(-120)
accel = 0,.5
removetime = 60
supermovetime = 999
pausemovetime = 999
;scale = IfElse(Random <= 499,.4,.2),IfElse(Random <= 499,.4,.2)
sprpriority = 8

[State 8706, a6]
type = destroyself
trigger1 = (time>=9)

;---------------------------------------------------------------------------
; Hit Overrides and Extra States
;---------------------------------------------------------------------------
[StateDef 9000]
type = S
movetype= H
physics = S


[State 9000, End]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1


;-----------------------------------------------------------------------
;Hyper FX
[Statedef 96000]
type = S
movetype = I
physics = N
anim = 9999

[state 8010,1]
type = palfx
trigger1 = 1
time = 1
add = ifelse(time>128,0,-256+time*2),ifelse(time>128,0,-256+time*2),ifelse(time>128,0,-256+time*2)

[State 0, AssertSpecial]
type = AssertSpecial
trigger1 = 1
flag = NoBG
flag2= NoFg
flag3= NoBarDisplay
ignorehitpause = 1

[State 0, Explod]
type = Explod
trigger1 = !time
anim = 7710
ID = 7005
pos = 160,120
postype = back  ;p2,front,back,left,right
bindtime = -1
vel = 0,0
accel = 0,0
random = 0,0
removetime = -1
supermovetime = 0
pausemovetime = 0
sprpriority = -115
under = 1
ownpal = 1
scale=0.5,0.75;1.25

[State 0, Explod]
type = Explod
trigger1 = !time
anim = 7711
ID = 7005
pos = 160,120
postype = back  ;p2,front,back,left,right
bindtime = -1
vel = 0,0
accel = 0,0
random = 0,0
removetime = -1
supermovetime = 0
pausemovetime = 0
sprpriority = 9999
ownpal = 1
scale=0.75,1;1.25,1.55


[State 0, RemoveExplod]
type = RemoveExplod
trigger1 = root,NumHelper(9700)=1
id = 7005

[State 0, ChangeState]
type = DestroySelf
trigger1 = root,NumHelper(9700)=1

[State 0, Listras2]
type = null;Explod
trigger1 = 1
anim = 8604
ID = 8603
pos = -20,120
postype = back
vel = 8,0
accel = 2,0
random = 0,200
removetime = -2
scale = 1,ifelse(random<500,1.5,1)
supermovetime = 9999999
pausemovetime = 9999999
ontop = 1
ownpal = 1
removeongethit = 1
supermove = 1
sprpriority = -3

[State 0, Listras3]
type = null;Explod
trigger1 = time%3=0
anim = 8604
ID = 8603
pos = 0,120
postype = back
vel = 12,0
accel = 8,0
random = 0,200
removetime = -2
scale = 0.5,0.5
supermovetime = 9999999
pausemovetime = 9999999
ontop = 1
ownpal = 1
removeongethit = 1
supermove = 1
sprpriority = -200



[State 0, ChangeState]
type = ChangeState
trigger1 = root, MoveType = H || root,Stateno <3000
value =  96010
ctrl = 0


;-----------------------------------------------------------------------
;Hyper FX end
[Statedef 96010]
type = S
movetype = I
physics = N
anim = 9999

[State 0, PalFXWiz]
type = AllPalFX
triggerAll = root,NumHelper(8400)=0
trigger1 = !time
time = 20
add = 255,255,255
mul = 256,256,256
sinadd = -255,-255,-255,80
invertall = 0
color = 256

[State 0, PlaySnd]
type = PlaySnd
trigger1 =!time
value = S9600,0

[state 8010]
type = modifyexplod
trigger1 = 1
id = 7005
scale = 1.0,1.0+time/-15.0
trans = add




[State 0, RemoveExplod]
type = RemoveExplod
trigger1 = time = 15
id = 7005
;ignorehitpause = 
;persistent = 



[State 0, DestroySelf]
type = DestroySelf
trigger1 = time = 16

;-----------------------------------------------------------------------
;Hyper combo Finish
[Statedef 9700]
type = S
movetype = I
physics = N
anim = 9999 ;Invisible anim.

[State 0, AssertSpecial]
type = AssertSpecial
trigger1 = 1
flag = nobardisplay
flag2 = nomusic

[State 8400: EnvColor]
type = EnvColor
trigger1 = time < 60
value = 0,0,0
time = 1
under = 1

[State 8400: EnvShake]
type = EnvShake
trigger1 = (!Time)
time = 12
freq = 120
ampl = -3
phase = 90

[State 3315, 15]
type = Explod
trigger1 = !Time
ID = 8400
anim = 17000
postype = Back
pos = 160,120
sprpriority = -10
ignorehitpause = 1
bindtime = -1
removetime = 120


[State 3315, 15]
type = Explod
trigger1 = !Time
ID = 8400
anim = 17002
postype = Back
pos = 160,120
sprpriority = -10
ignorehitpause = 1
bindtime = -1
removetime = 120


[State 0, PalFXWiz]
type = PalFX
trigger1 = Time = 60
time = 120
add = 0,0,0
mul = 256,256,256
sinadd = -255,-255,-255,240
invertall = 0
color = 256


[State 3315, 16]
type = PlaySnd
trigger1 = (NumExplod(8400) != 0)
value = s8700,0
persistent = 0
ignorehitpause = 1

;-----------------------------------------------------------------------
;Super combo Finish
[Statedef 8420]
type = S
movetype = I
physics = N
anim = 9999 ;Invisible anim.

[State 8400: Pause]
type = Pause
trigger1 = (!Time)
time = 12
movetime = 12

[State 8400: EnvColor]
type = EnvColor
trigger1 = (Time < 12)
value = (Time*4),(Time*4),(Time*4)
time = 1
under = 1

[State 0, RemoveExplod]
type = RemoveExplod
trigger1 = !time
id = 7005

[State 8400: EnvShake]
type = EnvShake
trigger1 = (!Time)
time = 12
freq = 120
ampl = -3
phase = 90

[State 8400: AllPalFX]
type = AllPalFX
trigger1 = (Time < 50)
time = 1
add = 0,0,0
mul = 256,256,256
sinadd = 0,0,0,1
invertall = 0
color = (Time*5)

[State 3315, 15]
type = Explod
trigger1 = !Time
ID = 8420
anim = 8420
postype = Back
pos = 0,0
sprpriority = -10
ownpal = 1
ignorehitpause = 1
bindtime = -1
removetime = -2
supermove=9999
pausemove=9999

[State 3315, 16]
type = PlaySnd
trigger1 = Time = 50
value = s9999,6


[State -3, 1]
type = RemoveExplod
trigger1 = RoundState = 4
ID = 8420

;-----------------------------------------------------------------------
;Fake stomp
[Statedef 8425]
type = S
movetype = I
physics = N
anim = 9999 ;Invisible anim.

[State 0, VelSet]
type = VelSet
trigger1 = !time
x = root, Var(5)
y = root, Var(6)

[State 885,End]
type = ChangeState
trigger1 = Vel Y > 0 && Pos Y >= 0;-15
value = 8435

;-----------------------------------------------------------------------
;Fake stomp land
[Statedef 8435]
type = S
movetype = I
physics = N
anim = 9999 

[State 100, 8]
type = EnvShake
trigger1 = !time
time = 15
ampl = -10

[State 777, hsp]
type = helper
trigger1 = !time
helpertype = normal
stateno = 8706
ID = 8706
name = "effect"
postype = p1
pos = 0,-15
facing = -1
supermovetime = 999
pausemovetime = 999
ignorehitpause = 1
ownpal = 1

[State 802, PlaySnd]
type = PlaySnd
trigger1 =!time
value = s8200,1

[State 0, DestroySelf]
type = DestroySelf
trigger1 = !time
;ignorehitpause = 
;persistent = 

