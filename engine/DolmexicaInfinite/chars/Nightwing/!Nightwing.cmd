[Remap]
x = x
y = y
z = z
a = a
b = b
c = c
s = s

[Defaults]
command.time=15
command.buffer.time=1

;==========================================CHARGE BACK THEN FORWARD========================== 
[command]
name = "charge_x"
command = ~40$B,F,x
time = 10
[command]
name = "charge_y"
command = ~40$B,F,y
time = 10
[command]
name = "charge_z"
command = ~40$B,F,z
time = 10
[command]
name = "charge_a"
command = ~40$B,F,a
time = 10
[command]
name = "charge_b"
command = ~40$B,F,b
time = 10
[command]
name = "charge_c"
command = ~40$B,F,c
time = 10

;---------------------------------------------------------------------------
; Power Sets
;---------------------------------------------------------------------------

[Command]
name = "Buster01"
command = ~D, D, a
time = 12

[Command]
name = "Buster02"
command = ~D, D, b
time = 12

[Command]
name = "Buster03"
command = ~D, D, c
time = 12

[Command]
name = "Buster04"
command = ~D, D, x
time = 12

[Command]
name = "Buster05"
command = ~D, D, y
time = 12

[Command]
name = "Buster06"
command = ~D, D, z
time = 12
;===============================================HOLD BUTTON====================================
[command]
name = "hold x"
command = /$x
time = 1
[command]
name = "hold y"
command = /$y
time = 1
[command]
name = "hold z"
command = /$z
time = 1
[command]
name = "hold a"
command = /$a
time = 1
[command]
name = "hold b"
command = /$b
time = 1
[command]
name = "hold c"
command = /$c
time = 1

;========================================DRAGON PUNCH SINGLE BUTTON============================
[command]
name = "dp_x"
command = ~F, D, DF, x
[command]
name = "dp_y"
command = ~F, D, DF, y
[command]
name = "dp_z"
command = ~F, D, DF, z
[command]
name = "dp_a"
command = ~F, D, DF, a
[command]
name = "dp_b"
command = ~F, D, DF, b
[command]
name = "dp_c"
command = ~F, D, DF, c

;==========================================FIREBALL SINGLE BUTTON==============================
[command]
name = "qcf_x"
command = ~D, DF, F, x
[command]
name = "qcf_y"
command = ~D, DF, F, y
[command]
name = "qcf_z"
command = ~D, DF, F, z
[command]
name = "qcf_a"
command = ~D, DF, F, a
[command]
name = "qcf_b"
command = ~D, DF, F, b
[command]
name = "qcf_c"
command = ~D, DF, F, c

;==========================================FIREBALL DOUBLE BUTTON==============================
[command]
name = "qcf_xy"
command = ~D, DF, F, x+y
[command]
name = "qcf_xy"
command = ~D, DF, F, x+z
[command]
name = "qcf_xy"
command = ~D, DF, F, y+z
[command]
name = "qcf_ab"
command = ~D, DF, F, a+b
[command]
name = "qcf_ab"
command = ~D, DF, F, b+c
[command]
name = "qcf_ab"
command = ~D, DF, F, a+c

;====================================HALF CIRCLE FORWARD SINGLE BUTTON========================
[command]
name = "hcf_x"
command = ~B, D, F, x
time = 40
[command]
name = "hcf_y"
command = ~B, D, F, y
time = 40
[command]
name = "hcf_z"
command = ~B, D, F, z
time = 40
[command]
name = "hcf_a"
command = ~B, D, F, a
time = 40
[command]
name = "hcf_b"
command = ~B, D, F, b
time = 40
[command]
name = "hcf_c"
command = ~B, D, F, c
time = 40
;====================================HALF CIRCLE FORWARD DOUBLE BUTTON=========================
[command]
name = "hcf_xy"
command = ~B, D, F, x+z
time = 40
[command]
name = "hcf_xy"
command = ~B, D, F, y+z
time = 40
[command]
name = "hcf_xy"
command = ~B, D, F, x+y
time = 40
[command]
name = "hcf_ab"
command = ~B, D, F, a+b
time = 40
[command]
name = "hcf_ab"
command = ~B, D, F, b+c
time = 40
[command]
name = "hcf_ab"
command = ~B, D, F, a+c
time = 40

;======================================HALF CIRCLE BACK SINGLE BUTTON==========================
[command]
name = "hcb_x"
command = ~F, D, B, x
time = 40
[command]
name = "hcb_y"
command = ~F, D, B, y
time = 40
[command]
name = "hcb_z"
command = ~F, D, B, z
time = 40
[command]
name = "hcb_a"
command = ~F, D, B, a
time = 40
[command]
name = "hcb_b"
command = ~F, D, B, b
time = 40
[command]
name = "hcb_c"
command = ~F, D, B, c
time = 40
;=====================================HALF CIRCLE BACK DOUBLE BUTTON=========================
[command]
name = "hcb_xy"
command = ~F, D, B, x+z
time = 40
[command]
name = "hcb_xy"
command = ~F, D, B, y+z
time = 40
[command]
name = "hcb_xy"
command = ~F, D, B, x+y
time = 40
[command]
name = "hcb_ab"
command = ~F, D, B, a+b
time = 40
[command]
name = "hcb_ab"
command = ~F, D, B, b+c
time = 40
[command]
name = "hcb_ab"
command = ~F, D, B, a+c
time = 40
;==========================================HURRICANE SINGLE BUTTON=============================
[command]
name = "qcb_x"
command = ~D, DB, B, x
[command]
name = "qcb_y"
command = ~D, DB, B, y
[command]
name = "qcb_z"
command = ~D, DB, B, z
[command]
name = "qcb_a"
command = ~D, DB, B, a
[command]
name = "qcb_b"
command = ~D, DB, B, b
[command]
name = "qcb_c"
command = ~D, DB, B, c
;==========================================HURRICANE DOUBLE BUTTON=============================
[command]
name = "qcb_ab"
command = ~D, DB, B, a+b
[command]
name = "qcb_ab"
command = ~D, DB, B, b+c
[command]
name = "qcb_ab"
command = ~D, DB, B, a+c
[command]
name = "qcb_xy"
command = ~D, DB, B, x+y
[command]
name = "qcb_xy"
command = ~D, DB, B, y+z
[command]
name = "qcb_xy"
command = ~D, DB, B, x+z
;============================================= SINGLE BUTTONS ================================
[Command]
name="a"
command=a
time=1
[Command]
name="b"
command=b
time=1
[Command]
name="c"
command=c
time=1
[Command]
name="x"
command=x
time=1
[Command]
name="y"
command=y
time=1
[Command]
name="z"
command=z
time=1
[Command]
name="start"
command=s
time=1
;===============================================AIR JUMP======================================
[command]
name = "airjump"
command = $U
time = 1
;============================================DOUBLE TAP DIRECTION=============================
[command]
name = "SJump"
command = ~$D, $U
time = 10
[Command]
name = "DU"
command = $D, $U
time = 10
[Command]
name = "FF";Required (do not remove)
command = F, F
time = 10
[Command]
name = "BB";Required (do not remove)
command = B, B
time = 10
;===========================================MVC TEAM COMMANDS================================
[Command]
name="Double"
command=~D,DF,F,c+z
[Command]
name="Double"
command=~D,DF,F,~c+z
[Command]
name="assist"
command=y+b
time=1
[Command]
name="assist"
command=~y+b
time=1
[Command]
name="tag"
command=z+c
time=1
[Command]
name="tag"
command=~z+c
time=1
;============================================ 2/3  buttons ===================================
[Command]
name = "recovery";Required (do not remove)
command = a+b
time = 1
[Command]
name = "recovery_roll"
command = B,DB,D,a
time = 1
[Command]
name = "recovery_roll"
command = B,DB,D,b
time = 1
[Command]
name = "recovery_roll"
command = B,DB,D,c
time = 1
[Command]
name = "recovery_roll"
command = /F,a
time = 1
[Command]
name = "recovery_roll"
command = /F,b
time = 1
[Command]
name = "recovery_roll"
command = /F,c
time = 1
[Command]
name = "recovery_rollback"
command = /B,a
time = 1
[Command]
name = "recovery_rollback"
command = /B,b
time = 1
[Command]
name = "recovery_rollback"
command = /B,c
time = 1

[Command]
name = "alpha_counter"
command = /B,x
time = 10
[Command]
name = "alpha_counter"
command = /B,y
time = 10
[Command]
name = "alpha_counter"
command = /B,z
time = 10
[Command]
name = "alpha_counter"
command = ~B,DB,D,x
time = 10
[Command]
name = "alpha_counter"
command = ~B,DB,D,y
time = 10
[Command]
name = "alpha_counter"
command = ~B,DB,D,z
time = 10

[Command]
name = "guardpush"
command = x+y
time = 4
[Command]
name = "guardpush"
command = y+z
time = 4
[Command]
name = "guardpush"
command = x+z
time = 4
[Command]
name = "guardpush"
command = x+y+z
time = 4

;===========================================DIRECTION========================================
[Command]
name="fwd"
command=F
time=1
[Command]
name="back"
command=B
time=1
[Command]
name="down"
command=D
time=1
[Command]
name="up"
command=U
time=1
;=========================================RELEASE BUTTON=======================================
[Command]
name="rlsa"
command=~a
time=1
[Command]
name="rlsb"
command=~b
time=1
[Command]
name="rlsc"
command=~c
time=1
[Command]
name="rlsx"
command=~x
time=1
[Command]
name="rlsy"
command=~y
time=1
[Command]
name="rlsz"
command=~z
time=1
;=========================================HOLD DIRECTION=======================================
[Command]
name="holdfwd";Required (do not remove)
command=/$F
time=1
[Command]
name="holdback";Required (do not remove)
command=/$B
time=1
[Command]
name="holdup";Required (do not remove)
command=/$U
time=1
[Command]
name="holddown";Required (do not remove)
command=/$D
time=1
;=====================================DOWN DOWN DOUBLE BUTTONS==================================
[command]
name = "dd_xyz"
command = D,D, x+y
time = 25
[command]
name = "dd_xyz"
command = D,D, y+z
time = 25
[command]
name = "dd_xyz"
command = D,D, x+z
time = 25
[command]
name = "dd_abc"
command = D,D, a+b
time = 25
[command]
name = "dd_abc"
command = D,D, b+c
time = 25
[command]
name = "dd_abc"
command = D,D, a+c
time = 25
[command]
name = "dd_xyz"
command = D,D, ~x+y
time = 25
[command]
name = "dd_xyz"
command = D,D, ~y+z
time = 25
[command]
name = "dd_xyz"
command = D,D, ~x+z
time = 25
[command]
name = "dd_abc"
command = D,D, ~a+b
time = 25
[command]
name = "dd_abc"
command = D,D, ~b+c
time = 25
[command]
name = "dd_abc"
command = D,D, ~a+c
time = 25
;========================================DOWN DOWN SINGLE BUTTONS================================
[command]
name = "dd_x"
command = D,D, x
time = 25
[command]
name = "dd_y"
command = D,D, y
time = 25
[command]
name = "dd_z"
command = D,D, z
time = 25
[command]
name = "dd_a"
command = D,D, a
time = 25
[command]
name = "dd_b"
command = D,D, b
time = 25
[command]
name = "dd_c"
command = D,D, c
time = 25
[command]
name = "dd_x"
command = D,D, ~x
time = 25
[command]
name = "dd_y"
command = D,D, ~y
time = 25
[command]
name = "dd_z"
command = D,D, ~z
time = 25
[command]
name = "dd_a"
command = D,D, ~a
time = 25
[command]
name = "dd_b"
command = D,D, ~b
time = 25
[command]
name = "dd_c"
command = D,D, ~c
time = 25
;===========================================DEMON RAGE COMMANDS==================================
[command]
name = "shun"
command = x,x,F,a,z
time = 35
[command]
name ="shun 2"
command = x,x,F,a,c
time = 40
[command]
name = "shun"
command = x,x,F,a,~z
time = 35
[command]
name ="shun 2"
command = x,x,F,a,~c
time = 40
;========================================BACK FORWARD DOUBLE BUTTONS==============================
[command]
name = "BFXY"
command = ~B, F, x+y
[command]
name = "BFXY"
command = ~B, F, y+z
[command]
name = "BFXY"
command = ~B, F, x+z
[command]
name = "BFXY"
command = ~B, F, ~x+y
[command]
name = "BFXY"
command = ~B, F, ~y+z
[command]
name = "BFXY"
command = ~B, F, ~x+z
[command]
name = "BFAB"
command = ~B, F, a+b
[command]
name = "BFAB"
command = ~B, F, b+c
[command]
name = "BFAB"
command = ~B, F, a+c
[command]
name = "BFAB"
command = ~B, F, ~a+b
[command]
name = "BFAB"
command = ~B, F, ~b+c
[command]
name = "BFAB"
command = ~B, F, ~a+c


;---------------------------------------------------------------------------
;Artificial Intelligence
[statedef -1]

[State -1, Anti Air]
type = changestate
Triggerall = roundstate = 2 && (AiLevel) && ctrl && random <= (800 * (AiLevel ** 2 / 64.0))
trigger1 = (statetype != A) && (p2statetype = A) && P2MoveType != H
trigger1 = EnemyNear, Pos Y > -40 && p2dist x <= 100 && FrontEdgeDist >= 40
value = ifelse(random<500,1200,1400)

;--|-AI Defense-|-----------------------------------------------------------
[State -1, AI Defense]
type = ChangeState
triggerall = (roundstate = 2) && (AiLevel)  
triggerall = (Ctrl) && (p2movetype = A) && (statetype = S)
trigger1 = (p2bodydist X <= 250) && random <= (800 * (AiLevel ** 2 / 64.0))
value = 130;ifelse(random<50,730,130)

[State -1, AI Defense]
type = ChangeState
triggerall = (roundstate = 2) && (AiLevel) 
triggerall = (Ctrl) && (p2movetype = A) && (statetype = C)
trigger1 = (p2bodydist X <= 250) && random <= (800 * (AiLevel ** 2 / 64.0))
value = 131;ifelse(random<50,700,131)

[State -1, AI Defense]
type = ChangeState
triggerall = (roundstate = 2) && (AiLevel) 
triggerall = (Ctrl) && (p2movetype = A) && (statetype = A)
trigger1 = (p2bodydist X <= 250) && random <= (800 * (AiLevel ** 2 / 64.0))
value = 132

;-|-AI Combo Attempt-|----------------------------------------------
[State -1, AI Normal Attacks]
type = ChangeState
value = ifelse(Power>=1000,3000+random%2*100,ifelse(random<300,100,ifelse(random>600,1000,1400)))
triggerall = (AiLevel)
triggerall = stateno != [100,106]
triggerall = random <= (700 * (AiLevel ** 2 / 64.0))
triggerall = statetype != A
trigger1 = ctrl
trigger1 = p2bodydist x >=45

[State -1, AI Normal Attacks]
type = ChangeState
triggerall = (roundstate = 2) && (AiLevel) && random <= (800 * (AiLevel ** 2 / 64.0))
triggerall = (Ctrl) && (statetype = S)
trigger1 = (p2bodydist X <= 25) && stateno != 200
ignorehitpause = 0
value = ifelse(random<500,200+random%2*600,430)

[State -1, AI Normal Attacks 2]
type = ChangeState
triggerall = (roundstate = 2) && (AiLevel) && random <= (800 * (AiLevel ** 2 / 64.0))
trigger1 = stateno = 200 && movehit
value = ifelse(power>=1000,3000+random%2*100,210)

[State -1, AI Normal Attacks 2b]
type = ChangeState
triggerall = (roundstate = 2) && (AiLevel) && random <= (800 * (AiLevel ** 2 / 64.0))
trigger1 = stateno = 210 && movehit
value = ifelse(random<300,220,ifelse(random>600,250,420))

[State -1, AI Normal Attacks 2b]
type = ChangeState
triggerall = (roundstate = 2) && (AiLevel) && random <= (800 * (AiLevel ** 2 / 64.0))
trigger1 = stateno = 220 && movehit
value = ifelse(random<300,1000,ifelse(random>600,1300,1400))

[State -1, AI Normal Attacks 3]
type = ChangeState
triggerall = (roundstate = 2) && (AiLevel) && random <= (800 * (AiLevel ** 2 / 64.0))
trigger1 = stateno = 430 && movehit
value = ifelse(power>=1000,3000+random%2*100,ifelse(random<500,420,440))

[State -1, AI Normal Attacks 3]
type = ChangeState
triggerall = (roundstate = 2) && (AiLevel) && random <= (800 * (AiLevel ** 2 / 64.0))
trigger1 = stateno = 440 && movehit
value = ifelse(random<500,1300,450)

[State -1, AI Normal Attacks 3]
type = ChangeState
triggerall = (roundstate = 2) && (AiLevel) && random <= (800 * (AiLevel ** 2 / 64.0))
trigger1 = stateno = 450 && movehit
value = 1300

;----AIR COMBOS-----

;---------------------------------------------------------------------------
; Combo 3a - CHP > Aerial Rave
[State -2,  CHP > Aerial Rave]
type = changestate
Triggerall = roundstate = 2 && (AiLevel) 
trigger1 = (stateno = 420)&& (movehit) ;&& time > 10;  && (statetype = S)
value = 80

;---------------------------------------------------------------------------
; A.I. - Air Combos

;---------------------------------------------------------------------------
; Air Combo 1 - JLP / JLK

[State -1, JLP / JLK]
type = changestate
Triggerall = roundstate = 2 && (AiLevel) && (statetype = A) && NumHelper(9010) = 0 && random <= (750 * (AiLevel ** 2 / 64.0))
triggerall = (time > 4) && ctrl && prevstateno != [620,650] 
trigger1 = stateno = 50; && EnemyNear, Pos X <=100  && EnemyNear, Pos Y <0
trigger2 = stateno = 7001; && EnemyNear, Pos X <=100  && EnemyNear, Pos Y <0
value = 600;ifelse((p2bodydist X <=50),600,ifelse(NumHelper(2210),1450,1550));ifelse (random <=500,600,630)

;---------------------------------------------------------------------------
; Air Combo 2 - Jumping Light Punch > Jumping Light Kick

[State -1, 2]
type = changestate
Triggerall = roundstate = 2 && (AiLevel) && (statetype = A)
trigger1 = (stateno = 600) && random <= (750 * (AiLevel ** 2 / 64.0))
trigger1 = (movecontact)
value = 630

;---------------------------------------------------------------------------
; Air Combo 3 - Jumping Light Kick > Jumping Medium Punch

[State -1, 3]
type = changestate
Triggerall = roundstate = 2 && (AiLevel) && (statetype = A)
triggerall = (movecontact) && random <= (750 * (AiLevel ** 2 / 64.0))
trigger1 = (p2bodydist X <= 100)
trigger1 = (stateno = 630)
trigger1 = (prevstateno = 600)
value = 610

;---------------------------------------------------------------------------
; Air Combo 4 - Jumping Medium Punch > Jumping Medium Kick

[State -1, 4]
type = changestate
Triggerall = roundstate = 2 && (AiLevel) && (statetype = A)
triggerall = (movecontact) && random <= (750 * (AiLevel ** 2 / 64.0))
trigger1 = (p2bodydist X <= 100)
trigger1 = (stateno = 610)
trigger1 = (prevstateno = 630)
value = 640;ifelse (power>=1000,ifelse(random<500,3000+(random%2)*100,3205),640)

;---------------------------------------------------------------------------
; Air Combo 5 - Jumping Medium Kick > Jumping Heavy Punch

[State -1, 5]
type = changestate
Triggerall = roundstate = 2 && (AiLevel) && (statetype = A)
triggerall = (movecontact) && random <= (750 * (AiLevel ** 2 / 64.0))
trigger1 = (p2bodydist X <= 100)
trigger1 = (stateno = 640)
trigger1 = (prevstateno = 610)
trigger1 = Power <1000
value = ifelse(random>500,620,1200)

[State -1, 5]
type = null;changestate
Triggerall = roundstate = 2 && (AiLevel) && (statetype = A)
triggerall = (movecontact) && random <= (750 * (AiLevel ** 2 / 64.0))
trigger1 = (p2bodydist X <= 100)
trigger1 = (stateno = 640)
trigger1 = (prevstateno = 610)
trigger1 = Power >=1000
value = ifelse(random<500,3205,3000+(random%2)*100);ifelse(random>500,3600,3700);ifelse (power>=1000,3200,620)

[State -1, AI Special]
type = changestate
triggerall = (roundstate = 2) && (AiLevel) && (var(35) = 0)
triggerall = (Ctrl) && (Statetype = S)  && random <= (300 * (AiLevel ** 2 / 64.0))
trigger1 = (p2bodydist x >= 200) && (prevstateno != 5120) && (p2movetype != H) && (statetype != A)
value = ifelse(random<500,1000,1300)


[State -1, AIhelper]
type=changestate
trigger1=ishelper(9741)
value=9741
;===============================================================================================
;                                            TEAM COMMANDS 
;===============================================================================================
[State -1, team hyper]
type = null;ChangeState
value = 4600
triggerall =var(53) = 1
triggerall =command = "Double"
triggerall =Var(51) = 1
triggerall =NumPartner && partner, life > 0
triggerall =stateno != 4512
triggerall =power >= 2000
trigger1=(StateType != A) && (Ctrl = 1)
trigger2=(stateno = [200,499])&&(StateType != A)
trigger3=(Stateno=[1000,1020])&&(animelemtime(6)>0)
trigger4=(Stateno=1201||Stateno=1211||Stateno=1221)
;=======================================
[State -1, tag]
type = null;ChangeState
value = 4510
triggerall = var(53) = 1
triggerall = command = "tag"
triggerall = Var(51) = 1
triggerall = NumPartner && partner, stateno = 4512 
triggerall = NumPartner && partner, life > 0
trigger1 = (StateType != A) && (Ctrl = 1)
trigger2 = (stateno = [200,499]) && (StateType != A)
;=======================================
[State -1, assist]
type = null;ChangeState
value = 4900
triggerall = var(53) = 1
triggerall = command = "assist"
triggerall = Var(51) = 1
triggerall = NumPartner && partner, stateno = 4512 ||NumPartner && partner, stateno = 4800
triggerall = NumPartner && partner, life > 0
triggerall = (StateType != A) 
trigger1 = (Ctrl = 1)
trigger2 = (stateno=[0,599])
;===============================================================================================
;                                            Hypers Moves
;===============================================================================================
;Batrang Barrage
[State -1, Batrang Barrage]
type=ChangeState
value=3000
triggerall = (roundstate = 2) && (!AiLevel) 
triggerall=var(53)=1;||NumPartner=0
triggerall=command="qcf_xy"
triggerall=power>=1000
trigger1 = Statetype != A && ctrl
trigger2 = (HitdefAttr = SC, NA) && (MoveContact)


;===============================================================================================
;Gothan Beatdown
[State -1, Gothan Beatdown]
type=ChangeState
value=3100
triggerall = (roundstate = 2) && (!AiLevel) 
triggerall=var(53)=1;||NumPartner=0
triggerall=command="qcf_ab"
triggerall=power>=1000
trigger1 = Statetype != A && ctrl
trigger2 = (HitdefAttr = SC, NA) && (MoveContact)


;===============================================================================================
;                                             Specials
;===============================================================================================

[State -1, Mode change]
type = ChangeState
value = 1100
triggerall = (roundstate = 2) && (!AiLevel) 
triggerall = var(16) = 0 && ctrl && (StateType !=A)
trigger1 = command = "Buster01"
trigger2 = command = "Buster02"
trigger3 = command = "Buster03"
trigger4 = command = "Buster04"
trigger5 = command = "Buster05"
trigger6 = command = "Buster06"

;Justice Upper
[State -1]
type=ChangeState
value=1200
triggerall = (roundstate = 2) && (!AiLevel) 
triggerall=var(53)=1;||NumPartner=0
triggerall=command="dp_x"||command="dp_y" ||command="dp_z"
triggerall=Roundstate=2&&statetype!=A
trigger1=ctrl
trigger2=MoveContact&&StateNo=[200,450]

;Batrang
[State -1]
type=ChangeState
value=1000
triggerall = (roundstate = 2) && (!AiLevel) 
triggerall=var(53)=1;||NumPartner=0
triggerall=command="qcf_x"||command="qcf_y" ||command="qcf_z"
triggerall=Roundstate=2&&statetype!=A
trigger1=ctrl
trigger2=MoveContact&&StateNo=[200,450]

;Spin Kick
[State -1]
type=ChangeState
value=1300
triggerall=(!AiLevel)&&var(53)=1;||NumPartner=0
triggerall=command="qcf_a"||command="qcf_b" ||command="qcf_c"
triggerall=Roundstate=2&&statetype!=A
trigger1=ctrl
trigger2=MoveContact&&StateNo=[200,450]

;Teleport Attack
[State -1]
type=ChangeState
value=1400
triggerall=(!AiLevel)&&var(53)=1;||NumPartner=0
triggerall=command="qcb_a"||command="qcb_b" ||command="qcb_c"
triggerall=Roundstate=2&&statetype!=A
trigger1=ctrl
trigger2=MoveContact&&StateNo=[200,450]

;Reversal Battoms
[State -1]
type=ChangeState
value=1500
triggerall = var(35) = 0
triggerall=(!AiLevel)&&var(53)=1;||NumPartner=0
triggerall=command="qcb_x"||command="qcb_y" ||command="qcb_z"
triggerall=Roundstate=2&&statetype!=A
trigger1=ctrl
trigger2=MoveContact&&StateNo=[200,450]

;Shock Battoms
[State -1]
type=ChangeState
value=1600
triggerall = var(35) = 20001
triggerall=(!AiLevel)&&var(53)=1;||NumPartner=0
triggerall=command="qcb_x"||command="qcb_y" ||command="qcb_z"
triggerall=Roundstate=2&&statetype!=A
trigger1=ctrl
trigger2=MoveContact&&StateNo=[200,450]

;Spinning Battoms
[State -1]
type=ChangeState
value=1700
triggerall = var(35) = 20002
triggerall=(!AiLevel)&&var(53)=1;||NumPartner=0
triggerall=command="qcb_x"||command="qcb_y" ||command="qcb_z"
triggerall=Roundstate=2&&statetype!=A
trigger1=ctrl
trigger2=MoveContact&&StateNo=[200,450]


;===============================================================================================
;                                              Throws
;===============================================================================================

;GRAB
[State -1]
type = ChangeState
value = 800
triggerall = !AiLevel
triggerall = command = "z" && statetype = S && ctrl && stateno != 100
trigger1 = (command = "holdfwd" || Command = "holdback") && p2bodydist X < 10 && p2movetype != H
trigger1 = (p2statetype = S) || (p2statetype = C)


;Ground Throw Punch
[State -1, Throw]
type = null;ChangeState
value =800
triggerall =(!AiLevel)&&var(53)=1;||NumPartner=0
triggerall =command="z"
triggerall =p2bodydist X <40
triggerall =statetype = S
triggerall =p2statetype = S||p2statetype=C
triggerall =stateno!=[100,105]
triggerall =roundstate=2
triggerall =ctrl
trigger1 =command="holdfwd"||command="holdback"
trigger1 =p2movetype!=H
;----------------------------------
;Ground Throw Kick
[State -1, Throw]
type =NULL;ChangeState
value =810
triggerall =(!AiLevel)&&var(53)=1;||NumPartner=0
triggerall =command="c"
triggerall =p2bodydist X <40
triggerall =statetype = S
triggerall =p2statetype=S||p2statetype=C
triggerall =stateno!=[100,105]
triggerall =roundstate=2
triggerall =ctrl
trigger1 =command="holdfwd"||command="holdback"
trigger1 =p2movetype!=H
;----------------------------------
;Air Throw 
[State -1, Throw]
type=NULL;ChangeState
value=850
triggerall =(!AiLevel)&&var(53)=1;||NumPartner=0
triggerall =command="z"
triggerall =statetype =A
triggerall =p2bodydist X <40
triggerall =p2statetype=A
triggerall =roundstate=2
triggerall =ctrl
trigger1 =command="holdfwd"||command="holdback"
trigger1 =p2movetype!=H
;===============================================================================================
;                                          Standing Attacks
;===============================================================================================
;stand light punch
[state -1]
type = changestate
value =200
triggerall=(!AiLevel)&&var(53)=1;||NumPartner=0
triggerall=command="x"&&command!="holddown"
triggerall=Roundstate=2&&statetype!=A
trigger1=ctrl
;=======================================
;stand medium punch
[state -1]
type = changestate
value = 210
triggerall=(!AiLevel)&&var(53)=1;||NumPartner=0
triggerall=command="y"&&command!="holddown"
triggerall=Roundstate=2&&statetype!=A
trigger1=ctrl
trigger2=MoveContact&&StateNo=[200,205]
trigger3=MoveContact&&StateNo=[230,235]
trigger4=MoveContact&&StateNo=400
trigger5=MoveContact&&StateNo=430
;=======================================
;stand strong punch
[state -1]
type = changestate
value = 220
triggerall=(!AiLevel)&&var(53)=1;||NumPartner=0
triggerall=command="z"&&command!="holddown"
triggerall=Roundstate=2&&statetype!=A
trigger1=ctrl
trigger2=MoveContact&&StateNo=[200,210]
trigger3=MoveContact&&StateNo=[230,240]
trigger4=MoveContact&&StateNo=[400,410]
trigger5=MoveContact&&StateNo=[430,440]
;=======================================
;stand light kick
[state -1]
type = changestate
value = 230
triggerall=(!AiLevel)&&var(53)=1;||NumPartner=0
triggerall=command="a"&&command!="holddown"
triggerall=Roundstate=2&&statetype!=A
trigger1=ctrl
trigger2=MoveContact&&StateNo=[200,205]
trigger3=MoveContact&&StateNo=400
trigger4=MoveContact&&StateNo=430
;=======================================
;standing strong kick
[state -1]
type = changestate
value = 240
triggerall=(!AiLevel)&&var(53)=1;||NumPartner=0
triggerall=command="b"&&command!="holddown"
triggerall=Roundstate=2&&statetype!=A
trigger1 = ctrl
trigger2 = MoveContact&&StateNo=[200,215]
trigger3 = MoveContact&&StateNo=230
trigger4 = MoveContact&&StateNo=400
trigger5 = MoveContact&&StateNo=430
;=======================================
;standing strong kick
[state -1]
type = changestate
value = 250
triggerall=(!AiLevel)&&var(53)=1;||NumPartner=0
triggerall=command="c"&&command!="holddown"
triggerall=Roundstate=2&&statetype!=A
trigger1 = ctrl
trigger2 = MoveContact&&StateNo=[200,220]
trigger3 = MoveContact&&StateNo=[230,240]
trigger4 = MoveContact&&StateNo=[400,410]
trigger5 = MoveContact&&StateNo=[430,440]
;===============================================================================================
;                                     Crouching Attacks
;===============================================================================================
;crouching light punch
[state -1, crouching light punch]
type = changestate
value = 400
triggerall=(!AiLevel)&&var(53)=1;||NumPartner=0
triggerall=command="x"&&command="holddown"
triggerall=Roundstate=2&&statetype!=A
trigger1=ctrl
;=======================================
;crouching medium punch
[state -1, crouching medium punch]
type = changestate
value = 410
triggerall=(!AiLevel)&&var(53)=1;||NumPartner=0
triggerall=command="y"&&command="holddown"
triggerall=Roundstate=2&&statetype!=A
trigger1=ctrl
trigger2=MoveContact&&StateNo=[200,210]
trigger3=MoveContact&&StateNo=[230,230]
trigger4=MoveContact&&StateNo=400
trigger5=MoveContact&&StateNo=[430,440]
;=======================================
;crouching strong punch
[state -1, crouching strong punch]
type = changestate
value = 420
triggerall=(!AiLevel)&&var(53)=1;||NumPartner=0
triggerall=command="z"&&command="holddown"
triggerall=Roundstate=2&&statetype!=A
trigger1=ctrl
trigger2=MoveContact&&StateNo=[200,210]
trigger3=MoveContact&&StateNo=[230,240]
trigger4=MoveContact&&StateNo=[400,410]
trigger5=MoveContact&&StateNo=[430,440]
;=======================================
;crouching light kick
[state -1, crouching light kick]
type = changestate
value = 430
triggerall=(!AiLevel)&&var(53)=1;||NumPartner=0
triggerall=command="a"&&command="holddown"
triggerall=Roundstate=2&&statetype!=A
trigger1=ctrl
trigger2=MoveContact&&StateNo=[200,205]
trigger3=MoveContact&&StateNo=[230,230]
trigger4=MoveContact&&StateNo=400
;=======================================
;crouching medium kick
[state -1, crouching medium kick]
type = changestate
value = 440
triggerall=(!AiLevel)&&var(53)=1;||NumPartner=0
triggerall=command="b"&&command="holddown"
triggerall=Roundstate=2&&statetype!=A
trigger1=ctrl
trigger2=MoveContact&&StateNo=[200,210]
trigger3=MoveContact&&StateNo=[230,230]
trigger4=MoveContact&&StateNo=[400,410]
trigger5=MoveContact&&StateNo=430
;=======================================
;crouching strong kick
[state -1, crouching strong kick]
type = changestate
value = 450
triggerall=(!AiLevel)&&var(53)=1;||NumPartner=0
triggerall=command="c"&&command="holddown"
triggerall=Roundstate=2&&statetype!=A
trigger1 = ctrl
trigger2 = MoveContact&&StateNo=[200,210]
trigger3 = MoveContact&&StateNo=[230,230]
trigger4 = MoveContact&&StateNo=[400,410]
trigger5 = MoveContact&&StateNo=[430,440]
;===============================================================================================
;                                         Aerial Attacks
;===============================================================================================
;jump light punch
[state -1]
type = changestate
value =600
triggerall=(!AiLevel)&&var(53)=1;||NumPartner=0
triggerall=command="x"
triggerall=Roundstate=2&&statetype=A
trigger1=ctrl
;=======================================
;jump medium punch
[state -1]
type = changestate
value = 610
triggerall=(!AiLevel)&&var(53)=1;||NumPartner=0
triggerall=command="y"
triggerall=Roundstate=2&&statetype=A
trigger1=ctrl
trigger2=MoveContact&&StateNo=600
trigger3=MoveContact&&StateNo=[630,640]
;=======================================
;jump strong punch
[state -1]
type = changestate
value = 620
triggerall=(!AiLevel)&&var(53)=1;||NumPartner=0
triggerall=command="z"
triggerall=Roundstate=2&&statetype=A
trigger1=ctrl
trigger2=MoveContact&&StateNo=[600,610]
trigger3=MoveContact&&StateNo=[630,640]
;=======================================
;jump light kick
[state -1]
type = changestate
value = 630
triggerall=(!AiLevel)&&var(53)=1;||NumPartner=0
triggerall=command="a"
triggerall=Roundstate=2&&statetype=A
trigger1=ctrl
trigger2=MoveContact&&StateNo=600
;=======================================
;jump medium kick
[state -1]
type = changestate
value = 640
triggerall=(!AiLevel)&&var(53)=1;||NumPartner=0
triggerall=command="b"
triggerall=Roundstate=2&&statetype=A
trigger1=ctrl
trigger2=MoveContact&&StateNo=[600,610]
trigger3=MoveContact&&StateNo=630
;=======================================
;jump strong kick
[state -1]
type = changestate
value = 650
triggerall=(!AiLevel)&&var(53)=1;||NumPartner=0
triggerall=command="c"
triggerall=Roundstate=2&&statetype=A
trigger1=ctrl
trigger2=MoveContact&&StateNo=[600,610]
trigger3=MoveContact&&StateNo=[630,640]
;===============================================================================================
;                                          System States
;===============================================================================================
;Jump
[state -1]
type = changestate
value = 40
triggerall = var(53) = 1 || NumPartner = 0
triggerall = command = "holdup"
triggerall=Roundstate=2&&statetype != a
trigger1 = ctrl
;=======================================
;Dash Forward
[state -1]
type = changestate
value = 100
triggerall = var(53) = 1 || NumPartner = 0
triggerall=Roundstate=2&&statetype != a
trigger1 = (command = "FF") && (stateno !=[100,106])
trigger1 = ctrl
;=======================================
;Air Dash
[State -1,Air Dash]
type = ChangeState
value = 102
triggerall = var(53) = 1 || NumPartner = 0
triggerall = command = "FF"
triggerall = roundstate=2
triggerall = statetype = A
triggerall = var(7) = 0
trigger1 = ctrl
trigger1 = PrevStateNo != 102
;=======================================
;Dash Back
[State -1,Dash Back]
type = ChangeState
value = 105
triggerall = var(53) = 1 || NumPartner = 0
triggerall = command = "BB"
triggerall = (stateno !=[100,106])
triggerall = roundstate=2
trigger1 = statetype = S
trigger1 = ctrl = 1
;=======================================
;Air Dash Back
[State -1]
type = ChangeState
value = 107
triggerall = var(53) = 1 || NumPartner = 0
triggerall = command = "BB"
triggerall = roundstate=2
triggerall = statetype = A
triggerall = var(7) = 0
trigger1 = ctrl
trigger1 = PrevStateNo != 107
;=======================================
;Taunt
[State -1]
type = null;ChangeState
value = 800;115
triggerall = var(53) = 1 || NumPartner = 0
triggerall = command ="start"
triggerall = roundstate=2
triggerall = statetype!=A
trigger1 = ctrl = 1
;=======================================
;Guard Push Standing
[State -1]
type = ChangeState
value = 700
triggerall = command = "guardpush"
triggerall=Roundstate=2&&statetype = S
triggerall = !var(0)
trigger1 = stateno = [150,153]
;=======================================
;Guard Push Crouching
[State -1]
type = ChangeState
value = 705
triggerall = command = "guardpush"
triggerall=Roundstate=2&&statetype = C
triggerall = !var(0)
trigger1 = stateno = [150,153]
;=======================================
;Guard Push Air
[State -1]
type = ChangeState
value = 710
triggerall = command = "guardpush"
triggerall=Roundstate=2&&statetype = A
triggerall = !var(0)
trigger1 = stateno = [154,155]
;=======================================
;Alpha/Zero Counter 
[State -1]
type=ChangeState
value=750
triggerall=command="alpha_counter"||Command = "tag"
triggerall=statetype !=A
triggerall=Power >=500
triggerall=P2BodyDist x=[0,60]
triggerall=p2bodydist Y=[-50,10]
triggerall=!var(0)&&roundstate=2
trigger1=stateno=150||stateno=152
;=======================================
;Air Alpha/Zero Counter
[State -1]
type =null; ChangeState
value = 755
triggerall = command= "alpha_counter"||Command = "tag"
triggerall = statetype=A
triggerall = Power >=500
triggerall = P2BodyDist x=[0,50]
triggerall = p2bodydist Y=[-30,30]
triggerall = !var(0)&&roundstate=2
trigger1 = stateno=[154,155]
;=======================================
;Lie Down Recovery Roll Foward
[State -1]
type = ChangeState
value = 940
triggerall = command = "holdfwd"
triggerall = !var(0)&&alive
triggerall = time=1
trigger1 = stateno=5120
;=======================================
;Lie Down Recovery Roll Back
[State -1]
type = ChangeState
value = 941
triggerall = command = "holdback"
triggerall = !var(0)&&alive
triggerall = time=1
trigger1 = stateno=5120
;=======================================
;Tech Hit Recovery Roll Forward
[State -1]
type = ChangeState
value = 942
triggerall = !ctrl && Command = "recovery_roll"
triggerall = (StateNo = 5030) || (StateNo = 5035) || (StateNo = 5050) || (StateNo = 5071)
triggerall = !var(0)&&alive
triggerall = movetype != A
trigger1 = pos Y > -10
;=======================================
;Tech Hit Recovery Roll Back
[State -1]
type = ChangeState
value = 943
triggerall = !ctrl && Command = "recovery_rollback"
triggerall = (StateNo = 5030) || (StateNo = 5035) || (StateNo = 5050) || (StateNo = 5071)
triggerall = !var(0)&&alive
triggerall = movetype != A
trigger1 = pos Y > -10
;===============================================================================================
;===============================================================================================
;                                          Partner Controlls
;===============================================================================================
;===============================================================================================
[State -1, team hyper]
type = ChangeState
value = 4600
triggerall = NumPartner
triggerall = var(53) = 2
triggerall = NumPartner && partner,command = "Double"
triggerall = Var(51) = 1
triggerall = NumPartner && partner, life > 0
triggerall = stateno != 4512
triggerall = power >= 2000
trigger1 = (StateType != A) && (var(54) = 1)
trigger2 = (stateno = [200,499]) && (StateType != A)
trigger3=(Stateno=[1000,1020])&&(animelemtime(6)>0)
trigger4=(Stateno=1201||Stateno=1211||Stateno=1221)
ignorehitpause = 1
;=======================================
[State -1, tag]
type = ChangeState
value = 4510
triggerall = NumPartner
triggerall = var(53) = 2
triggerall = NumPartner && partner,command = "tag"
triggerall = Var(51) = 1
triggerall = NumPartner && partner, stateno = 4512 
triggerall = NumPartner && partner, life > 0
trigger1 = (StateType != A) && (var(54) = 1)
trigger2 = (stateno = [200,499]) && (StateType != A)
ignorehitpause = 1
;===============================================================================================
;                                            Hypers Moves
;===============================================================================================
;
;----------------------------------
;


;===============================================================================================
;                                             Specials
;===============================================================================================







;----------------------------------
;Ground Throw Kick
[State -1, Throw]
type =NULL;ChangeState
value =810
triggerall=var(53)=2
triggerall =NumPartner && partner,command="c"
triggerall =p2bodydist X <40
triggerall =statetype = S
triggerall =p2statetype=S||p2statetype=C
triggerall =stateno!=[100,105]
triggerall =roundstate=2
triggerall =var(54)=1
trigger1 =NumPartner && partner,command="holdfwd"||NumPartner && partner,command="holdback"
trigger1 =p2movetype!=H
;----------------------------------
;Air Throw 
[State -1, Throw]
type=NULL;ChangeState
value=850
triggerall=var(53)=2
triggerall =NumPartner && partner,command="z"
triggerall =statetype =A
triggerall =p2bodydist X <40
triggerall =p2statetype=A
triggerall =roundstate=2
triggerall =var(54)=1
trigger1 =NumPartner && partner,command="holdfwd"||NumPartner && partner,command="holdback"
trigger1 =p2movetype!=H
;===============================================================================================
;                                           Standing Attacks
;===============================================================================================
;stand light punch
[state -1]
type = changestate
value = 200
triggerall = var(53) = 2
triggerall = statetype != A
triggerall = NumPartner && partner,command = "x"
triggerall = NumPartner && partner,command != "holddown"
trigger1 = var(54) = 1
ignorehitpause = 1
;=======================================
;stand medium punch
[state -1]
type = changestate
value = 210
triggerall = var(53) = 2
triggerall = statetype != A
triggerall = NumPartner && partner,command = "y"
triggerall = NumPartner && partner,command != "holdback"
triggerall = NumPartner && partner,command != "holddown"
trigger1 = var(54) = 1
trigger2=MoveContact&&StateNo=[200,205]
trigger3=MoveContact&&StateNo=[230,235]
trigger4=MoveContact&&StateNo=400
trigger5=MoveContact&&StateNo=430
ignorehitpause = 1
;=======================================
;stand strong punch
[state -1]
type = changestate
value = 220
triggerall = var(53) = 2
triggerall = statetype != A
triggerall = NumPartner && partner,command = "z"
triggerall = NumPartner && partner,command != "holddown"
trigger1 = statetype = s
trigger1 = var(54) = 1
trigger2=MoveContact&&StateNo=[200,210]
trigger3=MoveContact&&StateNo=[230,240]
trigger4=MoveContact&&StateNo=[400,410]
trigger5=MoveContact&&StateNo=[430,440]
ignorehitpause = 1
;=======================================
;stand light kick
[state -1]
type = changestate
value = 230
triggerall = var(53) = 2
triggerall = NumPartner && partner,command = "a"
triggerall = NumPartner && partner,command != "holddown"
triggerall = statetype != A
trigger1 = var(54) = 1
trigger2=MoveContact&&StateNo=[200,205]
trigger3=MoveContact&&StateNo=400
trigger4=MoveContact&&StateNo=430
ignorehitpause = 1
;=======================================
;standing strong kick
[state -1]
type = changestate
value = 240
triggerall = var(53) = 2
triggerall = NumPartner && partner,command = "b"
triggerall = NumPartner && partner,command != "holddown"
triggerall = statetype != A
trigger1 = var(54) = 1
trigger2 = MoveContact&&StateNo=[200,215]
trigger3 = MoveContact&&StateNo=230
trigger4 = MoveContact&&StateNo=400
trigger5 = MoveContact&&StateNo=430
ignorehitpause = 1
;=======================================
;standing strong kick
[state -1]
type = changestate
value = 250
triggerall = var(53) = 2
triggerall = NumPartner && partner,command = "c"
triggerall = NumPartner && partner,command != "holddown"
triggerall = statetype != A
trigger1 = var(54) = 1
trigger2 = MoveContact&&StateNo=[200,220]
trigger3 = MoveContact&&StateNo=[230,240]
trigger4 = MoveContact&&StateNo=[400,410]
trigger5 = MoveContact&&StateNo=[430,440]
ignorehitpause = 1
;===============================================================================================
;                                     Crouching Attacks
;===============================================================================================
;crouching light punch
[state -1, crouching light punch]
type = changestate
value = 400
triggerall = var(53) = 2
triggerall = NumPartner && partner,command = "x"
triggerall = NumPartner && partner,command = "holddown"
triggerall = statetype != A
trigger1 = var(54) = 1
ignorehitpause = 1
;=======================================
;crouching medium punch
[state -1, crouching medium punch]
type = changestate
value = 410
triggerall = var(53) = 2
triggerall = NumPartner && partner,command = "y"
triggerall = NumPartner && partner,command = "holddown"
triggerall = statetype != A
trigger1 = var(54) = 1
trigger2=MoveContact&&StateNo=[200,210]
trigger3=MoveContact&&StateNo=[230,230]
trigger4=MoveContact&&StateNo=400
trigger5=MoveContact&&StateNo=[430,440]
ignorehitpause = 1
;=======================================
;crouching strong punch
[state -1, crouching strong punch]
type = changestate
value = 420
triggerall = var(53) = 2
triggerall = NumPartner && partner,command = "z"
triggerall = NumPartner && partner,command = "holddown"
triggerall = statetype != A
trigger1 = var(54) = 1
trigger2=MoveContact&&StateNo=[200,210]
trigger3=MoveContact&&StateNo=[230,240]
trigger4=MoveContact&&StateNo=[400,410]
trigger5=MoveContact&&StateNo=[430,440]
ignorehitpause = 1
;=======================================
;crouching light kick
[state -1, crouching light kick]
type = changestate
value = 430
triggerall = var(53) = 2
triggerall = NumPartner && partner,command = "a"
triggerall = NumPartner && partner,command = "holddown"
triggerall = statetype != A
trigger1 = var(54) = 1
trigger2=MoveContact&&StateNo=[200,205]
trigger3=MoveContact&&StateNo=[230,230]
trigger4=MoveContact&&StateNo=400
ignorehitpause = 1
;=======================================
;crouching medium kick
[state -1, crouching medium kick]
type = changestate
value = 440
triggerall = var(53) = 2
triggerall = NumPartner && partner,command = "b"
triggerall = NumPartner && partner,command = "holddown"
triggerall = statetype != A
trigger1 = var(54) = 1
trigger2=MoveContact&&StateNo=[200,210]
trigger3=MoveContact&&StateNo=[230,230]
trigger4=MoveContact&&StateNo=[400,410]
trigger5=MoveContact&&StateNo=430
;=======================================
;crouching strong kick
[state -1, crouching strong kick]
type = changestate
value = 450
triggerall = var(53) = 2
triggerall = NumPartner && partner,command = "c"
triggerall = NumPartner && partner,command = "holddown"
triggerall = statetype != A
trigger1 = var(54) = 1
trigger2=MoveContact&&StateNo=[200,210]
trigger3=MoveContact&&StateNo=[230,230]
trigger4=MoveContact&&StateNo=[400,410]
trigger5=MoveContact&&StateNo=[430,440]
ignorehitpause=1
;===============================================================================================
;                                        Aerial Attacks
;===============================================================================================
;jump light punch
[state -1]
type = changestate
value = 600
triggerall=var(53)=2
triggerall=NumPartner && partner,command="x"
triggerall=Roundstate=2&&statetype=A
trigger1=var(54)=1
trigger2=(NumPartner && partner,command="x")
trigger2=(stateno=[140,155])
trigger2=hitshakeover
trigger3=stateno=51
trigger3=(NumPartner && partner,command="x")
trigger4=(stateno=[140,155])
trigger4=(NumPartner && partner,command="holdback"&&NumPartner && partner,command="x")
trigger5=stateno=5210&&NumPartner && partner,time>=8
trigger5=(NumPartner && partner,command="x")
ignorehitpause=1
;=======================================
;jump medium punch
[state -1]
type = changestate
value = 610
triggerall=var(53)=2
triggerall=NumPartner && partner,command="y"
triggerall=Roundstate=2&&statetype=A
trigger1=var(54)=1
trigger2=(NumPartner && partner,command="y")
trigger2=(stateno=[140,155])
trigger2=hitshakeover
trigger3=stateno=51
trigger3=(NumPartner && partner,command="y")
trigger4=(stateno=[140,155])
trigger4=(NumPartner && partner,command="holdback"&&NumPartner && partner,command="y")
trigger5=stateno=5210&&NumPartner && partner,time>=8
trigger5=(NumPartner && partner,command="y")
trigger6=MoveContact&&StateNo=600
trigger7=MoveContact&&StateNo=[630,640]
ignorehitpause=1
;=======================================
;jump strong punch
[state -1]
type = changestate
value = 620
triggerall=var(53)=2
triggerall=NumPartner && partner,command="z"
triggerall=Roundstate=2&&statetype=A
trigger1=var(54)=1
trigger2=(NumPartner && partner,command="z")
trigger2=(stateno=[140,155])
trigger2=hitshakeover
trigger3=stateno=51
trigger3=(NumPartner && partner,command="z")
trigger4=(stateno=[140,155])
trigger4=(NumPartner && partner,command="holdback"&&NumPartner && partner,command="z")
trigger5=stateno=5210&&NumPartner && partner,time>=8
trigger5=(NumPartner && partner,command="z")
trigger6=MoveContact&&StateNo=[600,610]
trigger7=MoveContact&&StateNo=[630,640]
ignorehitpause=1
;=======================================
;jump light kick
[state -1]
type = changestate
value = 630
triggerall=var(53) = 2
triggerall=NumPartner && partner,command="a"
triggerall=Roundstate=2&&statetype=A
trigger1=var(54)=1
trigger2=(NumPartner && partner,command="a")
trigger2=(stateno=[140,155])
trigger2=hitshakeover
trigger3=stateno=51
trigger3=(NumPartner && partner,command="a")
trigger4=(stateno=[140,155])
trigger4=(NumPartner && partner,command="holdback"&&NumPartner && partner,command="a")
trigger5=stateno=5210&&NumPartner && partner,time>=8
trigger5=(NumPartner && partner,command="a")
trigger6=MoveContact&&StateNo=600
ignorehitpause=1
;=======================================
;jump medium kick
[state -1]
type = changestate
value = 640
triggerall=var(53) = 2
triggerall=NumPartner && partner,command = "b"
triggerall=Roundstate=2&&statetype=A
trigger1=var(54)=1
trigger2=(NumPartner && partner,command="b")
trigger2=(stateno=[140,155])
trigger2=hitshakeover
trigger3=stateno=51
trigger3=(NumPartner && partner,command="b")
trigger4=(stateno=[140,155])
trigger4=(NumPartner && partner,command="holdback"&&NumPartner && partner,command="b")
trigger5=stateno=5210&&NumPartner && partner,time>=8
trigger5=(NumPartner && partner,command="b")
trigger6=MoveContact&&StateNo=[600,610]
trigger7=MoveContact&&StateNo=630
ignorehitpause=1
;=======================================
;jump strong kick
[state -1]
type = changestate
value = 650
triggerall=var(53)=2
triggerall=NumPartner && partner,command="c"
triggerall=Roundstate=2&&statetype=A
trigger1=var(54)=1
trigger2=(NumPartner && partner,command="c")
trigger2=(stateno=[140,155])
trigger2=hitshakeover
trigger3=stateno=51
trigger3=(NumPartner && partner,command="c")
trigger4=(stateno=[140,155])
trigger4=(NumPartner && partner,command="holdback"&&NumPartner && partner,command="c")
trigger5=stateno=5210&&NumPartner && partner,time>=8
trigger5=(NumPartner && partner,command="c")
trigger6=MoveContact&&StateNo=[600,610]
trigger7=MoveContact&&StateNo=[630,640]
ignorehitpause=1
;===============================================================================================
;                                          System States
;===============================================================================================
;Super Jump
[state -1]
type = changestate
value = 40
triggerall = var(53) = 2
triggerall = NumPartner && partner,command = "DU"
trigger1 = statetype != a
trigger1 = var(54) = 1
;=======================================
;Jump
[State -1, Jump]
type = ChangeState
value = 40
triggerall = var(53) = 2 
triggerall = var(54) = 1
triggerall = statetype != A 
triggerall = stateno != 40
trigger1 = NumPartner && partner,command = "holdup"
;=======================================
;Dash Forward
[state -1]
type = changestate
value = 100
triggerall = var(53) = 2
triggerall = statetype != a
trigger1 = (NumPartner && partner,command = "FF") && (stateno !=[100,106])
trigger1 = var(54) = 1
;=======================================
;Air Dash
[State -1,Air Dash]
type = ChangeState
value = 102
triggerall = var(53) = 2
triggerall = NumPartner && partner,command = "FF"
triggerall = roundstate=2
triggerall = statetype = A
triggerall = var(7) = 0
trigger1 = var(54) = 1
trigger1 = PrevStateNo != 102
;=======================================
;Dash Back
[state -1]
type = changestate
value = 105
triggerall = var(53) = 2
trigger1 = NumPartner && partner,command = "BB"
trigger1 = (statetype = s) && (stateno !=[100,106])
trigger1 = var(54) = 1
ignorehitpause = 1
;=======================================
;Air Step Back
[State -1, Air Step Back]
type = ChangeState
value = 107
triggerall = var(53) = 2
triggerall = NumPartner && partner,command = "BB"
triggerall = roundstate=2
triggerall = statetype = A
triggerall = var(7) = 0
trigger1 = var(54) = 1
trigger1 = PrevStateNo != 107
;=======================================
;Taunt
[State -1]
type = ChangeState
value = 115
triggerall = var(53) = 2
triggerall = NumPartner && partner,command ="start"
triggerall = roundstate=2
triggerall = statetype!=A
trigger1 = var(54) = 1
;=======================================
;Guard Push Standing
[State -1]
type = ChangeState
value = 700
triggerall = var(53)=2
triggerall = NumPartner && partner,command = "guardpush"
triggerall = statetype = S
triggerall = roundstate=2
trigger1 = stateno = [150,153]
;=======================================
;Guard Push Crouching
[State -1]
type = ChangeState
value = 705
triggerall = var(53)=2
triggerall = NumPartner && partner,command = "guardpush"
triggerall = statetype = C
triggerall = roundstate=2
trigger1 = stateno = [150,153]
;=======================================
;Guard Push Air
[State -1]
type = ChangeState
value = 710
triggerall = var(53)=2
triggerall = NumPartner && partner,command = "guardpush"
triggerall = statetype = A
triggerall = roundstate=2
trigger1 = stateno = [154,155]
;=======================================
;Alpha/Zero Counter 
[State -1]
type=ChangeState
value=750
triggerall=var(53)=2
triggerall=NumPartner && partner,command="alpha_counter"||NumPartner && partner,Command = "tag"
triggerall=statetype !=A
triggerall=Power >=500
triggerall=P2BodyDist x=[0,60]
triggerall=p2bodydist Y=[-50,10]
triggerall=roundstate=2
trigger1=stateno=150||stateno=152
;=======================================
;Air Alpha/Zero Counter
[State -1]
type =null; ChangeState
value = 755
triggerall = var(53)=2
triggerall = NumPartner && partner,command= "alpha_counter"||NumPartner && partner,Command = "tag"
triggerall = statetype=A
triggerall = Power >=500
triggerall = P2BodyDist x=[0,50]
triggerall = p2bodydist Y=[-30,30]
triggerall = !var(0)&&roundstate=2
trigger1 = stateno=[154,155]
;=======================================
;Defence
[state -1]
type = changestate
triggerall = var(53)=2
triggerall = inguarddist && Life >0 && StateNo !=5000
trigger1 = NumPartner && partner,command = "holdback" && movetype !=H
trigger1 = var(54)=1 && StateNo !=[120,160]
value = 120
;=======================================
;Stand to Crouch
[State -1, Crouch]
type = ChangeState
value = 10
triggerall = var(53) = 2 
triggerall = NumPartner && partner,command = "holddown"
triggerall = var(54) = 1
trigger1 = statetype = S
;=======================================
;Crouch to Stand
[State -1, Crouch]
type = ChangeState
value = 12
triggerall = var(53) = 2 
triggerall = NumPartner && partner,command != "holddown"
trigger1 = stateno = [10,11] 
trigger1 = statetype = C
;=======================================
;Walk
[State -1, Walk]
type = ChangeState
value = ifelse(p2Dist x > 0,20,5)
triggerall = var(53) = 2 
triggerall = var(54) = 1
triggerall = statetype = S
trigger1 = NumPartner && partner,command = "holdfwd" || NumPartner && partner,command = "holdback"
trigger1 = StateNo !=[120,160]
trigger1 = stateno != [100,106]
;=======================================
;Stand
[State -1, Stand]
type = ChangeState
value = 0
triggerall = var(53) = 2
triggerall = var(54) = 1
triggerall = stateno = 20
trigger1 = NumPartner && partner,command != "holdfwd" || NumPartner && partner,command != "holdback"
trigger1 = stateno != [100,106]
