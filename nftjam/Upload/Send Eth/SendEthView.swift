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
        
        qrCodeImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.width.equalTo(108)
        }
        
        ethAddress.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(qrCodeImageView.snp.bottom).offset(10)
        }
    }
}
