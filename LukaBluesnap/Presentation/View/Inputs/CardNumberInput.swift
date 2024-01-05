//
//  CardNumberInpu.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//

import SwiftUI
import Combine

struct CardNumberInput: View {
  @Binding var value : String
  let hintText: String
  @State var textLen = 0
  @State var isDeleting = true
  var offset = 0

  init(
    value: Binding<String>,
    hintText: String = ""
  ) {
    self._value = value
    self.hintText = hintText
  }

  var body: some View {

    TextField(
      "**** **** **** ****",
      text: _value
    )
    .onReceive(Just(value)) { _ in limitText(19) }


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

    guard text.count % 5 == 0 else {
      return text
    }

    let newText: String = text.replaceWithRegex(pattern: " ", character: "") // no spaces
      .enumerated()
      .reduce(into: "") { result, element in
        let (index, character) = element
        result.append(character)

        if ((index + 1) % 4) == 0 && result.count < 19{
          result.append(" ")
        }
      }

    return newText
  }
}

struct CardNumberInput_Previews: PreviewProvider {
  static var previews: some View {
    CardNumberInput(value: .constant(""))
  }
}
