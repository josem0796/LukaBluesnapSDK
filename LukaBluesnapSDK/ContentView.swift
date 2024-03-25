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

          Button(action: {
            viewModel.checkTransaction(traceId: "65fc7f3fb2202728ecd59d18")
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
