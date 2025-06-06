** Controller Class
CLASS zcl_alv_application_list DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING io_model_list TYPE REF TO zcl_alv_model_list
                            io_view_list  TYPE REF TO zcl_alv_view_list,
      run.
  PRIVATE SECTION.
    DATA:
      mo_model_list TYPE REF TO zif_alv_model,
      mo_view_list  TYPE REF TO zif_alv_view.
ENDCLASS.
CLASS zcl_alv_application_list IMPLEMENTATION.
  METHOD constructor.
    mo_model_list = io_model_list.
    mo_view_list = io_view_list.
  ENDMETHOD.

* ---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_MVC_DEMO_APP->RUN
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------
  METHOD run.
    DATA: lo_list_view TYPE REF TO zcl_alv_view_list.
    DATA: lo_model_list    TYPE REF TO zcl_alv_model_list.

    mo_model_list->initialize( ).
    lo_model_list ?= mo_model_list.
    mo_view_list->set_data( ir_data = mo_model_list->get_data( )  ).
    mo_view_list->display(  ).

  ENDMETHOD.
ENDCLASS.
