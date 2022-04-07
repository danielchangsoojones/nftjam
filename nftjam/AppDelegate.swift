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
    
    //set orientations you want to be allowed in this property by default
    var orientationLock = UIInterfaceOrientationMask.portrait

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    
    private func setStartingVC() {
        if User.current() != nil {
            let query = MontageParse.query() as! PFQuery<MontageParse>
            query.getFirstObjectInBackground { montageParse, error in
                if let montageParse = montageParse {
                    let youtubeUpload = YoutubeUpload(startTimeSeconds: 0, endTimeSeconds: 0, youtubeID: "hi", mediaLink: "hi", montage: montageParse, thumbnailFile: montageParse.ethAddressQR)
                    let vc = PaymentOptionViewController(youtubeUpload: youtubeUpload)
                    let navController = UINavigationController(rootViewController: vc)
                    self.set(startingVC: navController)
                }
            }
//            let vc = DiscoverViewController()
//            let navController = UINavigationController(rootViewController: vc)
//            set(startingVC: navController)
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

