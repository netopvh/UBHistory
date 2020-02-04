//
//  HelpCell.swift
//  UBHistory
//
//  Created by Usemobile on 14/03/19.
//

import UIKit

class HelpCell: UITableViewCell {
    
    lazy var imvIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        self.contentView.addSubview(imageView)
        return imageView
    }()
    
    lazy var lblText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
        self.contentView.addSubview(label)
        return label
    }()
    
    lazy var imvArrow: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        self.contentView.addSubview(imageView)
        return imageView
    }()
    
    lazy var borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.hex707070.withAlphaComponent(0.1)
        self.contentView.addSubview(view)
        return view
    }()
    
    var settings: UBHistorySettings = .default {
        didSet {
            self.setupSettings()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setup() {
        self.contentView.backgroundColor = .white
        self.imvIcon.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: nil, right: nil, padding: .init(top: 15, left: 18, bottom: 0, right: 0), size: .init(width: 15, height: 15))
        self.lblText.anchor(top: nil, left: self.imvIcon.rightAnchor, bottom: nil, right: self.imvArrow.leftAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12))
        self.lblText.centerYAnchor.constraint(equalTo: self.imvIcon.centerYAnchor).isActive = true
        self.imvArrow.anchor(top: nil, left: nil, bottom: nil, right: self.contentView.rightAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 18), size: .init(width: 26, height: 26))
        self.imvArrow.centerYAnchor.constraint(equalTo: self.imvIcon.centerYAnchor).isActive = true
        self.borderView.anchor(top: self.imvIcon.bottomAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 1))
        
    }
    
    private func setupSettings() {
        let _settings = self.settings.historyDetailsSettings
        self.imvIcon.image = (_settings.helpImage ?? UIImage.getFrom(customClass: HelpCell.self, nameResource: "help"))?.withRenderingMode(.alwaysTemplate)
        self.imvIcon.tintColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
        self.imvArrow.image = (_settings.helpArrow ?? UIImage.getFrom(customClass: HelpCell.self, nameResource: "arrow"))?.withRenderingMode(.alwaysTemplate)
        self.imvArrow.tintColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
        self.lblText.font = _settings.helpFont
    }
    
    
    func setSelection(selected: Bool) {
        self.contentView.backgroundColor = selected ? self.settings.mainColor : .white
        self.lblText.textColor = selected ? .white : #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
        self.imvIcon.tintColor = selected ? .white : #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
        self.imvArrow.tintColor = selected ? .white : #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
    }
    
}
