//
//  AddressStopsView.swift
//  UBHistory
//
//  Created by Gustavo Rocha on 10/01/20.
//

import Foundation

class AddressStopsView: UIView{
    
    //MARK: UIComponents
    var point: Point?
    
    lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .hexB9B9B9
        label.text = "ORIGEM"
        self.addSubview(label)
        return label
    }()
    
    lazy var lblFirstAddress: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .hex777777
        label.text = "TESTANDO NOME DO LOCAL TESTANDO NOME DO LOCAL TESTANDO NOME DO LOCAL"
        self.addSubview(label)
        return label
    }()
    
    lazy var lblSecondAddress: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .hexB9B9B9
        label.text = "TESTANDO NOME E NUMERO DA RUA TESTANDO NOME E NUMERO DA RUA TESTANDO NOME E NUMERO DA RUA"
        self.addSubview(label)
        return label
    }()
    
    //MARK: Vars
    
    var settings: UBHistorySettings
    var stop = 0
    
    init(settings: UBHistorySettings = .default, point: Point?, stop: Int) {
        self.stop = stop
        self.point = point
        self.settings = settings
        super.init(frame: .zero)
        self.setupConstraints()
        self.setupModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Local functions
    
    func setupConstraints(){
        
        let detailsSettings = self.settings.historyDetailsSettings
        self.lblTitle.font = detailsSettings.titlesFont
        self.lblFirstAddress.font = detailsSettings.addressFont
        self.lblSecondAddress.font = detailsSettings.addressSubFont
        
        self.lblFirstAddress.textColor = self.point?.visited ?? false  ? .hex777777 : .hexB9B9B9
        
        self.lblTitle.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor)
        self.lblFirstAddress.anchor(top: self.lblTitle.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, padding: .init(top: 4, left: 0, bottom: 0, right: 0))
        self.lblSecondAddress.anchor(top: self.lblFirstAddress.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, padding: .init(top: 2, left: 0, bottom: 0, right: 0))
        
    }
    
    func setupModel(){
        
        guard let _type = self.point?.type else {return}
        
        var type: String {
            switch _type {
            case "origin":
                return .originType
            case "destiny":
                return .destinyType
            case "destination":
                return .destinyType
            case "point":
                return "\(self.stop)ª" + .stopType
            case "stop":
                return "\(self.stop)ª" + .stopType
            default:
                return ""
            }
            
        }
        
        self.lblTitle.text = type.uppercased()
        self.lblFirstAddress.text = self.point?.address?.address
        self.lblSecondAddress.text = "\(self.point?.address?.city ?? "") - \(self.point?.address?.state ?? "") "
    }
    
}
