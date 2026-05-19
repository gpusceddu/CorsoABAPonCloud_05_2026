CLASS zcl_gf_riempi_tipo_utente DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS:
      lm_riempi
        IMPORTING
          io_out TYPE REF TO if_oo_adt_classrun_out.
ENDCLASS.



CLASS zcl_gf_riempi_tipo_utente IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    lm_riempi( io_out = out ).
  ENDMETHOD.

  METHOD lm_riempi.
    DATA:
        lt_tipo_utente TYPE TABLE OF ztipo_utente_gf
            WITH EMPTY KEY.


    lt_tipo_utente = VALUE #( (
        id = '00'
        descrizione = 'Bambino'
        limitazioni = 'Tra 8 e 12 anni'
        prezzo = '4'
        valuta = 'EUR' ) (
        id = '01'
        descrizione = 'Adulto'
        limitazioni = 'Tra 13 e 65 anni'
        prezzo = '8'
        valuta = 'EUR' ) (
        id = '02'
        descrizione = 'Anziano'
        limitazioni = '66+'
        prezzo = '3'
        valuta = 'EUR' ) ).
    DATA(lv_output) = io_out->write(
      EXPORTING
        data   = lt_tipo_utente
        name   = 'Stiamo tentando di inserire queste righe'
*      RECEIVING
*        output =
    ).

    DELETE FROM ztipo_utente_gf.
    INSERT ztipo_utente_gf
        FROM TABLE @lt_tipo_utente.
    IF sy-subrc IS INITIAL.
      COMMIT WORK AND WAIT.
      io_out->write(
        EXPORTING
          data   = 'Inserimento avvenuto con successo'
*            name   =
*        RECEIVING
*            output =
      ).
    ELSE.
      ROLLBACK WORK.
      io_out->write(
        EXPORTING
          data   = 'Errore inserimento'
*            name   =
*          RECEIVING
*            output =
      ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
