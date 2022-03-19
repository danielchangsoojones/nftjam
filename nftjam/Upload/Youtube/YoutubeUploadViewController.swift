//
//  UploadViewController.swift
//  nftjam
//
//  Created by Daniel Jones on 3/18/22.
//

import UIKit
import youtube_ios_player_helper

class YoutubeUploadViewController: UIViewController {
    private var youtubePlayerView = YTPlayerView()
    
    override func loadView() {
        super.loadView()
        let ytUploadView = YoutubeUploadView(frame: self.view.frame)
        self.view = ytUploadView
        self.youtubePlayerView = ytUploadView.youtubePlayerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        youtubePlayerView.load(withVideoId: "axn4vu2tT0Y", playerVars: ["playsinline": "1"])
    }
    
    
}
