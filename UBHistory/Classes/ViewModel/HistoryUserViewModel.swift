//
//  HistoryUserViewModel.swift
//  UBHistory
//
//  Created by Usemobile on 13/03/19.
//

import Foundation

open class HistoryUserViewModel {
    
    var name: String
    var rate: String
    var vehicle: String?
    var profileImage: String
    
    public init(name: String, lastName: String? = nil, rate: Double, vehicle: HistoryVehicleViewModel? = nil, profileImage: String) {
        self.name = lastName == nil ? name : name + " " + lastName!
        self.rate = String(format: "%.1f", rate)
        self.vehicle = vehicle?.description
        self.profileImage = profileImage
    }
    
}
