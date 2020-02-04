//
//  HistoryReceiptModel.swift
//  UBHistory
//
//  Created by Usemobile on 06/06/19.
//

import Foundation

open class HistoryReceiptModel {
    
    var leftText: NSAttributedString?
    var rightText: NSAttributedString?
    
    public init(leftText: NSAttributedString?,
                rightText: NSAttributedString?) {
        self.leftText = leftText
        self.rightText = rightText
    }
    
}
