//
//  CZTextCollectionViewCell.swift
//  MyRandom
//
//  Created by ChenZuo on 2017/2/15.
//  Copyright © 2017年 ChenZuo. All rights reserved.
//

import UIKit

class CZTextCollectionViewCell: UICollectionViewCell {
    
    var textLabel: UILabel = {
        
        var textLabel = UILabel()
        textLabel.textColor = RGB(r: 86, g: 86, b: 86)
        textLabel.textAlignment = .center
        textLabel.font = czFont(14)
        textLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 20
        textLabel.layer.cornerRadius = 3
        textLabel.layer.borderWidth = 0.5
        textLabel.layer.borderColor = RGB(r: 86, g: 86, b: 86).cgColor
        return textLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.textLabel)
        setup()
    }
    
    func setup() {
        self.textLabel.snp.makeConstraints { (make) in
            make.size.equalTo(self.contentView)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
