//
//  TravelsViewController.swift
//  UBHistory
//
//  Created by Usemobile on 25/09/19.
//

import UIKit

import USE_Coordinator

public protocol TravelsViewControllerDelegate {
    func travelsViewController(_ viewController: UBTravelsViewController, didRequestHistoryRefresh completion: @escaping([HistoryViewModel]?, _ hasInfiniteScroll: Bool) -> Void)
    func travelsViewController(_ viewController: UBTravelsViewController, didRequestHistoryInfiniteScroll completion: @escaping([HistoryViewModel]?, _ hasInfiniteScroll: Bool) -> Void)
    
    func travelsViewController(_ viewController: UBTravelsViewController, didRequestDelete schedule: HistoryViewModel, on completion: @escaping (_ success: Bool) -> Void)
    func travelsViewController(_ viewController: UBTravelsViewController, didRequestListSchedules completion: @escaping([HistoryViewModel]?, _ hasInfiniteScroll: Bool) -> Void)
    func travelsViewController(_ viewController: UBTravelsViewController, didRequestSchedulesRefresh completion: @escaping([HistoryViewModel]?, _ hasInfiniteScroll: Bool) -> Void)
    func travelsViewController(_ viewController: UBTravelsViewController, didRequestSchedulesInfiniteScroll completion: @escaping([HistoryViewModel]?, _ hasInfiniteScroll: Bool) -> Void)
}

public class UBTravelsViewController: CoordinatedViewController {
    
    lazy var scrollView: USEScrollView = {
        let count = 2
        var viewControllers: [UIViewController] = [
            self.historyViewController,
            self.schedulesViewController
        ]
        let headerView = UIView()
        let view = USEScrollView(viewControllers: viewControllers, headerView: headerView, headerHeight: 0, segmentedHeight: 50, segmentedSettings: self.settings.segmentedSettings)
        return view
    }()
    
    public var delegate: TravelsViewControllerDelegate?
    public var settings: UBHistorySettings
    
    private var historyViewController: UBHistoryController!
    private var schedulesViewController: UBSchedulesViewController!
    
    public init(settings: UBHistorySettings = .default) {
        self.settings = settings
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func loadView() {
        self.historyViewController = UBHistoryController(settings: self.settings)
        self.historyViewController.title = .historyVCTitle
        self.historyViewController.delegate = self
        self.historyViewController.coordinator = (self.coordinator as? HistoryCoordinator)
        if self.settings.hasSchedules {
            self.schedulesViewController = UBSchedulesViewController(settings: self.settings)
            self.schedulesViewController.title = .schedulesVCTitle
            self.schedulesViewController.delegate = self
            self.schedulesViewController.coordinator = self.coordinator
            
            self.view = self.scrollView
            self.scrollView.navBarHeight = UIApplication.shared.statusBarFrame.height + (self.navigationController == nil ? 0 : 44)
            if #available(iOS 11.0, *) {
                self.scrollView.tabBarHeight = (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0) + (self.tabBarController == nil ? 0 : 49)
            } else {
                self.scrollView.tabBarHeight = (self.tabBarController == nil ? 0 : 49)
            }
        } else {
            super.loadView()
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        if !self.settings.hasSchedules {
            guard let child = self.historyViewController else { return }
            self.addChild(child)
            self.view.addSubview(child.view)
            child.didMove(toParent: self)
            child.view.frame = self.view.bounds
        }
        self.title = self.settings.hasSchedules ? .travels : .history
        let image = self.settings.closeImage ?? UIImage.getFrom(customClass: UBHistoryController.self, nameResource: "close")
        let button = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(btnClosePressed))
        button.tintColor = self.settings.closeColor
        self.navigationItem.leftBarButtonItem = button
        self.navigationController?.navigationBar.isTranslucent = false
        if self.settings.hasSchedules {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if #available(iOS 11.0, *) {
            if !self.settings.hasSchedules {
                self.historyViewController.view.frame.size.height = self.view.frame.size.height
            }
        }
    }
    
    @objc func btnClosePressed() {
        (self.coordinator as? HistoryCoordinator)?.endCoordinator()
    }
    
    public func setupHistory(_ history: [HistoryViewModel], hasInfiniteScroll: Bool) {
        self.historyViewController.setupHistory(history, hasInfiniteScroll: hasInfiniteScroll)
    }
    
    public func insertHistory(_ history: [HistoryViewModel], hasInfiniteScroll: Bool) {
        self.historyViewController.insertHistory(history, hasInfiniteScroll: hasInfiniteScroll)
    }
    
    public func historyFetchFailed() {
        self.historyViewController.historyFetchFailed()
    }
    
    public func setupSchedules(_ schedules: [HistoryViewModel], hasInfiniteScroll: Bool) {
        self.schedulesViewController.setupSchedules(schedules, hasInfiniteScroll: hasInfiniteScroll)
    }
    
    public func insertSchedules(_ schedules: [HistoryViewModel], hasInfiniteScroll: Bool) {
        self.schedulesViewController.insertSchedules(schedules, hasInfiniteScroll: hasInfiniteScroll)
    }
    
    public func schedulesFetchFailed() {
        self.historyViewController.historyFetchFailed()
    }
    
}

extension UBTravelsViewController: UBHistoryControllerDelegate {
    
    public func historyController(_ historyController: UBHistoryController, didRequestRefresh completion: @escaping ([HistoryViewModel]?, Bool) -> Void) {
        self.delegate?.travelsViewController(self, didRequestHistoryRefresh: completion)
    }
    
    public func historyController(_ historyController: UBHistoryController, didRequestInfiniteScroll completion: @escaping ([HistoryViewModel]?, Bool) -> Void) {
        self.delegate?.travelsViewController(self, didRequestHistoryInfiniteScroll: completion)
    }
    
}


extension UBTravelsViewController: UBSchedulesViewControllerDelegate {
    
    public func schedulesViewController(_ schedulesViewController: UBSchedulesViewController, didRequestDeleteFor schedule: HistoryViewModel, on completion: @escaping (Bool) -> Void) {
        self.delegate?.travelsViewController(self, didRequestDelete: schedule, on: completion)
    }
    
    public func schedulesViewController(_ schedulesViewController: UBSchedulesViewController, didRequestListSchedules completion: @escaping ([HistoryViewModel]?, Bool) -> Void) {
        self.delegate?.travelsViewController(self, didRequestListSchedules: completion)
    }
    
    public func schedulesViewController(_ schedulesViewController: UBSchedulesViewController, didRequestRefresh completion: @escaping ([HistoryViewModel]?, Bool) -> Void) {
        self.delegate?.travelsViewController(self, didRequestSchedulesRefresh: completion)
    }
    
    public func schedulesViewController(_ schedulesViewController: UBSchedulesViewController, didRequestInfiniteScroll completion: @escaping ([HistoryViewModel]?, Bool) -> Void) {
        self.delegate?.travelsViewController(self, didRequestSchedulesInfiniteScroll: completion)
    }
    
}
