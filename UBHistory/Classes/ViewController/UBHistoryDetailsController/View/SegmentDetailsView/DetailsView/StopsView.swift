//
//  AddressView.swift
//  UBHistory
//
//  Created by Gustavo Rocha on 14/03/19.
//

import UIKit

class StopsView: UIView {
    
    lazy var viewAddress: AddressStopsView = {
        let view = AddressStopsView(point: self.point, stop: self.countStops)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        return view
    }()
    
    lazy var viewTime: TimeStopsView = {
        let view = TimeStopsView(point: self.point)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        return view
    }()
    
    //MARK: vars
    
    var countStops: Int = 0
//    var point: Point?
    
    var point: Point {
        didSet {
            self.setupModels()
        }
    }
    
    //MARK: methos
    
    init(point: Point, stopCount: Int) {
        self.point = point
        self.countStops = stopCount
        super.init(frame: .zero)
        self.setupModels()
        self.setupConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Local Functions
    
    func setupConstraints(){
        self.viewAddress.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.viewTime.leftAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 10))
        self.viewTime.anchor(top: nil, left: nil, bottom: nil, right: self.rightAnchor, size: .init(width: 35, height: 0))
        self.viewTime.centerYAnchor.constraint(equalTo: self.viewAddress.centerYAnchor).isActive = true
    
    }
    
    func setupModels(){
        self.viewAddress.point = self.point
        self.viewTime.point = self.point
        if !(self.point.type == "point"){
            self.viewTime.isHidden = true
        }
    }
    
}
