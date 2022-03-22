//
//  SendEthViewController.swift
//  nftjam
//
//  Created by Daniel Jones on 3/21/22.
//

import UIKit

class SendEthViewController: UploadViewController {
    private let youtubeUpload: YoutubeUpload
    private let dataStore = UploadDataStore()
    
    override var uploadView: UploadView {
        return SendEthView(frame: self.view.frame)
    }
    
    init(youtubeUpload: YoutubeUpload) {
        self.youtubeUpload = youtubeUpload
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func submit() {
        youtubeUpload.priceToMint = 0.2
        dataStore.uploadNFTLink(youtubeUpload: youtubeUpload) { isSuccess, error in
            if isSuccess {
                self.dismiss(animated: true)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "uploadNFT")
            }
        }
    }
}
