DIP4 ;SFISC/XAK-QUEUE & DEQUEUE ;19AUG2003
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**34,999,1003**
 ;
 S:$D(DQTIME)[0&$D(ZTQUEUED) DQTIME="NOW"
 S:$G(DDXP)=4&$D(IO("Q")) DDXPQ=1 K IO("Q") S %DT="TEX",X="" I $D(DQTIME)#2 S X=DQTIME,%DT="XT"
W I '$D(DQTIME) S %DT("A")=$$EZBLD^DIALOG(8160)_": ",%DT("B")="NOW" ;**CCO/NI 'REQUESTED TIME TO PRINT:'
 S:$D(DQTIME) X=DQTIME
 S %DT="FRX" S:'$D(DQTIME) %DT=%DT_"AE" S %DT(0)="NOW" D ^%DT K %DT G:Y<1 X^DIP3:$D(DQTIME),X^DIP3:X[U,X^DIP3:$D(DTOUT),W S X=+Y D H^%DTC S Y=%H_","_%T
 W:'$D(ZTQUEUED) ! S ZTDTH=Y X ^%ZOSF("UCI") S ZTUCI=Y,ZTRTN="ZTSK^DIP4",ZTDESC=DHD
 S ZTSAVE("^UTILITY(""DIP2"",$J,")=""
 I $P($G(DPP(0,"IX")),U,2)["$J" S ZTSAVE("^"_$P(DPP(0,"IX"),U,2))=""
 I $G(DPP(1,"IX"))["^UTILITY(" S ZTSAVE("^UTILITY(U,$J,")=""
 S ZTIO=$S($D(ION)#2:ION,1:IO) I $G(IOST)]"" S ZTIO=ZTIO_";"_IOST
 I $G(IO("DOC"))]"" S ZTIO=ZTIO_";"_IO("DOC") G ZTM
 I $G(IOM) S ZTIO=ZTIO_";"_IOM I $G(IOSL) S ZTIO=ZTIO_";"_IOSL
ZTM S ZTSAVE("*")="" D ^%ZTLOAD
 K ^UTILITY("DIP2",$J),^UTILITY(U,$J),DIS,DXS,DX,DHD,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTUCI,FLDS,DCC,DIPT,X
 W:'$D(ZTQUEUED) $$EZBLD^DIALOG(8161,$G(ZTSK)),! X $G(^%ZIS("C")) G Q^DIP ;**CCO/NI 'REQUEST QUEUED'
 ;
ZTSK ;
 K DISYS D CLEAN^DIEFU
 I $G(DPP(1))]"",'$D(DPP(1,"GET")) Q:$G(DK)=""  D
 . S DIPCRIT=+$G(DIPCRIT),DISUPNO=$S($D(DISUPNO)#2:DISUPNO,1:1)
 . N S,Q S DIFM=+$G(L),S=+$P($G(@(DK_"0)")),U,2),Q="""" N DIBTRPT,DICNVDPP,DITYP,DJ,DU,DV
 . S DICNVDPP=1 D CNVCM^DIP11,T1^DIP11
 . Q
 D 0^DICRW G DQ^DITC1:$D(DIT),^DIP5