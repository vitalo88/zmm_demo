interface zif_alv_model.
  methods:
    initialize,
    get_data returning value(ir_ref) type ref to data.
endinterface.

class zcl_alv_model_list definition.
  public section.
    interfaces zif_alv_model.

    methods: constructor importing
                           !is_criteria type mts_criteria,
      set_data importing value(ir_ref) type ref to data.
    data: mt_data type standard table of t001w.
    data ms_criteria type mts_criteria.
endclass.
class zcl_alv_model_list implementation.
  method constructor.
    ms_criteria = is_criteria.
  endmethod.


  method zif_alv_model~initialize.
    clear mt_data[].

    select * from t001w as t
        into corresponding fields of table mt_data
        where t~werks in ms_criteria-werks.
  endmethod.
  method zif_alv_model~get_data.
    get reference of mt_data into ir_ref.
  endmethod.
  method set_data.

    assign ir_ref->* to field-symbol(<fs>).
    mt_data = corresponding #( <fs> ).
  endmethod.
endclass.
