//
//  DetailsBottomView.swift
//  UBHistory
//
//  Created by Usemobile on 14/03/19.
//

import UIKit

class DetailsBottomView: UIView {
    
    lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .hexB9B9B9
        self.addSubview(label)
        return label
    }()
    
    lazy var lblFirst: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .hex777777
        self.addSubview(label)
        return label
    }()
    
    lazy var lblSecond: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .hex777777
        self.addSubview(label)
        return label
    }()
    
    enum BottomTypes {
        case time
        case distance
        case order
    }
    
    var type: BottomTypes
    var settings: HistoryDetailsSettings {
        didSet {
            self.setupSettings()
        }
    }
    
    init(type: BottomTypes, settings: HistoryDetailsSettings = .default) {
        self.type = type
        self.settings = settings
        super.init(frame: .zero)
        self.setup()
        self.setupSettings()
        switch self.type {
        case .time:
            self.lblTitle.text = .dayAndHour
        case .distance:
            self.lblTitle.text = .distanceAndTime
        case .order:
            self.lblTitle.text = .serviceOrder
        }
        self.lblTitle.text = self.lblTitle.text?.uppercased()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.lblTitle.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor)
        self.lblFirst.anchor(top: self.lblTitle.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, padding: .init(top: 12, left: 4, bottom: 0, right: 4))
        self.lblSecond.anchor(top: self.lblFirst.bottomAnchor, left: self.lblFirst.leftAnchor, bottom: nil, right: self.lblFirst.rightAnchor)
    }
    
    private func setupSettings() {
        self.lblTitle.font = self.settings.titlesFont
        self.lblFirst.font = self.settings.dayFont
        self.lblSecond.font = self.settings.timeFont
    }
    
    func fillUI(firstText: String?, secondText: String?) {
        self.lblFirst.text = firstText
        self.lblSecond.text = secondText
    }
    
}
