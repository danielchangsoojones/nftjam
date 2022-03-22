//
//  SendEthView.swift
//  nftjam
//
//  Created by Daniel Jones on 3/21/22.
//

import UIKit

class SendEthView: UploadView {
    let qrCodeImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    let ethAddress: UIButton = {
        let button = UIButton()
        button.setTitle("0x71C7656EC7ab88b098defB751B7401B5f6d8976F", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    let sendLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 2
        return label
    }()
    
    let infoButton: UIButton = {
        let button = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
              .font: UIFont.systemFont(ofSize: 12, weight: .light),
              .foregroundColor: UIColor.white,
              .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributeString = NSMutableAttributedString(
                string: "What happens when my NFT joins a montage",
                attributes: attributes
        )
        button.setAttributedTitle(attributeString, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.textAlignment = .right
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.text = "Montage Ethereum Address"
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setConstraints() {
        super.setConstraints()
        addSubview(qrCodeImageView)
        addSubview(ethAddress)
        addSubview(sendLabel)
        addSubview(infoButton)
        
        qrCodeImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.width.equalTo(108)
        }
        
        ethAddress.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(qrCodeImageView.snp.bottom).offset(10)
        }
        
        sendLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(ethAddress.snp.bottom).offset(15)
        }
        
        infoButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(sendLabel)
            make.top.equalTo(sendLabel.snp.bottom).offset(5)
        }
    }
}
