*&---------------------------------------------------------------------*
*&  Include           ZSPLIT_ALV_PAI
*&---------------------------------------------------------------------*

MODULE USER_COMMAND_0200 INPUT.

  CASE SY-UCOMM.
    WHEN '&BACK' OR '&CANCEL' OR '&EXIT'.
      "SET SCREEN 0.
      LEAVE TO SCREEN 0.
    WHEN '&KAYDET'.
      PERFORM SAVE.

    WHEN OTHERS.
  ENDCASE.

ENDMODULE.
