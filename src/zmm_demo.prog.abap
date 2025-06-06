*&---------------------------------------------------------------------*
*& Report  ZSD_CHANGE_DEL_PRICING_COND
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
report zmm_demo.

include zmm_demo_top.
selection-screen begin of block b1 with frame title text-001.
select-options: so_werks for t001w-werks.
selection-screen end of block b1.


include zmm_demo_model.
include zmm_demo_view.
include zmm_demo_app.


start-of-selection.
  data: ls_criteria type mts_criteria.
  data  lo_model_list type ref to zcl_alv_model_list.
  data  lo_view_list type ref to zcl_alv_view_list.
  data  lo_app_list type ref to zcl_alv_application_list.

  ls_criteria-werks   = so_werks[].

  lo_model_list   = new #( ls_criteria ).
  lo_view_list    = new zcl_alv_view_list( ).
  lo_app_list     = new #( io_model_list    = lo_model_list    io_view_list    = lo_view_list ).
  lo_app_list->run( ).
  write space.
