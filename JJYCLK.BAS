REM JJYCLK

USEVAR MIN,HOUR,DAYS,DOW,YEAR,MON,DAY,PA1,PA2,RSLT

USETIMER 1000
INTERRUPT TIMER, ISRTMR

CLS
F=1
C=0
N=0
T=0
G=0
WHILE 1
 IF A==0 THEN
  IF C>0 THEN
   REM PRINT C
   IF     (C > 800-80) AND (C < 800+80) THEN
    N=N+1
    IF F!=1 THEN
     G=(G<<1) OR 0
     REM PRINT 0;
    ENDIF
   ELSEIF (C > 500-80) AND (C < 500+80) THEN
    N=N+1
    IF F!=1 THEN
     G=(G<<1) OR 1
     REM PRINT 1;
    ENDIF
   ELSEIF (C > 200-80) AND (C < 200+80) THEN
    REM PRINT ""
    IF F==1 THEN
     F=0
     N=0
    ELSE
     IF N==8 THEN
      REM PRINT "BEGIN"
      PA2=    (G>>7 AND 1)
      PA2=PA2+(G>>6 AND 1)
      PA2=PA2+(G>>5 AND 1)
      PA2=PA2+(G>>3 AND 1)
      PA2=PA2+(G>>2 AND 1)
      PA2=PA2+(G>>1 AND 1)
      PA2=PA2+(G    AND 1)
      PA2=PA2 AND 1
      MIN=((G>>5) AND 0x07)*10+(G AND 0x0F)
      T=1
     ELSEIF N==9 THEN
      IF     T==1 THEN
       PA1=    (G>>6 AND 1)
       PA1=PA1+(G>>5 AND 1)
       PA1=PA1+(G>>3 AND 1)
       PA1=PA1+(G>>2 AND 1)
       PA1=PA1+(G>>1 AND 1)
       PA1=PA1+(G    AND 1)
       PA1=PA1 AND 1
       HOUR=((G>>5) AND 0x03)*10+(G AND 0x0F)
       REM PRINT HOUR;":";MIN
       T=T+1
      ELSEIF T==2 THEN
       DAYS=((G>>5) AND 0x03)*100+(G AND 0x0F)*10
       T=T+1
      ELSEIF T==3 THEN
       DAYS= DAYS+((G>>5) AND 0x0F)
       GOSUB(MONDAY, DAYS)
       REM PRINT "Days:";DAYS
       IF (PA1==(G>>2 AND 1)) AND (PA2==(G>>1 AND 1)) THEN 
        RSLT=1
       ELSE
        RSLT=0
       ENDIF
       T=T+1
      ELSEIF T==4 THEN
       YEAR=2000+((G>>4) AND 0x0F)*10+(G AND 0x0F)
       REM PRINT YEAR;"/";MON;"/";DAY;
       T=T+1
      ELSEIF T==5 THEN
       DOW$=GOSUB$(DAYWEEK,(G>>6) AND 0x07)
       IF RSLT==1 THEN
        PRINT YEAR;"/";MON;"/";DAY;"(";DOW$;")"
        PRINT HOUR;":";MIN
       ELSE
        PRINT "Wrong"
       ENDIF
       PRINT ""
       T=0
      ENDIF
     ENDIF
    ENDIF
    N=0
   ENDIF
   C=0
  ENDIF
 ENDIF
 IDLE
WEND

LABEL ISRTMR
 A=IN(0)
 IF A==1 THEN
  C=C+1
 ENDIF 
RETURN

LABEL MONDAY
 VAR Z,S,I
 Z=ARGS(1)
 RESTORE DAYSSUM
 FOR I=0 TO 11
  S=CREAD()
  IF Z>S THEN
   Z=Z-S
  ELSE
   BREAK
  ENDIF
 NEXT
 MON=I+1
 DAY=Z
RETURN

LABEL DAYWEEK
 VAR Z
 Z=ARGS(1)
 IF     Z==0 THEN
  DOW$="Sun"
 ELSEIF Z==1 THEN
  DOW$="Mon"
 ELSEIF Z==2 THEN
  DOW$="Tue"
 ELSEIF Z==3 THEN
  DOW$="Wed"
 ELSEIF Z==4 THEN
  DOW$="Thu"
 ELSEIF Z==5 THEN
  DOW$="Fri"
 ELSEIF Z==6 THEN
  DOW$="Sat"
 ENDIF
RETURN DOW$

LABEL DAYSSUM
CDATA 31,28,31,30,31,30,31,31,30,31,30,31