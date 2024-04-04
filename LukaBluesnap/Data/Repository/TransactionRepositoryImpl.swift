//
//  TransactionRepositoryImpl.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//

import Combine
import Alamofire

class TransactionRepositoryImpl: TransactionsRepository {
  var authRepository: AuthRepository = DataContainer.authRepository

  func processPayment(customerId: String, card: LukaCard, amount: Double, email: String, customerTraceId: String) -> AnyPublisher<TransactionResult, TransactionError> {
    let trx = Transaction(
      email: email,
      amount: String(format:"%.2f", amount),
      bsToken: LukaBluesnapSdk.instance.session.bsToken,
      lukaClientId: customerTraceId.isEmpty ? LukaBluesnapSdk.instance.session.lukaCustomerId : customerTraceId,
      creditCard: TrxCard(
        id: card.cardId,
        statusId:0,
        ccSubType: card.cardSubType.toString(),
        ccType: card.cardProcessor.toString(),
        last4: card.cardLast4,
        expiryDate: card.expiryDate,
        country: card.country.lowercased()
      ),
      cardHolder: CardHolder(lukapayId: customerId),
      storeCard: false
    )

    let token = LukaBluesnapSdk.instance.session.lukaToken

    guard !token.isEmpty else {
      return Fail(error: TransactionError.noAuth).eraseToAnyPublisher()
    }

    return LukaBluesnapSdk.instance.apiSession.request(
      URL(string: "\(ApiConfig.baseUrl)/transaccion")!,
      method: .post,
      parameters: trx,
      encoder: JSONParameterEncoder.prettyPrinted,
      headers: ["Authorization": "Bearer \(token)"]
    )
    .publishDecodable(type: TransactionResponseDto.self)
    .tryMap { result in

      if result.value?.code == 400 {
        throw TransactionError.badRequest
      }

      if result.value?.success != true && result.value?.resultInfo?.status != "success" {
        throw TransactionError.somethingWentWrong(msg: result.value?.msg ?? "Something wrong happened")
      }

      return TransactionResult(
        id: result.value?.transactionId ?? 0,
        merchantTransactionId: result.value?.transactionMerchantId ?? 0,
        traceId: result.value?.traceId ?? "",
        amount: result.value?.amount ?? 0.0,
        lukaClientId: result.value?.cardHolder?.lukapayId ?? "",
        paymentNetwork: result.value?.paymentNetwork ?? ""
      )
    }.mapError { error -> TransactionError in
      guard let err = error as? TransactionError else {
        return TransactionError.somethingWentWrong(msg: "Something wrong happened. Try again later.")
      }
      return err
    }
    .eraseToAnyPublisher()
  }
  
  func checkTransaction(traceId: String) -> AnyPublisher<TransactionResponseDto, TransactionError> {
    return LukaBluesnapSdk.instance.apiSession.request(
      URL(string: "\(ApiConfig.baseUrl)/transaccion")!,
      method: .get,
      parameters: ["trazaId": traceId],
      headers: ["Authorization": LukaBluesnapSdk.instance.config.creds.basic()]
    )
    .publishDecodable(type: [TransactionResponseDto].self)
    .tryMap { result in
      
      guard let value = result.value?.first else {
        throw TransactionError.badRequest
      }
      
      if value.message == "Correo electrónico inválido" {
        throw TransactionError.badRequest
      }


      return value
    }.mapError { error -> TransactionError in
      guard let err = error as? TransactionError else {
        return TransactionError.somethingWentWrong(msg: "Something went wrong. Try again")
      }
      return err
    }
    .eraseToAnyPublisher()
  }
  
}


