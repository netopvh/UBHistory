//
//  SegmentedSettings.swift
//  UBHistory
//
//  Created by Usemobile on 25/09/19.
//

import Foundation


public class SegmentedSettings {
    
    public var titleFont: UIFont
    public var barBackgroundColor: UIColor
    public var backgroundColor: UIColor = .blue
    
    public static var `default`: SegmentedSettings {
        return SegmentedSettings(titleFont: UIFont.systemFont(ofSize: 17, weight: .medium))
    }
    
    public init(titleFont: UIFont,
                barBackgroundColor: UIColor = .white) {
        self.titleFont = titleFont
        self.barBackgroundColor = barBackgroundColor
    }
    
}
