//
//  ViewController.swift
//  nftjam
//
//  Created by Daniel Jones on 3/17/22.
//

import UIKit

class MontageViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        let nftTag = NFTTagView(frame: CGRect(x: 0, y: 0, width: 74, height: 35))
        self.view.addSubview(nftTag)
        nftTag.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(10)
            make.height.equalTo(35)
            make.width.equalTo(74)
        }
    }
    
    
}

