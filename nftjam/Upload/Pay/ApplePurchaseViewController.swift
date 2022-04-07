//
//  ApplePurchaseViewController.swift
//  nftjam
//
//  Created by Daniel Jones on 4/7/22.
//

import UIKit
import StoreKit

class ApplePurchaseViewController: SendEthViewController {
    private let label = UILabel(frame: CGRect(x: 50, y: 70, width: 100, height: 100))
    private let priceLabel = UILabel(frame: CGRect(x: 250, y: 250, width: 100, height: 100))
    private let buyButton = UIButton(frame: CGRect(x: 250, y: 400, width: 100, height: 100))
    private var products: [SKProduct] = []
    
    override init(youtubeUpload: YoutubeUpload) {
        super.init(youtubeUpload: youtubeUpload)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titlelLabel.text = "Add NFT to Montage"
        ethAddressQR.isHidden = true
        ethAddress.isHidden = true
        copyPasteBtn.isHidden = true
        sendInfoLabel.isHidden = true
        checkBox.isHidden = true
        
        infoButton.snp.remakeConstraints { make in
            make.top.equalTo(titlelLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        checkBoxLabel.text = "After purchase, we will mint your NFT and send it to your Ethereum wallet. Then, it will be added to the montage\n\nPrice:$20"
        checkBoxLabel.numberOfLines = 0
        checkBoxLabel.textAlignment = .center
        checkBoxLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        checkBoxLabel.snp.remakeConstraints { make in
            make.leading.trailing.equalTo(submitButton)
            make.bottom.equalTo(submitButton.snp.top).offset(-10)
        }
        
        
        
        
        label.text = "hi"
        label.backgroundColor = .blue
        view.addSubview(label)
        
        priceLabel.text = "priceLabel"
        priceLabel.backgroundColor = .red
        view.addSubview(priceLabel)
        
        buyButton.backgroundColor = .green
        buyButton.addTarget(self,
                            action: #selector(buy),
                            for: .touchUpInside)
        view.addSubview(buyButton)

        NFTJamProducts.store.requestProducts{ [weak self] success, products in
          guard let self = self else { return }
          if success {
              if let products = products, let product = products.first {
                  self.products = products
                  DispatchQueue.main.async {
                      self.label.text = product.localizedTitle
                      self.priceFormatter.locale = product.priceLocale
                      self.priceLabel.text = self.priceFormatter.string(from: product.price)
                  }
              }
              
          }
        }
    }
    
    @objc private func buy() {
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
