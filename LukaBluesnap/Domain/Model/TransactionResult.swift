//
//  TransactionResult.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 8/11/23.
//

public struct TransactionResult {
  public let id: Int
  public let merchantTransactionId: Int
  public let traceId: String
  public let amount: Double
  public let lukaClientId: String
  public let paymentNetwork: String
}
