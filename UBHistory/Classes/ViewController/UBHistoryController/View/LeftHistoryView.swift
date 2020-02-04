//
//  LeftHistoryView.swift
//  UBHistory
//
//  Created by Usemobile on 12/03/19.
//
import UIKit
import HCSStarRatingView
class HistoryLeftView: UIView {
    
    lazy var lblValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        self.addSubview(label)
        return label
    }()
    
    lazy var lblNotRated: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = .notRatedText
        label.textAlignment = .right
        label.isHidden = true
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
    
    lazy var lblDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        self.addSubview(label)
        return label
    }()
    
    lazy var lblTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        self.addSubview(label)
        return label
    }()
    
    lazy var lblCancelled: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .right
        label.isHidden = true
        self.addSubview(label)
        return label
    }()
    
    lazy var lblServiceOrder: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .right
        self.addSubview(label)
        return label
    }()
    
    var viewMoodel: HistoryViewModel? {
        didSet {
            self.setupModel()
        }
    }
    var settings: LeftViewSettings = .default {
        didSet {
            self.setupSettings()
        }
    }
    var hasPaymentInfos: Bool = true
    var hasIdOrder: Bool = true
    
    init() {
        super.init(frame: .zero)
//        self.setup()
        self.preSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        self.setup()
        self.preSetup()
    }
    
    func preSetup(){
        if self.hasIdOrder{
            self.setup()
        }else{
            self.setupNoOrderView()
        }
    }
    
    private func setup() {
        self.lblValue.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, padding: .init(top: 12, left: 4, bottom: 0, right: 8))
        
        self.ratingView.anchor(top: self.lblValue.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, padding: .init(top: 4, left: 20, bottom: 0, right: 5), size: .init(width: 0, height: 12))
        
        self.lblTime.anchor(top: nil, left: nil, bottom: self.lblServiceOrder.topAnchor, right: self.rightAnchor, padding: .init(top: 0, left: 0, bottom: 5, right: 8))
        
        self.lblServiceOrder.anchor(top: self.lblTime.bottomAnchor, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, padding: .init(top: 4, left: 27, bottom: 4, right: 8))
        
        self.lblDate.anchor(top: nil, left: nil, bottom: self.lblTime.topAnchor, right: self.lblTime.rightAnchor)
        
        self.lblNotRated.anchor(top: self.lblValue.bottomAnchor, left: self.lblValue.leftAnchor, bottom: nil, right: self.lblValue.rightAnchor, padding: .init(top: 4, left: 0, bottom: 0, right: 0))
        
        self.lblCancelled.topAnchor.constraint(equalTo: self.topAnchor, constant: 14).isActive = true
        self.lblCancelled.centerXAnchor.constraint(equalTo: self.lblValue.centerXAnchor).isActive = true
        
    }
    
    private func setupSettings() {
        self.lblValue.font = self.settings.valueFont
        self.lblValue.textColor = self.settings.valueColor
        
        self.lblCancelled.font = self.settings.cancelledFont
        self.lblCancelled.textColor = self.settings.cancelledColor
        
        self.lblNotRated.font = self.settings.notRatedFont
        self.lblNotRated.textColor = self.settings.notRatedColor
        
        self.lblDate.font = self.settings.dateFont
        self.lblDate.textColor = self.settings.dateColor
        
        self.lblTime.font = self.settings.timeFont
        self.lblTime.textColor = self.settings.timeColor
        
        self.lblServiceOrder.font = self.settings.serviceOrderFont
        self.lblServiceOrder.textColor = self.settings.serviceOrderColor
        
        let starFilled = self.settings.starFilled ?? UIImage.getFrom(customClass: HistoryLeftView.self, nameResource: "starFilled")
        self.ratingView.filledStarImage = starFilled
        let starEmpty = self.settings.starEmpty ?? UIImage.getFrom(customClass: HistoryLeftView.self, nameResource: "starEmpty")
        self.ratingView.emptyStarImage = starEmpty
    }
    
    private func setupModel() {
        guard let _model = self.viewMoodel else { return }
        
        let cancelled = _model.cancelled
        self.lblCancelled.text = cancelled
        self.lblCancelled.isHidden = cancelled == nil
        
        let rate = _model.rate
        self.lblNotRated.isHidden = cancelled == nil ? (rate != nil) : true
        self.ratingView.isHidden = cancelled == nil ? (rate == nil) : true
        self.ratingView.value = rate ?? 0
        
        self.lblValue.text = self.hasPaymentInfos ? _model.value : nil
        self.lblValue.isHidden = cancelled != nil
        
        self.lblDate.text = _model.day
        self.lblTime.text = _model.time
        
        guard let _order = self.viewMoodel?.serviceOrder else {
            self.lblServiceOrder.text = nil
            self.lblServiceOrder.isHidden = true
            return
        }
        self.lblServiceOrder.text =  "ID:\( _order)"
        self.lblServiceOrder.isHidden = false
    }
    
    func setSelection(selected: Bool) {
        self.lblValue.textColor = selected ? .white : self.settings.valueColor
        self.lblCancelled.textColor = selected ? .white : self.settings.cancelledColor
        self.lblNotRated.textColor = selected ? .white : self.settings.notRatedColor
        self.lblDate.textColor = selected ? .white : self.settings.dateColor
        self.lblTime.textColor = selected ? .white : self.settings.timeColor
        self.lblServiceOrder.textColor = selected ? .white : self.settings.serviceOrderColor
    }
    
    func setupNoOrderView(){
        self.lblValue.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, padding: .init(top: 12, left: 4, bottom: 0, right: 8))
        
        self.ratingView.anchor(top: self.lblValue.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, padding: .init(top: 4, left: 20, bottom: 0, right: 5), size: .init(width: 0, height: 12))
        
        self.lblTime.anchor(top: nil, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, padding: .init(top: 0, left: 0, bottom: 5, right: 8))
        
        self.lblDate.anchor(top: nil, left: nil, bottom: self.lblTime.topAnchor, right: self.lblTime.rightAnchor)
        
        self.lblNotRated.anchor(top: self.lblValue.bottomAnchor, left: self.lblValue.leftAnchor, bottom: nil, right: self.lblValue.rightAnchor, padding: .init(top: 4, left: 0, bottom: 0, right: 0))
        
        self.lblCancelled.topAnchor.constraint(equalTo: self.topAnchor, constant: 14).isActive = true
        self.lblCancelled.centerXAnchor.constraint(equalTo: self.lblValue.centerXAnchor).isActive = true
    }
    
}

