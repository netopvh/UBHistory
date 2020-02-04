//
//  ScrollView.swift
//  SegmentedTest
//
//  Created by Usemobile on 13/08/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import UIKit

class USEScrollView: UIView {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        scrollView.bounces = false
        self.addSubview(scrollView)
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        self.scrollView.addSubview(view)
        return view
    }()
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        self.containerView.addSubview(view)
        return view
    }()
    
    private lazy var segmentView: SegmentedView = {
        let view = SegmentedView(cells: self.viewControllers.compactMap({ $0.title }), segmentedSettings: self.segmentedSettings)
        view.delegate = self
        view.updateScrolling = { (isScrolling: Bool) in
            self.ignoreScroll = isScrolling
        }
        self.containerView.addSubview(view)
        return view
    }()
    
    private lazy var contentView: ContentView = {
        let view = ContentView(views: self.viewControllers.compactMap({ $0.view }))
        view.scrollView = self
        view.delegate = self
        self.containerView.addSubview(view)
        return view
    }()
    
    public var headerHeight: CGFloat = 0 {
        didSet {
            self.updateSizes()
        }
    }
    public var segmentedHeight: CGFloat = 0 {
        didSet {
            self.updateSizes()
        }
    }
    
    public var navBarHeight: CGFloat = 0 {
        didSet {
            self.updateSizes()
        }
    }
    public var tabBarHeight: CGFloat = 0 {
        didSet {
            self.updateSizes()
        }
    }
    
    private var headerHeightConstraint = NSLayoutConstraint()
    private var segmentedHeightConstraint = NSLayoutConstraint()
    private var contentHeightConstraint = NSLayoutConstraint()
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    private var segmentedSettings: SegmentedSettings = .default
    
    private var viewControllers: [UIViewController] = []
    private var _headerView: UIView = UIView()
    
    private var observing = true
    private var ignoreScroll = false
    
    init(viewControllers: [UIViewController], headerView: UIView, headerHeight: CGFloat = 0, segmentedHeight: CGFloat = 0, segmentedSettings: SegmentedSettings) {
        self.viewControllers = viewControllers
        self._headerView = headerView
        self.headerHeight = headerHeight
        self.segmentedHeight = segmentedHeight
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
        self.contentHeightConstraint = self.contentView.heightAnchor.constraint(equalToConstant: self.getContentHeight())
    }
    
    private func setup() {
        self.backgroundColor = .white
        self.setupConstraints()
        
        self.viewControllers.forEach({
            $0.view.addObserver(self, forKeyPath: "contentOffset", options: [NSKeyValueObservingOptions.new, NSKeyValueObservingOptions.old], context: nil)
        })
    }
    
    private func setupConstraints() {
        
        if #available(iOS 11.0, *) {
            self.scrollView.anchor(top: self.safeAreaLayoutGuide.topAnchor, left: self.safeAreaLayoutGuide.leftAnchor, bottom: self.bottomAnchor, right: self.safeAreaLayoutGuide.rightAnchor)
        } else {
            self.scrollView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
        }
        self.containerView.fillSuperview()
        let scrollHeight = self.containerView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor)
        scrollHeight.priority = .defaultLow
        
        self.headerView.anchor(top: self.containerView.topAnchor, left: self.containerView.leftAnchor, bottom: nil, right: self.containerView.rightAnchor)
        self.headerView.addSubview(self._headerView)
        self._headerView.fillSuperview()
        self.segmentView.anchor(top: self.headerView.bottomAnchor, left: self.containerView.leftAnchor, bottom: nil, right: self.containerView.rightAnchor)
        self.contentView.anchor(top: self.segmentView.bottomAnchor, left: self.containerView.leftAnchor, bottom: self.containerView.bottomAnchor, right: self.containerView.rightAnchor)
        
        self.headerHeightConstraint = self.headerView.heightAnchor.constraint(equalToConstant: self.headerHeight)
        self.segmentedHeightConstraint = self.segmentView.heightAnchor.constraint(equalToConstant: self.segmentedHeight)
        self.contentHeightConstraint = self.contentView.heightAnchor.constraint(equalToConstant: self.getContentHeight())
        
        self.addConstraints([
            self.containerView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            scrollHeight,
            self.headerHeightConstraint,
            self.segmentedHeightConstraint,
            self.contentHeightConstraint
            ])
        
    }
    
    private func updateSizes() {
        self.headerHeightConstraint.constant = self.headerHeight
        self.segmentedHeightConstraint.constant = self.segmentedHeight
        self.contentHeightConstraint.constant = self.getContentHeight()
        self.layoutIfNeeded()
    }
    
    private func getContentHeight() -> CGFloat {
        var bottom: CGFloat = 0
        if #available(iOS 11.0, *) {
            bottom = self.safeAreaInsets.bottom
        }
        return self.screenHeight - self.navBarHeight - self.segmentedHeight - self.tabBarHeight + bottom
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if !observing { return }
        
        let scrollView = object as? UIScrollView
        if scrollView == nil { return }
        if scrollView == self.scrollView { return }
        
        let changeValues = change! as [NSKeyValueChangeKey: AnyObject]
        
        if let new = changeValues[NSKeyValueChangeKey.newKey]?.cgPointValue,
            let old = changeValues[NSKeyValueChangeKey.oldKey]?.cgPointValue {
            
            let diff = old.y - new.y
            
            if diff > 0.0 {
                
                handleScrollUp(scrollView!,
                               change: diff,
                               oldPosition: old)
            } else {
                
                handleScrollDown(scrollView!,
                                 change: diff,
                                 oldPosition: old)
            }
        }
    }
    
    func setContentOffset(_ scrollView: UIScrollView, point: CGPoint) {
        observing = false
        scrollView.contentOffset = point
        observing = true
    }
    
    func handleScrollUp(_ scrollView: UIScrollView,
                        change: CGFloat,
                        oldPosition: CGPoint) {
        let contentOffset = self.scrollView.contentOffset
        if self.headerHeight != 0.0 && contentOffset.y != 0.0 {
            if scrollView.contentOffset.y < 0.0 {
                if contentOffset.y >= 0.0 {
                    
                    var yPos = contentOffset.y - change
                    yPos = yPos < 0 ? 0 : yPos
                    let updatedPos = CGPoint(x: contentOffset.x, y: yPos)
                    setContentOffset(self.scrollView, point: updatedPos)
                    setContentOffset(scrollView, point: oldPosition)
                }
            }
        }
    }
    
    func handleScrollDown(_ scrollView: UIScrollView,
                          change: CGFloat,
                          oldPosition: CGPoint) {
        let offset: CGFloat = self.getOffset()
        let contentOffset = self.scrollView.contentOffset
        if contentOffset.y < offset {
            
            if scrollView.contentOffset.y >= 0.0 {
                
                var yPos = contentOffset.y - change
                yPos = yPos > offset ? offset : yPos
                let updatedPos = CGPoint(x: contentOffset.x, y: yPos)
                setContentOffset(self.scrollView, point: updatedPos)
                setContentOffset(scrollView, point: oldPosition)
            }
        }
    }
    
    func getOffset() -> CGFloat {
        return self.headerHeight
    }

}

extension USEScrollView: ContentViewDelegate {
    
    func contentView(_ contentView: ContentView, didSelect row: Int) {
        guard !self.ignoreScroll else { return }
        self.segmentView.scroll(to: row)
    }
    
    func contentView(_ contentView: ContentView, didScrollTo position: CGFloat) {
        guard !self.ignoreScroll else { return }
        self.segmentView.scroll(to: position)
    }
    
}

extension USEScrollView: SegmentedViewDelegate {
    
    func segmentedView(_ segmentedView: SegmentedView, didSelect row: Int) {
        self.contentView.scrollToRow(row)
    }
    
}

extension UIView {
    
    func getFirstScrollView() -> UIView {
        if self is UIScrollView {
            return self
        } else {
            return self.subviews.first(where: { (view) -> Bool in
                view is UIScrollView
            }) ?? self
        }
    }
    
}
