DIQGDDT ;SFISC/DCL-DATA DICTIONARY ATTRIBUTE TEXT ;8/15/96  13:29
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
LIST(TYPE,DIDARRAY,TP,EQL) ;DO CALL
 ;TYPE="FILETXT" OR "FIELDTXT"
 ;DIDARRAY=TARGET ARRAY - IS LOCAL ARRAY PASSED BY REFERENCE WHICH WILL BE SEEDED WITH FILE OR FIELD ATTRIBUTES
 ;TP=TEXT PIECE USING ; AS DELIMITER
 ;EQL=EQUAL TO - NULL IS DEFAUL OR PIECE OF TXT
ENLST S:$G(TP)'>0 TP=4 S:$G(EQL)'>0 EQL=99
 N DIQGI,DIQGX,DIQGY F DIQGI=1:1 S DIQGX=$T(@TYPE+DIQGI),DIQGY=$P(DIQGX,";",TP) Q:DIQGY=""  D
 .S DIDARRAY(DIQGY)=$P(DIQGX,";",EQL)
 .S:$P(DIQGX,";",5)]"" DIDARRAY(DIQGY,"#(word-processing)")=$S($G(DIQGDFLG)["L":"",1:$P(DIQGX,";",5))
 .I $P(DIQGX,";",6)]"" D
 ..N TYPE
 ..S TYPE=$P(DIQGX,";",7)
 ..N DIQGI,DIQGX,DIQGYS
 ..F DIQGI=1:1 S DIQGX=$T(@TYPE+DIQGI) Q:$P(DIQGX,";",4)=""  D
 ...S DIQGYS=$P(DIQGX,";",4),DIDARRAY(DIQGY,"#",DIQGYS)=""
 ...Q
 .Q
 ;DIQGI,DIQGY ARE SCRATCH VARIABLES USED TO BUILD ARRAY
 ;DIQGI INDEXES TEXT AND DIQGY CONTAINS THE ATTRIBUTE NAME
 Q
DD N %,%ZISOS,A,D0,D1,D2,DA,DIC,DIW,DIWF,DIWL,DIWR,DIWT,DK,DL,DN,DX,I,POP,S,X,Y,DIQGF,DIQGFN
 S DIC=1,DIC(0)="AEMQ" D ^DIC Q:Y'>0  ;Select file
 S DIC="^DD("_+Y_",",DIQGFN=+Y
 D F(DIQGFN,.DIQGF)
 D ^%ZIS Q:POP  U IO
 S DIC="^DIC(",DA=DIQGFN
 D EN^DIQ
 S X=""
 F  S X=$O(^DIC(DIQGFN,0,X)) Q:X=""  W !,X,"=",^(X)
 S DIQGF="" F  S DIQGF=$O(DIQGF(DIQGFN,DIQGF)) Q:DIQGF=""  D
 .W !,$$L("=",IOM),!,"DD NUMBER: ",DIQGF,!
 .S DA="" F  S DA=$O(DIQGF(DIQGFN,DIQGF,DA)) Q:DA=""  D
 ..W !,$$L("-",IOM),!
 ..S DIC="^DD("_DIQGF_"," D EN^DIQ
 ..Q
 .Q
 W !!,"End of Report",!!
 D ^%ZISC
 Q
 ;
L(X,RM) Q $TR($J("",RM)," ",X)
 ;
F(DIQGDICN,DIQGFSTA,DIQGSEL,DIQGDEL) ;
 ;  DIQGDICN file number
 ;  DIQGFSTA Field Selected Target Array(can be passed by reference or
 ;                                       as a reference)
 ;  DIQGSEL Selection Marker(optional)
 ;  DIQGDEL Deselection Marker (optional)
 N %,%Y,DA,DDC,DIC,DIQGDWN,DIQGTGA,X,Y
 I $D(@("^DIC("_DIQGDICN_",0)")) W !!?4,"'",$P(^(0),"^"),"' FILE",!
 S:'$D(DIQGSEL) DIQGSEL="+" S:'$D(DIQGDEL) DIQGDEL="-"
 S DIC="^DD("_DIQGDICN_",",DIC(0)="AEMQ",X=$E($G(DIQGFSTA)),DIQGTGA=(X="^"!(X=".")) S:X="." DIQGFSTA=$E(DIQGFSTA,2,99)
M S DIC("W")="W:$P(^(0),U,2) $S($P(^DD(+$P(^(0),U,2),.01,0),U,2)[""W"":""  (word-processing)"",1:""  (multiple)"") W:$D("_$S(DIQGTGA:"@DIQGFSTA@(DIQGDICN,+$E(DIC,5,99),+Y)",1:"DIQGFSTA(DIQGDICN,+$E(DIC,5,99),+Y)")_") DIQGSEL"
 D ^DIC I Y'>0,$D(@(DIC_"0,""UP"")")) S DIC="^DD("_+^("UP")_"," G M ;Select field/back out of multiples
 S DIQGDWN="" I Y>0,$P(@(DIC_+Y_",0)"),U,2) S DIQGDWN=+$P(^(0),U,2) I $P(^DD(+$P(^(0),U,2),.01,0),U,2)'["W" D T(DIQGDWN) S DIC="^DD("_DIQGDWN_"," G M
 I Y>0,DIQGDWN>0 D T(DIQGDWN) G M
 I Y>0 D T() G M
 Q
T(DWN) ;
 D @$S(DIQGTGA:"TAR(+$E(DIC,5,99),+Y,$G(DWN))",1:"TBR(+$E(DIC,5,99),+Y,$G(DWN))")
 Q
TAR(DDFN,FLD,DWNFN) ;Target array is in DIQGFSTA As a global/local Reference
 I DWNFN S @DIQGFSTA@(DIQGDICN,DWNFN)=DDFN_"^"_FLD
 I '$D(@DIQGFSTA@(DIQGDICN,DDFN,FLD)) S @DIQGFSTA@(DIQGDICN,DDFN,FLD)=$S(DWNFN:DWNFN,1:"") Q
 I DWNFN,$D(@DIQGFSTA@(DIQGDICN,DWNFN))>9 Q
 N X S X=$G(@DIQGFSTA@(DIQGDICN,DDFN,FLD)) I X K @DIQGFSTA@(DIQGDICN,$P(X,"^"))
 K @DIQGFSTA@(DIQGDICN,DDFN,FLD) W DIQGDEL Q
 Q
TBR(DDFN,FLD,DWNFN) ;Target array DIQGFSTA is a local array passed By Reference
 I DWNFN S DIQGFSTA(DIQGDICN,DWNFN)=DDFN_"^"_FLD
 I '$D(DIQGFSTA(DIQGDICN,DDFN,FLD)) S DIQGFSTA(DIQGDICN,DDFN,FLD)=$S(DWNFN:DWNFN,1:"") Q
 I DWNFN,$D(DIQGFSTA(DIQGDICN,DWNFN))>9 Q
 N X S X=$G(DIQGFSTA(DIQGDICN,DDFN,FLD)) I X K DIQGFSTA(DIQGDICN,$P(X,"^"))
 K DIQGFSTA(DIQGDICN,DDFN,FLD) W DIQGDEL Q
 Q
 ;
 ;ATRBUTE FLD #;ATRBUTE NAME;1=WORD PROCESSING
FILETXT ;
 ;;.01;NAME;
 ;;1;GLOBAL NAME;
 ;;1.1;ENTRIES;
 ;;4;DESCRIPTION;1
 ;;20;DEVELOPER;
 ;;21;DATE;
 ;;31;DD ACCESS;
 ;;32;RD ACCESS;
 ;;33;WR ACCESS;
 ;;34;DEL ACCESS;
 ;;35;LAYGO ACCESS;
 ;;36;AUDIT ACCESS;
 ;;50;LOOKUP PROGRAM;
 ;;51;VERSION;
 ;;51.1;DISTRIBUTION PACKAGE;
 ;;51.2;PACKAGE REVISION DATA;
 ;;54;ARCHIVE FILE;
 ;;100.6;REQUIRED IDENTIFIERS;;1;RI
 ;;
FIELDTXT ;
 ;;.01;LABEL;
 ;;.1;TITLE;
 ;;.2;SPECIFIER;
 ;;.24;DECIMAL DEFAULT;
 ;;.25;TYPE;
 ;;.26;COMPUTE ALGORITHM;
 ;;.28;MULTIPLE-VALUED;
 ;;.3;POINTER;
 ;;.4;GLOBAL SUBSCRIPT LOCATION;
 ;;.5;INPUT TRANSFORM;
 ;;1.1;AUDIT;
 ;;1.2;AUDIT CONDITION;
 ;;2;OUTPUT TRANSFORM;
 ;;3;HELP-PROMPT;
 ;;4;XECUTABLE HELP;
 ;;8;READ ACCESS;
 ;;8.5;DELETE ACCESS;
 ;;9;WRITE ACCESS;
 ;;9.01;COMPUTED FIELDS USED;
 ;;10;SOURCE;
 ;;21;DESCRIPTION;1
 ;;23;TECHNICAL DESCRIPTION;1
 ;;50;DATE FIELD LAST EDITED;
 ;;200;FIELD LENGTH;
 ;
RI ;REQUIRED IDENTIFIERS
 ;;1;FIELD;
 ;;