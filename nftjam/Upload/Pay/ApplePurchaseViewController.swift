//
//  ApplePurchaseViewController.swift
//  nftjam
//
//  Created by Daniel Jones on 4/7/22.
//

import UIKit
import StoreKit

class ApplePurchaseViewController: SendEthViewController {
    private var products: [SKProduct] = []
    private var spinningView: UIView?
    
    override init(youtubeUpload: YoutubeUpload) {
        super.init(youtubeUpload: youtubeUpload)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.completedPurchase(notification:)), name: .IAPHelperPurchaseNotification,
                                               object: nil)

        updateUI()
        loadProducts()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func completedPurchase(notification: Notification) {
        youtubeUpload.purchaseMedium = "apple"
        dataStore.uploadNFTLink(youtubeUpload: youtubeUpload) { success, error in
            self.spinningView?.removeFromSuperview()
            if success {
                self.dismiss(animated: true)
            } else {
                BannerAlert.show(with: error)
            }
        }
    }
    
    private func updateUI() {
        titlelLabel.text = "Add NFT to Montage"
        ethAddressQR.isHidden = true
        ethAddress.isHidden = true
        copyPasteBtn.isHidden = true
        sendInfoLabel.isHidden = true
        checkBox.isHidden = true
        
        
        
        if (MyConfigurationParse.shared?.isHiding ?? false) {
            infoButton.isHidden = true
            checkBoxLabel.text = "Price:$19.99"
        } else {
            checkBoxLabel.text = "After purchase, we will mint your NFT and send it to your Ethereum wallet. Then, it will be added to the montage\n\nPrice:$19.99"
            infoButton.snp.remakeConstraints { make in
                make.top.equalTo(titlelLabel.snp.bottom).offset(10)
                make.leading.trailing.equalToSuperview().inset(10)
            }
        }
        
        
        checkBoxLabel.numberOfLines = 0
        checkBoxLabel.textAlignment = .center
        checkBoxLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        checkBoxLabel.snp.remakeConstraints { make in
            make.leading.trailing.equalTo(submitButton)
            make.bottom.equalTo(submitButton.snp.top).offset(-10)
        }
    }
    
    private func loadProducts() {
        NFTJamProducts.store.requestProducts{ [weak self] success, products in
          guard let self = self else { return }
          if success {
              if let products = products {
                  self.products = products
              }
          } else {
              BannerAlert.show(title: "Error",
                               subtitle: "Error with requesting the product",
                               type: .error)
          }
        }
    }
    
    override func submit() {
        self.spinningView = Helpers.showActivityIndicatory(in: self.view)
        print("buying product")
        if let product = products.first {
            NFTJamProducts.store.buyProduct(product)
        } else {
            BannerAlert.show(title: "Error",
                             subtitle: "Couldn't find the correct SKProduct",
                             type: .error)
        }
    }
    
    let priceFormatter: NumberFormatter = {
      let formatter = NumberFormatter()
      
      formatter.formatterBehavior = .behavior10_4
      formatter.numberStyle = .currency
      
      return formatter
    }()
}
