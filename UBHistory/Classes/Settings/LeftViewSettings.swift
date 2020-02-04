//
//  LeftViewSettings.swift
//  UBHistory
//
//  Created by Usemobile on 25/09/19.
//

import Foundation


public class LeftViewSettings {
    public var valueFont: UIFont
    public var valueColor: UIColor
    public var cancelledFont: UIFont
    public var cancelledColor: UIColor
    public var notRatedFont: UIFont
    public var notRatedColor: UIColor
    public var dateFont: UIFont
    public var dateColor: UIColor
    public var timeFont: UIFont
    public var timeColor: UIColor
    public var serviceOrderFont: UIFont
    public var serviceOrderColor: UIColor
    
    public var starFilled: UIImage?
    public var starEmpty: UIImage?
    
    public static var `default`: LeftViewSettings {
        return LeftViewSettings(valueFont: .systemFont(ofSize: 18), valueColor: .black, cancelledFont: .systemFont(ofSize: 10), cancelledColor: .cancelledRed, notRatedFont: .systemFont(ofSize: 10), notRatedColor: #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1), dateFont: .systemFont(ofSize: 10, weight: .light), dateColor: #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), timeFont: .boldSystemFont(ofSize: 10), timeColor: #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), serviceOrderFont: .systemFont(ofSize: 10, weight: .regular))
    }
    
    public init(valueFont: UIFont, valueColor: UIColor = .black, cancelledFont: UIFont, cancelledColor: UIColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1), notRatedFont: UIFont, notRatedColor: UIColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1), dateFont: UIFont, dateColor: UIColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), timeFont: UIFont, timeColor: UIColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), serviceOrderFont: UIFont, serviceOrderColor: UIColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1) ,starFilled: UIImage? = nil, starEmpty: UIImage? = nil) {
        self.valueFont = valueFont
        self.valueColor = valueColor
        self.cancelledFont = cancelledFont
        self.cancelledColor = cancelledColor
        self.notRatedFont = notRatedFont
        self.notRatedColor = notRatedColor
        self.dateFont = dateFont
        self.dateColor = dateColor
        self.timeFont = timeFont
        self.timeColor = timeColor
        self.serviceOrderFont = serviceOrderFont
        self.serviceOrderColor = serviceOrderColor
        
        self.starFilled = starFilled
        self.starEmpty = starEmpty
    }
}
