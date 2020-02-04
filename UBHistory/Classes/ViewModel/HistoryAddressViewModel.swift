//
//  HistoryAddressViewModel.swift
//  UBHistory
//
//  Created by Usemobile on 08/03/19.
//

import Foundation

open class HistoryAddressViewModel {
    public let objectId: String?
    
    public let address: String?
    public let city: String?
    public let neighborhood: String?
    public let number: String?
    public let state: String?
    public let zip: String?
    
    public var primaryAddress: String {
        let _address = self.address ?? ""
        let _number  = self.number ?? ""
        return _number.isEmpty ? _address : (_address.isEmpty ? _number : _address + ", " + _number)
    }
    
    public var secondaryAddress: String {
        let _neighborhood = self.neighborhood ?? ""
        let _city  = self.city ?? ""
        return _city.isEmpty ? _neighborhood : (_neighborhood.isEmpty ? _city : _neighborhood + ", " + _city)
    }
    
    public lazy var mainAddress: String = {
        return self.primaryAddress.isEmpty ? self.secondaryAddress : self.primaryAddress
    }()
    
    public lazy var oneLineFullAddress: String = {
        return self.getFullAddress(separetedBy: " - ")
    }()
    
    public lazy var twoLineFullAddress: String = {
        return self.getFullAddress(separetedBy: ",\n")
    }()
    
    public init(objectId: String? = nil,
         address: String? = nil,
         neighborhood: String? = nil,
         city: String? = nil,
         number: String? = nil,
         state: String? = nil,
         zip: String? = nil) {
        self.objectId = objectId
        
        self.address = address
        self.neighborhood = neighborhood
        self.city = city
        self.number = number
        self.state = state
        self.zip = zip
    
    }
    
    private func getFullAddress(separetedBy: String) -> String{
        return self.primaryAddress.isEmpty ? self.secondaryAddress : (self.secondaryAddress.isEmpty ? self.primaryAddress : (self.primaryAddress + separetedBy + self.secondaryAddress))
    }
}
