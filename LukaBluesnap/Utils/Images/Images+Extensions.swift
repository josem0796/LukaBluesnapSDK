//
//  Images+Extensions.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//

import SwiftUI

class Images {
  static var ARROW_LEFT = "arrow_left"
}

extension Image {
  @ViewBuilder func resize(width: CGFloat, height: CGFloat) -> some View {
    self
      .resizable()
      .scaledToFit()
      .frame(width: width, height: height)
  }
}
