//
//  EthAddressViewController.swift
//  nftjam
//
//  Created by Daniel Jones on 3/20/22.
//

import UIKit

class EthAddressViewController: UIViewController {    
    override func loadView() {
        super.loadView()
        let ethUploadView = EthAdressView(frame: self.view.frame)
        self.view = ethUploadView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    


}
