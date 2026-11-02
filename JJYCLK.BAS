REM JJYCLK

USEVAR MIN,HOUR,DAYS,YEAR,WEEK

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
REM   PRINT C
   IF     (C > 800-50) AND (C < 800+50) THEN
    N=N+1
    IF F!=1 THEN
     G=(G<<1) OR 0
     REM PRINT 0;
    ENDIF
   ELSEIF (C > 500-50) AND (C < 500+50) THEN
    N=N+1
    IF F!=1 THEN
     G=(G<<1) OR 1
     REM PRINT 1;
    ENDIF
   ELSEIF (C > 200-50) AND (C < 200+50) THEN
    REM PRINT ""
    IF F==1 THEN
     F=0
    ELSE
     IF N==8 THEN
      PRINT "BEGIN"
      MIN=((G>>5) AND 0x07)*10+(G AND 0x0F)
      T=1
     ELSEIF N==9 THEN
      IF     T==1 THEN
       HOUR=((G>>5) AND 0x03)*10+(G AND 0x0F)
       PRINT HOUR;":";DEC$(MIN)
      ELSEIF T==2 THEN
       DAYS=((G>>5) AND 0x03)*100+(G AND 0x0F)*10
      ELSEIF T==3 THEN
       DAYS= DAYS+((G>>5) AND 0x0F)
       PRINT "Days:";DAYS
      ELSEIF T==4 THEN
       YEAR=2000+((G>>4) AND 0x0F)*10+(G AND 0x0F)
       PRINT YEAR
      ELSEIF T==5 THEN
       WEEK=(G>>6) AND 0x07
       PRINT WEEK
      ENDIF
      T=T+1
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
