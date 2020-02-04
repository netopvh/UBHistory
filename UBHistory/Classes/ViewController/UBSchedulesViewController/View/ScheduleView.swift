//
//  ScheduleView.swift
//  UBHistory
//
//  Created by Usemobile on 25/09/19.
//

import UIKit

import Lottie

protocol ScheduleViewDelegate: class {
    func scheduleView(_ scheduleView: ScheduleView, didSelect history: HistoryViewModel)
    func scheduleView(_ scheduleView: ScheduleView, didRequestDelete history: HistoryViewModel, for indexPath: IndexPath)
    func scheduleViewDidRequestRefresh(_ scheduleView: ScheduleView)
    func scheduleViewDidRequestInfiniteScroll(_ scheduleView: ScheduleView)
}

class ScheduleView: UIView {
    
    lazy var lottieView: LOTAnimationView = {
        let lottieView = LOTAnimationView(name: self.settings.lottieName)
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        lottieView.contentMode = UIView.ContentMode.scaleAspectFit
        lottieView.backgroundColor = .white
        lottieView.isHidden = true
        lottieView.loopAnimation = true
        lottieView.animationProgress = 0
        self.addSubview(lottieView)
        return lottieView
    }()
    
    lazy var failureView: FailureView = {
        let failureView = FailureView(settings: self.settings)
        failureView.translatesAutoresizingMaskIntoConstraints = false
        //        self.addSubview(failureView)
        return failureView
    }()
    
    lazy var emptyView: EmptyHistoryView = {
        let emptyView = EmptyHistoryView(settings: self.settings)
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.type = .schedules
        //        emptyView.isHidden = true
        self.addSubview(emptyView)
        return emptyView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ScheduleCell.self, forCellReuseIdentifier: kScheduleCell)
        self.addSubview(tableView)
        return tableView
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.lightGray
        
        return refreshControl
    }()

    let kScheduleCell = "ScheduleCell"
    
    var schedules = [HistoryViewModel]() {
        didSet {
            if self.schedules.isEmpty {
                self.hasInfiniteScroll = false
            }
        }
    }
    
    var settings: UBHistorySettings = .default
    var hasInfiniteScroll: Bool = false {
        didSet {
            self.setupInfiniteScroll()
        }
    }
    
    weak var delegate: ScheduleViewDelegate?
    
    required init(settings: UBHistorySettings = .default) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.settings = settings
        self.emptyView.fillSuperview()
        self.tableView.fillSuperview()
        self.lottieView.fillSuperview()
        self.tableView.reloadData()
        
        self.setupPullRefresh()
        self.setupInfiniteScroll()
        self.sendSubviewToBack(self.emptyView)
        self.bringSubviewToFront(self.tableView)
        self.bringSubviewToFront(self.lottieView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func schedulesFetchFailed() {
        self.refreshControl.endRefreshing()
        self.tableView.finishInfiniteScroll()
    }
    
    func playProgress() {
        self.lottieView.play()
        self.lottieView.isHidden = false
    }
    
    func stopProgress() {
        self.lottieView.isHidden = true
        self.lottieView.stop()
    }
    
    func setupSchedules(_ schedules: [HistoryViewModel], hasInfiniteScroll: Bool) {
        self.hasInfiniteScroll = hasInfiniteScroll
        self.stopProgress()
        self.refreshControl.endRefreshing()
        self.tableView.finishInfiniteScroll()
        
        self.schedules = schedules
        self.emptyView.isHidden = !self.schedules.isEmpty
        self.tableView.reloadData()
    }
    
    func insertSchedules(_ schedules: [HistoryViewModel], hasInfiniteScroll: Bool) {
        defer {
            self.tableView.finishInfiniteScroll()
            self.hasInfiniteScroll = hasInfiniteScroll
        }
        self.stopProgress()
        let (start, end) = (self.schedules.count, (self.schedules.count + schedules.count))
        let indexPaths = (start ..< end).map { return IndexPath(row: $0, section: 0)}
        
        self.schedules.append(contentsOf: schedules)
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: indexPaths, with: .fade)
        self.tableView.endUpdates()
        self.emptyView.isHidden = !self.schedules.isEmpty
    }
    
    func deleteSchedule(for indexPath: IndexPath) {
        self.schedules.remove(at: indexPath.row)
        self.tableView.reloadData()
        self.emptyView.isHidden = !self.schedules.isEmpty
    }
    
    func setupPullRefresh() {
        if self.settings.hasRefresh {
            self.tableView.addSubview(self.refreshControl)
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.updatePullRefresh()
    }
    
    func updatePullRefresh() {
        UBFeedback.notification.feedback(.warning)
        self.delegate?.scheduleViewDidRequestRefresh(self)
    }
    
    func setupInfiniteScroll() {
        self.tableView.setShouldShowInfiniteScrollHandler({ tableView in
            return self.hasInfiniteScroll
        })
        self.tableView.addInfiniteScroll { _ in
        self.delegate?.scheduleViewDidRequestInfiniteScroll(self)
        }
    }

}


extension ScheduleView: UITableViewDelegate {
    // MOCK: - Por hora não há interação definida com a célula
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard indexPath.row < self.schedules.count else { return }
//        self.delegate?.scheduleView(self, didSelect: self.schedules[indexPath.row])
//    }
//
//    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
//        (tableView.cellForRow(at: indexPath) as? ScheduleCell)?.setSelection(selected: true)
//    }
//
//    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
//        (tableView.cellForRow(at: indexPath) as? ScheduleCell)?.setSelection(selected: false)
//    }
}

extension ScheduleView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.schedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kScheduleCell, for: indexPath) as! ScheduleCell
        cell.hasPaymentInfos = self.settings.hasPaymentInfos
        cell.settings = self.settings
        cell.viewModel = self.schedules[indexPath.row]
        cell.deleteAction = { [weak self] in
            guard let self = self, indexPath.row < self.schedules.count else { return }
            self.delegate?.scheduleView(self, didRequestDelete: self.schedules[indexPath.row], for: indexPath)
        }
        return cell
    }
}
