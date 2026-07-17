;=========================================================================================
;                                  DELAYED HYPER COMBO STATES
;=========================================================================================
;THESE ARE THE DELAYED HYPER COMBO STATES, THEY MUST BE WITHIN 4400-4499, STATENO 4401 IS
;WHERE THE ACTUAL DHC CHANGESTATES ARE LOCATED.

;Delayed Hyper Combo P3 Jumps Onscreens from state 4512
[Statedef 4400]
type    = S
movetype= A
physics = N
velset = 0,0
ctrl = 0
sprpriority=3
poweradd = -1000

[State 4400, AssertSpecial]
type = AssertSpecial
trigger1 =1
flag = noFG
flag2 = noBG
flag3 = NoBarDisplay
ignorehitpause = 1

; In case the character does have the anim 4700.
[State 4400]
type=ChangeAnim
triggerall=SelfAnimExist(4400)
trigger1=time=0
value=4400
persistent=0

; In case the character doesn't have the anim 4700 it will use your jumping forward anim 42
[State 4400]
type=ChangeAnim
triggerall=!SelfAnimExist(4400)
trigger1=time=0
value=42                         
persistent=0

[state 4400 TEAM HYPER PAUSE P3]
type = pause
trigger1 = time = 0
time = 36           ;this determines when partner moves
movetime = 16       ;this is when you move
pausebg = 0
ignorehitpause = 1
persistent=0

[State 4400, screen bound]
type = ScreenBound
trigger1 = 1
value = 0

[State 4400, position]
type = Posset
triggerall = NumPartner = 1
trigger1 = time = 0
trigger1 = facing = 1
x = (NumPartner && partner, pos x) - 257
y = -130 

[State 4400, position]
type = Posset
triggerall = NumPartner = 1
trigger1 = time = 0
trigger1 = facing = -1
x = (NumPartner && partner, pos x) + 257
y = -130 

[State 4400, position]
type = Posadd
trigger1 = 1
x = 13.2

[State 4400, velocity]
type = VelSet
trigger1 = time = 0
y = 3

[State 4400, velocity]
type = Veladd
trigger1 = 1
y = .7

[State 4400]
type = Varset
trigger1=time=10
var(14)=0

[State 4400]
type = ChangeState
trigger1 = pos y >= 0 
trigger2 = time = 16
value = 4401

;===============================================================
;Delayed Hyper Combo Attack State (partner will jump offscreen(state 4450) when you are in this state)
[Statedef 4401]
type    = S
movetype= A
physics = S
ctrl = 0
velset = 0,0
anim = 4401
sprpriority=3

[State 4401, AssertSpecial]
type = AssertSpecial
trigger1 =1
flag = noFG
flag2 = noBG
flag3 = NoBarDisplay
ignorehitpause = 1

[State 4401, his is comming from a jumping state 4400]
type=posset
trigger1=time=0
y=0

[State 4401, his is comming from a jumping state 4400]
type=velset
trigger1=time=0
x=0
y=0

;THIS IS WHERE YOUR DHC HYPER STATE IS DETERMINED BASED ON VAR(57) BEING SET FROM THE LIST AT THE BOTTOM OF THE CNS FILE.
;EXAMPLE: IF YOUR DHC HYPER IS GOING TO INTERRUPT YOUR PARTNERS WITH A BEAM/FIREBALL MOTION WITH PUNCHES VAR(57)=1, IF
;YOUR DHC HYPER IS GOING TO INTERRUPT YOU PARTNERS HYPER WITH A HURRICAN MOTION WITH PUNCHES VAR(57)=3. YOU DONNOT HAVE
;TO SET VAR(57) MANUALLY, IT IS SET IN THE -3 STATE WHEN YOUR PARTNER IS DOING HIS HYPER AND YOU DO YOUR PARTNERS DHC 
;COMMAND

;This interrupts your partners hyper with the Orobouros
[State 4401]
type =changestate
triggerall = NumPartner = 1
trigger1=time=0
trigger1=var(57)=1||NumPartner && partner,var(57)=1
value=4403

;BE SURE TO RESET VAR(57) TO 0
[State 4401]
type =varset
trigger1=time>=5
var(57)=0

;CANNOT BE HIT FOR 10 TICKS IF ENEMY IS IN FRONT OF YOU 
[State 4401]
type = nothitby
trigger1 = p2bodydist x>=1
trigger1 = 1
value = SCA,AA,AT,AP
time = 10

;THIS IS A PRECAUTION SO YOU WONT GET STUCK IN THIS STATE IF YOUR DHC DOESNT WORK
[State 4401]
type = ChangeState
trigger1 = time = 120;;;;;;;;this time stops the team hyper attack(leave this at 120, DO NOT CHANGE)
value = 4402;;;;;;;;;;;;0 if you want p1 to have a taunt after team hyper while his partner jumps offscreen use 4702
ctrl = 0

;===============================================================
;Delayed Hyper Combo Ending Taunt or Cool Down Animation (This Player Stays On Screen after Delayed Hyper Combo)
[Statedef 4402]
type    = S
movetype= I
physics = S
ctrl = 0
anim =4702

[State 3000, Break Glass Explod]
type=Explod
trigger1=!winko
trigger1=Time=0
anim=8205
ID=8205
pos=0,0
postype=left
facing=1
vfacing=1
bindtime=-1
;removetime=-2
scale=1,1
sprpriority=4
ontop=0
ownpal=0
removeongethit=0

[State 3000, Break Glass Sound]
type=PlaySnd
trigger1=!winko
trigger1=Time=0
value=8205,0
channel=5
freqmul=1.0

[State 4402]
type = ChangeState
triggerall = NumPartner = 1 && NumPartner && partner, movetype != A
trigger1 = animtime = 0
trigger2 = anim = 0
value = 0
ctrl = 1

;===============================================================
;DELAYED HYPER COMBO 1
[Statedef 4403]
type    = S
movetype= A
physics = S
juggle  = 10
ctrl = 0
velset = 0,0
anim =4403
sprpriority=1

[State 4403, his is comming from a jumping state 4400]
type=posset
trigger1=1
y=0

[State 4403, his is comming from a jumping state 4400]
type=null;velset
trigger1=time=0
x=0
y=0

[State 4403, Reset DHC]
type= varset
trigger1= var(57)
trigger1= AnimElem<=5
var(57)= 0

[State 4403, Corner Push]
type= varset
trigger1= fvar(5)
trigger1= 1
fvar(5)= 0

[State 4403, the start time must be time=0]
type=SuperPause
trigger1=Time=0
anim=-1          ;the animation must be -1
;pos=65,-84
time=20
sound=s3000,0

[State 4403, Team Hyper Startup FX]
type=Explod
trigger1=time=0
anim=6050
id=6050
pos=-17,-85
sprpriority=4
supermovetime=999
pausemovetime=999
postype=P1
bindtime =1
removeongethit=1
scale=.6,.6
ownpal=1
ignorehitpause=1

[State 4403, HyperBg DHC Gold]
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

[State 4403, AssertSpecial]
type = AssertSpecial
trigger1 = time>1
flag = noFG
flag2 = noBG
flag3 = NoBarDisplay
ignorehitpause = 1

[State 4403, Remove Explod]
type=RemoveExplod
trigger1=AnimTime=0||movetype=H
trigger2=NumHelper(9600)
id=8200

[State 4403]
type=PlaySnd
trigger1=AnimElem=2
value=2,67;;8
channel=2

[State 4403]
type=NotHitBy
Trigger1=time>=8&&time<21
value=SCA
Time=1

[State 4403]
type=PlaySnd
trigger1=P2life=0
trigger2=winko
value=s3000,1
volume=255
channel=2
ignorehitpause=1
persistent=0

[State 4403, fadein from Black]
type=BGPalFx
trigger1=P2life=0
trigger2=winko
time=25
add=-256,-256,-256
sinadd=255,255,255,150
ignorehitpause=1
persistent=0
pausemovetime=9999

[State 4403]
type=EnvShake
trigger1=P2life=0
trigger2=winko
time=14
ampl=-3
freq=160
phase=1
ignorehitpause=1
persistent=0

[State 4403]
type=Pause
trigger1=P2life=0
trigger2=winko
time=10
movetime=10
ignorehitpause=1
persistent=0

[State 4403, Break Glass Explod]
type=Explod
trigger1=!winko
trigger1=Animtime=0||movetype=H
anim=8205
ID=8205
pos=0,0
postype=left
facing=1
vfacing=1
bindtime=-1
;removetime=-2
scale=1,1
sprpriority=4
ontop=0
ownpal=0
removeongethit=0

[State 4403, Break Glass Sound]
type=PlaySnd
trigger1=!winko
trigger1=Animtime=0||movetype=H
value=8205,0
channel=5
freqmul=1.0

[State 4403]
type=ChangeState
trigger1=AnimTime=0
value=0
ctrl=1

;===============================================================
; Jumping out of the stage after partner Interrupts Hyper(goes to waiting offscreen state 4512)
[Statedef 4450]
type = S
movetype = I
physics = N
anim =4511	                 ; <- You must have anim 4511 or it will break the tag
sprpriority =0
ctrl = 0

[State 4450]
type = Varset
trigger1=animtime=0
v=57
value=0

[State 4450, Remove Explod]  ;from state 3000
type=RemoveExplod
trigger1=Time>=0||movetype=H
trigger2=NumHelper(9600)
id=8200

[State 4450, screen bound]
type = posset
trigger1 =1
y = 0

[State 4450, screen bound]
type = ScreenBound
trigger1 = 1
value = 0

[State 4450]
type =assertspecial
trigger1 = 1
flag = invisible

[State 4450, jump out animation]
type =explod
trigger1 = time = 0
trigger1 = numexplod(4511) = 0
anim =4511                        ; <- You must have anim 4511
id=4511
postype = p1
pos = 0, 0
vel = -12,-6
sprpriority = -2
ownpal = 1
bindtime = 1
removetime=20

[State 4450]
type =turn
trigger1 = time = 0

[State 4450, invincibility]
type = NotHitBy
trigger1 = 1
value = SCA

[State 4450, ghost]
type = PlayerPush
trigger1 = 1
value = 0

[State 4450, wait outside state]
type=ChangeState
trigger1=animtime=0
trigger2=time>=35
value=4512

