//
//  CVVInput.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//

import SwiftUI
import Combine

struct CVVInput: View {
  @Binding var value : String

  init(
    value: Binding<String>
  ) {
    self._value = value
  }

  var body: some View {

    SecureField(
      "CVV",
      text: $value
    )
    .onReceive(Just(value)) { _ in limitText(3) }
    .keyboardType(.numberPad)

  }

  func limitText(_ upper: Int) {
    if value.count <= upper {
      return
    }

    value = String(value.prefix(upper))
  }

}

struct CVVInput_Previews: PreviewProvider {
  static var previews: some View {
    CVVInput(value: .constant(""))
  }
}
