//
//  EmptyHistoryView.swift
//  UBHistory
//
//  Created by Usemobile on 15/03/19.
//

import Foundation
import UIKit

class EmptyHistoryView: UIView {
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)
        self.contentView.addSubview(imageView)
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)
        self.contentView.addSubview(label)
        return label
    }()
    
    enum ViewTypes: String {
        case history
        case schedules
        
        func getImage() -> UIImage? {
            return UIImage.getFrom(customClass: EmptyHistoryView.self, nameResource: "empty" + self.rawValue.capitalized)
        }
        
        func getText() -> String {
            switch self {
            case .history:
                return .emptyHistory
            case .schedules:
                return .emptySchedules
            }
        }
    }
    
    var settings: UBHistorySettings
    
    var type: ViewTypes = .history {
        didSet {
            self.imageView.image = self.type.getImage()
            self.label.text = self.type.getText()
        }
    }
    
    init(settings: UBHistorySettings = .default) {
        self.settings = settings
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.setup()
        self.setupSettings()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.contentView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        let heightAnchor = self.imageView.heightAnchor.constraint(equalToConstant: 0)
        heightAnchor.priority = .defaultLow
        let widthAnchor = self.imageView.widthAnchor.constraint(equalToConstant: 0)
        widthAnchor.priority = .defaultLow
        self.addConstraints([
            heightAnchor,
            widthAnchor,
            self.imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.imageView.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor)
        ])
        //        self.imageView.anchor(top: self.contentView.topAnchor, left: nil, bottom: nil, right: nil, size: .init(width: 80, height: 68))
        //        self.imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        
        self.label.anchor(top: self.imageView.bottomAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
    }
    
    private func setupSettings() {
        self.type = .history
        self.label.font = self.settings.emptyFont
        
        DispatchQueue.main.async {
            self.layoutIfNeeded()
        }
    }
}
