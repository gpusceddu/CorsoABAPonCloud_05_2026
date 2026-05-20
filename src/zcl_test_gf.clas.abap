CLASS zcl_test_gf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_gf IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*    INSERT zbiglietto_gf
*        FROM (
*            SELECT *
*                FROM zbiglietto_gf2
*        ).
  ENDMETHOD.
ENDCLASS.
