//
//  Country.swift
//  Country
//
//  Created by Metehan Gürgentepe on 26.08.2024.
//

import Foundation

struct Country: Codable {
    var name: Name
//    var capital: [String]
    var area: Double
    var population: Int
}

struct Name: Codable {
    let common, official: String
}
