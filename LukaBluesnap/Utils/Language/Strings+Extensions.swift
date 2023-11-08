//
//  Strings+Extensions.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//


import SwiftUI
import Foundation

class Strings {
  static let card_number = "card_number"
  static let name = "name"
  static let expiry_date = "expiry_date"
  static let cvv = "cvv"
  static let enter_card_details = "enter_card_details"
  static let card_details = "card_details"
  static let cardholder_name="cardholder_name";
  static let add="add";
  static let no_auth="no_auth";
  static let card_already_added_error="card_already_added_error";
  static let accept="accept";
  static let cancel="cancel";
}

extension String {
  func localized() -> LocalizedStringKey {
    return LocalizedStringKey(self)
  }


}

class TextProvider {
  public static func text(_ key: LocalizedStringKey) -> Text {
      return Text(key, bundle: Bundle(for: self))
  }
}

class StringProvider {
  public static func nsStringLocalized(_ key: String) -> String {
    return NSLocalizedString(key, bundle: Bundle(for: self), comment:"")
  }
}


