//
//  DetailsView.swift
//  UBHistory
//
//  Created by Usemobile on 13/03/19.
//

import UIKit

class DetailsView: UIView {
    
    lazy var stopsViewstack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .white
        return stack
    }()
    
    lazy var originView: AddressView = {
        let view = AddressView(type: .origin, model: self.viewModel, settings: self.settings)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        return view
    }()
    
    lazy var destinyView: AddressView = {
        let view = AddressView(type: .destiny, model: self.viewModel, settings: self.settings)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        return view
    }()
    
    lazy var borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.hex707070.withAlphaComponent(0.1)
        self.addSubview(view)
        return view
    }()
    
    lazy var distanceView: DetailsBottomView = {
        let view = DetailsBottomView(type: .distance, settings: self.settings.historyDetailsSettings)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        return view
    }()
    
    lazy var timeView: DetailsBottomView = {
        let view = DetailsBottomView(type: .time, settings: self.settings.historyDetailsSettings)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        return view
    }()
    
    lazy var orderView: DetailsBottomView = {
        let view = DetailsBottomView(type: .order, settings: self.settings.historyDetailsSettings)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        return view
    }()
    
    var viewModel: HistoryViewModel {
        didSet {
            self.setupModel()
        }
    }
    var settings: UBHistorySettings
    var countStops = 5
    var hasMultiplesStops = false
    
    init(model: HistoryViewModel, settings: UBHistorySettings = .default, hasMultipleStops: Bool = false) {
        self.hasMultiplesStops = hasMultipleStops
        self.viewModel = model
        self.countStops = model.points?.count ?? 0
        self.settings = settings
        super.init(frame: .zero)
        self.viewModel.serviceOrder != nil ? self.setup() : self.removeOrderView()
//        self.setup()
        self.setupModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        self.backgroundColor = .white

        if self.hasMultiplesStops{
            self.addSubview(stopsViewstack)
            self.setupStack()
            self.stopsViewstack.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0))
            let stackHeight = self.stopsViewstack.heightAnchor.constraint(equalToConstant: 0)
            stackHeight.priority = .defaultLow
            stackHeight.isActive = true
            
            self.borderView.anchor(top: self.stopsViewstack.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor , padding: .init(top: 20, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 1))
        }else{
            self.originView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, padding: .init(top: 30, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 96.dynamic()))
            self.destinyView.anchor(top: self.topAnchor, left: self.originView.rightAnchor, bottom: nil, right: self.rightAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 96.dynamic()))
            self.originView.widthAnchor.constraint(equalTo: self.destinyView.widthAnchor).isActive = true
            self.borderView.anchor(top: self.originView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, size: .init(width: 0, height: 1))
            
//            self.borderView.anchor(top: self.originView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor , padding: .init(top: 20, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 1))
        }
        

        self.orderView.anchor(top: self.timeView.topAnchor, left: self.leftAnchor, bottom: nil, right: self.timeView.leftAnchor, size: .init(width: 0, height: 70.dynamic()))
        self.timeView.anchor(top: self.borderView.bottomAnchor, left: nil, bottom: self.bottomAnchor, right: self.distanceView.leftAnchor, padding: .init(top: 12, left: 0, bottom: 12, right: 0), size: .init(width: 0, height: 70.dynamic()))
        self.distanceView.anchor(top: self.timeView.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, size: .init(width: 0, height: 70.dynamic()))
       
        self.timeView.widthAnchor.constraint(equalTo: self.orderView.widthAnchor).isActive = true
        self.distanceView.widthAnchor.constraint(equalTo: self.timeView.widthAnchor).isActive = true
        self.setupOrderView()
    }
    
    func setupModel() {
        self.timeView.fillUI(firstText: self.viewModel.day, secondText: self.viewModel.time)
        self.distanceView.fillUI(firstText: self.viewModel.distance, secondText: self.viewModel.duration)
        self.viewModel.serviceOrder != nil ? self.setup() :  self.removeOrderView()
    }
    
    func setupOrderView(){
        if let _order = self.viewModel.serviceOrder {
            self.orderView.fillUI(firstText: "", secondText: "\(_order)")
        }
    }
    
    func removeOrderView(){
        self.backgroundColor = .white
        
        if self.hasMultiplesStops{
           self.addSubview(stopsViewstack)
           self.setupStack()
           self.stopsViewstack.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0))
           let stackHeight = self.stopsViewstack.heightAnchor.constraint(equalToConstant: 0)
           stackHeight.priority = .defaultLow
           stackHeight.isActive = true

           self.borderView.anchor(top: self.stopsViewstack.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor , padding: .init(top: 20, left: 0, bottom: 0, right: 0),size: .init(width: 0, height: 1))
        }else{
            self.originView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, padding: .init(top: 30, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 96.dynamic()))
            self.destinyView.anchor(top: self.topAnchor, left: self.originView.rightAnchor, bottom: nil, right: self.rightAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 96.dynamic()))
            self.originView.widthAnchor.constraint(equalTo: self.destinyView.widthAnchor).isActive = true
            self.borderView.anchor(top: self.originView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, size: .init(width: 0, height: 1))
        }
        
        self.timeView.anchor(top: self.borderView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 70.dynamic()))
        self.distanceView.anchor(top: self.timeView.topAnchor, left: self.timeView.rightAnchor, bottom: nil, right: self.rightAnchor, size: .init(width: 0, height: 70.dynamic()))
        self.distanceView.widthAnchor.constraint(equalTo: self.timeView.widthAnchor).isActive = true
    }
    
    func setupStack(){
        self.stopsViewstack.spacing = 30
        if self.stopsViewstack.arrangedSubviews.count == 0{
            guard let _count = self.viewModel.points?.count else {return}
            for i in 0..<_count{
                guard let _point = self.viewModel.points?[i] else {return}
                let view = StopsView(point: _point, stopCount: i)
                self.stopsViewstack.addArrangedSubview(view)
            }
            
        }
    
    }
    
    func cleanStack() {
        self.stopsViewstack.arrangedSubviews.forEach({
            $0.isHidden = true
        })
    }
    
    func showStack() {
        self.stopsViewstack.arrangedSubviews.forEach({
            $0.isHidden = false
        })
    }
    
}
