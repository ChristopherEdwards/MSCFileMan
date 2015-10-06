DIEH1 ;SFISC/DPC-DBS HELP CON'T ;05:41 PM  8 Aug 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**85,999**
 ;
 ;;
DT(DIEHDT,DIWRITE) ; **CCO/NI OPTIONAL 'DIWRITE' PARAMETER ADDED SO WE CAN CALL THIS FROM DIEQ AS WELL AS DIEFU AND DIEH FOR FOREIGN-LANGUAGE DATE-HELP
 N P,Q
 I DIEHDT'["N" S P(1)=$$EZBLD^DIALOG($S(DIEHDT["M":9110.8,1:9110.1)) ;22*85  **CCO/NI 'OR 0157' 'OR 120157'
 D
 . I DIEHDT["P" S P(2)=$$EZBLD^DIALOG(9110.2) Q  ;**CCO/NI 'PAST'
 . I DIEHDT["F" S P(2)=$$EZBLD^DIALOG(9110.3) Q  ;**CCO/NI 'FUTURE'
 . S P(2)=$$EZBLD^DIALOG(9110.4) ;**CCO/NI 'ASSUMES CURRENT YEAR'
 . S P(3)=$$EZBLD^DIALOG(9110.5) ;**CCO/NI '20 YEARS future, 80 past'
 . Q
M I DIEHDT["M" D BLD^DIALOG(9110.7,.P,.P) G W ;22*85
 I DIEHDT'["X" D
 . N X S X=$$EZBLD^DIALOG(9110.6) ;**CCO/NI  'MAY OMIT PRECISE DATE'
 . I $G(P(3))]"" S P(4)=X Q
 . S P(3)=X Q
 D BLD^DIALOG(9110,.P,.P)
 I DIEHDT["T"!(DIEHDT["R") D
 . I DIEHDT["S" S Q(1)=$$EZBLD^DIALOG(9112) ;**CCO/NI 'SECONDS ALLOWED'
 . I DIEHDT["R" S Q(2)=$$EZBLD^DIALOG(9113) ;**CCO/NI 'TIME REQUIRED'
 . D BLD^DIALOG(9111,.Q,.Q)
 . Q
W I $G(DIWRITE) D MSG^DIALOG("WH") ;**CCO/NI NEW DIWRITE PARAMETER WRITES IT OUT
 Q
 ;
