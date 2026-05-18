CLASS zcl_gf_estrazione_voli DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS:
      lm_conta_connection_id
        IMPORTING
          out TYPE REF TO if_oo_adt_classrun_out.
ENDCLASS.



CLASS zcl_gf_estrazione_voli IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    lm_conta_connection_id( out = out ).
  ENDMETHOD.


  METHOD lm_conta_connection_id.
    TYPES: BEGIN OF lty_counter,
             carrier_id TYPE /dmo/flight-carrier_id,
             cnt        TYPE int8,
           END OF lty_counter.
    DATA: lt_counter TYPE STANDARD TABLE OF lty_counter.

    SELECT
            AirlineID,
            COUNT( DISTINCT ConnectionID ) AS cnt
        FROM /DMO/I_Flight
        GROUP BY AirlineID
        ORDER BY AirlineID
        INTO TABLE @lt_counter.
*    SELECT
*            carrier_id,
*            COUNT( DISTINCT connection_id ) AS cnt
*        FROM /dmo/flight
*        GROUP BY carrier_id
*        ORDER BY carrier_id
*        INTO TABLE @lt_counter.
*    WITH
*        +select AS (
*            SELECT DISTINCT
*                    carrier_id,
*                    connection_id
*                FROM /dmo/flight
*        )
*    SELECT
*            carrier_id,
*            COUNT( connection_id ) AS cnt
*        FROM +select
*        GROUP BY carrier_id
*        INTO TABLE @lt_counter.

    out->write(
      EXPORTING
        data   = lt_counter
        name   = 'Contatore voli'
*      RECEIVING
*        output =
    ).
  ENDMETHOD.

ENDCLASS.
