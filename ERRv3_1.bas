!!
                  EARTHROTATION

        © 2023-2025 by Dietmar Schrausser
!!
_name$="ERR"
_ver$="v3.5.9.1" % Standard devices
INCLUDE strg_.inc
! % default //////////////////////////////////
FILE.EXISTS fx, "err.ini"
IF fx
 TEXT.OPEN r, fer, "err.ini"
 TEXT.READLN fer, ini$:s01=VAL(ini$)
 TEXT.READLN fer, ini$:s02=VAL(ini$)
 TEXT.READLN fer, ini$:s03=VAL(ini$)
 TEXT.READLN fer, ini$:s04=VAL(ini$)
 TEXT.READLN fer, ini$:s05=VAL(ini$)
 TEXT.READLN fer, ini$:s06=VAL(ini$)
 TEXT.READLN fer, ini$:s07=VAL(ini$)
 TEXT.READLN fer, ini$:s08=VAL(ini$)
 TEXT.READLN fer, ini$:s09=VAL(ini$)
 TEXT.READLN fer, ini$:s10=VAL(ini$)
 TEXT.READLN fer, ini$:swn=VAL(ini$)
 TEXT.READLN fer, ini$:swo=VAL(ini$)
 TEXT.READLN fer, ini$:swh=VAL(ini$)
 TEXT.READLN fer, ini$:swek=VAL(ini$)
 TEXT.READLN fer, ini$:kp$=ini$
 TEXT.READLN fer, ini$:lp$=ini$
 TEXT.READLN fer, ini$:swc=VAL(ini$)
 TEXT.READLN fer, ini$:fp$=ini$
 TEXT.READLN fer, ini$:swg=VAL(ini$)
 TEXT.READLN fer, ini$:gp$=ini$
 TEXT.READLN fer, ini$:swgr=VAL(ini$)
 TEXT.READLN fer, ini$:grp$=ini$
 TEXT.READLN fer, ini$:swmg=VAL(ini$)
 TEXT.READLN fer, ini$:mgp$=ini$
 TEXT.READLN fer, ini$:swla=VAL(ini$)
 TEXT.READLN fer, ini$:lap$=ini$
 TEXT.READLN fer, ini$:ggg=VAL(ini$)
 TEXT.READLN fer, ini$:ggw=VAL(ini$)
 TEXT.READLN fer, ini$:gwl=VAL(ini$)
 TEXT.READLN fer, ini$:mfi=VAL(ini$)
 TEXT.READLN fer, ini$:skl=VAL(ini$)
 TEXT.CLOSE fer
ELSE
 ! %layer default ///////////////////////////
 s01=1
 s02=1
 s03=1
 s04=1
 s05=1
 s06=1
 s07=1
 s08=1
 s09=-1
 s10=1
 swc=0:fp$="RGB"
 ggg=0.5
 ggw=50
 gwl=0.8
 mfi=50
 skl=3
ENDIF
cc=255
SENSORS.OPEN 1:1
SENSORS.OPEN 2:1
SENSORS.OPEN 3:1
SENSORS.OPEN 9:1
SENSORS.OPEN 10:1
GPS.OPEN
!
DIM x[2]
x[1]=1
x[2]=30
inf=1
dlg=1
sw0=1
ts=50
!
st0: % // color scheme start /////////////////
!
IF swc<=1 THEN GR.OPEN cc,0,0,0,0,1
IF swc=2  THEN GR.OPEN cc/4,0,0,0,0,1
IF swc=3  THEN GR.OPEN cc/5,cc,cc,cc,0,1
IF swc=4  THEN GR.OPEN cc,cc,cc,cc,0,1
!
IF dlg=1 THEN GOSUB dialog
dlg=1
GR.SCREEN sx,sy
mx=sx/2:my=sy/2
pat$="../../ERR/"
!
! /////////////////////
sze=1.9     % // factor
lg= sx/sze  % // size
! /////////////////////
!
GR.COLOR c,0,0,0,0
!
st: % Start //////////////////////////////////
!
GR.CLS
GR.SET.STROKE skl
!
TIME Y$, M$, D$, h$, min$, sec$
yr=VAL(Y$)
sec=VAL(sec$)
nt=VAL(D$)
nm=VAL(M$)
st=VAL(h$)
min=VAL(min$)
!
GPS.ALTITUDE gat
GPS.STATUS gst
GPS.PROVIDER gpv$
GPS.LONGITUDE glo
GPS.LATITUDE gla
GPS.TIME gt
GPS.SPEED gsp
GPS.ACCURACY gac
GPS.SATELLITES gsa
IF gst=0 % GPS off //////////
 s05=-1:gst$="off"
ENDIF
!
IF s06=1 % Text
 IF s05=1 % GPS /////////////////////////////////
  gsp$=FORMAT$("###.#", gsp*3.6) + "km/h"
  gac$=FORMAT$("##", gac)+"m"
  gsa$=FORMAT$("##", gsa)+"Sat"
  gt$=USING$(, "%tT", INT(gt))
  gd$=USING$(, "%tD", INT(gt))
  glo$=FORMAT$("%%.##",glo)
  gla$=FORMAT$("%%.##",gla)
  gla$=gla$+CHR$(176)+"N"
  glo$=glo$+CHR$(176)+"E"
  gat$=FORMAT$("####.#",gat)+"m"
  IF gst=0 : gst$="off" : ENDIF
  IF gst=1 : gst$=CHR$(9602)   : ENDIF
  IF gst=2 : gst$=CHR$(9602)+CHR$(9603)  : ENDIF
  IF gst=3 : gst$= CHR$(9602)+CHR$(9603) +CHR$(9604): ENDIF
  IF gst=4 : gst$= CHR$(9602)+CHR$(9603)+ CHR$(9604)+CHR$(9605) : ENDIF
 ENDIF
 !
 GR.TEXT.ALIGN 3
 GR.TEXT.SIZE sx/38 % /11 ///////////
 GR.TEXT.BOLD 1
 GR.TEXT.DRAW tx,sx,sy/40,D$+"."+M$+"."+Y$
 IF s05=1 & swg THEN GR.TEXT.DRAW tx,sx,sy/23,"gps "+gd$
 GR.TEXT.ALIGN 1
 GR.TEXT.DRAW tx,2,sy/40,h$+":"+min$+":"+sec$
 IF s05=1 & swg THEN GR.TEXT.DRAW tx,2,sy/23,gt$+" gps"
 GR.TEXT.ALIGN 1
 GR.TEXT.SIZE sx/35 % /12 ////////// 
 IF s05=1 % GPS
  GR.TEXT.DRAW tx,2,sy-sy/35,gst$
  IF swg
   GR.TEXT.DRAW tx,0,sy-sy/200,gpv$+gsa$+gac$
  ELSE
   GR.TEXT.DRAW tx,0,sy-sy/20,gpv$
  ENDIF
  GR.TEXT.SIZE sx/28 % /14 ////////// 
  GR.TEXT.ALIGN 2
  GR.TEXT.DRAW tx,mx,sy-sy/180,gla$+glo$
  GR.TEXT.SIZE sx/35 % /12 //////////
  GR.TEXT.ALIGN 3
  GR.TEXT.DRAW tx,sx,sy-sy/200,gat$
  IF swg
   GR.TEXT.DRAW tx,sx,sy-sy/35,gsp$
  ENDIF
 ENDIF
ENDIF
!
SENSORS.READ 1,  clx,cly,clz  % Accelerometer
SENSORS.READ 2,  mfx,mfy,mfz  % Magnetic Field
SENSORS.READ 3,  cp, cpi,crl  % Orientation
SENSORS.READ 9,  cpx,cpy,cpz  % Gravity
SENSORS.READ 10, acx,acy,acz  % Linear Accel
!
IF s08=1 %Linear Acceleration ////////////////////
 ts=sx/300 %factor
 acx=acx*ts
 acy=acy*ts
 acz=acz*ts
 acm=ABS(acy) % maximum ///////////
 IF ABS(acx)>ABS(acm) THEN acm=acx
 IF ABS(acz)>ABS(acm) THEN acm=acz
 GR.CIRCLE cl,mx,my,sx/500*acm^3
 IF ABS(acm)>ABS(acm1) THEN acm1=acm
 IF s09=1
  ts2=gwl*ts % threshold //////////
  IF ABS(acx)>ts2|ABS(acy)>ts2
  ENDIF
  IF ABS(acz)>ts2
  ENDIF
 ENDIF
ENDIF
!
a=cp
IF a< 15 | a>345 : or$= "N"  :ENDIF
IF a<345 & a>330 : or$= "NNW":ENDIF
IF a<330 & a>300 : or$= "NW" :ENDIF
IF a<300 & a>285 : or$= "WNW":ENDIF
IF a<285 & a>255 : or$= "W"  :ENDIF 
IF a<255 & a>240 : or$= "WSW":ENDIF
IF a<240 & a>210 : or$= "SW" :ENDIF
IF a<210 & a>195 : or$= "SSW":ENDIF
IF a<105 & a> 75 : or$= "E"  :ENDIF 
IF a<120 & a>105 : or$= "ESE":ENDIF
IF a<150 & a>120 : or$= "SE" :ENDIF
IF a<165 & a>150 : or$= "SSE":ENDIF
IF a<195 & a>165 : or$= "S"  :ENDIF 
IF a<75  & a>60  : or$= "ENE":ENDIF
IF a<60  & a>30  : or$= "NE" :ENDIF
IF a<30  & a>15  : or$= "NNE":ENDIF
!
IF s01=1 % Compass, earth magnetic field //////////
 IF swc=0 THEN GR.COLOR cc-35,cc,90,90,1
 GR.TEXT.ALIGN 2
 GR.TEXT.SIZE sx/20 % /17 ////////// 
 IF s06=1 THEN GR.TEXT.DRAW tx,mx,sx/10,or$
ENDIF
!
GR.TEXT.BOLD 0
!
IF swc=0 THEN GR.COLOR cc/4,150,150,cc,1
IF swc=1 THEN GR.COLOR cc/3,cc,50,50,1
IF swc=2 THEN GR.COLOR cc/3,50,cc,50,1
IF swc=3 THEN GR.COLOR cc/4,cc,cc,cc,1
IF swc=4 THEN GR.COLOR cc/4,0,0,0,1
!
GR.CIRCLE cl,mx,my,lg-lg/5
!
IF swc=0 THEN GR.COLOR cc/2,cc,cc,cc,0
IF swc=1 THEN GR.COLOR cc/1.5,cc,50,50,0
IF swc=2 THEN GR.COLOR cc/2,50,cc,50,0
IF swc=3 THEN GR.COLOR cc/3,cc,cc,cc,0
IF swc=4 THEN GR.COLOR cc/2,0,0,0,0
!
lgz=lg-lg/4
GR.TEXT.SIZE sx/45 % /10 //////////
GR.TEXT.ALIGN 1
!
IF s03=1 % Gravitational Field g ///////////////////
 !
 GR.LINE ln ,mx, my, mx-(lgz*cpx/10) ,my +(lgz*cpy/10) 
 GR.LINE ln ,mx, my, mx+(lgz*cpx/10) ,my -(lgz*cpy/10) 
 GR.TEXT.DRAW tx, mx-(lgz*cpx/10)-3, my+(lgz*cpy/10)+8,"g"
ENDIF
!
IF s02=1 % space z //////////////////////////////// 
 !
 GR.LINE ln ,mx, my, mx-(lgz*clx/10) ,my +(lgz*cly/10) 
 GR.LINE ln ,mx, my, mx+(lgz*clx/10) ,my - (lgz*cly/10)
 GR.TEXT.DRAW tx, mx+(lgz*clx/10)-3, my-(lgz*cly/10)-5,"z"
ENDIF
!
ag=lg-lg/5
ag1=SIN(TORADIANS(90-cpi))
!
! % Compass /////////////////////////////////////////
axp=sx/17
GR.ROTATE.START -cp,mx,my
IF swn>1 % Mark (N) ////////////////////
 GR.CIRCLE cl,mx,my-(lg-axp) *ag1,sy/70 
ENDIF
ag2=SIN(TORADIANS(crl))
GR.ROTATE.END
!
IF swc=0 THEN GR.COLOR cc/2,cc,cc,cc,0
IF swc=1 THEN GR.COLOR cc/2,cc,50,50,0
IF swc=2 THEN GR.COLOR cc/2,50,cc,50,0
IF swc=3 THEN GR.COLOR cc/3,cc,cc,cc,0
IF swc=4 THEN GR.COLOR cc/2,0,0,0,0
!
ag0=SIN(TORADIANS(90-(cpy/10*90)))
IF s03=1 % Gravitation layer x ///////////////////////
 GR.ROTATE.START 180+((cpx/10)*90),mx,my
 GR.ARC ar, mx+ag,my-(ag*ag0), mx-ag,my+(ag*ag0),0,360,0
 GR.ROTATE.END
ENDIF
!
ag2=SIN(TORADIANS(90-(cpx/10)*90))
GR.ROTATE.START (180+((cpx/10)*90)),mx,my
IF s03=1 % Gravitation layer y ///////////////////////
ENDIF
!
IF s01=1 % Earth magnetic field ///////////////////////
 GR.ROTATE.START 360-cp,mx,my
 GR.ROTATE.START 90,mx,my
 IF swc=0 THEN GR.COLOR cc-35,cc,90,90,0
 ! % E-W axis /////////
 IF swo=1 THEN GR.LINE ln, mx,my+(lg-15)*ag1 ,mx,my-(lg-15)*ag1
 GR.ROTATE.END
 GR.ROTATE.END
ENDIF
GR.ROTATE.END
!
IF swc=0 THEN GR.COLOR cc/2,cc,cc,cc,0
al0=SIN(TORADIANS(90-(cly/10*90)))
IF s02=1 % space x ////////////////////////////////////
 GR.ROTATE.START 180+((clx/10)*90),mx,my
 GR.ARC ar, mx+(ag),my-(ag*al0), mx-ag,my+ag*al0,0,360,0
 ! % Horizon /////////////////////////////
 IF swh
  IF swc=0 THEN GR.COLOR cc/4,150,150,cc,1
  IF swc=1 THEN GR.COLOR cc/2,cc,50,50,1
  IF swc=2 THEN GR.COLOR cc/2,50,cc,50,1
  IF swc=3 THEN GR.COLOR cc/3,cc,cc,cc,1
  IF swc=4 THEN GR.COLOR cc/4,0,0,0,1
  GR.ARC ar, mx-ag,my-(ag*al0), mx+ag,my+ag*al0,-cp,-180,0
 ENDIF
 GR.ROTATE.END
ENDIF
!
al2=SIN(TORADIANS(90-(clx/10)*90))
GR.ROTATE.START (180+((clx/10)*90)),mx,my
!
IF s02=1 % Space layers y
ENDIF
!
GR.ROTATE.END
!
ag2=SIN(TORADIANS((cpx/10)*90))
al2=SIN(TORADIANS((clx/10)*90))
!
GR.CIRCLE cl,mx,my, sx/340
IF s01=1 % Earth magnetic field //////////////////////
 !
 GR.ROTATE.START 360-cp,mx,my
 IF swc=0 THEN GR.COLOR cc-35,cc,90,90,1
 IF swc=1 THEN GR.COLOR cc,cc,50,50,1
 IF swc=2 THEN GR.COLOR cc,50,cc,50,1
 IF swc=3 THEN GR.COLOR cc/2,cc,cc,cc,1
 IF swc=4 THEN GR.COLOR cc,0,0,0,1
 GR.CIRCLE cl,mx,my-(lg-axp)*(ag1),sx/250
 ! % N-S axis ///////////////
 IF swn<2 
  GR.LINE ln, mx,my+(lg-axp)*ag1 ,mx,my-(lg-axp)*ag1
  GR.CIRCLE cl, mx,my+(lg-axp)*ag1, sx/250 
 ENDIF
 IF swn<3 THEN GR.LINE ln, mx,my,mx,my-(lg-axp)*ag1
 GR.TEXT.DRAW tx, mx-sx/500,my-(lg-axp)*ag1-sx/1000 ,""
 GR.TEXT.ALIGN 2
 GR.TEXT.SIZE sx/30 % //17! //////////////
 GR.ROTATE.END
 IF s06=1
  posc=sx/15 % // position
  GR.ROTATE.START 360-cp,mx,my
  GR.TEXT.DRAW tx, mx,my-lg+posc,"N"
  GR.ROTATE.END
  GR.ROTATE.START 180-cp,mx,my
  GR.TEXT.DRAW tx, mx,my-lg+posc,"S"
  GR.ROTATE.END
  GR.ROTATE.START 90-cp,mx,my
  GR.TEXT.DRAW tx, mx,my-lg+posc,"O"
  GR.ROTATE.END
  GR.ROTATE.START 270-cp,mx,my
  GR.TEXT.DRAW tx, mx,my-lg+posc,"W"
  GR.ROTATE.END
 ENDIF
ENDIF
!
IF s03=1&s02=1
 ! %grav acc //////////////////////////////////
 dx=ABS(cpx-clx)
 dy=ABS(cpy-cly)
 dz=ABS(cpz-clz)
 IF dx>dmxg THEN dmxg=dx
 IF dy>dmxg THEN dmxg=dy
 IF dz>dmxg THEN dmxg=dz
ENDIF
!
cp$=  FORMAT$("###.#",cp)+"°"
cpi$= FORMAT$("###.#",-cpi)+"°"+ CHR$(8597)
crl$= FORMAT$("###.#", crl)+"°"+ CHR$(8596)
GR.TEXT.ALIGN 2
GR.TEXT.SIZE sx/26 %/ 14 /////////
!
IF s06=1
 IF s01=1 % Earth magnetic field Text //////////
  !
  ypos= sy/10 % y position //////
  !
  GR.TEXT.DRAW tx,mx,     ypos,cpi$
  GR.TEXT.DRAW tx,mx+mx/3,ypos,crl$
  GR.TEXT.DRAW tx,mx-mx/3,ypos,cp$
 ENDIF
 IF swc=0 THEN GR.COLOR cc-140,225,225,cc,1
 IF s03=1 % Grav field Text
  cpx$=   CHR$(0)+ FORMAT$("###",(cpx/10)*90)+"°x"
  cpy$=   CHR$(0)+ FORMAT$("###",(cpy/10)*90)+"°y"
  cpz$=   CHR$(0)+ FORMAT$("###",(cpz/10)*90)+"°z"
  dmxg$=  CHR$(0)+ FORMAT$("##.##",dmxg)+"°"
  !
  posygr=sy/7 % y position //////
  !
  GR.TEXT.DRAW tx,mx-mx/3,sy-posygr, cpz$
  GR.TEXT.DRAW tx,mx,     sy-posygr, cpy$
  GR.TEXT.DRAW tx,mx+mx/3,sy-posygr, cpx$
  GR.TEXT.DRAW tx,mx-mx/1.6,sy-posygr,"g:" 
 ENDIF
 IF s02=1 % Space Text /////////////////////////
  clx$=  CHR$(0)+ FORMAT$("###",(clx/10)*90)+"°x"
  cly$=  CHR$(0)+ FORMAT$("###",(cly/10)*90)+"°y"
  clz$=  CHR$(0)+ FORMAT$("###",(clz/10)*90)+"°z"
  !
  posyz= sy/6 % y position //////
  !
  GR.TEXT.DRAW tx,mx+mx/3,sy-posyz,clx$ 
  GR.TEXT.DRAW tx,mx,     sy-posyz,cly$
  GR.TEXT.DRAW tx,mx-mx/3,sy-posyz,clz$
  GR.TEXT.DRAW tx,mx-mx/1.6,sy-posyz,"z:" 
 ENDIF
 IF s08=1 % Linear Acceleration Text ///////////
  acx$=FORMAT$("#.##",acx/ts)+"°x"
  acy$=FORMAT$("#.##",acy/ts)+"°y"
  acz$=FORMAT$("#.##",acz/ts)+"°z"
  acm1$=CHR$(9650)+FORMAT$("##.##",ABS(acm1/ts))+"°"
  !
  posyl= sy/10 % y position //////
  !
  GR.TEXT.DRAW tx,mx+mx/3,sy-posyl,acx$ 
  GR.TEXT.DRAW tx,mx,     sy-posyl,acy$
  GR.TEXT.DRAW tx,mx-mx/3,sy-posyl,acz$
  GR.TEXT.DRAW tx,mx-mx/1.6,sy-posyl,"d:"
  GR.TEXT.ALIGN 3
  GR.TEXT.DRAW tx,sx,sy-posyl,acm1$
 ENDIF
ENDIF
!
IF s04=1 % Local Magnetic Field ////////////////
 IF swc=0 THEN GR.COLOR cc-140,cc,cc,50,1
 mfx$= CHR$(0)+ FORMAT$("###.##",  mfx/100)+"x"
 mfy$= CHR$(0)+ FORMAT$("#####.##",mfy/100)+"y"
 mfz$= CHR$(0)+ FORMAT$("###.##",  mfz/100)+"z"
 ! % Vector ////////////
 snm=100 % Field intensity /////////////////////
 GR.CIRCLE cl ,mx-(lgz*mfx/snm),my +(lgz*mfy/snm) ,sx/200
 GR.LINE ln ,mx,my,mx - (lgz*mfx/snm) ,my+(lgz*mfy/snm)
 GR.LINE ln ,mx,my,mx + (lgz*mfx/snm) ,my-(lgz*mfy/snm)
 !
 IF swmg=1
  GR.TEXT.ALIGN 2
  GR.Text. draw tx ,mx + (lgz*mfx/snm) ,my-(lgz*mfy/snm), "+"
  GR.COLOR cc-200,cc,cc,50,1
  ! GR.LINE ln ,mx, my, mx+(lgz*mfx/snm) ,my-(lgy*mfz/snm)
  ! GR.LINE ln ,mx, my, mx-(lgz*mfx/snm) ,my+(lgy*mfz/snm)
  ! GR.LINE ln ,mx, my, mx-(lgx*mfz/snm) ,my+(lgz*mfy/snm)
  ! GR.LINE ln ,mx, my, mx+(lgx*mfz/snm) ,my-(lgz*mfy/snm)
  IF swc=0 THEN GR.COLOR cc-140,cc,cc,50,1
 ELSE
  GR.CIRCLE cl ,mx+(lgz*mfx/snm),my -(lgz*mfy/snm) ,sx/200
  GR.LINE ln ,mx-2,my-2,mx +(lgz*mfx/snm)-2 ,my-(lgz*mfy/snm)-2
  GR.LINE ln ,mx+2,my+2,mx +(lgz*mfx/snm)+2 ,my-(lgz*mfy/snm)+2
 ENDIF
 !
 GR.TEXT.ALIGN 2
 GR.TEXT.BOLD 1
 IF s06=1
  !
  posyg= sy/6 % y position ////// 
  !
  GR.TEXT.DRAW tx,mx,       posyg,mfy$
  GR.TEXT.DRAW tx,mx+mx/3,  posyg,mfx$
  GR.TEXT.DRAW tx,mx-mx/3,  posyg,mfz$
  GR.TEXT.DRAW tx,mx-mx/1.6,posyg,"G:" 
 ENDIF
 !
 ! Magnetic Field indicator, circle ///////////
 IF mfi<>0
  GR.CIRCLE cl,mx,my, sx/mfi*ABS(mfz)/100 % // 20
  IF mfz>0 
   GR.COLOR 150,0,0,0,1
   GR.CIRCLE cl,mx,my, sx/(mfi+1)*ABS(mfz)/100 % // 19
  ENDIF
  IF swc=0 THEN GR.COLOR cc-140,cc,cc,50,1
  GR.CIRCLE cl,mx,0, sx/mfi*ABS(mfy)/100 % // 20
  IF mfy<0 
   GR.COLOR 150,0,0,0,1
   GR.CIRCLE cl,mx,0, sx/(mfi+1)*ABS(mfy)/100 % // 19
  ENDIF
 ENDIF
 IF s09=1
  mfmx=ggw % Signal threshold density //////////////
  IF mfy > mfmx THEN TONE 10000, 100
  IF mfy < -mfmx THEN TONE 5000, 100
  IF mfx > mfmx THEN TONE 10000, 100
  IF mfx < -mfmx THEN TONE 5000, 100
  IF mfz > mfmx THEN TONE 10000, 100
  IF mfz < -mfmx THEN TONE 5000, 100
 ENDIF
ENDIF
!
IF swc=0 THEN GR.COLOR cc-140,225,225,cc,1
IF swc=1 THEN GR.COLOR cc,cc,50,50,1
IF swc=2 THEN GR.COLOR cc,50,cc,50,1
IF swc=3 THEN GR.COLOR cc/2,cc,cc,cc,1
IF swc=4 THEN GR.COLOR cc,0,0,0,1
!
GR.RENDER
!
GR.TOUCH tc,tx,ty
IF tc 
 GOSUB dialog
ENDIF
!
IF dlg=1 
 GOTO st
ELSE
 GR.CLOSE
 GOTO st0 % // color scheme /////////////////////
ENDIF
!
ONERROR:
GOSUB fin
END
ONMENUKEY:
GOSUB dialog
MENUKEY.RESUME
ONBACKKEY:
GOSUB fin
END
!
! dialog subroutines
!////////////////////////////////////////////////
!
dialog:
smb$=CHR$(9989)
smq$=CHR$(9654)
GOSUB menu
!
std:
ARRAY.LOAD sel$[],o01$,o04$,o02$,o03$,o08$,o05$,o06$,o07$,o11$,o09$,"Ok", _ex$+"  Exit"
DIALOG.SELECT sel, sel$[],_name$+" Earthrotation "+_ver$+" - Layers:"
IF sel=1
 s01=s01*-1
 IF s01=1 THEN GOSUB dialogk
ENDIF
IF sel=2
 s04=s04*-1
 IF s04=1 THEN GOSUB dialogm
ENDIF
IF sel=3
 s02=s02*-1
 IF s02=1 THEN GOSUB dialogl
ENDIF
IF sel=4
 s03=s03*-1:dmxg=0
 IF s03=1 THEN GOSUB dialoggr
ENDIF
IF sel=5
 s08=s08*-1:acm1=0
 IF s08=1 THEN GOSUB dialogla
ENDIF
IF sel=6
 s05=s05*-1
 IF s05=1 THEN GOSUB dialogg
ENDIF
IF sel=7:s06=s06*-1:ENDIF
IF sel=8
 GOSUB dialogf
 inf=0:dlg=0
ENDIF
IF sel=9
 GOSUB lbrte
ENDIF
IF sel=10:s09=s09*-1:ENDIF
IF sel=11:RETURN:   ENDIF
IF sel=12:GOSUB fin:   ENDIF
GOSUB menu
GOTO std
RETURN
!
menu:
IF s01=1:o01$=smb$+"  Compass "+kp$:ENDIF
IF s01=-1: o01$="     Compass off":  ENDIF
IF s02=1:o02$=smb$+"  Space "+lp$:ENDIF
IF s02=-1: o02$="     Space off":  ENDIF
IF s03=1:o03$=smb$+"  Gravitation "+grp$:ENDIF
IF s03=-1: o03$="     Gravitation off":  ENDIF
IF s04=1:o04$=smb$+"  Magnetic Field "+mgp$:ENDIF
IF s04=-1: o04$="     Magnetic Field off":  ENDIF
IF s05=1:o05$=smb$+"  GPS "+gp$:ENDIF
IF s05=-1: o05$="     GPS off":  ENDIF
IF s06=1:o06$=smb$+"  Text":ENDIF
IF s06=-1: o06$="     Text off":  ENDIF
o07$=smq$+"  Color scheme:  "+fp$
o11$=smq$+"  Line width:  "+INT$(skl)
IF s08=1:o08$=smb$+"  Linear Acceleration "+lap$:ENDIF
IF s08=-1: o08$="     Linear Acceleration off":  ENDIF
IF s09=1:o09$=smb$+"  Signal":ENDIF
IF s09=-1: o09$="     Signal off":  ENDIF
!
RETURN
!
dialogk:
k01$="(N) Position"
k02$="(N)- Vector"
k03$="N-S Axis"
ARRAY.LOAD sel2$[],k01$,k02$,k03$
DIALOG.SELECT sel2, sel2$[],"Compass Options:"
IF sel2=1:swn=3:swo=0:kp$="(N)":ENDIF
IF sel2=2:swn=2:swo=0:kp$="(N)-":ENDIF
IF sel2=3:swn=1:swo=0:kp$="N-S":ENDIF
RETURN
!
dialogl:
l01$="Normal"
l02$="Horizon"
ARRAY.LOAD sel3$[],l01$,l02$
DIALOG.SELECT sel3, sel3$[],"Space Options:"
IF sel3=1:swh=0:swek=0:lp$="":ENDIF
IF sel3=2:swh=1:swek=0:lp$="Horizon":ENDIF
RETURN
!
dialogg:
g01$="Normal"
g02$="Full"
ARRAY.LOAD sel4$[],g01$,g02$
DIALOG.SELECT sel4, sel4$[],"GPS Profil:"
IF sel4=1:swg=1:gp$="":ENDIF
IF sel4=2:swg=1:gp$="Full":ENDIF
RETURN
!
dialogf:
f01$="RGB"
f02$="Red"
f03$="Green"
f04$="Black"
f05$="White"
ARRAY.LOAD sel5$[],f01$,f02$,f03$,f04$,f05$
DIALOG.SELECT sel5, sel5$[],"Color:"
IF sel5=1:swc=0:fp$="RGB":ENDIF
IF sel5=2:swc=1:fp$="Red":ENDIF
IF sel5=3:swc=2:fp$="Green":ENDIF
IF sel5=4:swc=3:fp$="Black":ENDIF
IF sel5=5:swc=4:fp$="White":ENDIF
RETURN
!
dialoggr:
RETURN
!
dialogm:
gm01$="Normal" 
gm02$="Magnetic Poles +/-" 
gm03$="Density Threshold="+FORMAT$("###.##",ggw/100)+" G"
gm04$="Indicator Sensitivity= "+FORMAT$("##.##",mfi/100)+" G" 
ARRAY.LOAD sel7$[],gm01$, gm02$, gm03$, gm04$
DIALOG.SELECT sel7, sel7$[],"Magnetic Field Options:"
IF sel7=1:swmg=0:mgp$="":ENDIF
IF sel7=2:swmg=1:mgp$="+/-":ENDIF
IF sel7=3
 ggwi=ggw/100
 INPUT "Density Gauss G=… ",ggwi,0.50
 ggw=ggwi*100
ENDIF
IF sel7=4
 mfii=mfi/100
 INPUT "Sensitivity=… ",mfii,0.50
 mfi=mfii*100
ENDIF
RETURN
!
dialogla:
RETURN
!
lbrte:
ARRAY.LOAD selbr$[],"1 [very narrow]","2 [narrow]","3 [normal]","4 [bold]","5 [very bold]"
DIALOG.SELECT skl, selbr$[],"Line width:"
RETURN 
!
fin:
! %write defaults
TEXT.OPEN w, fer, "err.ini"
TEXT.WRITELN fer, s01
TEXT.WRITELN fer, s02
TEXT.WRITELN fer, s03
TEXT.WRITELN fer, s04
TEXT.WRITELN fer, s05
TEXT.WRITELN fer, s06
TEXT.WRITELN fer, s07
TEXT.WRITELN fer, s08
TEXT.WRITELN fer, s09
TEXT.WRITELN fer, s10
TEXT.WRITELN fer, swn
TEXT.WRITELN fer, swo
TEXT.WRITELN fer, swh
TEXT.WRITELN fer, swek
TEXT.WRITELN fer, kp$
TEXT.WRITELN fer, lp$
TEXT.WRITELN fer, swc
TEXT.WRITELN fer, fp$
TEXT.WRITELN fer, swg
TEXT.WRITELN fer, gp$
TEXT.WRITELN fer, swgr
TEXT.WRITELN fer, grp$
TEXT.WRITELN fer, swmg
TEXT.WRITELN fer, mgp$
TEXT.WRITELN fer, swla
TEXT.WRITELN fer, lap$
TEXT.WRITELN fer, ggg
TEXT.WRITELN fer, ggw
TEXT.WRITELN fer, gwl
TEXT.WRITELN fer, mfi
TEXT.WRITELN fer, skl
TEXT.CLOSE fer
CONSOLE.TITLE _name$
PRINT _name$+" Earthrotation "+_ver$         
PRINT "Copyright "+_cr$+" 2024 by Dietmar Gerald Schrausser"
PRINT "https://github.com/Schrausser/ERR"
END
RETURN
! // END //
! //
