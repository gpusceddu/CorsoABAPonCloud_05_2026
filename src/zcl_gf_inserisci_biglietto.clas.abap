CLASS zcl_gf_inserisci_biglietto DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_gf_inserisci_biglietto IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA:
        lt_biglietto TYPE TABLE FOR CREATE zi_biglietto_gf,
        ls_biglietto LIKE LINE OF lt_biglietto.

    SELECT MAX( IdBiglietto )
        FROM zi_biglietto_gf
        INTO @DATA(lv_id).

    DO 5 TIMES.
      lv_id += 1.
      CLEAR ls_biglietto.
      ls_biglietto-%cid = lv_id.
      ls_biglietto-IdBiglietto = lv_id.
      ls_biglietto-%control-IdBiglietto = if_abap_behv=>mk-on.
      APPEND ls_biglietto
        TO lt_biglietto.
    ENDDO.

    MODIFY ENTITIES OF zi_biglietto_gf
      ENTITY Biglietto
      CREATE FROM lt_biglietto.

    COMMIT ENTITIES.

  ENDMETHOD.
ENDCLASS.
