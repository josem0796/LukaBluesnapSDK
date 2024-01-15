//
//  TransactionResponseDto.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 6/11/23.
//

struct TransactionResponseDto: Codable {
  let infoUser: InfoUser?
  let resultInfo: ResultInfo?
  let cardData: CardData?
  let cardHolder: CardHolderResponseDto?
  let msg: String?
  let code: Int?
  var continues: Bool?
  let success : Bool?
  let transactionId: Int?
  let transactionMerchantId: Int?
  let paymentNetwork: String?
  let traceId: String?
  let amount: Double?
  let message: String?

  enum CodingKeys: String, CodingKey {
    case infoUser = "InfoUsuarioPagador"
    case resultInfo = "InfoProceso"
    case cardData = "InfoTarjeta"
    case cardHolder = "TarjetaHabiente"
    case msg = "Descripcion"
    case code = "Codigo"
    case continues = "Continua"
    case success = "Exitoso"
    case transactionId = "TransaccionId"
    case transactionMerchantId = "TransaccionMerchantId"
    case paymentNetwork = "MedioDePago"
    case traceId = "TrazaId"
    case amount = "Monto"
    case message = "Mensaje"
  }
}

struct InfoUser: Codable {
  let email: String
  enum CodingKeys: String, CodingKey {
    case email = "Email"
  }
}

struct ResultInfo: Codable {
  let status: String

  enum CodingKeys: String, CodingKey {
    case status = "EstatusProcesamiento"
  }
}

struct CardData: Codable {
  let id: Int
  let last4: String
  let ccSubType: String
  let ccType: String?
  let expiryDate: String?
  let country: String?

  enum CodingKeys: String, CodingKey {
    case id = "Id"
    case last4 = "UltimosCuatroDigitos"
    case ccSubType = "SubTipoTarjeta"
    case ccType = "TipoTarjeta"
    case expiryDate = "FechaVencimiento"
    case country = "Pais"
  }
}

//extension CreditCard {
//  static func from(cardData: CardData) -> CreditCard {
//    return CreditCard(id: cardData.id, expiryDate: cardData.expiryDate ?? "", last4: cardData.last4, type: cardData.ccType ?? "")
//  }
//}

struct CardHolderResponseDto: Codable {
  let lukapayId: String?

  enum CodingKeys: String, CodingKey {
    case lukapayId = "LukapayId"
  }
}
