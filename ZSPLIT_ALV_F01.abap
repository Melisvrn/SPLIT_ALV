*&---------------------------------------------------------------------*
*&      Form  GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM GET_DATA .

  SELECT  EKKO~EBELN EKKO~BSART EKKO~AEDAT EKPO~EBELP
    EKPO~MATNR EKBE~GJAHR EKBE~BELNR EKPO~BUKRS EKPO~STATU FROM
     EKKO INNER  JOIN EKPO
    ON EKKO~EBELN EQ EKPO~EBELN
    AND EKKO~AEDAT EQ EKPO~AEDAT
    AND EKKO~BUKRS EQ EKPO~BUKRS
    INNER JOIN EKBE ON EKPO~EBELN EQ EKBE~EBELN
    AND EKPO~MATNR EQ EKBE~MATNR
    INTO  CORRESPONDING FIELDS OF TABLE GT_ITAB
    WHERE EKKO~EBELN IN S_EBELN
    AND   EKKO~BUKRS IN S_BUKRS.


ENDFORM.

FORM CREATE_OBJECT .
*Alv Ekranına için.
  CREATE OBJECT ALV_GRID_0200
    EXPORTING
      CONTAINER_NAME = 'ALV_GRID'. "

ENDFORM.

FORM SPLITTER_MAIN .
*2.Ekran İçin.
  CREATE OBJECT SPLITTER
    EXPORTING
      PARENT  = ALV_GRID_0200
      ROWS    = 2
      COLUMNS = 1
      ALIGN   = 15.

  CALL METHOD SPLITTER->GET_CONTAINER
    EXPORTING
      ROW       = 1
      COLUMN    = 1
    RECEIVING
      CONTAINER = ALV_GRID1.

  CALL METHOD SPLITTER->GET_CONTAINER
    EXPORTING
      ROW       = 2
      COLUMN    = 1
    RECEIVING
      CONTAINER = ALV_GRID2.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  CREATE_FIELDCAT_0200
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM CREATE_FIELDCATALOG_0200 . "ZMV_SPLIT
  CLEAR :FIELDCATALOG[].
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     I_BUFFER_ACTIVE        =
      I_STRUCTURE_NAME       = 'ZMV_SPLIT_ALV'
    CHANGING
      CT_FIELDCAT            = FIELDCATALOG
    EXCEPTIONS
      INCONSISTENT_INTERFACE = 1
      PROGRAM_ERROR          = 2
      OTHERS                 = 3.

ENDFORM.

FORM CREATE_FIELDCATALOG2_0200.
  CLEAR :FIELDCATALOG2[].
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     I_BUFFER_ACTIVE        =
      I_STRUCTURE_NAME       = 'ZMV_SPLIT'
    CHANGING
      CT_FIELDCAT            = FIELDCATALOG2
    EXCEPTIONS
      INCONSISTENT_INTERFACE = 1
      PROGRAM_ERROR          = 2
      OTHERS                 = 3.

ENDFORM.

FORM REFRESH_ALV .
*Tabloları Yenilemek için.

  CALL METHOD DISPLAY1->REFRESH_TABLE_DISPLAY .
  CALL METHOD DISPLAY2->REFRESH_TABLE_DISPLAY .

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  DISPLAY_0200
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM DISPLAY_0200 .

  DATA: S1110_EVENT_HANDLER TYPE REF TO S1110_EVENT_HANDLER,
        LS_VARIANT          TYPE DISVARIANT VALUE SY-REPID.

  CREATE OBJECT DISPLAY1
    EXPORTING
      I_PARENT = ALV_GRID1.

  CREATE OBJECT DISPLAY2
    EXPORTING
      I_PARENT = ALV_GRID2.

  CREATE OBJECT S1110_EVENT_HANDLER.

  SET HANDLER S1110_EVENT_HANDLER->HANDLE_DOUBLE_CLICK  FOR DISPLAY1.
  SET HANDLER S1110_EVENT_HANDLER->SCR1_DATA_CHANGED    FOR DISPLAY1.
  SET HANDLER S1110_EVENT_HANDLER->ON_HOTSPOT_CLICK FOR DISPLAY2.


  CALL METHOD DISPLAY1->REGISTER_EDIT_EVENT
    EXPORTING
      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_ENTER.

  CALL METHOD DISPLAY1->REGISTER_EDIT_EVENT
    EXPORTING
      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED
    EXCEPTIONS
      ERROR      = 1
      OTHERS     = 2.

  PERFORM CREATE_FIELDCATALOG_0200.

  W_LAYO-CWIDTH_OPT = 'X'.
  W_LAYO-COL_OPT    = 'X'.
  W_LAYO-ZEBRA      = 'X'.
  W_LAYO-SEL_MODE   = 'A'.

*Double Click'i 1.ekranda yapması için.
  CALL METHOD DISPLAY1->SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
      I_SAVE           = 'A'
      I_STRUCTURE_NAME = 'ZMV_SPLIT_ALV'
      IS_LAYOUT        = W_LAYO
*     it_toolbar_excluding = gt_exc2
    CHANGING
      IT_OUTTAB        = GT_ITAB
      IT_FIELDCATALOG  = FIELDCATALOG.

  PERFORM CREATE_FIELDCATALOG2_0200.

  W_LAYO-COL_OPT    = 'X'.
  W_LAYO-ZEBRA      = 'X'.
  W_LAYO-SEL_MODE   = 'A'.

  CALL METHOD DISPLAY2->SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
      IS_LAYOUT       = W_LAYO
*     it_toolbar_excluding = gt_exc2
    CHANGING
      IT_OUTTAB       = LT_ITAB2
      IT_FIELDCATALOG = FIELDCATALOG2.


ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  GET_MATERIAL_INFO
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_E_ROW_INDEX  text
*----------------------------------------------------------------------*
FORM GET_MATERIAL_INFO  USING    P_INDEX.

  CLEAR: GS_ITAB.

  READ TABLE GT_ITAB INTO GS_ITAB INDEX P_INDEX.

  CLEAR: LT_ITAB, LS_ITAB.

  SELECT  * FROM ZMV_SPLIT
    INTO TABLE LT_ITAB2
      WHERE EBELN EQ GS_ITAB-EBELN  AND BUKRS EQ GS_ITAB-BUKRS.
     "WHERE MATNR EQ GS_ITAB-MATNR.



ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  SAVE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SAVE .
  DATA : LT_DATA TYPE TABLE OF  ZMV_SPLIT.
  DATA : LS_DATA LIKE LINE OF LT_DATA.

  MOVE-CORRESPONDING GT_ITAB TO LT_DATA.

  LOOP AT LT_DATA INTO LS_DATA.
    LS_DATA-ERNAM = SY-UNAME.
    LS_DATA-ERDAT = SY-DATUM.
    LS_DATA-ERZET = SY-UZEIT.

    MODIFY LT_DATA FROM LS_DATA TRANSPORTING ERNAM ERDAT ERZET.


*    INSERT  zmv_split FROM TABLE lt_data.
*     INSERT zmv_split from ls_data.
*    MODIFY zmv_split from ls_data.

    MODIFY ZMV_SPLIT FROM TABLE LT_DATA.
    COMMIT WORK ."AND WAIT .

    CLEAR LS_DATA.
  ENDLOOP.


ENDFORM.
