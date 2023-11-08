//
//  LoaderView.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 5/11/23.
//

import SwiftUI

struct LoaderView: View {
  var color: Color = .white
  var opacity : CGFloat = 0.5
  var duration : CGFloat = Constants.ANIMATION_DURATION

  @State private var angle : CGFloat = 0

  var body: some View {
    Arc(rotationAngle: angle)
        .foregroundColor(color)
        .opacity(opacity)
        .animation(.linear(duration: duration), value: angle)
        .task {
          animate()
        }
  }

  func animate() {
    angle = (angle + 1).truncatingRemainder(dividingBy: Constants.MAX_ROTATION_ANGLES)
    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
      animate()
    }
  }

}

extension LoaderView {
  class Constants {
    static let MAX_ROTATION_ANGLES : CGFloat = 361
    static let ANIMATION_DURATION = 0.003
  }
}

struct Arc: Shape {
  let rotationAngle : CGFloat
  var openingAngle : CGFloat = 90
  var lineWidth : CGFloat? = nil
  var centerPoint : CGPoint? = nil
  var clockwise : Bool = true

  func path(in rect: CGRect) -> Path {
    let radius = min(rect.height*0.5, rect.width*0.5)
    let width = lineWidth ?? radius*0.3
    let center = centerPoint ?? CGPoint(x: rect.width*0.5, y: rect.height*0.5)
    return Path { path in
      path.addArc(
        center: center,
        radius: radius,
        startAngle: .degrees(rotationAngle - openingAngle),
        endAngle: .degrees(rotationAngle),
        clockwise: clockwise
      )
    }.strokedPath(.init(lineWidth: width))
  }
}

struct LoaderView_Previews: PreviewProvider {
  static var previews: some View {
      LoaderView()
  }
}
