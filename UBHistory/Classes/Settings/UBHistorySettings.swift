//
//  UBHistorySettings.swift
//  UBHistory
//
//  Created by Usemobile on 08/03/19.
//

import Foundation

public enum HistoryLanguage: String {
    case en = "en-US"
    case pt = "pt-BR"
    case es = "es-BO"
}

var currentLanguage: HistoryLanguage = .pt

public class UBHistorySettings {
    
    public var language: HistoryLanguage = .pt {
        didSet {
            currentLanguage = language
        }
    }
    
    public var mainColor: UIColor
    public var lottieName: String
    public var hasRefresh: Bool
    public var hasInfiniteScroll: Bool
    public var isUserApp: Bool
    public var leftViewSettings: LeftViewSettings
    public var rightViewSettings: RightViewSettings
    public var historyDetailsSettings: HistoryDetailsSettings
    public var segmentedSettings: SegmentedSettings
    public var scheduleLeftViewSettings: ScheduleLeftViewSettings
    
    public var emptyImage: UIImage?
    public var emptyFont: UIFont
    
    public var closeImage: UIImage?
    public var closeColor: UIColor
    public var retryTitleColor: UIColor = .white
    public var retryFont: UIFont = .systemFont(ofSize: 18, weight: .medium)
    
    public var forceTouchEnabled = false
    public var hasPaymentInfos = true {
        didSet {
            self.historyDetailsSettings.hasPaymentInfos = self.hasPaymentInfos
        }
    }
    public var hasSchedules: Bool = false
    
    public static var `default`: UBHistorySettings {
        return UBHistorySettings(mainColor: .mainColor, lottieName: "loading")
    }
    
    public init(mainColor: UIColor, lottieName: String, hasRefresh: Bool = true, hasInfiniteScroll: Bool = true, isUserApp: Bool = true, emptyImage: UIImage? = nil, emptyFont: UIFont = .systemFont(ofSize: 20), closeImage: UIImage? = nil, closeColor: UIColor = .white, retryTitleColor: UIColor = .white, leftViewSettings: LeftViewSettings = .default, rightViewSettings: RightViewSettings = .default, historyDetailsSettings: HistoryDetailsSettings = .default, segmentedSettings: SegmentedSettings = .default, scheduleLeftViewSettings: ScheduleLeftViewSettings = .default) {
        self.mainColor = mainColor
        self.lottieName = lottieName
        self.hasRefresh = hasRefresh
        self.hasInfiniteScroll = hasInfiniteScroll
        self.isUserApp = isUserApp
        self.emptyImage = emptyImage
        self.emptyFont = emptyFont
        self.closeImage = closeImage
        self.closeColor = closeColor
        //        self.retryTitleColor = retryTitleColor
        //        self.retryFont = retryFont
        self.leftViewSettings = leftViewSettings
        self.rightViewSettings = rightViewSettings
        self.historyDetailsSettings = historyDetailsSettings
        self.historyDetailsSettings.hasPaymentInfos = self.hasPaymentInfos
        self.segmentedSettings = segmentedSettings
        self.segmentedSettings.backgroundColor = mainColor
        self.scheduleLeftViewSettings = scheduleLeftViewSettings
    }
}
