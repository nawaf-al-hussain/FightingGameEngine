;Place Your Characters Assist Attacks here, If you are not in the assist attack states [4800,4899]
;your assist character will go to state 4511, which is the jump offscreen state. Try not to use
;variables in these states as your partner sometimes will not read the variables. also try not to
;have the assist jump over or land on the other side of the enemy as this will cause your commands
;to reverse while your assist partner jumps off screen(while in state 4511) 
;=================================================================================================
;                                      ASSIST ATTACK STATES
;=================================================================================================
;partner jumps onscreen for his assist
[Statedef 4800]
type    = S
movetype= I
physics = N
anim = 4800
ctrl = 0

[State 4800]
type =varset
trigger1=1
v=55
value=1

[State 4800, screen bound] ; Prevents the camera from following the char
type = ScreenBound
trigger1 = 1
value = 0

[State 4800]
type = Posset
triggerall = NumPartner = 1
trigger1 = time = 0
trigger1 = facing = 1
x = (NumPartner && partner, pos x) - 257
y = -80

[State 4800]
type = Posset
triggerall = NumPartner = 1
trigger1 = time = 0
trigger1 = facing = -1
x = (NumPartner && partner, pos x) + 257
y = -80

[State 4800]
type = Posadd
trigger1 = 1
x = 10

[State 4800]
type = VelSet
trigger1 = time = 0
y = -5

[State 4800]
type = Veladd
trigger1 = 1
y = .7

[state 4800]
type = changestate
trigger1 = pos Y >= 0
value = 4801

;===============================================================
;Assist Attack Landing for 4800, the attack will start after this state so try to make the animation 4 ticks or less
[Statedef 4801]
type=S
movetype=A
physics=S
velset=0,0
poweradd=40
ctrl=0
anim=4801

[State 4801];Prevents partner from being stuck in state 4900 if holding back or forward
type =varset
trigger1=1
v=49
value=1

[State 4801, screen bound] ; Prevents the camera from following the char
type=ScreenBound
trigger1=1
value=0

[state 4801]
type=posset
trigger1=time=0
y=0

[state 4801]
type=Explod
trigger1=time=0
anim=7008
pos=0,0
postype=p1
removetime=-2
ignorehitpause=1
bindtime=1
persistent=0
sprpriority=-2
ownpal=1

[state 4801]
type=PlaySnd
trigger1=AnimElem=2
value=2,29
channel=3

[state 4801]
type=ChangeState
trigger1=AnimTime=0
value=4802
ctrl=0

;===============================================================
;Assist Attack
[Statedef 4802]
type    = S
physics = S
movetype = A
ctrl = 0
velset = 0,0
juggle = 10
poweradd =50

[State 4802]
type=ChangeAnim
trigger1=time=0
value=4802

[State 4802]
type=PlaySnd
trigger1=animelem=2
value=2,11
channel=2

[State 4802]
type=NotHitBy
trigger1=time=0
value=SCA,NP,SP
time=8

[State 4802]
type = ChangeState
trigger1 = animtime = 0
value = 4803
ctrl = 1

;===============================================================
;Assist Attack
[Statedef 4803]
type    = A
physics = N
movetype = A
ctrl = 0
sprpriority =0

[State 4803]
type=ChangeAnim
trigger1=time=0
value=4803

[State 4803]
type=NotHitBy
trigger1=time=0
value=SCA,NP,SP
time=6

[State 4803]
type=PlaySnd
trigger1=AnimElem=4
value=2,17
channel=0

[State 4803]
type=PlaySnd
trigger1=P2life=0
trigger1=winko
value=3000,2
volume=255
channel=2
ignorehitpause=1
persistent=0

[State 4802, fadein from Black]
type=BGPalFx
trigger1=P2life=0
trigger1=winko
time=25
add=-256,-256,-256
sinadd=255,255,255,150
ignorehitpause=1
persistent=0
pausemovetime=9999

[State 4803]
type=EnvShake
trigger1=P2life=0
trigger1=winko
time=14
ampl=-3
freq=160
phase=1
ignorehitpause=1
persistent=0

[State 4803]
type=Pause
trigger1=P2life=0
trigger1=winko
time=10
movetime=10
ignorehitpause=1
persistent=0

[State 4803]
trigger1 = time=20
type = ChangeState
value =4804

;===============================================================
:Assist Attack End
[Statedef 4804]
type    =S
physics =S
ctrl =0
anim =4804

[State 4804]
type = PlaySnd
trigger1 = time = 0
value = S52,0

[State 4804]
type = VelSet
trigger1 = Time = 0
x = 0
y = 0

[State 4804]
type = PosSet
trigger1 = Time = 0
y = 0

[State 4804]
type = NotHitBy
trigger1 = Time = 0
value = , NT,ST,HT
time = 1

[State 4804]
type = ChangeState
trigger1 = AnimTime = 0
value = 4810

;===============================================================
;Taunt After The Assist Attack
[Statedef 4810]
type    = S
movetype= I
physics = S
anim =4810
ctrl = 0
sprpriority=0

[State 4808, screen bound] ; Prevents the camera from following the char
type = ScreenBound
trigger1 = 1
value = 0

[State 4808]
type =velset
trigger1=1
x=0
y=0

[State 4808]
type =Posset
trigger1=1
y=0

[State 4808, voice]
type=Playsnd
trigger1=!time
value=2,45
channel=2

[state 4808]
type = changestate
trigger1 = animtime = 0
value = 4511

;===============================================================
;p1 calls in partner for him to assist
[Statedef 4900]
type=S
movetype=I
physics=S
anim=4900
ctrl=0
sprpriorit-3

[State 4900]
type =varset
trigger1=1
v=54
value=0

[State 4900]
type=Velset
trigger1=1
x=0
y=0

[state 4900]
type=ctrlset
trigger1=time>46
value=1

[state 4900]
type=changestate
trigger1=time=47
value=0
ctrl=1