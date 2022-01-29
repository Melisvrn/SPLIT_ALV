*&---------------------------------------------------------------------*
*&  Include           ZSPLIT_ALV_CLS
*&---------------------------------------------------------------------*

CLASS S1110_EVENT_HANDLER DEFINITION.
  PUBLIC SECTION.
    METHODS SCR1_DATA_CHANGED
                  FOR EVENT DATA_CHANGED OF CL_GUI_ALV_GRID
      IMPORTING ER_DATA_CHANGED.

    METHODS : HANDLE_DOUBLE_CLICK
                  FOR EVENT DOUBLE_CLICK OF CL_GUI_ALV_GRID
      IMPORTING E_ROW E_COLUMN.

    METHODS ON_HOTSPOT_CLICK
                  FOR EVENT HOTSPOT_CLICK OF CL_GUI_ALV_GRID
      IMPORTING E_ROW_ID
                  E_COLUMN_ID
                  ES_ROW_NO .


ENDCLASS.

CLASS S1110_EVENT_HANDLER IMPLEMENTATION.

  METHOD scr1_data_changed .

    w_stbl-row = 'X'.
    w_stbl-col = 'X'.

    CALL METHOD display1->refresh_table_display
      EXPORTING
        is_stable      = w_stbl
        i_soft_refresh = 'X'.

  ENDMETHOD.


  METHOD HANDLE_DOUBLE_CLICK.

    PERFORM GET_MATERIAL_INFO USING E_ROW-INDEX.

    W_STBL-ROW = 'X'.
    W_STBL-COL = 'X'.

    CALL METHOD DISPLAY1->REFRESH_TABLE_DISPLAY
      EXPORTING
        IS_STABLE      = W_STBL
        I_SOFT_REFRESH = 'X'.

    CALL METHOD DISPLAY2->REFRESH_TABLE_DISPLAY
      EXPORTING
        IS_STABLE      = W_STBL
        I_SOFT_REFRESH = 'X'.

  ENDMETHOD.


   METHOD  on_hotspot_click.
*Hotspot'a Tıklayıp Popup Açmak için.
    DATA : l_columnid TYPE lvc_s_col,
           l_roid     TYPE lvc_s_roid.

    DATA: wt_layout    TYPE slis_layout_alv.

    wt_layout-colwidth_optimize = 'X'.
    wt_layout-zebra             = 'X'.
     w_stbl-row = 'X'.
    w_stbl-col = 'X'.

    CALL METHOD display2->refresh_table_display
      EXPORTING
        is_stable      = w_stbl
        i_soft_refresh = 'X'.

  ENDMETHOD.



ENDCLASS.
