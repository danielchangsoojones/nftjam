//
//  CustomButton.swift
//  nftjam
//
//  Created by Daniel Jones on 3/17/22.
//

import UIKit

class CustomButton: UIButton {
    private let spinner = UIActivityIndicatorView()
    
    init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        self.backgroundColor = .deepBlue
        self.layer.cornerRadius = 18
        setTitle("", for: .disabled)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startSpinning() {
        spinner.startAnimating()
        isEnabled = false
    }
    
    func stopSpinning() {
        spinner.stopAnimating()
        isEnabled = true
    }
    
    private func setSpinner() {
        spinner.color = .white
        addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
            make.width.equalTo(self.snp.height).multipliedBy(0.8)
        }
    }
}
