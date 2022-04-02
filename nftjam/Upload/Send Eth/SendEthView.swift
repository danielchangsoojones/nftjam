//
//  SendEthView.swift
//  nftjam
//
//  Created by Daniel Jones on 3/21/22.
//

import UIKit
import UICheckbox

class SendEthView: UploadView {
    let qrCodeImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    let ethAddress: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
    
    let sendLabel: UILabel = {
        let label = UILabel()
        
        //TODO: remove
        label.text = "Send 0.2 ETH to the montage’s ETH address to add a NFT to the montage"
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
    let infoButton: UIButton = {
        let button = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
              .font: UIFont.systemFont(ofSize: 14, weight: .light),
              .foregroundColor: UIColor.white,
              .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributeString = NSMutableAttributedString(
                string: "What happens when my NFT joins a montage?",
                attributes: attributes
        )
        button.setAttributedTitle(attributeString, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.textAlignment = .right
        return button
    }()
    
    let checkBox: UICheckbox = {
        let checkbox = UICheckbox()
        checkbox.backgroundColor = .white
        checkbox.layer.borderColor = UIColor.deepBlue.cgColor
        checkbox.layer.borderWidth = 3
        return checkbox
    }()
    
    let checkBoxLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.text = "I’ve sent 0.2 ETH to the montage’s address"
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
    let nftImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        //TODO: remove
        imageView.image = UIImage(named: "dua")
        
        
        return imageView
    }()
    
    private let arrow: UIImageView = {
        let img = UIImage(named: "big_arrow")
        let imageView = UIImageView(image: img)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let montageView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let copyPasteBtn: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "copy-paste")
        btn.setImage(img, for: .normal)
        return btn
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
        addSubview(checkBox)
        addSubview(checkBoxLabel)
        addSubview(nftImgView)
        addSubview(arrow)
        addSubview(montageView)
        addSubview(copyPasteBtn)
        
        qrCodeImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.width.equalTo(108)
        }
        
        ethAddress.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
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
        
        checkBox.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.bottom.equalTo(submitButton.snp.top).offset(-10)
            make.height.width.equalTo(30)
        }
        
        checkBoxLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkBox.snp.trailing).offset(5)
            make.trailing.equalTo(titleLabel)
            make.centerY.equalTo(checkBox)
        }
        
        let width: CGFloat = 70
        nftImgView.snp.makeConstraints { make in
            make.top.equalTo(infoButton.snp.bottom).offset(5)
            make.leading.equalTo(titleLabel)
            make.width.equalTo(width)
        }
        
        let horizontalDistance: CGFloat = 10
        arrow.snp.makeConstraints { make in
            make.centerY.equalTo(nftImgView)
            make.leading.equalTo(nftImgView.snp.trailing).offset(horizontalDistance)
            make.width.equalTo(75)
            make.height.equalTo(25)
        }
        
        montageView.snp.makeConstraints { make in
            make.centerY.equalTo(nftImgView)
            make.leading.equalTo(arrow.snp.trailing).offset(horizontalDistance)
            make.width.equalTo(width)
            make.height.equalTo(width)
        }
        
        copyPasteBtn.snp.makeConstraints { make in
            make.centerY.equalTo(ethAddress)
            make.leading.equalTo(ethAddress.snp.trailing)
        }
    }
}
