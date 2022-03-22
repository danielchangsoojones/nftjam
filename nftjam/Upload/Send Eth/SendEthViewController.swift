//
//  SendEthViewController.swift
//  nftjam
//
//  Created by Daniel Jones on 3/21/22.
//

import UIKit

class SendEthViewController: UploadViewController {
    private let youtubeUpload: YoutubeUpload
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
