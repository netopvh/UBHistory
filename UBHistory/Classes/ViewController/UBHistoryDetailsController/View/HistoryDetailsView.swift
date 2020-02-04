//
//  HistoryDetailsView.swift
//  UBHistory
//
//  Created by Usemobile on 13/03/19.
//

import Foundation
import UIKit

protocol HistoryDetailsViewDelegate {
    func sendMessagePressed(historyDetailsView: HistoryDetailsView)
    func shareReceipt(historyDetailsView: HistoryDetailsView)
    func didSelectHelpItem(_ historyDetailsView: HistoryDetailsView, at indexPath: IndexPath)
}

class HistoryDetailsView: UIView {
    lazy var imvMap: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var driverView: DriverView = {
        let view = DriverView(model: self.viewModel, settings: self.settings)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        return view
    }()
    
    lazy var travelView: TravelView = {
        let view = TravelView(model: self.viewModel, settings: self.settings)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        return view
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.backgroundColor = .white
        segmentedControl.tintColor = .blue
        if #available(iOS 13.0, *) {
            segmentedControl.selectedSegmentTintColor = .white
        }
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.insertSegment(withTitle: .details, at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: .help, at: 1, animated: false)
        if self.settings.hasPaymentInfos {
            segmentedControl.insertSegment(withTitle: .receipt, at: 2, animated: false)
        }
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(self.itemSelected(sender:)), for: .valueChanged)
        self.addSubview(segmentedControl)
        return segmentedControl
    }()
    
    lazy var segmentDetailsView: SegmentDetailsView = {
        let view = SegmentDetailsView(model: self.viewModel, settings: self.settings, hasMutipleStops: self.hasMultipleStops)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        self.addSubview(view)
        return view
    }()
    
    var viewModel: HistoryViewModel {
        didSet {
            self.setup()
            self.driverView.viewModel = viewModel
            self.travelView.viewModel = viewModel
            self.segmentDetailsView.viewModel = viewModel
            
        }
    }
    var settings: UBHistorySettings = .default {
        didSet {
            self.driverView.settings = self.settings
            self.travelView.settings = self.settings
        }
    }
    var delegate: HistoryDetailsViewDelegate?
    var hasMultipleStops:Bool = false
    
    init(model: HistoryViewModel, settings: UBHistorySettings = .default, hasMultipleStops: Bool = false) {
        self.settings = settings
        self.viewModel = model
        self.hasMultipleStops = hasMultipleStops
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.removeConstraints(self.constraints)
        self.backgroundColor = .white
        var hasValidMap = false
        if let bigMap = self.viewModel.bigMap, let mapURL = URL(string: bigMap), UIApplication.shared.canOpenURL(mapURL) {
            hasValidMap = true
        }
        let mapHeight: CGFloat = hasValidMap ? 150 : 0
        if hasValidMap, let bigMap = self.viewModel.bigMap {
            self.addSubview(self.imvMap)
            self.imvMap.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, size: .init(width: 0, height: mapHeight.dynamic()))
            let mapPlaceholder = self.settings.historyDetailsSettings.mapPlaceholder ?? UIImage.getFrom(customClass: HistoryDetailsView.self, nameResource: "mapPlaceholder")
            self.imvMap.cast(urlStr: bigMap, placeholder: mapPlaceholder)
        }
        self.driverView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, padding: .init(top: mapHeight.dynamic(), left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 100.dynamic()))
        self.travelView.anchor(top: self.driverView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, size: .init(width: 0, height: 90.dynamic()))
        self.segmentedControl.anchor(top: self.travelView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 30.dynamic()))
        self.segmentDetailsView.anchor(top: self.segmentedControl.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, padding: .init(top: 2, left: 20, bottom: 0, right: 20))
        
        self.segmentedControl.tintColor = self.settings.mainColor
        if #available(iOS 13.0, *) {
            self.segmentedControl.selectedSegmentTintColor = self.settings.mainColor
        }
    }
    
    @objc func itemSelected(sender: UISegmentedControl) {
        self.segmentDetailsView.present(index: sender.selectedSegmentIndex)
    }
    
    func setHelpItems(_ items: [String]) {
        self.segmentDetailsView.setHelpItems(items)
    }
}

extension HistoryDetailsView: SegmentDetailsViewDelegate {
    func didSelectHelpItem(_ segmentedDetailsView: SegmentDetailsView, at indexPath: IndexPath) {
        self.delegate?.didSelectHelpItem(self, at: indexPath)
    }
    
    func sendMessagePressed(_ segmentedDetailsView: SegmentDetailsView) {
        self.delegate?.sendMessagePressed(historyDetailsView: self)
    }
    func shareReceipt(_ segmentedDetailsView: SegmentDetailsView) {
        self.delegate?.shareReceipt(historyDetailsView: self)
    }
}
