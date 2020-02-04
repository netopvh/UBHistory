//
//  DriverView.swift
//  UBHistory
//
//  Created by Usemobile on 13/03/19.
//

import UIKit

class DriverView: UIView {
    
    lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .hexB9B9B9
        self.addSubview(label)
        return label
    }()
    
    lazy var imvAvatar: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        self.addSubview(imageView)
        return imageView
    }()
    
    lazy var lblName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .hex777777
        self.addSubview(label)
        return label
    }()
    
    lazy var lblVehicle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .hexB9B9B9
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        self.addSubview(label)
        return label
    }()
    
    lazy var lblRate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .hexB9B9B9
        self.addSubview(label)
        return label
    }()
    
    var viewModel: HistoryViewModel {
        didSet {
            self.setupModel()
        }
    }
    var settings: UBHistorySettings {
        didSet {
            self.setupSettings()
        }
    }
    
    init(model: HistoryViewModel, settings: UBHistorySettings = .default) {
        self.settings = settings
        self.viewModel = model
        super.init(frame: .zero)
        self.setup()
        self.setupSettings()
        self.setupModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        let avatarSize: CGFloat = 46
        self.lblTitle.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, padding: .init(top: 16, left: 16, bottom: 0, right: 0))
        self.imvAvatar.anchor(top: self.lblTitle.bottomAnchor, left: self.lblTitle.leftAnchor, bottom: nil, right: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 46, height: avatarSize.dynamic()))
        self.imvAvatar.setCorner((avatarSize/2).dynamic())
        self.lblName.anchor(top: self.imvAvatar.topAnchor, left: self.imvAvatar.rightAnchor, bottom: nil, right: nil, padding: .init(top: 0, left: 8, bottom: 0, right: 0))
        self.lblVehicle.anchor(top: self.lblName.bottomAnchor, left: self.lblName.leftAnchor, bottom: nil, right: self.lblName.rightAnchor)
        self.lblRate.anchor(top: nil, left: self.lblName.rightAnchor, bottom: nil, right: self.rightAnchor, padding: .init(top: 0, left: 6, bottom: 0, right: 16), size: .init(width: 50, height: 0))
        self.lblRate.centerYAnchor.constraint(equalTo: self.imvAvatar.centerYAnchor).isActive = true
        
        
    }
    
    fileprivate func setLblVehicleText() {
        if let _ = self.viewModel.card {
            self.lblVehicle.text = .cardPayment
        } else {
            self.lblVehicle.text = .cashPayment
        }
    }
    
    private func setupModel() {
        let placeholder = self.settings.historyDetailsSettings.avatarPlaceholder ?? UIImage.getFrom(customClass: DriverView.self, nameResource: "avatarPlaceholder")
        if let _model = self.viewModel.user {
            if self.settings.isUserApp {
                self.lblVehicle.text = _model.vehicle
            } else {
                self.setLblVehicleText()
            }
            self.lblName.text = _model.name
            self.lblRate.text = _model.rate
            
            self.imvAvatar.cast(urlStr: _model.profileImage, placeholder: placeholder)
        } else {
            if self.settings.isUserApp {
                self.lblName.text = .driverUnavailable
                self.lblVehicle.text = .rideNotAccepted
                self.imvAvatar.image = placeholder
                self.lblRate.text = ""
            } else {
                self.lblName.text = .passengerUnavailable
                self.setLblVehicleText()
                self.imvAvatar.image = placeholder
                self.lblRate.text = ""
            }
        }
    }
    
    private func setupSettings() {
        self.lblTitle.text = self.settings.isUserApp ? .driver : .passenger
        self.lblTitle.text = self.lblTitle.text?.uppercased()
        let detailsSettings = self.settings.historyDetailsSettings
        
        self.lblTitle.font = detailsSettings.categoryFont
        self.lblName.font = detailsSettings.nameFont
        self.lblVehicle.font = detailsSettings.vehicleFont
        self.lblRate.font = detailsSettings.ratingFont
    }
}
