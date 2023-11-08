//
//  EmptyResponse.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//

import Alamofire

struct EmptyResponseDto : Codable, EmptyResponse {
  static func emptyValue() -> Self {
    return EmptyResponseDto.init()
  }
}
