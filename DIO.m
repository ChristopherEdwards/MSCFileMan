DIO ;SFISC/GFT,TKW-CALL SORT, ACTUAL OUTPUT ;7:15 AM  27 May 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**2**
 ;
 S Y=-1 K:$D(DCL)>9 ^DOSV(0,IO(0)) F Z=0:1 S Y=$O(DCL(Y)) Q:Y=""  S V=DCL(Y),^DOSV(0,IO(0),"F",+V)=Y_U_$P($G(^DD(+Y,+$P(Y,U,2),0)),U,1,2)
 I $G(DIOEND)["M^DIAU"!($G(DIOEND)["L^DIDC") S %X="DPP(",%Y="DIPP(" D %XY^%RCR S DIJS=DJ,DIPQ=DPQ,DIMS=M,DIPP=DPP
GO ;
 K DCL,DIASKHD,DIPT,DIPZ,DIL,DIL0,R,DOP,DHD,DD,DE,DG,DI,DIC,DK,DL,DN,DM,DU,DV,DW,DP,DY,POP,D,O,X,Y,V,DICS,TO,%X,%Y,DQ,%
 S DCC=U_$P(DJ,U,3),@("DD=$P("_DCC_"0),U,2)"),DP=+DD
 I '$D(DIBTPGM),+$G(DIBT1),$G(^DIBT(DIBT1,"ROU"))]"",DPQ S DIBTPGM=^("ROU") D
 . N DRN,DIERR D NXTNO^DIOZ(.DRN) I $G(DIERR) D QSV^DIOZ Q
 . S DIBTPGM=DIBTPGM_$E("000",1,(4-$L(DRN)))_DRN
 . Q
 K:$G(DIBTPGM)="" DIBTPGM
 I '$D(DSC),'$G(DIO("SCR"))=1,DD["s",$D(^DD(DP,0,"SCR")) D SCR
 S DD=$P(DJ,U,4),DL="D0",DN=DL,DI=$S('$D(BY(0)):U,$E(BY(0))=U:U,1:"")_$P(DJ,U,2),A=1
 I $G(ZTSTOP)=1!($G(DIFMSTOP)) G IXK
 I $D(DIBTPGM) D
 .S (DICNT,DICP,DICDX,DICOV)=1 K DISAVX,DISETP,DISETQ,^TMP("DIBTC",$J)
 .I '$D(DSC),'$G(DIO("SCR")),$D(DIS)>9 D SVSCR
DIOO1 F Z=1:1:DD-1 S @DL="",DL="DIOO"_Z,DN=DL_","_DN N @DL
 S @DL=$S($D(DPP(DJK,"F"))&$D(DPP(DJK,"IX")):$P(DPP(DJK,"F"),U),DD>1:"",1:0),Z=0 D ^DIO0
 I DPQ G ^DIOS
IX I $D(DPP(DJK,"IX")),$O(^UTILITY($J,99,99))>99,DPP(DJK)-DP,'$D(DSC),DD>1 S X="I $D("_$P(DPP(DJK,"IX"),U,1,2)_DN F %=1:1 S X=X_",D"_% I %+1=DD S DSC(+DPP(DJK))=X_"))" Q
 I $D(CP) S C="",CP=0 F X=0:0 S C=$O(CP(C)),A="" Q:C=""  K CP(C) S CP(C,C)=0 F Y=0:0 S A=$O(CP(A)) Q:A=C  S CP(C,A)=0
 I $D(DIWL),DIWL=1 S ^(1)="S DIWF=""W"" "_^UTILITY($J,99,1)
IXK K DPP,DPQ,DJ,M,DISMIN,DISH
 I $G(ZTSTOP)=1!($G(DIFMSTOP)) I $G(DIBTPGM)]"" D
 .N % S %=+$P(DIBTPGM,"^DISZ",2) D:% ENRLS^DIOZ(%) K DIBTPGM Q
 D 2 S:'$D(Y) Y=1 G ^DIO4
 ;
2 ;
 I $D(DIBTPGM) D
 .I '$D(DPQ),$D(DX(0)) N %,X S %="D O^DIO2",(%(1),%(2))="DX",X=0 D SETU^DIOS
 .D ENC^DIOZ K ^UTILITY($J,0) Q
 K DLN,DL,F,I,J,V,W,X,Y,Z,DE,DRJ,DICP,DICDX,DICOV,DICNT,DISAVX,DISETP,DISETQ,^TMP("DIBTC",$J) D:'$D(DISYS) OS^DII
 I $G(ZTSTOP)=1!($G(DIFMSTOP))!($G(DIERR)) S (DJ,DIO)=0 Q
 S X=1 X ^DD("FUNC",18,1)
 I $D(DIOBEG) X DIOBEG K DIOBEG
 S I(0)=DCC,J(0)=DP,DI=99,(DN,X)=1,(DJ,DE,DIO,IOX,IOY)=0
 G ^DIO2
 ;
SCR S DD="S Y=D0 I $D("_DCC_"Y,0)) "_^("SCR") I '$D(DIS(0)) S:'$D(DIS) DIS=1 S DIS(0)=DD Q
 S DIS("SCR")=DD,DIS(0)=$S($D(DIBTPGM):"D DISCR",1:"X DIS(""SCR"")")_" I  "_DIS(0)
 Q
SVSCR ;SAVE DIS ARRAY INTO ^TMP FOR LATER COMPILATION
 N %,I,J,K S %=.0000001
 I $D(DIS)'=11 S ^TMP("DIBTC",$J,%,DICNT)="SEARCH S DIO=1",DICNT=DICNT+1
 S ^TMP("DIBTC",$J,%,DICNT)="SCR S DIO(""SCR"")=1",DICNT=DICNT+1
 S I="" I $D(DIS(0)) S ^(DICNT)=" "_DIS(0),I=" Q:'$T ",DICNT=DICNT+1
 S:$O(DIS(0)) I=I_" D S1 Q:'$T " I I]"" S ^(DICNT)=I,DICNT=DICNT+1
 S ^(DICNT)="PASS S:'$D(DPQ) DIPASS=1",^(DICNT+1)=" G O",DICNT=DICNT+2
 I $O(DIS(0)) S K=0 D
 .F J=1:1 Q:'$D(DIS(J))  S:K ^TMP("DIBTC",$J,%,DICNT)=" Q:$T",DICNT=DICNT+1 S ^(DICNT)=$P("S1 ^ ",U,K+1)_DIS(J),DICNT=DICNT+1,K=1
 .S ^(DICNT)=" Q",DICNT=DICNT+1 Q
 I $G(DIS("SCR"))]"" S ^TMP("DIBTC",$J,%,DICNT)="DISCR "_DIS("SCR"),^(DICNT+1)=" Q",DICNT=DICNT+2
 Q
