@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Biglietti'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_BIGLIETTO_GF
  as select from zbiglietto_gf as Biglietto
{
  key Biglietto.id_biglietto  as IdBiglietto,
      @Semantics: {
          user: {
              createdBy: true
          }
      }
      Biglietto.creato_da     as CreatoDa,
      @Semantics.systemDateTime.createdAt: true
      Biglietto.creato_a      as CreatoA,
      //      Questo campo serve per gestire i valori alla modifica
      @Semantics.user.lastChangedBy: true
      Biglietto.modificato_da as ModificatoDa,
      @Semantics.systemDateTime.lastChangedAt: true
      Biglietto.modificato_a  as ModificatoA,

      case when Biglietto.modificato_a <> Biglietto.creato_a
        then 'X'
        else ''
      end                     as Modificato
      //      case when $projection.ModificatoA <> $projection.CreatoA
      //        then 'X'
      //        else ''
      //      end                     as Modificato
}
