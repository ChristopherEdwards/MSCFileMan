DIFGA1 ;SFISC/XAK,DCM-FILEGRAM TEMPLATES ;2/27/99  12:35
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
Q W:$D(DTOUT) $C(7)
 K Y,C,L,DM,DQI,DA,DICOMP,DICOMPX,I,J,S,DIL,DK
 K D,DIFG,DC,DICS,DP,DU,DXS,DL,DJ,DINS,DIFGLINK
 K DIAXLOC,DIAXMSG,DIAXGL,DIAXF,^UTILITY("DIFG",$J),DJ1,DIAXEF,DIAXDL,DIAXDI,DIAXFILE,DIAXFNO
 K DIAXDICA,DIAXNP,DIAXZ,DIAXDK,DTOUT,DUOUT,DIRUT
 D:$D(DIAX) Q1^DIAXMS
 Q
 ;
INIT K ^UTILITY("DIFG",$J)
 S (L,DL)=1,(I(0),DI)=DIC,(DK,J(0))=+$P(@(DI_"0)"),U,2)
 S DINS="",(DC,DJ,C,C(0),DIL)=0 Q:'$D(DIAX)
 ;
INET K DIC
 S DIC=1,DIC(0)="AEQZ",DIC("S")="I Y'<2,+Y'="_DK_" S DIFILE=+Y,DIAC=""RD"" D ^DIAC I %",DIC("A")="DESTINATION FILE: " D ^DIC Q:Y'>0
 S (DIAXF,DIAXFILE,DIAXFNO,DIAXDL(DL),DIAXDK(DK))=+Y,DIAXGL=$E(^DIC(+Y,0,"GL"),2,99),DIAXEF=Y(0,0),DIAXLOC(DIAXFILE)=""
 Q
