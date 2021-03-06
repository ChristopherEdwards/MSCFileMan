DINTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;3150105.090443
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 4 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 ;;7.3;3150105.090443
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 G CONT^DINTEG0
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
DDBR ;;7906127
DDBR0 ;;6764066
DDBR1 ;;8703066
DDBR2 ;;7311422
DDBR3 ;;4203793
DDBR4 ;;3825959
DDBRAHT ;;3163072
DDBRAHTE ;;4494745
DDBRAHTJ ;;8127499
DDBRAHTR ;;3559647
DDBRAP ;;6408822
DDBRGE ;;7148671
DDBRP ;;3102453
DDBRS ;;3270885
DDBRT ;;1082266
DDBRU ;;5561789
DDBRU2 ;;6998282
DDBRWB ;;3731408
DDBRZIS ;;2782759
DDD ;;4960181
DDDIN001 ;;4631596
DDDINIT ;;9469137
DDDINIT1 ;;3380778
DDDINIT2 ;;5769347
DDDINIT3 ;;17411771
DDFIX ;;9248622
DDGF ;;2404833
DDGF0 ;;5019432
DDGF1 ;;3616756
DDGF2 ;;5122106
DDGF3 ;;5884407
DDGF4 ;;3144618
DDGFADL ;;1657976
DDGFAPC ;;3517238
DDGFASUB ;;2019110
DDGFBK ;;4977860
DDGFBSEL ;;3781733
DDGFEL ;;6204971
DDGFFLD ;;3591069
DDGFFLDA ;;4985721
DDGFFM ;;13542092
DDGFH ;;777683
DDGFHBK ;;3351847
DDGFLOAD ;;6031483
DDGFORD ;;1882109
DDGFPG ;;6684383
DDGFSV ;;3914112
DDGFU ;;6031904
DDGFUPDB ;;2111934
DDGFUPDP ;;4834612
DDGLBXA ;;6650734
DDGLBXA1 ;;5660836
DDGLCBOX ;;3142271
DDGLIB0 ;;12847014
DDGLIBH ;;5990936
DDGLIBP ;;6944295
DDGLIBW ;;4873749
DDGLIBW1 ;;2827213
DDIOL ;;2169076
DDMAP ;;10326674
DDMAP1 ;;10777939
DDMAP2 ;;8115904
DDMOD ;;1243925
DDMP ;;12736095
DDMP1 ;;10259786
DDMP2 ;;9832169
DDMPSM ;;7716532
DDMPSM1 ;;4022503
DDMPU ;;8736585
DDPA1 ;;5867798
DDPA2 ;;5267527
DDR ;;9436521
DDR0 ;;7449698
DDR1 ;;1579958
DDR2 ;;9129323
DDR3 ;;4148197
DDR4 ;;1087048
DDS ;;10090099
DDS0 ;;5567296
DDS01 ;;13651139
DDS02 ;;7416211
DDS1 ;;9849651
DDS10 ;;3938555
DDS11 ;;8454599
DDS2 ;;18211459
DDS3 ;;3189882
DDS4 ;;8202272
DDS41 ;;10395644
DDS5 ;;4578219
DDS6 ;;4992467
DDS7 ;;4096139
DDSBOX ;;2092228
DDSCAP ;;1229502
DDSCLONE ;;8551304
DDSCLONF ;;3707716
DDSCOM ;;8504389
DDSCOMP ;;3749902
DDSDBLK ;;4344626
DDSDEL ;;3871490
DDSDFRM ;;7459603
DDSFO ;;1344288
DDSIT ;;1295380
DDSLIB ;;3940938
DDSM ;;8490041
DDSM1 ;;3436411
DDSMSG ;;3448001
DDSOPT ;;1262299
DDSPRNT ;;6344220
DDSPRNT1 ;;6686768
DDSPRNT2 ;;7178744
DDSPTR ;;6158065
DDSR ;;12362739
DDSR1 ;;4904990
DDSRP ;;11445903
DDSRSEL ;;3434331
DDSRUN ;;2844081
DDSSTK ;;1882725
DDSU ;;7562944
DDSUTL ;;4735038
DDSVAL ;;7158373
DDSVALF ;;9923187
DDSVALM ;;2890107
DDSWP ;;4896248
DDSZ ;;13034807
DDSZ1 ;;8694433
DDSZ2 ;;6361220
DDSZ3 ;;1594412
DDU ;;1050719
DDUCHK ;;11567917
DDUCHK1 ;;11627692
DDUCHK2 ;;14763862
DDUCHK3 ;;10216829
DDUCHK4 ;;9075423
DDUCHK5 ;;9352507
DDW ;;5083967
DDW1 ;;8630619
DDW2 ;;3548454
DDW3 ;;7712208
DDW4 ;;4008452
DDW5 ;;5305159
DDW6 ;;6106572
DDW7 ;;2528938
DDW8 ;;5165759
DDW9 ;;5266497
DDWC ;;5363342
DDWC1 ;;3741432
DDWF ;;2933221
DDWG ;;3914522
DDWH ;;2609362
DDWK ;;1588476
DDWT1 ;;7969058
DDXP ;;3072791
DDXP1 ;;8779421
DDXP2 ;;5076643
DDXP3 ;;6778805
DDXP31 ;;10141602
DDXP32 ;;4822412
DDXP33 ;;2372567
DDXP4 ;;13879375
DDXP41 ;;2008135
DDXP5 ;;1420134
DDXPLIB ;;3276900
DI ;;921286
DIA ;;9285360
DIA1 ;;7889989
DIA2 ;;4995593
DIA3 ;;11607242
DIAC ;;1497180
DIALOG ;;11370464
DIALOGU ;;2108617
DIALOGZ ;;8284783
DIAR ;;12697332
