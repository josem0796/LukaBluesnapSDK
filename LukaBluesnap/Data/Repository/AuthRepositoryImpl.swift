//
//  AuthRepositoryImpl.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//

import Combine
import Alamofire

class AuthRepositoryImpl: AuthRepository {
  func auth(username: String, password: String) -> AnyPublisher<String, Never> {
    return AF.request(
      URL(string: "\(ApiConfig.baseUrl)/servicio/login")!,
      method: .post,
      parameters: ["Username":username, "Password": password],
      encoder: JSONParameterEncoder.prettyPrinted
    ).validate(statusCode: [200])
      .publishDecodable(type: EmptyResponseDto.self, emptyResponseCodes: [200])
      .compactMap { response in
        guard let token: String = response.response?.allHeaderFields["token"] as? String,
              let id: String = response.response?.allHeaderFields["id"] as? String else {
          return ""
        }

        print("token \(token), id: \(id)")
        LukaBluesnapSdk.instance.session.lukaCustomerId = id
        LukaBluesnapSdk.instance.session.lukaToken = token
        return token
      }
      .eraseToAnyPublisher()
  }

  func getBsToken() -> AnyPublisher<String, Never> {
    let authToken = LukaBluesnapSdk.instance.session.lukaToken
    return AF.request(
      URL(string: "\(ApiConfig.baseUrl)/transaccion/token")!,
        method: .get,
        headers: ["Authorization": "Bearer \(authToken)"]
      )
      .validate(statusCode: [201])
      .publishDecodable(type: EmptyResponseDto.self, emptyResponseCodes: [201])
      .compactMap { response in
        guard let bsToken = response.response?.allHeaderFields["bstoken"] as? String else {
          return ""
        }
        print("got bsToken: \(bsToken)")

        LukaBluesnapSdk.instance.session.bsToken = bsToken
        return bsToken
    }.eraseToAnyPublisher()  }
}
