//
//  EthAddressViewController.swift
//  nftjam
//
//  Created by Daniel Jones on 3/20/22.
//
import UIKit
import TTTAttributedLabel
import SCLAlertView

class EthAddressViewController: UIViewController {
    private let youtubeUpload: YoutubeUpload
    
    init(youtubeUpload: YoutubeUpload) {
        self.youtubeUpload = youtubeUpload
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        let ethUploadView = EthAdressView(frame: self.view.frame)
        self.view = ethUploadView
        ethUploadView.descriptionLabel.delegate = self
        ethUploadView.submitButton.addTarget(self,
                                             action: #selector(submitPressed),
                                             for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @objc private func submitPressed() {
        //segue to new VC
    }
}

extension EthAddressViewController: TTTAttributedLabelDelegate {
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        let alertView = SCLAlertView()
        let subtitle = "In the beta, your ETH address will be used to receive earnings made by your NFT.The amount paid to mint a new token is divided equally amongst all previous token holders. Everytime an artist joins your montage, we will manually direct ETH to your wallet.\n\nSoon, we will develop an automated smart contract (it will be audited by a top smart contract auditor). When complete, you will be able to log in with Metamask, and access the smart contract instantly.\nFor questions, email danieljones@mintnfttube.com"
        alertView.showInfo("Why input your ETH Address?", subTitle: subtitle)
    }
}
