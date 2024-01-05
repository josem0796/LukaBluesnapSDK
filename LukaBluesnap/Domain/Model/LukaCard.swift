//
//  Card.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//

import Foundation
import BluesnapSDK

public struct LukaCard: Codable {
  public let cardId: Int
  public let cardLast4: String
  public let cardProcessor: LukaCard.Processor
  public let cardSubType: LukaCard.SubType
  public let country: String
  public let expiryDate: String

  public enum Processor: Codable {
    case visa
    case mastercard
    case amex
    case other

    static func fromString(_ str: String?) -> Processor {
      switch str {
      case "VISA": return .visa
      case "MASTERCARD" : return .mastercard
      case "AMEX": return .amex
      default: return .other
      }
    }

    func toString() -> String {
      switch self {
      case .visa: return "VISA"
      case .mastercard : return "MASTERCARD"
      case .amex: return "AMEX"
      default: return "UNKNOWN"
      }
    }
  }

  public enum SubType: Codable {
    case credit
    case debit
    case other

    static func fromString(_ str: String?) -> SubType {
      switch str {
      case "CREDIT": return .credit
      case "DEBIT" : return .debit
      default: return .other
      }
    }

    func toString() -> String {
      switch self {
      case .credit: return "CREDIT"
      case .debit : return "DEBIT"
      default: return "UNKNOWN"
      }
    }
  }
}

struct TrxCard: Codable {
  let bin: String? = nil
  let category: String = "CONSUMER"
  let city: String? = nil
  let description: String? = .empty
  let direction: String? = nil
  let zipCode: String? = nil
  let expiryDate: String?
  let storeCard: Bool = true
  let id: Int
  let statusId: Int
  let currency: String? = "USD"
  let country: String?
  let ccSubType: String?
  let ccType: String?
  let last4: String?
  let state: String? = nil

  init(
    id: Int = 0,
    statusId: Int,
    ccSubType: String?,
    ccType: String?,
    last4: String?,
    expiryDate: String?,
    country: String?
  ) {
    self.expiryDate = expiryDate
    self.statusId = statusId
    self.country = country
    self.ccSubType = ccSubType
    self.ccType = ccType
    self.last4 = last4
    self.id = id
  }

  enum CodingKeys: String, CodingKey {
    case bin = "Bin"
    case category = "CategoriaTarjeta"
    case city = "Ciudad"
    case description = "Description"
    case direction = "Direccion"
    case zipCode = "CodigoPostal"
    case storeCard = "EstaBoveda"
    case state = "Estado"
    case expiryDate = "FechaVencimiento"
    case id = "Id"
    case statusId = "IdStatus"
    case currency = "Moneda"
    case country = "Pais"
    case ccSubType = "SubTipoTarjeta"
    case ccType = "TipoTarjeta"
    case last4 = "UltimosCuatroDigitos"
  }
}

class BsCard: ObservableObject {
  var cardNumber: String = ""
  var cardHolderName: String = ""
  var cardCvv: String = ""
  var expiryDate: String = ""
  var country: String = "US"
  var subType: String = "CREDIT"
  var cardNumberFormatted: String {
    return cardNumber.replacingOccurrences(of: " ", with: "")
  }

  var valid : Bool {
    guard !cardNumber.isEmpty,
          !cardCvv.isEmpty,
          cardCvv.count == 3,
          !expiryDate.isEmpty else {
      return false
    }

    return true
  }

  var expiryDateFormatted: String {
    return expiryDate.formatExpiryDate()
  }
  var ccType: String? {
    return BSValidator.getCCTypeByRegex(cardNumber)
  }

  var last4: String? {
    return String(cardNumber
            .replaceWithRegex(pattern: " ", character: "")
            .suffix(4))
  }

  init(cardNumber: String = "", cardHolderName: String = "", cardCvv: String = "", expiryDate: String = "") {
    self.cardNumber = cardNumber
    self.cardHolderName = cardHolderName
    self.cardCvv = cardCvv
    self.expiryDate = expiryDate
  }

}

internal extension String {
  fileprivate func formatExpiryDate() -> String {
    let expiryDateArray =  self.split(separator: "/")
    let month = expiryDateArray[0]
    let year = expiryDateArray[1]

    return "\(month)/20\(year)"
  }
}
