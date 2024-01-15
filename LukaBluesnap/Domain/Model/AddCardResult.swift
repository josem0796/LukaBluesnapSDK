//
//  AddCardResult.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 6/11/23.
//

import Foundation

public struct AddCardResult: Codable {
  public let lukaCustomerId: String
  public let card: LukaCard
}

public enum AddCardError: Error {
  case noAuth
  case noCustomerId
  case couldNotAddCard
  case cardAlreadyAdded
  case invalidEmail
  case somethingWentWrong(msg: String)
}

extension AddCardError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noAuth:
          return StringProvider.nsStringLocalized(Strings.no_auth)
        case .cardAlreadyAdded:
          return StringProvider.nsStringLocalized(Strings.card_already_added_error)
        default:
          return NSLocalizedString("Something wrong happened", comment: "")
        }
    }
}


