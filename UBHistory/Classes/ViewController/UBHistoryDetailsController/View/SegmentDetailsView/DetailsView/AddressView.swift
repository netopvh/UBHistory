//
//  AddressView.swift
//  UBHistory
//
//  Created by Usemobile on 14/03/19.
//

import UIKit

class AddressView: UIView {
    
    enum AddressTypes {
        case origin
        case destiny
        case stop
    }
    
    lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .hexB9B9B9
        self.addSubview(label)
        return label
    }()
    
    lazy var lblFirstAddress: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = .hex777777
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        self.addSubview(label)
        return label
    }()
    
    lazy var lblSecondAddress: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .hexB9B9B9
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        self.addSubview(label)
        return label
    }()
    
    var type: AddressTypes
    var viewModel: HistoryViewModel
    var settings: UBHistorySettings {
        didSet {
            self.setupSettings()
        }
    }
    
    init(type: AddressTypes, model: HistoryViewModel, settings: UBHistorySettings = .default) {
        self.type = type
        self.viewModel = model
        self.settings = settings
        super.init(frame: .zero)
        self.setup()
        self.setupSettings()
        self.setupModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.lblTitle.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor)
        self.lblFirstAddress.anchor(top: self.lblTitle.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, padding: .init(top: 4, left: 0, bottom: 0, right: 0))
        self.lblSecondAddress.anchor(top: self.lblFirstAddress.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, padding: .init(top: 2, left: 0, bottom: 0, right: 0))
        let secondAddressBottom = self.lblSecondAddress.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        secondAddressBottom.priority = UILayoutPriority(250)
        secondAddressBottom.isActive = true
    }
    
    private func setupSettings() {
        let detailsSettings = self.settings.historyDetailsSettings
        self.lblTitle.font = detailsSettings.titlesFont
        self.lblFirstAddress.font = detailsSettings.addressFont
        self.lblSecondAddress.font = detailsSettings.addressSubFont
    }
    
    private func setupModel() {
        switch self.type {
        case .origin:
            self.lblTitle.text = .origin
        case .destiny:
            self.lblTitle.text = .destiny
        case .stop:
            self.lblTitle.text = .stop
        }
        self.lblTitle.text = self.lblTitle.text?.uppercased()
        
        self.lblFirstAddress.text = self.type == .origin ? self.viewModel.originFirstLine : self.viewModel.destinyFirstLine
        self.lblSecondAddress.text = self.type == .origin ? self.viewModel.originSecondLine : self.viewModel.destinySecondLine
    }
}
