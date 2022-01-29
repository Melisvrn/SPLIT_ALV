*&---------------------------------------------------------------------*
*&  Include           ZSPLIT_ALV_SEL
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK 200 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS : S_EBELN FOR GS_ITAB-EBELN.
  SELECT-OPTIONS : S_BUKRS FOR GS_ITAB-BUKRS.
SELECTION-SCREEN END OF BLOCK 200.

AT SELECTION-SCREEN OUTPUT.
