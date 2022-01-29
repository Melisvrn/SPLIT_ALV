*&---------------------------------------------------------------------*
*&  Include           ZSPLIT_ALV_PBO
*&---------------------------------------------------------------------*

MODULE STATUS_0200 OUTPUT.
  SET PF-STATUS 'STATUS_200'.
  SET TITLEBAR 'SPLIT ALV'.

  IF ALV_GRID_0200 IS INITIAL.
    PERFORM CREATE_OBJECT.
*    PERFORM CREATE_FIELDCATALOG_0200.
*    PERFORM CREATE_FIELDCATALOG2_0200.
    PERFORM SPLITTER_MAIN.
    PERFORM DISPLAY_0200.

  ELSE.
    PERFORM refresh_alv.
  ENDIF.
ENDMODULE.
*-------------------------------------------------------*
