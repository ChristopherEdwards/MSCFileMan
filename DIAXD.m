DIAXD ;SFISC/DCM-GET SOURCE DATA ;9/6/96  15:17
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
EN ;
 N DILL,FRFILE,TOFILE,DIAXIEN,DIAXI,DIAXFR,DIAXTO,DATAFR,DATALST,Z
 S (DILL,DIAXI)=$G(DILL)+1,FRFILE=@DIAXTFR@(DILL,"FR"),TOFILE=@DIAXTFR@(FRFILE,"TO"),Z=","
 S DIAXFR="^TMP($J,""DIAXFR"")",DIAXTO="^TMP($J,""DIAXTO"")",DATAFR="^TMP($J,""DATAFR"")",DATALST="^TMP($J,""DATALST"")"
 D Q,TOP I $G(DIERR) D Q Q
 D NEXTLVL
Q K @DIAXFR,@DIAXTO,@DATAFR
 K:$G(DIERR) ^TMP("DIAX",$J)
 Q
TOP ;
 N FRIENS,TOIENS
 S (FRIENS,@DIAXFR@(FRFILE,"IENS"))=DIAXFE_Z
 S (TOIENS,@DIAXTO@(TOFILE,"IENS"),@DIAXTO@(FRFILE,"IENS",FRIENS))=$$DIAXIEN()
 D GETFDA(FRIENS,TOIENS)
 Q
GETFDA(FRIENS,TOIENS) ;
 D GETS Q:$G(DIERR)
 D FDA
 Q
GETS ;
 N DR,FLAGS,FIELDS
 F  S DR=$G(DR)+1 Q:'$G(@DIAXTFR@(FRFILE,"DR",DR))  D  Q:$G(DIERR)
 . S FLAGS="EIN"
 . S FIELDS=@DIAXTFR@(FRFILE,"DR",DR)
 . D GETS^DIQ(FRFILE,FRIENS,FIELDS,FLAGS,DATAFR,DIAXERR) D:$G(DIERR) ERR
 Q
FDA ;
 N A,B,C S A=0
 F  S A=$O(@DATAFR@(FRFILE,FRIENS,A)) Q:A'>0  F C=0,1 S B=$G(@DIAXTTO@(FRFILE,A,C)) D:B]""  Q:$G(DIERR)
 . I $O(@DATAFR@(FRFILE,FRIENS,A,0)) S ^TMP("DIAX",$J,TOFILE,TOIENS,+$P(B,U,2))=U_$P($$GET1^DIQ(FRFILE,FRIENS,A,"B"),U,2) Q
 . S ^TMP("DIAX",$J,TOFILE,TOIENS,+$P(B,U,2))=$S(+$P(B,U,3):@DATAFR@(FRFILE,FRIENS,A,"E"),1:@DATAFR@(FRFILE,FRIENS,A,"I"))
 I '$D(^TMP("DIAX",$J,TOFILE,TOIENS,.01)) S ^TMP("DIAX",$J,TOFILE,TOIENS,.01)=$$GET1^DIQ(FRFILE,FRIENS,.01,"I","",DIAXERR) D:$G(DIERR) ERR
 K @DATAFR
 Q
GETLIST ;
 N SCR,A,B S SCR=$G(DIAXSCR(FRFILE))
 S FRIENS=$G(FRIENS),PART=$G(PART),INDEX=$G(INDEX) K @DATALST
 D LIST^DIC(FRFILE,FRIENS,"","","","",PART,INDEX,.SCR,"",DATALST,DIAXERR)
 I $G(DIERR) D ERR,Q1 Q
 I '$P(@DATALST@("DILIST",0),U) D Q1 Q
 I $G(PART)]"" S FRIENS=Z_@DIAXFR@(PARENT,"IENS")
 S A=0 F  S A=$O(@DATALST@("DILIST",2,A)) Q:A'>0  S B=@DATALST@("DILIST",2,A),@DIAXFR@(FRFILE,"IENS",$E(FRIENS,2,99),B_FRIENS)=""
Q1 K @DATALST,PART,INDEX
 Q
TOIENS ;
 N A,B S A=""
 F  S A=$O(@DIAXFR@(FRFILE,"IENS",FRIENS,A)) Q:A=""  S B=$$DIAXIEN(),@DIAXTO@(FRFILE,"IENS",A)=B_@DIAXTO@(PARENT,"IENS",FRIENS)
 Q
GETDATA ;
 Q:'$D(@DIAXTFR@(FRFILE,"DR"))
 N A,ZFRIENS S A="",ZFRIENS=FRIENS N FRIENS
 F  S A=$O(@DIAXFR@(FRFILE,"IENS",ZFRIENS,A)) Q:A=""  S FRIENS=A D  Q:$G(DIERR)
 . N TOIENS
 . S TOIENS=@DIAXTO@(FRFILE,"IENS",FRIENS)
 . D GETFDA(FRIENS,TOIENS) Q:$G(DIERR)
 . I $D(DIAXFILE(FRFILE)) D  Q
 . . N Y,DIERZ
 . . D RECURSE
 . . I $G(DIERZ) N DIERR,Y S Y("IEN")=DIAXFE D BLD^DIALOG(1300,"",.Y) D STE^DIAXU()
 Q
MULT(FRIENS) ;
 S FRIENS=Z_FRIENS
 D GETLIST Q:$G(DIERR)
 S FRIENS=$E(FRIENS,2,99)
 D TOIENS
 D GETDATA
 Q
ERR ;
 Q:'$D(FRFILE)!('$D(FRIENS))
 Q:'$D(DIAXFILE(FRFILE))
 D STE^DIAXU(FRFILE,FRIENS)
 Q
NEXTLVL ;
 F DIAXI=$G(DIAXI):0 S DIAXI=$O(@DIAXTFR@(DIAXI)) Q:'$D(@DIAXTFR@(+DIAXI,"FR"))  D NEXTLVL2 Q:$G(DIERR)!(DIAXI="")
 Q
NEXTLVL2 ;
 N FRFILE,TOFILE,PARENT,DILL,FRIENS,TOIENS,TAG
 S FRFILE=@DIAXTFR@(DIAXI,"FR"),TOFILE=@DIAXTFR@(FRFILE,"TO"),PARENT=^("PRT"),DILL=^("P2"),TAG=^("P4")
 D @TAG
 Q
3 ;
 I $D(DIAXFILE(FRFILE)) D FILE Q:$G(DIERR)
 I DILL=2 S FRIENS=@DIAXFR@(PARENT,"IENS") D MULT(FRIENS) Q
 N A,B S (A,B)="" F  S B=$O(@DIAXFR@(PARENT,"IENS",B)) Q:B=""  D
 . F  S A=$O(@DIAXFR@(PARENT,"IENS",B,A)) Q:A=""  D  Q:$D(DIAXFILE(PARENT))
 . . S FRIENS=A D MULT(FRIENS) Q:$G(DIERR)
 Q
2 ;
 N PTRFLD,FRIENS,PTRIEN,A,B
 S PTRFLD=$P(@DIAXTFR@(FRFILE,"P5"),":")
 I DILL=2 S FRIENS=@DIAXFR@(PARENT,"IENS") D 21 Q
 S (A,B)="" F  S B=$O(@DIAXFR@(PARENT,"IENS",B)) Q:B=""  D  Q:$G(DIERR)!('PTRIEN)
 . F  S A=$O(@DIAXFR@(PARENT,"IENS",B,A)) Q:A=""  D  Q:$G(DIERR)!'(PTRIEN)!($D(DIAXFILE(PARENT)))
 . . S FRIENS=A D 21
 Q
21 N TOIENS
 S PTRIEN=$$GET1^DIQ(PARENT,FRIENS,PTRFLD,"I","",DIAXERR) D:$G(DIERR)  Q:$G(DIERR)!('PTRIEN)
 . N FRFILE
 . S FRFILE=PARENT
 . D ERR
 S FRIENS=PTRIEN_Z
 S TOIENS=@DIAXTO@(PARENT,"IENS",A)
 D GETFDA(FRIENS,TOIENS)
 Q
4 ;
 N PART,INDEX,FRIENS
 S PART=$$GET1^DIQ(PARENT,@DIAXFR@(PARENT,"IENS"),.01,"I","",DIAXERR) D:$G(DIERR)  Q:PART']""!$G(DIERR)
 . N FRFILE,FRIENS
 . S FRFILE=PARENT
 . S FRIENS=@DIAXFR@(PARENT,"IENS")
 . D ERR
 S INDEX=@DIAXTFR@(FRFILE,"P7")
 I $D(DIAXFILE(FRFILE)) D FILE Q:$G(DIERR)
 S FRIENS="" D GETLIST Q:$G(DIERR)
 S FRIENS=@DIAXFR@(PARENT,"IENS")
 D TOIENS,GETDATA
 Q
DIAXIEN() ;
 S DIAXIEN=$G(DIAXIEN)+1
 Q "+"_DIAXIEN_Z
FILE ;
 Q:'$D(^TMP("DIAX",$J))
 N IEN S IEN="^TMP($J,""IEN"")"
 D Q2,UPDATE^DIE("E","^TMP(""DIAX"",$J)",IEN,DIAXERR)
 I $G(DIERR) D  Q
 . K ^TMP("DIAX",$J)
 . D ERR
 N %,NODE,A,B,FI,VAL,DA S %=0,NODE=DIAXTO
 I $G(@IEN@(1)) S DIAXDA=^(1),FI=0,FI=$O(@NODE@(FI))
 E  S FI=FRFILE
 F  S %=$O(@IEN@(%)) Q:'%  S DA=@IEN@(%) D VAL
Q2 K @IEN Q
VAL S NODE=DIAXTO,NODE=$NA(@NODE@(FI)) F  S NODE=$Q(@NODE) Q:NODE'["DIAXTO"  Q:$QS(NODE,5)'[$G(FRIENS)  S VAL=@NODE I VAL[("+"_%_Z)  S VAL=$P(VAL,"+"_%_Z,1)_DA_Z_$P(VAL,"+"_%_Z,2) S @NODE=VAL D
 . S A=$QS(NODE,3),B=$QS(NODE,5)
 . Q:(A'=DIAXF)&('$D(DIAXFILE(A)))
 . Q:A=""!(B="")
 . I A=DIAXF S B=+B,VAL=+VAL
 . S @DIAXRSLT@("RESULT",A,B)=VAL
 Q
RECURSE ;
 N DIAXIZ,DILLZ,DIERR
 S DIAXIZ=DIAXI,DILLZ=DILL
 D NEXTLVL,FILE
 N NODE,SUB,FILE S FILE=FRFILE
 F  S FILE=$O(@DIAXFR@(FILE)) Q:'FILE  F NODE=$NA(@DIAXFR@(FILE)),$NA(@DIAXTO@(FILE)) F  S NODE=$Q(@NODE) Q:NODE'["IENS"  S SUB=$QS(NODE,5) I SUB[FRIENS K @NODE
 K @DIAXFR@(FRFILE,"IENS",ZFRIENS,FRIENS),@DIAXTO@(FRFILE,"IENS",FRIENS)
 S DIAXI=DIAXIZ,DILL=DILLZ,A=""
 I $G(DIERR) K DIAXDA S DIERZ=1
 Q
