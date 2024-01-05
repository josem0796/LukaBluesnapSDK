//
//  LukaBluensnapMainView.swift
//  LukaBluesnap
//
//  Created by Jose Moran on 2/11/23.
//

import SwiftUI
import UIKit

struct LukaBluesnapView: View {
  @StateObject var viewModel: LukaBluesnapViewModel = .init()
  @Environment(\.presentationMode) var presentationMode

  var body: some View {
    VStack {
      ZStack {
        HStack {
          ImageProvider.image(Images.ARROW_LEFT)
            .resize(width: 24, height: 24)
            .padding(.trailing, 24)
            .onTapGesture {
              presentationMode.wrappedValue.dismiss()
            }

          Spacer()
        }

        HStack {
          Spacer()

          TextProvider.text(Strings.card_details.localized())
            .font(.system(size: 20))

          Spacer()
        }
      }


      cardDetailsView

      Spacer()

      Button(action: {
        switch viewModel.btnState {
        case .enabled:
          viewModel.addCard()
        default:
          break
        }

      }) {
        switch viewModel.btnState {
            case .loading:
              VStack {
                LoaderView()
                  .frame(width: 24, height: 24)
              }
            default:
              TextProvider.text(Strings.add.localized())
                    .foregroundColor(.white)
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
      }.foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: 50)
        .background( viewModel.btnState == .disabled ? Color.grayText : Color.primaryBlue )
        .disabled(viewModel.btnState == .disabled)
        .cornerRadius(8)
        .padding(.vertical, 12)
    }
    .padding(.top, 12)
    .padding(.horizontal, 24)
    .customAlert(isPresented: viewModel.errorMsgKey != .none) {
      AlertDialog(
        title: StringProvider.nsStringLocalized(viewModel.errorMsgKey.rawValue),
        onAccept: {
          viewModel.errorMsgKey = .none
        }
      )
    }
    .navigationBarHidden(true)

  }

  var cardDetailsView: some View {
    VStack(alignment: .leading) {
      TextProvider.text(Strings.enter_card_details.localized())
        .font(.system(size: 16))

      VStack(alignment: .leading) {
        TextProvider.text(Strings.card_number.localized())
          .font(.system(size: 12))
          .padding(.top, 24)
        CardNumberInput(value: $viewModel.bsCard.cardNumber)
          .inputStyle()
      }

      VStack(alignment: .leading) {
        TextProvider.text(Strings.name.localized())
          .font(.system(size: 12))
        TextField("", text: $viewModel.bsCard.cardHolderName, prompt: TextProvider.text(Strings.cardholder_name.localized()))
          .inputStyle()
      }

      HStack {
        VStack(alignment: .leading) {
          TextProvider.text(Strings.expiry_date.localized())
            .font(.system(size: 12))
          ExpiryDateInput(value: $viewModel.bsCard.expiryDate)
            .inputStyle()
        }

        VStack(alignment: .leading) {
          TextProvider.text(Strings.cvv.localized())
            .font(.system(size: 12))
          CVVInput(value: $viewModel.bsCard.cardCvv)
            .inputStyle()
        }
      }
    }
    .padding(.vertical, 12)
  }
}

class LukaBluesnapUIController: UIHostingController<LukaBluesnapView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: LukaBluesnapView())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LukaBluesnapView()
    }
}
