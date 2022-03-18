//
//  MontageView.swift
//  nftjam
//
//  Created by Daniel Jones on 3/17/22.
//

import UIKit

class MontageView: UIView {
    private var topStackView: UIStackView!
    private var bottomStackView: UIStackView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStackViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        addSubview(topStackView)
        topStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.snp.topMargin)
            make.height.equalTo(144)
        }
    }
    
    private func setStackViews() {
        let thumbnail1 = ThumbnailView(frame: CGRect(x: 0, y: 0, width: 94, height: 0))
        let thumbnail2 = ThumbnailView(frame: CGRect(x: 0, y: 0, width: 94, height: 0))
        let thumbnail3 = ThumbnailView(frame: CGRect(x: 0, y: 0, width: 94, height: 0))
        
        topStackView = createStackView()
        bottomStackView = createStackView()
        
        topStackView.addArrangedSubview(thumbnail1)
        topStackView.addArrangedSubview(thumbnail2)
        topStackView.addArrangedSubview(thumbnail3)
    }
    
    
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        stackView.spacing = 20
        return stackView
    }
}
