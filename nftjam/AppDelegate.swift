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
            let query = MontageParse.query() as! PFQuery<MontageParse>
            query.getFirstObjectInBackground { montage, error in
                if let montage = montage {
                    let youtubeUpload = YoutubeUpload(startTimeSeconds: 10, endTimeSeconds: 30, youtubeID: "zPG1n1B0Ydw", mediaLink: "https://www.youtube.com/watch?v=zPG1n1B0Ydw", montage: montage, thumbnailFile: montage.ethAddressQR)
                    let vc = SendEthViewController(youtubeUpload: youtubeUpload)
                    let navController = UINavigationController(rootViewController: vc)
                    self.set(startingVC: navController)
                } else if let error = error {
                    BannerAlert.show(with: error)
                } else {
                    BannerAlert.showUnknownError(functionName: "error")
                }
            }
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

