;===============================================================================================
;                                            TEAM HYPER STATES 
;===============================================================================================
;Team Hyper p1 (if you want a taunt or something before the team hyper superpause)
;we are not using the taunt so we are going straight to state 4600
[Statedef 4599]  
type = A
movetype = I
physics = N
sprpriority = 0
velset = 0,0
ctrl = 0

[State 4599]
type = Changeanim
trigger1 = time = 0
value = 4599

[State 4599, position]
type=PosSet
trigger1=time=0
y=0

[State 4599, velocity]
type=VelSet
trigger1=1
x=0
y=0

[State 4599, Corner Push]
type= varset
trigger1= fvar(5)
trigger1= time<=20
fvar(5)= 0

[State 4599,]
type = ChangeState
trigger1 = animtime = 0
value = 4600

;===============================================================
;Team Hyper P1 Superpause State And Wait For Partner To Jump Onscreen (The team Hyper startup for P1)
[Statedef 4600]
type = S
movetype = I
physics = S
sprpriority = 0
velset = 0,0
ctrl = 0
poweradd = -1000

[State 4600]
type = Changeanim
trigger1 = time = 0
value = 4600

[State 4600]
type=velset
trigger1=1
x=0
y=0

[State 4600]
type=posset
trigger1=1
y=0

[State 4600, Corner Push]
type= varset
trigger1= fvar(5)
trigger1= time<=20
fvar(5)= 0

[State 4600]
type=PlaySnd
trigger1=time=0
value=3000,0

[state 4600,HYPER STARTUP FX]
type =explod
triggerall = numexplod(6000) = 0
trigger1 = time = 0
anim=6050
ID=6050
postype =P1
pos=-17,-89
sprpriority=4
ownpal=1
bindtime=-1
supermove=1
pausemovetime=-1
removeongethit=1
scale=.6,.6
persistent=0

[State 4600, invincibility] 
type = NotHitBy
trigger1 = 1
time = 1
value = SCA

[State 4600, ghost]
type = PlayerPush
trigger1 = 1
value = 0

[State 4600, end state]
type = ChangeState
trigger1 = time = 1
value = 4601

;===============================================================
;Team Hyper Attack State (team Hyper state for P1)
[Statedef 4601]
type    = S
movetype= A
physics = S
ctrl = 0
sprpriority = 0

[State 4601]
type =null; Changeanim
trigger1 = time = 0
value = 4601

[State 4601, Reset DHC]
type= varset
trigger1= var(57)
trigger1= 1
var(57)= 0

[State 4601, NotHitBy]
type = NotHitBy
trigger1 = Time = 0
time = 25
value = SCA, NA, SA, HA, NT, ST, HT, HP
ignorehitpause = 1

[State 4601, HyperBg DHC Gold]
type=Explod
trigger1=time=1
anim=8201
pos=320,0
id=8200
sprpriority=-4
pausemovetime=-1
supermovetime=-1
postype =back
bindtime =-1
removetime =999
removeongethit=1
scale=1.02,1
facing=-1
shadow=68,68,255
ownpal=1
ignorehitpause=1

[State 4601, Remove Explod]
type = RemoveExplod
trigger1 = numhelper(9600)
trigger2 = Time=120||movetype=H
id = 8200

[State 4601, AssertSpecial]
type = AssertSpecial
trigger1 = 1
flag = noFG
flag2 = noBG
flag3 = NoBarDisplay
ignorehitpause = 1

[State 4601]
type=PlaySnd
trigger1=AnimElem=2
value=2,67;;8
channel=2

[State 4601]
type=NotHitBy
Trigger1=time>=8&&time<21
value=SCA
Time=1

[State 4601]
type=Screenbound
trigger1=animelem>=60
value=0

[State 4601]
type = nothitby
trigger1 = numhelper(3051) = 1
value = SCA, NA, SA, HA, NT, ST, HT, NP, SP, HP
time = 10

[State 4601]
type = ChangeState
trigger1 = time = 120;;;;;;;;this time stops the team hyper attack(leave this at 120, DO NOT CHANGE)
value = 4511;;;;4602 if you want p1 to have a taunt after team hyper before he jumps offscreen use 4602
ctrl = 0

;===============================================================
;Team Hyper Ending Taunt(This Player Jumps Off Screen after team Hyper)
[Statedef 4602]
type    = S
movetype= I
physics = S
ctrl = 0
anim = 4602

[state 4602]
type = changestate
trigger1 = animtime = 0
value = 4511

;===============================================================
;Team Hyper P3 Jumps Onscreens from state 4511
[Statedef 4700]
type    = s
movetype= a
physics = N
velset = 0,0
anim = 4700
ctrl = 0
sprpriority=2
poweradd = -1000

[state 4700, TEAM HYPER PAUSE P3]
type = pause
trigger1 = time = 0
time = 48
movetime = 16
pausebg = 0
ignorehitpause = 1

[State 4700, screen bound] ; Prevents the camera from following the char
type = ScreenBound
trigger1 = 1
value = 0

[State 4700, position]
type = Posset
triggerall = NumPartner = 1
trigger1 = time = 0
trigger1 = facing = 1
x = (NumPartner && partner, pos x) - 257
y = -130 

[State 4700, position]
type = Posset
trigger1 = time = 0
trigger1 = facing = -1
x = (NumPartner && partner, pos x) + 257
y = -130 

[State 4700, position]
type = Posadd
trigger1 = 1
x = 13

[State 4700, velocity]
type = VelSet
trigger1 = time = 0
y = 3

[State 4700, velocity]
type = Veladd
trigger1 = 1
y = .7

[State 4700]
type = ChangeState
trigger1 = pos y >= 0 
value = 4701

;===============================================================
;Team Hyper Attack State (team Hyper state for P3)
[Statedef 4701]
type    = S
movetype= A
physics = S
ctrl = 0
velset = 0,0
anim = 4701
sprpriority=2

[State 4701]
type = posset
trigger1 = time = 0
y = 0 

[State 4701, Reset DHC]
type= varset
trigger1= var(57)
trigger1= 1
var(57)= 0

[State 4701]
type = NotHitBy
trigger1 = Time = 0
time = 25
value = SCA, NA, SA, HA, NT, ST, HT, HP
ignorehitpause = 1

[State 4701]
type=PlaySnd
trigger1=AnimElem=2
value=2,67;;8
channel=2

[State 4701]
type=NotHitBy
Trigger1=time>=8&&time<21
value=SCA
Time=1

[State 4701]
type=Screenbound
trigger1=animelem>=60
value=0

[State 4701]
type = nothitby
trigger1 = numhelper(3051) = 1
value = SCA, NA, SA, HA, NT, ST, HT, NP, SP, HP
time = 10

[State 4701]
type = ChangeState
triggerall = NumPartner = 1
trigger1 = NumPartner && partner,stateno=4511;;;;time = 120;;;;;;;;this time stops the team hyper attack(leave this at 120, DO NOT CHANGE)
value = 4702;;;;;;;;;;;;0 if you want p1 to have a taunt after team hyper while his partner jumps offscreen use 4702
ctrl = 0

;===============================================================
;Team Hyper Ending Taunt or Cool Down Animation (This Player Stays On Screen after team Hyper)
[Statedef 4702]
type    = S
movetype= I
physics = S
ctrl = 0
anim =4702

[State 4702, Break Glass Explod]
type = Explod
trigger1 = !winko
trigger1 = time=0&&numexplod(8205)=0
anim = 8205
ID = 8205
pos = 0,0
postype = left
facing = 1
vfacing = 1
bindtime = -1
removetime = -2
scale = 1,1
sprpriority = 4
ontop = 0
ownpal = 0
removeongethit = 0

[State 4702, Break Glass Sound]
type = PlaySnd
trigger1 = !winko
trigger1 = time=0
value = 8205,0
volume = 100
channel = -1
freqmul = 1.0

[State 4702]
type = ChangeState
triggerall = NumPartner = 1
triggerall = NumPartner && partner, movetype != A
trigger1 = animtime = 0
trigger2 = anim = 0
value = 0
ctrl = 1
