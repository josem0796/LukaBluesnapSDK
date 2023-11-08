//
//  UseCaseFactory.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//

import Foundation

public struct UseCaseFactory {
  static var lukaAuthUseCase: LukaAuthUseCase { LukaAuthUseCase() }
  static var bsTokenUseCase: GetBsTokenUseCase { GetBsTokenUseCase() }

  static var addCardUseCase: AddCardUseCase { AddCardUseCase() }
  static var deleteCardUseCase: DeleteCardUseCase { DeleteCardUseCase() }
  static var listCardsUseCase: GetCardsUseCase { GetCardsUseCase() }

  static var processPaymentUseCase: ProcessPaymentUseCase { ProcessPaymentUseCase() }
}
