//
//  Products.swift
//  nftjam
//
//  Created by Daniel Jones on 4/7/22.
//

import Foundation

public struct NFTJamProducts {
  
  public static let nftvideo1999v2 = "danielchangsoojones.nftjam.nftvideo1999v2"
  
  private static let productIdentifiers: Set<ProductIdentifier> = [NFTJamProducts.nftvideo1999v2]

  public static let store = IAPHelper(productIds: NFTJamProducts.productIdentifiers)
}

func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
  return productIdentifier.components(separatedBy: ".").last
}

