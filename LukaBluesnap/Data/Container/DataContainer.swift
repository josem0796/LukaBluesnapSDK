//
//  DataContainer.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//

struct DataContainer {
  static var cardsRepository: CardsRepository {
    CardsRepositoryImpl()
  }

  static var authRepository: AuthRepository {
    AuthRepositoryImpl()
  }

  static var transactionsRepository: TransactionsRepository {
    TransactionRepositoryImpl()
  }
}
