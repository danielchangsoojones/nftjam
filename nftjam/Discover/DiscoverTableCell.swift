//
//  DiscoverTableCell.swift
//  nftjam
//
//  Created by Daniel Jones on 3/29/22.
//

import UIKit
import SnapKit
import Reusable

class DiscoverTableCell: UITableViewCell, Reusable {
    var thumbnailImgViews: [UIImageView] = []
    private let containerView = UIView()
    let creatorLabel = UILabel()
    let montageTitleLabel = UILabel()
    let currentValueLabel = UILabel()
    let ethValueLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        selectionStyle = .none
        setContainerView()
        addImgs()
        addInformationView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setContainerView() {
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.width.equalTo(290)
            make.height.equalTo(340)
            make.center.equalToSuperview()
        }
    }
    
    private func addImgs() {        
        addImgView(frame: CGRect(x: 0, y: 0, width: 90, height: 135))
        addImgView(frame: CGRect(x: 90, y: 0, width: 120, height: 180))
        addImgView(frame: CGRect(x: 210, y: 0, width: 90, height: 135))
        addImgView(frame: CGRect(x: 0, y: 125, width: 110, height: 165))
        addImgView(frame: CGRect(x: 110, y: 130, width: 110, height: 165))
        addImgView(frame: CGRect(x: 210, y: 120, width: 90, height: 135))
        addImgView(frame: CGRect(x: 0, y: 260, width: 60, height: 90))
        addImgView(frame: CGRect(x: 60, y: 290, width: 60, height: 90))
        addImgView(frame: CGRect(x: 120, y: 280, width: 60, height: 90))
        addImgView(frame: CGRect(x: 180, y: 245, width: 120, height: 180))
        
        
        containerView.bringSubviewToFront(thumbnailImgViews[1])
    }
    
    private func addImgView(frame: CGRect) {
        let imgView = UIImageView(frame: frame)
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        self.containerView.addSubview(imgView)
        thumbnailImgViews.append(imgView)
    }
    
    private func addInformationView() {
        let bottomInfoView = UIView()
        bottomInfoView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        containerView.addSubview(bottomInfoView)
        bottomInfoView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(94)
        }
        
        bottomInfoView.addSubview(currentValueLabel)
        let horizontalInset: CGFloat = 18
        
        creatorLabel.textColor = UIColor.white
        creatorLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        bottomInfoView.addSubview(creatorLabel)
        creatorLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(horizontalInset)
            make.top.equalToSuperview().offset(19)
            make.trailing.equalTo(currentValueLabel)
        }
        
        montageTitleLabel.textColor = creatorLabel.textColor
        montageTitleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        bottomInfoView.addSubview(montageTitleLabel)
        montageTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(creatorLabel)
            make.top.equalTo(creatorLabel.snp.bottom).offset(8)
        }
        
        currentValueLabel.textColor = creatorLabel.textColor
        currentValueLabel.font = creatorLabel.font
        currentValueLabel.text = "Current Montage Value"
        currentValueLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(horizontalInset)
            make.firstBaseline.equalTo(creatorLabel)
        }
        
        ethValueLabel.textColor = creatorLabel.textColor
        ethValueLabel.font = montageTitleLabel.font
        bottomInfoView.addSubview(ethValueLabel)
        ethValueLabel.snp.makeConstraints { make in
            make.trailing.equalTo(currentValueLabel)
            make.firstBaseline.equalTo(montageTitleLabel)
        }
    }
}
