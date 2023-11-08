//
//  AddCardUseCase.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//

import Combine

class AddCardUseCase {
  private var cardsRepository = DataContainer.cardsRepository
  func invoke(email: String, card: BsCard, customerId: String? = nil) -> AnyPublisher<AddCardResult,AddCardError> {
    return cardsRepository.storeCard(email: email, customerId: customerId, card: card)
  }
}
