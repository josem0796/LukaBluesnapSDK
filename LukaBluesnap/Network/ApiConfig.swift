//
//  ApiConfig.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//

import Foundation

class ApiConfig {
  static var baseUrl: String  {
   return LukaBluesnapSdk.instance.config.env == .live ?
    "https://lukaapi.payco.net.ve/api/v1" : "https://bspaycoapi-qa.payco.net.ve/api/v1"
  }
}
