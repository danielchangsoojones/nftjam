//
//  LogInViewController.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import UIKit

class LogInViewController: RegisterViewController {
    private var messageHelper: MessageHelper?
    
    override func viewDidLoad() {
        messageHelper = MessageHelper(currentVC: self, delegate: nil)
        super.viewDidLoad()
        updateLabels()
        setUpResetPasswordBtn()
    }
    
    override func runServerAuthentication() {
        dataStore.logIn(email: emailTextField.text ?? "",
                        password: passwordTextField.text ?? "")
    }
    
    private func updateLabels() {
        titleLabel.text = "Log In"
        nextButton.setTitle("LOG IN", for: .normal)
    }
    
    private func setUpResetPasswordBtn() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Reset Password",
            style: .plain,
            target: self,
            action: #selector(resetBtnPressed)
        )
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([ .font: UIFont.systemFont(ofSize: 13, weight: .light)], for: .normal)
    }
    
    @objc private func resetBtnPressed() {
        let msg = "please help me reset my password for nft jam"
        messageHelper?.text("3176905323", body: msg)
//        let resetPasswordVC = ResetPasswordViewController()
//        pushVC(resetPasswordVC)
    }
    
    override func segueIntoApp() {
        let vc = DiscoverViewController()
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
}
