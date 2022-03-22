//
//  UploadViewController.swift
//  nftjam
//
//  Created by Daniel Jones on 3/21/22.
//

import UIKit

class UploadViewController: UIViewController {
    private var submitButton: UIButton!
    
    var uploadView: UploadView {
        return UploadView(frame: self.view.frame)
    }
    
    override func loadView() {
        super.loadView()
        let uploadView = self.uploadView
        self.view = uploadView
        uploadView.submitButton.addTarget(self,
                                          action: #selector(submit),
                                          for: .touchUpInside)
        
    }
    
    @objc func submit() {
        //override in subclasses
    }
}
