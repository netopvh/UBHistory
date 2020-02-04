//
//  HistoryTableView.swift
//  UBHistory
//
//  Created by Usemobile on 08/03/19.
//

import UIKit
import UIScrollView_InfiniteScroll
import Lottie

protocol HistoryTableViewDelegate {
    func didSelectHistory(_ tableView: HistoryTableView, history: HistoryViewModel)
    func didRequestRefresh(_ tableView: HistoryTableView)
    func didRequestInfiniteScroll(_ tableView: HistoryTableView)
}

class HistoryTableView: UIView {
    
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
        tableView.register(HistoryCell.self, forCellReuseIdentifier: kHistoryCell)
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
    
    let kHistoryCell = "HistoryCell"
    
    var history = [HistoryViewModel]() {
        didSet {
            if self.history.count == 0 {
                self.settings.hasInfiniteScroll = false
            }
        }
    }
    var delegate: HistoryTableViewDelegate?
    var settings: UBHistorySettings = .default
    var hasInfiniteScroll: Bool = false {
        didSet {
            self.setupInfiniteScroll()
        }
    }
    
    required init(settings: UBHistorySettings = .default) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.settings = settings
        self.emptyView.fillSuperview()
        self.tableView.fillSuperview()
        self.lottieView.fillSuperview()
        //        self.failureView.fillSuperview()
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
    
    func historyFetchFailed() {
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
    
    func setupHistory(_ history: [HistoryViewModel], hasInfiniteScroll: Bool) {
        self.hasInfiniteScroll = hasInfiniteScroll
        self.stopProgress()
        self.refreshControl.endRefreshing()
        self.tableView.finishInfiniteScroll()
        
        self.history = history
        self.emptyView.isHidden = !self.history.isEmpty
        self.tableView.reloadData()
    }
    
    func insertHistory(_ history: [HistoryViewModel], hasInfiniteScroll: Bool) {
        defer {
            self.tableView.finishInfiniteScroll()
            self.hasInfiniteScroll = hasInfiniteScroll
        }
        self.stopProgress()
        let (start, end) = (self.history.count, (self.history.count + history.count))
        let indexPaths = (start ..< end).map { return IndexPath(row: $0, section: 0)}
        
        self.history.append(contentsOf: history)
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: indexPaths, with: .fade)
        self.tableView.endUpdates()
        self.emptyView.isHidden = !self.history.isEmpty
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
        self.delegate?.didRequestRefresh(self)
    }
    
    func setupInfiniteScroll() {
        self.tableView.setShouldShowInfiniteScrollHandler({ tableView in
            return self.hasInfiniteScroll
        })
        self.tableView.addInfiniteScroll { _ in
            self.delegate?.didRequestInfiniteScroll(self)
        }
    }
    
}

extension HistoryTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectHistory(self, history: self.history[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        (tableView.cellForRow(at: indexPath) as? HistoryCell)?.setSelection(selected: true)
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        (tableView.cellForRow(at: indexPath) as? HistoryCell)?.setSelection(selected: false)
    }
}

extension HistoryTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kHistoryCell, for: indexPath) as! HistoryCell
        cell.hasPaymentInfos = self.settings.hasPaymentInfos
        cell.settings = self.settings
        cell.viewModel = self.history[indexPath.row]
        return cell
    }
}
