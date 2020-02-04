//
//  UBSchedulesViewController.swift
//  UBHistory
//
//  Created by Usemobile on 25/09/19.
//

import UIKit

import USE_Coordinator

public protocol UBSchedulesViewControllerDelegate: class {
    func schedulesViewController(_ schedulesViewController: UBSchedulesViewController, didRequestDeleteFor schedule: HistoryViewModel, on completion: @escaping(_ success: Bool) -> Void)
    func schedulesViewController(_ schedulesViewController: UBSchedulesViewController, didRequestListSchedules completion: @escaping([HistoryViewModel]?, _ hasInfiniteScroll: Bool) -> Void)
    func schedulesViewController(_ schedulesViewController: UBSchedulesViewController, didRequestRefresh completion: @escaping([HistoryViewModel]?, _ hasInfiniteScroll: Bool) -> Void)
    func schedulesViewController(_ schedulesViewController: UBSchedulesViewController, didRequestInfiniteScroll completion: @escaping([HistoryViewModel]?, _ hasInfiniteScroll: Bool) -> Void)
    
}

public class UBSchedulesViewController: CoordinatedViewController {
    
    lazy var scheduleView: ScheduleView = {
        let view = ScheduleView(settings: settings)
        view.delegate = self
        return view
    }()
    
    var settings: UBHistorySettings = .default
    weak var delegate: UBSchedulesViewControllerDelegate?
    
    private var hasAppear: Bool = false
    
    init(settings: UBHistorySettings) {
        self.settings = settings
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override public func loadView() {
        self.view = self.scheduleView
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !self.hasAppear {
            self.scheduleView.playProgress()
            self.hasAppear = true
            self.delegate?.schedulesViewController(self, didRequestListSchedules: { [weak self](history, hasInfiniteScroll) in
                guard let self = self else { return }
                if let _history = history {
                    self.setupSchedules(_history, hasInfiniteScroll: hasInfiniteScroll)
                } else {
                    self.schedulesFetchFailed()
                }
            })
        }
    }
    
    public func setupSchedules(_ schedules: [HistoryViewModel], hasInfiniteScroll: Bool) {
        self.scheduleView.setupSchedules(schedules, hasInfiniteScroll: hasInfiniteScroll)
    }
    
    public func insertSchedules(_ schedules: [HistoryViewModel], hasInfiniteScroll: Bool) {
        self.scheduleView.insertSchedules(schedules, hasInfiniteScroll: hasInfiniteScroll)
    }
    
    public func schedulesFetchFailed() {
        self.scheduleView.schedulesFetchFailed()
    }
    
}

extension UBSchedulesViewController: ScheduleViewDelegate {
    
    func scheduleView(_ scheduleView: ScheduleView, didSelect history: HistoryViewModel) {
        
    }
    
    func scheduleView(_ scheduleView: ScheduleView, didRequestDelete history: HistoryViewModel, for indexPath: IndexPath) {
        self.delegate?.schedulesViewController(self, didRequestDeleteFor: history) { [weak scheduleView](success: Bool) in
            guard let scheduleView = scheduleView else { return }
            if success {
                scheduleView.deleteSchedule(for: indexPath)
            } 
        }
    }
    
    func scheduleViewDidRequestRefresh(_ scheduleView: ScheduleView) {
        self.delegate?.schedulesViewController(self, didRequestRefresh: { [weak self](history, hasInfiniteScroll) in
            guard let self = self else { return }
            if let _history = history {
                self.setupSchedules(_history, hasInfiniteScroll: hasInfiniteScroll)
            } else {
                self.schedulesFetchFailed()
            }
        })
    }
    
    func scheduleViewDidRequestInfiniteScroll(_ scheduleView: ScheduleView) {
        self.delegate?.schedulesViewController(self, didRequestInfiniteScroll: { [weak self](history, hasInfiniteScroll) in
            guard let self = self else { return }
            if let _history = history {
                self.insertSchedules(_history, hasInfiniteScroll: hasInfiniteScroll)
            } else {
                self.schedulesFetchFailed()
            }
        })
    }
    
}
