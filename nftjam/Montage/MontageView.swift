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
        //the video stays same height always. Thumbnails shrink in size.
        videoView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(250)
        }
        
        let videoVerticalOffset: CGFloat = 10
        topStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.equalTo(self.snp.topMargin)
            make.bottom.equalTo(videoView.snp.top).offset(-videoVerticalOffset)
        }
        
        bottomStackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(topStackView)
            make.height.equalTo(topStackView)
            make.top.equalTo(videoView.snp.bottom).offset(videoVerticalOffset)
        }
        
        setLine(startingView: thumbnailViews[0], endingView: thumbnailViews[1], isHorizontal: true)
        setLine(startingView: thumbnailViews[1], endingView: thumbnailViews[2], isHorizontal: true)
        setLine(startingView: thumbnailViews[2], endingView: videoView, isHorizontal: false)
        setLine(startingView: videoView, endingView: thumbnailViews[3], isHorizontal: false)
        setLine(startingView: thumbnailViews[3], endingView: thumbnailViews[4], isHorizontal: true)
        setLine(startingView: thumbnailViews[4], endingView: thumbnailViews[5], isHorizontal: true)
        
        setArrow(attachedView: thumbnailViews[0], isLeading: true)
        setArrow(attachedView: thumbnailViews[5], isLeading: false)
    }
    
    private func setStackViews() {
        topStackView = createStackView()
        bottomStackView = createStackView()
        
        for _ in 1...3 {
            let thumbnail = ThumbnailView(frame: CGRect(x: 0, y: 0, width: 94, height: 0))
            topStackView.addArrangedSubview(thumbnail)
            thumbnailViews.append(thumbnail)
        }
        
        for _ in 1...3 {
            let thumbnail = ThumbnailView(frame: CGRect(x: 0, y: 0, width: 94, height: 0))
            bottomStackView.addArrangedSubview(thumbnail)
            thumbnailViews.append(thumbnail)
        }
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        addSubview(stackView)
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
                if startingView is ThumbnailView {
                    make.centerX.equalTo(startingView)
                } else {
                    make.centerX.equalTo(endingView)
                }
                make.width.equalTo(startingView.layer.borderWidth)
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
        
        let nftTag = NFTTagView(logoDimension: 23, fontSize: 16)
        videoView.addSubview(nftTag)
        nftTag.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
        }
    }
    
    private func setArrow(attachedView: UIView, isLeading: Bool) {
        let img = UIImage(named: "arrow")
        let arrow = UIImageView(image: img)
        arrow.contentMode = .scaleAspectFit
        addSubview(arrow)
        arrow.snp.makeConstraints { make in
            let horizontalOffset: CGFloat = 0
            if isLeading {
                make.leading.equalToSuperview().offset(horizontalOffset)
                make.trailing.equalTo(attachedView.snp.leading).offset(horizontalOffset)
            } else {
                make.trailing.equalToSuperview().offset(-horizontalOffset)
                make.leading.equalTo(attachedView.snp.trailing).offset(horizontalOffset)
            }
            make.centerY.equalTo(attachedView)
        }
    }
}
