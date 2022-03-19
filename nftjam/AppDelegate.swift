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
        setStartingVC()
        return true
    }
    
    private func setStartingVC() {
        let vc = YoutubeUploadViewController()
        let navController = UINavigationController(rootViewController: vc)
        set(startingVC: navController)
    }
    
    private func set(startingVC: UIViewController) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = startingVC
        self.window?.makeKeyAndVisible()
    }
}

