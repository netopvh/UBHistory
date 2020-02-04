//
//  ContentView.swift
//  SegmentedTest
//
//  Created by Usemobile on 13/08/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import UIKit

protocol ContentViewDelegate: class {
    func contentView(_ contentView: ContentView, didScrollTo position: CGFloat)
    func contentView(_ contentView: ContentView, didSelect row: Int)
}

class ContentView: UIView {
    
    var scrollView: USEScrollView?
    
    lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(ContentCell.self, forCellWithReuseIdentifier: self.kCellId)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        self.addSubview(collectionView)
        return collectionView
    }()
    
    public weak var delegate: ContentViewDelegate?
    
    private let kCellId = "ContentCell"
    private var views: [UIView] = []
    
    private var ignoreScroll: Bool = false
    
    init(views: [UIView]) {
        self.views = views
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.backgroundColor = .clear
        self.collectionView.fillSuperview()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !self.ignoreScroll else { return }
        let width = scrollView.frame.width
        let page = scrollView.contentOffset.x / width
        let position = page * (width / CGFloat(self.views.count))
        self.delegate?.contentView(self, didScrollTo: position)
    }
    
    func scrollToRow(_ row: Int) {
        self.ignoreScroll = true
        self.collectionView.scrollToItem(at: IndexPath(item: row, section: 0), at: .left, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.ignoreScroll = false
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / self.frame.width)
        self.delegate?.contentView(self, didSelect: index)
    }
}

extension ContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.views.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.kCellId, for: indexPath) as! ContentCell
        cell.containerView = self.views[indexPath.item]
        return cell
    }
    
}

extension ContentView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionSize = collectionView.frame.size
        return CGSize(width: UIScreen.main.bounds.width, height: collectionSize.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

