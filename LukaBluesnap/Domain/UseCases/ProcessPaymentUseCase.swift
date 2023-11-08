//
//  ProcessPaymentUseCase.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//

import Combine

class ProcessPaymentUseCase {
  var transactionsRepository = DataContainer.transactionsRepository
  var authRepository: AuthRepository = DataContainer.authRepository

  func invoke(customerId: String, card: LukaCard, amount: Double, email: String) -> AnyPublisher<TransactionResult, TransactionError> {
    return authRepository.auth(username: LukaBluesnapSdk.instance.config.creds.username, password: LukaBluesnapSdk.instance.config.creds.password)
      .flatMap { _ in
        return self.authRepository.getBsToken()
      }.flatMap { _ in
        return self.transactionsRepository.processPayment(customerId: customerId, card: card, amount: amount, email: email)
      } .eraseToAnyPublisher()
  }
}
