//
//  UploadViewController.swift
//  nftjam
//
//  Created by Daniel Jones on 3/21/22.
//

import UIKit

class UploadViewController: UIViewController {
    var submitButton: UIButton!
    private var messageHelper: MessageHelper?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageHelper = MessageHelper(currentVC: self)
        setExitBtn()
        setHelpBtn()
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc func submit() {
        //override in subclasses
    }
    
    private func setHelpBtn() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Help",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(helpPressed))
    }
    
    @objc private func helpPressed() {
        messageHelper?.text("3176905323")
    }
    
    private func setExitBtn() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Exit",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(exitBtnPressed))
    }
    
    @objc private func exitBtnPressed() {
        self.dismiss(animated: true)
    }
}
