//
//  ContentView.swift
//  LukaBluesnapSDK
//
//  Created by Jose Moran on 31/10/23.
//

import SwiftUI
import UIKit

import LukaBluesnap

struct ContentView: View {
  @StateObject var viewModel = MainViewModel()
  
    var body: some View {
      VStack {

        ForEach(0..<self.viewModel.cards.count, id: \.self) { index in
          Text("\(viewModel.cards[index].cardLast4)")
            .onTapGesture {
              viewModel.makePayment(card: viewModel.cards[index])
            }
        }

          Button(action: {
            viewModel.addCard()
          }, label: {
            Text("Press me")
          })
      }
      .task {
        viewModel.getCards()
      }
      .padding()
    }
}

class ContentViewUIController: UIHostingController<ContentView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: ContentView())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
