//
//  Locations.swift
//  Faculty Locations
//
//  Created by Giyu Tomioka on 8/17/24.
//

import Foundation

struct AUPlace: Decodable {
    var facultyName: String
    var abbreviation: String
    var imageLogoName: String
    var locationLat: Double
    var locationLong: Double
    
    enum CodingKeys: String, CodingKey {
        case facultyName = "FacultyName"
        case abbreviation = "Abbreviation"
        case imageLogoName = "ImageLogoName"
        case locationLat = "LocationLat"
        case locationLong = "LocationLong"
    }
}

struct LocationsModal: Decodable {
    var Places: [AUPlace]
}
