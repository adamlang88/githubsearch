//
//  AppDelegate.swift
//  GitHubSearch
//
//  Created by Lang Ádám on 2021. 08. 28..
//

import UIKit
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController : UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let searchController = Injector.resolve(SearchViewController.self)!
        navigationController = UINavigationController(rootViewController: searchController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }

}

