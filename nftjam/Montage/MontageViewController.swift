//
//  ViewController.swift
//  nftjam
//
//  Created by Daniel Jones on 3/17/22.
//

import UIKit
import youtube_ios_player_helper

class MontageViewController: UIViewController, YTPlayerViewDelegate {
    private var ytPlayerView: YTPlayerView!
    private let videoIDs = ["yzTuBuRdAyA", "TUVcZfQe-Kw", "vRXZj0DzXIA", "QYh6mYIJG2Y", "CTFtOOh47oo", "e2AeKIzfQus", "l0U7SxXHkPY", "yzTuBuRdAyA", "TUVcZfQe-Kw", "vRXZj0DzXIA", "QYh6mYIJG2Y", "CTFtOOh47oo", "e2AeKIzfQus", "l0U7SxXHkPY", "yzTuBuRdAyA", "TUVcZfQe-Kw", "vRXZj0DzXIA", "QYh6mYIJG2Y", "CTFtOOh47oo", "e2AeKIzfQus", "l0U7SxXHkPY", "yzTuBuRdAyA", "TUVcZfQe-Kw", "vRXZj0DzXIA", "QYh6mYIJG2Y", "CTFtOOh47oo", "e2AeKIzfQus", "l0U7SxXHkPY"]
    
//    private let videoIDs = ["XQOGbAVMeB4", "BzqybOt0Ics", "AKU2u1Aj96w", "EHPX2IYbH2k", "XQOGbAVMeB4", "BzqybOt0Ics", "AKU2u1Aj96w", "EHPX2IYbH2k", "XQOGbAVMeB4", "BzqybOt0Ics", "AKU2u1Aj96w", "EHPX2IYbH2k", "XQOGbAVMeB4", "BzqybOt0Ics", "AKU2u1Aj96w", "EHPX2IYbH2k", "XQOGbAVMeB4", "BzqybOt0Ics", "AKU2u1Aj96w", "EHPX2IYbH2k"]
    
    override func loadView() {
        super.loadView()
        let montageView = MontageView(frame: self.view.frame)
        self.view = montageView
        ytPlayerView = montageView.youtubePlayerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let blue = UIColor(red: 68.0 / 255, green: 64.0 / 255, blue: 175.0 / 255, alpha: 1)
        self.view.backgroundColor = blue
        
        ytPlayerView.delegate = self
        
        ytPlayerView.load(withVideoId: videoIDs[0], playerVars: ["playsinline": "1"])
        startTimer()
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        ytPlayerView.playVideo()
    }
    
    var timer: Timer?
    var num = 1
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 15.0,
                                     target: self,
                                     selector: #selector(eventWith(timer:)),
                                     userInfo: [ "foo" : "bar" ],
                                     repeats: true)
    }
    
    // Timer expects @objc selector
    @objc func eventWith(timer: Timer!) {
        let videoID = videoIDs[num]
        num += 1
        ytPlayerView.load(withVideoId: videoID, playerVars: ["playsinline": "1"])
    }
    
    func playerViewPreferredWebViewBackgroundColor(_ playerView: YTPlayerView) -> UIColor {
        return .clear
    }
}

