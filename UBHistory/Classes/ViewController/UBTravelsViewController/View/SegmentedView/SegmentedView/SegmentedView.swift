//
//  SegmentedView.swift
//  SegmentedTest
//
//  Created by Usemobile on 13/08/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import UIKit

protocol SegmentedViewDelegate: class {
    func segmentedView(_ segmentedView: SegmentedView, didSelect row: Int)
}

class SegmentedView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(SegmentedCell.self, forCellWithReuseIdentifier: self.kCellId)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        self.addSubview(collectionView)
        return collectionView
    }()
    
    var scrollIndicator: CAShapeLayer?
    
    private var cells: [String] = []
    private var segmentedSettings: SegmentedSettings = .default
    private let kCellId = "SegmentedCell"
    
    private var selectedItem: Int = 0 
    private let scrollAnimationDuration: TimeInterval = 0.5
    
    public weak var delegate: SegmentedViewDelegate?
    
    public var updateScrolling: ((Bool) -> Void)?
    
    init(cells: [String], segmentedSettings: SegmentedSettings) {
        self.cells = cells
        self.segmentedSettings = segmentedSettings
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addScrollIndicator()
    }
    
    private func addScrollIndicator() {
        let layerName = "ScrollIndicator"
        self.layer.sublayers?.filter({ $0.name == layerName }).forEach({ $0.removeFromSuperlayer() })
        
        let layer = CAShapeLayer()
        layer.name = layerName
        
        let bounds = self.bounds
        let height: CGFloat = 4
        
        let path = UIBezierPath(rect: CGRect(x: 0, y: bounds.height - height, width: bounds.width / CGFloat(self.cells.count), height: height))
        layer.path = path.cgPath
        
        layer.fillColor = self.segmentedSettings.barBackgroundColor.cgColor
        
        self.layer.addSublayer(layer)
        self.scrollIndicator = layer
    }
    
    private func setup() {
        self.backgroundColor = self.segmentedSettings.backgroundColor
        self.collectionView.fillSuperview()
        self.collectionView.reloadData()
    }
    
    public func scrollAnimated(to position: CGFloat) {
        self.updateScrolling?(true)
        UIView.animate(withDuration: self.scrollAnimationDuration, animations: {
            self.scrollIndicator?.frame.origin.x = position
        }) { _ in
            self.updateScrolling?(false)
        }
    }
    
    public func scroll(to position: CGFloat) {
        self.scrollIndicator?.frame.origin.x = position
    }
    
    public func scroll(to row: Int) {
        let position: CGFloat = CGFloat(row) * (self.bounds.width) / CGFloat(self.cells.count)
        self.scrollAnimated(to: position)
        guard row != self.selectedItem else { return }
        UIView.animate(withDuration: self.scrollAnimationDuration) {
            (self.collectionView.cellForItem(at: IndexPath(item: self.selectedItem, section: 0)) as? SegmentedCell)?.deselect()
            (self.collectionView.cellForItem(at: IndexPath(item: row, section: 0)) as? SegmentedCell)?.select()
        }
        self.selectedItem = row
    }
}

extension SegmentedView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newRow = indexPath.item
        guard newRow != self.selectedItem else { return }
        UIView.animate(withDuration: self.scrollAnimationDuration) {
            (collectionView.cellForItem(at: IndexPath(item: self.selectedItem, section: 0)) as? SegmentedCell)?.deselect()
            (collectionView.cellForItem(at: indexPath) as? SegmentedCell)?.select()
        }
        self.scroll(to: indexPath.row)
        self.selectedItem = newRow
        self.delegate?.segmentedView(self, didSelect: newRow)
    }
    
}

extension SegmentedView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cells.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.kCellId, for: indexPath) as! SegmentedCell
        if indexPath.item == self.selectedItem {
            cell.select()
        } else {
            cell.deselect()
        }
        cell.titleFont = self.segmentedSettings.titleFont
        cell.title = self.cells[indexPath.item]
        return cell
    }

}

extension SegmentedView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionSize = collectionView.frame.size
        let size = CGSize(width: UIScreen.main.bounds.width / CGFloat(self.cells.count), height: collectionSize.height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}


