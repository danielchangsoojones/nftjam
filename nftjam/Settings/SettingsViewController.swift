//
//  HomeMenuViewController.swift
//  btown-rides-riders
//
//  Created by Daniel Jones on 3/4/18.
//  Copyright © 2018 Chong500Productions. All rights reserved.
//

import UIKit
import Former

class SettingsViewController: BaseFormViewController<Any> {
    private let contactUsRow = LabelRowFormer<FormLabelCell>()
    private var messageHelper: MessageHelper?

    override func viewDidLoad() {
        super.viewDidLoad()
        messageHelper = MessageHelper(currentVC: self)
        contactUs()
        setupLogOutRow()
        //giving it a big inset from the bottom because sometimes the nav bar
        //gets too big and then it covers the logout button. It's a hacky fix
        //that works for now.
        tableView.contentInset.bottom = 100
    }
    
    private func contactUs() {
        addRowWithFooter(row: contactUsRow,
                         header: "Contact Us",
                         footer: "Send us a text message to get in touch with our team. or email us at danieljones@mintnfttube.com")
    }
    
    private func addRowWithFooter(row: LabelRowFormer<FormLabelCell>, header: String, footer: String) {
        row.configure { (row) in
            row.text = "Tap here"
        }
        
        row.onSelected { (_) in
            self.messageHelper?.text("3176905323")
        }
        
        append(row: row, headerTitle: header, footerDescription: footer)
    }
    
    private func textUs(body: String? = nil) {
        let customerServicePhone = "3176905323"
        messageHelper?.text(customerServicePhone, body: body ?? "")
    }
    
    private func setupLogOutRow() {
        addTappableLabelRow(title: "Log Out", onSelected: {
            User.logOutInBackground { error in
                if let error = error {
                    BannerAlert.show(with: error)
                } else {
                    self.segueToWelcomeVC()
                }
            }
        })
    }
    
    private func segueToWelcomeVC() {
        let welcomeVC = WelcomeViewController()
        welcomeVC.modalPresentationStyle = .fullScreen
        present(welcomeVC, animated: true)
    }
}
