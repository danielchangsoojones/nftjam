//
//  WelcomeView.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import UIKit
import SnapKit

class WelcomeView: UIView {
    private var stackView: UIStackView!
    private var logInView: UIView!
    var logInButton: UIButton!
    var registerButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addLogInView()
        addButtons()
        addTitles()
        addInfluencerProfile()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addLogInView() {
        logInView = UIView()
        logInView.backgroundColor = .white
        addSubview(logInView)
        logInView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        stackView = UIStackView()
        stackView.spacing = 9
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        logInView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(40)
            make.top.equalTo(logInView.snp.top).inset(20)
        }
    }
    
    private func addButtons() {
        logInButton = createButton(title: "LOG IN", textColor: .black)
        registerButton = createButton(title: "REGISTER", textColor: .white)
        stackView.addArrangedSubview(logInButton)
        stackView.addArrangedSubview(registerButton)
    }
    
    private func createButton(title: String, textColor: UIColor) -> UIButton {
        let button = UIButton()
        button.backgroundColor = textColor == .black ? .white : .black
        button.setTitle(title, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.titleLabel?.font =  .systemFont(ofSize: 13, weight: .black)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        let horizontalInset: CGFloat = 20
        let verticalInset: CGFloat = 20
        button.contentEdgeInsets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        return button
    }
    
    private func addTitles() {
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Build Collaborative Youtube NFT's"
        subtitleLabel.textColor = .black
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = .systemFont(ofSize: 20, weight: .light)
        subtitleLabel.textAlignment = .center
        addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(5)
            make.centerY.equalToSuperview()
        }
        
        let logoImageView = UIImageView()
        if let logoImage = UIImage(named: "nft-logo") {
            logoImageView.image = logoImage
            logoImageView.contentMode = .scaleAspectFit
            addSubview(logoImageView)
            logoImageView.snp.makeConstraints { (make) in
                make.bottom.equalTo(subtitleLabel.snp.top).offset(-15)
                make.leading.trailing.equalToSuperview().inset(30)
            }
        }
    }
    
    private func addInfluencerProfile() {
        let influencerImageView = UIImageView()
        if let image = UIImage(named: "kaiti_1") {
            influencerImageView.image = image
            influencerImageView.contentMode = .scaleAspectFit
            addSubview(influencerImageView)
            influencerImageView.snp.makeConstraints { (make) in
                make.leading.equalToSuperview().inset(20)
                make.bottom.equalTo(logInView.snp.top).offset(-25)
                make.height.width.equalTo(55)
            }
            
            let influencerName = UILabel()
            influencerName.text = "Kaiti Yoo"
            influencerName.font = .systemFont(ofSize: 13, weight: .bold)
            influencerName.textColor = .white
            addSubview(influencerName)
            influencerName.snp.makeConstraints { (make) in
                make.leading.equalTo(influencerImageView.snp.trailing).offset(7)
                make.bottom.equalTo(influencerImageView.snp.centerY).offset(-3)
            }
            
            let influencerHandle = UILabel()
            influencerHandle.text = "@kayteeyou"
            influencerHandle.font = .systemFont(ofSize: 11, weight: .regular)
            influencerHandle.textColor = .white
            addSubview(influencerHandle)
            influencerHandle.snp.makeConstraints { (make) in
                make.leading.equalTo(influencerName)
                make.top.equalTo(influencerImageView.snp.centerY).offset(3)
            }
        }
    }
}
