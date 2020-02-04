//
//  TimeStopsView.swift
//  UBHistory
//
//  Created by Gustavo Rocha on 10/01/20.
//

import Foundation

class TimeStopsView: UIView{
    
     //MARK: UIComponents
    
    lazy var lblTime: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byTruncatingTail
        label.textColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
        label.text = "TEMPO"
        self.addSubview(label)
        return label
    }()
    
    lazy var lblTimeCount: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
        label.text = "03:12"
        self.addSubview(label)
        return label
    }()
    
    //MARK: Vars
  
    var point: Point?
    var settings: UBHistorySettings
    
    init(settings: UBHistorySettings = .default, point: Point?) {
        self.point = point
        self.settings = settings
        super.init(frame: .zero)
        self.setupConstraints()
        self.setupModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Local Functions
    
    func setupConstraints(){
        
        let detailsSettings = self.settings.historyDetailsSettings
        self.lblTime.font = detailsSettings.titlesFont
        self.lblTimeCount.font = detailsSettings.addressFont
        
        self.lblTime.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        self.lblTimeCount.anchor(top: self.lblTime.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, padding: .init(top: 4, left: 0, bottom: 0, right: 0))
    }
    
    func setupModel(){
        self.lblTimeCount.text = self.point?.duration
    }
    
}
