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
    private var linkTextField: UITextField!
    private var hasLoadedYoutubeOnce = false
    
    override func loadView() {
        super.loadView()
        let ytUploadView = YoutubeUploadView(frame: self.view.frame)
        self.view = ytUploadView
        self.youtubePlayerView = ytUploadView.youtubePlayerView
        youtubePlayerView.delegate = self
        linkTextField = ytUploadView.linkTextField
        linkTextField.delegate = self
        ytUploadView.submitButton.addTarget(self,
                                            action: #selector(submitPressed(_:)),
                                            for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc private func submitPressed(_ sender: UIButton) {
        
    }
}

extension YoutubeUploadViewController: UITextFieldDelegate, YTPlayerViewDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !string.isEmpty {
            if hasLoadedYoutubeOnce {
                youtubePlayerView.cueVideo(byId: "axn4vu2tT0Y", startSeconds: 100, endSeconds: 140)
            } else {
                hasLoadedYoutubeOnce = true
                youtubePlayerView.load(withVideoId: "axn4vu2tT0Y", playerVars: ["playsinline": "1"])
            }
            youtubePlayerView.isHidden = false
        }
        
        return true
    }
}
