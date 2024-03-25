//
//  ChecktTransactionUseCase.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 25/3/24.
//

import Foundation
import Combine

class ChecktTransactionUseCase {
  private var transactionRepository = DataContainer.transactionsRepository
  func invoke(traceId: String) -> AnyPublisher<TransactionResponseDto,TransactionError> {
    return transactionRepository.checkTransaction(traceId: traceId)
  }
}
