DINIT41 ;SFISC/GFT-INITIALIZE VA FILEMAN ;4/14/93  1:15 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
DD F I=1:1 S X=$E($T(DD+I),4,999) G ^DINIT42:X?.P S ^DD("FUNC",I+30,0)=$P(X,";",1),Y=1 F DU=1,2,3,9,10 S Y=Y+1 I $P(X,";",Y)]"" S ^(DU)=$P(X,";",Y)
 ;;BLANK;X "F I=1:1:X "_$S($D(^UTILITY($J,"W")):"S X="" |TAB|"" D L^DIWP",1:"W !") S X="";;;SKIP (ARG) NUMBER OF LINES;W
 ;;MONTHNAME;S X=$P("JANUARY^FEBRUARY^MARCH^APRIL^MAY^JUNE^JULY^AUGUST^SEPTEMBER^OCTOBER^NOVEMBER^DECEMBER","^",+X);;;TURNS "1" INTO "JANUARY", "2" INTO "FEBRUARY", ETC.
 ;;SETPAGE;S DC=X,X="";;;PAGE NUMBER ON NEXT PAGE WILL BE (ARG)+1;W
 ;;INDENT;S:'$D(DIWF) DIWF="" S %Y=1,%=$F(DIWF,"I") X:% "F %Y=%:1 Q:$E(DIWF,%Y)'?1N" S DIWF=$E(DIWF,1,%-2)_$E(DIWF,%Y,999)_"I"_(X\1),X="";;;INDENT FOLLOWING TEXT (ARG) SPACES;W
 ;;SITENUMBER;S X=^DD("SITE",1);;0;NUMBER IDENTIFYING YOUR SITE (FROM INITIALIZATION)
 ;;WIDTH;S:'$D(DIWF) DIWF="" S %Y=1,%=$F(DIWF,"C") X:% "F %Y=%:1 Q:$E(DIWF,%Y)'?1N" S DIWF=$E(DIWF,1,%-2)_$E(DIWF,%Y,999)_"C"_(X\1),X="";;;DISPLAY FOLLOWING TEXT (ARG) COLUMNS ACROSS;W
 ;;PAGESTART;S:'$D(DIWF) DIWF="" S %Y=1,%=$F(DIWF,"T") X:% "F %Y=%:1 Q:$E(DIWF,%Y)'?1N" S DIWF=$E(DIWF,1,%-2)_$E(DIWF,%Y,999)_"T"_(X\1),X="";;;START NEW OUTPUT TEXT ON LINE (ARG) OF PAGE;W
 ;;NOWRAP;S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="";;0;DISPLAY LINE-FOR-LINE AS INPUT;W
 ;;WRAP;S DIWF=$P(DIWF,"N",1)_$P(DIWF,"N",2),X="";;0;RETURN TO 'WRAP-AROUND' OUTPUT;W
 ;;MINUTES;S Y=$E(X1_"000",9,10)-$E(X_"000",9,10)*60+$E(X1_"00000",11,12)-$E(X_"00000",11,12),X2=X,X=$P(X,".",1)'=$P(X1,".",1) D ^%DTC:X S X=X*1440+Y;;2;DIFFERENCE BETWEEN 2 DATE/TIMES IN MINUTES
 ;;MODULO;S X=X1#X;;2;FIRST ARGUMENT MOD SECOND ARGUMENT (MUMPS '#' OPERATOR)
 ;;SET;S:X]""&(X'[U)&(X'["$C(94)") @X=X1,X=X1;;2;TAKES THE VALUE OF 1ST ARGUMENT, BUT ALSO PUTS IT INTO THE VARIABLE NAMED BY THE 2ND ARGUMENT
 ;;BETWEEN;S:X<X1 %=X1,X1=X,X=% S X=X2'>X&(X2'<X1);;3;EQUALS '1' IF 1ST ARGUMENT LIES BETWEEN 2ND AND 3RD, '0' OTHERWISE
 ;;TOP;S DIFF=1 X:$D(^UTILITY($J,1)) ^(1) S X="";;0;TOP-OF-FORM;W
 ;;NOBLANKLINE;S X="",DIWF=$S($D(DIWF):DIWF_" ",1:" ");;0;SUPPRESSES PRINTING OF A SINGLE ALL-BLANK LINE;W
 ;;RANGEDATE;S %Y=X3,Y=X2,X2=X S:X>X1 X2=X1,X1=X S:Y>%Y %Y=Y,Y=X3 S:Y>X2 X2=Y S:%Y<X1 X1=%Y D ^%DTC S X=$S(%Y=0:0,X<0:0,1:X+1) K %Y,X3;;4;TAKES 2 DATE RANGES, RETURNS THE NUMBER OF DAYS BY WHICH THEY OVERLAP, OR 0 IF OVERLAP IS INDEFINITE
 ;;SETPARAM;S:X]""&(X?.ANP)&(X1'[U)&(X1'["$C(94)") DIPA($E(X,1,30))=X1 S X="";;2;RETURNS NOTHING, BUT SETS PARAMETER NAMED BY 2ND ARGUMENT TO 1ST ARGUMENT
