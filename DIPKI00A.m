DIPKI00A ;VEN/TOAD-PACKAGE FILE INIT ; 30-MAR-1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 I DSEC F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DIC(9.4,0,"DD")
 ;;=#
 ;;^DIC(9.4,0,"DEL")
 ;;=#
 ;;^DIC(9.4,0,"LAYGO")
 ;;=#
 ;;^DIC(9.4,0,"WR")
 ;;=#