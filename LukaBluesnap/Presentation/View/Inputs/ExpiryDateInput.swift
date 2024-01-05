//
//  ExpiryDateInput.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//

import Combine
import SwiftUI

struct ExpiryDateInput: View {
  @Binding var value : String
  var prevValue: String? = nil
  let hintText: String

  init(
    value: Binding<String>,
    hintText: String = ""
  ) {
    self._value = value
    self.hintText = hintText
  }

  var body: some View {

    TextField(
      "MM/YY",
      text: _value
    )
    .onReceive(Just(value)) { _ in limitText(5) }

    .keyboardType(.numberPad)
  }

  func limitText(_ upper: Int) {
    if value.count <= upper {
        value = getTextFormatted(text: value)
        return
    }

    value = getTextFormatted(text: String(value.prefix(upper)))
  }

  func getTextFormatted(text: String) -> String {

    guard text.count % 3 == 0 else {
      return text
    }


    let newText: String = text.replaceWithRegex(pattern: "/", character: "")
      .enumerated()
      .reduce(into: "") { result, element in
        let (index, character) = element
        result.append(character)

        if (index + 1) % 2 == 0 && result.count < 5{
            result.append("/")
        }
      }

    return newText
  }
}

struct ExpiryDateInput_Previews: PreviewProvider {
  static var previews: some View {
    ExpiryDateInput(value: .constant(""))
  }
}
