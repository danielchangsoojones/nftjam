//
//  EthAdressView.swift
//  nftjam
//
//  Created by Daniel Jones on 3/20/22.
//

import UIKit
import TextFieldEffects

class EthAdressView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter Your Ethereum Address"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
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
    
//    private let descriptionLabel: UILabel = {
//       let label = UILabel()
//        label.text = "Your Ethereum address is where we will send your earnings. Everytime a new NFT is added onto the montage, your NFT earns part of the proceeds. Learn about the beta"
//
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .spaceGray
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        addSubview(titleLabel)
        addSubview(addressTextField)
        addSubview(line)
//        addSubview(descriptionLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(self.snp.topMargin)
        }
        
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
        
//        descriptionLabel.snp.makeConstraints { make in
//            make.leading.trailing.equalTo(addressTextField)
//            make.top.equalTo(addressTextField.snp.bottom)
//        }
    }
}
