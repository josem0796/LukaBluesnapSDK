//
//  GetCardsUseCase.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//

import Combine

class GetCardsUseCase {
  var cardsRepository = DataContainer.cardsRepository
  var authRepository: AuthRepository = DataContainer.authRepository

  func invoke(customerId: String) -> AnyPublisher<[LukaCard], Never> {
    return authRepository.auth(username: LukaBluesnapSdk.instance.config.creds.username, password: LukaBluesnapSdk.instance.config.creds.password)
      .flatMap { _ in
        return self.cardsRepository.listCards(customerId: customerId)
      }.eraseToAnyPublisher()
  }
}
