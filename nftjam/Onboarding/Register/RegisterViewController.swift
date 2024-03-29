//
//  RegisterViewController.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import UIKit
import SnapKit

class RegisterViewController: UIViewController, OnboardingDataStoreDelegate {
    var titleLabel: UILabel!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var nextButton: SpinningButton!
    var dataStore: OnboardingDataStore!
    var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let registerView = RegisterView(frame: self.view.bounds)
        self.view = registerView
        titleLabel = registerView.titleLabel
        emailTextField = registerView.emailTextField
        passwordTextField = registerView.passwordTextField
        passwordTextField.isSecureTextEntry = true
        nextButton = registerView.nextButton
        stackView = registerView.stackView
        registerView.nextButton.addTarget(self, action: #selector(nextBtnPressed), for: .touchUpInside)
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.topItem?.title = ""
        dataStore = OnboardingDataStore(delegate: self)
    }
    
    @objc func nextBtnPressed() {
        nextButton.startSpinning()
        if validateEmail() && validatePassword() {
            runServerAuthentication()
        } else {
            nextButton.stopSpinning()
        }
    }
    
    func runServerAuthentication() {
        dataStore.register(email: emailTextField.text ?? "",
                           password: passwordTextField.text ?? "")
    }
    
    func segueIntoApp() {
        let discoverVC = DiscoverViewController()
        let navController = UINavigationController(rootViewController: discoverVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
}

extension RegisterViewController {
    func validateEmail() -> Bool {
        if let email = emailTextField?.text, !email.isEmail {
            BannerAlert.show(title: "Invalid Email",
                             subtitle: "You must input a proper email",
                             type: .error)
            return false
        }
        
        return true
    }
    
    func validatePassword() -> Bool {
        if let password = passwordTextField?.text {
            if password.isBlank {
                BannerAlert.show(title: "Invalid Password", subtitle: "You must input a password", type: .error)
                return false
            }
        }
        return true
    }
    
    func showError(title: String, subtitle: String) {
        nextButton.stopSpinning()
        BannerAlert.show(title: title, subtitle: subtitle, type: .error)
    }
}
