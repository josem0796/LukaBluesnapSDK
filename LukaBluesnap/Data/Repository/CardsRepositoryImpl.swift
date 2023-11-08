//
//  CardsRepositoryImpl.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//

import Combine
import Alamofire

class CardsRepositoryImpl: CardsRepository {

  func storeCard(email: String, customerId: String? = nil, card: BsCard) -> AnyPublisher<AddCardResult, AddCardError> {
    let trx = Transaction(
      email: email,
      bsToken: LukaBluesnapSdk.instance.session.bsToken,
      lukaClientId: LukaBluesnapSdk.instance.session.lukaCustomerId,
      creditCard: TrxCard(
        statusId:0,
        ccSubType: card.subType,
        ccType: card.ccType,
        last4: card.last4,
        expiryDate: card.expiryDateFormatted,
        country: card.country.lowercased()
      ),
      cardHolder: CardHolder(lukapayId: customerId)
    )

    let token = LukaBluesnapSdk.instance.session.lukaToken

    guard !token.isEmpty else {
      return Fail(error: AddCardError.noAuth).eraseToAnyPublisher()
    }

    return AF.request(
      URL(string: "\(ApiConfig.baseUrl)/transaccion")!,
      method: .post,
      parameters: trx,
      encoder: JSONParameterEncoder.prettyPrinted,
      headers: ["Authorization": "Bearer \(token)"]
    )
    .publishDecodable(type: TransactionResponseDto.self)
    .tryMap { result in

      if result.value?.code == 400 {
        throw AddCardError.cardAlreadyAdded
      }

      if result.value?.success != true && result.value?.resultInfo?.status != "success" {
        throw AddCardError.somethingWentWrong(msg: result.value?.msg ?? "Something went wrong. Try again")
      }

      guard let lukaId = result.value?.cardHolder?.lukapayId else {
        throw AddCardError.noCustomerId
      }

      let cardId = result.value?.cardData?.id ?? 0
      let last4 = result.value?.cardData?.last4 ?? ""
      let ccType = result.value?.cardData?.ccType ?? ""
      let ccSubType = result.value?.cardData?.ccSubType ?? ""
      let expiryDate = result.value?.cardData?.expiryDate ?? ""
      let country = result.value?.cardData?.country ?? ""


      return AddCardResult(lukaCustomerId: lukaId, card: LukaCard(cardId: cardId, cardLast4: last4, cardProcessor: LukaCard.Processor.fromString(ccType), cardSubType: LukaCard.SubType.fromString(ccSubType), country: country, expiryDate: expiryDate))
    }.mapError { error -> AddCardError in
      guard let err = error as? AddCardError else {
        return AddCardError.somethingWentWrong(msg: "Something went wrong. Try again")
      }
      return err
    }
    .eraseToAnyPublisher()
  }

  func listCards(customerId: String) -> AnyPublisher<[LukaCard], Never> {
    let token = LukaBluesnapSdk.instance.session.lukaToken

    guard !token.isEmpty else {
      return Just([]).eraseToAnyPublisher()
    }

    return AF.request(
      URL(string: "\(ApiConfig.baseUrl)/tarjetacredito/servicio/\(customerId)")!,
      method: .get,
      headers: ["Authorization": "Bearer \(token)"]
    )
    .publishDecodable(type: [TrxCard].self)
    .compactMap {
      guard let value = $0.value else {
        return []
      }

      return value.map { LukaCard(cardId: $0.id, cardLast4: $0.last4 ?? "", cardProcessor: LukaCard.Processor.fromString($0.ccType), cardSubType: LukaCard.SubType.fromString($0.ccSubType), country: $0.country ?? "", expiryDate: $0.expiryDate ?? "")}

    }
    .replaceError(with: [])
    .replaceNil(with: [])
    .eraseToAnyPublisher()
  }

  func deleteCard(customerId: String, cardId: Int) -> AnyPublisher<Bool, Never> {
    let token = LukaBluesnapSdk.instance.session.lukaToken

    guard !token.isEmpty else {
      return Just(false).eraseToAnyPublisher()
    }

    return AF.request(
      URL(string: "\(ApiConfig.baseUrl)/tarjetacredito/\(cardId)/user/\(customerId)")!,
      method: .delete,
      headers: ["Authorization": "Bearer \(token)"]
    )
    .publishDecodable(type: EmptyResponseDto.self, emptyResponseCodes: [202])
    .compactMap { response in
      return response.response?.statusCode == 202
    }
    .replaceError(with: false)
    .replaceNil(with: false)
    .eraseToAnyPublisher()
  }

}
