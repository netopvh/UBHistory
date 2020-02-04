//
//  ReceiptCell.swift
//  UBHistory
//
//  Created by Usemobile on 06/06/19.
//

import UIKit

class ReceiptCell: UITableViewCell {
    
    lazy var containerView: UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        return view
    }()
    
    lazy var lblLeft: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        self.containerView.addSubview(label)
        return label
    }()
    
    lazy var lblRight: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        self.containerView.addSubview(label)
        return label
    }()
    
    var viewModel: HistoryReceiptModel? {
        didSet {
            self.fillModel()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.contentView.backgroundColor = .white
        let padding: CGFloat = 16
        self.containerView.fillSuperview(with: .init(top: padding, left: padding, bottom: 0, right: padding))
        
        self.lblLeft.anchor(top: self.containerView.topAnchor, left: self.containerView.leftAnchor, bottom: self.containerView.bottomAnchor, right: nil)
        self.lblRight.anchor(top: self.containerView.topAnchor, left: self.lblLeft.rightAnchor, bottom: self.containerView.bottomAnchor, right: self.containerView.rightAnchor)
    }
    
    private func fillModel() {
        self.lblLeft.attributedText = self.viewModel?.leftText
        self.lblRight.attributedText = self.viewModel?.rightText
    }

}
