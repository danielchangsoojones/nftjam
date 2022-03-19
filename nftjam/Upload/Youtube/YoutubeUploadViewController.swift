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
    
    override func loadView() {
        super.loadView()
        let ytUploadView = YoutubeUploadView(frame: self.view.frame)
        self.view = ytUploadView
        self.youtubePlayerView = ytUploadView.youtubePlayerView
        linkTextField = ytUploadView.linkTextField
        linkTextField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}

extension YoutubeUploadViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !string.isEmpty {
            youtubePlayerView.load(withVideoId: "axn4vu2tT0Y", playerVars: ["playsinline": "1"])
            youtubePlayerView.isHidden = false
        }
        
        return true
    }
}
