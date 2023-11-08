//
//  FontLoader.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 6/11/23.
//

import Foundation
import CoreGraphics
import CoreText

public class FontLoader {
    static public func loadFont() {
        if let fontUrl = Bundle(for: FontLoader.self).url(forResource: "Opensans-Bold", withExtension: "ttf"),
           let dataProvider = CGDataProvider(url: fontUrl as CFURL),
           let newFont = CGFont(dataProvider) {
            var error: Unmanaged<CFError>?
            if !CTFontManagerRegisterGraphicsFont(newFont, &error)
                {
                    print("Error loading Font!")
            } else {
                print("Loaded font")
            }
        } else {
            assertionFailure("Error loading font")
        }

      if let fontUrl = Bundle(for: FontLoader.self).url(forResource: "Opensans-Regular", withExtension: "ttf"),
         let dataProvider = CGDataProvider(url: fontUrl as CFURL),
         let newFont = CGFont(dataProvider) {
          var error: Unmanaged<CFError>?
          if !CTFontManagerRegisterGraphicsFont(newFont, &error)
              {
                  print("Error loading Font!")
          } else {
              print("Loaded font")
          }
      } else {
          assertionFailure("Error loading font")
      }

      if let fontUrl = Bundle(for: FontLoader.self).url(forResource: "Opensans-Light", withExtension: "ttf"),
         let dataProvider = CGDataProvider(url: fontUrl as CFURL),
         let newFont = CGFont(dataProvider) {
          var error: Unmanaged<CFError>?
          if !CTFontManagerRegisterGraphicsFont(newFont, &error)
              {
                  print("Error loading Font!")
          } else {
              print("Loaded font")
          }
      } else {
          assertionFailure("Error loading font")
      }

      if let fontUrl = Bundle(for: FontLoader.self).url(forResource: "Opensans-Semibold", withExtension: "ttf"),
         let dataProvider = CGDataProvider(url: fontUrl as CFURL),
         let newFont = CGFont(dataProvider) {
          var error: Unmanaged<CFError>?
          if !CTFontManagerRegisterGraphicsFont(newFont, &error)
              {
                  print("Error loading Font!")
          } else {
              print("Loaded font")
          }
      } else {
          assertionFailure("Error loading font")
      }
    }
}
