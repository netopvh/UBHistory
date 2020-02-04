//
//  FailureView.swift
//  UBHistory
//
//  Created by Usemobile on 15/03/19.
//

import Foundation
import UIKit

class FailureView: UIView {
    
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
        label.text = .historyListFail
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var btnRetry: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(.retryTitle, for: .normal)
        self.contentView.addSubview(button)
        return button
    }()
    
    var settings: UBHistorySettings
    
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
        
        self.imageView.anchor(top: self.contentView.topAnchor, left: nil, bottom: nil, right: nil, size: .init(width: 80, height: 68))
        self.imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        
        self.label.anchor(top: self.imageView.bottomAnchor, left: self.contentView.leftAnchor, bottom: nil, right: self.contentView.rightAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        
        self.btnRetry.anchor(top: self.label.bottomAnchor, left: nil, bottom: self.contentView.bottomAnchor, right: nil, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 50))
        self.btnRetry.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.btnRetry.setCorner(25)
        
    }
    
    private func setupSettings() {
        self.imageView.image = (self.settings.emptyImage ?? UIImage.getFrom(customClass: EmptyHistoryView.self, nameResource: "emptyHistory"))?.withRenderingMode(.alwaysTemplate)
        self.label.font = self.settings.emptyFont
        
        self.btnRetry.backgroundColor = self.settings.mainColor
        self.btnRetry.setTitleColor(self.settings.retryTitleColor, for: .normal)
        self.btnRetry.titleLabel?.font = self.settings.retryFont
    }
}
