//
//  CardsRepository.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//

import Combine

protocol CardsRepository {
  func storeCard(email: String,  customerId: String?, card: BsCard) -> AnyPublisher<AddCardResult, AddCardError>
  func listCards(customerId: String) -> AnyPublisher<[LukaCard], Never>
  func deleteCard(customerId: String, cardId: Int) -> AnyPublisher<Bool,Never>
}
