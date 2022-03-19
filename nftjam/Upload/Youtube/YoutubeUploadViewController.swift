//
//  UploadViewController.swift
//  nftjam
//
//  Created by Daniel Jones on 3/18/22.
//

import UIKit

class YoutubeUploadViewController: UIViewController {
    override func loadView() {
        super.loadView()
        let youtubeUploadView = YoutubeUploadView(frame: self.view.frame)
        self.view = youtubeUploadView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}
