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
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let logoImgView: UIImageView = {
        let nftLogo = UIImage(named: "nft-logo")
        let imgView = UIImageView(image: nftLogo)
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 187.0 / 255, green: 144.0 / 255, blue: 144.0 / 255, alpha: 1)
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        addSubview(logoImgView)
        addSubview(titleLabel)
        logoImgView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(-2)
            make.top.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(2)
            make.leading.equalTo(logoImgView.snp.trailing).inset(3)
        }
    }
    
}
