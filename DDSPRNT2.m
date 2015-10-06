DDSPRNT2 ;SFISC/MKO-PRINT A FORM ;29JAN2004
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1004**
 ;
BLOCK ;Print Block properties from Block file
 D WP^DDSPRNT($NA(^DIST(.404,DDSBK,15)),DDSCOL2+1,"AB") Q:$D(DIRUT)
 ;
 D WR("DATA DICTIONARY NUMBER:",$P(DDSBK(0),U,2),1) Q:$D(DIRUT)
 S X=$P(DDSBK(0),U,3)
 I X]"" D WR("DISABLE NAVIGATION:",$$EXTERNAL^DILFD(.404,2,"",$P(DDSBK(0),U,3))) Q:$D(DIRUT)
 ;
 D WR("PRE ACTION:",$G(^DIST(.404,DDSBK,11))) Q:$D(DIRUT)
 D WR("POST ACTION:",$G(^DIST(.404,DDSBK,12))) Q:$D(DIRUT)
 K DDSBK(0)
 ;
 ;Loop through all fields
 I $X D W() Q:$D(DIRUT)
 Q:'$O(^DIST(.404,DDSBK,40,0))
 ;
 D:$Y+7'<IOSL HEADER^DDSPRNT Q:$D(DIRUT)
 W !?DDSCOL2,"Field  Field"
 W !?DDSCOL2,"Order  Properties"
 W !?DDSCOL2,"-----  ----------"
 ;
 N DDSFD,DDSFDO
 S DDSFDO=""
 F  S DDSFDO=$O(^DIST(.404,DDSBK,40,"B",DDSFDO)) Q:DDSFDO=""!$D(DIRUT)  S DDSFD=0 F  S DDSFD=$O(^DIST(.404,DDSBK,40,"B",DDSFDO,DDSFD)) Q:'DDSFD!$D(DIRUT)  D FIELD
 ;
 Q
 ;
FIELD ;Print Block properties
 S DDSCOL1=15,DDSCOL2=22,DDSCOL3=45
 F X=0,2,4,20 S DDSFD(X)=$G(^DIST(.404,DDSBK,40,DDSFD,X))
 Q:DDSFD(0)=""
 ;
 D W(DDSFDO,DDSCOL1) Q:$D(DIRUT)
 W ?DDSCOL2,"FIELD TYPE:"
 W ?DDSCOL3,$$EXTERNAL^DILFD(.4044,2,"",$P(DDSFD(0),U,3))
 ;
 D WR("CAPTION:",$P(DDSFD(0),U,2)) Q:$D(DIRUT)
 D WR("EXECUTABLE CAPTION:",$G(^DIST(.404,DDSBK,40,DDSFD,.1))) Q:$D(DIRUT)
 D WR("DISPLAY GROUP:",$P(DDSFD(0),U,4)) Q:$D(DIRUT)
 ;
 D WR("UNIQUE NAME:",$P(DDSFD(0),U,5)) Q:$D(DIRUT)
 ;
 D WR("FIELD:",$P($G(^DIST(.404,DDSBK,40,DDSFD,1)),U)) Q:$D(DIRUT)
 D WR("COMPUTED EXPRESSION:",$G(^DIST(.404,DDSBK,40,DDSFD,30))) Q:$D(DIRUT)
 ;
 I DDSFD(20)'?."^" D  Q:$D(DIRUT)
 . D WR("READ TYPE:",$$EXTERNAL^DILFD(.4044,20.1,"",$P(DDSFD(20),U))) Q:$D(DIRUT)
 . D WR("PARAMETERS:",$P(DDSFD(20),U,2)) Q:$D(DIRUT)
 . D WR("QUALIFIERS:",$P(DDSFD(20),U,3)) Q:$D(DIRUT)
 . ;
 . S DDSWP=$NA(^DIST(.404,DDSBK,40,DDSFD,21))
 . I $P($G(@DDSWP@(0)),U,3) D
 .. D W("HELP:",DDSCOL2) Q:$D(DIRUT)
 .. D WP^DDSPRNT(DDSWP,DDSCOL2+3,"B")
 . K DDSWP Q:$D(DIRUT)
 . ;
 . D WR("INPUT TRANSFORM:",$G(^DIST(.404,DDSBK,40,DDSFD,22))) Q:$D(DIRUT)
 . D WR("SAVE CODE:",$G(^DIST(.404,DDSBK,40,DDSFD,23))) Q:$D(DIRUT)
 . D WR("SCREEN:",$G(^DIST(.404,DDSBK,40,DDSFD,24))) Q:$D(DIRUT)
 . K DDSFD(20)
 ;
 D WR("CAPTION COORDINATE:",$P(DDSFD(2),U,3)) Q:$D(DIRUT)
 D WR("DATA COORDINATE:",$P(DDSFD(2),U)) Q:$D(DIRUT)
 D WR("DATA LENGTH:",$P(DDSFD(2),U,2)) Q:$D(DIRUT)
 D WR("SUPPRESS COLON:",$S($P(DDSFD(2),U,4):"YES",1:"")) Q:$D(DIRUT)
 ;
 D WR("DEFAULT:",$P($G(^DIST(.404,DDSBK,40,DDSFD,3)),U)) Q:$D(DIRUT)
 D WR("EXECUTABLE DEFAULT:",$G(^DIST(.404,DDSBK,40,DDSFD,3.1))) Q:$D(DIRUT)
 ;
 I DDSFD(4)'?."^" D
 . D WR("REQUIRED:",$S($P(DDSFD(4),U):"YES",$P(DDSFD(4),U)=0:"NO",1:"")) Q:$D(DIRUT)
 . D WR("DISABLE EDITING:",$S($P(DDSFD(4),U,4)=2:"REACHABLE",$P(DDSFD(4),U,4):"YES",1:"")) Q:$D(DIRUT)
 . D WR("RIGHT JUSTIFY:",$S($P(DDSFD(4),U,3):"YES",1:"")) Q:$D(DIRUT)
 . D WR("DISALLOW LAYGO:",$S($P(DDSFD(4),U,5):"YES",1:"")) Q:$D(DIRUT)
 K DDSFD(4)
 ;
 D WR("SUB PAGE LINK:",$P($G(^DIST(.404,DDSBK,40,DDSFD,7)),U,2)) Q:$D(DIRUT)
 ;
 D WR("BRANCHING LOGIC:",$G(^DIST(.404,DDSBK,40,DDSFD,10))) Q:$D(DIRUT)
 D WR("PRE ACTION:",$G(^DIST(.404,DDSBK,40,DDSFD,11))) Q:$D(DIRUT)
 D WR("POST ACTION:",$G(^DIST(.404,DDSBK,40,DDSFD,12))) Q:$D(DIRUT)
 D WR("POST ACTION ON CHANGE:",$G(^DIST(.404,DDSBK,40,DDSFD,13))) Q:$D(DIRUT)
 D WR("DATA VALIDATION:",$G(^DIST(.404,DDSBK,40,DDSFD,14))) Q:$D(DIRUT)
 ;
 D W() Q:$D(DIRUT)
 Q
 ;
WR(DDSLAB,DDSVAL,DDSFLG) ;Write label and value
 I DDSVAL="",'$G(DDSFLG) Q
 ;
 D W() Q:$D(DIRUT)
 W ?DDSCOL2,DDSLAB
 ;
 I $X>DDSCOL3 N DDSCOL3 S DDSCOL3=$X+1
 D PCOL(DDSVAL,DDSCOL3)
 Q
 ;
PCOL(DDSVAL,DDSCOL) ;Print DDSVAL starting in column DDSCOL
 N DDSWIDTH,DDSIND
 S DDSWIDTH=IOM-DDSCOL-1
 F DDSIND=1:DDSWIDTH:$L(DDSVAL) D  Q:$D(DIRUT)
 . I DDSIND>1 D W() Q:$D(DIRUT)
 . W ?DDSCOL,$E(DDSVAL,DDSIND,DDSIND+DDSWIDTH-1)
 Q
 ;
W(DDSSTR,DDSCOL) ;Write DDSSTR preceded by !?DDSCOL
 I $Y+3'<IOSL D HEADER^DDSPRNT Q:$D(DIRUT)
 W !?+$G(DDSCOL),$G(DDSSTR)
 Q
