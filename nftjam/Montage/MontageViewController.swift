//
//  ViewController.swift
//  nftjam
//
//  Created by Daniel Jones on 3/17/22.
//

import UIKit

class MontageViewController: UIViewController {
    override func loadView() {
        super.loadView()
        let montageView = MontageView(frame: self.view.frame)
        self.view = montageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let blue = UIColor(red: 68.0 / 255, green: 64.0 / 255, blue: 175.0 / 255, alpha: 1)
        self.view.backgroundColor = blue
//        let nftTag = ThumbnailView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//        self.view.addSubview(nftTag)
//        nftTag.snp.makeConstraints { make in
//            make.leading.top.equalToSuperview().offset(10)
//            make.height.equalTo(144)
//            make.width.equalTo(94)
//        }
    }
    
    
}

