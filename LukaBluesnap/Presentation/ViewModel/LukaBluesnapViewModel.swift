//
//  LukaViewModel.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//

import Combine
import SwiftUI
import BluesnapSDK

class LukaBluesnapViewModel: ObservableObject {

  @Published var bsCard: BsCard = .init()
  @Published var btnState: BtnState = .disabled
  @Published var errorMsgKey: ErrorMsgKeys = .none

  enum ErrorMsgKeys: String {
    case authToken = "auth-token"
    case bsToken = "bs-token"
    case invalidCard = "invalid-card"
    case threeDSecureUnavailable = "3dsecure-unavailable-error"
    case threeDSecureFailed = "3dsecure-failed-error"
    case threeDSecureInternal = "3dsecure-internal-error"
    case none = "none"
  }

  private var disposables = Set<AnyCancellable>()

  enum BtnState {
    case disabled
    case enabled
    case loading
  }

  init() {

    $bsCard.sink { [weak self] in

      guard let self = self else {
        return
      }

      guard $0.valid else {
        self.btnState = .disabled
        return
      }

      self.btnState = .enabled
    }.store(in: &disposables)


    UseCaseFactory.bsTokenUseCase.invoke()
      .sink {  bsToken in
        if bsToken.isEmpty {
          self.errorMsgKey = .bsToken
//          self.state = .idle
          return
        }

        try! BlueSnapSDK.initBluesnap(
          bsToken: BSToken(tokenStr: bsToken),
          generateTokenFunc: { _ in },
          initKount: true, fraudSessionId: nil,
          applePayMerchantIdentifier: nil, merchantStoreCurrency: nil,
          completion: { err in
            guard let err else {
              debugPrint("No errors when authing bluesnap")
              return
            }

            debugPrint("errors when authing bluesnap \(err)")
//            self.state = .idle
          })
      }
      .store(in: &disposables)

  }

  func addCard() {

    self.btnState = .loading
    let request = BSTokenizeRequest()
    request.paymentDetails = BSTokenizeNewCCDetails(
      ccNumber: bsCard.cardNumber,
      cvv: bsCard.cardCvv,
      ccType: bsCard.ccType,
      expDate: bsCard.expiryDateFormatted
    )

    BlueSnapSDK.submitTokenizedDetails(
      tokenizeRequest: request,
      completion: { result , error in
        if error != nil {
          self.errorMsgKey = .invalidCard
          self.btnState = .enabled
          return
        }
        print(result)
        self.bsCard.country = result["issuingCountry"] ?? "US"

        BlueSnapSDK.authenticationWith3DS(currency: "USD", amount: "1.0", { result, bsErrors in
          switch result {
          case "AUTHENTICATION_SUCCEEDED":
            self.addCardDetails()
          case "AUTHENTICATION_BYPASSED":
            self.addCardDetails()
          case "AUTHENTICATION_UNAVAILABLE":
            self.btnState = .enabled
            self.errorMsgKey = .threeDSecureUnavailable
          case "AUTHENTICATION_FAILED":
            self.btnState = .enabled
            self.errorMsgKey = .threeDSecureFailed
          case "THREE_DS_ERROR":
            self.btnState = .enabled
            self.errorMsgKey = .threeDSecureInternal
          default:
            self.btnState = .enabled
            break
          }
        })
      }
    )
  }

  func addCardDetails() {
    btnState = .loading
    guard let operation: AddCardOperation = LukaBluesnapSdk.instance.operation as? AddCardOperation else {
      return
    }

    operation.loadingCall?()
    UseCaseFactory.addCardUseCase
      .invoke(
        email: operation.email,
        card: bsCard
      )

      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          debugPrint("Failure to add card details: \n\temail: \(operation.email),\n\tcardNumber: \(self.bsCard.last4 ?? ""), \n\texpiryDate: \(self.bsCard.expiryDate)")
          operation.errorCall?(error)
          
        case .finished: debugPrint("Successfully added card details: \n\temail: \(operation.email),\n\tcardNumber: \(self.bsCard.last4 ?? ""), \n\texpiryDate: \(self.bsCard.expiryDate)")
        }

        operation.dismiss()
        self.btnState = .enabled

      }, receiveValue: { result in
        self.btnState = .enabled
        operation.successCall?(result)
        
      })
      .store(in: &disposables)

  }
}
