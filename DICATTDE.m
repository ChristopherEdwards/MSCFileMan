DICATTDE ;GFT/GFT -- END screen edit;24MAY2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**42,83,103,999,1004,1027,1028,1032,1042,1043**
 ;
LAYGODEF ;should user see 'ADDING NEW'?
 N %
 I DICATTF=.01,$G(^DD(DICATTA,0,"UP")) S Y=^("UP"),%=$O(^DD(Y,"SB",DICATTA,0)) I %,$P($G(^DD(Y,%,0)),U,2)["A" S Y="NO" Q
 S Y="YES"
 Q
 ;
POST ;This is the DATA VALIDATION of the DICATT FORM
 N DICATT1N,DICATTM,DICATT4N,DICATT4S,DICATTED,X,T,G,DIC,DIE,DR,DA
 K DDSBR,DDSERROR
 I DICATT2 G MULEDIT^DICATTDD
VP I $$G(20)=8 D POSTVP^DICATTD8 I $D(DDSBR) S DDSERROR=1,DDSBR=DDSBR_"^DICATT8^2.8" Q
 S DICATT1N=$$G(1)
 I DICATT1N="" G ^DICATTDK:$D(DICATTDK) S DDSBR=1,DDSERROR=1 Q
 I DICATT1N=$$G(2) S DDSERROR=1,DDSBR=1 D HLP^DDSUTL("NAME AND TITLE MUST BE DIFFERENT") Q
 I $G(DICATTLN) D  I $D(DDSERROR) D HLP^DDSUTL("YOUR REDEFINITION OF THE FIELD WOULD CAUSE TOO MUCH DATA STORAGE!") Q
 .N W,DP,N,A,L,Y
 .S A=DICATTA,DP=DICATTF,W=$P(^DD(A,DP,0),U,4),Y=$P(W,";"),N=$P(W,";",2),T=0,L=DICATTLN Q:W=""
 .D MX^DICATT1
TOOMUCH .I $$MAX^DICATTDM(L-T,Y)>($G(^DD("STRING_LIMIT"),255)-4) S DDSERROR=1,DDSBR=20
NEW I DICATT4="",'$D(DICATT4N)  D  I $D(DDSERROR) D HLP^DDSUTL("DATA-STORAGE INFO INCOMPLETE") Q
 .I DICATTF=.001 S DICATT4N=" " Q
 .S G=$$G(20) I G=6 S DICATT4N=" ; " Q
 .I G=5!$$G(20.5) D  Q:$D(DDSERROR)  S DICATT4N=DICATTM(76)_";0" Q  ;Note that we can $$GET the defaulted values for storage, even if user has not seen Pages 3 or 4
 ..F T=76,76.1 S DICATTM(T)=$$GET^DDSVALF(T,"DICATTS",4,"","") I DICATTM(T)="" S DDSERROR=1,DDSBR="76^DICATTS^4" Q
 .S G=$$GET^DDSVALF(16,"DICATTM",3,"",""),T=$$GET^DDSVALF(17,"DICATTM",3,"","")
 .I G=""!(T="") S DDSERROR=1,DDSBR="16^DICATTM^3" Q
 .S DICATT4N=G_";"_T Q
 S X=^DD(DICATTA,DICATTF,0) D  I $D(DDSERROR) D HLP^DDSUTL("FIELD DEFINITION IS TOO LONG!") Q  ;Can't fit it into the zero node
 .S T=$L(DICATT1N)+$L($S($D(DICATT2N):DICATT2N,1:$P(X,U,2)))+$L($S($D(DICATT3N):DICATT3N,1:$P(X,U,3)))+$L($S($D(DICATT4N):DICATT4N,1:$P(X,U,4)))+$L($S($D(DICATT5N)#2:DICATT5N,1:$P(X,U,5,999)))
 .I T>($G(^DD("STRING_LIMIT"),255)-13) S DDSERROR=1
FILE ;Everything's good!   We're gonna file it
 I $D(DICATT4N) S $P(^DD(DICATTA,DICATTF,0),U,4)=DICATT4N I DICATT4N'?.P S DICATT4S=$P(DICATT4N,";"),^DD(DICATTA,"GL",DICATT4S,$P(DICATT4N,";",2),DICATTF)="" ;new Piece 4
 I $D(DICATTM),$D(DICATT4S) D  Q  ;make a MULTIPLE
 .N TYPE S TYPE=$$G(20)
 .D MULMAKE^DICATTDD(DICATTM(76.1),TYPE)
WP .I TYPE=5 N DICATTA,DICATTF S:'$D(DICATT2N) DICATT2N="W" ;so we'll bounce back up from W-P multiple
 .S DICATTA=DICATTM(76.1),DICATTF=.01,DICATTMN="" D CHANGED ;make the .01 Field of the new multiple
CHANGED S X=$E("R",$$G(18)) I DICATT2["R"'=$L(X)!$D(DICATTMN) D
 .S DICATTMN="" K ^DD(DICATTA,"RQ",DICATTF) I X["R" S ^(DICATTF)=""
 .I '$D(DICATT2N) S DICATT2N=$TR(DICATT2,"R") I DICATT2["W" S DICATT2N="W"
 .S DICATT2N=X_DICATT2N_$E("I",$G(DICATT2)["I")
 .S %=$P(DICATT2,"P",2) I % K ^DD(+%,0,"PT",DICATTA,DICATTF) ;remove old PT node
 .F %=DICATTA:0  S ^DD(%,0,"DT")=DT Q:'$D(^("UP"))  S %=^("UP") Q:'$D(^DD(%))
 .S %=$P(DICATT2N,"P",2) I % S ^DD(+%,0,"PT",DICATTA,DICATTF)=""
COMPUTED .I DICATT2N["C" D
 ..N DICOMPX,A,DA
 ..S A=+$P(DICATT2,"p",2) I A,$D(^DD(A,0)) K ^(0,"PTC",DICATTA,DICATTF)
 ..S A=+$P(DICATT2N,"p",2) I A,$D(^DD(A,0)) S ^(0,"PTC",DICATTA,DICATTF)=""
 ..S (DA(1),A)=DICATTA,DA=DICATTF,DICOMPX=$G(DICATT5N(9.01)) K ^DD(A,DA,9.02) D ACOMP^DICATT3
 .I DICATTF=.01 D
 ..I DICATTA=DICATTB D  Q
 ...I $D(^DIC(DICATTA,0,"GL")),$D(@(^("GL")_"0)")) D UP2("",DICATT2N)
 ..S Y=$$GET^DDSVALF(2,"DICATTMUL",5,"I","") I Y?1N S DICATT2N=$E("M",Y=1)_DICATT2N
 ..S DR=$$GET^DDSVALF(1,"DICATTMUL",5,"I","")
 ..I $G(^DD(DICATTA,0,"UP")) S Y=^("UP"),%=$O(^DD(Y,"SB",DICATTA,0)) I Y,%,$D(^DD(Y,%,0)) D UP2(DR,DICATT2N) ;Reset the MULTIPLE field at the higher level
 .S $P(^DD(DICATTA,DICATTF,0),U,2)=DICATT2N
PIECE3 .I $D(DICATT3N) S $P(^(0),U,3)=$G(DICATT3N)
 .I $D(DICATTVP) D FILE^DICATTD8
SCREEN S %=$$GET^DDSVALF(65,"DICATT SCREEN",6,"I",""),X=$P(^DD(DICATTA,DICATTF,0),U,2) I %=0!(%="NO")!(X'["P"&(X'["S")) K ^(12),^(12.1)
 F %=8:0 S %=$O(DICATT5N(%)) Q:'%  S ^DD(DICATTA,DICATTF,%)=DICATT5N(%)
 I $D(DICATT5N)#2 S $P(^(0),U,5,99)=DICATT5N
 S DR="50////^S X=DT" F X=1:1:8 D 0
 D DIE
EGP ;K ^DD(DICATTA,DICATTF,.009) ;**CCO/NI  WHEN FIELD CHANGES, KILL OFF ITS HELP TRANSLATIONS
 S DR="Q",X=98 D 0,DIE
 S DR="Q",X=99 D 0,DIE
 D FILEWORD^DICATTD0
MUMPS I $P(^DD(DICATTA,DICATTF,0),U,2)["K" S ^(9)="@" ;**151
AUDIT I $G(DICATT2)]"",$P(^(0),U,2)'=DICATT2,$G(^DD(DICATTB,0,"DIK"))]"" D EN2^DIKZ(DICATTB,"",^("DIK")) ;Recompile CROSS-REFS if auditing changes
RESET D GET^DICATTD ;now that we have filed, the NEW is OLD, in case they keep editing!
Q Q
 ;
UP2(A,X) N T,Y ;A=0 if NO LAYGO  X=SPECIFIER
 S Y=$P(^(0),U,2),Y=$TR(Y,"SDPV")
 F T="S","V","P","D" I X[T S Y=Y_T Q
 I A?1N S Y=$TR(Y,"A")_$E("A",DR=0)
 S $P(^(0),U,2)=Y
 Q
 ;
0 S T=$T(@X),G=$TR($$G(X),";") Q:G="@"!(G="^")  S:G="" G="@" S DR=DR_$P(T,";",2,3)_"////"_G Q  ;Re-file NAME, TITLE, etc.  Delete if they are now gone.  Leave "@" alone
1 ;;.01
2 ;;.1
3 ;;1.1
4 ;;1.2
5 ;;8
6 ;;8.5
7 ;;9
8 ;;10
98 ;;3
99 ;;4
 ;
DIE S DICATTED=1,DA=DICATTF,DA(1)=DICATTA,(DIC,DIE)="^DD(DICATTA,"
 D ^DIE
 Q
 ;
N ;
 S DA=DICATTF I $G(DDA(1))]"" S:$G(DICATTA) DDA(1)=DICATTA S:'$D(^DD(DDA(1),DA)) DDA="D" D AUDT^DICATTA
 I $D(DIU0) N DI D IJ^DIUTL(DICATTA),P^DICATT
 Q
 ;
G(I) N X Q $$GET^DDSVALF(I,"DICATT",1,"I","")
