//
//  TransactionsRepository.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//

import Combine

protocol TransactionsRepository {
  func processPayment(customerId: String, card: LukaCard, amount: Double, email: String, customerTraceId: String) -> AnyPublisher<TransactionResult, TransactionError>
}
