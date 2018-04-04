//
//  AppDelegate.swift
//  ChuckNorrisFacts
//
//  Created by Mariana Meireles | Stone on 14/03/18.
//  Copyright © 2018 Mariana Meireles | Stone. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let injector = Injector(with: CommandLine.arguments, and: ProcessInfo.processInfo)
        let initialViewController = InitialViewController(withViewModel: injector.viewModel())
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = UINavigationController(rootViewController: initialViewController)
        window?.makeKeyAndVisible()
        
        return true
    }


}

