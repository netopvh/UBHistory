//
//  ReceiptButtonCell.swift
//  UBHistory
//
//  Created by Usemobile on 06/06/19.
//

import UIKit

class ReceiptButtonCell: UITableViewCell {
    
    lazy var btnReceipt: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.btnReceiptPressed(_:)), for: .touchUpInside)
        self.contentView.addSubview(button)
        return button
    }()

    var btnReceiptPressed: (() -> Void)?
    
    var settings: UBHistorySettings? {
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
        self.btnReceipt.anchor(top: self.contentView.topAnchor, left: nil, bottom: self.contentView.bottomAnchor, right: nil, size: .init(width: 0, height: 44))
        self.btnReceipt.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
    
    private func fillModel() {
        guard let settings = self.settings else { return }
        let color = settings.mainColor
        let attributedText = NSMutableAttributedString(string: .shareReceipt, attributes: [NSAttributedString.Key.font: settings.historyDetailsSettings.buttonFont, NSAttributedString.Key.foregroundColor: color,
                                                                                           NSAttributedString.Key.underlineStyle: 1, NSAttributedString.Key.underlineColor: color])
        self.btnReceipt.setAttributedTitle(attributedText, for: .normal)
    }
    
    @objc func btnReceiptPressed(_ sender: UIButton) {
        self.btnReceiptPressed?()
    }

}
