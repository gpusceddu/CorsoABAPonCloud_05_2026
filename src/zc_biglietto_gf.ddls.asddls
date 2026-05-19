@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Biglietti'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_BIGLIETTO_GF
  provider contract transactional_query
  as projection on ZI_BIGLIETTO_GF as Biglietto
{
    key Biglietto.IdBiglietto,
    Biglietto.CreatoDa,
    Biglietto.CreatoA,
    Biglietto.ModificatoDa,
    Biglietto.ModificatoA,
    Biglietto.Modificato
}
