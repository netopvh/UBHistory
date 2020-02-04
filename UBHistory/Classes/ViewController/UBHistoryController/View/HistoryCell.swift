//
//  HistoryCell.swift
//  UBHistory
//
//  Created by Usemobile on 12/03/19.
//

import UIKit

class HistoryCell: UITableViewCell {
    
    lazy var shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        self.contentView.addSubview(view)
        return view
    }()
    
    lazy var circleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        self.shadowView.addSubview(view)
        return view
    }()
    
    lazy var leftView: HistoryLeftView = {
        let view = HistoryLeftView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        self.circleView.addSubview(view)
        return view
    }()
    
    lazy var borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 0.1)
        self.circleView.addSubview(view)
        return view
    }()
    
    lazy var rightView: RightHistoryView = {
        let view = RightHistoryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        self.circleView.addSubview(view)
        return view
    }()
    
    var viewModel: HistoryViewModel? {
        didSet {
            self.leftView.hasIdOrder = self.viewModel?.serviceOrder != nil ? true :false
            self.leftView.viewMoodel = self.viewModel
            self.rightView.viewModel = self.viewModel
        }
    }
    var settings: UBHistorySettings = .default {
        didSet {
            self.hasPaymentInfos = self.settings.hasPaymentInfos
            self.leftView.settings = self.settings.leftViewSettings
            self.rightView.settings = self.settings.rightViewSettings
        }
    }
    var hasPaymentInfos: Bool = true {
        didSet {
            self.leftView.hasPaymentInfos = self.hasPaymentInfos
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
        self.selectionStyle = .none
        self.shadowView.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: nil, right: self.contentView.rightAnchor, padding: .init(top: 10, left: 16, bottom: 10, right: 16), size: .init(width: 0, height: 100))
        let bottom = self.shadowView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        bottom.priority = UILayoutPriority(rawValue: 750)
        bottom.isActive = true
        self.circleView.fillSuperview()
        
        self.shadowView.applyCustomShadowToCircle(shadowOpacity: 0.3, shadowRadius: 3)
        self.circleView.setCorner(10)
        
        self.leftView.anchor(top: self.circleView.topAnchor, left: self.circleView.leftAnchor, bottom: self.circleView.bottomAnchor, right: nil, size: .init(width: 100, height: 0))
        self.borderView.anchor(top: self.circleView.topAnchor, left: self.leftView.rightAnchor, bottom: self.circleView.bottomAnchor, right: nil, padding: .init(top: 12, left: 0, bottom: 12, right: 0), size: .init(width: 1, height: 0))
        self.rightView.anchor(top: self.circleView.topAnchor, left: self.borderView.rightAnchor, bottom: self.circleView.bottomAnchor, right: self.circleView.rightAnchor)
        self.rightView.hasDelete = false
    }
    
    func setSelection(selected: Bool) {
        self.circleView.backgroundColor = selected ? self.settings.mainColor : .white
        self.rightView.setSelection(selected: selected)
        self.leftView.setSelection(selected: selected)
    }
}

