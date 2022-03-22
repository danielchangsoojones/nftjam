//
//  EthAddressViewController.swift
//  nftjam
//
//  Created by Daniel Jones on 3/20/22.
//
import UIKit
import TTTAttributedLabel
import SCLAlertView

class EthAddressViewController: UploadViewController {
    private let youtubeUpload: YoutubeUpload
    
    override var uploadView: UploadView {
        return EthAdressView(frame: self.view.frame)
    }
    
    init(youtubeUpload: YoutubeUpload) {
        self.youtubeUpload = youtubeUpload
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        if let ethAddressView = self.view as? EthAdressView {
            ethAddressView.descriptionLabel.delegate = self
        }
    }
    
    override func submit() {
        
    }
}

extension EthAddressViewController: TTTAttributedLabelDelegate {
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        let alertView = SCLAlertView()
        let subtitle = "When you add your public ETH address. We have a manual process to send your earnings to your Ethereum address. Everytime someone adds an NFT to your montage, you will receive a portion of that NFT's price. In the beta, we will send you ETH manually for every added NFT to your montage.\n\nHowever, we are currently working on an automated smart contract (which we will get audited by a top smart contract auditor). You will eventually be able to log in with Metamask, and access the smart contract instantly.\n\nIf you have questions, please email us at danieljones@mintnfttube.com"
        alertView.showInfo("Why input your ETH Address?", subTitle: subtitle)
    }
}
