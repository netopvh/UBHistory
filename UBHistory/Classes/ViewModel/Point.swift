//
//  Point.swift
//  Tipo Uber Cliente
//
//  Created by Gustavo Rocha on 02/01/20.
//  Copyright © 2020 Usemobile. All rights reserved.
//

import Foundation

public class Point {
    public var visited: Bool?
    public var address: Address?
    public var type: String?
    public var duration: String?
    
    public init(visited: Bool, address: Address, type: String, duration: String) {
        self.visited = visited
        self.address = address
        self.type = type
        self.duration = duration
    }
}

public class Address {
    public var city: String?
    public var neighborhood: String?
    public var state: String?
    public var zip: String?
    public var location: Location?
    public var address: String?
    public var number: String?

    
    public init(address: String,city: String , neighborhood: String , state: String,zip: String? ,number: String ,location: Location?) {
        self.location = location
        self.city = city
        self.address = address
        self.neighborhood = neighborhood
        self.state = state
        self.zip = zip
        self.number = number
    }
}

public class Location {
    public var latitude: Double
    public var longitude: Double
    
    public init(latitude: Double, longitude: Double){
        self.latitude = latitude
        self.longitude = longitude
    }
}
