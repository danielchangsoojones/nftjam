//
//  ViewController.swift
//  nftjam
//
//  Created by Daniel Jones on 3/17/22.
//

import UIKit
import youtube_ios_player_helper
import Parse

class MontageViewController: UIViewController {
    private var ytPlayerView: YTPlayerView!
    private let videoIDs = ["yzTuBuRdAyA", "TUVcZfQe-Kw", "vRXZj0DzXIA", "QYh6mYIJG2Y", "CTFtOOh47oo", "e2AeKIzfQus", "l0U7SxXHkPY", "yzTuBuRdAyA", "TUVcZfQe-Kw", "vRXZj0DzXIA", "QYh6mYIJG2Y", "CTFtOOh47oo", "e2AeKIzfQus", "l0U7SxXHkPY", "yzTuBuRdAyA", "TUVcZfQe-Kw", "vRXZj0DzXIA", "QYh6mYIJG2Y", "CTFtOOh47oo", "e2AeKIzfQus", "l0U7SxXHkPY", "yzTuBuRdAyA", "TUVcZfQe-Kw", "vRXZj0DzXIA", "QYh6mYIJG2Y", "CTFtOOh47oo", "e2AeKIzfQus", "l0U7SxXHkPY"]
    private let dataStore = MontageDataStore()
    private var thumbnailViews: [ThumbnailView] = []
    
//    private let videoIDs = ["XQOGbAVMeB4", "BzqybOt0Ics", "AKU2u1Aj96w", "EHPX2IYbH2k", "XQOGbAVMeB4", "BzqybOt0Ics", "AKU2u1Aj96w", "EHPX2IYbH2k", "XQOGbAVMeB4", "BzqybOt0Ics", "AKU2u1Aj96w", "EHPX2IYbH2k", "XQOGbAVMeB4", "BzqybOt0Ics", "AKU2u1Aj96w", "EHPX2IYbH2k", "XQOGbAVMeB4", "BzqybOt0Ics", "AKU2u1Aj96w", "EHPX2IYbH2k"]
    
    override func loadView() {
        super.loadView()
        let montageView = MontageView(frame: self.view.frame)
        self.view = montageView
        ytPlayerView = montageView.youtubePlayerView
        montageView.addButton.addTarget(self,
                                        action: #selector(addButtonPressed),
                                        for: .touchUpInside)
        thumbnailViews = montageView.thumbnailViews
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let blue = UIColor(red: 68.0 / 255, green: 64.0 / 255, blue: 175.0 / 255, alpha: 1)
        self.view.backgroundColor = blue
        ytPlayerView.delegate = self
        
        //This parameter causes the player to begin playing the video at the given number of seconds from the start of the video. The parameter value is a positive integer
        //parameter documentation https://developers.google.com/youtube/player_parameters
        let startTimeSec = 100
        ytPlayerView.load(withVideoId: videoIDs[0], playerVars: ["playsinline": "1",
                                                                 "controls" : 0, //hides controls (play button, etc.)
                                                                 "cc_load_policy": 0,
                                                                 "disablekb": 1,
                                                                 "iv_load_policy": 3,
                                                                 "start": startTimeSec
                                                                ])
        startTimer()
        loadMontage()
    }
    
    private func loadMontage() {
        dataStore.loadMontage(with: "KdQrmr0tBW") { result, error in
            if let nftVideos = result as? [NFTVideoParse] {
                self.loadThumbnails(from: nftVideos)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "loadMontage")
            }
        }
    }
    
    private func loadThumbnails(from nftVideos: [NFTVideoParse]) {
        for (index, nft) in nftVideos.enumerated() {
            if thumbnailViews.indices.contains(index) && index <= 3 && index > 0 {
                var thumbIndex = 0
                if index == 1 {
                    thumbIndex = 2
                } else if index == 2{
                    thumbIndex = 1
                }
                
                nft.thumbnailImg?.getDataInBackground(block: { (data, error) in
                    if let data = data {
                        let img = UIImage(data: data)
                        self.thumbnailViews[thumbIndex].thumbnailImgView.image = img
                    } else if (error != nil) {
                        BannerAlert.show(with: error)
                    } else {
                        print("error")
                    }
                })
            }
        }
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
        //cueing is better because it doesn't need to reload the iframe
        ytPlayerView.cueVideo(byId: videoID, startSeconds: 0)
        ytPlayerView.playVideo()
    }
    
    @objc private func addButtonPressed() {
        let uploadVC = YoutubeUploadViewController(montageID: "KdQrmr0tBW")
        let navController = UINavigationController(rootViewController: uploadVC)
        present(navController, animated: true)
    }
}

extension MontageViewController: YTPlayerViewDelegate {
    func playerViewPreferredWebViewBackgroundColor(_ playerView: YTPlayerView) -> UIColor {
        return .clear
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        ytPlayerView.playVideo()
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        if state == .cued {
            ytPlayerView.playVideo()
        }
    }
}

