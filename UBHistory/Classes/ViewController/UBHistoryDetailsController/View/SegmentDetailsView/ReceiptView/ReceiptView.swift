//
//  ReceiptView.swift
//  UBHistory
//
//  Created by Usemobile on 13/03/19.
//

import UIKit

protocol ReceiptViewDelegate {
    func shareReceipt(_ receiptView: ReceiptView)
}

class ReceiptView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 45
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.register(ReceiptCell.self, forCellReuseIdentifier: kReceiptCell)
        tableView.register(ReceiptButtonCell.self, forCellReuseIdentifier: kReceiptButtonCell)
        self.addSubview(tableView)
        return tableView
    }()
    
    lazy var cancelledView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.backgroundColor = .white
        self.addSubview(view)
        return view
    }()
    
    lazy var lblCancelled: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.8, green: 0.7960784314, blue: 0.7960784314, alpha: 1)
        label.text = .travelCancelledText
        label.textAlignment = .center
        self.cancelledView.addSubview(label)
        return label
    }()
    
    var viewModel: HistoryViewModel {
        didSet {
            self.setupModel()
        }
    }
    var settings: UBHistorySettings
    var delegate: ReceiptViewDelegate?
    
    let kReceiptCell = "ReceiptCell"
    let kReceiptButtonCell = "ReceiptButtonCell"
    
    var receiptModels: [HistoryReceiptModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    init(model: HistoryViewModel, settings: UBHistorySettings = .default) {
        self.viewModel = model
        self.settings = settings
        super.init(frame: .zero)
        self.setup()
        self.setupSettings()
        self.setupModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.backgroundColor = .white
        self.tableView.fillSuperview()
        DispatchQueue.main.async {
            self.bringSubviewToFront(self.cancelledView)
            self.cancelledView.fillSuperview()
            self.lblCancelled.anchor(top: self.cancelledView.topAnchor, left: self.cancelledView.leftAnchor, bottom: nil, right: self.cancelledView.rightAnchor, padding: .init(top: self.bounds.height/230*48, left: 0, bottom: 0, right: 0))
        }
    }
    
    private func setupSettings() {
        self.lblCancelled.font = self.settings.leftViewSettings.timeFont
    }
    
    private func setupModel() {
        let receiptModels = self.viewModel.receiptCellModels ?? []
        self.cancelledView.isHidden = receiptModels.isEmpty ? (self.viewModel.cancelled == nil) : true
        self.receiptModels = receiptModels
    }
    
    private func fillReceipt(with receiptCellModels: [HistoryReceiptModel]) {
        self.receiptModels = receiptCellModels
    }
}

extension ReceiptView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.receiptModels.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == self.receiptModels.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: kReceiptButtonCell, for: indexPath) as! ReceiptButtonCell
            cell.settings = self.settings
            cell.btnReceiptPressed = { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.delegate?.shareReceipt(strongSelf)
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: kReceiptCell, for: indexPath) as! ReceiptCell
        cell.viewModel = self.receiptModels[indexPath.row]
        return cell
    }
}

