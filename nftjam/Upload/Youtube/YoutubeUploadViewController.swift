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
    private var startTextField: UITextField!
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
        self.startTextField = ytUploadView.startTextField
        startTextField.delegate = self
        ytUploadView.endTextField.delegate = self
        
        //have to add tags
        linkTextField.tag = 0
        startTextField.tag = 1
        ytUploadView.endTextField.tag = 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc private func submitPressed(_ sender: UIButton) {
        
    }
}

extension YoutubeUploadViewController: UITextFieldDelegate, YTPlayerViewDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 0 {
            handleMediaLinkTextField(replacementString: string)
        } else {
            let textCount = textField.text?.count ?? 0
            if textCount == 5  && !string.isEmpty {
                return false
            } else {
                handleTimeStamp(textField: textField,
                                replacementString: string)
            }
        }
        
        return true
    }
    
    private func handleMediaLinkTextField(replacementString string: String) {
        if !string.isEmpty {
            if hasLoadedYoutubeOnce {
                youtubePlayerView.cueVideo(byId: "axn4vu2tT0Y", startSeconds: 100, endSeconds: 140)
            } else {
                hasLoadedYoutubeOnce = true
                youtubePlayerView.load(withVideoId: "axn4vu2tT0Y", playerVars: ["playsinline": "1"])
            }
            youtubePlayerView.isHidden = false
        }
    }

    private func handleTimeStamp(textField: UITextField, replacementString string: String) {
        if let text = textField.text, text.count == 2, !string.isEmpty {
            textField.text = text + ":"
        }
    }
}
