//
//  UploadViewController.swift
//  nftjam
//
//  Created by Daniel Jones on 3/18/22.
//

import UIKit
import youtube_ios_player_helper

class YoutubeUpload {
    static let clipDuration: Float = 15
    static var clipDurationStr: String {
        return String(Int(clipDuration))
    }
    
    let startTimeSeconds: Float
    let endTimeSeconds: Float
    let youtubeID: String
    let mediaLink: String
    let montageID: String
    var ethAddress: String = ""
    var priceToMint: Double = 0.0
    
    init(startTimeSeconds: Float, endTimeSeconds: Float, youtubeID: String, mediaLink: String, montageID: String) {
        self.startTimeSeconds = startTimeSeconds
        self.endTimeSeconds = endTimeSeconds
        self.youtubeID = youtubeID
        self.mediaLink = mediaLink
        self.montageID = montageID
    }
}

class YoutubeUploadViewController: UploadViewController {
    private var youtubePlayerView = YTPlayerView()
    private var linkTextField: UITextField!
    private var startTextField: UITextField!
    private var endTextField: UITextField!
    private var typedNums: [String] = []
    private let montageID: String
    
    private var hasLoadedFirstYoutubeVid = false
    private var timer: Timer?
    
    override var uploadView: UploadView {
        return YoutubeUploadView(frame: self.view.frame)
    }
    
    init(montageID: String) {
        self.montageID = montageID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        if let ytUploadView = self.view as? YoutubeUploadView {
            self.youtubePlayerView = ytUploadView.youtubePlayerView
            youtubePlayerView.delegate = self
            linkTextField = ytUploadView.linkTextField
            linkTextField.delegate = self
            self.startTextField = ytUploadView.startTextField
            self.endTextField = ytUploadView.endTextField
            startTextField.delegate = self
            endTextField.delegate = self
            
            //have to add tags
            linkTextField.tag = 0
            startTextField.tag = 1
            endTextField.tag = 2
        }        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //parameter documentation https://developers.google.com/youtube/player_parameters
        youtubePlayerView.load(withPlayerParams: ["playsinline": "1",
                                                  "cc_load_policy": 0,
                                                  "controls" : 0,
                                                  "disablekb": 1,
                                                  "iv_load_policy": 3])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    override func submit() {
        if let youtubeLink = linkTextField.text, let startTime = startTextField.text {
            let startTimeSeconds = convertTimeStrToSeconds(timeStr: startTime)
            let endTimeSeconds = (startTimeSeconds ?? 0) + YoutubeUpload.clipDuration
            let youtubeID = getIDFromYoutube(link: youtubeLink)
            let youtubeUpload = YoutubeUpload(startTimeSeconds: startTimeSeconds ?? 0,
                                              endTimeSeconds: endTimeSeconds ,
                                              youtubeID: youtubeID ?? "",
                                              mediaLink: youtubeLink,
                                              montageID: montageID)
            let ethAddressVC = EthAddressViewController(youtubeUpload: youtubeUpload)
            self.navigationController?.pushViewController(ethAddressVC, animated: true)
        }
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
                if hasLoadedFirstYoutubeVid {
                    youtubePlayerView.cueVideo(byId: videoID, startSeconds: 0)
                    startTimer()
                } else {
                    youtubePlayerView.load(withVideoId: videoID, playerVars: ["playsinline": "1",
//                                                                             "controls" : 0, //hides controls (play button, etc.)
                                                                             "cc_load_policy": 0,
                                                                             "disablekb": 1,
                                                                             "iv_load_policy": 3,
                                                                                       "start": 0
                                                                            ])
                    
                    startTimer()
                }
            }
            
            youtubePlayerView.isHidden = false
        }
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(self.timerFinished),
                                         userInfo: nil,
                                         repeats: true)
    }
    
    @objc private func timerFinished() {
        if let startText = startTextField.text {
            youtubePlayerView.currentTime { currentTime, error in
                let startTimeSeconds = self.convertTimeStrToSeconds(timeStr: startText) ?? 0.0
                let timeDifference = currentTime - startTimeSeconds
                if timeDifference >= YoutubeUpload.clipDuration {
                    self.youtubePlayerView.pauseVideo()
                    self.youtubePlayerView.seek(toSeconds: startTimeSeconds, allowSeekAhead: true)
                    self.timer?.invalidate()
                    self.timer = nil
                }
            }
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
            startTimer()
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
    
    private func updateEndTimeStamp(totalSecondsFloat: Float) {
        let additionalClipTime: Double = Double(YoutubeUpload.clipDuration)
        let totalSeconds = Double(totalSecondsFloat) + additionalClipTime
        let minutes = Int(floor(totalSeconds / 60))
        let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
        let str = "\(minutes):\(seconds)"
        endTextField.text = str
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        switch state {
        case .playing:
            if timer == nil {
                startTimer()
            }
        default:
            print("hey")
        }
    }
}
