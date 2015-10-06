DIAXU ;SFISC/DCM-UPDATE DESTINATION FILE ;8/16/96  16:42
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q
DIAX ;called from ^DIAX (Update Destination File option)
DQ ;
 I $D(ZTQUEUED) N DIAR,DIAX S ZTREQ="@",DIAR=6,DIAX=1 D MRK^DIARU
 N DIAXF,DIAXFRT S DIAXF=$P(^DIAR(1.11,DIARC,0),U,2),DIAXFRT=$$ROOT^DILFD(DIAXF)
 D EXTRACT(DIAXF,DIARB,DIARP)
 D UPDATE^DIARU
 I $D(ZTQUEUED),$G(DIERR) S ZTIO=DIAXIOP,ZTRTN="XREP^DIAXU",ZTDESC="EXTRACT TOOL EXCEPTION REPORT",ZTSAVE("^TMP(""DIAXU"",$J)")="",ZTSAVE("^TMP(""DIERR"",$J)")="",ZTSAVE("DIARC")="" D ^%ZTLOAD Q 
XREP ;
 I $D(ZTQUEUED) S ZTREQ="@"
 D ^DIAXP
 Q
EN ; obsolete, replaced by EXTRACT
 N %,DIAXERR S DIAXERR=""
 D CLEAN^DIEFU
 F %=$G(DIAXF)_U_"DIAXF",$G(DIAXFE)_U_"DIAXFE",$G(DIAXT)_U_"DIAXT" I $P(%,U,1)']"" D ERR(201,$P(%,U,2))
 Q:$G(DIERR)
 D EXTRACT(DIAXF,DIAXFE,DIAXT,$S($D(DIAXDEL):"D",1:""))
 I '$G(DIERR),$D(^TMP("DIAXU",$J,"RESULT",DIAXF,DIAXFE)) S DIAXDA=^(DIAXFE)
 Q
 ;
DIPT N X,D,SCR,DIARP,DIAR,DIPG
 S X=$S(DIAXT:DIAXT,1:$P($P(DIAXT,"[",2),"]")),D="F"_DIAXF,SCR="I $P(^(0),U,8)=2"
 S DIARP=$$FIND1^DIC(.4,"","XA",X,D,SCR,DIAXERR)
 Q:$G(DIERR)  I 'DIARP D ERR(202,"EXTRACT TEMPLATE") Q
 S DIAR=6,DIPG=1,DIAXT=DIARP,DIAXDF=$P(^DIPT(DIAXT,0),U,9),DIAXDFRT=$$ROOT^DILFD(DIAXDF)
 D EN^DIAXM
 Q
DIK N DIK,DA
 S DIK=$$ROOT^DILFD(DIAXF),DA=DIAXFE
 D ^DIK
 Q
K K @DIAXTFR,@DIAXTTO
 Q
ONE I '$$VENTRY^DIEFU(DIAXF,DIAXFE) D ERR(601,DIAXFE),STE() Q
 D ^DIAXD I $G(DIERR) D:$D(DIAXFILE)  D STE() Q
 . N DIERR,A S A("IEN")=DIAXFE
 . D BLD^DIALOG(1300,"",.A)
 D ^DIAXF I $G(DIERR) D STE() Q
 Q:$D(DIAX)
 I $G(DIAXFLGS)["D" D DIK
 I $G(DIAXDA) S @DIAXRSLT@("RESULT",DIAXF,DIAXFE)=DIAXDA
 Q
 ;
DIBT N SCR,D
 S D="F"_DIAXF,SCR="I $P(^(0),U,4)="_DIAXF_",'$P(^(0),U,8)"
 S DIAXST=$S($G(DIAXST):DIAXST,1:$$FIND1^DIC(.401,"","AX",DIAXST,D,SCR,DIAXERR))
 I 'DIAXST!('$D(^DIBT(DIAXST,1))) D ERR(202,"SEARCH TEMPLATE") S:$G(DIAR) DIAR="" Q
 N Z S Z=0 F  S Z=$O(^DIBT(DIAXST,1,Z)) Q:Z'>0  D
 . N DIAXDA,DIAXFE,DIERR
 . S DIAXFE=Z
 . D ONE
 . Q:$G(DIERR)
 . I $G(DIAX) D  Q
 . . N FDA,IEN
 . . S FDA(1.14,"+"_+DIAXFE_","_DIARC_",",.01)=DIAXDA,IEN(DIAXFE)=DIAXDA
 . . D UPDATE^DIE("","FDA","IEN")
 . . S @(DIAXFRT_"DIAXFE,-9)")=DIARC
 . I $G(DIAXFLGS)["D" K ^DIBT(DIAXST,1,DIAXFE)
 Q
STE(FI,IEN) N Z
 S:$G(FI)="" FI=DIAXF
 S:$G(IEN)="" IEN=DIAXFE
 S DIERRZ=(DIERR+DIERRZ)_U_($P(DIERR,U,2)+($P(DIERRZ,U,2)))
 F DIERRLST=DIERRLST:1:$O(^TMP("DIERR",$J,"E"),-1) S Z=DIERRLST_";"
 S @DIAXRSLT@("RESULT","ERR",FI,IEN)=Z
 Q
ERR(DIAXER,DIAXTXT) ;
 D BLD^DIALOG(DIAXER,DIAXTXT,"",DIAXERR,"F")
 Q
EXTRACT(DIAXF,DIAXSRCE,DIAXT,DIAXFLGS,DIAXSCR,DIAXFILE,DIAXRSLT,DIAXERRA) ;
 N DIAXST,DIAXFE,T,DIFM,DIOVRD,DIERRLST,DIAXTFR,DIAXTTO,DIAXDF,DIAXDFRT,DIAXERR,DIERRZ,DIAXDA
 S DIAXRSLT=$S($G(DIAXRSLT)]"":DIAXRSLT,1:"^TMP(""DIAXU"",$J)"),(DIFM,DIOVRD)=1,(DIERRLST,DIERRZ)=0,DIAXERR=""
 K ^TMP("DIAXU",$J),^TMP("DIAX",$J),^TMP($J) D CLEAN^DIEFU
 I '$G(DIAR) D  Q:$G(DIERR)
 . N %,PARAM F %=1:1:3 S PARAM=$S(%=1:$G(DIAXF)_U_"FILE",%=2:$G(DIAXSRCE)_U_"SOURCE",1:$G(DIAXT)_U_"EXTRACT TEMPLATE") I $P(PARAM,U)']"" D ERR(202,$P(PARAM,U,2))
 . Q:$G(DIERR)
 . I '$$VFILE^DIEFU(DIAXF) D ERR(202,"FILE") Q
 . I $G(DIAXSRCE) S DIAXFE=+DIAXSRCE,T="ONE"
 . I $E(DIAXSRCE)="[" S DIAXST=$P($P(DIAXSRCE,"[",2),"]"),T="DIBT"
 . D DIPT
 . Q
 E  S T="DIBT",DIAXST=DIAXSRCE
 D ^DIAXT I $G(DIERR) S:$G(DIAR) DIAR="" Q
 D @T,K
 I $G(DIERRZ) S DIERR=DIERRZ
 I $G(DIERR),$G(DIAXERRA)]"" M @DIAXERRA@("DIERR")=^TMP("DIERR",$J) K ^TMP("DIERR",$J)
 Q