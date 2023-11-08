//
//  View+Extensions.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//

import SwiftUI

extension View {
  @ViewBuilder func inputStyle(_ bkg: Color = Color.inputBkgGray) -> some View {
    self
      .frame(height: 18)
      .padding(16)
      .background(bkg)
      .cornerRadius(8)
  }
}
