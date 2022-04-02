//
//  UploadView.swift
//  nftjam
//
//  Created by Daniel Jones on 3/18/22.
//

import UIKit
import TextFieldEffects
import youtube_ios_player_helper

class YoutubeUploadView: UploadView {
    let linkTextField = HoshiTextField()
    private let startStampContainer = UIView()
    private let endStampContainer = UIView()
    let startTextField = UITextField()
    let endTextField = UITextField()
    let youtubePlayerView = YTPlayerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.spaceGray
        titleLabel.text = "Choose \(YoutubeUpload.clipDurationStr) seconds of a youtube clip"
        setLinkTextField()
        setTimeStamps()
        youtubePlayerView.isHidden = true
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setConstraints() {
        super.setConstraints()
        addSubview(linkTextField)
        addSubview(startStampContainer)
        addSubview(endStampContainer)
        addSubview(youtubePlayerView)
        addSubview(submitButton)
        
        linkTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.height.equalTo(60)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        startStampContainer.snp.makeConstraints { make in
            make.leading.equalTo(linkTextField)
            make.top.equalTo(linkTextField.snp.bottom).offset(35)
        }
        
        endStampContainer.snp.makeConstraints { make in
            make.trailing.equalTo(linkTextField)
            make.bottom.equalTo(startStampContainer)
        }
        
        youtubePlayerView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(startStampContainer.snp.bottom).offset(10)
            make.height.equalTo(280)
        }
    }
    
    private func setLinkTextField() {
        linkTextField.font = UIFont.systemFont(ofSize: 30, weight: .light)
        linkTextField.placeholderColor = UIColor.white.withAlphaComponent(0.8)
        linkTextField.borderActiveColor = .white
        linkTextField.borderInactiveColor = UIColor.white.withAlphaComponent(0.5)
        linkTextField.textColor = .white
        linkTextField.autocorrectionType = .no
        linkTextField.autocapitalizationType = .none
        linkTextField.spellCheckingType = .no
        linkTextField.clearButtonMode = .whileEditing
        linkTextField.placeholder = "Paste a youtube link"
    }
    
    private func setTimeStamps() {
        setTimeStampContainer(title: "Start:",
                              containerView: startStampContainer,
                              placeholder: "00:00",
                              textField: startTextField,
                              shouldEnable: true)
        
        setTimeStampContainer(title: "End:",
                              containerView: endStampContainer,
                              placeholder: "00:\(YoutubeUpload.clipDurationStr)",
                              textField: endTextField,
                              shouldEnable: false)
    }
    
    private func setTimeStampContainer(title: String, containerView: UIView, placeholder: String, textField: UITextField, shouldEnable: Bool) {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .light)
        label.textColor = .white
        label.text = title
        containerView.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        textField.keyboardType = .numberPad
        textField.tintColor = .white
        textField.textColor = .white
        textField.font = UIFont.systemFont(ofSize: 20, weight: .light)
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1.0
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        textField.isEnabled = shouldEnable
        containerView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.leading.equalTo(label.snp.trailing).offset(5)
            make.trailing.equalToSuperview()
            make.width.equalTo(77)
            make.bottom.equalTo(label)
        }
    }
}
