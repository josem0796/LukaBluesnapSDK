//
//  MainViewModel.swift
//  LukaBluesnapSDK
//
//  Created by Jose Moran on 6/11/23.
//

import Foundation
import Combine
import LukaBluesnap

class MainViewModel: ObservableObject {

  @Published var cards: [LukaCard] = []

  var disposables = Set<AnyCancellable>()

  func addCard() {
    LukaBluesnapSdk.addNewCard(email: "jmoran@yopmail.com")
      .onSuccess { result in
        print(result)
      }.onError { err in
        print(err)
      }
      .onLoading {
        print("loading")
      }
      .start()
  }

  func getCards() {
    LukaBluesnapSdk.getCards(clientId: "e1555a98-881a-48a5-b958-fc1c6f37f258")
      .onSuccess { list in
        self.cards = list
      }.onLoading {

      }.start()
  }

  func deleteCard(id: Int) {
    LukaBluesnapSdk.deleteCard(clientId: "e1555a98-881a-48a5-b958-fc1c6f37f258", cardId: id)
      .onSuccess { isDeleted in
        if (isDeleted) {
          // remove from list
        }else {
          // show error message
        }
      }.onError { err in

      }.start()
  }

  func makePayment(card: LukaCard) {
    LukaBluesnapSdk.processPayment(clientId: "e1555a98-881a-48a5-b958-fc1c6f37f258", card: card, amount: 10.0, email: "jdoe@yopmail.com")
      .onSuccess { rst in
        print("Transaction successfull \(rst.id)")
      }.onError { err in
        print(err)
      }.start()
  }

}
