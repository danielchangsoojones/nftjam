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
        youtubePlayerView.load(withPlayerParams: ["playsinline": "1"])
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
            if let videoID = getIDFromYoutube(url: string) {
                youtubePlayerView.cueVideo(byId: videoID, startSeconds: 100, endSeconds: 140)
            }
            
            youtubePlayerView.isHidden = false
        }
    }
    
    private func getIDFromYoutube(url: String) -> String? {
        let isYoutubeLink = url.lowercased().contains("youtube")
        if let url = URLComponents(string: url), let queryItems = url.queryItems, isYoutubeLink {
            let videoIDItem = queryItems.first { item in
                return item.name == "v"
            }
            return videoIDItem?.value
        }
        
        return nil
    }

    private func handleTimeStamp(textField: UITextField, replacementString string: String) {
        if let text = textField.text, !string.isEmpty {
            if text.count == 1 {
                //when it just has one number
                textField.text = text + ":"
            } else if text.count == 4 {
                var textCopy = text
                textCopy.removeAll { char in
                    return char == ":"
                }
                textCopy.insert(":", at: text.index(text.startIndex, offsetBy: 2))
                textField.text = textCopy
            }
        }
    }
}
