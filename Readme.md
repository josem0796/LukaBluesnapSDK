
# Luka - BlueSnap iOS SDK

--------------------------

[![Latest Version](https://img.shields.io/badge/Latest%20Version-1.0.0-blue.svg)](https://github.com/josem0796/LukaBluesnapSDk/releases)
[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org/)
[![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)](https://developer.apple.com/)

Luka's iOS SDK for Bluesnap enables you to integrate with Bluesnap SDK in swiftly manner. It's important to note that this SDK currently only supports Card payments through the BlueSnap SDK and no other payment method is supported.

# Installation

## Requirements
* Luka API credentials
* iOS 15 or later

## CocoaPods
To integrate Luka - BlueSnap SDK into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '15.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'LukaBluesnapSDK', '~> <latest version available>'
end
```

Then, run the following command:

```bash
$ pod install --repo-update
```
# Usage

## Initialization
Initialize LukaBluesnapSDK by setting up the configuration on your AppDelegate class or in your Swift main App in the following way:

```swift 
    LukaBluesnapSdk
      .setUpConfig(
        config: Config(env: .sandbox, creds: Config.SdkCredentials(username: "username", password: "password")),
        callbacks: ConfigCallbacksImpl()
      )
```

The ConfigCallbacks protocol is used to provide callback functionality as describe in the following code: 

```swift 
    class ConfigCallbacksImpl: ConfigCallbacks {
        func onSuccess() {
          print("success")
        }
    
        func onError() {
          print("error")
        }
    }
```

## Add a new card to a user 

To add a Debit/Credit card to a user in your app you may use the addNewCard() method: 

```swift 
    LukaBluesnapSdk.addNewCard(email: "emailaddress@email.com")
      .onSuccess { result in
        print(result)
      }.onError { err in
        print(err)
      }
      .onLoading {
        print("loading")
      }
      .start()
```

The onSuccess callback function provides an AddCardResult class that contains information regarding the lukaId assign to the given email address, as well as Card information provided as a Card object.

```swift 
    public struct AddCardResult: Codable {
        public let lukaCustomerId: String
        public let card: LukaCard
    }
```

```swift 
    public struct LukaCard: Codable {
      public let cardId: Int
      public let cardLast4: String
      public let cardProcessor: LukaCard.Processor
      public let cardSubType: LukaCard.SubType
      public let country: String
      public let expiryDate: String
    }
```
The onError callback provides an error parameter of type Error which can be cast to AddCardError to differentiate each type of error: 

```swift 
    public enum AddCardError: Error {
      case noAuth
      case noCustomerId
      case couldNotAddCard
      case cardAlreadyAdded
      case somethingWentWrong(msg: String)
    }
```

In case, the error is not on the previous available options within the AddCardError class, then a string describing the error will be provided as parameter of the error. To access a description of the error the property `errorDescription` may be used.

## Add a new card to a user

To add a Debit/Credit card to a user in your app you may use the addNewCard() method:

```swift 
    LukaBluesnapSdk.addNewCard(email: "emailaddress@email.com")
      .onSuccess { result in
        print(result)
      }.onError { err in
        print(err)
      }
      .onLoading {
        print("loading")
      }
      .start()
```
This method redirects you to a built-in screen within the SDK that provides with all the inputs needed to link a new card with a user.

The onSuccess callback function provides an AddCardResult class that contains information regarding the lukaId assign to the given email address, as well as Card information provided as a Card object.

This logic is consistent across all available methods within this SDK.

## List all available cards for a user 

To list all Debit/Credit cards from a give user in your app you may use the getCards() method, as such:

```swift 
    LukaBluesnapSdk.getCards(clientId: "client uuid provided when a card is link to a user")
      .onSuccess { list : [LukaCard] in
        self.cards = list
      }.onLoading {}
      .start()
```

This method provides with a list of instances of the LukaCard class. This same class may be used later when processing a payment with a card. It's important to note that if any error occurs, then an empty array will be returned.

## Delete a user card

To be able to delete a user card you only need the user clientId and the cardId to delete:

```swift 
    LukaBluesnapSdk.deleteCard(clientId: "client uuid provided when a card is link to a user", cardId: id)
      .onSuccess { isDeleted in
        if (isDeleted) {
          // remove from list
        }
      }.onError { err in

      }.start()
```

## Process a payment 

To be able to process a payment with a card that is already link to a user you may use the processPayment() method:

```swift 
    LukaBluesnapSdk.processPayment(clientId: "client uuid provided when a card is link to a user", card: card, amount: 10.0, email: "emailaddress@email.com")
      .onSuccess { rst in
        print("Transaction successfull \(rst.id)")
      }.onError { err in
        print(err)
      }.start()
```

This method needs the previously provided LukaCard class, the amount in Double, the clientId and the email associated with the user. The onSuccess callback returns an instance of TransactionResult class, which contains relevant information regarding the payment. 

```swift 
    public struct TransactionResult {
      public let id: Int
      public let merchantTransactionId: Int
      public let traceId: String
      public let amount: Double
      public let lukaClientId: String
      public let paymentNetwork: String
    }
```

