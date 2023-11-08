//
//  DeleteCardsUseCase.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//

import Combine

class DeleteCardUseCase {
  private var cardsRepository = DataContainer.cardsRepository
  var authRepository: AuthRepository = DataContainer.authRepository
  
  func invoke(customerId: String, cardId: Int) -> AnyPublisher<Bool, Never> {
    return authRepository.auth(username: LukaBluesnapSdk.instance.config.creds.username, password: LukaBluesnapSdk.instance.config.creds.password)
      .flatMap { _ in
        return self.cardsRepository.deleteCard(customerId: customerId, cardId: cardId)
      }.eraseToAnyPublisher()
  }
}
