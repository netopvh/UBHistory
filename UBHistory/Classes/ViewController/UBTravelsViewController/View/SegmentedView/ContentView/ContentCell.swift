//
//  ContentCell.swift
//  SegmentedTest
//
//  Created by Usemobile on 13/08/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import UIKit

class ContentCell: UICollectionViewCell {
    
    var containerView: UIView? {
        didSet {
            if let oldValue = oldValue {
                oldValue.removeFromSuperview()
            }
            if let containerView = self.containerView {
                self.addSubview(containerView)
                containerView.fillSuperview()
            }
        }
    }
    
    private let kCellId = "TableCell"
    
    var scrollView: USEScrollView? {
        didSet {
            if let oldValue = oldValue {
                self.tableView.removeObserver(oldValue, forKeyPath: "contentOffset", context: nil)
            }
            guard let scrollView = self.scrollView else { return }
            self.tableView.addObserver(scrollView, forKeyPath: "contentOffset", options: [NSKeyValueObservingOptions.new, NSKeyValueObservingOptions.old], context: nil)
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.kCellId)
        tableView.dataSource = self
        self.addSubview(tableView)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.tableView.fillSuperview()
    }
}


extension ContentCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.kCellId, for: indexPath)
        cell.backgroundColor = .white
        cell.contentView.backgroundColor = .random
        return cell
    }
    
}

extension UIColor {
    
    static var random: UIColor {
        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1)
    }
}
