*&---------------------------------------------------------------------*
*& Report ZSPLIT_ALV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSPLIT_ALV.

INCLUDE ZSPLIT_ALV_TOP.
INCLUDE ZSPLIT_ALV_CLS.
INCLUDE ZSPLIT_ALV_SEL.
INCLUDE ZSPLIT_ALV_F01.
INCLUDE ZSPLIT_ALV_PBO.
INCLUDE ZSPLIT_ALV_PAI.

START-OF-SELECTION.

  PERFORM GET_DATA.
  CALL SCREEN 0200.

END-OF-SELECTION.
