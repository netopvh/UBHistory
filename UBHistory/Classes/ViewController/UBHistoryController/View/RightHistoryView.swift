//
//  RightHistoryView.swift
//  UBHistory
//
//  Created by Usemobile on 12/03/19.
//

import UIKit

class RightHistoryView: UIView {
    
    lazy var imvOrigin: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        return imageView
    }()
    
    lazy var imvRoute: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        return imageView
    }()
    
    lazy var imvDestiny: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        return imageView
    }()
    
    lazy var lblOrigin: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.7
        self.addSubview(label)
        return label
    }()
    
    lazy var lblDestiny: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.7
        self.addSubview(label)
        return label
    }()
    
    lazy var btnDelete: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(self.deletePressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = self.settings.originColor
        let insetPadding: CGFloat = 12
        button.imageEdgeInsets = UIEdgeInsets(top: insetPadding, left: insetPadding, bottom: insetPadding, right: insetPadding)
        self.addSubview(button)
        return button
    }()
    
    var viewModel: HistoryViewModel? {
        didSet {
            self.setupModel()
        }
    }
    
    var settings: RightViewSettings = .default {
        didSet {
            self.setupSettings()
        }
    }
    
    var hasDelete: Bool = false {
        didSet {
            self.cnstDeleteWidth.priority = UILayoutPriority(self.hasDelete ? 999 : 250)
            self.cnstDeleteHeight.priority = UILayoutPriority(self.hasDelete ? 999 : 250)
            self.btnDelete.isHidden = !self.hasDelete
            self.layoutIfNeeded()
        }
    }
    
    var deleteAction: (() -> Void)?
    
    let routeColor: UIColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    let destinyColor: UIColor = #colorLiteral(red: 0.3254901961, green: 0.3254901961, blue: 0.3254901961, alpha: 1)
    
    private var cnstDeleteWidth = NSLayoutConstraint()
    private var cnstDeleteHeight = NSLayoutConstraint()
    
    init() {
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.imvOrigin.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, padding: .init(top: 16, left: 14, bottom: 0, right: 0), size: .init(width: 10, height: 10))
        
        self.imvRoute.anchor(top: self.imvOrigin.bottomAnchor, left: nil, bottom: nil, right: nil, padding: .init(top: 2, left: 0, bottom: 0, right: 0), size: .init(width: 10, height: 42))
        self.imvRoute.centerXAnchor.constraint(equalTo: self.imvOrigin.centerXAnchor).isActive = true
        
        self.imvDestiny.anchor(top: self.imvRoute.bottomAnchor, left: nil, bottom: nil, right: nil, size: .init(width: 10, height: 12))
        self.imvDestiny.centerXAnchor.constraint(equalTo: self.imvRoute.centerXAnchor).isActive = true
        
        self.lblOrigin.anchor(top: nil, left: self.imvOrigin.rightAnchor, bottom: nil, right: self.btnDelete.leftAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 4))
        self.lblOrigin.centerYAnchor.constraint(equalTo: self.imvOrigin.centerYAnchor).isActive = true
        
        self.lblDestiny.anchor(top: nil, left: self.imvDestiny.rightAnchor, bottom: nil, right: self.lblOrigin.rightAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 0))
        self.lblDestiny.centerYAnchor.constraint(equalTo: self.imvDestiny.centerYAnchor).isActive = true
        
        let deleteWidth = self.btnDelete.widthAnchor.constraint(equalToConstant: 0)
        deleteWidth.priority = UILayoutPriority(750)
        let deleteHeight = self.btnDelete.heightAnchor.constraint(equalToConstant: 0)
        deleteHeight.priority = UILayoutPriority(750)
        self.cnstDeleteWidth = self.btnDelete.widthAnchor.constraint(equalToConstant: 44)
        self.cnstDeleteWidth.priority = UILayoutPriority(999)
        self.cnstDeleteHeight = self.btnDelete.heightAnchor.constraint(equalToConstant: 44)
        self.cnstDeleteHeight.priority = UILayoutPriority(999)
        self.addConstraints([
            self.btnDelete.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.btnDelete.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -2),
            deleteWidth,
            deleteHeight,
            self.cnstDeleteWidth,
            self.cnstDeleteHeight
        ])
    }
    
    private func setupSettings() {
        self.lblOrigin.font = self.settings.originFont
        self.lblOrigin.textColor = self.settings.originColor
        
        self.lblDestiny.font = self.settings.destinyFont
        self.lblDestiny.textColor = self.settings.destinyColor
        
        let imageOrigin = self.settings.imageOrigin ?? UIImage.getFrom(customClass: RightHistoryView.self, nameResource: "circle")
        self.imvOrigin.image = imageOrigin?.withRenderingMode(.alwaysTemplate)
        
        let imageRoute = self.settings.imageRoute ?? UIImage.getFrom(customClass: RightHistoryView.self, nameResource: "dots")
        self.imvRoute.image = imageRoute?.withRenderingMode(.alwaysTemplate)
        
        let imageDestiny = self.settings.imageDestiny ?? UIImage.getFrom(customClass: RightHistoryView.self, nameResource: "pin")
        self.imvDestiny.image = imageDestiny?.withRenderingMode(.alwaysTemplate)
        
        let trashImage = self.settings.imageTrash ?? UIImage.getFrom(customClass: RightHistoryView.self, nameResource: "trash")
        self.btnDelete.setImage(trashImage?.withRenderingMode(.alwaysTemplate), for: .normal)
        
        self.imvOrigin.tintColor = self.settings.originTintColor
        self.imvRoute.tintColor = self.routeColor
        self.imvDestiny.tintColor = self.destinyColor
        self.btnDelete.tintColor = self.settings.originTintColor
    }
    
    private func setupModel() {
        guard let _model = self.viewModel else { return }
        
        self.lblOrigin.text = _model.originFull
        self.lblDestiny.text = _model.destinyFull
        
        self.imvOrigin.tintColor = _model.cancelled == nil ? self.settings.originTintColor : (self.settings.cancelledTintColor ?? .cancelledRed)
    }
    
    func setSelection(selected: Bool) {
        self.lblOrigin.textColor = selected ? .white : self.settings.originColor
        self.lblDestiny.textColor = selected ? .white : self.settings.destinyColor
        
        let color = selected ? .white : (self.viewModel?.cancelled == nil ? self.settings.originTintColor : (self.settings.cancelledTintColor ?? .cancelledRed))
        self.imvOrigin.tintColor = color
        self.btnDelete.tintColor = color
        self.imvRoute.tintColor = selected ? .white : self.routeColor
        self.imvDestiny.tintColor = selected ? .white : self.destinyColor
    }
    
    @objc func deletePressed() {
        self.deleteAction?()
    }
}
