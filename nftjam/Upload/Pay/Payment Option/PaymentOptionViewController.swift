//
//  PaymentOptionViewController.swift
//  nftjam
//
//  Created by Daniel Jones on 4/7/22.
//

import UIKit

class PaymentOptionViewController: UploadViewController {
    private let youtubeUpload: YoutubeUpload
    private let ethButton = CustomButton(title: "Mint with Ethereum")
    private let promoBtn = CustomButton(title: "Enter Promo Code")
    
    init(youtubeUpload: YoutubeUpload) {
        self.youtubeUpload = youtubeUpload
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.setTitle("Mint With Apple Pay", for: .normal)
        
        let verticalSpacing: CGFloat = -25
        self.view.addSubview(ethButton)
        ethButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(submitButton)
            make.bottom.equalTo(submitButton.snp.top).offset(verticalSpacing)
            make.height.equalTo(submitButton)
        }
        ethButton.addTarget(self,
                            action: #selector(ethBtnPressed),
                            for: .touchUpInside)
        
        self.view.addSubview(promoBtn)
        promoBtn.snp.makeConstraints { make in
            make.leading.trailing.equalTo(submitButton)
            make.bottom.equalTo(ethButton.snp.top).offset(verticalSpacing)
            make.height.equalTo(submitButton)
        }
        
        titlelLabel.text = "How would you like to buy your NFT?"
    }
    
    @objc private func ethBtnPressed() {
        let vc = SendEthViewController(youtubeUpload: youtubeUpload)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func submit() {
        let vc = ApplePurchaseViewController(youtubeUpload: youtubeUpload)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func promoBtnPressed() {
        
    }
}
