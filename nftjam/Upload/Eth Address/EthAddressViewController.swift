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
    private var addressTextField: UITextField!
    
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
            self.addressTextField = ethAddressView.addressTextField
        }
    }
    
    override func submit() {
        if let text = addressTextField.text, !text.isEmpty {
            youtubeUpload.ethAddress = text
            let sendEthVC = SendEthViewController(youtubeUpload: youtubeUpload)
            navigationController?.pushViewController(sendEthVC, animated: true)
        } else {
            //TODO: put in a banner loader alert
        }
        
    }
}

extension EthAddressViewController: TTTAttributedLabelDelegate {
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        let alertView = SCLAlertView()
        let subtitle = "In the beta, your ETH address will be used to receive earnings made by your NFT.The amount paid to mint a new token is divided equally amongst all previous token holders. Everytime an artist joins your montage, we will manually direct ETH to your wallet.\n\nSoon, we will develop an automated smart contract (it will be audited by a top smart contract auditor). When complete, you will be able to log in with Metamask, and access the smart contract instantly.\nFor questions, email danieljones@mintnfttube.com"
        alertView.showInfo("Why input your ETH Address?", subTitle: subtitle)
    }
}
