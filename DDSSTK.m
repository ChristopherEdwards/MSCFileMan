DDSSTK ;SFISC/MKO-STACK CONTEXT, GO TO A NEW PAGE ;19JUNE2007
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1028**
 ;
 N DDO
 N DDSBK,DDSDN,DDSFLD,DDSNP,DDSOPB,DDSPG,DDSPTB,DDSREP,DDSTP
 ;
 I DDSSTACK?1"`".E D
 . S DDSSTACK=+$E(DDSSTACK,2,999)
 E  I DDSSTACK=+$P(DDSSTACK,"E") D
 . S DDSSTACK=+$O(^DIST(.403,+DDS,40,"B",DDSSTACK,""))
 E  D
UP . S DDSSTACK=$O(^DIST(.403,+DDS,40,"C",$$UP^DILIBF(DDSSTACK),"")) ;**
 ;
 I 'DDSSTACK!($D(^DIST(.403,+DDS,40,+$G(DDSSTACK),0))[0) D  Q
 . K DDSSTACK,DDSBR
 ;
 N DDSDAORG,DDSDLORG,DDSFLORG,DDSPG
 N:'$P(^DIST(.403,+DDS,40,+$G(DDSSTACK),0),U,6) DDSSC ;N DDSSC (Page array) if not going to a POPUP PAGE
 ;
 S DDSPG=DDSSTACK
 K DDSSTACK,DDSBR
 ;
 S DDSDLORG=DDSDL,DDSDAORG=DA
 F DDSI=1:1:DDSDL S DDSDAORG(DDSI)=DA(DDSI)
 K DDSI
 ;
DDSH S DDSSTK=1,DDSH=1 ;DDSH tells SM+6^DIR0 to refresh the COMMAND LINE
 D PROC^DDS
 Q