//
//  GetBsTokenUseCase.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//

import Combine

class GetBsTokenUseCase {
  var authRepository = DataContainer.authRepository

  func invoke() -> AnyPublisher<String,Never> {
    return authRepository.getBsToken()
  }
}
