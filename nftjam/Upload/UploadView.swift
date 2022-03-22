//
//  UploadView.swift
//  nftjam
//
//  Created by Daniel Jones on 3/21/22.
//

import UIKit

class UploadView: UIView {
    let submitButton = CustomButton(title: "Add NFT Clip to Montage")
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .spaceGray
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        addSubview(titleLabel)
        addSubview(submitButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.topMargin)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        submitButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalTo(self.snp.bottomMargin)
            make.height.equalTo(53)
        }
    }
}
