//
//  RightViewSettings.swift
//  UBHistory
//
//  Created by Usemobile on 25/09/19.
//

import Foundation


public class RightViewSettings {
    public var originFont: UIFont
    public var originColor: UIColor
    public var destinyFont: UIFont
    public var destinyColor: UIColor
    public var originTintColor: UIColor
    public var cancelledTintColor: UIColor?
    
    public var imageOrigin: UIImage?
    public var imageRoute: UIImage?
    public var imageDestiny: UIImage?
    public var imageTrash: UIImage?
    
    public static var `default`: RightViewSettings {
        return RightViewSettings(originFont: .systemFont(ofSize: 14), originColor: #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1), destinyFont: .systemFont(ofSize: 14), destinyColor: #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1), originTintColor: .mainColor)
    }
    
    public init(originFont: UIFont, originColor: UIColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1), destinyFont: UIFont, destinyColor: UIColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1), originTintColor: UIColor, cancelledTintColor: UIColor? = nil, imageOrigin: UIImage? = nil, imageRoute: UIImage? = nil, imageDestiny: UIImage? = nil, imageTrash: UIImage? = nil) {
        self.originFont = originFont
        self.originColor = originColor
        self.destinyFont = destinyFont
        self.destinyColor = destinyColor
        self.originTintColor = originTintColor
        self.cancelledTintColor = cancelledTintColor
        self.imageOrigin = imageOrigin
        self.imageRoute = imageRoute
        self.imageDestiny = imageDestiny
        self.imageTrash = imageTrash
    }
    
}
