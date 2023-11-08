//
//  Font+Extensions.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 6/11/23.
//

import SwiftUI

enum OpenSans: String {
  case regular = "Opensans-Regular"
  case bold = "Opensans-Bold"
  case semiBold = "Opensans-Semibold"
  case light = "Opensans-Light"
}

extension ContentSizeCategory {
  var size: CGFloat {
    switch self {
      case .extraSmall:
        return 12
      case .small:
        return 14
      case .medium:
        return 16
      case .large:
        return 20
      case .extraLarge:
        return 24
      default:
        return 14
    }
  }
}


extension View {
  func customFont(_ font: OpenSans, size: CGFloat) -> some View {
    self.font(.custom(font.rawValue, size: size, relativeTo: .headline))
  }

  func customFont(_ font: OpenSans, category: ContentSizeCategory) -> some View {
    customFont(font.rawValue, category: category)
  }

  func customFont(_ name: String, category: ContentSizeCategory) -> some View {
    return font(.custom(name, size: category.size))
  }

  func customFont(_ name: String, size: CGFloat) -> some View {
    return font(.custom(name, size: size))
  }

}
