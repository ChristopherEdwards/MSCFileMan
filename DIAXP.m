DIAXP ;SFISC/DCM-EXCEPTION REPORT ;5/16/96  10:56
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
EN ;
 N PAGE,LINE,DIAXX,FILE,FNAME,Y,DATE,DIRUT,Z
 S PAGE=0,LINE="",DIAXX=^DIAR(1.11,DIARC,0),FILE=$P(DIAXX,U,2),FNAME=$P($G(^DIC(FILE,0)),U)
 S Y=DT X ^DD("DD") S DATE=Y
 D HDR,BODY,END
 Q
 ;
C I IOST["C-" N DIR S DIR(0)="E" D ^DIR Q:$D(DIRUT)
 ;
HDR W:$Y @IOF W !,"EXTRACT ACTIVITY EXCEPTION REPORT",?IOM-24,DATE,?IOM-10,"PAGE: ",PAGE+1
 S PAGE=PAGE+1,$P(LINE,"-",IOM)="" W !,LINE
 Q
 ;
BODY W !!,"EXTRACT ACTIVITY: ",DIARC,?31,"ARCHIVER: ",$P($G(^VA(200,$P(DIAXX,U,6),0)),U)
 W !!,"THE FOLLOWING RECORDS IN THE '"_FNAME_"' FILE WERE NOT PROCESSED BY THE",!,"EXTRACT TOOL"
 N REC,LINE,ERR S REC=0 D REC Q:$D(DIRUT)
 W !!,"*** PLEASE KEEP THIS FOR FUTURE REFERENCE ***"
 Q
REC S LINE="Entry # "
 S REC=$O(^TMP("DIAXU",$J,"RESULT","ERR",FILE,REC)) Q:'REC  S ERR=^(REC)
 S LINE=LINE_+REC_" was NOT processed because:"
 D C:($Y+3>IOSL) Q:$D(DIRUT)
 W !!,LINE N A,B S A=1 D ERR
 G REC
ERR S B=$P(ERR,";",A) Q:B=""  S A=A+1
 N Z S Z=0
 F  S Z=$O(^TMP("DIERR",$J,+B,"TEXT",Z)) Q:'Z  D C:($Y+1>IOSL) Q:$D(DIRUT)  W !?2,$G(^(Z))
 G ERR
 ;
END I $E(IOST)'="C",$Y W @IOF
 D ^%ZISC
 K ^TMP("DIAXU",$J),^TMP("DIERR",$J)
 Q