//
//  Extensions.swift
//  USE_Chat
//
//  Created by Usemobile on 06/03/19.
//

import Foundation
import UIKit

public extension String {
    public static func getStringFrom(customClass: AnyClass, key: String) -> String? {
        //        let string = NSLocalizedString(key, tableName: nil, bundle: Bundle(for: customClass), value: "", comment: "")
        //        return string
        if let path = Bundle(for: customClass).path(forResource: "UBHistory", ofType: "bundle"), let bundle = Bundle(path: path) {
            return NSLocalizedString(key, bundle: bundle, comment: "")
        } else {
            return nil
        }
//        if let bundle = Bundle(path: Bundle(for: customClass).path(forResource: "UBHistory", ofType: "bundle") ?? "") {
//            return NSLocalizedString(key, bundle: bundle, comment: "")
//        } else {
//            return nil
//        }
        //        return NSLocalizedString(key, bundle: Bundle(for: customClass), comment: "")
    }
}

extension UIImage {
    
    class func getFrom(nameResource: String, type: String) -> UIImage? {
        guard let bundle = Bundle.main.path(forResource: nameResource, ofType: type) else { return nil }
        let url = URL(fileURLWithPath: bundle)
        guard let data = try? Data(contentsOf: url) else { return nil }
        let image = UIImage(data: data)
        return image
    }
    
    class func getFrom(customClass: AnyClass, nameResource: String) -> UIImage? {
        let bundle = Bundle(for: customClass)
        return UIImage(named: "UBHistory.bundle/\(nameResource)", in: bundle, compatibleWith: nil)
    }
    
    class func getFrom(customClass: AnyClass, nameResource: String, type: String) -> UIImage? {
        guard let bundle = Bundle(for: customClass).path(forResource: nameResource, ofType: type) else { return nil }
        let url = URL(fileURLWithPath: bundle)
        guard let data = try? Data(contentsOf: url) else { return nil }
        let image = UIImage(data: data)
        return image
    }
}

extension UIView {
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    //    func fillSuperview() {
    //        anchor(top: superview?.topAnchor, left: superview?.leftAnchor, bottom: superview?.bottomAnchor, right: superview?.rightAnchor)
    //    }
    
    func fillSuperview(with padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        self.anchor(top: self.superview?.topAnchor, left: self.superview?.leftAnchor, bottom: self.superview?.bottomAnchor, right: self.superview?.rightAnchor, padding: padding, size: size)
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
            
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: padding.left).isActive = true
            
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -padding.right).isActive = true
            
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
            
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
    
    func applyLightShadow() {
        self.applyShadow(opacity: 0.2, shadowRadius: 3.0)
    }
    
    func applyShadow(opacity: Float, shadowRadius: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = opacity
    }
    
    
    func applyCircle() {
        self.setCorner(self.bounds.height/2)
    }
    
    func setCorner(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func applyCustomShadowToCircle(shadowOpacity: Float, shadowRadius: CGFloat) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
    }
    
    func applyLightShadowToCircle() {
        self.applyCustomShadowToCircle(shadowOpacity: 0.2, shadowRadius: 3)
    }
    
    func applyShadowToCircle() {
        self.applyCustomShadowToCircle(shadowOpacity: 0.5, shadowRadius: 5)
    }
    
    func removeShadow() {
        self.layer.shadowPath = nil
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 0
        self.layer.shadowOpacity = 0
    }
    
    func setBottomShadow() {
        self.addshadow(top: false, left: false, bottom: true, right: false)
    }
    
    func addshadow(top: Bool,
                   left: Bool,
                   bottom: Bool,
                   right: Bool,
                   shadowRadius: CGFloat = 1.5) {
        
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = 0.3
        
        let path = UIBezierPath()
        var x: CGFloat = 0
        var y: CGFloat = 0
        var viewWidth = self.frame.width
        var viewHeight = self.frame.height
        
        // here x, y, viewWidth, and viewHeight can be changed in
        // order to play around with the shadow paths.
        if (!top) {
            y+=(shadowRadius+1)
        }
        if (!bottom) {
            viewHeight-=(shadowRadius+1)
        }
        if (!left) {
            x+=(shadowRadius+1)
        }
        if (!right) {
            viewWidth-=(shadowRadius+1)
        }
        // selecting top most point
        path.move(to: CGPoint(x: x, y: y))
        // Move to the Bottom Left Corner, this will cover left edges
        /*
         |☐
         */
        path.addLine(to: CGPoint(x: x, y: viewHeight))
        // Move to the Bottom Right Corner, this will cover bottom edge
        /*
         ☐
         -
         */
        path.addLine(to: CGPoint(x: viewWidth, y: viewHeight))
        // Move to the Top Right Corner, this will cover right edge
        /*
         ☐|
         */
        path.addLine(to: CGPoint(x: viewWidth, y: y))
        // Move back to the initial point, this will cover the top edge
        /*
         _
         ☐
         */
        path.close()
        self.layer.shadowPath = path.cgPath
    }
}

extension UIColor {
    
    static let chatBarBG: UIColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
    static let textViewBorder: UIColor = #colorLiteral(red: 0.9176470588, green: 0.9098039216, blue: 0.9098039216, alpha: 1)
    static let sendButton: UIColor = #colorLiteral(red: 0.08235294118, green: 0.5725490196, blue: 0.9019607843, alpha: 1)
    static let cancelledRed: UIColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
    static let mainColor: UIColor = #colorLiteral(red: 0.08235294118, green: 0.4470588235, blue: 0.6196078431, alpha: 1)
    static let hexB9B9B9: UIColor = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
    static let hex777777: UIColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
    static let hex707070: UIColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
}


extension UITextField {
    
    func setPlaceholderFont(_ text: String, _ font: UIFont, _ color: UIColor) {
        let attributes = [
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: font
        ]
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)
    }
    
}

extension UIDevice {
    
    static let isXFamily: Bool = {
        return UIScreen.main.bounds.size.height >= 812
    }()
    
    static let isSmallerDevice: Bool = {
        return UIScreen.main.bounds.size.height < 667
    }()
    
}

extension UIImageView {
    
    func cast(urlStr: String, placeholder: UIImage? = nil, completion: ((UIImage?, String?) -> Void)? = nil) {
        self.image = placeholder
        guard let url = URL.init(string: urlStr) else {
            completion?(nil, .invalidURL)
            return
        }
        URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    let image: UIImage? = UIImage(data: data)
                    completion?(image, nil)
                    self.image = image ?? placeholder
                }
            } else if let error = error {
                completion?(nil, error.localizedDescription)
            } else {
                completion?(nil, .imageCastFail)
            }
            }.resume()
    }
}

extension Double {
    
    func currency() -> String {
        
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: currentLanguage.rawValue)
        formatter.numberStyle = .currency
        return (formatter.string(from: self as NSNumber) ?? "")
        //            .replacingOccurrences(of: "R$", with: "R$ ")
    }
}

extension Date {
    
    func setup (_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let date = formatter.string(from: self)
        return date
    }
    
    func iso8601() -> String {
        return self.setup("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    }
}

extension String {
    
    func getPreferredLocale() -> Locale {
        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: preferredIdentifier)
    }
    
    func setup(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = self.getPreferredLocale()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let dateOld = formatter.date(from: self)
        let date = dateOld?.setup(format)
        return date ?? ""
    }
    
    func dayMonthYear() -> String? {
        return setup("E, dd MMM yyyy")
    }
    
    func hour() -> String? {
        return setup("HH:mm")
    }
    
    func dayWithMonth() -> String? {
        return setup("dd MMM").uppercased()
    }
    
    func dayOfWeek() -> String? {
        return setup("EE").capitalized
    }
    
    func dayOfYear() -> String? {
        return setup("dd").capitalized
    }
    
    func fullDate() -> String? {
        return setup("dd/MMM/yyyy")
    }
    
    func dateWithTime() -> String? {
        return setup("dd/MM/yyyy HH:mm")
    }
    
}

extension CGFloat {
    
    func dynamic() -> CGFloat {
        return UIDevice.isSmallerDevice ? self * 0.8 : self
    }
    
}


extension Double {
    
    func dynamic() -> Double {
        return Double(CGFloat(self).dynamic())
    }
    
}

extension Int {
    
    func dynamic() -> Int {
        return Int(CGFloat(self).dynamic())
    }
    
    func timeFormat() -> String {
        let seconds = self%60
        let minutes = self/60
        let hours = self/3600
        let secondsStr = seconds < 10 ? "0\(seconds)" : "\(seconds)"
        let minutesStr = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        let hoursStr = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        return hours > 0 ? hoursStr + ":" + minutesStr + ":" + secondsStr :
            minutesStr + ":" + secondsStr
    }
    
}



