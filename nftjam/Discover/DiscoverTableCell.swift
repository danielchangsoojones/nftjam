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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        setContainerView()
        addImgs()
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
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func addImgs() {
        //photo 1
        addImgView(color: .yellow) { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(96)
            make.width.equalTo(110)
        }
        
        addImgView(color: .blue) { make in
            make.leading.equalTo(self.thumbnailImgViews[0].snp.trailing)
            make.top.equalToSuperview()
            make.height.equalTo(96)
            make.width.equalTo(110)
        }
        
        addImgView(color: .green) { make in
            make.leading.equalTo(self.thumbnailImgViews[1].snp.trailing)
            make.top.equalToSuperview()
            make.height.equalTo(96)
            make.trailing.equalToSuperview()
        }
        
        addImgView(color: .darkGray) { make in
            make.leading.equalToSuperview()
            make.top.equalTo(self.thumbnailImgViews[0].snp.bottom)
            make.height.equalTo(96)
            make.width.equalTo(110)
        }
        
        addImgView(color: .black) { make in
            make.leading.equalTo(self.thumbnailImgViews[3].snp.trailing)
            make.top.equalTo(self.thumbnailImgViews[1].snp.bottom)
            make.height.equalTo(96)
            make.width.equalTo(110)
        }
        
        addImgView(color: .yellow) { make in
            make.leading.equalTo(self.thumbnailImgViews[4].snp.trailing)
            make.top.equalTo(self.thumbnailImgViews[2].snp.bottom)
            make.height.equalTo(96)
            make.trailing.equalToSuperview()
        }
        
        addImgView(color: .yellow) { make in
            make.leading.equalToSuperview()
            make.top.equalTo(self.thumbnailImgViews[3].snp.bottom)
            make.height.equalTo(96)
            make.width.equalTo(110)
        }
        
        addImgView(color: .blue) { make in
            make.leading.equalTo(self.thumbnailImgViews[6].snp.trailing)
            make.top.equalTo(self.thumbnailImgViews[4].snp.bottom)
            make.height.equalTo(96)
            make.width.equalTo(110)
        }
        
        addImgView(color: .gray) { make in
            make.leading.equalTo(self.thumbnailImgViews[7].snp.trailing)
            make.top.equalTo(self.thumbnailImgViews[5].snp.bottom)
            make.height.equalTo(96)
            make.trailing.equalToSuperview()
        }
        
        addImgView(color: .gray) { make in
            make.leading.equalToSuperview()
            make.top.equalTo(self.thumbnailImgViews[6].snp.bottom)
            make.height.equalTo(96)
            make.width.equalTo(110)
        }
        
        addImgView(color: .green) { make in
            make.leading.equalToSuperview()
            make.top.equalTo(self.thumbnailImgViews[6].snp.bottom)
            make.height.equalTo(96)
            make.width.equalTo(110)
        }
        
        addImgView(color: .yellow) { make in
            make.leading.equalTo(self.thumbnailImgViews[9].snp.trailing)
            make.top.equalTo(self.thumbnailImgViews[7].snp.bottom)
            make.height.equalTo(96)
            make.width.equalTo(110)
        }
        
        addImgView(color: .black) { make in
            make.leading.equalTo(self.thumbnailImgViews[11].snp.trailing)
            make.top.equalTo(self.thumbnailImgViews[8].snp.bottom)
            make.height.equalTo(96)
            make.trailing.equalToSuperview()
        }
    }
    
    private func addImgView(color: UIColor, makeConstraints: @escaping (ConstraintMaker) -> Void) {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.backgroundColor = color
        self.containerView.addSubview(imgView)
        imgView.snp.makeConstraints(makeConstraints)
        thumbnailImgViews.append(imgView)
    }
}
