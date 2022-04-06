//
//  ViewController.swift
//  nftjam
//
//  Created by Daniel Jones on 3/17/22.
//

import UIKit
import youtube_ios_player_helper
import Parse
import DCAnimationKit
import SCLAlertView

class MontageViewController: UIViewController {
    private var ytPlayerView: YTPlayerView!
    private let dataStore = MontageDataStore()
    private var thumbnailViews: [ThumbnailView] = []
    private var nftVideos: [NFTVideoParse?] = []
    private var shownNFTVideos: [NFTVideoParse?] = []
    private var timer: Timer?
    private let montage: MontageParse
    private var isMontageEnded = false
    
    init(montage: MontageParse) {
        self.montage = montage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        loadMontage()
    }
    
    private func loadMontage() {
        dataStore.loadMontage(with: montage.objectId ?? "") { result, error in
            if let nftVideos = result as? [NFTVideoParse] {
                if let firstNFTVid = nftVideos.first {
                    self.startYoutubeVid(firstNFTVid: firstNFTVid)
                    self.startTimer()
                }
                self.loadThumbnails(from: nftVideos)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "loadMontage")
            }
        }
    }
    
    private func startYoutubeVid(firstNFTVid: NFTVideoParse) {
        //This parameter causes the player to begin playing the video at the given number of seconds from the start of the video. The parameter value is a positive integer
        //parameter documentation https://developers.google.com/youtube/player_parameters
        ytPlayerView.load(withVideoId: firstNFTVid.youtubeID, playerVars: ["playsinline": "1",
                                                                 "controls" : 0, //hides controls (play button, etc.)
                                                                 "cc_load_policy": 0,
                                                                 "disablekb": 1,
                                                                 "iv_load_policy": 3,
                                                                           "start": firstNFTVid.startTimeSeconds
                                                                ])
    }
    
    private func loadThumbnails(from nftVideos: [NFTVideoParse]) {
        self.nftVideos = nftVideos
        for (index, nft) in nftVideos.enumerated() {
            if index < 4 {
                shownNFTVideos.append(nft)
            }
            
            nft.thumbnailImg?.getDataInBackground(block: { (data, error) in
                if let data = data {
                    let img = UIImage(data: data)
                    if self.thumbnailViews.indices.contains(index) && index <= 3 && index > 0 {
                        var thumbIndex = 0
                        if index == 1 {
                            thumbIndex = 2
                        } else if index == 2 {
                            thumbIndex = 1
                        }
                        
                        self.thumbnailViews[thumbIndex].thumbnailImgView.image = img
                    }
                    nftVideos[index].img = img
                } else if (error != nil) {
                    BannerAlert.show(with: error)
                } else {
                    print("error")
                }
            })
        }
        
        shownNFTVideos.reverse()
        if nftVideos.indices.contains(4) {
            shownNFTVideos.insert(nftVideos[4], at: 0)
        } else {
            shownNFTVideos.insert(nil, at: 0)
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(eventWith(timer:)),
                                     userInfo: [ "foo" : "bar" ],
                                     repeats: true)
    }
    
    // Timer expects @objc selector
    @objc func eventWith(timer: Timer!) {
        if shownNFTVideos.indices.contains(4) {
            if let nextNFT = shownNFTVideos[3], let currentShowingNFT = shownNFTVideos[4] {
                ytPlayerView.currentTime { currentTime, error in
                    let endTimeSeconds = Float(currentShowingNFT.endTimeSeconds)
                    if currentTime >= endTimeSeconds {
                        self.timer?.invalidate()
                        //cueing is better because it doesn't need to reload the iframe
                        self.ytPlayerView.cueVideo(byId: nextNFT.youtubeID,
                                                   startSeconds: Float(nextNFT.startTimeSeconds))
                        self.ytPlayerView.playVideo()
                        self.transitionThumbnails()
                    }
                }
            } else if shownNFTVideos[3] == nil {
                //when the last video of the montage is playing.
                ytPlayerView.currentTime { currentTime, error in
                    let endTimeSeconds = Float(self.shownNFTVideos[4]?.endTimeSeconds ?? 0)
                    if currentTime >= endTimeSeconds {
                        self.timer?.invalidate()
                        self.montageEnded()
                    }
                }
            }
        }
    }
    
    private func montageEnded() {
        //the end of the montage since there is no nft video left to show
        self.timer?.invalidate()
        ytPlayerView.stopVideo()
        isMontageEnded = true
        let alertView = SCLAlertView()
        alertView.addButton("Add NFT To Montage") {
            self.addButtonPressed()
        }
        alertView.showInfo("Montage Ended", subTitle: "The montage has ended. Add an NFT to the montage or return to the discover page to watch more NFT montages.")
    }
    
    private func transitionThumbnails() {
        for (index, nftVideo) in shownNFTVideos.enumerated() {
            let toImage = nftVideo?.img
            if index == 0 {
                UIView.transition(with: thumbnailViews[0].thumbnailImgView,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: { self.thumbnailViews[0].thumbnailImgView.image = toImage },
                                  completion: nil)
            } else if index == 1 {
                UIView.transition(with: thumbnailViews[1].thumbnailImgView,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: { self.thumbnailViews[1].thumbnailImgView.image = toImage },
                                  completion: nil)
            } else if index == 2 {
                //goes to the video
                UIView.transition(with: thumbnailViews[2].thumbnailImgView,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: { self.thumbnailViews[2].thumbnailImgView.image = toImage },
                                  completion: nil)
            } else if index == 3 {
                //main video
            } else if index == 4 {
                UIView.transition(with: thumbnailViews[3].thumbnailImgView,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: { self.thumbnailViews[3].thumbnailImgView.image = toImage },
                                  completion: nil)
            } else if index == 5 {
                UIView.transition(with: thumbnailViews[4].thumbnailImgView,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: { self.thumbnailViews[4].thumbnailImgView.image = toImage },
                                  completion: nil)
            } else if index == 6 {
                UIView.transition(with: thumbnailViews[5].thumbnailImgView,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: { self.thumbnailViews[5].thumbnailImgView.image = toImage },
                                  completion: nil)
            } else if index == 7 {
                shownNFTVideos.removeLast()
            }
        }
        
        let firstNFTVideo = shownNFTVideos.first
        let lastShownIndex = nftVideos.firstIndex { nftVideo in
            return firstNFTVideo??.objectId == nftVideo?.objectId
        }
        
        if let lastShownIndex = lastShownIndex {
            if nftVideos.indices.contains(lastShownIndex + 1) {
                shownNFTVideos.insert(nftVideos[lastShownIndex + 1], at: 0)
            } else {
                shownNFTVideos.insert(nil, at: 0)
            }
        } else {
            shownNFTVideos.insert(nil, at: 0)
        }
        
        startTimer()
    }
    
    @objc private func addButtonPressed() {
        let uploadVC = YoutubeUploadViewController(montage: montage)
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
        if state == .cued && !isMontageEnded {
            ytPlayerView.playVideo()
        }
    }
}

