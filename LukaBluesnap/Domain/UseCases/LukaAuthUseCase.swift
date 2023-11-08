//
//  LukaAuthUseCase.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//

import Combine

class LukaAuthUseCase {
  var authRepository = DataContainer.authRepository
  func invoke(username: String, password: String) -> AnyPublisher<String, Never> {
    return authRepository.auth(username: username , password: password)
  }
}
