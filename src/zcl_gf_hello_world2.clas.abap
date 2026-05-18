CLASS zcl_gf_hello_world2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_gf_hello_world2 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA:
        lo_object TYPE REF TO zcl_gf_hello_world,
        lo_object2 TYPE REF TO zcl_gf_hello_world,
        lo_object3 TYPE REF TO zcl_gf_hello_world,
        lo_object4 TYPE REF TO zcl_gf_hello_world.
    lo_object = NEW #(  ).
    lo_object->gm_test(  ).
*    lo_object->gv_flag = 'X'.
    CREATE OBJECT lo_object2.
*    lo_object2->gm_test(  ).
    CREATE OBJECT lo_object3.
*    lo_object3->gm_test(  ).
    CREATE OBJECT lo_object4.
    lo_object4->gm_test(  ).
  ENDMETHOD.
ENDCLASS.
