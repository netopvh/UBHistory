//
//  HistoryVehicleViewModel.swift
//  UBHistory
//
//  Created by Usemobile on 13/03/19.
//

import Foundation

open class HistoryVehicleViewModel {
    
    var description: String
    
    public init(brand: String, model: String, plate: String) {
        self.description = brand + " " + model + " - " + plate
    }
}
