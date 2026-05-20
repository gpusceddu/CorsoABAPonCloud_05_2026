CLASS lhc_zi_biglietto_gf2 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Biglietto
        RESULT result,
      earlynumbering_create FOR NUMBERING
        IMPORTING entities FOR CREATE Biglietto,
      ValidaStato FOR VALIDATE ON SAVE
        IMPORTING keys FOR Biglietto~ValidaStato,
      GetDefaultsForCreate FOR READ
        IMPORTING keys FOR FUNCTION Biglietto~GetDefaultsForCreate RESULT result,
      onSave FOR DETERMINE ON SAVE
        IMPORTING keys FOR Biglietto~onSave,
      CustomDelete FOR MODIFY
            IMPORTING keys FOR ACTION Biglietto~CustomDelete RESULT result.
ENDCLASS.

CLASS lhc_zi_biglietto_gf2 IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.
    DATA:
*      lv_id_max TYPE zi_biglietto_gf2-IdBiglietto,
      lv_id     TYPE zi_biglietto_gf2-IdBiglietto,
      lv_id_max TYPE cl_numberrange_runtime=>nr_number.
*    SELECT MAX( IdBiglietto )
*        FROM zi_biglietto_gf2
*        INTO @lv_id.
*    WITH
*        +max AS (
*            SELECT MAX( IdBiglietto ) AS IdBiglietto
*                FROM zi_biglietto_gf2
*            UNION ALL
*            SELECT MAX( IdBiglietto ) AS IdBiglietto
*                FROM zbiglietto_gf2_d
*        )
*        SELECT MAX( IdBiglietto )
*            FROM +max
*            INTO @lv_id_max.

    LOOP AT entities
            INTO DATA(ls_entity).
      IF ls_entity-IdBiglietto IS INITIAL.
*        lv_id_max += 1.
*        lv_id = lv_id_max.
        TRY.
            cl_numberrange_runtime=>number_get(
              EXPORTING
*            ignore_buffer     =
                nr_range_nr       = '01'
                object            = 'ZID_BIG_GF'
                quantity          = 1
*            subobject         =
*            toyear            =
              IMPORTING
                number            =  lv_id_max
*            returncode        =
*            returned_quantity =
            ).
            lv_id = lv_id_max.
          CATCH cx_nr_object_not_found.
          CATCH cx_number_ranges.
        ENDTRY.
      ELSE.
        lv_id = ls_entity-IdBiglietto.
      ENDIF.
      APPEND VALUE #(
          %cid = ls_entity-%cid
          %is_draft = ls_entity-%is_draft
          IdBiglietto = lv_id
      ) TO mapped-biglietto.
    ENDLOOP.
  ENDMETHOD.

  METHOD ValidaStato.
    DATA: lt_biglietto TYPE TABLE FOR READ RESULT zi_biglietto_gf2.

    READ ENTITIES OF zi_biglietto_gf2
        IN LOCAL MODE
        ENTITY Biglietto
        FIELDS ( Stato )
        WITH CORRESPONDING #( keys )
        RESULT lt_biglietto.

    LOOP AT lt_biglietto
            INTO DATA(ls_biglietto)
            WHERE Stato <> 'BOZZA'
              AND Stato <> 'ACCETTATO'
              AND Stato <> 'CANCELLATO'.
*       Segnalo quale riga va in errore
      APPEND VALUE #(
           %tky = ls_biglietto-%tky
           )
          TO failed-biglietto.
*       Elenco gli errori
      APPEND VALUE #(
          %tky = ls_biglietto-%tky
          %msg = NEW zcx_error_bigl_gf(
              textid = zcx_error_bigl_gf=>invalid_status
              severity = if_abap_behv_message=>severity-error
*                severity = if_abap_behv_message=>severity-warning
              iv_id = ls_biglietto-IdBiglietto
              iv_stato = ls_biglietto-Stato
          )
          )
          TO reported-biglietto.
    ENDLOOP.

  ENDMETHOD.

  METHOD GetDefaultsForCreate.
    result = VALUE #(
        FOR key IN keys (
            %cid         = key-%cid
            %param-stato = 'BOZZA'
        )
    ).
  ENDMETHOD.

  METHOD onSave.
    DATA:
      lt_biglietto TYPE TABLE FOR READ RESULT zi_biglietto_gf2,
      lt_update    TYPE TABLE FOR UPDATE zi_biglietto_gf2.

    READ ENTITIES OF zi_biglietto_gf2
        IN LOCAL MODE
        ENTITY Biglietto
        FIELDS ( Stato )
        WITH CORRESPONDING #( keys )
        RESULT lt_biglietto.

    LOOP AT lt_biglietto
            INTO DATA(ls_biglietto).
      APPEND VALUE #(
              %tky = ls_biglietto-%tky
              Stato = 'ACCETTATO'
              %control-Stato = if_abap_behv=>mk-on
           )
          TO lt_update.
    ENDLOOP.

    IF lt_update IS NOT INITIAL.
      MODIFY ENTITIES OF zi_biglietto_gf2
        IN LOCAL MODE
        ENTITY Biglietto
        UPDATE FROM lt_update.
    ENDIF.
  ENDMETHOD.


  METHOD CustomDelete.
    DATA:
      lt_biglietto TYPE TABLE FOR READ RESULT zi_biglietto_gf2,
      lt_update    TYPE TABLE FOR UPDATE zi_biglietto_gf2.

    READ ENTITIES OF zi_biglietto_gf2
        IN LOCAL MODE
        ENTITY Biglietto
        ALL FIELDS
        WITH CORRESPONDING #( keys )
        RESULT lt_biglietto.

    LOOP AT lt_biglietto
            INTO DATA(ls_biglietto).
      APPEND VALUE #(
              %tky = ls_biglietto-%tky
              Stato = 'CANCELLATO'
              %control-Stato = if_abap_behv=>mk-on
           )
          TO lt_update.

      ls_biglietto-Stato = 'CANCELLATO'.
      APPEND VALUE #(
        %tky = ls_biglietto-%tky
        %param = CORRESPONDING #( ls_biglietto )
      ) TO result.
    ENDLOOP.

    IF lt_update IS NOT INITIAL.
      MODIFY ENTITIES OF zi_biglietto_gf2
        IN LOCAL MODE
        ENTITY Biglietto
        UPDATE FROM lt_update.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
