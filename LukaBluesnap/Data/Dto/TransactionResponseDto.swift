//
//  TransactionResponseDto.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 6/11/23.
//

public struct TransactionResponseDto: Codable {
  public let infoUser: InfoUser?
  public let resultInfo: ResultInfo?
  public let cardData: CardData?
  public let cardHolder: CardHolderResponseDto?
  public let msg: String?
  public let code: Int?
  public var continues: Bool?
  public let success : Bool?
  public let transactionId: Int?
  public let transactionMerchantId: Int?
  public let paymentNetwork: String?
  public let traceId: String?
  public let amount: Double?
  public let originalAmount: Double?
  public let usdAmount: Double?
  public let message: String?

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
    case originalAmount = "MontoOriginal"
    case usdAmount = "MontoUsd"
    case message = "Mensaje"
  }
}

public struct InfoUser: Codable {
  public let email: String
  enum CodingKeys: String, CodingKey {
    case email = "Email"
  }
}

public struct ResultInfo: Codable {
  public let status: String

  enum CodingKeys: String, CodingKey {
    case status = "EstatusProcesamiento"
  }
}

public struct CardData: Codable {
  public let id: Int
  public let last4: String
  public let ccSubType: String
  public let ccType: String?
  public let expiryDate: String?
  public let country: String?

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

public struct CardHolderResponseDto: Codable {
  public let lukapayId: String?

  enum CodingKeys: String, CodingKey {
    case lukapayId = "LukapayId"
  }
}
