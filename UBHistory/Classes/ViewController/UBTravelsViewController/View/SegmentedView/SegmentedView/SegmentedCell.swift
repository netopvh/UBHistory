//
//  SegmentedCell.swift
//  SegmentedTest
//
//  Created by Usemobile on 13/08/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import UIKit

class SegmentedCell: UICollectionViewCell {
    
    lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
        self.addSubview(label)
        return label
    }()
    
    var titleFont: UIFont? {
        didSet {
            self.lblTitle.font = self.titleFont
        }
    }
    var title: String = "" {
        didSet {
            self.lblTitle.text = self.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.lblTitle.fillSuperview(with: .init(top: 0, left: 0, bottom: 4, right: 0))
    }
    
    public func select() {
        self.select(percentual: 1)
    }
    
    public func deselect() {
        self.select(percentual: 0)
    }
    
    public func select(percentual: CGFloat) {
        // percentual = (x - 128) / (0 - 128)
        // percentual * (0 - 128) = ( x - 128 )
        // percentual * (0 - 128) + 128 = x
        let refGrayValue: CGFloat = 64
        let refBlackValue: CGFloat = 255
        let rgbValue: CGFloat = (refGrayValue + (percentual * (refBlackValue - refGrayValue))) / 255
        let color = UIColor(red: rgbValue, green: rgbValue, blue: rgbValue, alpha: 1)
        self.lblTitle.textColor = color
    }
    
}
