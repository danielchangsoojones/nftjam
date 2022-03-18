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
    var videoView = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStackViews()
        setVideoView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        addSubview(topStackView)
        
        //the video stays same height always. Thumbnails shrink in size.
        videoView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(250)
        }
        
        topStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.equalTo(self.snp.topMargin)
            make.bottom.equalTo(videoView.snp.top).offset(-10)
        }
        
        setLine(startingView: thumbnailViews[0], endingView: thumbnailViews[1], isHorizontal: true)
        setLine(startingView: thumbnailViews[1], endingView: thumbnailViews[2], isHorizontal: true)
        setLine(startingView: thumbnailViews[2], endingView: videoView, isHorizontal: false)
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
    
    private func setLine(startingView: UIView, endingView: UIView, isHorizontal: Bool) {
        let line = UIView()
        line.backgroundColor = .white
        addSubview(line)
        line.snp.makeConstraints { make in
            if isHorizontal {
                make.height.equalTo(startingView.layer.borderWidth)
                make.leading.equalTo(startingView.snp.trailing)
                make.trailing.equalTo(endingView.snp.leading)
                make.centerY.equalTo(startingView)
            } else {
                //vertical line
                make.width.equalTo(startingView.layer.borderWidth)
                make.centerX.equalTo(startingView)
                make.top.equalTo(startingView.snp.bottom)
                make.bottom.equalTo(endingView.snp.top)
            }
        }
    }
    
    private func setVideoView() {
        videoView.layer.borderWidth = thumbnailViews.first?.layer.borderWidth ?? 4
        videoView.layer.borderColor = thumbnailViews.first?.layer.borderColor ?? UIColor.white.cgColor
        videoView.backgroundColor = .red
        addSubview(videoView)
        
        let nftTag = NFTTagView(frame: CGRect(x: 0, y: 0, width: 74, height: 35))
        videoView.addSubview(nftTag)
        nftTag.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.top.equalToSuperview().offset(4)
        }
    }
}
