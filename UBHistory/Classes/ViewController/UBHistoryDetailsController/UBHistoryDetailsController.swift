//
//  UBHistoryDetailsViewController.swift
//  UBHistory
//
//  Created by Usemobile on 12/03/19.
//

import UIKit

public protocol UBHistoryDetailsControllerDelegate {
    func viewDidLoad(_ viewController: UBHistoryDetailsController, historyId: String?)
    func sendMessagePressed(_ viewController: UBHistoryDetailsController, historyId: String)
    func shareReceipt(_ viewController: UBHistoryDetailsController, historyId: String)
    func didSelectHelpItem(_ viewController: UBHistoryDetailsController, at indexPath: IndexPath)
}

public class UBHistoryDetailsController: UIViewController {
    
    lazy var detailsView: HistoryDetailsView = {
        let view = HistoryDetailsView(model: self.viewModel, settings: self.settings, hasMultipleStops: self.hasMultiplesStops)
        view.delegate = self
        return view
    }()
    
    lazy var myScrollView: UIScrollView = {
       let scrollView = UIScrollView()
       scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
       return scrollView
    }()
    
    public var viewModel: HistoryViewModel {
        didSet {
            self.detailsView.viewModel = viewModel
        }
    }
    var hasMultiplesStops: Bool = false
    var settings: UBHistorySettings
    var coordinator: HistoryCoordinator?
    var delegate: UBHistoryDetailsControllerDelegate?
    
    init(model: HistoryViewModel, settings: UBHistorySettings = .default, hasMultipleStops: Bool = false) {
        self.hasMultiplesStops = hasMultipleStops
        self.settings = settings
        self.viewModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    public override func loadView() {
//        self.view = self.detailsView
//    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.myScrollView)
        self.myScrollView.addSubview(self.detailsView)
        
        
        self.myScrollView.fillSuperview()
        self.detailsView.fillSuperview()
        self.detailsView.widthAnchor.constraint(equalTo: self.myScrollView.widthAnchor).isActive = true
        let _height = self.detailsView.heightAnchor.constraint(equalTo: self.myScrollView.heightAnchor)
        _height.priority = .defaultLow
        _height.isActive = true

        self.title = .historyDetailsVCTitle
        self.delegate?.viewDidLoad(self, historyId: self.viewModel.objectId)
    }
    
    public func setHelpItems(_ items: [String]) {
        self.detailsView.setHelpItems(items)
    }
    
    
}

extension UBHistoryDetailsController: HistoryDetailsViewDelegate {
    func didSelectHelpItem(_ historyDetailsView: HistoryDetailsView, at indexPath: IndexPath) {
        self.delegate?.didSelectHelpItem(self, at: indexPath)
    }
    
    func sendMessagePressed(historyDetailsView: HistoryDetailsView) {
        if let objectId = self.viewModel.objectId {
            self.delegate?.sendMessagePressed(self, historyId: objectId)
        }
    }
    func shareReceipt(historyDetailsView: HistoryDetailsView) {
        if let objectId = self.viewModel.objectId {
            self.delegate?.shareReceipt(self, historyId: objectId)
        }
    }
}
