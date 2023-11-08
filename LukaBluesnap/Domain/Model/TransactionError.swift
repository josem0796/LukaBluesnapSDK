//
//  TransactionError.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 7/11/23.
//

public enum TransactionError: Error {
  case noAuth
  case noCustomerId
  case badRequest
  case somethingWentWrong(msg: String)

  func getErrorMsg() -> String {
    switch self {
    case .somethingWentWrong(msg: let msg):
        return msg 
    default:
         return ""
    }
  }
}

extension TransactionError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noAuth:
          return StringProvider.nsStringLocalized(Strings.no_auth)
        default:
          return NSLocalizedString("Something wrong happened", comment: "")
        }
    }
}
