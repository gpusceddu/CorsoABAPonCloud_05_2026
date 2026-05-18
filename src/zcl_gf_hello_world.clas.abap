CLASS zcl_gf_hello_world DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      gm_test.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS:
      lm_test.
    CLASS-METHODS:
      lm_test2.
    DATA:
        gv_flag TYPE abap_boolean.
ENDCLASS.



CLASS zcl_gf_hello_world IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA: lt_table TYPE STANDARD TABLE OF /dmo/flight.

    out->write(
      EXPORTING
        data   = 'Hello world!'
        name   = 'Descrizione'
*      RECEIVING
*        output =
    ).

    SELECT *
        FROM /dmo/flight
        INTO TABLE @lt_table.


    out->write(
      EXPORTING
        data   = lt_table
        name   = 'Tabella di output'
*      RECEIVING
*        output =
    ).

    me->lm_test(  ).
    lm_test(  ).

    zcl_gf_hello_world=>lm_test2(  ).
  ENDMETHOD.

  METHOD lm_test.

  ENDMETHOD.

  METHOD lm_test2.
  ENDMETHOD.

  METHOD gm_test.
    gv_flag = 'X'.
  ENDMETHOD.

ENDCLASS.
