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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.text = "Montage Ethereum Address"
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setConstraints() {
        addSubview(qrCodeImageView)
        
        qrCodeImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(qrCodeImageView.snp.bottom).offset(10)
            make.height.width.equalTo(108)
        }
    }
}
