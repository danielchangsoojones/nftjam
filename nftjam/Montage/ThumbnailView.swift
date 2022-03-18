//
//  ThumbnailView.swift
//  nftjam
//
//  Created by Daniel Jones on 3/17/22.
//

import UIKit

class ThumbnailView: UIView {
    let thumbnailImgView: UIImageView = {
        //TODO: remove img
        let img = UIImage(named: "dua")
        let imgView = UIImageView(image: img)
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    let nftTag = NFTTagView(logoDimension: 14, fontSize: 12)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 4
        layer.cornerRadius = 10
        clipsToBounds = true
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        addSubview(thumbnailImgView)
        addSubview(nftTag)
        
        thumbnailImgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        nftTag.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(8)
        }
    }
}
