//
//  HelpView.swift
//  UBHistory
//
//  Created by Usemobile on 14/03/19.
//

import Foundation

protocol HelpViewDelegate {
    func sendMessagePressed(_ helpView: HelpView)
    func didSelectHelpItem(_ helpView: HelpView, at indexPath: IndexPath)
}

class HelpView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 45
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HelpCell.self, forCellReuseIdentifier: kHelpCell)
        self.addSubview(tableView)
        return tableView
    }()
    
    lazy var btnSendMessage: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.btnSendMessagePressed(_:)), for: .touchUpInside)
        self.addSubview(button)
        return button
    }()
    
    let kHelpCell = "HelpCell"
    
    var helpItems = [String]() {
        didSet {
            self.setup()
            self.tableView.reloadData()
        }
    }
    
    var viewModel: HistoryViewModel
    var settings: UBHistorySettings
    var delegate: HelpViewDelegate?
    
    init(model: HistoryViewModel, settings: UBHistorySettings = .default) {
        self.viewModel = model
        self.settings = settings
        super.init(frame: .zero)
        DispatchQueue.main.async {
            self.setup()
            self.setupSettings()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let maxTableHeight = self.bounds.height - (UIDevice.isXFamily ? 64 : 44)
        let estimatedHeight = CGFloat(self.helpItems.count * 45)
        let tableHeight = estimatedHeight >= maxTableHeight ? maxTableHeight : estimatedHeight
        self.backgroundColor = .white
        self.tableView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.btnSendMessage.topAnchor, right: self.rightAnchor, size: .init(width: 0, height: tableHeight))
        self.btnSendMessage.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.btnSendMessage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.btnSendMessage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func setupSettings() {
        let color = self.settings.mainColor
        let attributedText = NSMutableAttributedString(string: .sendMessage, attributes: [NSAttributedString.Key.font: self.settings.historyDetailsSettings.buttonFont, NSAttributedString.Key.foregroundColor: color,
                                                                                               NSAttributedString.Key.underlineStyle: 1, NSAttributedString.Key.underlineColor: color])
        self.btnSendMessage.setAttributedTitle(attributedText, for: .normal)
    }
    
    @objc func btnSendMessagePressed(_ sender: UIButton) {
        self.delegate?.sendMessagePressed(self)
    }
}

extension HelpView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectHelpItem(self, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        (tableView.cellForRow(at: indexPath) as? HelpCell)?.setSelection(selected: true)
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        (tableView.cellForRow(at: indexPath) as? HelpCell)?.setSelection(selected: false)
    }
}

extension HelpView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.helpItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kHelpCell, for: indexPath) as! HelpCell
        cell.settings = self.settings
        cell.lblText.text = self.helpItems[indexPath.row]
        return cell
    }
}

