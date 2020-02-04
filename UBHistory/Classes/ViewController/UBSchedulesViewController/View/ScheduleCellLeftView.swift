//
//  ScheduleCellLeftView.swift
//  UBHistory
//
//  Created by Usemobile on 25/09/19.
//

import UIKit

class ScheduleCellLeftView: UIView {
    
    lazy var lblDay: UILabel = {
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
    
    lazy var lblCategoryTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.text = .category
        self.addSubview(label)
        return label
    }()
    
    lazy var lblCategory: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        self.addSubview(label)
        return label
    }()
    
    var viewModel: HistoryViewModel? {
        didSet {
            self.setupModel()
        }
    }
    var settings: ScheduleLeftViewSettings = .default {
        didSet {
            self.setupSettings()
        }
    }
    var hasPaymentInfos: Bool = true
    
    init() {
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.lblDay.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, padding: .init(top: 12, left: 4, bottom: 0, right: 8))
        self.lblTime.anchor(top: self.lblDay.bottomAnchor, left: self.lblDay.leftAnchor, bottom: nil, right: self.lblDay.rightAnchor)
        self.lblCategoryTitle.anchor(top: nil, left: self.lblTime.leftAnchor, bottom: nil, right: self.lblTime.rightAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        self.lblCategory.anchor(top: self.lblCategoryTitle.bottomAnchor, left: self.lblCategoryTitle.leftAnchor, bottom: self.bottomAnchor, right: self.lblCategoryTitle.rightAnchor, padding: .init(top: 0, left: 0, bottom: 5, right: 0))
    }
    
    private func setupSettings() {
        self.lblDay.font = self.settings.dayFont
        self.lblDay.textColor = self.settings.dayColor
        
        self.lblTime.font = self.settings.timeFont
        self.lblTime.textColor = self.settings.timeColor
        
        self.lblCategoryTitle.font = self.settings.categoryTitleFont
        self.lblCategoryTitle.textColor = self.settings.categoryTitleColor
        
        self.lblCategory.font = self.settings.categoryFont
        self.lblCategory.textColor = self.settings.categoryColor
    }
    
    private func setupModel() {
        guard let _model = self.viewModel else { return }
        
        self.lblDay.text = _model.day
        self.lblTime.text = _model.time
        
        self.lblCategory.text = _model.category
    }
    
    func setSelection(selected: Bool) {
        self.lblDay.textColor = selected ? .white : self.settings.dayColor
        self.lblTime.textColor = selected ? .white : self.settings.timeColor
        self.lblCategoryTitle.textColor = selected ? .white : self.settings.categoryTitleColor
        self.lblCategory.textColor = selected ? .white : self.settings.categoryColor
    }
    
}
