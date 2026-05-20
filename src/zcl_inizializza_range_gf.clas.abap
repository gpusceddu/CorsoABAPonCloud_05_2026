CLASS zcl_inizializza_range_gf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_inizializza_range_gf IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    " Creazione intervallo per il number range object ZID_BIG_GF
    TRY.
        cl_numberrange_intervals=>create(
          EXPORTING
            interval  = VALUE #( (
              nrrangenr  = '01'
              fromnumber = '0000000001'
              tonumber   = '9999999999'
              procind    = 'I'
            ) )
            object    = 'ZID_BIG_GF'
        ).
        out->write( 'Intervallo creato con successo.' ).
      CATCH cx_nr_object_not_found INTO DATA(lx_not_found).
        out->write( lx_not_found->get_text( ) ).
      CATCH cx_number_ranges INTO DATA(lx_nr).
        out->write( lx_nr->get_text( ) ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
