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
        //parameter documentation https://developers.google.com/youtube/player_parameters
        youtubePlayerView.load(withPlayerParams: ["playsinline": "1",
                                                  "cc_load_policy": 0,
                                                  "disablekb": 1,
                                                  "iv_load_policy": 3])
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
                youtubePlayerView.cueVideo(byId: videoID, startSeconds: 0)
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
                let newText = text + ":"
                textField.text = newText
            } else if text.count == 3 {
                let finalText = text + string
                if let totalSeconds = convertTimeStrToSeconds(timeStr: finalText) {
                    youtubePlayerView.seek(toSeconds: totalSeconds, allowSeekAhead: true)
                }
            } else if text.count == 4 {
                var newText = text
                newText.removeAll { char in
                    return char == ":"
                }
                newText.insert(":", at: text.index(text.startIndex, offsetBy: 2))
                textField.text = newText

                let finalText = newText + string
                if let totalSeconds = convertTimeStrToSeconds(timeStr: finalText) {
                    youtubePlayerView.seek(toSeconds: totalSeconds, allowSeekAhead: true)
                }
            }
        }
    }
    
    private func convertTimeStrToSeconds(timeStr: String) -> Float? {
        let components = timeStr.components(separatedBy: ":")
        if components.count == 2, let minutes = Float(components[0]), let seconds = Float(components[1]) {
            if seconds > 60 {
                //sometimes they might type 84, so they can get to 58:40
                //so that means the seconds are not ready to calculate yet
                return nil
            } else {
                let totalSeconds = minutes * 60 + seconds
                return totalSeconds
            }
        }
        
        return nil
    }
}
