//
//  ImageProvider.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//

import SwiftUI

public class ImageProvider {
    // convenient for specific image
    public static func picture() -> UIImage {
        return UIImage(named: "picture", in: Bundle(for: self), with: nil) ?? UIImage()
    }

    // for any image located in bundle where this class has built
    public static func image(_ name: String) -> Image {
        return Image(name, bundle: Bundle(for: self))
    }
}
