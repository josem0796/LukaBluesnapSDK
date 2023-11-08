//
//  UIApplication+Extensions.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 2/11/23.
//

import UIKit

extension UIApplication {
    class func getMainViewController() -> UINavigationController? {
        if #available(iOS 13.0, *) {
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
              return scene.windows.first?.rootViewController as? UINavigationController
            }
        } else {
            return UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
        }
        return nil  
    }
}
