//
//  SchedulesSettings.swift
//  UBHistory
//
//  Created by Usemobile on 25/09/19.
//

import UIKit

public class ScheduleLeftViewSettings {
    
    public var dayFont: UIFont
    public var timeFont: UIFont
    public var categoryTitleFont: UIFont
    public var categoryFont: UIFont
    
    public var dayColor: UIColor
    public var timeColor: UIColor
    public var categoryTitleColor: UIColor
    public var categoryColor: UIColor
    
    public static var `default`: ScheduleLeftViewSettings {
        return ScheduleLeftViewSettings(dayFont: UIFont.systemFont(ofSize: 15, weight: .light),
                                        timeFont: UIFont.systemFont(ofSize: 15, weight: .bold),
                                        categoryTitleFont: UIFont.systemFont(ofSize: 15, weight: .light),
                                        categoryFont: UIFont.systemFont(ofSize: 15, weight: .bold))
    }
    
    public init(dayFont: UIFont,
                timeFont: UIFont,
                categoryTitleFont: UIFont,
                categoryFont: UIFont,
                dayColor: UIColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1),
                timeColor: UIColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1),
                categoryTitleColor: UIColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1),
                categoryColor: UIColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)) {
        self.dayFont = dayFont
        self.timeFont = timeFont
        self.categoryTitleFont = categoryTitleFont
        self.categoryFont = categoryFont
        
        self.dayColor = dayColor
        self.timeColor = timeColor
        self.categoryTitleColor = categoryTitleColor
        self.categoryColor = categoryColor
    }
    
}
