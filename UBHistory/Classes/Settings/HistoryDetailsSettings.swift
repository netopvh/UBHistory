//
//  HistoryDetailsSettings.swift
//  UBHistory
//
//  Created by Usemobile on 25/09/19.
//

import Foundation


public class HistoryDetailsSettings {
    public var categoryFont: UIFont
    public var nameFont: UIFont
    public var vehicleFont: UIFont
    public var ratingFont: UIFont
    public var titlesFont: UIFont
    public var priceFont: UIFont
    public var addressFont: UIFont
    public var addressSubFont: UIFont
    public var dayFont: UIFont
    public var timeFont: UIFont
//    public var serviceOrderFont: UIFont
    public var helpFont: UIFont
    public var buttonFont: UIFont
    public var receiptTitleFont: UIFont
    public var receiptTextFont: UIFont
    
    public var helpImage: UIImage?
    public var helpArrow: UIImage?
    public var starFilled: UIImage?
    public var starEmpty: UIImage?
    public var mapPlaceholder: UIImage?
    public var avatarPlaceholder: UIImage?
    
    public var hasPaymentInfos = true
    
    public static var `default`: HistoryDetailsSettings {
        return HistoryDetailsSettings(categoryFont: .systemFont(ofSize: 10), nameFont: .boldSystemFont(ofSize: 18), vehicleFont: .systemFont(ofSize: 14), ratingFont: .systemFont(ofSize: 23), titlesFont: .systemFont(ofSize: 10), priceFont: .systemFont(ofSize: 30), addressFont: .systemFont(ofSize: 12, weight: .semibold), addressSubFont: .systemFont(ofSize: 11, weight: .semibold), dayFont: .systemFont(ofSize: 12, weight: .medium), timeFont: .systemFont(ofSize: 18, weight: .heavy), helpFont: .systemFont(ofSize: 12), buttonFont: .systemFont(ofSize: 15), receiptTitleFont: .systemFont(ofSize: 12), receiptTextFont: .systemFont(ofSize: 12))
    }
    
    public init(categoryFont: UIFont, nameFont: UIFont, vehicleFont: UIFont, ratingFont: UIFont, titlesFont: UIFont, priceFont: UIFont, addressFont: UIFont, addressSubFont: UIFont, dayFont: UIFont, timeFont: UIFont, helpFont: UIFont, buttonFont: UIFont, receiptTitleFont: UIFont, receiptTextFont: UIFont, helpImage: UIImage? = nil, helpArrow: UIImage? = nil, starFilled: UIImage? = nil, starEmpty: UIImage? = nil, mapPlaceholder: UIImage? = nil, avatarPlaceholder: UIImage? = nil) {
        self.categoryFont = categoryFont
        self.nameFont = nameFont
        self.vehicleFont = vehicleFont
        self.ratingFont = ratingFont
        self.titlesFont = titlesFont
        self.priceFont = priceFont
        self.addressFont = addressFont
        self.addressSubFont = addressSubFont
        self.dayFont = dayFont
        self.timeFont = timeFont
//        self.serviceOrderFont = serviceOrderFont
        self.helpFont = helpFont
        self.buttonFont = buttonFont
        self.receiptTitleFont = receiptTitleFont
        self.receiptTextFont = receiptTextFont
        
        self.helpImage = helpImage
        self.helpArrow = helpArrow
        self.starFilled = starFilled
        self.starEmpty = starEmpty
        self.mapPlaceholder = mapPlaceholder
        self.avatarPlaceholder = avatarPlaceholder
    }
    
}
