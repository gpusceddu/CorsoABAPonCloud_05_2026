CLASS zcx_error_bigl_gf DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .
    INTERFACES if_abap_behv_message .

    CONSTANTS:
      gc_msgid TYPE symsgid VALUE 'ZERROR_BIGL_GF',
*
      BEGIN OF invalid_status,
        msgid TYPE symsgid VALUE gc_msgid,
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'GV_ID',
        attr2 TYPE scx_attrname VALUE 'GV_STATO',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF invalid_status.
    DATA:
        gv_id     TYPE zi_biglietto_gf2-IdBiglietto,
        gv_stato  TYPE zi_biglietto_gf2-Stato.

    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL
        !severity TYPE if_abap_behv_message=>t_severity OPTIONAL
        iv_id     TYPE zi_biglietto_gf2-IdBiglietto OPTIONAL
        iv_stato  TYPE zi_biglietto_gf2-Stato OPTIONAL.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcx_error_bigl_gf IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor(
    previous = previous
    ).
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.

    if_abap_behv_message~m_severity = severity.

    gv_id       = iv_id.
    gv_stato    = iv_stato.
  ENDMETHOD.
ENDCLASS.
