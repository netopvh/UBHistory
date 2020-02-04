//
//  SegmentDetailsView.swift
//  UBHistory
//
//  Created by Usemobile on 13/03/19.
//

import UIKit

protocol SegmentDetailsViewDelegate {
    func sendMessagePressed(_ segmentedDetailsView: SegmentDetailsView)
    func shareReceipt(_ segmentedDetailsView: SegmentDetailsView)
    func didSelectHelpItem(_ segmentedDetailsView: SegmentDetailsView, at indexPath: IndexPath)
}

class SegmentDetailsView: UIView {
    lazy var detailsView: DetailsView = {
        let view = DetailsView(model: self.viewModel, settings: self.settings, hasMultipleStops: self.hasMultipleStops)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        return view
    }()
    
    lazy var helpView: HelpView = {
        let view = HelpView(model: self.viewModel, settings: self.settings)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        self.addSubview(view)
        return view
    }()
    
    lazy var receiptView: ReceiptView = {
        let view = ReceiptView(model: self.viewModel, settings: self.settings)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        self.addSubview(view)
        return view
    }()
    
    var viewModel: HistoryViewModel {
        didSet {
            self.detailsView.viewModel = viewModel
            self.detailsView.hasMultiplesStops = hasMultipleStops
            self.receiptView.viewModel = viewModel
        }
    }
    var settings: UBHistorySettings
    
    var hasMultipleStops:Bool = false
    
    var delegate: SegmentDetailsViewDelegate?
    
    init(model: HistoryViewModel, settings: UBHistorySettings = .default, hasMutipleStops: Bool = false) {
        self.viewModel = model
        self.settings = settings
        self.hasMultipleStops = hasMutipleStops
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.detailsView.fillSuperview()
        self.helpView.fillSuperview()
        self.receiptView.fillSuperview()
        
        self.present(index: 0)
    }
    
    func present(index: Int) {
        if index == 0 {
            self.detailsView.showStack()
        } else {
            self.detailsView.cleanStack()
        }
        switch index {
        case 0:
            self.bringSubviewToFront(self.detailsView)
        case 1:
            self.bringSubviewToFront(self.helpView)
        case 2:
            self.bringSubviewToFront(self.receiptView)
        default:
            break
        }
    }
    
    func setHelpItems(_ items: [String]) {
        self.helpView.helpItems = items
    }
}

extension SegmentDetailsView: HelpViewDelegate {
    func didSelectHelpItem(_ helpView: HelpView, at indexPath: IndexPath) {
        self.delegate?.didSelectHelpItem(self, at: indexPath)
    }
    
    func sendMessagePressed(_ helpView: HelpView) {
        self.delegate?.sendMessagePressed(self)
    }
}

extension SegmentDetailsView: ReceiptViewDelegate {
    func shareReceipt(_ receiptView: ReceiptView) {
        self.delegate?.shareReceipt(self)
    }
}

extension UIView {
    
    var firstSuperView: UIView {
        if let superView = self.superview {
            return superView.firstSuperView
        } else {
            return self
        }
    }
    
}
