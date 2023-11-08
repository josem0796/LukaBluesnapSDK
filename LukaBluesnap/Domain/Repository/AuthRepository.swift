//
//  AuthRepository.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//


import Combine

protocol AuthRepository {
  func auth(username: String, password: String) -> AnyPublisher<String,Never>
  func getBsToken() -> AnyPublisher<String,Never> 
}
