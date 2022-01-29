*&---------------------------------------------------------------------*
*&  Include           ZSPLIT_ALV_TOP
*&---------------------------------------------------------------------*

TABLES : EKKO ,
         EKPO ,
         ZMV_SPLIT ,
         EKBE .


DATA : GT_ITAB TYPE  TABLE OF ZMV_SPLIT_ALV , "WITH HEADER LINE ,
       LT_ITAB  TYPE  TABLE OF ZMV_SPLIT_ALV,
       LS_ITAB TYPE ZMV_SPLIT_ALV.
DATA:  GS_ITAB TYPE ZMV_SPLIT_ALV .
DATA : GT_ITAB2 TYPE TABLE OF ZMV_SPLIT,
       LT_ITAB2 TYPE TABLE OF ZMV_SPLIT,
       LS_ITAB2 TYPE ZMV_SPLIT,
       GS_ITAB2 TYPE ZMV_SPLIT.


"0200 ALV Docking Ekranı Tanımı.
"Type ref to: oluşturulan dataya veri tipini miras verir. Claalarda kullanılır.
DATA : ALV_GRID_0200 TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
       SPLITTER      TYPE REF TO CL_GUI_SPLITTER_CONTAINER.

DATA : ALV_GRID1 TYPE REF TO CL_GUI_CONTAINER,
       ALV_GRID2 TYPE REF TO CL_GUI_CONTAINER.

DATA : DISPLAY1 TYPE REF TO CL_GUI_ALV_GRID,
       DISPLAY2 TYPE REF TO CL_GUI_ALV_GRID.



"ALV özellikleri için gerekli tanımlamalar
DATA : FIELDCATALOG     TYPE LVC_T_FCAT,
       FIELDCATALOG2    TYPE LVC_T_FCAT,
       GS_FIELDCATALOG  TYPE LVC_S_FCAT,
       GS_FIELDCATALOG2 TYPE LVC_S_FCAT,
       GS_LAYOUT_0200   TYPE LVC_S_LAYO.

DATA : GS_TOOLBAR  TYPE STB_BUTTON,
       W_STBL      TYPE LVC_S_STBL,
       W_LAYO      TYPE LVC_S_LAYO,
       G_EVENT(30),
       G_NODE_KEY  TYPE TV_NODEKEY,
       GT_EXC      TYPE UI_FUNCTIONS,
       GT_EXC2     TYPE UI_FUNCTIONS.
