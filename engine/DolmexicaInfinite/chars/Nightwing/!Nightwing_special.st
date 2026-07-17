;==============================================================================================
;==============================================================================================
;                                           SPECIAL ATTACKS
;==============================================================================================
;==============================================================================================
;Throw Batrangs
[Statedef 1000]
type=S
movetype=I
physics=S
ctrl=0
poweradd=25
velset=0,0
sprpriority=1

[State 0, ChangeState]
type = ChangeState
triggerall = AiLevel
trigger1 = !Time && random< 200
value = 1300
ctrl = 0

[State 1000]
type=PlaySnd
trigger1=AnimElem=4
value=2,46;;2,10
channel=2

[State 1000, Vari�vel de for�a]
type = VarSet
trigger1 = !time && !AiLevel
v = 20
value = ifelse (command = "qcf_z",2,(ifelse(command = "qcf_y",1,0)))

[State 1000, Vari�vel de for�a]
type = VarSet
trigger1 = !time && AiLevel
v = 20
value = ifelse(random<700,2,1)

[State 0, ChangeAnim]
type = ChangeAnim
trigger1 = !time
value = 1000+Var(20)

[State 250, DUST]
type=Explod
trigger1=AnimElem = 3
ID=7009
anim=7009
postype=p1
pos=30,0
bindtime=1
scale=.5,.5
sprpriority=3
ownpal=1

[State 200, Voices]
type = PlaySnd
trigger1 = Anim = 1000 && AnimElem = 5
trigger2 = Anim = 1001 && AnimElem = 4
trigger3 = Anim = 1002 && AnimElem = 4
value = 0,0

[State 200, Voices]
type = PlaySnd
trigger1 = AnimElem = 4
value = S1002,0+random%3

[State 0, Helper]
type = Helper
trigger1 = Anim = 1000 && AnimElem = 5
trigger2 = Anim = 1001 && AnimElem = 4
trigger3 = Anim = 1002 && AnimElem = 4
helpertype = normal ;player
name = "batrang" 
ID = 1005
stateno = 1005
pos = ifelse(Anim=1000,58,ifelse(anim=1001,48,63)),ifelse(Anim=1000,-78,ifelse(anim=1001,-68,-63))
postype = p1    ;p2,front,back,left,right
facing = 1
keyctrl = 0
ownpal = 1

[State 1000]
type=ChangeState
trigger1=AnimTime=0
value=0
ctrl=1

;==============================================================================================
;Batrangs
[Statedef 1005]
type=A
movetype=A
physics=N
ctrl=0
poweradd=25
sprpriority=1
anim = 1005

[State -2, Hyper Combo Finish FX]
type = Helper
triggerall = (WinKO) && (NumHelper(9700) = 0)
trigger1 = MoveHit
helpertype = Normal
name = "Hyper Combo Finish FX"
ID = 9700
stateno = 9700
pos = 0,0
postype = p1    ;p2,front,back,left,right
facing = 1
ownpal = 0
supermove=9999
pausemove=9999
ignorehitpause=1

[State 0, PlaySnd]
type = PlaySnd
trigger1 = !time
value = S1005,0+random%2
ignorehitpause = 1

[State 1000, Vari�vel de for�a]
type = VarSet
trigger1 = !time
v = 20
value = root,var(20)

[State 0, VelSet]
type = VelSet
trigger1 = !time
x = 15
y = ifelse(var(20)=0,-5,ifelse(var(20)=1,6,0))

[State 0, HitOverride]
type = HitOverride
trigger1 = 1
attr = SCA;SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
slot = 0
stateno = 1006
time = -1

[State 1000]
type=ChangeState
trigger1=Pos Y>=-1 && Vel Y>0
value=1007


[State 250]
type=HitDef
triggerall= var(20) !=1
trigger1 = !time
priority=7,Hit
attr=A,AP
guardflag=MA
hitflag=MAF
damage=ifelse(root,stateno=3000,10,85),5
animtype=Hard
air.animtype=Back
fall.animtype=Back
ground.type=High
air.type=Low
getpower=(root,stateno!=3000),5
givepower=11,8 
pausetime=5,5
sparkno = S-1
sparkxy=var(32):=0,var(33):=0
hitsound=S0,5
guardsound = S0,10
guard.sparkno = s7004
ground.type = High
ground.slidetime = 12
ground.hittime  = 21
ground.velocity = -10,-2
air.velocity = -10,-2
ground.cornerpush.veloff = 0
envshake.time = 7
envshake.ampl = 4
fall=1

[State 250]
type=HitDef
triggerall= var(20)=1
trigger1 = !time
priority=7,Hit
attr=A,AP
guardflag=L
hitflag=MAF
damage=85,5
animtype=Hard
air.animtype=Back
fall.animtype=Back
air.type=Low
getpower=10,5
givepower=11,8 
pausetime=5,5
sparkno = S-1
sparkxy=var(32):=0,var(33):=0
hitsound=S0,5
guardsound = S0,10
guard.sparkno = s7004
ground.type = Trip
ground.slidetime = 12
ground.hittime  = 21
ground.velocity = -10,-2
air.velocity = -10,-2
ground.cornerpush.veloff = 0
envshake.time = 7
envshake.ampl = 4
fall=1

[State 250, hitspark heavy]
type=helper 
trigger1= hitpausetime=4;;;;;;;;;;;;;;;;;;;;must be 1 tick under pausetime (or at least under)
trigger1= movehit=1 && numtarget
helpertype=normal
stateno=7002
ID=7002
name="Blood"
postype=p2
pos= (target,const(size.ground.front) + var(32)) * (target,facing) * (-facing), floor(pos y-target,pos y) + var(33)
facing= ifelse((target,facing = facing), 1, -1)
ownpal=1
pausemovetime=65535
supermovetime=65535
ignorehitpause=1

[State 1000]
type=ChangeState
trigger1=Movecontact
value=1006

[State 0, DestroySelf]
type = DestroySelf
trigger1 = FrontEdgeDist < -20

;----------------------------------------------
;Batrangs hit
[Statedef 1006]
type=A
movetype=A
physics=N
ctrl=0
anim = 1006
sprpriority=1

[State 0, VelSet]
type = VelSet
trigger1 = !time
x = -1-random%7
y = -2-random%6
ignorehitpause = 1

[State 0, Gravity]
type = Gravity
trigger1 = 1


[State 1000]
type=ChangeState
trigger1=Pos Y>=-1 && Vel Y>0
value=1007

;----------------------------------------------
;Batrangs land
[Statedef 1007]
type=A
movetype=A
physics=N
ctrl=0
anim = 1007
sprpriority=1
velset = 0,0

[State 0, PlaySnd]
type = PlaySnd
trigger1 = !time
value = S47,0


[State 250]
type=Explod
trigger1=!time
ID=7008
anim=7008
postype=p1
pos=0,0
bindtime=1
scale=.5,.5
sprpriority=3
ownpal=1


[State 0, DestroySelf]
type = DestroySelf
trigger1 = !AnimTime

;==============================================================================================
;Batrangs EX
[Statedef 1008]
type=A
movetype=A
physics=N
ctrl=0
sprpriority=1
anim = 1005

[State -2, Hyper Combo Finish FX]
type = Helper
triggerall = (WinKO) && (NumHelper(9700) = 0)
trigger1 = MoveHit
helpertype = Normal
name = "Hyper Combo Finish FX"
ID = 9700
stateno = 9700
pos = 0,0
postype = p1    ;p2,front,back,left,right
facing = 1
ownpal = 0
ignorehitpause=1

[State 0, PlaySnd]
type = PlaySnd
trigger1 = !time
value = S1005,0+random%2
ignorehitpause = 1

[State 1000, Vari�vel de for�a]
type = VarSet
trigger1 = !time
v = 20
value = root,var(20)

[State 0, VelSet]
type = VelSet
trigger1 = !time
x = 15
y = ifelse(var(20)=0,-5,ifelse(var(20)=1,6,0))

[State 0, HitOverride]
type = HitOverride
trigger1 = 1
attr = SCA;SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
slot = 0
stateno = 1006
time = -1

[State 1000]
type=ChangeState
trigger1=Pos Y>=-1 && Vel Y>0
value=1007


[State 250]
type=HitDef
triggerall= var(20) !=1
trigger1 = !time
priority=7,Hit
attr=A,AP
guardflag=MA
hitflag=MAF
damage=ifelse(root,stateno=3000,10,85),5
animtype=Hard
air.animtype=Back
fall.animtype=Back
ground.type=High
air.type=Low
givepower=11,8 
pausetime=5,5
sparkno = S-1
sparkxy=var(32):=0,var(33):=0
hitsound=S0,5
guardsound = S0,10
guard.sparkno = s7004
ground.type = High
ground.slidetime = 12
ground.hittime  = 21
ground.velocity = -10,-2
air.velocity = -10,-2
ground.cornerpush.veloff = 0
envshake.time = 7
envshake.ampl = 4
fall=1
getpower = 0,0

[State 250]
type=HitDef
triggerall= var(20)=1
trigger1 = !time
priority=7,Hit
attr=A,AP
guardflag=L
hitflag=MAF
damage=85,5
animtype=Hard
air.animtype=Back
fall.animtype=Back
air.type=Low
givepower=11,8 
pausetime=5,5
sparkno = S-1
sparkxy=var(32):=0,var(33):=0
hitsound=S0,5
guardsound = S0,10
guard.sparkno = s7004
ground.type = Trip
ground.slidetime = 12
ground.hittime  = 21
ground.velocity = -10,-2
air.velocity = -10,-2
ground.cornerpush.veloff = 0
envshake.time = 7
envshake.ampl = 4
fall=1
getpower = 0,0

[State 250, hitspark heavy]
type=helper 
trigger1= hitpausetime=4;;;;;;;;;;;;;;;;;;;;must be 1 tick under pausetime (or at least under)
trigger1= movehit=1 && numtarget
helpertype=normal
stateno=7002
ID=7002
name="Blood"
postype=p2
pos= (target,const(size.ground.front) + var(32)) * (target,facing) * (-facing), floor(pos y-target,pos y) + var(33)
facing= ifelse((target,facing = facing), 1, -1)
ownpal=1
pausemovetime=65535
supermovetime=65535
ignorehitpause=1

[State 1000]
type=ChangeState
trigger1=Movecontact
value=1006

[State 0, DestroySelf]
type = DestroySelf
trigger1 = FrontEdgeDist < -20



;---------------------------------------------------------------------------------------------
; Mode Change
[Statedef 1100]
type    = S
movetype= A
physics = S
ctrl = 0
velset =0,0

[State 0, ChangeState]
type = ChangeState
trigger1 = !time && var(35) = 20002 && var(25) = 0
value = 1105
ctrl = 0

[State 0, VarSet]
type = VarSet
trigger1 = !time && var(25) = 0
v = 35
value = 0

[State 0, VarSet]
type = VarSet
trigger1 = !time && var(25) = 1
v = 35
value = 20001

[State 0, VarSet]
type = VarSet
trigger1 = !time && var(25) = 2
v = 35
value = 20002

[State 0, ChangeAnim]
type = ChangeAnim
trigger1 = !Time
value = 1100+var(35)

[State 0, PlaySnd]
type = PlaySnd
trigger1 = var(35) = 20002 && AnimElem = 4
value = S3,0

[State 0, PlaySnd]
type = PlaySnd
triggerall = var(35) = 20002
trigger1 = AnimElem = 8 || AnimElem = 11 ;|| AnimElem = 28 || AnimElem = 31
value = S3,1

[State 0, Explod]
type = Explod
trigger1 = AnimElem = 3
anim = 7018
ID = 7018
pos = 0,-90
postype = p1  ;p2,front,back,left,right
facing = 1
vfacing = 1
bindtime = 1
vel = 0,0
accel = 0,0
random = 0,0
removetime = -2
pausemovetime = 0
scale = 1,1
sprpriority = 10
ontop = 0
shadow = 0,0,0
ownpal = 1
removeongethit = 0

[State 0, PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 3
value = S1,8

[State 0, Helper]
type = Helper
triggerall = var(35)=20001
trigger1 = AnimElem = 4
helpertype = normal ;player
name = "spark"
ID = 1
stateno = 1
pos = 10,-94
postype = p1    ;p2,front,back,left,right
facing = 1
keyctrl = 0
ownpal = 1
supermovetime = 0
pausemovetime = 0

[State 1112, ChangeState]
type = ChangeState
trigger1 = !AnimTime
value = 0
ctrl = 1

;---------------------------------------------------------------------------------------------
; Mode Change alternate
[Statedef 1105]
type    = S
movetype= A
physics = S
ctrl = 0
velset =0,0
Anim = 1105

[State 0, VarSet]
type = VarSet
trigger1 = !time && var(25) = 0
v = 35
value = 0


[State 0, Explod]
type = Explod
trigger1 = AnimElem = 3
anim = 7018
ID = 7018
pos = 0,-90
postype = p1  ;p2,front,back,left,right
facing = 1
vfacing = 1
bindtime = 1
vel = 0,0
accel = 0,0
random = 0,0
removetime = -2
pausemovetime = 0
scale = 1,1
sprpriority = 10
ontop = 0
shadow = 0,0,0
ownpal = 1
removeongethit = 0

[State 0, PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 3
value = S1,8

[State 1112, ChangeState]
type = ChangeState
trigger1 = !AnimTime
value = 0
ctrl = 1


;--------------------------------------------
;Justice Upper
[Statedef 1200]
type    = A
movetype= A
physics = N
juggle  = 1
velset = 0,0
poweradd = 50
ctrl = 0
sprpriority = 2

[State 1000, Vari�vel de for�a]
type = VarSet
trigger1 =!time
v = 4
value = ifelse(AiLevel,2,ifelse (command = "dp_z",2,(ifelse(command = "dp_y",1,0))))

[State 250, DUST]
type=Explod
trigger1=!time && Pos Y = 0
ID=7009
anim=7009
postype=p1
pos=30,0
bindtime=1
scale=.5,.5
sprpriority=3
ownpal=1


[State 0, ChangeAnim]
type = ChangeAnim
trigger1 =!time
value = 1200+var(4)


[State 0, VelSet]
type = VelSet
trigger1 = AnimElem = 2
x = 1+var(4)
y = -7-var(4)
ignorehitpause = 1

[State 0, PlaySnd]
type = PlaySnd
trigger1 =  AnimElem = 2
value = S1,17

[State 0, PlaySnd]
type = PlaySnd
trigger1 =  AnimElem = 2
value = S1,17

[State 0, PlaySnd]
type = PlaySnd
triggerall = Anim = 1201 || Anim = 1202
trigger1 =  AnimElem = 4 || AnimElem = 6
value = S1,18

[State 0, PlaySnd]
type = PlaySnd
triggerall = Anim = 1202
trigger1 =  AnimElem = 8 || AnimElem = 10
value = S1,18


[State 1010, Ground FX]
type = Explod
triggerall = !Pos Y
trigger1 = !time 
anim = 8170
pos = -8,8
sprpriority = -4
supermovetime = -1
postype = p1
bindtime = 1
removetime = -2
removeongethit = 1
scale = .5, .5
facing = 1
ownpal = 1

[State 250]
type=HitDef
trigger1=time=0
priority=7,Hit
attr=S,SA
guardflag=MA
hitflag=MAF
damage=85
animtype=Hard
air.animtype=Back
fall.animtype=Back
ground.type=High
air.type=Low
getpower=10,5
givepower=11,8 
pausetime=11,11
sparkno = S-1
sparkxy=var(32):=-6,var(33):=-97
hitsound=S0,8
guardsound = S0,10
guard.sparkno = s7004
ground.type = High
ground.slidetime = 12
ground.hittime  = 21
ground.velocity = -6,-7
air.velocity = -2.2,-3.2
ground.cornerpush.veloff = 0
envshake.time = 7
envshake.ampl = 4
fall=1

[State 250]
type=HitDef
triggerall = Anim = 1201
trigger1=AnimElem = 3 || AnimElem = 4 
priority=7,Hit
attr=S,SA
guardflag=MA
hitflag=MAF
damage=25
animtype=Hard
air.animtype=Back
fall.animtype=Back
ground.type=High
air.type=Low
getpower=10,5
givepower=11,8 
pausetime=3,3
sparkno = S-1
sparkxy=var(32):=-6,var(33):=-97
hitsound=S0,8
guardsound = S0,10
guard.sparkno = s7004
ground.type = High
ground.slidetime = 12
ground.hittime  = 21
ground.velocity = -6,-5
air.velocity = -2.2,-5
ground.cornerpush.veloff = 0
envshake.time = 7
envshake.ampl = 4
fall=1

[State 250]
type=HitDef
triggerall = Anim = 1201
trigger1=AnimElem = 5
priority=7,Hit
attr=A,SA
guardflag=MA
hitflag=MAF
damage=25
animtype=Hard
air.animtype=Back
fall.animtype=Back
ground.type=High
air.type=Low
getpower=10,5
givepower=11,8 
pausetime=10,2
sparkno = S-1
sparkxy=var(32):=-6,var(33):=-97
hitsound=S0,5
guardsound = S0,10
guard.sparkno = s7004
ground.type = High
ground.slidetime = 12
ground.hittime  = 21
ground.velocity = -6,-5
air.velocity = -4,12
ground.cornerpush.veloff = 0
envshake.time = 15
envshake.ampl = 10
fall=1

[State 250]
type=HitDef
triggerall = Anim = 1202
trigger1=AnimElem = 3 || AnimElem = 4 || AnimElem = 5 || AnimElem = 6 || AnimElem = 7 || AnimElem = 8
priority=7,Hit
attr=S,SA
guardflag=MA
hitflag=MAF
damage=25
animtype=Hard
air.animtype=Back
fall.animtype=Back
ground.type=High
air.type=Low
getpower=10,5
givepower=11,8 
pausetime=3,3
sparkno = S-1
sparkxy=var(32):=-6,var(33):=-97
hitsound=S0,8
guardsound = S0,10
guard.sparkno = s7004
ground.type = High
ground.slidetime = 12
ground.hittime  = 21
ground.velocity = -6,-5
air.velocity = -2.2,-5
ground.cornerpush.veloff = 0
envshake.time = 7
envshake.ampl = 4
fall=1

[State 250]
type=HitDef
triggerall = Anim = 1202
trigger1=AnimElem = 11
priority=7,Hit
attr=A,SA
guardflag=MA
hitflag=MAF
damage=25
animtype=Hard
air.animtype=Back
fall.animtype=Back
ground.type=High
air.type=Low
getpower=10,5
givepower=11,8 
pausetime=10,2
sparkno = S-1
sparkxy=var(32):=-6,var(33):=-97
hitsound=S0,5
guardsound = S0,10
guard.sparkno = s7004
ground.type = High
ground.slidetime = 12
ground.hittime  = 21
ground.velocity = -6,-5
air.velocity = -4,12
ground.cornerpush.veloff = 0
envshake.time = 15
envshake.ampl = 10
fall=1


[State 250, hitspark heavy]
type=helper 
trigger1= Anim = 1200 && hitpausetime=10;;;;;;;;;;;;;;;;;;;;must be 1 tick under pausetime (or at least under)
trigger1= movehit=1 && numtarget
trigger2= Anim = 1201 && hitpausetime=3;;;;;;;;;;;;;;;;;;;;must be 1 tick under pausetime (or at least under)
trigger2= movehit=1 && numtarget
trigger3= Anim = 1202 && hitpausetime=3;;;;;;;;;;;;;;;;;;;;must be 1 tick under pausetime (or at least under)
trigger3= movehit=1 && numtarget
helpertype=normal
stateno=7002
ID=7002
name="Blood"
postype=p2
pos= (target,const(size.ground.front) + var(32)) * (target,facing) * (-facing), floor(pos y-target,pos y) + var(33)
facing= ifelse((target,facing = facing), 1, -1)
ownpal=1
pausemovetime=65535
supermovetime=65535
ignorehitpause=1



[State 0, Gravity]
type = Gravity
trigger1 = Pos Y < 0
ignorehitpause = 

[State 0, ChangeState]
type = ChangeState
trigger1 = Pos Y >=0 && Vel Y > 0
value = 1205
ctrl = 0

;-------------------------------------------------------------
;Upper Land
[Statedef 1205]
type    = A
movetype= A
physics = N
juggle  = 1
velset = 0,0
poweradd = 50
ctrl = 0
sprpriority = 2
anim = 1205

[State 52, 2]
type = PosSet
trigger1 = Time = 0
y = 0

[State 52]
type = Turn
trigger1 = P2dist X < -30

[State 52, End]
type = ChangeState
trigger1 = !AnimTime
value = 0
ctrl = 1

;-------------------------------------------------------------
; hitstate
[Statedef 1255]
type = A
movetype = H
physics = N
ctrl = 0
velset = -4, -12

[State 837, 1]
type = ChangeAnim2
trigger1 = Time = 0
value = 1255

[State 837, 2]
type = AssertSpecial
trigger1 = 1
flag = NoAutoTurn

[State 837, 3]
type = Gravity
trigger1 = 1

[State 837, 4]
type = Selfstate
trigger1 = Time > 0 && Pos Y >= -10
value = 5100
ctrl = 0


;==============================================================================================
;Spin Kick
[Statedef 1300]
type=S
movetype=A
physics=S
ctrl=0
anim=1300
poweradd=25
velset=0,0
sprpriority=1

[State 1000, Vari�vel de for�a]
type = VarSet
trigger1 = !time && !AiLevel
v = 20
value = ifelse (command = "qcf_c",2,(ifelse(command = "qcf_b",1,0)))

[State 1000, Vari�vel de for�a]
type = VarSet
trigger1 = !time && AiLevel
v = 20
value = ifelse(prevstateno = 1000,1,0)

[State 250, Velset when not chained from dash]
type=Velset
triggerall=PrevStateno!=[100,105]
trigger1=Time=0
x=7
y=0

[State 200, Voices]
type = PlaySnd
trigger1 = !time
value = 0,2

[State 250]
type=HitDef
trigger1=time=0
priority=7,Hit
attr=S,SA
guardflag=MA
hitflag=MAF
damage=55
animtype=Hard
air.animtype=Back
fall.animtype=Back
ground.type=High
air.type=Low
getpower=10,5
givepower=11,8 
pausetime=5,11
sparkno = S-1
sparkxy=var(32):=-6,var(33):=-97
hitsound=S0,4
guardsound = S0,10
guard.sparkno = s7004
ground.type = High
ground.slidetime = 12
ground.hittime  = 21
ground.velocity = -6
air.velocity = -2.2,-3.2
ground.cornerpush.veloff = 0
envshake.time = 7
envshake.ampl = 4


[State 250, hitspark heavy]
type=helper 
trigger1= hitpausetime=4;;;;;;;;;;;;;;;;;;;;must be 1 tick under pausetime (or at least under)
trigger1= movehit=1 && numtarget
helpertype=normal
stateno=7002
ID=7002
name="Blood"
postype=p2
pos= (target,const(size.ground.front) + var(32)) * (target,facing) * (-facing), floor(pos y-target,pos y) + var(33)
facing= ifelse((target,facing = facing), 1, -1)
ownpal=1
pausemovetime=65535
supermovetime=65535
ignorehitpause=1

[State 1000]
type=ChangeState
trigger1=AnimTime=0
value=1301+var(20)
ctrl=0

;------------------------------------------------------
;Spin Kick - weak
[Statedef 1301]
type=S
movetype=A
physics=S
ctrl=0
anim=1301
poweradd=25
velset=0,0
sprpriority=1

[State 250, Velset when not chained from dash]
type=Velset
triggerall=PrevStateno!=[100,105]
trigger1=Time=0
x=12
y=0

[State 250, Velset when chained from dash]
type=Velset
triggerall=PrevStateno=100
trigger1=Time<=6
x=ifelse(time>=5,.83,4)
y=0

[State 250]
type=Explod
trigger1=!time
ID=7009
anim=7009
postype=p1
pos=30,0
bindtime=1
scale=.5,.5
sprpriority=3
ownpal=1

[State 200, Voices]
type = PlaySnd
trigger1 = !time
value = 0,2

[State 250]
type=HitDef
trigger1=time=0
priority=7,Hit
attr=S,SA
guardflag=MA
hitflag=MAF
damage=45,0
animtype=Hard
air.animtype=Back
fall.animtype=Back
ground.type=High
air.type=Low
getpower=10,5
givepower=11,8 
pausetime=11,11
sparkno = S-1
sparkxy=var(32):=-6,var(33):=-97
hitsound=S0,8
guardsound = S0,10
guard.sparkno = s7004
ground.type = High
ground.slidetime = 12
ground.hittime  = 21
ground.velocity = -6,-3
air.velocity = -2.2,-3.2
ground.cornerpush.veloff = 0
envshake.time = 7
envshake.ampl = 4
fall=1


[State 250, hitspark heavy]
type=helper 
trigger1= hitpausetime=10;;;;;;;;;;;;;;;;;;;;must be 1 tick under pausetime (or at least under)
trigger1= movehit=1 && numtarget
helpertype=normal
stateno=7002
ID=7002
name="Blood"
postype=p2
pos= (target,const(size.ground.front) + var(32)) * (target,facing) * (-facing), floor(pos y-target,pos y) + var(33)
facing= ifelse((target,facing = facing), 1, -1)
ownpal=1
pausemovetime=65535
supermovetime=65535
ignorehitpause=1

[State 250, 4]
type = ChangeState
triggerall = !AiLevel
trigger1 = command = "qcf_a" && movecontact
value = 1305

[State 250, 4]
type = ChangeState
triggerall = !AiLevel
trigger1 = command = "qcf_b" && movecontact
value = 1302

[State 250, 4]
type = ChangeState
triggerall = !AiLevel
trigger1 = command = "qcf_c" && movecontact
value = 1303

[State 250, 4]
type = ChangeState
triggerall = AiLevel
trigger1 = movecontact && random < 300
value = 1305

[State 250, 4]
type = ChangeState
triggerall = AiLevel
trigger1 = movecontact && random >600
value = 1303


[State 250, 4]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;------------------------------------------------------
;Spin Kick - MEDIUM
[Statedef 1302]
type=S
movetype=A
physics=N
ctrl=0
anim=1302
poweradd=25
velset=0,0
sprpriority=1

[State 250, Velset when not chained from dash]
type=Velset
trigger1 = !time
x=7.5
y=-4
ignorehitpause = 1

[State 0, StateTypeSet]
type = StateTypeSet
trigger1 = !time
statetype = A 
ignorehitpause = 1

[State 0, Gravity]
type = Gravity
trigger1 = 1
ignorehitpause = 1


[State 250]
type=Explod
trigger1=!time
ID=7009
anim=7009
postype=p1
pos=30,0
bindtime=1
scale=.5,.5
sprpriority=3
ownpal=1

[State 200, Voices]
type = PlaySnd
trigger1 = !time
value = 0,2

[State 250]
type=HitDef
trigger1=time=0
priority=7,Hit
attr=S,SA
guardflag=MA
hitflag=MAF
damage=85
animtype=Hard
air.animtype=Back
fall.animtype=Back
ground.type=High
air.type=Low
getpower=10,5
givepower=11,8 
pausetime=11,11
sparkno = S-1
sparkxy=var(32):=-6,var(33):=-67
hitsound=S0,5
guardsound = S0,10
guard.sparkno = s7004
ground.type = High
ground.slidetime = 12
ground.hittime  = 21
ground.velocity = -6,-3
air.velocity = -2.2,-3.2
ground.cornerpush.veloff = 0
envshake.time = 7
envshake.ampl = 4
fall=1


[State 250, hitspark heavy]
type=helper 
trigger1= hitpausetime=10;;;;;;;;;;;;;;;;;;;;must be 1 tick under pausetime (or at least under)
trigger1= movehit=1 && numtarget
helpertype=normal
stateno=7002
ID=7002
name="Blood"
postype=p2
pos= (target,const(size.ground.front) + var(32)) * (target,facing) * (-facing), floor(pos y-target,pos y) + var(33)
facing= ifelse((target,facing = facing), 1, -1)
ownpal=1
pausemovetime=65535
supermovetime=65535
ignorehitpause=1

[State 250, 4]
type = ChangeState
trigger1 = Pos Y >=0 && Vel Y >0
value = 1304
ctrl = 0

;------------------------------------------------------
;Spin Kick - hard
[Statedef 1303]
type=S
movetype=A
physics=N
ctrl=0
anim=1303
poweradd=25
velset=0,0
sprpriority=1

[State 200, Atk Voice]
type = PlaySnd
trigger1 = !time
value = S1301,0+random%2
channel = 0

[State 250]
type=Explod
trigger1=!time
ID=7009
anim=7009
postype=p1
pos=30,0
bindtime=1
scale=.5,.5
sprpriority=3
ownpal=1


[State 250, Velset when not chained from dash]
type=Velset
trigger1 = !time
x=9
y=-6
ignorehitpause = 1

[State 0, StateTypeSet]
type = StateTypeSet
trigger1 = !time
statetype = A 
ignorehitpause = 1

[State 0, Gravity]
type = Gravity
trigger1 = 1

[State 200, Voices]
type = PlaySnd
trigger1=time=0
trigger2 = AnimElem = 5
trigger3 = AnimElem = 8
value = 0,2

[State 250]
type=HitDef
trigger1=time=0
trigger2 = AnimElem = 5
trigger3 = AnimElem = 8
priority=7,Hit
attr=S,SA
guardflag=MA
hitflag=MAF
damage=25
animtype=Hard
air.animtype=Back
fall.animtype=Back
ground.type=High
air.type=Low
getpower=10,5
givepower=11,8 
pausetime=8,8
sparkno = S-1
sparkxy=var(32):=-6,var(33):=-97
hitsound=S0,8
guardsound = S0,10
guard.sparkno = s7004
ground.type = High
ground.slidetime = 12
ground.hittime  = 21
ground.velocity = -6,-5
air.velocity = -2.2,-5.2
ground.cornerpush.veloff = 0
envshake.time = 7
envshake.ampl = 4
fall=1

[State 250]
type=HitDef
trigger1 = AnimElem = 14
priority=7,Hit
attr=S,SA
guardflag=MA
hitflag=MAF
damage=25
animtype=Hard
air.animtype=Back
fall.animtype=Back
ground.type=High
air.type=Low
getpower=10,5
givepower=11,8 
pausetime=11,11
sparkno = S-1
sparkxy=var(32):=-6,var(33):=-97
hitsound=S0,5
guardsound = S0,10
guard.sparkno = s7004
ground.type = High
ground.slidetime = 12
ground.hittime  = 21
ground.velocity = -10,-2
air.velocity = -10,-2
ground.cornerpush.veloff = 0
envshake.time = 7
envshake.ampl = 4
fall=1


[State 250, hitspark heavy]
type=helper 
trigger1= hitpausetime=7;;;;;;;;;;;;;;;;;;;;must be 1 tick under pausetime (or at least under)
trigger1= movehit=1 && numtarget
helpertype=normal
stateno=7002
ID=7002
name="Blood"
postype=p2
pos= (target,const(size.ground.front) + var(32)) * (target,facing) * (-facing), floor(pos y-target,pos y) + var(33)
facing= ifelse((target,facing = facing), 1, -1)
ownpal=1
pausemovetime=65535
supermovetime=65535
ignorehitpause=1

[State 250, 4]
type = ChangeState
trigger1 = Pos Y >=0 && Vel Y >0
value = 1304
ctrl = 0

;------------------------------------------------------
;Spin Kick - Land
[Statedef 1304]
type=S
movetype=I
physics=S
ctrl=0
anim=1304
velset=0,0
sprpriority=1

[State 0, PosSet]
type = PosSet
trigger1 = !time
y = 0
ignorehitpause = 1

[State 250, 4]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;------------------------------------------------------
;Spin Kick - follow 1
[Statedef 1305]
type=S
movetype=A
physics=S
ctrl=0
anim=1305
poweradd=25
velset=0,0
sprpriority=1

[State 250, Velset when not chained from dash]
type=Velset
trigger1=Time=0
x=12

[State 250, Velset when not chained from dash]
type=Velset
trigger1=AnimElem = 8
x=16

[State 250]
type=Explod
trigger1=!time
ID=7009
anim=7009
postype=p1
pos=30,0
bindtime=1
scale=.5,.5
sprpriority=3
ownpal=1

[State 200, Voices]
type = PlaySnd
trigger1=time=0
value = 0,2

[State 250]
type=HitDef
trigger1=time=0
priority=7,Hit
attr=S,SA
guardflag=MA
hitflag=MAF
damage=25
animtype=Hard
air.animtype=Back
fall.animtype=Back
ground.type=High
air.type=Low
getpower=10,5
givepower=11,8 
pausetime=11,11
sparkno = S-1
sparkxy=var(32):=-6,var(33):=-97
hitsound=S0,4
guardsound = S0,10
guard.sparkno = s7004
ground.type = High
ground.slidetime = 12
ground.hittime  = 21
ground.velocity = -6,-3
air.velocity = -2.2,-3.2
ground.cornerpush.veloff = 0
envshake.time = 7
envshake.ampl = 4
fall=1

[State 250]
type=HitDef
trigger1=AnimElem=9
priority=7,Hit
attr=S,SA
guardflag=MA
hitflag=MAF
damage=25
animtype=Hard
air.animtype=Back
fall.animtype=Back
ground.type=High
air.type=Low
getpower=10,5
givepower=11,8 
pausetime=11,11
sparkno = S-1
sparkxy=var(32):=-6,var(33):=-97
hitsound=S0,8
guardsound = S0,10
guard.sparkno = s7004
ground.type = High
ground.slidetime = 12
ground.hittime  = 21
ground.velocity = -6,-3
air.velocity = -2.2,-3.2
ground.cornerpush.veloff = 0
envshake.time = 7
envshake.ampl = 4
fall=1


[State 250, hitspark heavy]
type=helper 
trigger1= hitpausetime=10;;;;;;;;;;;;;;;;;;;;must be 1 tick under pausetime (or at least under)
trigger1= movehit=1 && numtarget
helpertype=normal
stateno=7002
ID=7002
name="Blood"
postype=p2
pos= (target,const(size.ground.front) + var(32)) * (target,facing) * (-facing), floor(pos y-target,pos y) + var(33)
facing= ifelse((target,facing = facing), 1, -1)
ownpal=1
pausemovetime=65535
supermovetime=65535
ignorehitpause=1

[State 250, 4]
type = ChangeState
triggerall = !AiLevel
trigger1 = command = "qcf_a" && movecontact && AnimElemTime(9)>0
value = 1306

[State 250, 4]
type = ChangeState
triggerall = !AiLevel
trigger1 = command = "qcf_b" && movecontact && AnimElemTime(9)>0
value = 1302

[State 250, 4]
type = ChangeState
triggerall = !AiLevel
trigger1 = command = "qcf_c" && movecontact && AnimElemTime(9)>0
value = 1303

[State 250, 4]
type = ChangeState
triggerall = AiLevel
trigger1 = movecontact && AnimElemTime(9)>0 && random < 300
value = 1306

[State 250, 4]
type = ChangeState
triggerall = AiLevel
trigger1 = movecontact && AnimElemTime(9)>0 && random >600
value = 1303



[State 250, 4]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1


;------------------------------------------------------
;Spin Kick - follow 2
[Statedef 1306]
type=S
movetype=A
physics=S
ctrl=0
anim=1306
poweradd=25
velset=0,0
sprpriority=1

[State 200, Atk Voice]
type = PlaySnd
trigger1 = AnimElem = 6
value = S7,2+random%2

[State 250, Velset when not chained from dash]
type=Velset
trigger1 = AnimElem =3
x=12

[State 250, Velset when not chained from dash]
type=Velset
trigger1 = AnimElem = 7
x=7.5
y=-5
ignorehitpause = 1

[State 0, StateTypeSet]
type = StateTypeSet
trigger1 = AnimElem = 7
statetype = A 
ignorehitpause = 1

[State 0, Gravity]
type = Gravity
trigger1 = AnimElemTime(8)>1
ignorehitpause = 1

[State 250]
type=Explod
trigger1=!time
ID=7009
anim=7009
postype=p1
pos=30,0
bindtime=1
scale=.5,.5
sprpriority=3
ownpal=1

[State 200, Voices]
type = PlaySnd
trigger1=time=0
value = 0,2

[State 250]
type=HitDef
trigger1=time=0
priority=7,Hit
attr=S,SA
guardflag=MA
hitflag=MAF
damage=45
animtype=Hard
air.animtype=Back
fall.animtype=Back
ground.type=High
air.type=Low
getpower=10,5
givepower=11,8 
pausetime=11,11
sparkno = S-1
sparkxy=var(32):=-6,var(33):=-97
hitsound=S0,5
guardsound = S0,10
guard.sparkno = s7004
ground.type = High
ground.slidetime = 12
ground.hittime  = 21
ground.velocity = -6,-3
air.velocity = -2.2,-3.2
ground.cornerpush.veloff = 0
envshake.time = 7
envshake.ampl = 4
fall=1

[State 250]
type=HitDef
trigger1=AnimElem=9
priority=7,Hit
attr=S,SA
guardflag=MA
hitflag=MAF
damage=25
animtype=Hard
air.animtype=Back
fall.animtype=Back
ground.type=High
air.type=Low
getpower=10,5
givepower=11,8 
pausetime=11,11
sparkno = S-1
sparkxy=var(32):=-6,var(33):=-97
hitsound=S0,8
guardsound = S0,10
guard.sparkno = s7004
ground.type = High
ground.slidetime = 12
ground.hittime  = 21
ground.velocity = -6,-3
air.velocity = -2.2,-3.2
ground.cornerpush.veloff = 0
envshake.time = 7
envshake.ampl = 4
fall=1


[State 250, hitspark heavy]
type=helper 
trigger1= hitpausetime=10;;;;;;;;;;;;;;;;;;;;must be 1 tick under pausetime (or at least under)
trigger1= movehit=1 && numtarget
helpertype=normal
stateno=7002
ID=7002
name="Blood"
postype=p2
pos= (target,const(size.ground.front) + var(32)) * (target,facing) * (-facing), floor(pos y-target,pos y) + var(33)
facing= ifelse((target,facing = facing), 1, -1)
ownpal=1
pausemovetime=65535
supermovetime=65535
ignorehitpause=1

[State 250, 4]
type = ChangeState
trigger1 = Pos Y >=0 && Vel Y >0
value = 1304
ctrl = 0

;---------------------------------------------------------------------------
; Smoke Teleport
[Statedef 1400]
type    = S
movetype= A
physics = S
juggle  = 4
poweradd= 75
velset = 0,0
anim = 1400
ctrl = 0
sprpriority = 2

[State 1000, Vari�vel de for�a]
type = VarSet
trigger1 =!time && !AiLevel
v = 20
value = ifelse (command = "qcb_c",6,(ifelse(command = "qcb_b",3,0)))

[State 1000, Vari�vel de for�a]
type = VarSet
trigger1 =!time && AiLevel
v = 20
value = ifelse(P2BodyDist X >40 && P2BodyDist X<100,3,ifelse(p2bodydist X > 140 && P2bodyDist X < 180,6,0))

[State 0, ChangeState]
type = ChangeState
trigger1 =!time && AiLevel && var(20) = 0
value = 1000
ctrl = 0
;anim =
;ignorehitpause = 
;persistent = 


[State 1400, 1]
type = PlaySnd
trigger1 = animelem = 5
value = s1400,0

[State 1400, Projectile]
type = Projectile
trigger1 = AnimElem = 5
ProjID = 8000
projanim = 7012;1405
projhitanim = 7012;1405
projremanim = 7012;1405
projcancelanim = 7012;1405
projremove = 1
projremovetime = 20
velocity = 0,0
remvelocity = 0,0
accel = 0,0
velmul = 1
projhits = 1
projmiss = 0
projpriority = 1
projsprpriority = 3
projedgebound = 120
projstagebound = 40
projheightbound = -240
offset = 20,7
postype = p1         ;p2,front,back,left,right
projshadow = 0,0,0
supermovetime = 0
pausemovetime = 0
; HitDef
attr = S, NA
animtype  = Medium
damage    = 10, 2
guardflag = MA
pausetime = 12,12
sparkno = s8224
sparkxy = 0,-10
hitsound   = S220,1
guardsound = S120,0
guard.sparkno = s8650
ground.type = High
ground.slidetime = 15
ground.hittime  = 15
ground.velocity = -1
air.velocity = -2.5,-4
palfx.color = 0
palfx.time = 28
palfx.mul = 256,256,256
palfx.add = 100,100,100
palfx.sinadd = -80,-80,-80,10

[State 250]
type=Explod
trigger1=AnimElem = 1
ID=7009
anim=7009
postype=p1
pos=30,0
bindtime=1
scale=.5,.5
sprpriority=3
ownpal=1

[State 1400, 7]
type = ChangeState
trigger1 = !AnimTime
value = 1410
ctrl = 1

;---------------------------------------------------------------------------
; Teleport - stage 2
[Statedef 1410]
type    = A
movetype= A
physics = N
juggle  = 4
poweradd= 75
velset = 0,5
anim = 1410
ctrl = 0
sprpriority = 2

[State 0, PosAdd]
type = PosAdd
trigger1 = !time
x = 30+(var(20)*30)
y = -180

[State 0, VelAdd]
type = VelAdd
trigger1 = 1
y = 0.25

[State 0, Explod]
type = Explod
trigger1 = !time
anim = 7171;1406
ID = 1406
pos = 0,-30
postype = p1  ;p2,front,back,left,right
sprpriority = 100
ownpal = 1
scale = 0.75,0.75


[State 0, AssertSpecial]
type = AssertSpecial
trigger1 = time = [0,6]
flag = invisible
flag = noshadow

[State 1400, 1]
type = PlaySnd
trigger1 = !time
value = s1400,0

[State 250]
type=HitDef
trigger1 = !time
priority=7,Hit
attr=A,SA
guardflag=MA
hitflag=MAF
damage=25
animtype=Hard
air.animtype=Back
fall.animtype=Back
ground.type=High
air.type=Low
getpower=10,5
givepower=11,8 
pausetime=5,11
sparkno = S-1
sparkxy=var(32):=-6,var(33):=-97
hitsound=S0,5
guardsound = S0,10
guard.sparkno = s7004
ground.type = High
ground.slidetime = 12
ground.hittime  = 21
ground.velocity = -10,-2
air.velocity = -10,-2
ground.cornerpush.veloff = 0
envshake.time = 7
envshake.ampl = 4
fall=1

[State 250, hitspark heavy]
type=helper 
trigger1= hitpausetime=4;;;;;;;;;;;;;;;;;;;;must be 1 tick under pausetime (or at least under)
trigger1= movehit=1 && numtarget
helpertype=normal
stateno=7003
ID=7003
name="Blood"
postype=p1
pos= 0,0;(target,const(size.ground.front) + var(32)) * (target,facing) * (-facing), floor(pos y-target,pos y) + var(33)
facing= ifelse((target,facing = facing), 1, -1)
ownpal=1
pausemovetime=65535
supermovetime=65535
ignorehitpause=1

[State 0, ChangeState]
type = ChangeState
trigger1= movehit=1 && numtarget
value = 1420
ctrl = 0
;anim =
;ignorehitpause = 
;persistent = 


[State 250, 4]
type = ChangeState
trigger1 = Pos Y >=0 && Vel Y >0
value = 1415
ctrl = 0

;------------------------------------------------------
;Teleport Land
[Statedef 1415]
type=S
movetype=I
physics=S
ctrl=0
anim=1415
velset=0,0
sprpriority=1

[State 0, PosSet]
type = PosSet
trigger1 = !time
y = 0
ignorehitpause = 1

[State 101, dash dust]
type=Explod
Anim=7008
trigger1=time=0
postype=P1
pos=0,0
bindTime=1
sprpriority=-1
vel=0,0
ownpal=1
removeongethit=1


[State -3, Landing Sound]
type = PlaySnd
trigger1 = Time = 1
value = 47, 0

[State 250, 4]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl =1

;------------------------------------------------------
;Spin Kick - MEDIUM
[Statedef 1420]
type=S
movetype=A
physics=N
ctrl=0
anim=1420
velset=0,0
sprpriority=1

[State 0, PlaySnd]
type = PlaySnd
trigger1 = !time && random < 500
value = S1300,0
channel = 0

[State 250, Velset when not chained from dash]
type=Velset
trigger1 = AnimElem=2
x=-5.5
y=-7
ignorehitpause = 1

[State 0, StateTypeSet]
type = StateTypeSet
trigger1 = !time
statetype = A 
ignorehitpause = 1

[State 0, Gravity]
type = Gravity
trigger1 = 1
ignorehitpause = 1

[State 200, Voices]
type = PlaySnd
trigger1 = !time
value = 0,2


[State 250, 4]
type = ChangeState
trigger1 = Pos Y >=0 && Vel Y >0
value = 1415
ctrl = 0

;==============================================================================================
; Reversal Battons
[Statedef 1500]
type=S
movetype=A
physics=S
ctrl=0
poweradd=25
velset=0,0
sprpriority=1

[State 250, DUST]
type=Explod
trigger1=AnimElem = 1
ID=7009
anim=7009
postype=p1
pos=30,0
bindtime=1
scale=.5,.5
sprpriority=3
ownpal=1

[State 1000, Vari�vel de for�a]
type = VarSet
trigger1 = !time
v = 20
value = ifelse (command = "qcb_x",2,(ifelse(command = "qcb_y",1,0)))

[State 0, ChangeAnim]
type = ChangeAnim
trigger1 = !time 
value = 1500+var(20)

[State 0, ReversalDef]
type = ReversalDef
trigger1 = !time && var(20)=0
reversal.attr = A,NA,SA,HA           ;SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
pausetime = 5,10
sparkno =  s7004
;sparkxy = 0,0 ;offset
hitsound = S0,10
p1stateno = Anim+10

[State 0, ReversalDef]
type = ReversalDef
trigger1 = !time && var(20)=1
reversal.attr = S,NA,SA,HA           ;SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
pausetime = 5,10
sparkno =  s7004
;sparkxy = 0,0 ;offset
hitsound = S0,10
p1stateno = Anim+10

[State 0, ReversalDef]
type = ReversalDef
trigger1 = !time && var(20)=2
reversal.attr = C,NA,SA,HA           ;SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
pausetime = 5,10
sparkno =  s7004
;sparkxy = 0,0 ;offset
hitsound = S0,10
p1stateno = Anim+10

[State 0, PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 2
value = S3,2

[State 0, ChangeState]
type = ChangeState
trigger1 = !Animtime
value = 0
ctrl = 1

;==============================================================================================
; Shock Battoms
[Statedef 1600]
type=S
movetype=A
physics=S
ctrl=0
poweradd=25
velset=0,0
sprpriority=1
anim = 1600

[State 250, DUST]
type=Explod
trigger1=AnimElem = 3
ID=7009
anim=7009
postype=p1
pos=30,0
bindtime=1
scale=.5,.5
sprpriority=3
ownpal=1

[State 1000, Vari�vel de for�a]
type = VarSet
trigger1 = !time
v = 20
value = ifelse (command = "qcb_x",0,(ifelse(command = "qcb_y",10,15)))

[State 0, VelSet]
type = VelSet
trigger1 = AnimElem = 3
x = var(20)


[State 0, Explod]
type = Explod
trigger1 = AnimElem = 3
anim = 1605
ID = 1605
pos = 64,-84
postype = p1  ;p2,front,back,left,right
facing = 1
vfacing = 1
bindtime = 11
vel = 0,0
accel = 0,0
random = 0,0
removetime = -2
pausemovetime = 0
scale = 0.75,0.75
sprpriority = 5
ontop = 0
shadow = 0,0,0
ownpal = 1
removeongethit = 1


[State 0, Explod]
type = Explod
trigger1 = AnimElem = 3
anim = 1605
ID = 1605
pos = -38,-116
postype = p1  ;p2,front,back,left,right
facing = 1
vfacing = 1
bindtime = 11
vel = 0,0
accel = 0,0
random = 0,0
removetime = -2
pausemovetime = 0
scale = 0.75,0.75
sprpriority = 5
ontop = 0
shadow = 0,0,0
ownpal = 1
removeongethit = 1

[State 0, PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 3
value = S220,1+random%2

[State 210, 2]
type = HitDef
trigger1 = !Time && var(35) = 20001
attr = S, NA
animtype  = Heavy
damage    = 50,1
guardflag = H
pausetime = 10,10
sparkno = S-1
sparkxy=var(32):=-34,var(33):=-70;;;;;;;;;must be like this for blood to have accurate x,y
hitsound=S0,5
guardsound = S0,9
guard.sparkno = s7004;;;s7004
ground.type = High
ground.slidetime = 12
ground.hittime  = 13
ground.velocity = -8,-6
air.velocity = -8,-6
palfx.time = 40
palfx.add = 100,100,250
palfx.mul = 200,200,256
palfx.sinadd = -100,-100,-80,4
palfx.color = 0;
fall = 1
fall.recover = 0
envshake.time = 7
envshake.ampl = 4

[State 210, hitspark medium]
type=helper 
trigger1= hitpausetime=9;;;;;;;;;;;;;;;;;;;;must be 1 tick under pausetime (or at least under)
trigger1= movehit=1 && numtarget
helpertype=normal
stateno=7001
ID=7001
name="Blood"
postype=p2
pos= (target,const(size.ground.front) + var(32)) * (target,facing) * (-facing), floor(pos y-target,pos y) + var(33)
facing= ifelse((target,facing = facing), 1, -1)
ownpal=1
pausemovetime=65535
supermovetime=65535
ignorehitpause=1


[State 0, ChangeState]
type = ChangeState
trigger1 = !Animtime
value = 0
ctrl = 1

;==============================================================================================
; Reversal Battons L
[Statedef 1510]
type=C
movetype=A
physics=C
ctrl=0
poweradd=25
velset=0,0
sprpriority=1
anim = 450

[State 0, NotHitBy]
type = NotHitBy
trigger1 = 1
value = SCA
time = 1

[State 250, DUST]
type=Explod
trigger1=AnimElem = 1
ID=7009
anim=7009
postype=p1
pos=30,0
bindtime=1
scale=.5,.5
sprpriority=3
ownpal=1


[State 450]
type=HitDef
trigger1=time=0
priority=5,Hit
attr=C,NA
damage =60
animtype = Hard
air.animtype = hard
fall.animtype = hard
getpower=30,15
givepower=15,8
hitflag=MAFD
guardflag=L
pausetime=10,8
sparkno=S7002
guard.sparkno=S7004
sparkxy=var(32):=-26,var(33):=-16
hitsound=S0,8
guardsound=S0,10
ground.type = trip
air.type = trip
ground.slidetime = 0
ground.hittime = 25
ground.cornerpush.veloff = 0
ground.velocity =0,-2.7
air.velocity =-1.4,-2.7
sprpriority = 1
persistent = 0
envshake.time = 5
envshake.freq = 60
envshake.ampl = -4
envshake.phase = 90
down.velocity = -1.12,-2.4
down.hittime = 20
p2stateno = 452


[State 0, ChangeState]
type = ChangeState
trigger1 = !Animtime
value = 0
ctrl = 1

;==============================================================================================
; Reversal Battons M
[Statedef 1511]
type=C
movetype=A
physics=C
ctrl=0
poweradd=25
velset=0,0
sprpriority=1
anim = 1511

[State 0, NotHitBy]
type = NotHitBy
trigger1 = 1
value = SCA
time = 1

[State 250, DUST]
type=Explod
trigger1=AnimElem = 1
ID=7009
anim=7009
postype=p1
pos=30,0
bindtime=1
scale=.5,.5
sprpriority=3
ownpal=1

[State 220]
type=HitDef
trigger1=time=0 
priority=4,Hit
attr=S,NA
guardflag=MA
hitflag=MAF
damage=50
animtype=Hard
air.animtype=Back
fall.animtype=Back
air.type=Low
getpower=10,5
givepower=11,8 
pausetime=5,11
sparkno = S-1
sparkxy=var(32):=-34,var(33):=-75;-50;;;;;;;;;must be like this for blood to have accurate x,y
hitsound= S0,5 ;S220,1
guardsound = S0,11
guard.sparkno = s7005;;;s7004
ground.type = high
ground.slidetime = 12
ground.hittime  = 13
ground.velocity = -10
air.velocity = -2.5,-4
envshake.time = 7
envshake.ampl = 4

[State 220, hitspark heavy]
type=helper 
trigger1= hitpausetime=4;;;;;;;;;;;;;;;;;;;;must be 1 tick under pausetime (or at least under)
trigger1= movehit=1 && numtarget
helpertype=normal
stateno=7002
ID=7002
name="Blood"
postype=p2
pos= (target,const(size.ground.front) + var(32)) * (target,facing) * (-facing), floor(pos y-target,pos y) + var(33)
facing= ifelse((target,facing = facing), 1, -1)
ownpal=1
pausemovetime=65535
supermovetime=65535
ignorehitpause=1


[State 0, ChangeState]
type = ChangeState
trigger1 = !Animtime
value = 0
ctrl = 1

;==============================================================================================
; Reversal Battons H
[Statedef 1512]
type=C
movetype=A
physics=C
ctrl=0
poweradd=25
velset=0,0
sprpriority=1
anim = 420

[State 0, NotHitBy]
type = NotHitBy
trigger1 = 1
value = SCA
time = 1

[State 250, DUST]
type=Explod
trigger1=AnimElem = 1
ID=7009
anim=7009
postype=p1
pos=30,0
bindtime=1
scale=.5,.5
sprpriority=3
ownpal=1

[State 420]
type=HitDef
trigger1=time=0
priority=5,Hit
attr = C, NA
animtype=Hard
air.animtype=Back
fall.animtype=Back
ground.type=Low
air.type=Low
damage =50
getpower = 30,15
givepower = 15,8
guardflag = MA
hitflag = MAFD
pausetime=10,7
sparkno = s7003
guard.sparkno = s7004
sparkxy=var(32):=-30,var(33):=-95
hitsound   = S0,5
guardsound = S0,9
ground.type = Low
ground.slidetime = 20
ground.hittime  = 25
ground.velocity = 0,-6
ground.cornerpush.veloff = 0
air.velocity = 0,-6
p2stateno = 429

[State 0, ChangeState]
type = ChangeState
trigger1 = !Animtime
value = 0
ctrl = 1


;==============================================================================================
; Spinning Bo
[Statedef 1700]
type=S
movetype=A
physics=S
ctrl=0
poweradd=25
velset=0,0
sprpriority=1
anim = 1700

[State 250, DUST]
type=Explod
trigger1=AnimElem = 1
ID=7009
anim=7009
postype=p1
pos=30,0
bindtime=1
scale=.5,.5
sprpriority=3
ownpal=1

[State 0, PlaySnd]
type = PlaySnd
trigger1 = time%12=0
value = S3,1

[State 0, NotHitBy]
type = NotHitBy
trigger1 = AnimElem = 1
value = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
time = 3

[State 1400, 1]
type = ReversalDef
trigger1 = (AnimElemTime(1) >= 0)&&(AnimElemTime(5) <= 2)
reversal.attr = SCA,NP,SP ;HP No for Hypers
sparkno = -1
hitsound   = S7,6
priority = 7,Hit
p2stateno = 1710
p1stateno = 1701
ignorehitpause = 1

[State 1400, 2]
type = hitoverride
trigger1 =(AnimElemTime(1) >= 0)&&(AnimElemTime(13) <= 2)
time = 1
attr = SCA,NP,SP
stateno = 1702
ignorehitpause = 1
slot=1

[State 0, ChangeState]
type = ChangeState
trigger1 = !Animtime
value = 0
ctrl = 1

;--------------------------------------------
; MIRROR COUNTER
[Statedef 1701]
type    = S
movetype= I
physics = S
velset = 0,0
ctrl = 0
poweradd = 45
anim = 20220;1701

[State 1401, 1];one more for multi hit 
type = ReversalDef
trigger1 = !time
reversal.attr = SCA,NP,SP ;NO HYPERS
sparkno = -1
hitsound   = S7,6
priority = 7,Hit
p2stateno = 1710
p1stateno = 1701

[State 0, PlaySnd]
type = PlaySnd
trigger1 = AnimElem = 2
value = S1600,1

[State 0, ChangeState]
type = ChangeState
trigger1 = !AnimTime 
value = 0
ctrl = 1

;--------------------------------------------
; MIRROR COUNTER 2
[Statedef 1702]
type    = S
movetype= I
physics = S
velset = 0,0
ctrl = 0
poweradd = 45
anim = 20220;1701


[State 1402, 2]
type = Projectile
triggerall = !NumProjID(1615)
trigger1 = AnimElem = 2
projid = 1615
projanim = 1615
projhitanim = 1616;1460
postype = P1
offset = 35,-40
projsprpriority = 3
projpriority = 4
velocity = var(4),0
attr = S, SP
damage = ifelse(p2movetype = H,10,100),7
animtype  = Heavy
hitflag = MAF
guardflag = MA
priority = 4, Hit
pausetime = 6,6
guard.pausetime = 0,6
sparkno = S7002;0
guard.sparkno = s6767
sparkxy = 15,-10
hitsound = s8000,2
guardsound = s8500,0
fall.envshake.time = 5
fall.envshake.ampl = -3
ground.type = High
ground.slidetime = 20
ground.hittime  = 20
ground.velocity = -8
air.type = Low
air.velocity = -5,-4
air.fall = 1
ground.cornerpush.veloff=0
envshake.time = 15
envshake.ampl = 10


[State 0, ChangeState]
type = ChangeState
trigger1 = !AnimTime 
value = 0
ctrl = 1

;------------------------------------------
; PROJ
[Statedef 1710]
type = A
physics = N
movetype = A
sprpriority = 3
ctrl = 0

[State 1410, a0];prevent bind projectiles like thor's thunderstrike
type = BindToRoot
trigger1 = !time
time = 0

[State 1410, a2]
type = VelSet
trigger1 =!time && vel x >0
x = -10.5
y = ifelse (pos Y >=0,0,-vel y)

[State 1410, a3]
type = turn
trigger1 = !time

[State 1410, ax]
type = posset
trigger1 = enemy,facing=1 && !time
x =enemy,pos x + 50
[State 1410, ax]
type = posset
trigger1 = enemy,facing=-1 && !time
x =enemy,pos x - 50


[State 1410, a4]
type = nothitby
trigger1 = 1
time = -1
value = SCA,AA,AT
ignorehitpause = 1

[State 1410, a6]
type = hitdef
trigger1 = time = 5
priority = 6,Hit
affectteam = F
attr = A,SP
damage = 100,7
animtype = Hard
hitflag = MAF
guardflag = MA
pausetime = 3,3
sparkxy = 0,0
sparkno = 1
guard.sparkno = s6767
hitsound = s8000,2
guardsound = s8500,0
ground.type = High               
ground.slidetime = 15
ground.hittime  = 25             
ground.velocity = -5
airguard.velocity = -1     
air.type = High                  
air.velocity = -4, -2           
air.hittime = 25
ground.cornerpush.veloff=0
air.fall = 1
p2facing = 1
fall = 1
fall.recover = 0
envshake.time = 15
envshake.ampl = 10

[State 1410, a1]
type = assertspecial
trigger1 = 1
flag = noshadow
ignorehitpause = 1

[State 1410, Safety]; for dcvsmarvel cap's shield
type = SelfState
trigger1 = name="Captain America"
trigger1 = MoveContact || FrontEdgeDist < -85 ||  BackEdgeDist < -85
value = 2100005
ignorehitpause = 1

[State 1410, a7]
type = destroyself
trigger1 = MoveContact || FrontEdgeDist < -85 ||  BackEdgeDist < -85
Trigger2 = vel x = 0  ;for helpers like thor bifrost break
Trigger3 = time >= 130 ;safety
Trigger4 = prevstateno=1410;safety stuck on colisions
ignorehitpause =1

[State 0, RemoveExplod]
type = RemoveExplod
trigger1 = MoveContact; && name="Burst Man"
id = 6023

[State 1410, Safety]
type = SelfState
trigger1 = !IsHelper
value = 5050

;---------------------- Integer variable list ----------------------

; var(0):= 2184 - Placeholder Helper
;          1191 - HANDGLIDER
;          1192 - Jaguar's State
;          7500 - Flying Screen Effect (Vs series feature, Aerial Rave Only) - by FerchogtX
;          7500 - Flying Screen Effect (Vs series feature, Aerial Rave Only) - by FerchogtX
; var(1):= 184 - WIN JUMP TO CEILING
;          2184 - Placeholder Helper
;          1191 - HANDGLIDER
;          7500 - Flying Screen Effect (Vs series feature, Aerial Rave Only) - by FerchogtX
;          7500 - Flying Screen Effect (Vs series feature, Aerial Rave Only) - by FerchogtX
;          50 - jump Up
; var(2):= 184 - WIN JUMP TO CEILING
;          2184 - Placeholder Helper
; var(3):= 102 - AIR DASH
;          107 - AIR DASH Back
;          2191 - JUMP OFF HANDGLIDER
; var(4):= 1200 - Justice Upper
; var(5):= 184 - WIN JUMP TO CEILING
;          600 - Jump Light Punch
;          610 - Jump Medium Punch
;          620 - Jump Strong Punch
;          630 - Jump Light Kick
;          640 - Jump Medium Kick
;          650 - Jump Strong Kick
;          -2
; var(6):= 115 - Taunt
;          625 - Jump Strong Punch
;          655 - Jump Strong Kick
;          -2
; var(8):= 9011 - This is the character's state where he/she is being knocked out when the stun meter has reached it's limit.
;          -2
; var(9):= 9004 - Dizzy Button Mash state
;var(10):= 700 - Guard Push Standing
;          705 - Guard Push Crouching
;var(12):= -2
;var(13):= -2
;var(14):= -3
;var(17):= 40 - Jump Start
;var(18):= -2
;var(20):= 1000 - Throw Batrangs
;          1005 - Batrangs
;          1300 - Spin Kick
;          1400 - Smoke Teleport
;          1500 - Reversal Battons
;          1600 - Shock Battoms
;          3000 - HYPER 1
;var(25):= -2
;var(31):= 942 - Recovery Roll Forward
;          943 - Recovery Roll Back
;var(32):= 200 - Stand Light Punch
;          210 - Standing Medium punch
;          220 - Standing strong punch
;          230 - Standing light kick
;          240 - Standing medium kick
;          250 - Standing hard kick
;          400 - Crouching light punch
;          410 - Crouching medium punch
;          420 - Crouching strong punch
;          430 - Crouching light kick
;          440 - Crouch Medium Kick
;          450 - Crouching Hard Kick
;          600 - Jump Light Punch
;          610 - Jump Medium Punch
;          620 - Jump Strong Punch
;          630 - Jump Light Kick
;          640 - Jump Medium Kick
;          650 - Jump Strong Kick
;          801 - Stand Punch Throw - Throwing Opponent
;          811 - Ground Throw Kicks P1 State
;          851 - Air Throw - Throwing Opponent
;          896 - P1 GROUND THROW TECH HIT STATE
;          897 - P2 GROUND THROWN TECH HIT STATE
;          898 - P2 AIR THROW TECH HIT State
;          899 - P1 AIR THROW TECH HIT STATE
;          1005 - Batrangs
;          1200 - Justice Upper
;          1300 - Spin Kick
;          1301 - Spin Kick - weak
;          1302 - Spin Kick - MEDIUM
;          1303 - Spin Kick - hard
;          1305 - Spin Kick - follow 1
;          1306 - Spin Kick - follow 2
;          1410 - Teleport - stage 2
;          1600 - Shock Battoms
;          1510 - Reversal Battons L
;          1511 - Reversal Battons M
;          1512 - Reversal Battons H
;var(33):= 200 - Stand Light Punch
;          210 - Standing Medium punch
;          220 - Standing strong punch
;          230 - Standing light kick
;          240 - Standing medium kick
;          250 - Standing hard kick
;          400 - Crouching light punch
;          410 - Crouching medium punch
;          420 - Crouching strong punch
;          430 - Crouching light kick
;          440 - Crouch Medium Kick
;          450 - Crouching Hard Kick
;          600 - Jump Light Punch
;          610 - Jump Medium Punch
;          620 - Jump Strong Punch
;          630 - Jump Light Kick
;          640 - Jump Medium Kick
;          650 - Jump Strong Kick
;          5080 - HITL_SHAKE
;          1005 - Batrangs
;          1200 - Justice Upper
;          1300 - Spin Kick
;          1301 - Spin Kick - weak
;          1302 - Spin Kick - MEDIUM
;          1303 - Spin Kick - hard
;          1305 - Spin Kick - follow 1
;          1306 - Spin Kick - follow 2
;          1410 - Teleport - stage 2
;          1600 - Shock Battoms
;          1510 - Reversal Battons L
;          1511 - Reversal Battons M
;          1512 - Reversal Battons H
;var(35):= 1100 - Mode Change
;var(40):= 940 - Lie Down Recovery Roll Forward
;          941 - Lie Down Recovery Roll back
;          942 - Recovery Roll Forward
;          943 - Recovery Roll Back
;var(41):= -2
;var(47):= -2
;var(50):= 101 - RUN_FWD LAND
;          400 - Crouching light punch
;var(51):= 811 - Ground Throw Kicks P1 State
;          -3
;var(53):= 5900 - initialize (at the start of the round)
;var(54):= 100 - Dash Forward
;          105 - RUN_BACK
;          50 - jump Up
;          52 - jump land
;          140 - GUARD (end)
;          5040 - HITA_RECOV (recovering in air, not falling)
;          -3
;var(57):= 3000 - HYPER 1
;var(58):= 9600
;          9650 - NORMAL ATTACK KO HELPER STATE
;          9650 - NORMAL ATTACK KO HELPER STATE
;          -3

;---------------------- Float variable list ----------------------

; fvar(0):= 2184 - Placeholder Helper
;          811 - Ground Throw Kicks P1 State
;          7500 - Flying Screen Effect (Vs series feature, Aerial Rave Only) - by FerchogtX
;          7500 - Flying Screen Effect (Vs series feature, Aerial Rave Only) - by FerchogtX
; fvar(1):= 7500 - Flying Screen Effect (Vs series feature, Aerial Rave Only) - by FerchogtX
;          7500 - Flying Screen Effect (Vs series feature, Aerial Rave Only) - by FerchogtX
; fvar(2):= 7500 - Flying Screen Effect (Vs series feature, Aerial Rave Only) - by FerchogtX
;          7500 - Flying Screen Effect (Vs series feature, Aerial Rave Only) - by FerchogtX
; fvar(5):= 420 - Crouching strong punch
;          751 - Alpha Counter
;          752 - Alpha Counter Crouching
;          3000 - HYPER 1
;          -3
;fvar(10):= 1 - stand fx
;          -2
;fvar(12):= -2

