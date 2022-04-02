//
//  SendEthViewController.swift
//  nftjam
//
//  Created by Daniel Jones on 3/21/22.
//

import UIKit
import SCLAlertView

class SendEthViewController: UploadViewController {
    private let youtubeUpload: YoutubeUpload
    private let dataStore = UploadDataStore()
    private var montageContainerView: UIView!
    
    override var uploadView: UploadView {
        return SendEthView(frame: self.view.frame)
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
        if let sendEthView = self.view as? SendEthView {
            sendEthView.qrCodeImageView.loadFromFile(youtubeUpload.montage.ethAddressQR)
            self.montageContainerView = sendEthView.montageView
            sendEthView.ethAddress.setTitle(youtubeUpload.montage.ethAddressStr,
                                            for: .normal)
            sendEthView.ethAddress.addTarget(self,
                                               action: #selector(copyEthAddress),
                                               for: .touchUpInside)
            sendEthView.copyPasteBtn.addTarget(self,
                                               action: #selector(copyEthAddress),
                                               for: .touchUpInside)
            sendEthView.sendLabel.text = "Send \(youtubeUpload.montage.mintPrice) ETH to the montage’s ETH address to add a NFT to the montage"
            sendEthView.infoButton.addTarget(self,
                                             action: #selector(infoPressed),
                                             for: .touchUpInside)
            sendEthView.nftImgView.loadFromFile(youtubeUpload.thumbnailFile)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLabelToMontage()
//        loadMontage()
    }
    
    //only adding a label for now cause adding the discover is difficult right now.
    private func addLabelToMontage() {
        let label = UILabel()
        montageContainerView.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        label.text = youtubeUpload.montage.title
    }
    
//    private func loadMontage() {
//        let dataStore = DiscoverDataStore()
//        dataStore.loadPhotos { montageDatas in
//            let montageData = montageDatas.first { montageData in
//                return montageData.montage.objectId == self.youtubeUpload.montage.objectId
//            }
//            
//            if let montageData = montageData {
//                self.setMontagePhotos(montageData: montageData)
//            }
//        }
//    }
    
//    private func setMontagePhotos(montageData: MontageData) {
//        let cell = DiscoverTableCell()
//        for (index, photo) in montageData.photos.enumerated() {
//            if cell.thumbnailImgViews.indices.contains(index) {
//                cell.thumbnailImgViews[index].loadFromFile(photo.image)
//            }
//        }
//        montageContainerView.addSubview(cell)
//        cell.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//    }
    
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
    
    @objc private func copyEthAddress() {
        print("hi")
    }
    
    @objc private func infoPressed() {
        let alertView = SCLAlertView()
        let subtitle = "when you add an NFT you make money"
        alertView.showInfo("Adding An NFT", subTitle: subtitle)
    }
}
