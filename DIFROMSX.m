DIFROMSX ;SFIRMFO/DCM/TKW-MOVE INDEX FILE ENTRIES ;12:31 PM  31 Oct 2001
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1,11,92**
 ;
DDIXOUT(DIFRFILE,DIFRF2,DIFRFDD,DIFRTA) ; retrieve INDEX entries for file
 ; DIFRFILE=top level file#
 ; DIFRF2=current file/subfile #
 ; DIFRFDD=1 if sending full DD
 ; DIFRTA=Global reference of transport global.
 N DIFRNAME,DIFRD0,DIFRD1,DIFRF,DIFRFLD,DIOUT,X,DICNT1,DICNT2
 S DIFRNAME="",DIOUT=0
 F  S DIFRNAME=$O(^DD("IX","BB",DIFRF2,DIFRNAME)) Q:DIFRNAME=""  D  Q:DIOUT
 . S DIFRD0=$O(^DD("IX","BB",DIFRF2,DIFRNAME,0)) Q:'DIFRD0
 . S (DIFRD1,DICNT1,DICNT2)=0
 . F  S DIFRD1=$O(^DD("IX",DIFRD0,11.1,DIFRD1)) Q:'DIFRD1  D  Q:DIOUT
 . . S X=$G(^DD("IX",DIFRD0,11.1,DIFRD1,0))
 . . S DIFRF=$P(X,U,3),DIFRFLD=$P(X,U,4) Q:'DIFRFLD!('DIFRF)
 . . S DICNT1=DICNT1+1,X=$$FNO^DILIBF(DIFRF)
 . . I '$D(@DIFRTA@("^DD",X,DIFRF,DIFRFLD)) D  Q
 . . . Q:'DIFRFDD&($G(@DIFRTA@("FIA",X,DIFRF))'=0)
 . . . D ERR1(DIFRF,DIFRFLD,DIFRNAME,"INDEX") Q
 . . S DICNT2=DICNT2+1
 . . Q
 . Q:DIOUT  I DICNT2=0,'DIFRFDD Q
 . ;I DICNT1'=DICNT2 D ERR2(DIFRF2,DIFRNAME,"INDEX") Q
 . M @DIFRTA@("IX",DIFRFILE,DIFRF2,DIFRNAME)=^DD("IX",DIFRD0)
 . K @DIFRTA@("IX",DIFRFILE,DIFRF2,DIFRNAME,11.1,"AC")
 . K @DIFRTA@("IX",DIFRFILE,DIFRF2,DIFRNAME,11.1,"B")
 . K @DIFRTA@("IX",DIFRFILE,DIFRF2,DIFRNAME,11.1,"BB")
 . Q
 Q
 ;
DDIXIN(DIFRFILE,DIFRF2,DIFRSA) ; Install INDEX file entries for file DIFRFILE
 ; DIFRFILE=source file#
 ; DIFRF2=current file/subfile#
 ; DIFRSA=name of array containing incoming data.
 N DIFRER,DIFRIN,DIFRNAME,DIFRD1,DIOUT,DIFRIN1,DIFRF,DIFRFLD,X
 I '$D(^DD(.11)) S DIFRER("FILE")=.11 D BLD^DIALOG(401,.DIFRER) Q
 S DIFRIN=$NA(@DIFRSA@("IX",DIFRFILE,DIFRF2))
 S DIFRNAME=""
 F  S DIFRNAME=$O(@DIFRIN@(DIFRNAME)) Q:DIFRNAME=""  D
 . S (DIFRD1,DIOUT)=0,DIFRIN1=$NA(@DIFRIN@(DIFRNAME))
 . F  S DIFRD1=$O(@DIFRIN1@(11.1,DIFRD1)) Q:'DIFRD1  D  Q:DIOUT
 . . S X=$G(@DIFRIN1@(11.1,DIFRD1,0))
 . . S DIFRF=$P(X,U,3),DIFRFLD=$P(X,U,4)
 . . I 'DIFRF!('DIFRFLD) Q
 . . I '$D(^DD(DIFRF,DIFRFLD,0)) D ERR3(DIFRF,DIFRFLD,DIFRNAME,"INDEX") Q
 . . I $O(^DD(DIFRF,DIFRFLD,5,0)) D
 . . . Q:$D(^TMP("DIFROMS2",$J,"TRIG",DIFRFILE,DIFRF,DIFRFLD))
 . . . D TRMOD^DICR(DIFRF,DIFRFLD)
 . . . S ^TMP("DIFROMS2",$J,"TRIG",DIFRFLD,DIFRF,DIFRFLD)="" Q
 . . Q
 . Q:DIOUT
 . N DIEN,DIK,DA,DIC,DO
 . S DIEN=$O(^DD("IX","BB",DIFRF2,DIFRNAME,0))
 . I DIEN D  N DINUM S DINUM=DIEN
 . . S DIK="^DD(""IX"",",DA=DIEN N DIEN D ^DIK Q
 . S DIC="^DD(""IX"",",DIC(0)="L",DIC("DR")=".02///^S X="_""""_DIFRNAME_"""",X=DIFRF2 D FILE^DICN S DIEN=+Y
 . I DIEN'>0 D ERR4(DIFRF2,DIFRNAME,"INDEX") Q
 . M ^DD("IX",DIEN)=@DIFRIN1
 . K DIK,DA S DIK="^DD(""IX"",",DA=DIEN D IX1^DIK
 . Q
 Q
 ;
ERR1(DIFRF,DIFRFLD,DIFRNAME,DIFRTYPE) ;
 N DIFRER S DIFRER(1)=DIFRFLD
 S DIFRER(2)=DIFRF
 S DIFRER(3)=DIFRNAME,DIFRER(4)=DIFRTYPE
 D BLD^DIALOG(9543,.DIFRER) S DIOUT=1 Q
ERR2(DIFRF2,DIFRNAME,DIFRTYPE) ;
 N DIFRER S DIFRER(1)=DIFRNAME,DIFRER(2)=DIFRTYPE
 S DIFRER(3)=DIFRF2
 D BLD^DIALOG(9544,.DIFRER) Q
ERR3(DIFRF,DIFRFLD,DIFRNAME,DIFRTYPE) ;
 N DIFRER S DIFRER(1)=DIFRTYPE,DIFRER(2)=DIFRNAME
 S DIFRER(3)=DIFRFLD
 S DIFRER(4)=DIFRF
 D BLD^DIALOG(9545,.DIFRER) S DIOUT=1 Q
ERR4(DIFRF2,DIFRNAME,DIFRTYPE) ;
 N DIFRER S DIFRER(1)=DIFRTYPE,DIFRER(2)=DIFRNAME,DIFRER(3)=DIFRF2
 D BLD^DIALOG(9549,.DIFRER) Q
 ;
 ;9543  Field |1| of file |2|, part of '|3|' |4| entry, is missing from the transport global...
 ;9544  Field(s) that are part of |1| |2| entry are missing from the transport global.
 ;9545  |1| entry |2| not installed.  The REFERENCE FIELD |3| in file |4| does not exist on the system.
 ;9549 |1| "|2|" on file |3| not installed, FILE^DICN call failed.
 ;
