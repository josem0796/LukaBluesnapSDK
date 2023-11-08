//
//  Transaction.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//

struct Transaction: Codable {
  var email: String = .empty
  var amount: String = .empty
  var reference: String = .empty
  var bsToken: String = .empty
  var currency: String = "USD"
  var cardId: Int = 0
  var lukaClientId: String
  var creditCardId: Int = 0
  let channelId: String = "5"
  var storeCard: Bool = true
  var creditCard: TrxCard? = nil
  var cardHolder: CardHolder? = nil

  init(
    email: String,
    amount: String = "1.0",
    bsToken: String,
    lukaClientId: String,
    creditCard: TrxCard? = nil,
    cardHolder: CardHolder? = nil,
    storeCard: Bool = true
  ) {
    self.email = email
    self.amount = amount
    self.bsToken = bsToken
    self.lukaClientId = lukaClientId
    self.creditCard = creditCard
    self.creditCardId = creditCard?.id ?? 0
    self.cardHolder = cardHolder
    self.storeCard = storeCard
  }

  enum CodingKeys: String, CodingKey {
    case email = "EmailTarjetaHabiente"
    case amount = "Monto"
    case reference = "Referencia"
    case bsToken = "TokenBluesnap"
    case currency = "Moneda"
    case cardId = "Id"
    case lukaClientId = "IdTraza"
    case channelId = "IdCanal"
    case storeCard = "ValidacionTarjeta"
    case creditCard = "TarjetaCredito"
    case cardHolder = "TarjetaHabiente"
    case creditCardId = "IdTarjetaCredito"
  }
}

struct CardHolder: Codable {
  let lukapayId: String?
  var name: String = .empty
  var lastName: String = .empty

  enum CodingKeys: String, CodingKey {
    case lukapayId = "LukapayId"
    case name = "Nombre"
    case lastName = "Apellido"
  }
}
