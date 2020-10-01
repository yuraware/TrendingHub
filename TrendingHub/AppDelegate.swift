//
//  AppDelegate.swift
//  TrendingHub
//
//  Created by Yurii Kobets on 9/21/20.
//  Copyright © 2020 Helloworld Association. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let appDIContainer = AppDIContainer()
    var appFlowCoordinator: AppFlowCoordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupStyles()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController

        appFlowCoordinator = AppFlowCoordinator(navigationController: navigationController, dependencies: appDIContainer)
        appFlowCoordinator?.start()
        window?.makeKeyAndVisible()

        return true
    }

    //MARK: - Private
    
    private func setupStyles() {
        let grayColor = UIColor(red: 102.0/255.0, green: 124.0/255.0, blue: 137.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : grayColor]
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
         UINavigationBar.appearance().tintColor = grayColor
    }

}

