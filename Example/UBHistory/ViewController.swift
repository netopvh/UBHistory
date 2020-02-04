//
//  ViewController.swift
//  UBHistory_Example
//
//  Created by Usemobile on 15/03/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import UBHistory

class ViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
        
        let button = UIButton(frame: .init(x: 0, y: 0, width: 100, height: 44))
        button.setTitle(NSLocalizedString("history_button", comment: ""), for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(historyPressed), for: .touchUpInside)
        self.view.addSubview(button)
        button.center = self.view.center
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var historyCoordinator: HistoryCoordinator?
    
    var currentHistoryPage = 0
    var currentSchedulesPage = 0
    var maxPage = 2
    
    lazy var language: HistoryLanguage = {
//        let languageCode = Locale.current.languageCode
//        switch languageCode?.lowercased() {
//        case "en":
//            return .en
//        default:
//            return .pt
//        }
        return .pt
    }()
    
    @objc func historyPressed() {
        let nav = UINavigationController()
        nav.navigationBar.tintColor = .white
        nav.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        nav.navigationBar.barTintColor = #colorLiteral(red: 0.08235294118, green: 0.4470588235, blue: 0.6196078431, alpha: 1)
        nav.navigationBar.isTranslucent = false
        nav.modalPresentationStyle = .overFullScreen
        let settings = UBHistorySettings.default
//        settings.hasPaymentInfos = false
        settings.isUserApp = true
        settings.language = self.language
        settings.emptyImage = #imageLiteral(resourceName: "emptyHistory")
        settings.closeImage = #imageLiteral(resourceName: "close")
        settings.historyDetailsSettings.mapPlaceholder = #imageLiteral(resourceName: "iconPlaceholder")
        settings.hasSchedules = true
//        settings.rightViewSettings.imageTrash = #imageLiteral(resourceName: "trash")
        self.historyCoordinator = HistoryCoordinator(navigationController: nav)
        self.historyCoordinator?.delegate = self
        self.historyCoordinator?.start(settings: settings)
//        self.historyCoordinator?.setupHistory([])
        
        
        self.present(nav, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.historyCoordinator?.setupHistory([], hasInfiniteScroll: false)
        }
    }
    
    var pointsOne: [Point] = [Point(visited: true, address: Address(address: "Republica Dusmininu", city: "Ouro Preto", neighborhood: "Bauxita", state: "Minas Gerais", zip: "35400000", number: "15", location: Location(latitude: -20, longitude: -43)), type: "origin", duration: ""),
                              Point(visited: true, address: Address(address: "Usemobile", city: "Ouro Preto", neighborhood: "Bauxita", state: "Minas Gerais", zip: "35400000", number: "151", location: Location(latitude: -20, longitude: -53)), type: "destiny", duration: "")]
    
    var pointsTwo: [Point] = [Point(visited: true, address: Address(address: "Republica Dusmininu", city: "Ouro Preto", neighborhood: "Bauxita", state: "Minas Gerais", zip: "35400000", number: "15", location: Location(latitude: -20, longitude: -43)), type: "origin", duration: ""),
                              Point(visited: true, address: Address(address: "Manos Lanches", city: "Ouro Preto", neighborhood: "Bauxita", state: "Minas Gerais", zip: "35400000", number: "10", location: Location(latitude: -21, longitude: -50)), type: "point" ,duration: "1:05"),
                              Point(visited: false, address: Address(address: "Usemobile", city: "Ouro Preto", neighborhood: "Bauxita", state: "Minas Gerais", zip: "35400000", number: "151", location: Location(latitude: -20, longitude: -53)), type: "destiny", duration: "")]
    
    var pointsThree: [Point] = [Point(visited: true, address: Address(address: "Republica Dusmininu", city: "Ouro Preto", neighborhood: "Bauxita", state: "Minas Gerais", zip: "35400000", number: "15", location: Location(latitude: -20, longitude: -43)), type: "origin", duration: ""),
                              Point(visited: true, address: Address(address: "Manos Lanches", city: "Ouro Preto", neighborhood: "Bauxita", state: "Minas Gerais", zip: "35400000", number: "10", location: Location(latitude: -21, longitude: -50)), type: "point",duration: "1:05"),
                              Point(visited: true, address: Address(address: "Corpus Prime", city: "Ouro Preto", neighborhood: "Bauxita", state: "Minas Gerais", zip: "35400000", number: "73", location: Location(latitude: -20, longitude: -37)), type: "point",duration: "2:55"),
                              Point(visited: false, address: Address(address: "Epa Plus", city: "Ouro Preto", neighborhood: "Bauxita", state: "Minas Gerais", zip: "35400000", number: "1000", location: Location(latitude: -20, longitude: -42)), type: "point",duration: "0:45"),
                              Point(visited: false, address: Address(address: "Usemobile", city: "Ouro Preto", neighborhood: "Bauxita", state: "Minas Gerais", zip: "35400000", number: "151", location: Location(latitude: -20, longitude: -53)), type: "destiny", duration: "")]
    
    lazy var historyCells: [HistoryViewModel] = {
        return [
            HistoryViewModel(language: self.language, objectId: "0", value: 9.87, rate: nil, date: "2019-07-15T22:47:00.000Z", distance: 4.626, duration: 2, cancelledBy: nil, bigMap: "a", card: nil, serviceOrder: 0123456,points: self.pointsOne ,user: HistoryUserViewModel(name: "Patrick", lastName: "Soares", rate: 5.0, vehicle: nil, profileImage: ""), origin: HistoryAddressViewModel(objectId: nil, address: "Rua Professor Fransico Pignataro, Ouro Preto", neighborhood: "Bauxita", city: "Ouro Preto", number: nil, state: nil, zip: nil), destiny: HistoryAddressViewModel(objectId: nil, address: "Rua Dois de Setembro, Ouro Preto", neighborhood: "Campus do Cruzeiro", city: "Ouro Preto", number: nil, state: nil, zip: nil)),
            HistoryViewModel(language: self.language, objectId: "1", value: 35, rate: 5, date: "2019-07-11T22:47:00.000Z", bigMap: "a", card: "visa 3821", points: self.pointsOne , user: HistoryUserViewModel(name: "Tulio", lastName: "Parreiras", rate: 4.8, vehicle: HistoryVehicleViewModel(brand: "Ford", model: "Fiesta", plate: "ABC1234"), profileImage: "https://scontent.fcnf1-1.fna.fbcdn.net/v/t1.0-9/388816_211336025612084_1271640720_n.jpg?_nc_cat=109&_nc_ht=scontent.fcnf1-1.fna&oh=79edf8e91a78a7c3b47b00c8539c098a&oe=5D19B87B"), origin: HistoryAddressViewModel(address: "Av. lacerda franco", number: "987"), destiny: HistoryAddressViewModel(address: "Al. Campinas", number: "1788")),
            HistoryViewModel( language: self.language, objectId: "2", date: "2019-07-11T00:52:00.000Z", cancelledBy: "passenger", origin: HistoryAddressViewModel(address: "Av. Paulista", number: "500"), destiny: HistoryAddressViewModel(address: "Al. barão dia", number: "654")),
            HistoryViewModel(language: self.language, objectId: "3", value: 23.1, date: "2019-07-10T22:21:00.000Z", bigMap: "a", serviceOrder: 0, points: self.pointsTwo,user: HistoryUserViewModel(name: "Tulio", lastName: "Parreiras", rate: 4.8, vehicle: HistoryVehicleViewModel(brand: "Ford", model: "Fiesta", plate: "ABC1234"), profileImage: "https://scontent.fcnf1-1.fna.fbcdn.net/v/t1.0-9/388816_211336025612084_1271640720_n.jpg?_nc_cat=109&_nc_ht=scontent.fcnf1-1.fna&oh=79edf8e91a78a7c3b47b00c8539c098a&oe=5D19B87B"), origin: HistoryAddressViewModel(address: "Rua moacir", neighborhood: "São Cristóvão", city: "Teresina", number: "1285"), destiny: HistoryAddressViewModel(address: "Rua moacir", neighborhood: "Paulista", city: "Teresina", number: "1285")),
            HistoryViewModel(language: self.language, objectId: "4", value: 9.12, rate: 3, date: "2019-07-03T09:52:00.000Z",points: self.pointsThree ,user: HistoryUserViewModel(name: "Tulio", rate: 4.8, vehicle: HistoryVehicleViewModel(brand: "Ford", model: "Fiesta", plate: "ABC1234"), profileImage: "https://scontent.fcnf1-1.fna.fbcdn.net/v/t1.0-9/388816_211336025612084_1271640720_n.jpg?_nc_cat=109&_nc_ht=scontent.fcnf1-1.fna&oh=79edf8e91a78a7c3b47b00c8539c098a&oe=5D19B87B"), origin: HistoryAddressViewModel(address: "Rua moacir", neighborhood: "São Cristóvão", city: "Teresina", number: "1285"), destiny: HistoryAddressViewModel(address: "Rua moacir", neighborhood: "Paulista", city: "Teresina", number: "1285")),
            HistoryViewModel(language: self.language, objectId: "5", value: 9.12, date: "2019-07-03T09:52:00.000Z",serviceOrder: 0123456,points: self.pointsThree ,user: HistoryUserViewModel(name: "Tulio", lastName: "Parreiras", rate: 4.8, vehicle: HistoryVehicleViewModel(brand: "Ford", model: "Fiesta", plate: "ABC1234"), profileImage: "https://scontent.fcnf1-1.fna.fbcdn.net/v/t1.0-9/388816_211336025612084_1271640720_n.jpg?_nc_cat=109&_nc_ht=scontent.fcnf1-1.fna&oh=79edf8e91a78a7c3b47b00c8539c098a&oe=5D19B87B"), origin: HistoryAddressViewModel(address: "Rua moacir", neighborhood: "São Cristóvão", city: "Teresina", number: "1285"), destiny: HistoryAddressViewModel(address: "Rua moacir", neighborhood: "Paulista", city: "Teresina", number: "1285"))
        ]
        }()

    func getHistory(completion: @escaping([HistoryViewModel]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0...1.5)) {
            let cells = self.historyCells
            
            let leftFont = UIFont.systemFont(ofSize: 12)
            let leftColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
            let rightFont = UIFont.systemFont(ofSize: 12)
            let rightColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
            let leftAttributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.font: leftFont,
                NSAttributedString.Key.foregroundColor: leftColor
            ]
            let rightAttributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.font: rightFont,
                NSAttributedString.Key.foregroundColor: rightColor
            ]
            cells[0].receiptCellModels = [
                HistoryReceiptModel(leftText: NSAttributedString(string: "VALOR DA VIAGEM", attributes: leftAttributes), rightText: NSAttributedString(string: "R$ 22,34", attributes: rightAttributes)),
                HistoryReceiptModel(leftText: NSAttributedString(string: "CUSTO FIXO", attributes: leftAttributes), rightText: NSAttributedString(string: "R$ 22,34", attributes: rightAttributes)),
                HistoryReceiptModel(leftText: NSAttributedString(string: "VALOR TOTAL", attributes: leftAttributes), rightText: NSAttributedString(string: "R$ 22,34", attributes: rightAttributes))
            ]
            completion(cells)
        }
    }
    
}

extension ViewController: HistoryCoordinatorDelegate {
    
    func historyCoordinator(_ historyCoordinator: HistoryCoordinator, historyDetailsPushedFor viewController: UBHistoryDetailsController, historyId: String?) {
        if let objectId = historyId {
            print("GET HISTORY INFOS FROM OBJECTID: ", objectId)
        }
        print("GET HELP INFOS: ")
    }
    
    func historyCoordinator(_ historyCoordinator: HistoryCoordinator, sendMessagePressedFor viewController: UBHistoryDetailsController, historyId: String) {
        print(">>>>> SEND MESSAGE PRESSED")
    }
    
    func historyCoordinator(_ historyCoordinator: HistoryCoordinator, shareReceiptFor viewController: UBHistoryDetailsController, historyId: String) {
        print(">>>>> SHARE RECEIPT: ", historyId)
    }
    
    func historyCoordinator(_ historyCoordinator: HistoryCoordinator, didSelectHelpItemAt indexPath: IndexPath) {
        
    }
    
    func historyCoordinatorEndCoordinator(_ historyCoordinator: HistoryCoordinator) {
        self.historyCoordinator = nil
    }
    
    func historyCoordinator(_ historyCoordinator: HistoryCoordinator, didRequestHistoryRefresh completion: @escaping ([HistoryViewModel]?, Bool) -> Void) {
//        if Bool.random() {
//            completion([], false)
//        } else {
//            if Bool.random() {
//                completion(nil, false)
//            } else {
                self.getHistory { (history) in
                    completion(history, true)
                }
                self.currentHistoryPage = 0
//            }
//        }
    }
    
    func historyCoordinator(_ historyCoordinator: HistoryCoordinator, didRequestHistoryInfiniteScroll completion: @escaping ([HistoryViewModel]?, Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0...1.5)) {
            self.currentHistoryPage += 1
            let hasInfiniteScroll = self.currentHistoryPage != self.maxPage
            print("Current History Page: ", self.currentHistoryPage)
            print("Max Page: ", self.maxPage)
            print("HAS INFINITE SCROLL: ", hasInfiniteScroll)
            completion(self.historyCells, hasInfiniteScroll)
        }
    }
    
    func historyCoordinator(_ historyCoordinator: HistoryCoordinator, didRequestDelete schedule: HistoryViewModel, on completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            let boolRandom = Bool.random()
            print("Delete: ", boolRandom)
            completion(boolRandom)
        }
    }
    
    func historyCoordinator(_ historyCoordinator: HistoryCoordinator, didRequestListSchedules completion: @escaping ([HistoryViewModel]?, Bool) -> Void) {
        self.getHistory { (history) in
            completion(history, true)
        }
        self.currentSchedulesPage = 0
    }
    
    func historyCoordinator(_ historyCoordinator: HistoryCoordinator, didRequestSchedulesRefresh completion: @escaping ([HistoryViewModel]?, Bool) -> Void) {
        if Bool.random() {
            completion([], false)
        } else {
            if Bool.random() {
                completion(nil, false)
            } else {
                self.getHistory { (history) in
                    completion(history, true)
                }
                self.currentSchedulesPage = 0
            }
        }
    }
    
    func historyCoordinator(_ historyCoordinator: HistoryCoordinator, didRequestSchedulesInfiniteScroll completion: @escaping ([HistoryViewModel]?, Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0...1.5)) {
            self.currentSchedulesPage += 1
            let hasInfiniteScroll = self.currentSchedulesPage != self.maxPage
            completion(self.historyCells, hasInfiniteScroll)
        }
    }
    
}

