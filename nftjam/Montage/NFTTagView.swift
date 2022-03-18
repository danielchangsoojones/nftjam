//
//  NFTTagView.swift
//  nftjam
//
//  Created by Daniel Jones on 3/17/22.
//

import UIKit
import SnapKit

class NFTTagView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "NFT"
        label.textColor = .white
        return label
    }()
    
    private let logoImgView: UIImageView = {
        let nftLogo = UIImage(named: "nft-logo")
        let imgView = UIImageView(image: nftLogo)
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    init(logoDimension: CGFloat, fontSize: CGFloat) {
        super.init(frame: .zero)
        backgroundColor = UIColor(red: 187.0 / 255, green: 144.0 / 255, blue: 144.0 / 255, alpha: 1)
        layer.cornerRadius = 10
        clipsToBounds = true
        titleLabel.font = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
        setConstraints(logoDimension: logoDimension)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints(logoDimension: CGFloat) {
        addSubview(logoImgView)
        addSubview(titleLabel)
        
        let leadingOffset: CGFloat = 3
        logoImgView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leadingOffset)
            make.centerY.equalTo(titleLabel)
            make.trailing.equalTo(titleLabel.snp.leading).offset(-2)
            make.width.equalTo(logoDimension)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(logoDimension * 0.2)
            make.trailing.equalToSuperview().inset(leadingOffset)
        }
    }
}
