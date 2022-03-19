//
//  UploadView.swift
//  nftjam
//
//  Created by Daniel Jones on 3/18/22.
//

import UIKit
import TextFieldEffects
import youtube_ios_player_helper

class YoutubeUploadView: UIView {
    let linkTextField = HoshiTextField()
    let clipTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Choose 20 seconds of a youtube clip"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    private let startStampContainer = UIView()
    private let endStampContainer = UIView()
    let startTextField = UITextField()
    let endTextField = UITextField()
    let youtubePlayerView = YTPlayerView()
    let submitButton = CustomButton(title: "Add NFT Clip to Montage")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.spaceGray
        setLinkTextField()
        setTimeStamps()
        youtubePlayerView.isHidden = true
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        addSubview(clipTimeLabel)
        addSubview(startStampContainer)
        addSubview(endStampContainer)
        addSubview(youtubePlayerView)
        addSubview(submitButton)
        
        clipTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.topMargin)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        linkTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(clipTimeLabel)
            make.height.equalTo(60)
            make.top.equalTo(clipTimeLabel.snp.bottom).offset(10)
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
            make.leading.trailing.equalTo(clipTimeLabel)
            make.top.equalTo(startStampContainer.snp.bottom).offset(10)
            make.height.equalTo(300)
        }
        
        submitButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(clipTimeLabel)
            make.bottom.equalTo(self.snp.bottomMargin)
            make.height.equalTo(53)
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
        linkTextField.placeholder = "Paste a youtube link"
        addSubview(linkTextField)
    }
    
    private func setTimeStamps() {
        setTimeStampContainer(title: "Start:",
                              containerView: startStampContainer,
                              placeholder: "00:00",
                              textField: startTextField)
        
        setTimeStampContainer(title: "End:",
                              containerView: endStampContainer,
                              placeholder: "00:20",
                              textField: endTextField)
    }
    
    private func setTimeStampContainer(title: String, containerView: UIView, placeholder: String, textField: UITextField) {
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
        containerView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.leading.equalTo(label.snp.trailing).offset(5)
            make.trailing.equalToSuperview()
            make.width.equalTo(77)
            make.bottom.equalTo(label)
        }
    }
}
