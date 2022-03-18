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
    var thumbnailViews: [ThumbnailView] = []
    
    
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
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.equalTo(self.snp.topMargin)
            make.height.equalTo(144)
        }
        
        setLine(startingView: thumbnailViews[0], endingView: thumbnailViews[1])
        setLine(startingView: thumbnailViews[1], endingView: thumbnailViews[2])
    }
    
    private func setStackViews() {
        topStackView = createStackView()
        bottomStackView = createStackView()
        
        for _ in 1...3 {
            let thumbnail = ThumbnailView(frame: CGRect(x: 0, y: 0, width: 94, height: 0))
            topStackView.addArrangedSubview(thumbnail)
            thumbnailViews.append(thumbnail)
        }
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }
    
    private func setLine(startingView: UIView, endingView: UIView) {
        let line = UIView()
        line.backgroundColor = .white
        addSubview(line)
        line.snp.makeConstraints { make in
            make.height.equalTo(startingView.layer.borderWidth)
            make.leading.equalTo(startingView.snp.trailing)
            make.trailing.equalTo(endingView.snp.leading)
            make.centerY.equalTo(startingView)
        }
    }
}
