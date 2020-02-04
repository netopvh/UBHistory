//
//  UBHistoryController.swift
//  UBHistory
//
//  Created by Usemobile on 08/03/19.
//

import UIKit

public protocol UBHistoryControllerDelegate {
    func historyController(_ historyController: UBHistoryController, didRequestRefresh completion: @escaping([HistoryViewModel]?, _ hasInfiniteScroll: Bool) -> Void)
    func historyController(_ historyController: UBHistoryController, didRequestInfiniteScroll completion: @escaping([HistoryViewModel]?, _ hasInfiniteScroll: Bool) -> Void)
}

public class UBHistoryController: UIViewController {
    
    lazy var tableView: HistoryTableView = {
        let view = HistoryTableView(settings: settings)
        view.delegate = self
        return view
    }()
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var coordinator: HistoryCoordinator?
    public var delegate: UBHistoryControllerDelegate?
    public var settings: UBHistorySettings
    
    public init(settings: UBHistorySettings = .default) {
        self.settings = settings
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        self.view = self.tableView
        let image = self.settings.closeImage ?? UIImage.getFrom(customClass: UBHistoryController.self, nameResource: "close")
        let button = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(btnClosePressed))
        button.tintColor = self.settings.closeColor
        self.navigationItem.leftBarButtonItem = button
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.title = .historyVCTitle
        self.tableView.playProgress()
    }
    
    @objc func btnClosePressed() {
        self.coordinator?.endCoordinator()
    }
    
    public func setupHistory(_ history: [HistoryViewModel], hasInfiniteScroll: Bool) {
        self.tableView.setupHistory(history, hasInfiniteScroll: hasInfiniteScroll)
    }
    
    public func insertHistory(_ history: [HistoryViewModel], hasInfiniteScroll: Bool) {
        self.tableView.insertHistory(history, hasInfiniteScroll: hasInfiniteScroll)
    }
    
    public func historyFetchFailed() {
        self.tableView.historyFetchFailed()
    }
    
}

extension UBHistoryController: HistoryTableViewDelegate {
    
    func didSelectHistory(_ tableView: HistoryTableView, history: HistoryViewModel) {
        self.coordinator?.showDetails(of: history)
    }
    
    func didRequestRefresh(_ tableView: HistoryTableView) {
        self.delegate?.historyController(self, didRequestRefresh: { [weak self](history, hasInfiniteScroll) in
            guard let self = self else { return }
            if let _history = history {
                self.setupHistory(_history, hasInfiniteScroll: hasInfiniteScroll)
            } else {
                self.historyFetchFailed()
            }
        })
    }
    
    func didRequestInfiniteScroll(_ tableView: HistoryTableView) {
        self.delegate?.historyController(self, didRequestInfiniteScroll: { [weak self](history, hasInfiniteScroll) in
            guard let self = self else { return }
            if let _history = history {
                self.insertHistory(_history, hasInfiniteScroll: hasInfiniteScroll)
            } else {
                self.historyFetchFailed()
            }
        })
    }
}
