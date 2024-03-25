//
//  AppDelegate.swift
//  LukaBluesnapSDK
//
//  Created by Jose Moran on 2/11/23.
//

import UIKit
import SwiftUI
import LukaBluesnap

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  override init() {
    LukaBluesnapSdk
      .setUpConfig(
        config: Config(env: .sandbox, creds: Config.SdkCredentials(username: "payco", password: "12345678")),
        callbacks: ConfigCallbacksImpl()
      )
  }

  class ConfigCallbacksImpl: ConfigCallbacks {
    func onSuccess() {
      print("success")
    }

    func onError() {
      print("error")
    }
  }


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    if connectingSceneSession.role ==
          UISceneSession.Role.windowApplication {
          let config = UISceneConfiguration(
              name: nil,
             sessionRole: connectingSceneSession.role
          )
          config.delegateClass = SceneDelegate.self
          return config
      }
      fatalError("Unhandled scene role \(connectingSceneSession.role)")
  }

}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    window?.windowScene = windowScene
    let hostingController = UIHostingController(rootView: ContentView())
    let navigationController = UINavigationController(rootViewController: hostingController)
    navigationController.setNavigationBarHidden(true, animated: false)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }

}
