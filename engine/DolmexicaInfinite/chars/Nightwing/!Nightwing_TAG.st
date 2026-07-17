;=========================================================================================
;                                TagIn Implementation
;=========================================================================================
;THIS IS THE TAG STATES. THIS IS WHERE THE TRIGGERS FOR THE DHC ARE LOCATED. STATE 4512 
;WILL CONTAIN EVERY CHARACTERS DHC TRIGGER VAR(14) AND VAR(57) WHICH WILL ALSO REQUIRE
;THE NAME OF THE CHARACTER AND THE AUTHORS NAME SO YOUR DHC PARTNER CAN BE IDENTIFIED

; Entering the screen When Tagged In
[Statedef 4500]
type=A
movetype=I
physics=N
anim=4500	
sprpriority=2
ctrl=0

[State 4500, position]
type=PosSet
trigger1=!time
x=-243*facing
y=-110

[State 4500, velocity]
type=VelSet
trigger1=!time
x=17.5
y=4.5

[State 4500, FX]
type=Playsnd
trigger1=!time
value=4500,0
channel=0

; the character cannot be hit until he has fully entered on the stage
[State 4500, invincibility] 
type=NotHitBy
trigger1=BackEdgeBodyDist <=0
value=SCA
time=2

; Prevents the camera from following the char
[State 4500, screen bound] 
type=ScreenBound
trigger1=1
value=0

;WHEN YOU ARE TAGGED IN YOU GO TO YOUR ATTACK STATE 4501
[State 4500, changestate]
type=ChangeState
triggerall=BackEdgeBodyDist >=0	        ; he is on the stage
trigger1=NumPartner && partner, life > 0		; and his partner is alive
trigger1=!Win && !Lose
value=4501

;WHEN YOU PARTNER JUMPS IN FOR THE TEAM HYPER, YOU GO TO YOUR TEAM HYPER STATE 4700
[State 4500, changestate]
type=ChangeState
triggerall=BackEdgeBodyDist >=0	        ; he is on the stage
trigger1=NumPartner && partner,stateno=4600
trigger1=NumPartner && partner,life > 0	
value=4700

[State 4500, 3]
type=VelSet
triggerall=BackEdgeBodyDist >=0
trigger1=FrontEdgeBodyDist <=0	        ; he has reached the other side of the screen
trigger2=NumPartner && partner,life <=0		; his partner has just died
trigger2=(Time >=50)||(P2BodyDist X=[-100,100])
trigger3=P2Dist X <0                    ; his enemy is behind him
trigger4=P2BodyDist X=[-100,100]
trigger4=Win
trigger5=Win
trigger5=Time>=20
x=0
y=0

;===============================================================
; Tagged in flying across the screen
[Statedef 4501]
type = A
movetype = A
physics = N
anim=4501
sprpriority = 2
ctrl = 0

[State 4501, voice]
type=Playsnd
trigger1=!time
value=2,48
channel=2

[state 4501]
type = hitdef
trigger1 = time = 0
attr =A,SA
animtype  = medium
damage    = 50
guardFlag = ma
pausetime = 9,9
sparkno = S7002
sparkxy=20,-20
hitsound   = S0,5
guardsound = S0,9
guard.sparkno = s7005
ground.type = High
ground.slidetime = 12
ground.hittime  = 15
ground.velocity = -14,-7
ground.cornerpush.veloff=0
fall = 1
fall.recover = 0 
air.velocity = -14,-7

[State 4501]
type = ChangeState
trigger1 = pos y >= 0	
value =4502				

;===============================================================
; Tagged in Landing Taunt
[Statedef 4502]
Type=S
Physics=S
Anim=4502
velset=0,0

[State 4502]
type=posset
trigger1 = 1
y=0

[State 4502, turn]
type=Turn
trigger1=!time
trigger1=P2Dist X < 0

[State 4502, voice]
type=Playsnd
trigger1=animelem=5
value=1,45
channel=2

[State 4502]
type=changestate
trigger1=time=60
value=0
ctrl=1 

;===============================================================
; Leaving Taunt
[Statedef 4510] 
type=S
movetype=I
physics=S
sprpriority=-2
velset=0,0
ctrl=0

; In case the character does have the anim 4510.
[State 4510]
type=ChangeAnim
triggerall=SelfAnimExist(4510)
trigger1=time=0
value=4510
persistent=0

; In case the character doesn't have the anim 4510.
[State 4510]
type=ChangeAnim
triggerall=!SelfAnimExist(4510)
trigger1=time=0
value=115                         ;put your characters taunt animation here
persistent=0

[State 4510]
type=varset
trigger1=time=0
v=52
value=0

[State 4510] ; the character cannot be hit since he is leaving
type=NotHitBy
trigger1=1
value=SCA

[State 4510, ghost]
type=PlayerPush
trigger1=1
value=0

[State 4510]
type=ChangeState
trigger1=time=29
value=4511

;===============================================================
; Jumping out of the stage after the taunt
[Statedef 4511]
type = S
movetype = I
physics = N
anim =4511	                 ; <- You must have anim 4511 or it will break the tag
sprpriority = 2
ctrl = 0

[State 4511, Remove Explod]
type=RemoveExplod
trigger1=(Time>=0)&&(NumPartner && partner,stateno=4401)||(movetype=H)
trigger2=NumHelper(9600)
id=8200

[State 4511, screen bound]
type = posset
trigger1 =1
y = 0

[State 4511, screen bound]
type = ScreenBound
trigger1 = 1
value = 0

[State 4511]
type =assertspecial
trigger1 = 1
flag = invisible

[State 4511, jump out animation]
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

[State 4511]
type =turn
trigger1 = time = 0

[State 4511, invincibility]
type = NotHitBy
trigger1 = 1
value = SCA

[State 4511, ghost]
type = PlayerPush
trigger1 = 1
value = 0

[State 4511, assist]; resets P1 jumping offscreen if hit during assist
type =varset
trigger1 = animtime = 0
trigger2 = time>=20
v=55
value=0

[State 4511, assist]; Allows partner to call in assist during walking states
type =varset
trigger1 = animtime = 0
trigger2 = time>=20
v=49
value=0

[State 4511, wait outside state]
type = ChangeState
trigger1 = animtime = 0
trigger2 = time>=20
value = 4512

;===============================================================
; Standby (offscreen)
[Statedef 4512]
type=A
movetype = I
physics = N
anim = 4512
velset = 0,0
ctrl = 0

[State 4512, invincibility]
type = NotHitBy
trigger1 = 1
value = SCA

[State 4512, ghost]
type = PlayerPush
trigger1 = 1
value = 0

[State 4512, screen bound]
type = ScreenBound
trigger1 = 1
value = 0

[State 4512, life add] ; Gains life (optional)
type=LifeAdd
trigger1=(gametime%10)=0&&(life<lifemax)
value=1

[State 4512, turn] ; always face the same direction as partner
type = turn
trigger1 = facing != NumPartner && partner,facing

[State 4512, position] ; always stay behind and at the same distance of the char on the stage
type = posset
trigger1 = 1
x = (NumPartner && partner, pos x) - 1000*facing
y = 0 

;THIS IS THE ASSIST CHANGESTATE
[State 4512] 
type=changestate
triggerall=(!winko)&&((pos y=0)||(NumPartner && partner,pos y=0))
trigger1 =var(53) = 1
trigger1 =command = "assist"
trigger1 =NumPartner && partner, var(13) != 1
trigger1 =NumPartner && partner, stateno = [0,699]
trigger2 =NumPartner && partner, stateno = 4900
trigger3 =var(53) = 2
trigger3 =NumPartner && partner, command = "assist"
trigger3 =NumPartner && partner, var(13) != 1
trigger3 =NumPartner && partner, stateno = [0,699]
value=4800

;THE VARSET TRIGGERS MUST MATCH THE VAR(14) AND VAR(57) TRIGGERS FROM YOU PARTNERS HYPER STATES, THESE VARSETS SHOULD
;INCLUDE ALL OF THE CHARATERS THAT HAVE THE EXACT SAME TEMPLATE. MUST HAVE NumPartner && partner,AUTHORNAME AND NumPartner && partner,NAME 
[State 4512,Alex Boomerang Raid]
type =Varset
triggerall=NumPartner && partner,authorname="MGMURROW"
triggerall=NumPartner && partner,name="Alex"
trigger1=NumPartner && partner,stateno=3000
trigger1=NumPartner && partner,time<=30
trigger2=(NumPartner && partner,stateno=[3200,3203])
trigger2=time>=0
v=57
value=0

[State 4512,Alex Boomerang Raid]
type =Varset
triggerall=NumPartner && partner,authorname="MGMURROW"
triggerall=NumPartner && partner,name="Alex"
trigger1=NumPartner && partner,stateno=3000
trigger1=(NumPartner && partner,AnimelemTime(7)>=0)&&(NumPartner && partner,AnimelemTime(46)<0)
trigger2=NumPartner && partner,stateno=3207
trigger2=(NumPartner && partner,stateno=3207)&&(NumPartner && partner,Time>=0)
v=14
value=1

[State 4512,Alex Boomerang Raid]
type =Varset
triggerall=NumPartner && partner,authorname="MGMURROW"
triggerall=NumPartner && partner,name="Alex"
trigger1=NumPartner && partner,stateno=3000
trigger1=(NumPartner && partner,AnimelemTime(46)>0)
v=14
value=0

[State 4512,Ryu Shinkuu Hadouken]
type =Varset
triggerall=NumPartner && partner,authorname="MGMURROW"
triggerall=NumPartner && partner,name="Ryu"
trigger1=NumPartner && partner,stateno=3001
trigger1=NumPartner && partner,time<=10
trigger2=NumPartner && partner,stateno=3100&&NumPartner && partner,anim=3100
v=57
value=0

[State 4512,Chun Li Kikoushou/Fireball]
type =Varset
triggerall=NumPartner && partner,authorname="MGMURROW"
triggerall=NumPartner && partner,name="Chun Li"
trigger1=NumPartner && partner,stateno=3000
trigger1=NumPartner && partner,time<=30
trigger2=NumPartner && partner,stateno=3100&&NumPartner && partner,anim=3100
trigger3=NumPartner && partner,stateno=3300
trigger4=NumPartner && partner,stateno=3301&&NumPartner && partner,AnimelemTime(6)<0
trigger5=NumPartner && partner,stateno=3301&&NumPartner && partner,AnimelemTime(88)>=0
v=57
value=0

[State 4512,Chun Li Kikoushou/Fireball]
type =Varset
triggerall=NumPartner && partner,authorname="MGMURROW"
triggerall=NumPartner && partner,name="Chun Li"
trigger1=NumPartner && partner,stateno=3000
trigger1=NumPartner && partner,anim=3000
trigger1=(NumPartner && partner,AnimelemTime(13)>=0)
trigger2=(NumPartner && partner,stateno=3100)&&(NumPartner && partner,AnimelemTime(4)>=0)
trigger3=NumPartner && partner,stateno=3301
trigger3=(NumPartner && partner,AnimelemTime(6)>=0)&&(NumPartner && partner,AnimelemTime(88)<0)
v=14
value=1

[State 4512,Chun Li Kikoushou/Fireball]
type =Varset
triggerall=NumPartner && partner,authorname="MGMURROW"
triggerall=NumPartner && partner,name="Chun Li"
trigger1=NumPartner && partner,stateno=3000
trigger1=(NumPartner && partner,Anim=3002)
trigger2=(NumPartner && partner,stateno=3100)&&(NumPartner && partner,Anim=3101)
trigger2=NumPartner && partner,AnimelemTime(62)>=0
trigger3=NumPartner && partner,stateno=3301
trigger3=(NumPartner && partner,AnimelemTime(88)>=0)
v=14
value=0

[State 4512,Strider Cypher's Edge]
type =Varset
triggerall=NumPartner && partner,authorname="MGMURROW"
triggerall=NumPartner && partner,name="Strider"
trigger1=(NumPartner && partner,stateno=3105)&&(NumPartner && partner,AnimelemTime(1)<=0)
trigger2=(NumPartner && partner,stateno=3105)&&(NumPartner && partner,AnimelemTime(11)>=0)
trigger3=(NumPartner && partner,stateno=3200)&&(NumPartner && partner,AnimelemTime(5)<0)
trigger4=(NumPartner && partner,stateno=3200)&&(NumPartner && partner,AnimelemTime(28)>=0)
trigger5=NumPartner && partner,stateno=3301
v=57
value=0

[State 4512,Strider Cypher's Edge]
type =Varset
triggerall=NumPartner && partner,authorname="MGMURROW"
triggerall=NumPartner && partner,name="Strider"
trigger1=NumPartner && partner,stateno=3105
trigger1=(AnimelemTime(4)>=0)&&(AnimelemTime(11)<0)
trigger2=NumPartner && partner,stateno=3200
trigger2=(NumPartner && partner,AnimelemTime(4)>=0)&&(NumPartner && partner,AnimelemTime(28)<0)
trigger3=NumPartner && partner,stateno=3303
trigger3=(NumPartner && partner,AnimelemTime(6)<0)
v=14
value=1

[State 4512,Strider Cypher's Edge]
type =Varset
triggerall=NumPartner && partner,authorname="MGMURROW"
triggerall=NumPartner && partner,name="Strider"
trigger1=NumPartner && partner,stateno=3105
trigger1=(NumPartner && partner,AnimelemTime(11)>=0)
trigger2=NumPartner && partner,stateno=3200
trigger2=(NumPartner && partner,AnimelemTime(1)>=0)&&(NumPartner && partner,AnimelemTime(28)>=0)
trigger3=NumPartner && partner,stateno=3303
trigger3=(NumPartner && partner,AnimelemTime(6)>=0)
v=14
value=0

[State 4512,Captain Commando]
type =Varset
triggerall=NumPartner && partner,authorname="MGMURROW"
triggerall=NumPartner && partner,name="Captain Commando"
trigger1=(NumPartner && partner,stateno=3050)&&(NumPartner && partner,anim=3050)&&(NumPartner && partner,animelemtime(1)<=1)
trigger2=(NumPartner && partner,stateno=3050)&&(NumPartner && partner,anim=3054)&&(NumPartner && partner,AnimelemTime(1)>=0)
trigger3=(NumPartner && partner,stateno=3104)&&(NumPartner && partner,AnimelemTime(5)>=0)
trigger4=(NumPartner && partner,stateno=3100)||(NumPartner && partner,stateno=3250)||(NumPartner && partner,stateno=3252)
trigger4=1
trigger5=(NumPartner && partner,stateno=3300)&&(NumPartner && partner,animelemtime(24)<0)
trigger6=(NumPartner && partner,stateno=3300)&&(NumPartner && partner,animelemtime(27)>=140)
v=57
value=0

[State 4512,Captain Commando]
type =Varset
triggerall=NumPartner && partner,authorname="MGMURROW"
triggerall=NumPartner && partner,name="Captain Commando"
trigger1=(NumPartner && partner,stateno=3050)&&(NumPartner && partner,anim=3051)&&(NumPartner && partner,animelemtime(1)=0)
trigger2=(NumPartner && partner,stateno=3102)&&(NumPartner && partner,AnimelemTime(6)<0)
trigger3=(NumPartner && partner,stateno=3251)
trigger3=1
trigger4=(NumPartner && partner,stateno=3300)&&(NumPartner && partner,AnimelemTime(25)=0)
v=14
value=1

[State 4512,Captain Commando]
type =Varset
triggerall=NumPartner && partner,authorname="MGMURROW"
triggerall=NumPartner && partner,name="Captain Commando"
trigger1=(NumPartner && partner,stateno=3050)&&(NumPartner && partner,anim=3054)&&(NumPartner && partner,AnimelemTime(1)>=0)
trigger2=(NumPartner && partner,stateno=3104)&&(NumPartner && partner,AnimelemTime(5)>=0)
trigger3=(NumPartner && partner,stateno=3100)||(NumPartner && partner,stateno=3250)||(NumPartner && partner,stateno=3252)||(NumPartner && partner,stateno=4403)
trigger3=1
trigger4=(NumPartner && partner,stateno=3300)&&(NumPartner && partner,animelemtime(24)<0)
trigger5=(NumPartner && partner,stateno=3300)&&(NumPartner && partner,animelemtime(27)>=140)
v=14
value=0

[State 4512,Shadowlady]
type =Varset
triggerall=NumPartner && partner,authorname="MGMURROW"
triggerall=NumPartner && partner,name="Shadowlady"
trigger1=NumPartner && partner,stateno=3000
trigger1=NumPartner && partner,time<=30
trigger2=NumPartner && partner,stateno=3100&&NumPartner && partner,anim=3100
trigger3=NumPartner && partner,stateno=3200&&(NumPartner && partner,AnimelemTime(1)>=0)
trigger4=NumPartner && partner,stateno=3201&&(NumPartner && partner,AnimelemTime(6)>=0)
trigger5=NumPartner && partner,stateno=3300
trigger6=NumPartner && partner,stateno=3301&&NumPartner && partner,AnimelemTime(6)<0
trigger7=NumPartner && partner,stateno=3301&&NumPartner && partner,AnimelemTime(88)>=0
trigger8=NumPartner && partner,stateno=3750&&NumPartner && partner,AnimelemTime(5)<0
trigger9=NumPartner && partner,stateno=3750&&NumPartner && partner,AnimelemTime(17)>=0
v=57
value=0

[State 4512,Shadowlady]
type =Varset
triggerall=NumPartner && partner,authorname="MGMURROW"
triggerall=NumPartner && partner,name="Shadowlady"
trigger1=NumPartner && partner,stateno=3000
trigger1=NumPartner && partner,anim=3000
trigger1=(NumPartner && partner,AnimelemTime(13)>=0)
trigger2=(NumPartner && partner,stateno=3100)&&(NumPartner && partner,AnimelemTime(4)>=0)
trigger3=NumPartner && partner,stateno=3201&&(NumPartner && partner,AnimelemTime(6)<0)
trigger4=NumPartner && partner,stateno=3301
trigger4=(NumPartner && partner,AnimelemTime(6)>=0)&&(NumPartner && partner,AnimelemTime(88)<0)
trigger5=NumPartner && partner,stateno=3750&&NumPartner && partner,AnimelemTime(6)>0
v=14
value=1

[State 4512,Shadowlady]
type =Varset
triggerall=NumPartner && partner,authorname="MGMURROW"
triggerall=NumPartner && partner,name="Shadowlady"
trigger1=NumPartner && partner,stateno=3000
trigger1=(NumPartner && partner,Anim=3002)
trigger2=(NumPartner && partner,stateno=3100)&&(NumPartner && partner,Anim=3101)
trigger2=NumPartner && partner,AnimelemTime(62)>=0
trigger3=NumPartner && partner,stateno=3200&&(NumPartner && partner,AnimelemTime(1)>=0)
trigger4=NumPartner && partner,stateno=3201&&(NumPartner && partner,AnimelemTime(6)>=0)
trigger5=NumPartner && partner,stateno=3301
trigger5=(NumPartner && partner,AnimelemTime(88)>=0)
trigger6=NumPartner && partner,stateno=3750&&NumPartner && partner,AnimelemTime(5)<0
trigger7=NumPartner && partner,stateno=3750&&NumPartner && partner,AnimelemTime(17)>=0
v=14
value=0

[State 4512,Crimson Viper]
type =Varset
triggerall=NumPartner && partner,authorname="MGMURROW"
triggerall=NumPartner && partner,name="Crimson Viper"
trigger1=NumPartner && partner,stateno=3000&&NumPartner && partner,AnimelemTime(7)<0
trigger2=NumPartner && partner,stateno=3000&&NumPartner && partner,AnimelemTime(8)>=4
trigger3=NumPartner && partner,stateno=3100&&NumPartner && partner,anim=3100
trigger4=NumPartner && partner,stateno=3103&&NumPartner && partner,AnimelemTime(4)>=0
trigger5=NumPartner && partner,stateno=3200&&NumPartner && partner,AnimelemTime(1)>=0
v=57
value=0

[State 4512,Crimson Viper]
type =Varset
triggerall=NumPartner && partner,authorname="MGMURROW"
triggerall=NumPartner && partner,name="Crimson Viper"
trigger1=NumPartner && partner,stateno=3000&&NumPartner && partner,AnimelemTime(7)>=0
trigger2=NumPartner && partner,stateno=3100&&NumPartner && partner,AnimelemTime(7)>=0
trigger3=NumPartner && partner,stateno=3100&&NumPartner && partner,AnimelemTime(8)<0
trigger4=NumPartner && partner,stateno=3103&&NumPartner && partner,AnimelemTime(1)>=0
trigger5=NumPartner && partner,stateno=3200&&NumPartner && partner,AnimelemTime(5)>=0
trigger5=NumPartner && partner,stateno=3200&&NumPartner && partner,AnimelemTime(8)<0
v=14
value=1

[State 4512,Crimson Viper]
type =Varset
triggerall=NumPartner && partner,authorname="MGMURROW"
triggerall=NumPartner && partner,name="Crimson Viper"
trigger1=NumPartner && partner,stateno=3000&&NumPartner && partner,AnimelemTime(8)>=4
trigger2=NumPartner && partner,stateno=3100&&NumPartner && partner,AnimelemTime(7)<0
trigger3=NumPartner && partner,stateno=3100&&NumPartner && partner,AnimelemTime(16)>=0
trigger4=NumPartner && partner,stateno=3102&&NumPartner && partner,AnimelemTime(2)>=0
trigger5=NumPartner && partner,stateno=3103&&NumPartner && partner,AnimelemTime(4)>=0
trigger6=NumPartner && partner,stateno=3200&&NumPartner && partner,AnimelemTime(8)>=0
v=14
value=0

[State 4512, p1 in state 4512] 
type=changestate
triggerall=!winko
triggerall =ID<NumPartner && partner,ID
triggerall =var(14) =1                                ;this detects when you can cancel your partners hyper with the DHC
triggerall =NumPartner && partner, stateno = [3000,3999]                            
trigger1 =(authorname="MGMURROW")&&(name="ALEX")&&(var(57)=1||var(57)=3)      ;this detects which hyper command was done
trigger2 =(authorname="MGMURROW")&&(name="RYU")&&(var(57)=1||var(57)=4)       ;this detects which hyper command was done 
trigger3 =(authorname="MGMURROW")&&(name="CHUN LI")&&(var(57)=1||var(57)=2||var(57)=4)   ;this detects which hyper command was done 
trigger4 =(authorname="MGMURROW")&&(name="STRIDER")&&(var(57)=1||var(57)=2||var(57)=5||var(57)=6) 
trigger5 =(authorname="MGMURROW")&&(name="CAPTAIN COMMANDO")&&(var(57)=1||var(57)=2||var(57)=3||var(57)=4) 
trigger6 =(authorname="MGMURROW")&&(name="SHADOWLADY")&&(var(57)=1||var(57)=2||var(57)=3||var(57)=4||var(57)=6)
trigger7 =(authorname="MGMURROW")&&(name="CRIMSON VIPER")&&(var(57)=1||var(57)=3||var(57)=5)
trigger8 =(authorname="Nestor")&&(name="Leo")&&(var(57)=1||var(57)=3)             
value=4400

[State 4512, partner in state 4512] 
type=changestate
triggerall=!winko
triggerall =ID>NumPartner && partner,ID
triggerall =NumPartner && partner, var(14) =1
triggerall =(NumPartner && partner,var(57)=1||NumPartner && partner,var(57)=2||NumPartner && partner,var(57)=5||NumPartner && partner,var(57)=6)  ;THIS MUST INCLUDE ALL OF THE CHARACTERS DHC HYPERS(not partners)
trigger1 =NumPartner && partner, stateno = [3000,3999]
value=4400

;JUMPS ONSCREEN WHEN PARTNER IS IN HIS TAUNT STATE BEFORE JUMPING OFFSCREEN(PREVENTS BOTH PLAYERS FROM BEING OFFSCREEN)
[State 4512] 
type = changestate
trigger1 = NumPartner && partner, stateno = 4510
value = 4500

;PLAYER JUMPS ONSCREEN WHEN PARTER WINS OR TIME IS UP
[State 4512] 
type = changestate
trigger1 = roundstate = 3
trigger1 = NumPartner && partner, stateno = 0
trigger1 = enemy, stateno =5150
value = 4520

;WHEN PARTNER IS IN STATE 4600(WAITING FOR PARTNER TO DO TEAM HYPER), YOU GO TO STATE 4700(JUMPING ONSCREEN FOR TEAM HYPER)
[State 4512]
type = ChangeState
triggerall = NumPartner = 1
trigger1 = NumPartner && partner, stateno = 4600
value = 4700

;===============================================================
; Jumping in when you win match or time over
[Statedef 4520]
type = A
movetype = I
physics = N
anim = 42;<------------use you jumping forward animation
sprpriority =0
ctrl = 0

[State 4520, 0]
type = varset
trigger1 = time = 0
v = 52
value = 0

[State 4520, 0]
type = ctrlset
trigger1 = time = 20
value = 1
ctrl = 1

[State 4520, 0]
type = PosSet
trigger1 = AnimElem = 2, < 0
x = -243*Facing
y = 0

[State 4520, 1]
type = VelSet
trigger1 = AnimElem = 2, = 0
x = 4
y = -8.75

[State 4520, 2]
type = NotHitBy
trigger1 = time < 20
value = SCA
time = 6

[State 4520, 8]
type = screenbound
trigger1 =1
value = 0

[State 4520, 8]
type = Gravity
trigger1 = AnimElem = 2, >= 0

[State 4520, 9]
type = VelSet
trigger1 = Vel Y >= 0
trigger1 = Pos y > 0
trigger1 = AnimElem = 2, >= 0
x = 0
y = 0

[State 4520, 10]
type = ChangeState
trigger1 = Vel Y >= 0
trigger1 = Pos Y > 0
trigger1 = AnimElem = 2, >= 0
value = 4521

;===============================================================
; Landing from jump in
[Statedef 4521]
type = S
movetype = I
physics = N
anim = 47
sprpriority =0
ctrl = 0

[State 4521]
type = PosSet
trigger1 = Time = 0
y =0

[State 4521]
type = NotHitBy
trigger1 = 1
value = SCA
time = 6

[State 4521]
type = ChangeState
trigger1 = AnimTime >= 0
value = 0
ctrl = 1
