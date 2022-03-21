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
    private var endTextField: UITextField!
    private var typedNums: [String] = []
    
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
        self.endTextField = ytUploadView.endTextField
        startTextField.delegate = self
        endTextField.delegate = self
        
        //have to add tags
        linkTextField.tag = 0
        startTextField.tag = 1
        endTextField.tag = 2
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
            if !string.isEmpty {
                typedNums.append(string)
            }
            
            if string.isEmpty && !typedNums.isEmpty {
                //user just backspaced when replacement string is empty
                typedNums.removeLast()
            } else if typedNums.count > 4 {
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
            if let videoID = getIDFromYoutube(link: string) {
                youtubePlayerView.cueVideo(byId: videoID, startSeconds: 0)
            }
            
            youtubePlayerView.isHidden = false
        }
    }
    
    private func getIDFromYoutube(link: String) -> String? {
        if let url = URLComponents(string: link) {
            //when you copy on iOS youtube app on a phone, it gives this weird youtube url
            let isYoutubeAppShareLink = link.lowercased().contains("youtu.be")
            let isWebYoutubeLink = link.lowercased().contains("youtube.com/watch?v=")
            if isYoutubeAppShareLink {
                //the path starts with a backslash
                var pathCopy = url.path
                pathCopy.removeAll { char in
                    return char == "/"
                }
                return pathCopy
            } else if let queryItems = url.queryItems, isWebYoutubeLink {
                let videoIDItem = queryItems.first { item in
                    return item.name == "v"
                }
                return videoIDItem?.value
            }
        }
        
        return nil
    }

    private func handleTimeStamp(textField: UITextField, replacementString string: String) {
        if typedNums.count == 1 {
            textField.text = "00:0"
        } else if typedNums.count == 2 {
            textField.text = "00:\(typedNums[0])"
        } else if typedNums.count == 3 {
            textField.text = "0\(typedNums[0]):\(typedNums[1])"
        } else if typedNums.count == 4 {
            textField.text = "\(typedNums[0])\(typedNums[1]):\(typedNums[2])"
        }
        
        let finalText = (textField.text ?? "") + string
        if let totalSeconds = convertTimeStrToSeconds(timeStr: finalText) {
            youtubePlayerView.seek(toSeconds: totalSeconds, allowSeekAhead: true)
            updateEndTimeStamp(totalSecondsFloat: totalSeconds)
        }
        
        
        
        
//        if (textField.text?.isEmpty ?? true) {
//            //the first typed number. Format for 1 seconds = 00:01
//            textField.text = "00:0"
//        } else if var text = textField.text, !string.isEmpty {
//            if text.count == 1 {
//                //when it just has one number
//                text.removeAll { char in
//                    return char == "0" || char == ":"
//                }
//                let newText = "00:\(text)"
////                let newText = "00:\(text) + ":"
//                textField.text = newText
//
//            } else if text.count == 3 {
//                let finalText = text + string
//                if let totalSeconds = convertTimeStrToSeconds(timeStr: finalText) {
//                    youtubePlayerView.seek(toSeconds: totalSeconds, allowSeekAhead: true)
//                    updateEndTimeStamp(totalSecondsFloat: totalSeconds)
//                }
//            } else if text.count == 4 {
//                var newText = text
//                newText.removeAll { char in
//                    return char == ":"
//                }
//                newText.insert(":", at: text.index(text.startIndex, offsetBy: 2))
//                textField.text = newText
//
//                let finalText = newText + string
//                if let totalSeconds = convertTimeStrToSeconds(timeStr: finalText) {
//                    youtubePlayerView.seek(toSeconds: totalSeconds, allowSeekAhead: true)
//                    updateEndTimeStamp(totalSecondsFloat: totalSeconds)
//                }
//            }
//        }
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
    
    private func updateEndTimeStamp(totalSecondsFloat: Float) {
        let additionalClipTime: Double = 20
        let totalSeconds = Double(totalSecondsFloat) + additionalClipTime
        let minutes = Int(floor(totalSeconds / 60))
        let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
        let str = "\(minutes):\(seconds)"
        endTextField.text = str
    }
}
