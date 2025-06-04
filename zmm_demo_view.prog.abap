*&---------------------------------------------------------------------*
*&  Include           ZSD_CHANGE_DEL_PRICING_COND_V
*&---------------------------------------------------------------------*
* View Interface
interface zif_alv_view.
  methods:
    set_data
      importing
        ir_data type ref to data,
    display.
endinterface.
class zcl_alv_view_list definition.
  public section.
    interfaces:
      zif_alv_view,
      if_alv_rm_grid_friend.
    methods: constructor,
      on_toolbar for event toolbar of cl_gui_alv_grid
        importing
          e_object
          sender,
      handle_user_command for event user_command of cl_gui_alv_grid
        importing e_ucomm  sender,
      refresh.
  private section.
    data:
      mt_data       type standard table of t001w,
      it_fcat       type lvc_t_fcat,
      mo_master_alv type ref to cl_gui_alv_grid.
endclass.
class zcl_alv_view_list implementation.

  method zif_alv_view~set_data.
    field-symbols <fs_context> type standard table.
    assign ir_data->* to <fs_context>.
    mt_data = corresponding #( <fs_context> ).
  endmethod.
  method constructor.
  endmethod.

  method zif_alv_view~display.
    data: o_salv     type ref to cl_salv_table.
    data: lt_exclude_btns     type  ui_functions.

    cl_salv_table=>factory( importing
                              r_salv_table   = o_salv
                            changing
                              t_table        = mt_data ).


    data(lo_column) = cast cl_salv_column_table( o_salv->get_columns( )->get_column( 'NAME1' ) ).
    lo_column->set_short_text(  |НазваЗавод| ).
    lo_column->set_medium_text( |Назва завод| ).
    lo_column->set_long_text(   |Назва Заводу| ).


    data(it_fcat) = cl_salv_controller_metadata=>get_lvc_fieldcatalog( r_columns      = o_salv->get_columns( )
                                                                       r_aggregations = o_salv->get_aggregations( ) ).


    loop at it_fcat assigning field-symbol(<ln_fcat>).
      case <ln_fcat>-fieldname.
        when 'PFACH'.
          <ln_fcat>-no_out = 'X'.
        when others.
      endcase.
    endloop.

*    append cl_gui_alv_grid=>mc_fc_loc_copy_row  to lt_exclude_btns.
*    append cl_gui_alv_grid=>mc_fc_loc_delete_row  to lt_exclude_btns.
*    append cl_gui_alv_grid=>mc_fc_loc_append_row to lt_exclude_btns.
*    append cl_gui_alv_grid=>mc_fc_loc_insert_row  to lt_exclude_btns.
*    append cl_gui_alv_grid=>mc_fc_loc_copy to lt_exclude_btns.
*    append cl_gui_alv_grid=>mc_fc_loc_cut to lt_exclude_btns.
*    append cl_gui_alv_grid=>mc_fc_loc_paste to lt_exclude_btns.
*    append cl_gui_alv_grid=>mc_fc_loc_paste_new_row to lt_exclude_btns.
*    append cl_gui_alv_grid=>mc_fc_loc_undo to lt_exclude_btns.

    data(lo_master_alv) = new cl_gui_alv_grid( i_parent      = cl_gui_container=>default_screen
                                       i_appl_events = abap_true ).

*    set handler me->handle_hotspot_click    for lo_master_alv.
    set handler me->on_toolbar              for lo_master_alv.
    set handler me->handle_user_command     for lo_master_alv.

    lo_master_alv->set_table_for_first_display( exporting
                                          is_variant            = value disvariant( report = sy-repid handle = 'LIST' )
                                          i_bypassing_buffer    = abap_false
                                          i_save                = 'A'
                                          it_toolbar_excluding  = lt_exclude_btns
                                          is_layout             = value lvc_s_layo( zebra = abap_true cwidth_opt = abap_true
                                                                                 sel_mode = 'A'
                                                                                 grid_title = 'Список заводів' )
                                        changing
                                          it_fieldcatalog    = it_fcat
                                          it_outtab          = mt_data ).

    " Set class ALV reference
    mo_master_alv = lo_master_alv.
  endmethod.

  method refresh.
    mo_master_alv->refresh_table_display( is_stable = value lvc_s_stbl( row = abap_true
                                                                 col = abap_true )
                                   i_soft_refresh = abap_true ).
  endmethod.
  method on_toolbar.
    append value #( butn_type = 3 ) to e_object->mt_toolbar.
    append value #( butn_type = 5 text = 'Виконати' icon = icon_change function = '&RUN' quickinfo = 'Виконати' disabled = ' ' ) to e_object->mt_toolbar.
  endmethod.
  method handle_user_command.
*    data: lt_bapiret2 type bapiret2_t.
*    refresh lt_bapiret2 .
    case e_ucomm.
      when '&RUN'.
*        sender->get_selected_rows( importing et_row_no = data(it_row_no) ).
*        delete it_row_no where row_id <= 0.
*
*        if lines( it_row_no ) > 0.
*          loop at it_row_no assigning field-symbol(<fs_row>).
*            read table mt_data assigning field-symbol(<fs_line>) index <fs_row>-row_id.
*          endloop.
*        endif.
        MESSAGE 'Функція виконана'(200) TYPE 'I' DISPLAY LIKE 'S'.
      when 'EXIT' or 'BACK' or 'CANC'.
        leave to screen 0.

    endcase.
  endmethod.
endclass.
