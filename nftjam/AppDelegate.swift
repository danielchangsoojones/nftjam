//
//  AppDelegate.swift
//  nftjam
//
//  Created by Daniel Jones on 3/17/22.
//

import UIKit
import Parse

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setUpServer()
        setStartingVC()
        return true
    }
    
    private func setStartingVC() {
        if User.current() != nil {
            let vc = MontageViewController()
            let navController = UINavigationController(rootViewController: vc)
            set(startingVC: navController)
        } else {
            let welcomeVC = WelcomeViewController()
            let navController = UINavigationController(rootViewController: welcomeVC)
            set(startingVC: navController)
        }
    }
    
    private func set(startingVC: UIViewController) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = startingVC
        self.window?.makeKeyAndVisible()
    }
    
    private func setUpServer() {
        let configuration = ParseClientConfiguration {
            $0.applicationId = Configuration.environment.appID
            $0.server = Configuration.environment.serverURL
        }
        Parse.initialize(with: configuration)
        
        User.registerSubclass()
        NFTVideoParse.registerSubclass()
        MontageParse.registerSubclass()
    }
}

