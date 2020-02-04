//
//  TravelView.swift
//  UBHistory
//
//  Created by Usemobile on 13/03/19.
//

import UIKit
import HCSStarRatingView

class TravelView: UIView {
    
    lazy var lblRatingTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        self.addSubview(label)
        return label
    }()
    
    lazy var ratingView: HCSStarRatingView = {
        let view = HCSStarRatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        self.addSubview(view)
        return view
    }()
    
    lazy var lblNotRated: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = UIColor.hex707070
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        self.addSubview(label)
        return label
    }()
    
    lazy var lblPriceTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.text = .travelValue
        label.textColor = .black
        self.addSubview(label)
        return label
    }()
    
    lazy var lblPriceValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.textColor = .black
        self.addSubview(label)
        return label
    }()
    
    lazy var lblCancelledTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = .travelValue
        label.textColor = .black
        self.addSubview(label)
        return label
    }()
    
    lazy var lblCancelled: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 2
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
    
    private var ratingTop = NSLayoutConstraint()
    
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
        self.lblRatingTitle.anchor(top: self.topAnchor, left: nil, bottom: nil, right: nil, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        self.ratingTop = self.ratingView.topAnchor.constraint(equalTo: self.lblRatingTitle.bottomAnchor, constant: 4)
        self.ratingTop.priority = UILayoutPriority(rawValue: 999)
        self.ratingTop.isActive = true
        let ratingCenterY = self.ratingView.centerYAnchor.constraint(equalTo: self.lblPriceValue.centerYAnchor)
        ratingCenterY.priority = UILayoutPriority(rawValue: 750)
        ratingCenterY.isActive = true
        self.ratingView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        self.ratingView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        if self.settings.hasPaymentInfos {
            self.lblRatingTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
            self.ratingView.leftAnchor.constraint(equalTo: self.lblRatingTitle.leftAnchor, constant: 0).isActive = true
        } else {
            self.lblRatingTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            self.ratingView.centerXAnchor.constraint(equalTo: self.lblRatingTitle.centerXAnchor).isActive = true
        }
        self.lblNotRated.anchor(top: nil, left: self.lblRatingTitle.leftAnchor, bottom: nil, right: nil)
        if self.settings.hasPaymentInfos {
            self.lblNotRated.centerYAnchor.constraint(equalTo: self.lblPriceValue.centerYAnchor).isActive = true
            self.lblNotRated.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor, constant: -4).isActive = true
        } else {
            self.lblNotRated.centerYAnchor.constraint(equalTo: self.lblPriceValue.centerYAnchor).isActive = true    
        }
        self.lblPriceTitle.anchor(top: self.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 16))
        let cnst = self.lblPriceValue.topAnchor.constraint(greaterThanOrEqualTo: self.lblPriceTitle.bottomAnchor, constant: 4)
        cnst.isActive = true
        self.lblPriceValue.anchor(top: nil, left: self.ratingView.rightAnchor, bottom: nil, right: self.lblPriceTitle.rightAnchor, padding: .init(top: 4, left: 30, bottom: 0, right: 0))
        self.lblCancelledTitle.anchor(top: self.lblPriceTitle.topAnchor, left: self.lblCancelled.leftAnchor, bottom: self.lblCancelled.topAnchor, right: self.lblCancelled.rightAnchor, padding: .init(top: 0, left: 0, bottom: 4, right: 0))
        self.lblCancelled.anchor(top: nil, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, padding: .init(top: 0, left: 16, bottom: 8, right: 16))
    }
    
    private func setupModel() {
        let cancelled = self.viewModel.cancelled
        self.lblCancelled.text = cancelled?.uppercased()
        self.lblCancelled.isHidden = cancelled == nil
        self.lblCancelledTitle.isHidden = cancelled == nil
        
        let rate = self.viewModel.rate
        self.lblNotRated.isHidden = cancelled == nil ? (rate != nil) : true
        self.lblRatingTitle.isHidden = cancelled == nil ? (rate == nil) : true
        self.ratingView.isHidden = cancelled == nil ? (rate == nil) : true
        self.ratingView.value = rate ?? 0
        
        self.lblPriceValue.isHidden = cancelled != nil
        self.lblPriceTitle.isHidden = cancelled != nil
        self.ratingTop.priority = UILayoutPriority(self.settings.hasPaymentInfos ? 250 : 999)
        
        if self.settings.hasPaymentInfos {
            if let value = self.viewModel.value, cancelled == nil {
                let length = value.first == "R" ? 2 : 1
                let attributedText = NSMutableAttributedString(string: value, attributes: [NSAttributedString.Key.font : self.settings.historyDetailsSettings.priceFont, NSAttributedString.Key.foregroundColor: self.settings.mainColor])
                attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1), range: NSRange(location:0,length:length))
                self.lblPriceValue.attributedText = attributedText
            } else {
                self.lblPriceTitle.text = nil
            }
        } else {
            self.lblPriceValue.text = nil
            self.lblPriceTitle.text = nil
            self.lblCancelledTitle.text = nil
        }
        
    }
    
    private func setupSettings() {
        let text: String = self.settings.isUserApp ? .driver : .passenger
        self.lblRatingTitle.text = .rated + text.uppercased()
        self.lblNotRated.text = .noRated + " " + text
        
        let detailsSettings = self.settings.historyDetailsSettings
        self.lblRatingTitle.font = detailsSettings.titlesFont
        self.lblCancelledTitle.font = detailsSettings.titlesFont
        self.lblPriceTitle.font = detailsSettings.titlesFont
        self.lblCancelled.font = detailsSettings.titlesFont
        
        self.lblPriceValue.textColor = self.settings.mainColor
        self.lblCancelled.textColor = .cancelledRed
        
        let starFilled = detailsSettings.starFilled ?? UIImage.getFrom(customClass: HistoryLeftView.self, nameResource: "starFilled")
        self.ratingView.filledStarImage = starFilled
        let starEmpty = detailsSettings.starEmpty ?? UIImage.getFrom(customClass: HistoryLeftView.self, nameResource: "starEmpty")
        self.ratingView.emptyStarImage = starEmpty
        
        self.lblNotRated.textAlignment = self.settings.hasPaymentInfos ? .left : .center
        
    }
}
