//
//  HistoryViewModel.swift
//  UBHistory
//
//  Created by Usemobile on 08/03/19.
//

import Foundation

open class HistoryViewModel {
    public let objectId: String?
    
    public var value: String?
    public var rate: CGFloat?
    
    public var day: String?
    public var time: String?
    
    public var distance: String?
    public var duration: String?
    
    public var cancelled: String?
    
    public var bigMap: String?
    
    public var card: String?
    public var date: String?
    
    public var user: HistoryUserViewModel?
    
    public var originFull: String
    public var destinyFull: String
    
    public var originFirstLine: String
    public var originSecondLine: String
    public var destinyFirstLine: String
    public var destinySecondLine: String
    
    public var receiptCellModels: [HistoryReceiptModel]?
    
    public var category: String?
    
    public var serviceOrder: Int?
    
    public var points: [Point]?
    
    public init(language: HistoryLanguage = .pt, objectId: String?, value: Double? = nil, rate: Int? = nil, date: String? = nil, distance: Double? = nil, duration: Int? = nil, cancelledBy: String? = nil, bigMap: String? = nil, card: String? = nil,  category: String? = nil, serviceOrder: Int? = nil ,points: [Point]? = nil ,user: HistoryUserViewModel? = nil, origin: HistoryAddressViewModel, destiny: HistoryAddressViewModel, receiptCellModels: [HistoryReceiptModel]? = nil) {
        self.objectId = objectId
        self.value = value?.currency()
        self.rate = rate == nil ? nil : CGFloat(rate!)
        
        self.day = date?.dayWithMonth()
        self.time = date?.hour()
        
        self.distance = distance == nil ? nil : "\(distance!) KM"
        self.duration = duration?.timeFormat()
        
        var text: String? = nil
        switch cancelledBy?.lowercased()  {
        case "passenger":
            text = .cancelledByPassenger(language: language)
        case "driver":
            text = .cancelledByDriver(language: language)
        case "admin":
            text = .cancelledByAdmin(language: language)
        case nil:
            text = nil
        default:
            text = .cancelledBySystem(language: language)
        }
        self.cancelled = text
        
        self.bigMap = bigMap
        
        self.card = card
        self.date = date?.dateWithTime()
        
        self.user = user
        
        self.originFull = origin.oneLineFullAddress
        self.destinyFull = destiny.oneLineFullAddress
        
        self.originFirstLine = origin.primaryAddress
        self.originSecondLine = origin.secondaryAddress.replacingOccurrences(of: ",", with: " -")
        self.destinyFirstLine = destiny.primaryAddress
        self.destinySecondLine = destiny.secondaryAddress.replacingOccurrences(of: ",", with: " -")
        
        self.receiptCellModels = receiptCellModels
        
        self.category = category
        self.serviceOrder = serviceOrder
        self.points = points
    }
    
    
}
