//
//  AlertDialog.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 8/11/23.
//

import SwiftUI

struct AlertDialog<Content: View>: View {

  let title: String
  let acceptBtnLabel: () -> Content
  var cancelBtnLabel: (() -> Content)? = nil
  let onAccept : () -> Void
  var onCancel : (() -> Void)? = nil

  init(
    title: String ,
    acceptBtnLabel: @escaping () -> Content = {
      TextProvider.text(Strings.accept.localized())
        .customFont(.semiBold, size: 16)
    },
    cancelBtnLabel: @escaping () -> Content = {
      TextProvider.text(Strings.cancel.localized())
        .customFont(.semiBold, size: 16)
    },
    onAccept: @escaping () -> Void = {},
    onCancel: (() -> Void)? = nil
  ) {
    self.title = title
    self.acceptBtnLabel = acceptBtnLabel
    self.cancelBtnLabel = cancelBtnLabel
    self.onAccept = onAccept
    self.onCancel = onCancel
  }

  init(
    title: String,
    acceptBtnLabel: @escaping () -> Content = {
      TextProvider.text(Strings.accept.localized())
        .customFont(.semiBold, size: 16)
    },
    onAccept: @escaping () -> Void = {}
  ) {
    self.title = title
    self.acceptBtnLabel = acceptBtnLabel
    self.cancelBtnLabel = nil
    self.onAccept = onAccept
    self.onCancel = nil
  }


  var body: some View {
    ZStack(alignment: .center) {
      Color(.gray)
        .opacity(0.5)
        .ignoresSafeArea()

      Rectangle()
        .fill(.white)
        .frame(width: 300, height: 150)
        .cornerRadius(15)
        .overlay(
          VStack {
            Text(title)
              .multilineTextAlignment(.center)
              .customFont(.semiBold, size: 16)

              .padding(.vertical, 8)
            HStack {
              Button(action: {
                withAnimation(.easeInOut) {
                  onAccept()
                }
              }) {
                acceptBtnLabel()
              }.foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: 45)
                .background( Color.primaryBlue )
                .cornerRadius(8)
                .padding(.vertical, 12)

              if cancelBtnLabel != nil {
                Button(action: {
                  withAnimation(.easeInOut) {
                    onCancel?()
                  }
                }) {
                  cancelBtnLabel?()
                }.foregroundColor(.white)
                  .frame(maxWidth: .infinity, maxHeight: 45)
                  .background(Color.primaryBlue )
                  .cornerRadius(8)
                  .padding(.vertical, 12)
              }


            }
          }.padding(.horizontal, 24)
        )
        .padding(24)

    }

  }
}

extension View {
  @ViewBuilder func customAlert(isPresented: Bool, _ content: () -> some View ) -> some View {
    ZStack {
      self

      if isPresented {
        content()
      }

    }
  }
}

struct AlertDialog_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
