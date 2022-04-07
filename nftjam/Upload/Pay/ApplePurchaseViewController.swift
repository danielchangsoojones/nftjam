//
//  ApplePurchaseViewController.swift
//  nftjam
//
//  Created by Daniel Jones on 4/7/22.
//

import UIKit
import StoreKit

class ApplePurchaseViewController: UIViewController {
    private let label = UILabel(frame: CGRect(x: 50, y: 70, width: 100, height: 100))
    private let priceLabel = UILabel(frame: CGRect(x: 250, y: 250, width: 100, height: 100))
    private let buyButton = UIButton(frame: CGRect(x: 250, y: 400, width: 100, height: 100))
    private var products: [SKProduct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
