//
//  HistoryCoordinator.swift
//  UBHistory
//
//  Created by Usemobile on 12/03/19.
//

import Foundation
import USE_Coordinator

public protocol HistoryCoordinatorDelegate {
    func historyCoordinator(_ historyCoordinator: HistoryCoordinator, historyDetailsPushedFor viewController: UBHistoryDetailsController, historyId: String?)
    func historyCoordinator(_ historyCoordinator: HistoryCoordinator, sendMessagePressedFor viewController: UBHistoryDetailsController, historyId: String)
    func historyCoordinator(_ historyCoordinator: HistoryCoordinator, shareReceiptFor viewController: UBHistoryDetailsController, historyId: String)
    func historyCoordinator(_ historyCoordinator: HistoryCoordinator, didSelectHelpItemAt indexPath: IndexPath)
    func historyCoordinatorEndCoordinator(_ historyCoordinator: HistoryCoordinator)
    
    func historyCoordinator(_ historyCoordinator: HistoryCoordinator, didRequestHistoryRefresh completion: @escaping([HistoryViewModel]?, Bool) -> Void)
    func historyCoordinator(_ historyCoordinator: HistoryCoordinator, didRequestHistoryInfiniteScroll completion: @escaping([HistoryViewModel]?, Bool) -> Void)
    
    func historyCoordinator(_ historyCoordinator: HistoryCoordinator, didRequestDelete schedule: HistoryViewModel, on completion: @escaping (_ success: Bool) -> Void)
    func historyCoordinator(_ historyCoordinator: HistoryCoordinator, didRequestListSchedules completion: @escaping([HistoryViewModel]?, Bool) -> Void)
    func historyCoordinator(_ historyCoordinator: HistoryCoordinator, didRequestSchedulesRefresh completion: @escaping([HistoryViewModel]?, Bool) -> Void)
    func historyCoordinator(_ historyCoordinator: HistoryCoordinator, didRequestSchedulesInfiniteScroll completion: @escaping([HistoryViewModel]?, Bool) -> Void)
}

public class HistoryCoordinator: NavigationCoordinator {
    
    public var rootController: UBTravelsViewController?
    
    public var sendMessage: (() -> Void)?
    
    public var settings: UBHistorySettings = .default
    public var delegate: HistoryCoordinatorDelegate?
    public var hasMultipleStops: Bool = false
    
    public func start(settings: UBHistorySettings = .default) {
//        settings.language = .en
        self.settings = settings
        let travelsVC = UBTravelsViewController(settings: settings)
        travelsVC.delegate = self
        travelsVC.coordinator = self
        
        if settings.forceTouchEnabled {
//            historyVC.registerForPreviewing(with: self, sourceView: historyVC.tableView)
        }
        navigationController.pushViewController(travelsVC, animated: false)
        self.rootController = travelsVC
    }
    
    public func showDetails(of history: HistoryViewModel) {
        let vc = self.getDetailsVC(of: history)
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func getDetailsVC(of history: HistoryViewModel) -> UBHistoryDetailsController {
        let vc = UBHistoryDetailsController(model: history, hasMultipleStops: self.hasMultipleStops)
        vc.delegate = self
        vc.coordinator = self
        vc.settings = self.settings
        return vc
    }
    
    public func setupHistory(_ history: [HistoryViewModel], hasInfiniteScroll: Bool) {
        self.rootController?.setupHistory(history, hasInfiniteScroll: hasInfiniteScroll)
    }
    
    public func setHelpItems(_ items: [String]) {
        if let vc = self.navigationController.topViewController as? UBHistoryDetailsController {
            vc.setHelpItems(items)
        }
    }
    
    func endCoordinator() {
        self.navigationController.dismiss(animated: true, completion: nil)
        self.delegate?.historyCoordinatorEndCoordinator(self)
    }
    
}

extension HistoryCoordinator: UBHistoryDetailsControllerDelegate {
    public func didSelectHelpItem(_ viewController: UBHistoryDetailsController, at indexPath: IndexPath) {
        self.delegate?.historyCoordinator(self, didSelectHelpItemAt: indexPath)
    }
    
    public func viewDidLoad(_ viewController: UBHistoryDetailsController, historyId: String?) {
        self.delegate?.historyCoordinator(self, historyDetailsPushedFor: viewController, historyId: historyId)
    }
    
    public func sendMessagePressed(_ viewController: UBHistoryDetailsController, historyId: String) {
        self.delegate?.historyCoordinator(self, sendMessagePressedFor: viewController, historyId: historyId)
    }
    
    public func shareReceipt(_ viewController: UBHistoryDetailsController, historyId: String) {
        self.delegate?.historyCoordinator(self, shareReceiptFor: viewController, historyId: historyId)
    }
}

extension HistoryCoordinator: UIViewControllerPreviewingDelegate {
    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
//        if let indexPath = self.rootController?.tableView.tableView.indexPathForRow(at: location), let model = self.rootController?.tableView.history[indexPath.row] {
//            return self.getDetailsVC(of: model)
//        }
        return nil
    }
    
    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.navigationController.pushViewController(viewControllerToCommit, animated: true)
    }
    
}

extension HistoryCoordinator: TravelsViewControllerDelegate {
    
    public func travelsViewController(_ viewController: UBTravelsViewController, didRequestDelete schedule: HistoryViewModel, on completion: @escaping (Bool) -> Void) {
        self.delegate?.historyCoordinator(self, didRequestDelete: schedule, on: completion)
    }
    
    public func travelsViewController(_ viewController: UBTravelsViewController, didRequestHistoryRefresh completion: @escaping ([HistoryViewModel]?, Bool) -> Void) {
        self.delegate?.historyCoordinator(self, didRequestHistoryRefresh: completion)
    }
    
    public func travelsViewController(_ viewController: UBTravelsViewController, didRequestHistoryInfiniteScroll completion: @escaping ([HistoryViewModel]?, Bool) -> Void) {
        self.delegate?.historyCoordinator(self, didRequestHistoryInfiniteScroll: completion)
    }
    
    public func travelsViewController(_ viewController: UBTravelsViewController, didRequestListSchedules completion: @escaping ([HistoryViewModel]?, Bool) -> Void) {
        self.delegate?.historyCoordinator(self, didRequestListSchedules: completion)
    }
    
    public func travelsViewController(_ viewController: UBTravelsViewController, didRequestSchedulesRefresh completion: @escaping ([HistoryViewModel]?, Bool) -> Void) {
        self.delegate?.historyCoordinator(self, didRequestSchedulesRefresh: completion)
    }
    
    public func travelsViewController(_ viewController: UBTravelsViewController, didRequestSchedulesInfiniteScroll completion: @escaping ([HistoryViewModel]?, Bool) -> Void) {
        self.delegate?.historyCoordinator(self, didRequestSchedulesInfiniteScroll: completion)
    }
    
}
