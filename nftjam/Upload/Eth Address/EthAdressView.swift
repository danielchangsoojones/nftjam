//
//  EthAdressView.swift
//  nftjam
//
//  Created by Daniel Jones on 3/20/22.
//

import UIKit
import TextFieldEffects
import TTTAttributedLabel

class EthAdressView: UploadView {
    private let addressTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 16, weight: .light)
        textField.textColor = .white
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no
        textField.clearButtonMode = .whileEditing
        textField.attributedPlaceholder = NSAttributedString(
            string: "i.e. 0x71C7656EC7ab88b098defB751B7401B5f6d8976F",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)]
        )
        return textField
    }()
    
    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let descriptionLabel: TTTAttributedLabel = {
        let tLabel = TTTAttributedLabel(frame: .zero)
        let linkStr = "Learn about the beta ->"
        let nonLinkString = "Your Ethereum address is where we will send your earnings. Everytime a new NFT is added onto the montage, your NFT earns part of the proceeds."
        let str = nonLinkString + " \(linkStr)"
        let nsString: NSString = NSString(string: str)
        tLabel.numberOfLines = 0
        tLabel.textColor = .white
        tLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        tLabel.text = str
        tLabel.linkAttributes = [kCTForegroundColorAttributeName as AnyHashable: UIColor.white, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let messageUsStringRange = nsString.range(of: linkStr)
        let messageUsStringURL = URL(string: linkStr)
        tLabel.addLink(to: messageUsStringURL, with: messageUsStringRange)
        return tLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .spaceGray
        titleLabel.text = "Enter your Ethereum Address"
        submitButton.setTitle("Next", for: .normal)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal override func setConstraints() {
        super.setConstraints()
        addSubview(addressTextField)
        addSubview(line)
        addSubview(descriptionLabel)
        
        addressTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(45)
        }
        
        line.snp.makeConstraints { make in
            make.leading.trailing.equalTo(addressTextField)
            make.bottom.equalTo(addressTextField)
            make.height.equalTo(1)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(addressTextField)
            make.top.equalTo(addressTextField.snp.bottom).offset(10)
        }
    }
}
